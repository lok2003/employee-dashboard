resource "aws_sns_topic" "monitoring" {
  name = "${var.eks_cluster}-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "monitoring_email" {
  topic_arn = aws_sns_topic.monitoring.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

