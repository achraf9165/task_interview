#!/bin/bash

# Check if filename was provided as input
if [ $# -eq 0 ]; then
    echo "Error: Please provide a filename as input"
    exit 1
fi

# Read file into an array of usernames
mapfile -t usernames < "$1"


# Set default output file name if not provided
output_file=${2:-passwords_list}


# Define password complexity, strength, and length
password_complexity=3 # 1 for lowercase + uppercase, 2 for lowercase + uppercase + numbers, 3 for lowercase, uppercase, digits and special characters
password_strength=20  # Password strength in bits (higher is stronger)
password_length=18    # Password length in characters


#Set Character sets based on password complexity
case $password_complexity in
	1)
	  char_set='[:lower:][:upper:]'
	  echo " "
	  echo "Password complexity: Lowercase and Uppercase letters"
	  
	  ;;
	2)
	  char_set='[:lower:][:upper:][:digit:]'
	  echo " "
	  echo "Password complexity: Lowercase and Uppercase letters with digits"

	  ;;
	3)
	  char_set='[:alnum:][:punct:]'
	  echo " "
	  echo "Password complexity: Lowercase, Uppercase letters, digits and special characters"

	;;
	
esac


# Loop through usernames and generate password for each
for username in "${usernames[@]}"
do
    # Generate password using openssl rand command using password strength, complexity and length defined above
    password=$(openssl rand -base64 "$password_strength" | tr -dc "$char_set" | fold -w "$password_length" | head -n 1)

    # Check when password complexity is 2,if the password contains a digit, and generate a new one if not
    while [ $password_complexity -eq 2 ] && ! [[ $password =~ [[:digit:]] ]]; do
    	password=$(openssl rand -base64 "$password_strength" | tr -dc "$char_set" | fold -w "$password_length" | head -n 1)
    done


    # Check when password complexity is 3, if the password contains a digit and a special character, and generate a new one if not
    while [ $password_complexity -eq 3 ] && ! [[ $password =~ [[:digit:]] && $password =~ [[:punct:]] ]]; do
	password=$(openssl rand -base64 "$password_strength" | tr -dc "$char_set" | fold -w "$password_length" | head -n 1)
    done

   

   # Print username and password to console
    echo " "
    echo "Username: $username"
    echo "Password: $password"

    # Print username and password to file
    echo " " >> $output_file
    echo "$username:  $password" >> $output_file
done 


# Print success message
echo " "
echo "The list of user names and passwords has been saved successfully to the following file: $output_file"

