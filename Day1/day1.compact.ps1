param(
  [string]$inputFile
)
$array = (Get-Content $inputFile).Split(" ")
$freq = 0
foreach ($change in (Get-Content $inputFile).Split(" ")) {
  $freq += [int]$change
}
write-output $freq
