look_for_dir(){				#Function that looks for a specific directory
    found_dir=0
    for directory in ./*
    do
	if [[ -d $directory ]] && [[ "${directory##*/}" == "$1" ]]
	then
	    found_dir=1
	fi
    done

    echo "$found_dir"
}

list_config_dirs(){			#Function that retrieves all the folders indicated in the config file
    while read elem
    do
	if [[ $elem == /* ]]
	then
	   if [[ $elem == */ ]]
	   then
	       echo "$elem"
	   else
               echo "$elem/"
	   fi
	fi
    done < /home/$USER/.config/pdf_search/config.txt
}
