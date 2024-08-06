# Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache python3 py3-pip bash

# Add and install dependencies
COPY ./webapp/requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Add our code
COPY ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Run the app. CMD is required to run on Heroku
CMD gunicorn --bind 0.0.0.0:$PORT wsgi