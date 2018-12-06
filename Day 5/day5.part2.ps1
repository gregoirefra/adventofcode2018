$start = Get-Date
$inputday = [System.Collections.ArrayList](Get-Content .\day5.input).ToCharArray()

$uniques = $inputday | select -Unique
#write-output $inputday


function FunctionName {
    param (
        [System.Collections.ArrayList]$potato,
        [char]$letter
    )
    $modified = $true
    while ($modified) {
        $modified = $false
        for ($i = 0; $i -lt $potato.Count; $i++) {
            if ($potato[$i] -like $letter) {
                $potato.RemoveAt($i)
                $modified = $true
                break
            }
            if (($potato[$i] -like $potato[$i + 1]) -and (-not($potato[$i] -clike $potato[$i + 1]))) {
                $potato.RemoveAt($i + 1)
                $potato.RemoveAt($i)
                $modified = $true
                break
            }
        }
    } 

    return $potato.Count
}
$min = 1000000000
workflow poss {
    param($arry)
    foreach -parallel ($puke in $arry) {
        FunctionName -potato $inputday.Clone() -letter $puke
    }
}

<#
$i = 0
foreach ($u in $uniques) {
    Write-Progress -Activity "Calulating length with $u ||| Current min is : $min" -Status "Letter : $u ||| Min : $min" -percentComplete ($i / $uniques.Count * 100)
    $temp = FunctionName -potato $inputday.Clone() -letter $u
    if ($temp -lt $min) {
        $min = $temp
    }
}
    
#>

$end = Get-Date

Write-output "Time taken : $($End-$start)"
write-output $min