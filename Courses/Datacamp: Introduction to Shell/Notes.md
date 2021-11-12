- [Manipulating files and directories](#manipulating-files-and-directories)
- [Sheet of commands](#sheet-of-commands)
- [Notes](#notes)
  - [Can I stop a running program?](#can-i-stop-a-running-program)
- [Combine commands](#combine-commands)
- [Wildcards](#wildcards)
  - [*](#)
  - [Other wildcards](#other-wildcards)
- [Do many things in a loop](#do-many-things-in-a-loop)
- [Create a file with `nano`](#create-a-file-with-nano)
- [Save commands history and rerun them](#save-commands-history-and-rerun-them)
- [Parameters in a bash file](#parameters-in-a-bash-file)
- [Re-run piles](#re-run-piles)

# Manipulating files and directories 

https://campus.datacamp.com/courses/introduction-to-shell/manipulating-files-and-directories?ex=1

# Sheet of commands

```bash

# current working directory
pwd # print working directory

# find out what's there
ls # listing
# e.g ls /home/repl
# ls *.filextention # relative path to files
# ls path/to/folder # relative path to folder (and objects in it)
# flags:
# -R (Recursive) will print everything below a directory.
# -F prints a / after the name of every directory (know what is what)

# move around files
cd # change directory

.. # the directory above the one I'm currently in

. # the current directory

~ # your home directory

# If I want to copy files
cp # copy
# e.g. cp original.txt duplicate.txt
# e.g. cp seasonal/spring.csv seasonal/summer.csv backup will copy these two files to backup folder (assumed it exists in current path)

# If I want to move files (or rename them)
mv # move
# e.g. seasonal/spring.csv seasonal/summer.csv backup
# mv course.txt old-course.txt | This renames the file

# If I want to delete files
rm # remove
# Same logic as cp and mv (can add as much files as wanted)

# If I want to remove a folder/directory
rmdir # remove directory
# Caveat: It has to be empty.

# If I want to create a folder/directory
mkdir # make directory
# Same logic as above.

# If I want to view a file's content
cat # concatenate
# e.g. cat course.txt

# If I cwant to view content piece by piece
# Used to be more now is
less # ...
# e.g. less seasonal/spring.csv
# Pressing n to go to second file,
# or q to quit

# If I just want to look at the start of file
head # head
# Outputs the first 10 lines/rows of a file

# If I want to auto-complete a file name
# Press tab (tab completion)

# If I want to control what a command does
# e.g.
head -n 3 # -n is number of lines
# -n is a command-line flag.
#Note: it's considered good style to put all flags before any filenames.
# flags:
# -n  [NUMBER OF LINES]

# If I want the manual
man # manual
# e.g. man head

# If I want to select a column from a file
cut
# flags
# -f Fields (e.g. columns 1 and 2: -f (1,2 or 1-2))
# -d delimiter (e.g. ,)

# If I want to see the history of commands
history

# If I want to rerun a command
# Either press key arrow up
# or use ![COMMAND] to rerun the most recent use of that command
# Or !1 to rerun the argument ID'd with 1

# If I want to return patterns in text
grep 
# e.g. grep -c incisor seasonal/autumn.csv seasonal/winter.csv to count the number of lines "incisor" appears in both files.

# If I want to store the results in a file
head -n 5 seasonal/winter.csv > top.csv
# Stores the results in top.csv

# If I want the number of words in a file
wc # word count
# prints the number of characters, words, and lines in a file
# with the flags -c, -w or -l

# If I want to sort lines of text
sort
# e.g. cut -d , -f 2 seasonal/spring.csv | grep -v Tooth | sort -r

# If I want to know the saved commands?
set 

# If I want to define a new local variable in the shell
name_of_variable = value_of_varialbe
# to call is $name_of_variable

# If I want to repeat commands
for filetype in gif jpg png; do echo $filetype; done

```

# Notes

The shell decides if a path is **absolute** or **relative** by looking at its first character: If it begins with `/`, it is absolute. If it does not begin with `/`, it is relative.

Anything that is optional is shown in square brackets `[...]`, either/or alternatives are separated by `|`, and things that can be repeated are shown by `...`

with `Paste`, joining the lines with columns creates only one empty column at the start, not two.

The greater-than sign `>` tells the shell to redirect head's output to a file. It isn't part of the head command; instead, it works with every shell command that produces output.

## Can I stop a running program?
<kbd>Ctrl</kbd> + <kbd>C</kbd>   

This is often written ^C in Unix documentation; note that the 'c' can be lower-case.

# Combine commands

Using the `|` pipe symbol

E.g.  
`head -n 5 seasonal/summer.csv | tail -n 3`  
`cut -d , -f 2 seasonal/summer.csv | grep -v Tooth`

Or  
`wc -l seasonal/*.csv | grep -v total | sort -n | head -n 1`
which will retun the file with the least amount of records.


# Wildcards

## *
Use wildcard character `*` to match 0 or more characters in a file.
e.g `head seasonal/s*.csv` or `head seasonal/*.csv`

## Other wildcards

* `?` matches a single character, so `201?.txt` will match `2017.txt` or `2018.txt`, but not `2017-01.txt`.

* `[...]` matches any one of the characters inside the square brackets, so `201[78].txt` matches 

* `{...}` matches any of the comma-separated patterns inside the curly brackets, so `{*.txt, *.csv}` matches any file whose name ends with `.txt` or `.csv`, but not files whose names end with `.pdf`


# Do many things in a loop

Be careful for the `;` character.

With the code example  
`for f in seasonal/*.csv; do echo $f; head -n 2 $f | tail -n 1; done`  
the result is
```
seasonal/autumn.csv
2017-01-05,canine
seasonal/spring.csv
2017-01-25,wisdom
seasonal/summer.csv
2017-01-11,canine
seasonal/winter.csv
2017-01-03,bicuspid
```

# Create a file with `nano`

e.g.  
`nano names.txt`


# Save commands history and rerun them

```bash
history | tail -n 3 > steps.txt
```

`nano dates.sh`  
`cut -d , -f 1 seasonal/*.csv`  
`bash dates.sh`

A file full of shell commands is called a ***shell script**, or sometimes just a "script" for short. Scripts don't have to have names ending in .sh, but this lesson will use that convention to help you keep track of which files are scripts.

Can also direct the output to a file
e.g.   
`bash teeth.sh > teeth.out`

# Parameters in a bash file  

To support this, you can use the special expression $@ (dollar sign immediately followed by at-sign) to mean "all of the command-line parameters given to the script".

`count-records.sh`
```bash
tail -q -n +2 $@ | wc -l
```

then run the command  
`bash count-records.sh seasonal/*.csv > count.out`

As well as `$@`, the shell lets you use `$1`, `$2`, and so on to refer to specific command-line parameters. You can use this to write commands that feel simpler or more natural than the shell's. For example, you can create a script called `column.sh` that selects a single column from a CSV file when the user provides the filename as the first parameter and the column as the second:
`cut -d , -f $2 $1`

# Re-run piles

`example.sh`   
```bash
# Print the first and last data records of each file.
for filename in $@
do
    head -n 2 $filename | tail -n 1
    tail -n 1 $filename
done
```