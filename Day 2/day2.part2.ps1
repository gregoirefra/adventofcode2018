param(
  $inputString
)

$triplet = $false
$double = $false
$tripleCount = 0
$doubleCount = 0 


foreach ($line1 in (Get-Content $inputString)) {
  $chararray1 = $line1.ToCharArray()
  foreach ($line2 in (Get-Content $inputString)) {
    $chararray2 = $line2.ToCharArray()
    $count = 0
    if ($line1 -ne $line2) {
      for ($i = 0; $i -lt $chararray2.Count; $i++) {
        if ($chararray1[$i] -eq $chararray2[$i]) {
          $count++
        }
      }
      if (($chararray1|Measure-Object).Count - 1 -eq $count){
        Write-Output $line1 
        Write-Output $line2
      }
    }


  }
}
  <#
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
  #>
#Write-Output "Double : $doubleCount"
#Write-Output "Triple : $tripleCount"
#Write-Output $tripleCount*$doubleCount