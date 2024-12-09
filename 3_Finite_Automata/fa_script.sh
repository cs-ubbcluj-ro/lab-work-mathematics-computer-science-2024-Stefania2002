#!/bin/bash

# Function to load FA from file
load_fa() {
  local file_name="$1"
  local line_num=0

  while IFS= read -r line; do
    line_num=$((line_num + 1))
    if [[ -z "$line" ]]; then
        continue
    fi

    case $line_num in
      1) IFS=',' read -r -a states <<< "$line" ;;
      2) IFS=',' read -r -a alphabet <<< "$line" ;;
      3) start_state="$line" ;;
      4) IFS=',' read -r -a final_states <<< "$line" ;;
      *) transitions+=("$line") ;;
    esac
  done < "$file_name"
}

# Function to display FA
display_fa() {
  echo "Set of States: ${states[*]}"
  echo "Alphabet: ${alphabet[*]}"
  echo "Start State: $start_state"
  echo "Set of Final States: ${final_states[*]}"
  echo "Transitions:"
  for transition in "${transitions[@]}"; do
    IFS=',' read -r state symbol next_state <<< "$transition"
    echo "  δ($state, $symbol) -> $next_state"
  done
}

# Main execution
fa_file="FA.in"
load_fa "$fa_file"
display_fa

