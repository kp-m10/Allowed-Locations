# Allowed-Locations

1) terraform init

2) terraform plan -var 'location=["westus2","westus"]' -var 'subscription=["your_subscription_id"]'

3) terraform apply -auto-approve -var 'location=["westus2","westus"]' -var 'subscription=["your_subscription_id"]'
