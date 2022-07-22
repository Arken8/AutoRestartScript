#!/bin/bash
#made by arken
#/!\ NO CHANGE THIS FILE !! /!\

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PWD

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

if [ -f AutoRestartConfig ]
then
	DIRECTORY=$(grep -e ^DIRECTORY= AutoRestartConfig | awk -F '=' '{print $2}')
	JARFILE=$(grep -e ^JARFILE= AutoRestartConfig | awk -F '=' '{print $2}')
	SCRENNAME=$(grep -e ^SCREENNAME= AutoRestartConfig | awk -F '=' '{print $2}')
	PARAMETERS=$(grep -e ^PARAMETERS= AutoRestartConfig | awk -F '=' '{print $2}')
	AUTORESTART=$(grep -e ^AUTORESTART= AutoRestartConfig | awk -F '=' '{print $2}')
else
	echo -e "${RED}No AutoRestartConfig found !${NC}"
	echo -e "${RED}AutoRestart script will continue but witkout any spécific configuration.${NC}"
fi

NUMBEROFJAR=$(find ./ -maxdepth 1 -iname "*.jar" | wc -l)

if [ $NUMBEROFJAR -eq 0 ]
then
	echo -e "${RED}No jar file found !${NC}"
	exit 0
elif [ $NUMBEROFJAR -gt 1 ]
then
	if [ -z "$JARFILE" ]
	then
		echo -e "${RED}There are more than one jar file !${NC}"
		echo -e "${RED}Specify the file you want to launch in the AutoRestartConfig.${NC}"
		exit 1
	fi
fi

if [ -z "$DIRECTORY" ]
then
	DIRECTORY=$PWD
fi

if [ -z "$JARFILE" ]
then
	cd $DIRECTORY
	JARFILE=$(find -iname *.jar|sed 's#.*/##')
fi

if [ -z "$SCREENNAME" ]
then
	SCREENNAME=$(basename $JARFILE .jar)
fi

if ! screen -list | grep -q -e ".*.$SCREENNAME"
then
	if [ "$AUTORESTART" != "false" ]
	then
        	cd $DIRECTORY && screen -d -m -S $SCREENNAME java $PARAMETERS -jar $JARFILE
		echo -e "${GREEN}Starting server...${NC}"
	else
		echo -e "${RED}Put the AUTORESTART variable on true in the AutoRestartConfiguration file to activate AutoRestart !${NC}"
	fi
else
	echo -e "${GREEN}Server already running !${NC}"
fi
