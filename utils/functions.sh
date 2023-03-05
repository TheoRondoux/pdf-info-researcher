#!/bin/bash

source utils/dir_management.sh

input_keyword_rofi(){			#Displays a rofi menu for the user to type something
    keyword=$(rofi -dmenu -p "Enter a keyword")
    echo "$keyword"
}

create_file(){				#Creating a file for the history
     isFilePresent=$(find history/"$1.txt" 2>> error.txt)
     if [[ isFilePresent != "" ]]
     then
	touch history/"$1.txt"
     fi
}

search_files(){				#Searching the user's input in all the files listed in the config file
    > "$2"
    for directory in $(list_config_dirs)
    do
	for file in $directory*.pdf
        do
	    content=$(pdfgrep --ignore-case "$1" $file 2>> error.txt)
	    if [[ "$content" != "" ]]
	    then
	        echo "$file" 1>> "$2"
	    fi
        done
    done
}

call_rofi(){				#Displaying a rofi menu with all the researches
    if [[ $(cat $2 2>> error.txt) != "" ]]
    then
	rofi -dmenu -p "$1" 0< "$2"
    else
	rofi -e "No file found for the keyword"
    fi
}

display_rofi_message(){			#Displays a message with rofi
    rofi -e "$1"
}
