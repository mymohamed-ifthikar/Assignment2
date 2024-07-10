# Assignment 2

Steps

  Fork and Clone the Repository
  Fork the Repository: Fork the repository sojoudian/clo835_s24 on GitHub.

# Clone Your Fork: Clone your forked repository locally.

  bash
  
  git clone https://github.com/sojoudian/clo835_s24.git
  cd clo835_s24
# Create a Dockerfile

  dockerfile
  
  #Use the official Python image from the Docker Hub
  FROM python:3.9-slim
  #Set the working directory in the container
  WORKDIR /app
  #Copy the Python script into the container
  COPY app.py .
  #Install the zoneinfo package for time zone support
  RUN pip install tzdata
  #Expose the port the app runs on
  
# Build and Push Docker Image:
  bash
  
  docker build -t project2-app .

Tag your Docker image (replace your-dockerhub-id with your Docker Hub ID):

  bash
  
  docker tag project2-app your-dockerhub-id/project-2-app:v1.0

Push your Docker image to Docker Hub:

  bash
  
  docker push your-dockerhub-id/project-2-app:v1.0

# Write Kubernetes Manifests

Create Kubernetes Deployment YAML (deployment.yaml):

  yaml
  
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: prj2-deployment
  spec:
    replicas: 1
    selector:
      matchLabels:
        app: prj2
    template:
      metadata:
        labels:
          app: prj2
      spec:
        containers:
          - name: prj2-container
            image: your-dockerhub-id/prj2-app:v1.0
            ports:
              - containerPort: 3030

# Create Kubernetes Service YAML (service.yaml):

  yaml
  
  apiVersion: v1
  kind: Service
  metadata:
    name: prj2-service
  spec:
    type: NodePort
    ports:
      - port: 3030
        targetPort: 3030
        nodePort: 32000
    selector:
      app: prj2

# Deploy to Kubernetes

  bash
  
  kubectl apply -f deployment.yaml
  kubectl apply -f service.yaml

# Testing
Access the application via NodePort (http://node-ip:32000).
Ensure the Application Works: The application should display the current time in Toronto, Canada.
