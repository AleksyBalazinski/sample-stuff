# The following script compares timestamps of .cpp source file and .o object file.
# If they differ by less than 3 seconds, then they are assumed to be equal. 
# If they are not equal, then .o gets recompiled and .exe re-linked and timestamps are set to the current time.

$delta = 30000000

$main = Get-ChildItem main.cpp
$func = Get-ChildItem func.cpp

$main_o = Get-ChildItem main.o
$func_o = Get-ChildItem func.o

$main_time = $main.LastAccessTime.Ticks
$func_time = $func.LastAccessTime.Ticks

$main_o_time = $main_o.LastAccessTime.Ticks
$func_o_time = $func_o.LastAccessTime.Ticks

$main_diff = ($main_o_time -gt ($main_time - $delta)) -and ($main_o_time -lt ($main_time + $delta))
$func_diff = ($func_o_time -gt ($func_time - $delta)) -and ($func_o_time -lt ($func_time + $delta))

if( -not $main_diff )
{
    Write-Host "Difference between main.cpp and main.o"
    g++ -c main.cpp
}

if( -not $func_diff )
{
    Write-Host "Difference between func.cpp and func.o"
    g++ -c func.cpp
}

if( -not ($func_diff -and $main_diff))
{
    Write-Host "Re-Linking..."
    g++ main.o func.o -o prog
    $main.LastAccessTime=(Get-Date)
    $func.LastAccessTime=(Get-Date)
    $func_o.LastAccessTime=(Get-Date)
    $main_o.LastAccessTime=(Get-Date)
}



