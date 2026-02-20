# Stage 1: Build
FROM golang:1.19 AS build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

# Stage 2: Minimal image
FROM alpine:3.18
WORKDIR /app
COPY --from=build /app/server .
CMD ["./server"]