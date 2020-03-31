FROM node:12.14.1
RUN useradd meteoruser
RUN mkdir /home/meteoruser
RUN chown meteoruser /home/meteoruser
USER root
WORKDIR /app/src
COPY . /app/src
RUN chown -R meteoruser /app/*
USER meteoruser
RUN curl "https://install.meteor.com/" | sh
USER root
RUN cp "/home/meteoruser/.meteor/packages/meteor-tool/1.10.1/mt-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor
USER meteoruser
RUN meteor npm install -g yarn
RUN meteor yarn 
CMD meteor --settings settings.json
EXPOSE 3000