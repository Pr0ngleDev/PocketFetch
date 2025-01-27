# Pocket Fetch
PocketFetch is a tiny, very fast, and simple fetch program writen in the Nim programming language.

### Overview
PocketFetch fetches hostname, free storage, and time and date on systems using bash. There are several color customazation options that can be run as flags. 

### Installation

Ensure you have Nim installed on your system. On Debian based systems, one can use `apt install nim`. Other systems can use `choosenim` for the install   

Download the repo with

`git pull https://github.com/Pr0ngleDev/pocketfetch`

Next, move into the PocketFetch directory

`cd pocketfetch/src/`

Compile using

`nim c pocketfetch.nim`

When you run `ls`, you should see a file named `pocketfetch`, without any file extension. This is a binary file, and it can be run by putting the file name in the terminal

Test the executable by running `./pocketfetch`

If no error pops up, you are ready to use pocketfetch like a command. Execute 

`sudo ln -s "$(pwd)/pocketfetch" /usr/local/bin/pocketfetch`

You can now run PocketFetch by simply running `pocketfetch`

### How to use

PocketFetch can be run in a variety of different colors. Use the `-h` flag when running the file to list all of them. The text will be black if no flag is used.

### Stats I'm proud of

PocketFetch only uses 82 SLoC

The executable is only 257 kilobytes 

The compile time is 4 seconds 

Real execution time is **0.013 seconds**
