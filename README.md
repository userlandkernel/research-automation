# Research Automation
Automates your research with scripts
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
