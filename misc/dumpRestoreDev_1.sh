#!/bin/bash

#TODO option to load latest dump for a given host
#TODO option to update configs
#TODO option to not generate schemaspy

if [[ $EUID -ne 0 ]]; then echo "You must be a root user"; exit; fi

user=""
pwd=""
db=""
host=""

mysql_root="mysql -u ${user} -p${pwd} ${db}"
mysql_palmcs="mysql -u ${user} -p${pwd} ${db}"


db_dir="${HOME}/palm/db"
dbdump_dir="${db_dir}/dbdump"
mkdir -p ${dbdump_dir}
dbdump_file="${dbdump_dir}/${host}.dump.`date +'%Y%m%d-%H%M'`.sql.gz"

function dodump() {

  echo
  date
  echo "Deleting older files"
  find ${dbdump_dir} -ctime +4 -exec rm -iv {} \;

  file="/tmp/common_config.txt"

  if [[ $1 == '' ]]; then
    echo
    date
    echo "Dumping from ${host} and writing to ${dbdump_file}"
    mysqldump -h${host} -u readonly -p --add-drop-database --add-drop-table --force --disable-keys \
      --triggers --routines --opt --skip-lock-tables --compress --comments \
      --dump-date --complete-insert --databases palmcs | gzip > ${dbdump_file}
  else
    dbdump_file=$1
  fi

  echo
  date
  echo "Done dumping to ${dbdump_file}"
}

function load_dumpfile() {

  echo
  date
  echo "Loading into local mysql: ${dbdump_file}"
  gunzip < ${dbdump_file} | ${mysql_root}

  echo
  date
  echo "Done loading ${dbdump_file}"
}

function generate_schemaspy() {

  local schema_dir="${db_dir}/schema"
  mkdir -p ${schema_dir}

  local temp_schema="${schema_dir}/localhost_${db}_temp"
  local final_schema="${schema_dir}/localhost_${db}"

  echo
  date
  # INSTALLATION ON LINUX
  dpkg-query -l graphviz > /dev/null
  if [[ $? == 1 ]]; then
    echo "Enter sudo password"
    sudo apt-get install -y graphviz
  else
    echo 'graphviz found...';
  fi

  # perhaps go the maven way
  ls ${HOME}/applications/schemaSpy_5.0.0.jar > /dev/null 2> /dev/null
  if [[ $? == 0 ]]; then
    echo 'schemaspy found...'
  else
    mkdir -p ${HOME}/applications
    pushd ${HOME}/applications
    wget http://downloads.sourceforge.net/project/schemaspy/schemaspy/SchemaSpy%205.0.0/schemaSpy_5.0.0.jar
    popd
  fi

  ## Schema spy invocation
  echo
  echo "Generating schemaspy..."
  invocation="java -jar ${HOME}/applications/schemaSpy_5.0.0.jar \
    -dp ${HOME}/.m2/repository/mysql/mysql-connector-java/5.1.13/mysql-connector-java-5.1.13.jar \
    -t mysql -host localhost  -port 3306 -db ${db} -u ${user} -p ${pwd} -o ${temp_schema}"
  echo "Invocation: ${invocation}"
  `${invocation}`

  rm -rf ${final_schema}

  mv ${temp_schema} ${final_schema}

  echo "$(date)" > ${final_schema}/date.txt

  echo
  date
  echo "Done. Open: ${final_schema}/index.html"
}

dodump
generate_schemaspy
load_dumpfile

echo
date
echo "Done!"
