output "django_app_public_ip" {
  value = aws_instance.django_app.public_ip
}
