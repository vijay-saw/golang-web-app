
FROM golang:1.23.2 AS base

WORKDIR /app

COPY go.mod . 

RUN go mod download 

COPY . .

RUN go build -o main .

#we are using distroless image for container size
FROM gcr.io/distroless/base


COPY --from=base /app/main . 

COPY --from=base /app/static ./static

EXPOSE 8000

CMD ["./main"]
