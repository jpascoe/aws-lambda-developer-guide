#!/bin/bash
set -eo pipefail
FUNCTION=$(aws cloudformation describe-stack-resource --stack-name rds-mysql --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
PAYLOAD=$(cat ./events/db-create-table.json | base64)
aws lambda invoke --function-name $FUNCTION --payload $PAYLOAD out.json
