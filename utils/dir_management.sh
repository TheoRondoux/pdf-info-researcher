look_for_dir(){
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

list_config_dirs(){
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
