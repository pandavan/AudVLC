# AudVLC

AudVLC is a simple bash script with GUI which will enable Linux users with an installed VLC player, stream their favourite videos and playlist as audios as well as videos from famous video streaming websites like YouTube, Dailymotion, Vimeo and many more.




1) Download the `AudVLC.sh (zenity)` or `AudVLC (yad).sh (yad)` bash script

2) Customize parameter or after installation change it from $HOME/.AudVLC/AudVLC.sh

3) Make AudVLC.sh as executable file using `$ chmod +x AudVLC.sh`

4) Execute AudVLC.sh file for installation

5) Paste the streaming URL in the textbox and select quality if you are using yad supported file.

# Requirments

1) Any modern Ubuntu distros

2) VLC player

3) [xsel](https://apps.ubuntu.com/cat/applications/xsel/)

#Changing paragmeters
- You can change parameters in this section of AudVLC.sh code

```
#quality of streaming video 240,360,720 etc
quality="360"

audio="yes" #If you want to stream audio keep it as "yes" else if you need video as well keep "no"
```

# Advantage of using AudVLC

- Use less system resources
- Prevents over heating of system while streaming. A 10-20 degree celcius (system test result) decrease in temperature is noted when compared to streaming from ordinary VLC player GUI or from browser
- Fast streaming
- Can select different quality of audios and videos

#Executing AudVLC from Ubuntu Unity Launcher

- First execute the AudVLC.sh script then search AudVLC in the Search bar
- Then Lock AudVLC to launcher

#Stoping Streaming (IMPORTANT)

- You have to press OK to stop the streaming process
- else you have to kill VLC process manually

