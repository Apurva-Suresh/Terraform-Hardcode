output "vpc_id" {
  value = "aws_vpc.twot_vpc.id"
}

output "pubsub1" {
  value = "aws_subnet.pubsub_1.id"
}

output "pubsub2_cidr" {
  value = "aws_subnet.pubsub2_cidr.id"
}