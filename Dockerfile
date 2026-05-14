FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build

WORKDIR /src

COPY Rinha2026.slnx ./
COPY src/web/Rinha.Web/*.csproj src/web/Rinha.Web/

RUN dotnet restore src/web/Rinha.Web/Rinha.Web.csproj \
    -r linux-musl-x64

COPY src ./src

RUN dotnet publish src/web/Rinha.Web/Rinha.Web.csproj \
    -c Release \
    -o /app/publish \
    -r linux-musl-x64 \
    --no-self-contained \
    /p:PublishReadyToRun=true \
    /p:InvariantGlobalization=true \
    /p:DebugType=None \
    /p:DebugSymbols=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine

WORKDIR /app

ENV ASPNETCORE_URLS=http://0.0.0.0:8080 \
    DOTNET_TieredPGO=1 \
    DOTNET_TC_QuickJitForLoops=1 \
    DOTNET_SYSTEM_NET_SOCKETS_INLINE_COMPLETIONS=1

RUN adduser -D appuser

COPY --from=build --chown=appuser:appuser /app/publish .

USER appuser

EXPOSE 8080

ENTRYPOINT ["dotnet", "Rinha.Web.dll"]