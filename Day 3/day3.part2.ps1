$inputday = get-content .\day3.input
$map = New-Object 'int[,]'1000, 1000

foreach ($line in $inputday) {
    $split = $line.Split("")
    [int]$x, [int]$y = $split[2].trim(':').split(',')
    [int]$w, [int]$h = $split[3].trim().split('x')

    for ($i = $y; $i -lt ($y + $h); $i++) {
        for ($j = $x; $j -lt ($x + $w); $j++) {
            $map[$i, $j]++
        }
    }
}

write-output ($map -ge 2 | Measure-Object).Count