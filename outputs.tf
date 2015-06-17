output "mongodb_image_id" {
    value = "${docker_image.mongodb.latest}"
}

output "mongodb_ip_address" {
    value = "${docker_container.mongodb.ip_address}"
}

output "mongodb_ip_prefix_length" {
    value = "${docker_container.mongodb.ip_prefix_length}"
}

output "mongodb_gateway" {
    value = "${docker_container.mongodb.gateway}"
}

output "mongodb_bridge" {
    value = "${docker_container.mongodb.bridge}"
}
