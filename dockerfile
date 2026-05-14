# Stage 1: Build & Dependency Installation
FROM node:20-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Stage 2: Clean, Secure Runtime execution
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Security hardening: Create non-root user accounts
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 bookstore_user

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./

RUN chown -R bookstore_user:nodejs /app
USER bookstore_user

EXPOSE 3000
CMD ["npm", "start"]
