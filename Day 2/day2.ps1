param(
  $inputString
)

$triplet = $false
$double = $false
$tripleCount = 0
$doubleCount = 0 

foreach ($line in (Get-Content $inputString)) {
  $chararray = $line.ToCharArray()
  foreach ($char1 in $chararray) {
    $count = ($chararray | Where-Object {$_ -eq $char1} | Measure-Object).Count
    if ($count -eq 3) {
      $triplet = $true
    }
    if ($count -eq 2) {
      $double = $true
    }
  }
  if ($triplet) {
    $tripleCount++
    $triplet = $false
  }
  if ($double) {
    $doubleCount++
    $double = $false
  }
}
Write-Output "Double : $doubleCount"
Write-Output "Triple : $tripleCount"
Write-Output $tripleCount*$doubleCount