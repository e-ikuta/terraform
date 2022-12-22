variable "ROLLBAR_SAMPLE_PROJECT_READ_WRITE" {
  type = string
}

# Install Rollbar provider from Terraform Registry
terraform {
  required_providers {
    rollbar = {
      source  = "rollbar/rollbar"
    }
  }
}

# Configure the Rollbar provider
provider "rollbar" {
  project_api_key = var.ROLLBAR_SAMPLE_PROJECT_READ_WRITE # needed for notifications (read/write)
}

# Create a new Slack notification rule for the "New Item" trigger
resource "rollbar_notification" "slack" {
  channel = "slack"
  rule  {
    filters {
        type =  "environment"
        operation =  "eq"
        value = "production"
    }
    filters {
       type = "title"
       operation = "within"
       value = "送客された顧客の登録に失敗しました"
    }
    trigger = "occurrence"
  }
  config {
    show_message_buttons = true
    channel = "random"
  }
}
