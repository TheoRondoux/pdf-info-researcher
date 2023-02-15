#!/bin/bash

source functions.sh

old_research(){
    touch hist_content.txt
    find history/* > hist_content.txt
    file=$(call_rofi "Choose a file" hist_content.txt)
    rm hist_content.txt
    xdg-open $(call_rofi "Select a file to open" $file) 1>> error.txt
}

new_research(){
    keyword=$(input_keyword_rofi)
    create_file "$keyword"
    search_files "$keyword" history/"$keyword.txt"
    xdg-open $(call_rofi "Select a file to open" history/"$keyword.txt") 1>> error.txt
}

> error.txt
option=$(call_rofi "Choose an option" options.txt)
case $option in
    "Old research") old_research;;
    "New research") new_research;;
    *) rofi -e "Not an option";;
esac
