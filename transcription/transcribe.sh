#!/bin/bash

DIR="$HOME/Downloads/6.5840/"
MODEL="llama2-chinese:13b-chat"
# MODEL="llama-chinese-subtitle-translator-13B"

# Transcription to Chinese
for file_path in "$DIR"/*.vtt; do
    # Construct the write path with the desired output name
    write_path="${file_path%.*}.output.md"

    echo "" > "$write_path"
    
    # Placeholder for your loop body
    echo "Processing file: $file_path"
    echo "Writing output to: $write_path"

    # Your code goes here
    # Loop through the file, reading 24 lines at a time
    # Get the number of lines in the file
    total_lines=$(wc -l < "$file_path")
    line_num=0
    blob=""
    
    # Iterate from 4 to total lines in intervals of 3
    for ((i = 4; i <= total_lines; i += 3)); do
        line=$(head -n $i "$file_path" | tail -n 1 )
        blob="$blob\n$line"
        line_num=$((line_num + 1))
        echo "$line" >> "$write_path"
        if ((line_num == 30)); then
            echo "原文：$blob"
            # Process the blob with your command (echo is used as a placeholder)
            output=$(ollama run $MODEL "Summarize the content. One sentence.：$blob") 
            echo "翻译：$output"
            echo -e "\n概括：--------------------------\n $output\n ----------------------------" >> "$write_path"
            line_num=0
        fi
    done

    wc -l "$write_path"
done


