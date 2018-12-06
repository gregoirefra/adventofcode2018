$start = Get-Date
$inputday = [System.Collections.ArrayList](Get-Content .\day5.input).ToCharArray()

$uniques = $inputday | sort-object -Unique


function ShrinkArray {
  param (
    [System.Collections.ArrayList]$potato,
    [char]$letter
  )
  $modified = $true
  while ($modified) {
    $modified = $false
    #Write-Output "Current length : $($potato.Count)"

    for ($i = 0; $i -lt $potato.Count; $i++) {
      Write-Progress -id 2 -ParentId 1 -Activity "Processing data" -PercentComplete ($i / $inputday.Count * 100) -Status "Current length : $($potato.Count)"
      if ($i -lt 0) {
        $i = 0
      }
      if ($potato[$i] -like $letter) {
        $potato.RemoveAt($i)
        $modified = $true
        $i -= 2
      }
      if (($potato[$i] -like $potato[$i + 1]) -and (-not($potato[$i] -clike $potato[$i + 1]))) {
        $potato.RemoveAt($i + 1)
        $potato.RemoveAt($i)
        $modified = $true
        $i -= 2

      }
    }
  }
  return $potato.Count
}


$j = 0
$min = 50000
foreach ($u in $uniques) {
  Write-Progress -Activity "Calulating length with $u || Current min is : $min || Time since started $((Get-date) - $start)" -Status "Letter : $u ||| Min : $min" -percentComplete ($j / $uniques.Count * 100) -Id (1)
  $temp = ShrinkArray -potato $inputday.Clone() -letter $u
  if ($temp -lt $min) {
    $min = $temp
  }
  $j++
}





$end = Get-Date

Write-output "Time taken : $($End-$start)"
write-output $min