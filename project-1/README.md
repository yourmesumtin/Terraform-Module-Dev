Kubernetes Deployment using Rancher k3s
and Deploying NGINX on node


here is the nginx.yaml or you can name it deployment.yaml

vim deployment.yaml 

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21.1
        ports:
        - containerPort: 80
          hostPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer




to see your output in json format 
terraform output -json | jq

NB: You have to install jq


USER DATA

#!/bin/bash
sudo hostnamectl set-hostname ${nodename} &&
curl -sfL https://get.k3s.io | sh -s - server \
--datastore-endpoint="mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}" \
--write-kubeconfig-mode 644 \
--tls-san=$(curl http://169.254.169.254/latest/meta-data/public-ipv4) \
--token="th1s1sat0k3n!"   


NB:
--tls-san=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)  # This command in the user data is adding the public ip to the certificate within our k3s installation so that we can accesss the kubernetes resources on its public ip addresses instead of its internal ip addresses.