Write-Host "Generating 'Helo Wrld' art in 2016 (no history rewrite)..."

$GRID_START = Get-Date "2016-03-01"
$ROWS = 7
$spacing = 1
$word = "Helo Wrld"

$letters = @{

# Uppercase
"H"=@("100001","100001","111111","100001","100001","100001","000000")
"W"=@("100001","100001","100001","101101","101101","010010","000000")

# Lowercase
"e"=@("000000","011110","100001","111111","100000","011110","000000")
"l"=@("010000","010000","010000","010000","010000","010000","000000")
"o"=@("000000","011110","100001","100001","100001","011110","000000")
"r"=@("000000","101110","110001","100000","100000","100000","000000")
"d"=@("000001","000001","011111","100001","100001","011111","000000")

# Space
" "=@("000000","000000","000000","000000","000000","000000","000000")
}

$col = 0

foreach ($char in $word.ToCharArray()) {

    if (-not $letters.ContainsKey($char)) { continue }

    $pattern = $letters[$char]
    $width = $pattern[0].Length

    for ($r=0; $r -lt $ROWS; $r++) {
        for ($c=0; $c -lt $width; $c++) {

            if ($pattern[$r][$c] -eq "1") {

                $date = $GRID_START.AddDays(($col*7)+$r)

                $env:GIT_AUTHOR_DATE=$date.ToString("yyyy-MM-dd")+"T12:00:00"
                $env:GIT_COMMITTER_DATE=$env:GIT_AUTHOR_DATE

                git commit --allow-empty -m "Helo Wrld 2016 art"
            }
        }
    }

    $col += $width + $spacing
}

Write-Host "Done."
Write-Host "Now push normally (no force needed):"
Write-Host "git push origin main"
