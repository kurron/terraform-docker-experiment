provider "docker" {
   host = "tcp://localhost:2375/"
}

resource "docker_image" "nginx" {
#  image = "nginx:latest"
   name = "nginx:latest"
   keep_updated = true
}

resource "docker_container" "nginx" {
   image = "${docker_image.nginx.latest}"
   name = "nginx"
   hostname = "nginx"
   must_run = true
   ports {
       internal = 80
       external = 80
   }
}

