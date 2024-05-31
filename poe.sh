#!/bin/bash
#
#PoE control for MaaSPower: https://gilesknap.github.io/maaspower/main/index.html
#
#Written by Tony Windebank

SWITCH="dell5524p"
USER="user"
PASS="password"
IPADDR="10.0.0.20"

#configure the port range for your switch
PORTSTART="1"
PORTEND="24"

int='^[0-9]+$'

#Power Control
if [[ "$1" == "power" ]]; then
	
	#Check if power is on, off, or invalid
	if [[ "$2" == "on" ]]; then
		POWER=""
	elif [[ "$2" == "off" ]]; then
		POWER="never"
	else
		echo "Error: No Power Mode defined."
		exit 1
	fi
	
	#Check if Port is a number
	if  ! [[ $3 =~ $int ]]; then
		echo "Error: Port $3 is not an integer"
		exit 1
	fi
	
	#Check if Port is within range
	if !(($3 >= $PORTSTART && $3 <= $PORTEND)); then
		echo "Error: Port is not within Range $PORTSTART-$PORTEND"
		exit 1
	fi

	#Connect to Dell 5524p
	ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=diffie-hellman-group-exchange-sha1 -tt $IPADDR <<-EOF
	$USER
	$PASS
	config
	interface gigabitethernet 1/0/$3
	power inline $POWER
	exit
	exit
	exit
	EOF

#Status Querying 	
elif [[ "$1" == "status" ]]; then
	
	#We need to use expect statements to return data from our commands
	./status.exp $SWITCH $USER $PASS $IPADDR $2 | grep -e "Port Status" | cut -c 36-38

#Help Commands
else
	cat <<-EOF
	Usage: poe.sh [status|power] <port>
	status		<port>	Query for the Port Status, returns off or on
	power	on	<port>	Power On Port #
	power	off	<port>	Power Off Port #
	EOF
fi
