param(
  [string]$inputFile
)
$usedfreq = @{}
$start = 0
$array = (Get-content $inputFile).split(" ")
for ($i = 0; $i -lt 1000000; $i++) {
  foreach ($change in $array) {
    if ($change.Contains("-*")) {
      $start -= $change.trimstart("-")
    }
    else {
      $start += $change.trimstart("+")
    }
    if ($usedfreq.$start) {
      Write-output $start
      exit
    }
    else {
      $usedfreq.Add($start, "used freq")
    }
  }
}

Write-Output $start