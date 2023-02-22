#!/bin/bash

source utils/dir_management.sh

input_keyword_rofi(){
    keyword=$(rofi -dmenu -p "Enter a keyword")
    echo "$keyword"
}

create_file(){
     isFilePresent=$(find history/"$1.txt" 2>> error.txt)
     if [[ isFilePresent != "" ]]
     then
	touch history/"$1.txt"
     fi
}

search_files(){
    > "$2"
    for directory in $(list_config_dirs)
    do
	for file in $directory*.pdf
        do
	    content=$(pdfgrep "$1" $file 2>> error.txt)
	    if [[ "$content" != "" ]]
	    then
	        echo "$file" 1>> "$2"
	    fi
        done
    done
}

call_rofi(){
    if [[ $(cat $2 2>> error.txt) != "" ]]
    then
	rofi -dmenu -p "$1" 0< "$2"
    else
	rofi -e "No file found for the keyword"
    fi
}

display_rofi_message(){
    rofi -e "$1"
}
