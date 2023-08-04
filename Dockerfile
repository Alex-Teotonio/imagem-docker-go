FROM golang:alpine AS builder
WORKDIR /go/src/app
ADD . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags='-w -s' -installsuffix cgo -o app .

FROM scratch
COPY --from=builder /go/src/app/app /app
ENTRYPOINT ["/app"]

