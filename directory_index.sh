#!/bin/sh

set -eu

# configuration
default_title="Directory index"
start_dir="."

# $1: directory where to search directories
list_directories() {
  find "$1" -type d -maxdepth 1 -not -path '*/\.*' -not -path "$1" | sort | \
  while IFS='' read -r directory_path; do
    directory_name=$(basename "$directory_path")
    echo "    <li><a href=\"$directory_name/\">$directory_name/</a></li>"
  done
}

# $1: directory where to search files
list_files() {
  find "$1" -type f -maxdepth 1 -not -path '*/\.*' | sort | \
  while IFS='' read -r file_path; do
    file_name=$(basename "$file_path" | sed 's/"/&quot;/g')
    echo "    <li><a href=\"$file_name\">$file_name</a></li>"
  done
}

# $1: title
generate_header() {
  if [ "$1" = "." ]; then
    current_title_prefix=""
    current_title="$default_title"
  else
    current_title_prefix="Index for: "
    current_title="$1"
  fi

  cat - <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$current_title_prefix$current_title</title>
</head>
<body>
  <header>
    <h1>$current_title</h1>
  </header>
  <ul>
EOF
}

generate_footer() {
  cat - <<EOF
  </ul>
  <footer>Generated at: $(date -u '+%F %H:%M:%S (UTC)')</footer>
</body>
</html>
EOF
}

# $1: directory path
generate_index() {
  index_file_temp="$1/.index.html"
  index_file="$1/index.html"
  directory_name=$(basename "$1")
  if [ -f "$index_file" ]; then
    echo "  - not generating index file '$index_file', because it already exists"
  else
    echo "  - generating index for: $directory_name ($index_file)"
    (
      generate_header "$directory_name"
      list_directories "$1"
      list_files "$1"
      generate_footer
    ) > "$index_file_temp"
    mv "$index_file_temp" "$index_file"
  fi
}

echo "Generating indexes…"

find "$start_dir" -type d -not -path '*/\.*' | \
while IFS='' read -r directory_path; do
  generate_index "$directory_path"
done
