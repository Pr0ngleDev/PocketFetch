import strutils # for editing the strings osproc returns
import osproc # for executing commands
import terminal # for color options
import os # for working with terminal on collecting flags
import times # for getting current times
import math # for formatting storage
import sequtils # for formatting printed info

# Pragmas to ensure user doesn't have to run flags on compile
{.checks: off, optimization: speed.} # Turn off all runtime checks and optimize code for speed
{.hints: off, warnings: off.} # Turn off all hints and warnings because the user doesn't need to see my mistakes
{.passC: "-flto".} # turn on link-time optimization
{.passL: "-s".} # strip executable of symbols to ensure minimal size

let args = commandLineParams() # define list of flags for future ease of use

# flags
if args.len > 1:
  echo "Please use only one argument" # we only want one color to be used
  quit(1)
elif args.len == 0:
  setForegroundColor(fgBlack) # if there are no args, the text will be in an ugly black
else:
  case args[0]
  of "-h": # help message
    echo """
        Cozycli 
        cozycli [options] 
        Options: 
          -h show this message 
          -r make the output red 
          -m make the output magenta 
          -b make the output blue 
          -w make the output greyish white 
          -c make the output cyan 
          -g make the output green 
          -y make the output yellow
        """
    quit(1)
  of "-r":
    setForegroundColor(fgRed)
  # -r makes the output red
  of "-m":
    setForegroundColor(fgMagenta)
  # -m makes the output magenta
  of "-b":
    setForegroundColor(fgBlue)
  # -b makes the output blue
  of "-w":
    setForegroundColor(fgWhite)
  # -w makes the output white
  of "-g":
    setForegroundColor(fgGreen)
  # -g makes the output green
  of "-c":
    setForegroundColor(fgCyan)
  # -c makes the output cyan
  of "-y":
    setForegroundColor(fgYellow)
  # -y makes the output yellow
  else:
    echo "Unknown flag submitted. Please execute with -h for help"
    quit(1)

# collect system info, using procs to make the code more readable

# Current user
proc getUsername(): string {.inline.} =
  execProcess(r"echo $USER").replace("\n", "")

# Current Host
proc getHostname(): string {.inline.} =
  execProcess("hostname").strip()

# Storage info
proc getStorageInfo(): string {.inline.} =
  let avail =
    parseInt(execProcess(r"df -m --output=avail / | tail -n +2").strip()) div 1000
  let size =
    parseInt(execProcess(r"df -m --output=size / | tail -n +2").strip()) div 1000
  return " Storage: " & $avail & "GB out of " & $size & "GB"

# Current user shell
proc getShell(): string {.inline.} =
  execProcess(r"echo $SHELL")[5 .. 8]

# Time in UTC. I have not found how to use user's time zone
proc getCurrentTime(): string {.inline.} =
  " It's " & $now().format("hh:mm") & " UTC on this wonderful " &
    now().format("dddd").strip()


# collect system information
let usersplace: string = getUsername() & "@" & getHostname()
let storage: string = getStorageInfo()
let currentshell: string = " Shell: " & getShell()
let time = getCurrentTime()

# formatting for the place to print the info
let info = @[usersplace, storage, currentshell, time]
let maxLength = info.mapIt(it.len).max + 1 # find the length of the longest variable
let line = repeat("_", maxLength)
  # assign an underscore (the top and bottom of the box) for each character of the longest string
let diffSpaces = info.mapIt(maxLength - it.len)
  # add spaces for each thing that is not maxLength, for formatting purposes
let spaces = diffSpaces.mapIt(repeat(" ", it))

var infoWithSpaces = newSeq[string]()
for i in 0 ..< info.len:
  infoWithSpaces.add(info[i] & spaces[i]) # format diffSpaces into a usable format

# printing info to console
echo " " & line
for i in 0 ..< info.len:
  echo "|" & info[i].center(maxLength) & "|"
echo r"|" & line & r"|"
