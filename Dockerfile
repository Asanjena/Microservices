

# decide which base image to use


# ensure to use official image
#FROM nginx


# label it - with your name
#LABEL MAINTAINER=ALEMA@SPARTA

# copy data index.html
#COPY index.html /usr/share/nginx/html/

# required port exposed 80
#EXPOSE 80

# launch the app/ server 
#CMD ["nginx", "-g", "daemon off;"]



# Official image
FROM node

# Label it with your name
LABEL MAINTAINER=ALEMA@SPARTA

# create and navigate to app folder
WORKDIR /usr/src/app

#Copy app folder to container app folder
COPY app /usr/src/app

# Expose port 3000 on container
EXPOSE 3000

# Launch the app/server
CMD ["node", "app.js"]
