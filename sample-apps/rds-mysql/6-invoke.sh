#!/bin/bash
set -eo pipefail
FUNCTION=$(aws cloudformation describe-stack-resource --stack-name rds-mysql --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
PAYLOAD=$(cat ./events/db-read-table.json | base64)
while true; do
  aws lambda invoke --function-name $FUNCTION --payload $PAYLOAD out.json
  cat out.json
  echo ""
  sleep 2
done
