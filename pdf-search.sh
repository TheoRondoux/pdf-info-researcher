#!/bin/bash

#Import all the functions
source utils/functions.sh
source utils/dir_management.sh

#If the folder history does not exists, create it
if [[ $(look_for_dir history) -eq 0 ]]
then
    mkdir history
fi

#Function to fetch all the previous researches
old_research(){
    touch hist_content.txt					#Creating a temporary file
    find history/* > hist_content.txt 2>> error.txt		#Checking if the are any previous researches
    if [[ $? -ne 0 ]]						#If there is any error, displaying a message and exiting the program
    then
	display_rofi_message 'No previous researches to show' 
	exit 1
    fi
    file=$(call_rofi "Choose a file" hist_content.txt)			#Displaying all the options fount or a message if no previous researches foun
    rm hist_content.txt							#Deleteting the temporary file
    xdg-open $(call_rofi "Select a file to open" $file) 1>> error.txt	#Opening the file chosen by the user
}

#Function to make a new research in the files
new_research(){
    keyword=$(input_keyword_rofi)							#Getting the keyword entered by the user
    create_file "$keyword"								#Creating the file corresponding to the keyword
    search_files "$keyword" history/"$keyword.txt"					#Researching the keyword in the file
    xdg-open $(call_rofi "Select a file to open" history/"$keyword.txt") 1>> error.txt	#Opening the file wantend by the user
}

#Empty error.txt
> error.txt

#Getting the option chosen by the user
option=$(call_rofi "Choose an option" utils/options.txt)

#Depending on the option, calling the right function
case $option in
    "Old research") old_research;;
    "New research") new_research;;
    *) rofi -e "Not an option";;
esac
