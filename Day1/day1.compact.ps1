param(
  [string]$inputFile
)
$array = (Get-Content $inputFile).Split(" ")
$freq = 0
foreach ($change in $array) {
  $freq += [int]$change
}

write-output $freq