#!/bin/bash

#Import all the functions
source functions.sh

#Function to fetch all the previous researches
old_research(){
    touch hist_content.txt					#Creating a temporary file
    find history/* > hist_content.txt 2>> errors.txt		#Checking if the are any previous researches
    file=$(call_rofi "Choose a file" hist_content.txt)		#Displaying all the options fount or a message if no previous researches found
    if [[ $? -ne 0 ]]						#If there is any error, exiting the program
    then
	exit 1
    fi
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

#Empty errors.txt
> error.txt

#Getting the option chosen by the user
option=$(call_rofi "Choose an option" options.txt)

#Depending on the option, calling the right function
case $option in
    "Old research") old_research;;
    "New research") new_research;;
    *) rofi -e "Not an option";;
esac
