enum state{
    awake
    asleep
}

$dayinput = Get-content .\day4.input
for ($i = 0; $i -lt $dayinput.Count; $i++) {
    $tempCopy = $dayinput[$i]
    $tempCopy = $tempCopy.Split("]")
    $tempCopy[0] = [DateTime]($tempCopy[0].Trimstart("["))
    $tempCopy[1] = $tempCopy[1].trim()
    $dayinput[$i] = @{"TimeStamp" = $tempCopy[0]; "Event" = $tempCopy[1]}
}

class Guard {
    [int]$guardID
    [state]$his_state
    [int]$maxMinuteSleep
    [int[]]$sleepingMinute
    [int]$allTimeSleep

    Guard ([int]$id) {
        $this.guardID = $id
    }

    [void] AddSleep([int]$sleepingMinute) {

            $this.sleepingMinute += $sleepingMinute
            $this.allTimeSleep ++
        
    }

    [int] getMaxMinuteSleep() {
        if ($this.sleepingMinute) {
            $t = $this.sleepingMinute
            return  [int](($t | group-object | Sort-Object {$_.Count} -Descending)[0].Name)
        }
        return 0
        
    }
}

$dayinput = $dayinput | Sort-Object {$_.TimeStamp}
$guards=@([Guard]::new(0),[Guard]::new(0))

foreach ($events in $dayinput) {
    if ($events.Event -like "Guard *") {
        #We check if the guard exist and set it as current
        $guardID = ($events.Event.Split())[1].Trimstart("#")
        if (-not ($guards.GuardID -contains $guardID)) {
            $guards += [Guard]::new($guardID)
        }
        if ($currentGuard -ne $guardID) {
            $currentGuard = $guardID
        }
    }
    elseif ($events.Event -eq "falls asleep") {
        [int]$sleep = ([DateTime]$events.TimeStamp).Minute
        foreach ($item in $guards) {
            if ($item.GuardID -eq $guardID) {
                $item.AddSleep($sleep)
            }
        }
    }
    else {
        foreach ($item in $guards) {
            if ($item.GuardID -eq $guardID) {
                for ($i = ($sleep + 1); $i -lt ([DateTime]$events.TimeStamp).Minute; $i++) {
                    $item.AddSleep($i)
                }
            }
        }
    }
}

$maxGuard = [Guard]::new(0)

foreach ($item in $guards) {
    if ($maxGuard.sleepingMinute.Count -lt $item.sleepingMinute.Count) {
        $maxGuard = $item
    }
}

Write-output ([int]$maxGuard.guardID * [int]$maxGuard.getMaxMinuteSleep())

#Write-Output
#$test = $guards[5].getMaxMinuteSleep()

#$guardsTime = @{}
#$currentGuard = 0
#$sleep = 0
<#
foreach ($events in $dayinput) {
    if ($events.Event -like "Guard *") {
        #We check if the guard exist and set it as current
        $guardID = ($events.Event.Split())[1].Trimstart("#")
        if (-not ($guardsTime.Keys -contains ("$guardID"))) {
            $guardsTime.Add($guardID, 0)
        }
        if ($currentGuard -ne $guardID) {
            $currentGuard = $guardID
        }
    }
    elseif ($events.Event -eq "falls asleep") {
        #$guardsTime.$currentGuard += [int]([DateTime]$events.TimeStamp).Minute
        [int]$sleep = ([DateTime]$events.TimeStamp).Minute
    }
    else {
        $guardsTime.$currentGuard += ([int]([DateTime]$events.TimeStamp).Minute - $sleep - 1)
    }
}
$maxGuard = @{"Max" = 0; "GuardID" = 0}
foreach ($g in $guardsTime.Keys) {
    if ($guardsTime.$g -gt $maxGuard.Max) {
        $maxGuard.GuardID = $g
        $maxGuard.Max = $guardsTime.$g
    }
}
#>

#$grouppp = $guards.($maxGuard.GuardID) | group

#write-output ([int](($grouppp | Sort-Object {$_.Count} -Descending)[0].Name) * [int]($maxGuard.guardID))