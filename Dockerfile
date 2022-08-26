FROM golang:1.19-bullseye AS build
WORKDIR /opt
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
ENV CGO_ENABLED 0
RUN go build -o app

FROM gcr.io/distroless/base-debian11
COPY --from=build /opt/app /
CMD ["/app"]