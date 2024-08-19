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

LABEL key="value"
# maintainer / version / description 

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

# Command to run the executable
CMD ["./main"]
