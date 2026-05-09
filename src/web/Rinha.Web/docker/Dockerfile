FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build

WORKDIR /src

RUN apk add --no-cache \
    clang \
    build-base \
    zlib-dev

COPY src/web/Rinha.Web/*.csproj src/web/Rinha.Web/
COPY src/domain/Rinha.Core/*.csproj src/domain/Rinha.Core/

RUN dotnet restore src/web/Rinha.Web/Rinha.Web.csproj \
    -r linux-musl-x64

COPY src ./src

RUN dotnet publish src/web/Rinha.Web/Rinha.Web.csproj \
    -c Release \
    -o /app/publish \
    -r linux-musl-x64 \
    --self-contained true \
    /p:PublishTrimmed=true \
    /p:PublishAot=true \
    /p:StripSymbols=true \
    /p:InvariantGlobalization=true \
    /p:UseAppHost=true

FROM alpine:3.22

WORKDIR /app

RUN apk add --no-cache \
    libgcc \
    libstdc++

ENV ASPNETCORE_URLS=http://0.0.0.0:8080

COPY --from=build /app/publish .

RUN adduser -D appuser
USER appuser

EXPOSE 8080

ENTRYPOINT ["./Rinha.Web"]