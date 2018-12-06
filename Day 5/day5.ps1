$inputday = [System.Collections.ArrayList](Get-Content .\day5.input).ToCharArray()

#write-output $inputday
$modified = $true
while ($modified) {
  Write-Output "Current length : $($inputday.Count)"
  $modified = $false
  Write-Progress -id 1 -Activity "Day 5 part 1" -Status "Shrinking data"
  for ($i = 0; $i -lt $inputday.Count; $i++) {
    if ($i -lt 0) {
      $i = 0
    }
    Write-Progress -id 2 -ParentId 1 -Activity "Processing data" -PercentComplete ($i / $inputday.Count * 100) 
    if (($inputday[$i] -like $inputday[$i + 1]) -and (-not($inputday[$i] -clike $inputday[$i + 1]))) {
      $inputday.RemoveAt($i + 1)
      $inputday.RemoveAt($i)
      $modified = $true
      $i -= 2
    }
  }
}
write-output "Final length: $($inputday.Count)"