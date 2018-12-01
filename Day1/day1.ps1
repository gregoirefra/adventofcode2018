param(
  [string]$inputFile
)
$array = (Get-Content $inputFile).Split(" ")
$freq = 0
foreach ($change in $array) {
  if ($change.Contains("-*")) {
    $freq -= $change.trimstart("-")
  }
  else {
    $freq += $change.trimstart("+")
  }
}

write-output $freq