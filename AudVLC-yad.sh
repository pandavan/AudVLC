#!/bin/bash

#
#AudVLC audio and video web streaming for Linux system from youtube,dailymotion, vimeo and other sites which are compatible with your installed VLC player

# install vlc 
# If you wants to play youtube playlist then download lua file from http://addons.videolan.org/content/show.php/+Youtube+playlist?content=149909
# install xsel (Optional)

#################PARAMETERS###################
#NO NEED TO CHANGE ANY PARAMETERS IN THIS FILE
#quality of streaming video 240,360,720 etc
#quality="240" 

audio="FALSE" #If you want audio keep it as "yes" else if you need video keep "no"

##########################################################

function YouAud {	
	
# Copying and validation of url from clipbord using xsel -a  $clpy != $regex 

#checking whether AudVLC is empty or not

var=$(head -n1 $HOME/.AudVLC/AudVLC)
#edit regex variable to add more website
regex='((http://)?)(www\.)?((youtube\.com/)|(youtu\.be)|(youtube)|(dailymotion\.com/)|(dailymotion)|(vimeo\.com/)|(vimeo)).+';
clpy=$(xsel -b);
if [[ $clpy =~ $regex ]];then
#removing playlist parameters
clpy="$(echo "$clpy"|sed "s/&.*//")"
clpy=$clpy;
elif [[ ( -e $HOME/.AudVLC/AudVLC ) && ( $clpy != $regex ) && ( -s $HOME/.AudVLC/AudVLC ) ]]; then
clpy=$var
else
clpy="http://"
fi
    
inpu=$(yad --form --center --window-icon="gtk-execute" --text="\nEnter Streaming Information:\n" --title="AudVLC"\
             --width="500" --field="URL" $clpy\
             --field="Quality:CBE" 360\!240\!480\!720\!1080 \
             --field="Audio:CHK" FALSE )

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

#getting input variable
OUTPUT=$(echo $inpu | awk 'BEGIN {FS="|" } { print $1 }')
quality=$(echo $inpu | awk 'BEGIN {FS="|" } { print $2 }')
audio=$(echo $inpu | awk 'BEGIN {FS="|" } { print $3 }')
#URL validation

if [[ $OUTPUT =~ $regex  ]] ; then
echo $OUTPUT
echo ""
echo "Quality = $quality"
echo ""
echo "Stream Audio= $audio"
echo ""
echo "WAIT FOR SOME MINUTES"
echo ""
echo -n > ~/.AudVLC/AudVLC
echo $OUTPUT >> ~/.AudVLC/AudVLC

if [ $audio == "TRUE" ]; then
cvlc --preferred-resolution $quality --no-video $OUTPUT & KILL=$(zenity --notification --title="AudVLC" --window-icon="info"  --text="`printf "WARNING AudVLC: \n\n DON'T PRESS CANCEL OR CLOSE \n\n PRESS ONLY OK TO STOP AND KILL VLC MEDIA PLAYER"`")	
else
vlc --preferred-resolution $quality $OUTPUT 	
fi

#validating submittion and quitting VLC media player
accepted=$?


if [ $accepted -eq 2 ]; then
id=$(pgrep vlc)
kill $id
exit
elif [ $accepted -eq 1 ]; then
id=$(pgrep vlc)
kill $id
exit 
elif [ $accepted -eq 0 ]; then
id=$(pgrep vlc)
kill $id
exit 
fi
else
echo ""
fi


}

#creating launcher icon and executable
if [[ ! -f $HOME/.local/share/applications/AudVLC.desktop ]]; then
echo -e "\nCreating a Launcher file details and icon for current user\n"
cat >$HOME/.local/share/applications/AudVLC.desktop<<EOL
[Desktop Entry]
Name=AudVLC
Comment=AudVLC Downloader
Exec=$HOME/.AudVLC/AudVLC.sh
Icon=$HOME/.AudVLC/PCRZK1g.png
Terminal=false
Type=Application
StartupNotify=true
EOL
fi
if [[ ! -d $HOME/.AudVLC ]] || [[ ! -f $HOME/.AudVLC/PCRZK1g.png ]] || [[ ! -f $HOME/.AudVLC/AudVLC.sh ]]; then
echo -e "\nDownloading Icon for Launcher\n"
mkdir -p $HOME/.AudVLC/
cp $(readlink -f $0) $HOME/.AudVLC/AudVLC.sh
wget -N -P $HOME/.AudVLC/ http://i.imgur.com/PCRZK1g.png
#icon courtsey https://www.iconfinder.com/icons/299725/channel_logo_play_player_subscribe_tube_video_youtube_icon#size=128
YouAud;
else
echo -e "\nAll programms and packages installed"
#killing already running zenity process

YouAud;
fi

# Working in Ubuntu System
