resource "docker_image" "dockerImage" {
  name= "nginx:latest"
}
resource "docker_container" "dockerContainer" {
  image = docker_image.dockerImage.image_id
  name = "nginxWebServer"
  ports {
    internal = 80
    external = 8000
  }
}