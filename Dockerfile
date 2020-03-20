FROM node:latest AS development

RUN mkdir /srv/chat && chown node:node /srv/chat

USER node

WORKDIR /srv/chat

COPY --chown=node:node package.json package-lock.json ./

RUN npm install 

# TODO: Can remove once we have some dependencies in package.json.
# RUN mkdir -p node_modules

FROM node:slim AS production

USER node

WORKDIR /srv/chat

COPY --from=development --chown=root:root /srv/chat/node_modules ./node_modules

COPY . .

CMD ["node", "index.js"]