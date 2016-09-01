#!/bin/bash

#
#AudVLC audio and video web streaming for Linux system from youtube,dailymotion, vimeo and other sites which are compatible with your installed VLC player

# install vlc 
# If you wants to play youtube playlist then download lua file from http://addons.videolan.org/content/show.php/+Youtube+playlist?content=149909
# install xsel (Optional)

#################Change parameters here###################

#quality of streaming video 240,360,720 etc
quality="360"

audio="yes" #If you want to stream audio keep it as "yes" else if you need video as well keep "no"

##########################################################

function YouAud {	
	
# Copying and validation of url from clipbord using xsel -a  $clpy != $regex 

#checking whether AudVLC is empty or not

var=$(head -n1 $HOME/AudVLC)
#edit regex variable to add more website
regex='((http://)?)(www\.)?((youtube\.com/)|(youtu\.be)|(youtube)|(dailymotion\.com/)|(dailymotion)|(vimeo\.com/)|(vimeo)).+';
clpy=$(xsel -b);
if [[ $clpy =~ $regex ]];then
clpy=$clpy;
elif [[ ( -e $HOME/AudVLC ) && ( $clpy != $regex ) && ( -s $HOME/AudVLC ) ]]; then
clpy=$var
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
echo "Quality = $quality"
echo ""
echo "Stream Audio= $audio"
echo ""
echo "WAIT FOR SOME MINUTES"
echo ""
echo -n > ~/AudVLC
echo $OUTPUT >> ~/AudVLC

if [ $audio == "yes" ]; then
cvlc --preferred-resolution $quality --no-video $OUTPUT & KILL=$(zenity --notification --title="AudVLC" --window-icon="info"  --text="`printf "WARNING AudVLC: \n\n DON'T PRESS CANCEL OR CLOSE \n\n PRESS ONLY OK TO STOP AND KILL VLC MEDIA PLAYER"`")	
else
cvlc --preferred-resolution $quality $OUTPUT & KILL=$(zenity --notification --title="AudVLC" --window-icon="info"  --text="`printf "WARNING AudVLC: \n\n DON'T PRESS CANCEL OR CLOSE \n\n PRESS ONLY OK TO STOP AND KILL VLC MEDIA PLAYER"`")	
fi

#validating submittion and quitting VLC media player
accepted=$?


if [ $accepted -eq 2 ]; then
PID_ZENITY=${!}
PID_CHILD=$(pgrep -o -P $$)
kill PID_CHILD
id=$(pgrep vlc)
kill $id
exit
PID_ZENITY=${!}
PID_CHILD=$(pgrep -o -P $$)
kill PID_CHILD
elif [ $accepted -eq 1 ]; then
id=$(pgrep vlc)
kill $id
exit 
elif  [ $accepted -eq 0 ]; then
PID_ZENITY=${!}
PID_CHILD=$(pgrep -o -P $$)
kill PID_CHILD
id=$(pgrep vlc)
kill $id
exit 
fi
else
PID_ZENITY=${!}
PID_CHILD=$(pgrep -o -P $$)
kill PID_CHILD
id=$(pgrep vlc)
kill $id
exit  
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
YouAud;
fi

# Working in Ubuntu System
