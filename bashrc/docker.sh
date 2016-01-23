# Quickstart Containers - https://docs.docker.com/engine/userguide/basics/
# Best Practices - http://crosbymichael.com/dockerfile-best-practices.html
# Reference - http://docs.docker.com/engine/reference/builder/

### Vagrant
#VBoxManage
#VBoxManage list runningvms
#VBoxManage controlvm
# https://github.com/warren5236/WordpressWithVagrant/blob/UsingBootstrap.sh/Vagrantfile
# http://stackoverflow.com/questions/15408969/how-do-i-destroy-a-vm-when-i-deleted-the-vagrant-file

### Docker
# Debugging - http://pothibo.com/2015/7/how-to-debug-a-docker-container
    # Run an intermediate container
        # docker run --rm -it 9c9e81692ae9 /bin/bash
    # Attaching to a running container
        # docker run --name instance.project.com project.com
        # docker exec -it instance.project.com /bin/bash
# Run multiple commands - http://stackoverflow.com/a/23968289/1216965
# Centos/Debian/Ubuntu - Docker / Ansible - williamyeh/ansible
# Centos SSH - jdeathe/centos-ssh

function docker_start {
    bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
}

function dockerip {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

function dockerui {
  docker run --name="dockerui" -d -p 9000:9000 -v /var/run/docker.sock:/docker.sock crosbymichael/dockerui -e /docker.sock
}

function docker_list {
  docker ps -l -q
}

# http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
function rm_containers_stopped {
  # Delete only the containers that are not running. Parse the "ps" output for the "Exited" string:
  # docker ps -a | awk '/Exited/ {print $1}' | xargs docker rm -v

  docker rm $(docker ps -a -q) 
}

# http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
function rm_images_untagged {
  #old - docker rmi $(docker images -a | grep "^<none>" | awk "{print $3}")
  docker rmi $(docker images --quiet --filter "dangling=true")
}

function kill_containers_running {
  ## http://stackoverflow.com/a/23206588/1216965
  docker ps -q | xargs docker kill
}

function stop_containers_running {
  docker stop `docker ps -q`
}

function rm_all_images {
  #Removing Images 
  docker rmi -f $(docker images | \grep ^\<none | awk '{print $3}')  
}

function docker_kamon {
    docker run -d -p 80:80 -p 81:81 -p 8125:8125/udp -p 8126:8126 --name kamon-grafana-dashboard kamon/grafana_graphite
}

