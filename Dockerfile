FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100-preview6-alpine3.9 AS build

WORKDIR /app

COPY . .

RUN dotnet publish -r linux-musl-x64 -c Release -o ./deploy

FROM alpine:latest

COPY --from=build /app/deploy .

RUN apk update && apk add libstdc++ && apk add libintl

ENV ASPNETCORE_URLS http://*:5000

ENTRYPOINT ["./DotNet3.Executable.Api"]

EXPOSE 5000

# docker build -t echoapi:local . (64.8 MB file size)
# docker run -p 5000:5000 -t echoapi:local (0.12% CPU - 35 MB RAM)
