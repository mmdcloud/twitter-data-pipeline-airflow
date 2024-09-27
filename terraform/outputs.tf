output "airflow_instnace_ip" {
  value = aws_instance.airflow_instance.public_ip
}
