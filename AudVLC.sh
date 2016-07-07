#!/bin/bash

#
#AudVLC audio web streaming for Linux system from youtube,dailymotion, vimeo and other sites which are compatible with your installed VLC player

# install vlc 
# If you wants to play youtube playlist then download lua file from http://addons.videolan.org/content/show.php/+Youtube+playlist?content=149909
# install xsel (Optional)


function YouAud {	
	
# Copying and validation of url from clipbord using xsel

#edit regex variable to add more website
regex='((http://)?)(www\.)?((youtube\.com/)|(youtu\.be)|(youtube)|(dailymotion\.com/)|(dailymotion)|(vimeo\.com/)|(vimeo)).+';
clpy=$(xsel -b);
if [[ $clpy =~ $regex ]];then
clpy=$clpy;
else
clpy="http://"
fi

OUTPUT=$(zenity --entry --width="500" --title="AudVLC" --text="Enter YouTube URL" --entry-text="$clpy")

#validating submittion
accepted=$?

if [ $accepted -eq 2 ]; then
YouAud;
exit
elif [ $accepted -eq 1 ]; then
echo "Cancelled"
exit 1
elif  [ $accepted -eq 0 ]; then
echo ""
else
echo "something went wrong"
exit 1 
fi

#URL validation

if [[ $OUTPUT =~ $regex  ]] ; then
echo $OUTPUT
echo ""
echo "WAIT FOR SOME MINUTES"
echo ""
cvlc --vout none $OUTPUT	
else
zenity --info --width=300 --title="AudVLC" --timeout=3 --text="Wrong Streaming URL"
YouAud;
fi



}

YouAud;

# Working in Ubuntu System
