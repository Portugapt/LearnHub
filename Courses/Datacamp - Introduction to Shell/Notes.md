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
