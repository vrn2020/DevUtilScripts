param (
[string]$csvFilePath,
[bool]$firstRowContainsColumnNames
)

# Read the CSV file
$data = Get-Content -Path $csvFilePath

# Initialize the starting index for iterating through the rows
$startIndex = if ($firstRowContainsColumnNames) { 1 } else (o}

# Get the column names from the first row of the CSV file and add single quotes if applicable
$columnNames = @（）

if ($firstRowContainsColumnNames) {
$columnNames = ($data[0] -split '\s+') | ForEach-object {''$_'" }
}

# Construct the SQL insert statement
$sqlInsert = "INSERT INTO YourTableName ("
$sqlInsert += (ScolumnNames -join ", ") +. ") VALUES "

# Iterate through each row of the CSV data, starting from the appropriate index

for ($i = $startIndex; $i -lt §data.Count; $i++) {
$rowvalues = @()
$values = ($data[$i] -split '\s+')
for ($j = 0; $j -It $values. Count; $j++) {
if (Svalues[$j] -eq "NULL" -or [int]::TryParse(Svalues[$j], [ref]$null)) {
$rowValues += $values[$j]
} 
elseif ($values[$j] -match "^\d{4}-\d{2}-\d{2}$" -and $j -It $values. Count - 2 -and $values[$j + 1] -match "^\d{2}: \d{2}; \d{2}l. \d{7,}$" -and $values[$j + 2] -match "^[+-]\d{2}:\d{2}5") {
$combinedValue = $values[$j] + " " + $values [$j + 1] + " " + Svalues[$j + 2]
$rowvalues += "'$combinedValue'"
$j += 2 # Skip the next 2 values
} 
else {
$rowValues += "'$($values[$j])'"
}
}
$sqlInsert += "(" + ($rowvalues -join ", ") + "),"
}

# Remove the trailing ",  " and append a semicolon to end the SQL statement
$sqlInsert - $sqlInsert.TrimEnd(" ,") + ";"

# Output the constructed SQL insert statement
Write-Host $sqlInsert
