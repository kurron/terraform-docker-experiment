provider "docker" {
   host = "tcp://localhost:2375/"
}

resource "docker_image" "busybox" {
#  image = "nginx:latest"
   name = "busybox:latest"
   keep_updated = true
}

resource "docker_container" "mongodb-data" {
   image = "${docker_image.busybox.latest}"
   name = "mongodb-data"
   hostname = "mongodb-data"
   must_run = false
   volumes {
       container_path = "/data/db" 
   }
}

resource "docker_image" "mongodb" {
#  image = "nginx:latest"
   name = "mongo:latest"
   keep_updated = true
}

resource "docker_container" "mongodb" {
   image = "${docker_image.mongodb.latest}"
   name = "mongodb"
   hostname = "mongodb"
   must_run = true
   command = ["--storageEngine=wiredTiger", "--notablescan", "--journalCommitInterval=300"]
   volumes {
       from_container = "mongodb-data"
   }
   ports {
       internal = 27017  
       external = 27017  
   }
}
