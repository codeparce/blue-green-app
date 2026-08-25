FROM node:20-alpine

WORKDIR /app
COPY package.json ./
RUN corepack enable && pnpm install --prod
COPY src ./src

COPY .env.example .env

ENV NODE_ENV=production
EXPOSE 3000
CMD ["pnpm", "start"]
