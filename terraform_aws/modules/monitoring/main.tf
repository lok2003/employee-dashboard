resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${var.eks_cluster}/cluster"
  retention_in_days = var.log_retention.days
  tags = {
    Name        = "${var.eks_cluster}-eks-logs"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

resource "aws_cloudwatch_dashboard" "eks" {
  dashboard_name = "eks-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Frontend CPU Utilization"
          region = "ap-south-1"
          view   = "timeSeries"
          stat   = "Average"
          period = 300

          metrics = [
            [
              "ContainerInsights",
              "container_cpu_utilization",
              "ClusterName",
              var.eks_cluster,
              "Namespace",
              "dashboard",
              "PodName",
              "employee-dashboard-deployment",
              "ContainerName",
              "employee-dashboard-container"
            ]
          ]
        }
      },

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "Backend CPU Utilization"
          region = "ap-south-1"
          view   = "timeSeries"
          stat   = "Average"
          period = 300

          metrics = [
            [
              "ContainerInsights",
              "container_cpu_utilization",
              "ClusterName",
              var.eks_cluster,
              "Namespace",
              "dashboard",
              "PodName",
              "employee-dashboard-backend",
              "ContainerName",
              "backend-deployment"
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "Frontend Memory Utilization"
          region = "ap-south-1"
          view   = "timeSeries"
          stat   = "Average"
          period = 300
          metrics = [
            [
              "ContainerInsights",
              "container_memory_utilization",
              "ClusterName",
              var.eks_cluster,
              "Namespace",
              "dashboard",
              "PodName",
              "employee-dashboard-deployment",
              "ContainerName",
              "employee-dashboard-container"
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "Backend Memory Utilization"
          region = "ap-south-1"
          view   = "timeSeries"
          stat   = "Average"
          period = 300

          metrics = [
            [
              "ContainerInsights",
              "container_memory_utilization",
              "ClusterName",
              var.eks_cluster,
              "Namespace",
              "dashboard",
              "PodName",
              "employee-dashboard-bakend",
              "ContainerName",
              "backend-deployment"
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 24
        height = 6
        properties = {
          title  = "Employee Dashboard Pod Restarts"
          region = "ap-south-1"
          view   = "timeSeries"
          stat   = "Sum"
          period = 300
          metrics = [
            [
              "ContainerInsights",
              "pod_number_of_container_restarts",
              "ClusterName",
              var.eks_cluster,
              "Namespace",
              "dashboard",
              "PodName",
              "employee-dashboard-deployment"
              ], [
              ".",
              ".",
              ".",
              ".",
              ".",
              ".",
              "PodName",
              "employee-dashboard-backend"
            ]
          ]
        }
      }
    ]
  })
}
