FROM oven/bun:latest AS fe-builder

WORKDIR /app

ENV ESBUILD_BINARY_PATH=/usr/bin/node

COPY client/package.json .

RUN bun install

COPY client/. .

RUN bun run build

FROM golang:1.25.3-alpine3.22 AS be-builder

WORKDIR /app

COPY server/go.mod .
COPY server/go.sum .

RUN go mod tidy

COPY server/. .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -mod=mod -o react-go .

FROM alpine:3.20

WORKDIR /app

RUN apk add --no-cache curl

COPY --from=fe-builder /app/dist/. ./public
COPY --from=be-builder /app/. .

CMD [ "./react-go" ]