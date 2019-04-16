#Build phase
FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

#Run phase with Nginx the FROM signifies a new phase
FROM nginx
## copies over from the builder phase static-directory to nginx location which is /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

#by default nginx starts up by default when the container starts up
