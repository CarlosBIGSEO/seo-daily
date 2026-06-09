<#
  SEO Daily - generador diario
  Lanza Claude Code en modo headless para regenerar el informe SEO del dia.
  Lo ejecuta la Tarea Programada de Windows "SEO Daily News".
#>

$ErrorActionPreference = 'Stop'
$proj   = 'C:\Users\carlo\Downloads\seo-news-daily'
$gen    = Join-Path $proj '_generator'
$logDir = Join-Path $gen 'logs'
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Force $logDir | Out-Null }

$now      = Get-Date
$dias     = @('domingo','lunes','martes','miércoles','jueves','viernes','sábado')
$meses    = @('enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre')
$todayIso = $now.ToString('yyyy-MM-dd')
$todayLong= "$($dias[[int]$now.DayOfWeek]), $($now.Day) de $($meses[$now.Month-1]) de $($now.Year)"
$genTime  = $now.ToString('HH:mm')
$log      = Join-Path $logDir "run-$todayIso.log"

function Log($m){ $line = "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m; Add-Content -Path $log -Value $line -Encoding utf8; Write-Output $line }

Log "=== SEO Daily :: inicio ($todayLong) ==="

# 1) Resolver la ultima version instalada del CLI de Claude Code
$cliBase = Join-Path $env:APPDATA 'Claude\claude-code'
$exe = $null
if (Test-Path $cliBase) {
  $latest = Get-ChildItem $cliBase -Directory -ErrorAction SilentlyContinue |
            Sort-Object { try { [version]$_.Name } catch { [version]'0.0.0' } } | Select-Object -Last 1
  if ($latest) { $cand = Join-Path $latest.FullName 'claude.exe'; if (Test-Path $cand) { $exe = $cand } }
}
if (-not $exe) { Log "ERROR: no se encontro claude.exe en $cliBase"; exit 1 }
Log "CLI: $exe"

# 2) Construir el prompt final inyectando la fecha
$promptPath = Join-Path $gen 'prompt.md'
$prompt = Get-Content $promptPath -Raw -Encoding utf8
$prompt = $prompt.Replace('{{TODAY_LONG}}', $todayLong).Replace('{{TODAY_ISO}}', $todayIso).Replace('{{GEN_TIME}}', $genTime)

# 3) Ejecutar Claude headless en la carpeta del proyecto
Set-Location $proj
Log "Lanzando Claude headless (modelo sonnet)..."
try {
  $prompt | & $exe --print --permission-mode bypassPermissions --add-dir $proj --model sonnet *>> $log
  $code = $LASTEXITCODE
} catch {
  Log "EXCEPCION: $($_.Exception.Message)"; $code = 1
}

if ($code -eq 0 -and (Test-Path (Join-Path $proj 'index.html'))) {
  Log "=== OK :: index.html regenerado (exit $code) ==="
  # Publicar en GitHub Pages (commit + push). Continue para que stderr de git no aborte.
  $ErrorActionPreference = 'Continue'
  Log "Publicando en GitHub..."
  git -C $proj add -A *>> $log
  git -C $proj commit -m "SEO Daily: edicion $todayIso" *>> $log
  git -C $proj push origin main *>> $log
  if ($LASTEXITCODE -eq 0) { Log "Publicado en GitHub Pages OK." } else { Log "AVISO: 'git push' devolvio $LASTEXITCODE (revisa credenciales/red)." }
} else {
  Log "=== FALLO :: exit $code ==="
}
exit $code
