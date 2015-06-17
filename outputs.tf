output "nginx_id" {
    value = "${docker_image.nginx.latest}"
}

output "nginx_ip_address" {
    value = "${docker_container.nginx.ip_address}"
}

output "nginx_ip_prefix_length" {
    value = "${docker_container.nginx.ip_prefix_length}"
}

output "nginx_gateway" {
    value = "${docker_container.nginx.gateway}"
}

output "nginx_bridge" {
    value = "${docker_container.nginx.bridge}"
}
