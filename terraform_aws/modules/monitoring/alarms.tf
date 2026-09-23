resource "aws_cloudwatch_metric_alarm" "frontend_cpu_high" {
  alarm_name          = "${var.eks_cluster}-frontend-cpu-high"
  alarm_description   = "Frontend container CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
  threshold           = 80

  namespace   = "ContainerInstance"
  metric_name = "container_cpu_utilization"
  dimensions = {
    ClusterName   = var.eks_cluster
    Namespace     = "dashboard"
    PodName       = "employee-dashboard-deployment"
    ContainerName = "employee-dashboard-container"
  }
  treat_missing_data = "notBreaching"
  alarm_actions      = [aws_sns_topic.monitoring.arn]
}


resource "aws_cloudwatch_metric_alarm" "backend_cpu_high" {
  alarm_name          = "${var.eks_cluster}-backend-cpu-high"
  alarm_description   = "Backend container CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
  threshold           = 80
  namespace           = "ContainerInsights"
  metric_name         = "container_cpu_utilization"
  dimensions = {
    ClusterName   = var.eks_cluster
    Namespace     = "dashboard"
    PodName       = "employee-dashboard-backend"
    ContainerName = "backend-deployment"
  }
  treat_missing_data = "notBreaching"
  alarm_actions      = [aws_sns_topic.monitoring.arn]
}


resource "aws_cloudwatch_metric_alarm" "frontend_memory_high" {
  alarm_name          = "${var.eks_cluster}-frontend-memory-high"
  alarm_description   = "Frontend container memory utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
  threshold           = 80

  namespace   = "ContainerInsights"
  metric_name = "container_memory_utilization"
  dimensions = {
    ClusterName   = var.eks_cluster
    Namespace     = "dashboard"
    PodName       = "employee-dashboard-deployment"
    ContainerName = "employee-dashboard-container"
  }
  treat_missing_data = "notBreaching"
  alarm_actions      = [aws_sns_topic.monitoring.arn]
}

resource "aws_cloudwatch_metric_alarm" "backend_memory_high" {
  alarm_name          = "${var.eks_cluster}-backend-memory-high"
  alarm_description   = "Frontend container memory utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
  threshold           = 80

  namespace   = "ContainerInsights"
  metric_name = "container_memory_utilization"
  dimensions = {
    ClusterName   = var.eks_cluster
    Namespace     = "dashboard"
    PodName       = "employee-dashboard-backend"
    ContainerName = "backend-deployment"
  }
  treat_missing_data = "notBreaching"
  alarm_actions      = [aws_sns_topic.monitoring.arn]
}

