# loop through the list of webhook_types and create an sns topic for each

resource "aws_sns_topic" "topic" {
  kms_master_key_id             = "alias/aws/sns"
  name                          = "${var.prefix}-${var.name}"
  tags                          = local.tags
  sqs_failure_feedback_role_arn = ""
  delivery_policy               = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}
