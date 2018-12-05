$inputday = [System.Collections.ArrayList](Get-Content .\day5.input).ToCharArray()

#write-output $inputday
$modified = $true
while ($modified) {
    $modified=$false
    for ($i = 0; $i -lt $inputday.Count; $i++) {
        if (($inputday[$i] -like $inputday[$i + 1]) -and (-not($inputday[$i] -clike $inputday[$i + 1]))) {
            $inputday.RemoveAt($i + 1)
            $inputday.RemoveAt($i)
            $modified = $true
        }
    }
    return $inputday
} 