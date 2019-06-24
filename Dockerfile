FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100-preview6-alpine3.9 AS build

WORKDIR /app

COPY . .

RUN dotnet publish -r linux-musl-x64 -c Release -o ./deploy

FROM alpine:latest

COPY --from=build /app/deploy ./app

RUN apk update && apk add libstdc++ && apk add libintl

ENV ASPNETCORE_URLS http://*:5000

EXPOSE 5000

ENTRYPOINT ["./app/DotNet3.Executable.Api"]

# docker build -t echoapi:local . (91 MB file size)
# docker run -p 5000:5000 -t echoapi:local (0.08% CPU - 30 MB RAM)
