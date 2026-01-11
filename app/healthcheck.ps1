try {
    Invoke-WebRequest -Uri http://localhost:8080/health -Method GET -TimeoutSec 2 | Out-Null
    exit 0
} catch {
    exit 1
}
