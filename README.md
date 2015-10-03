Calias
============
2015-10-03



What is it?
-------------------

Calias is a bash script that makes a command available system wide rapidly.

It will automatically create a symlink for you and put it in your /usr/local/bin directory.<br>
The -v option is verbose


Usage
----------- 

```bash
calias <realScript> <symlinkName>

# example
calias moderator.sh mymod
```
 
Options
-------------

	-v: turn verbose mode on
	-f: if turned on, will remove any existing symlink with path <symlinkName>
 


How to use
----------------

1. Put the calias.sh script in your /usr/local/bin directory and rename it calias.
2. Ensure calias has the execute permission.
3. Now you can use it:
			calias <file> <alias>
			calias myscript.sh myscript
