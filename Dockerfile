FROM golang:1.20
WORKDIR /opt
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
ENV CGO_ENABLED 0
RUN go build -o app

FROM gcr.io/distroless/static-debian11
COPY --from=0 /opt/app /
CMD ["/app"]
