# AWS Lambda HTTP Server with Go and Terraform

## Overview
This project demonstrates how to deploy a simple Go-based AWS Lambda function that acts as an HTTP server using API Gateway. Terraform is used to provision the necessary AWS resources.

## Architecture
- **AWS Lambda**: Executes the Go application on demand.
- **API Gateway**: Routes HTTP requests (`GET` and `POST`) to the Lambda function.
- **IAM Role**: Grants the necessary permissions to Lambda.
- **Terraform**: Manages infrastructure as code (IaC).

## Features
- Supports HTTP `GET` and `POST` requests.
- Handles JSON payloads for `POST` requests.
- Uses AWS API Gateway to expose the Lambda as a REST API.

## Setup Instructions
### Prerequisites
Ensure you have the following installed:
- [Go](https://golang.org/doc/install)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://aws.amazon.com/cli/)
- An AWS account with necessary IAM permissions

### Steps to Deploy
1. **Clone the repository**
   ```sh
   git clone <repo-url>
   cd <repo-folder>
   ```

2. **Build and package the Go Lambda function**
   ```sh
   GOOS=linux GOARCH=amd64 go build -o main main.go
   zip lambda.zip main
   ```

3. **Initialize and apply Terraform**
   ```sh
   terraform init
   terraform apply -auto-approve
   ```

4. **Obtain the API Gateway endpoint**
   After deployment, Terraform will output the API Gateway URL. Use it to send requests.

5. **Test the API**
   - **GET Request:**
     ```sh
     curl -X GET https://your-api-gateway-url/prod/
     ```
   - **POST Request:**
     ```sh
     curl -X POST https://your-api-gateway-url/prod/ -d '{"message": "Hello"}' -H "Content-Type: application/json"
     ```

## Caveats and Considerations
### Cold Start Latency
Since AWS Lambda is a serverless function, there may be a cold start delay if the function has not been invoked for a while.

### Stateless Execution
Each Lambda invocation is stateless, meaning it does not retain memory or session data between requests.

### Request Limits
API Gateway has a 30-second timeout, and Lambda has memory and execution time limits (default 15 minutes max).

### Binary Handling
Ensure the Go binary is built for **Linux (amd64)** architecture since AWS Lambda runs on a Linux environment.

## Cleanup
To remove all deployed resources, run:
```sh
terraform destroy -auto-approve
```

## Conclusion
This setup provides a scalable, cost-efficient HTTP server using AWS Lambda and API Gateway. It's ideal for lightweight API use cases without managing a dedicated server.

Let me know if you have any questions or need improvements! 🚀

