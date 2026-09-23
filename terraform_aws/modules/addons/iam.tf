resource "aws_iam_role" "ebs_csi_role" {
  name = "eks-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "cloudwatch_role" {
  name = "eks-cloudwatch-observability-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ebs_csi_policy" {
  role = aws_iam_role.ebs_csi_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_pod_identity_association" "ebs_csi" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi_role.arn

  depends_on = [
    aws_eks_addon.pod_identity_agent
  ]
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# resource "aws_iam_role_policy_attachment" "cloudwatch_xray_policy" {
#   role       = aws_iam_role.cloudwatch_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSxrayWriteOnlyAccess"
# }
resource "aws_eks_pod_identity_association" "cloudwatch" {
  cluster_name    = var.cluster_name
  namespace       = "amazon-cloudwatch"
  service_account = "cloudwatch-agent"

  role_arn = aws_iam_role.cloudwatch_role.arn

  depends_on = [
    aws_eks_addon.pod_identity_agent
  ]
}