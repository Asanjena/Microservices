# Docker
 
This will go through how you can make images on Docker and use these to run containers for Nginx and the Nodejs web app. 


# Hosting a static website with Nginx web-server

1. Use the **docker run** command to run the official NGinx image. When you use this command, it will kick in an API and check if there is an image locally. If not, then it will go to docker hub and pull it down from there.

2. To set up the nginx web-server, use command:

Docker run -d -p 80:80 nginx

(if you don't have it locally, it will pull from docker hub)

3. In web browser, type 'localhost', and you will be able to see the nginx welcome page.


## Interacting with running container**
1. To log into the running container, and cofigure nginx, run the command:

```
docker exec -it <container id> sh
```

2. If you get a windown related error, try: 

```
alias docker = 'winpty docker", and run the command from 1. again
```

3. Once inside, use the following commands so that we can edit index.html:

```
apt update -y
apt upgrade -y
apt install sudo -y
sudo apt install nano -y

cd /user/share/nginx/html
```

5. Then run 'exit'

## Hosting own profile website on nginx server

1. On vscode, create an index.html and add in your profile contents

2. Due to issues with git bash, I opened up command promt. cd into the right directory (where the index.html is), and then copy the profile (index.html) to /usr/share/nginx/html

```
docker cp index.html 907263cab327:/usr/share/nginx/html/
```

**note**: 907263cab327 is the container name


## Images and using Dockerfile

1. We can make a Dockerfile that has commands to execute when making an image:

```
sudo nano Dockerfile
```
2. Add the following to the Dockerfile:
```
# Use official Nginx image as base image
FROM nginx

# Label it with your name
LABEL MAINTAINER=ALEMA@SPARTA

# Copy index.html to container Nginx html folder
COPY index.html /usr/share/nginx/html/

# Expose Port 80 on container
EXPOSE 80

# Launch the app/server
CMD ["nginx", "-g", "daemon off;"]
```

## Configuring Dockerfile to build and image and run Nodejs:

1. In the Dockerfile, use the following:
```
# Use official Node image as base image
FROM node

# Label it with your name
LABEL MAINTAINER=ALEMA@SPARTA

# Create and navigate to app folder
WORKDIR /usr/src/app

# Copy app folder contents to container app folder
COPY app /usr/src/app

# Expose Port 3000 on container
EXPOSE 3000

# Launch the app/server
CMD ["node", "app.js"]
```
2. Build the image using the command:
```
docker build -t asanjena/alema_docker_app .
```

3. Push it using:
```
docker push asanjena/alema_docker_app

```

4. Run it using:
```
docker run -d -p 3000:3000 asanjena/alema_docker_app
```
![Alt text](Images/docker-hub.PNG)


5. You should then be able to access 'localhost:3000' and 'localhost:3000/fibonacci/10' in a web browser

![Alt text](Images/sparta-app.PNG)

![Alt text](Images/fibonacci.PNG)




















