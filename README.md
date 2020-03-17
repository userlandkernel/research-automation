# Research Automation
Automates your research with scripts.  
Check out tutorials and documentation [here](https://github.com/userlandkernel/research-automation/tree/master/docs) 


## fwbrowse (BASH)
iOS Firmware browser.  
Provided an iOS Version and Device Identifier this script automatically retrieves the corresponding firmware url from ipsw.me.  
It will automatically launch partial zip browser (from t1hmstar) so you can choose what files you want to download.  


## jtool2c (BASH)
Uses jtool2 to generate a c file for using iOS kernel symbol offsets  
If jtool2 is not installed it will download it and install it into ```/usr/local/bin```  
Usage is simple, pass it an uncompressed kernelcache and it will generate the c files for you  

## dumpbootargs (BASH)
Retrieves all boot-arguments from the iOS kernel  
Usage is simple, pass it a compressed/uncompressed kernelcache and it will save the list of boot-arguments in ```bootargs.txt```  

## iokitrev.py (IDA, WIP)
Retrieves code from userland proceses that make calls to userclients of IOKit drivers and Families.  
This is the best approach to reverse kernel driver userclients their selectors.  
The script is lazily written, it should be updated by someone who knows idapython a bit better.  
Usage: In IDA choose ```File>Script File...``` and choose ```iokitrev.py```, output will be in the IDA console.  

## update-xnu.sh (BASH)
Retrieves, extracts and commits the latest XNU tarball from opensource.apple.com to a git repository.  
Usage is simple, change the git configuration in the script to your own repository and run it.  

## sqlite3dump (BASH)
Prints out an SQLite3 database in a human readable format.  
No need to know the tables or whatsoever, the script will figure these out.  
Usage is simple, provide a path to a SQLite3 database and the script will print it out nicely.

## nano (GNU Nano)
This directory contains syntax files for use with nano.  
Install them into /usr/share/nano/

## Special info
On ARMv7 (32-bit) devices Apple has a JTAG interface that can be enabled through a boot arg (dcc=1) [See more here](https://github.com/UKERN-Developers/darwin-xnu/blob/6ea0ae33271d25e3e29ae0431068f3f3faeda9a3/pexpert/arm/pe_serial.c#L846)  
The boot arg is still present on ARM64 devices but will lead to a panic as it is unimplemented. [See more here](https://github.com/UKERN-Developers/darwin-xnu/blob/6ea0ae33271d25e3e29ae0431068f3f3faeda9a3/pexpert/arm/pe_serial.c#L173)  
I hope some of you might find this interesting as it should allow a DCSD cable to perform JTAG via DCC, goodby expensive Kanzi requirements :)
