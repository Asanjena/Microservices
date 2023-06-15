

![Alt text](<Images/Cluster diagram.png>)



## Deploying nginx using K8


1. First we will create a nginx-deploy.yml file to deploy nginx

```
apiVersion: apps/v1
kind: Deployment #pod - service what kind of service/object
#what would you like to call it - name the service 
metadata:
  name: nginx-deployment # naming the deployment
spec:
  selector:
    matchLabels:
      app: nginx # look for this label to match with k8 service
    # lets create a replica set of this with instances/pods
  replicas: 3 # 3 pods
    # template to use it's label for K8 service to launch in
  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx
        image: asanjena/alema-profile:latest
        ports:
        - containerPort: 80

```


2. Next, we need to create a K8 Service. To do this, make a nginx-service.yml file and enter:

```
---
# Selecet the type of API version and type of service/object
apiVersion: v1
kind: Service
# Metadata for name
metadata:
  name: nginx-svc
  namespace: default # src

spec:
  ports:
  - nodePort: 30001
    port: 80

    targetPort: 80

  # Define the selector and label to connect to nginx

  selector:
    app: nginx

  type: NodePort
  ```

  3. Now run these using the command:

  ```
  kubectl create -f nginx-deploy.yml
  kubectl nginx-service.yml
  ```

  4. Now if you use 'http://localhost:30001' in a web browser, you can see the image being displayed (in this case my profile)






  ## Deploying node using K8s


  1. Create a node-deployment.yml file to deploy the app. In the file, put:

```
  
apiVersion: apps/v1 # which api to use for deployment
kind: Deployment # what kind of service/object you want to create

# what would you like to call it - name the service/object
metadata:
  name: node-deployment # naming the deployment - Good idea to name it same as the filename

# create a kubernetes nginx-service.yml to create a k8 service
spec:
  selector:
    matchLabels:
      app: node-app # look for this label to match with k8 service

  # Let's create a replica set of this with instances/pods
  replicas: 3

  # Template to use it's label for k8 service to launch in the browser
  template:
    metadata:
      labels:
        app: node-app # This label connects to the service or any other k8s components

  # Let's define the container spec
    spec:
      containers:
      - name: node-app
        image: asanjena/alema_docker_app:latest
        ports:
        - containerPort: 3000

```

2. Next, create a K8 service and make a node-service.yml file:

```
---
# Select the type of API version and type of service/object
apiVersion: v1
kind: Service

# Metadata for name
metadata:
  name: node-svc
  namespace: default # sre

#Specification to include ports Selector to connect to the deployment
spec:
  ports:
  - nodePort: 30001
    port: 80
    targetPort: 3000

# Let's define the selector and label to connect to nginx depoyment
  selector:
    app: node-app # this label connects this service to deployment

# Creating NodePort type of deployment
  type: NodePort

```
3. Now if you go to a web browser and type 'http://localhost:3000', you should be able to see the app page. 




## Scaling

For this, use the command