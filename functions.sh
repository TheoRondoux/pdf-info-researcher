input_keyword_rofi(){
    keyword=$(rofi -dmenu -p "Enter a keyword")
    echo "$keyword"
}

search_files(){
    > "$2"
    for file in /home/$USER/.config/pdf_search/*.pdf
    do
	content=$(pdfgrep "$1" $file)
	if [[ "$content" != "" ]]
	then
	    echo "$file" 1>> "$2"
	fi
    done
}

call_rofi(){
    if [[ $(cat $2) != "" ]]
    then
	rofi -dmenu -p "$1" 0< "$2"
    else
	rofi -e "No file found for the keyword"
    fi
}
