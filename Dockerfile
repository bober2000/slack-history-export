FROM node:8-alpine

ARG SLACK_TOKEN
ENV SLACK_TOKEN ${SLACK_TOKEN}
ARG CHANNEL_NAME
ENV CHANNEL_NAME ${CHANNEL_NAME}
ARG FILE_NAME
ENV FILE_NAME ${FILE_NAME}

RUN mkdir -p /app

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

CMD [ "node", "bin/slack-history-export.js", "-t ${SLACK_TOKEN}", "-c ${CHANNEL_NAME}", "-f ${FILE_NAME}"]
