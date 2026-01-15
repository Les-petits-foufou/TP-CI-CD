# ==========================================
# Stage 1: Dependencies
# ==========================================
FROM node:20-slim AS deps
WORKDIR /app
COPY app/package.json app/package-lock.json ./
RUN npm ci

# ==========================================
# Stage 2: Build
# ==========================================
FROM node:20-slim AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY app/ .
RUN npx prisma generate
RUN npm run build

# ==========================================
# Stage 3: Runner (Production)
# ==========================================
FROM node:20-slim AS runner
WORKDIR /app

# On garde le fix OpenSSL (TRES IMPORTANT)
RUN apt-get update -y && apt-get install -y openssl ca-certificates

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

# CORRECTION DU CHEMIN ICI : on ajoute /api/
CMD ["node", "dist/api/main.js"]
