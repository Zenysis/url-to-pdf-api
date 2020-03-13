FROM node:10-alpine

WORKDIR /app

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge=~73.0.3683.103 \
      nss@edge \
      freetype@edge \
      freetype-dev@edge \
      harfbuzz@edge \
      ttf-freefont@edge

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV BROWSER_EXECUTABLE_PATH=/usr/bin/chromium-browser

ENV NODE_ENV=production
ENV PORT=9000

COPY package.json package-lock.json ./

RUN npm install

COPY . .

EXPOSE 9000

CMD ["node", "src/index.js"]
