provider "docker" {
   host = "tcp://localhost:2375/"
}

resource "docker_image" "busybox" {
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

resource "docker_container" "mysql-data" {
   image = "${docker_image.busybox.latest}"
   name = "mysql-data"
   hostname = "mysql-data"
   must_run = false
   volumes {
       container_path = "/var/lib/mysql"
   }
   volumes {
       container_path = "/etc/mysql/conf.d"
   }
}

resource "docker_image" "mysql" {
   name = "mysql:latest"
   keep_updated = true
}

resource "docker_container" "mysql" {
   image = "${docker_image.mysql.latest}"
   name = "mysql"
   hostname = "mysql"
   must_run = true
   volumes {
       from_container = "mysql-data"
   }
   ports {
       internal = 3306
       external = 3306
   }
   env = ["MYSQL_ROOT_PASSWORD=sa", "MYSQL_USER=mysql", "MYSQL_PASSWORD=mysql", "MYSQL_DATABASE=sushe"]
}

