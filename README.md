# Deploy SpringBoot and ReactJs frontend to ec2 using terraform

Code reference is taken from https://github.com/kantega/react-and-spring.git

##### AIM:

Build the code and deploy jar file to ec2 using terraform

##### Used tools:

Jenkins

Terraform

maven

### Manual Install steps

1. Clone the code https://github.com/kantega/react-and-spring.git

    `git clone https://github.com/kantega/react-and-spring.git`

2. Build the code 

    `mvn clean install`

3. Copy the jar file to the packages folder

4. Create an instance 

    `terraform plan`

    `terraform apply -auto-approve`

5. To destroy 

    `terraform destroy -auto-approve`


Notice : we ignored the pem file 