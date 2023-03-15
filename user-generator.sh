#!/bin/bash

#Define API and parameters
API_URL="https://names.drycodes.com/"
params_boy="?nameOptions=boy_names"
params_girl="?nameOptions=girl_names"


#Set the number of users to retrieve
num_users=15


# Set default output file name if one is not provided
output_file=${1:-user_list}

# Make API request to extract boy and girl names
boy_names=$(curl -s "${API_URL}${num_users}${params_boy}")
girl_names=$(curl -s "${API_URL}${num_users}${params_girl}")

# Extract all elements in the boy and girl name arrays
boy_names_array=($(echo "$boy_names" | tr -d '[]"\n' | sed 's/_/ /g'  ))
girl_names_array=($(echo "$girl_names" | tr -d '[]"\n' | sed 's/_/ /g' ))

#Concatenate the girl and boy name array
usernames="${girl_names_array[*]},${boy_names_array[*]}"
 
#Replace comma with new lines
usernames=$(echo "$usernames" | tr ',' '\n')

# Print success message
echo " "
echo "Names written to file "$output_file" "
echo " "


#Print user names into file while overriding previous data stored in there. 
echo "$usernames" > $output_file


#Print in console
echo "$((num_users * 2)) users have been generated below: "
echo " "
echo "$usernames"

