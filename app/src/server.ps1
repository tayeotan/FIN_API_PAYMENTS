Add-Type -AssemblyName System.Net.HttpListener

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:8080/")
$listener.Start()

Write-Host "Payment API running on port 8080"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    if ($request.HttpMethod -eq "GET" -and $request.Url.AbsolutePath -eq "/health") {
        $response.StatusCode = 200
        $buffer = [Text.Encoding]::UTF8.GetBytes("OK")
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.Close()
        continue
    }

    if ($request.HttpMethod -eq "POST" -and $request.Url.AbsolutePath -eq "/pay") {
        $response.ContentType = "application/json"
        $reader = New-Object IO.StreamReader($request.InputStream)
        $body = $reader.ReadToEnd()
        $reader.Close()

    try {
        $payment = $body | ConvertFrom-Json
    } catch {
        $response.StatusCode = 400
        $buffer = [Text.Encoding]::UTF8.GetBytes('{"status":"error","message":"Invalid JSON"}')
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.Close()
        continue
    }


        if ($payment.amount -le 0) {
            $response.StatusCode = 400
            $output = @{ status = "error"; message = "Invalid amount" }
        } else {
            $response.StatusCode = 200
            $output = @{
                status = "approved"
                transactionId = [guid]::NewGuid().ToString()
            }
        }

        $json = $output | ConvertTo-Json
        $buffer = [Text.Encoding]::UTF8.GetBytes($json)
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
    }
    else {
        $response.StatusCode = 404
    }

    $response.Close()
}
