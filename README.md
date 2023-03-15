# task_interview

The user-generator.sh file generates a list of users. The number of users generated can be set in the script. It uses the https://names.drycodes.com/ API to extract the names.
Once generated, it is printed to the console, and saved to a file. The file by default is named user_list, unless the file name is specified as an input.
One user per line is printed, in order to facilitate the password generating process. Each underscore is replace by a space, to facilitate the clearness of data.

Before running the script, we must ensure that the file is executable by running the following command: chmod +x user-generator.sh

To run the script, write the following command: ./user-generator <users> where users is the file name that will store the list of users. Please note that <users> is 
not mandatory, and a default name will be associated to the generated file if no input was given.


The password-generator.sh file requires an input (The file generated through user-generator.sh). It then computes a password for each user, as it has been specified that each user 
is on a seperate line. It uses different complexity levels that were set in code. It then prints each user and its associated password to the console. It also prints
it onto another file. By default, the name of the file generated is called password_file , but this could be set by the user, by inputting the file name while running the command.
OpenSSL is used to generate the password based on different factors: Password complexity, password length, and password strength. 
For complexity levels, a loop is created to ensure that each password fits the criterea. As long as it doesn't fit such criteria, a new password must be generated. 

Before running the script, we must ensure that the file is executable by running the following command: chmod +x password-generator.sh

To run the script, write the following command: ./password-generator <users> <pw-file> where <users> is the file name generated in 'user-generator', and <pw-file> is 
file name for the generated passwords. Please note that <pw-file> is not a mandatory input, and a default name will be given to the password file if no input was given.




