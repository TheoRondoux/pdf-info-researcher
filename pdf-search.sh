#!/bin/bash

source functions.sh
> error.txt
keyword=$(input_keyword_rofi)
search_files "$keyword" files.txt
xdg-open $(call_rofi "Select a file" files.txt) 1>> error.txt
