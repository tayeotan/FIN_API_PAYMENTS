FROM mcr.microsoft.com/powershell:lts-alpine

WORKDIR /app

COPY src/server.ps1 .
COPY healthcheck.ps1 .

EXPOSE 8080

HEALTHCHECK CMD pwsh ./healthcheck.ps1

CMD ["pwsh", "./server.ps1"]