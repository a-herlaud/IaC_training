output "public_ip" {
    description = "The public IP address of the web server"
    value = aws_instance.example.public_ip
}