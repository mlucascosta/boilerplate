FROM node:lts-gallium
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY . .
RUN yarn install
EXPOSE 3000
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1
CMD ["yarn", "start"]
