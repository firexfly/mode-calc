# mode-calc

Calculate the mode of a data set, stored in a file or input from your keyboard.

# Use:

To use mode-calc simply run the program on the command line providing a file (containing your data) as input:

`./mode-calc data`

If no file is provided on the command line, the program will prompt the user for data:

`./mode-calc`
>Please enter data set below, separated by spaces:
>
>1 2 2 3 4

# Output:

The program will output a table with the data followed by a statement telling you what the mode is or if there are multiple, there will be a space separated list of modes.

>1	=>	1

>2	=>	2

>3	=>	1

>4	=>	1

>The mode is: 2

>\-----------------------------------------

# Unexpected input

The program should not run if the user inputs any unexpected data; for example if there is no data or non numeric data is provided. If the input came from the keyboard, the user will be prompted to retry immediately; if the input came from a file, the program will stop running and warn the user.
