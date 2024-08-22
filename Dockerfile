#build stage
FROM golang:1.22.2 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/main.go

# Stage 2: Create a smaller image with just the binary and required files
FROM alpine:latest

# Metadata
LABEL maintainer="kherld.hussein@gmail.com" \
      maintainer="datieno001@gmail.com" \
      maintainer="tomabila3@gmail.com" \
      version="1.0.0" \
      description="This is a program that generates ASCII art based on a given string and banner style specified. The program uses a web interface that is appealing, intuitive and user friendly to displays the results.The application container built with Docker."

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Copy the Public directory from the builder stage
COPY --from=builder /app/public /root/public

# Copy the template directory from the builder stage
COPY --from=builder /app/templates /root/templates

# Expose port 8080 to the outside world
EXPOSE 8080

# Run the executable
CMD ["./main"]
