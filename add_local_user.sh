#!/bin/bash

# The script adds a local user to the system.

# Enforces that the script is executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
	echo 'You need to have superuser (root) privileges to run this script.'
	exit 1
fi

# Get username, name of the person who will be using the account and password.
read -p 'Enter the username to create: ' USERNAME
read -p 'Enter the real name of the person who will be using the account: ' REAL_NAME
read -p 'Enter the initial password to use for the account: ' PASSWORD

# Create new user with the information provided.
useradd -c "${REAL_NAME}" -m ${USERNAME}

# Check if creation of user was successfull.
if [[ "${?}" -ne 0 ]]
then
	echo 'Create user went wrong. Please try again.'
	exit 1
fi

#Add password to the new user account
echo ${PASSWORD} | passwd --stdin ${USERNAME} 

# Check if the password was added successfully.
if [[ "${?}" -ne 0 ]]
then	echo 'The password was not added successfully. Please try again.'
	exit 1
fi

#Force password change on first login.
passwd -e ${USERNAME}


#Displays the username, real name, password, and host. (in order to easily deliver the information to the new account holder)
echo "
Info about the new account:
Username: ${USERNAME} 
Real Name: ${REAL_NAME}
Password: ${PASSWORD}
Host: ${HOSTNAME}
"



