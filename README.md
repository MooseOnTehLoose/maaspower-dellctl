# Features:
Turn individual PoE ports on or of, and get the status of a given port

## Usage

	Usage: poe.sh [status|power] <port>
	status		<port>	Query for the Port Status, returns off or on
	power	on	<port>	Power On Port #
	power	off	<port>	Power Off Port #

Power on a port:
```
./poe.sh power on 12
```
Power off a port:
```
./poe.sh power off 23
```
Query a port's status: 
```
./poe.sh status 1
```

## Configuration

These values configure the ssh connection to your PoE Switch
```
SWITCH="dell5524p"
USER="user"
PASS="password"
IPADDR="10.0.0.20"
```

SWITCH - The name of the switch, visible on the command line when in an ssh session:
```
tony@maas-controller:~$ ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=diffie-hellman-group-exchange-sha1 10.4.8.3
 

User Name:tony
Password:*******

dell5524p#
```
You can configure this value on Dell Switches from the UI under System - General - Asset - System Name

USER - The ssh USER  
PASS - The ssh Password. If your switch supports public key authentication you do not need this. Dell Switches such as the 5500 series support PKI but only as a secondary auth mechanism, password is always required.  
IPADDR - The IP address of the switch. You can add multiple addresses, configurable from the UI under System - IP Addressing - IPv4 Interface Parameters  

You may want to set limits to the ports which can be controlled remotely and can do so via the below values:  
PORTSTART="1"  
PORTEND="24"  


## Installation:
Place poe.sh and status.exp in the root of your maaspower folder. 
