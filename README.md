# Research Automation
Automates your research with scripts

## jtool2c
Uses jtool2 to generate a c file for using iOS kernel symbol offsets  
If jtool2 is not installed it will download it and install it into /usr/local/bin  
Usage is simple, pass it an uncompressed kernelcache and it will generate the c files for you  

## dumpbootargs
Retrieves all boot-arguments from the iOS kernel  
Usage is simple, pass it a compressed/uncompressed kernelcache and it will save the list of boot-arguments in bootargs.txt  

