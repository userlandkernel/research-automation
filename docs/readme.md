# Documentation and Tutorials

## Tutorial: Kernel caches
This tutorial teaches you how to analyze a kernelcache.  
Reasons for this can be that you want to reverse engineer a driver that's part of the IOKit or find a bug in an MIG generated routine.  
It can also be that you want to generate offsets for use with a new jailbreak, that's great too.  

### Dependencies
- brew (https://brew.sh), a package manager for macOS
- jq (brew install jq), a json parser command-line utility
- jtool2 (https://newosxbook.com/files/jtool2.tgz), an analysis tool for mach-o binaries
- joker (https://newosxbook.com/files/joker.tar), a kernel and kernel extension extraction tool
- pzb (https://github.com/tihmstar/partialZipBrowser), a pain in the ass to compile because tihmstar doesn't check dependencies

### 1. Retrieving the kernelcache for your device
In this repository you can find a tool called ```fwbrowser```.  
It works very simple, you give it an iOS version (13.2.2) and an iOS Device (ex: iPhone8,1).  
```bash
./fwbrowser 13.2.2 iPhone8,1
```
Then the firmware browser will contact the API at ipsw.me.  
Next it opens tihmstar's partialzip browser on the retrieved firmware url.  
It will take some time to initialize, and when it's done you will get a shell.  

```
$ 


```

All you now have to do is simply type ls to list files in the remote firmware.  
```
$ ls
         0 d Firmware/
    264948 f BuildManifest.plist
      1385 f Restore.plist
  16940283 f kernelcache.release.n71
 104569371 f 048-90336-109.dmg
 101779483 f 048-90011-109.dmg
3522328971 f 048-90083-104.dmg
```

Now to get the kernelcache you just choose the one matching your device (ex: n71):  
```
$ get kernelcache.release.n71
getting: kernelcache.release.n71
100% [===================================================================================================>]
download succeeded
```

And to finish with when it has downloaded you type
```
$ exit


```

You now have the kernelcache in your current directory, but its LZSS-compressed.  
To analyze the kernelcache we will use jtool2.  
jtool2 will automatically decompress the kernel and it can be helpful in symbolication of the stripped kernels.  
To analyze the kernelcache you need to type:
```bash
jtool2 --analyze kernelcache.release.n71
```
You now have a .ARM64 file which contains the symbols that jtool2 could retrieve.  
However the kernelcache is still compressed so you cannot load it into a disassembler to start reverse engineering.  
To decompress the kernelcache you can use the -dec flag while using jtool2
```bash
jtool2 -dec kernelcache.release.n71
```

jtool2 stores the decompressed kernelcache at /tmp/kernel
To move it to your current directory you can type mv /tmp/kernel ./kernelcache.release.n72.dec

From this point it is easy to work with the kernelcache.
Strings is broken on macOS when it detects unknown or invalid load commands, but you can still use a trick to get the strings.  
```bash
cat kernelcache.release.n71.dec | strings > kernel_strings.txt
```

Now if you want to work with kexts we can use joker, joker can extract them for us.
To do that we provide joker the **decompressed** kernelcache.  
```bash
joker -K all kernelcache.release.n71.dec
```
That will extract all kernel extensions to /tmp/ and also generate .ARM64 symbol files for them there.  
I generally create a folder named kexts in the current directory and move everything from /tmp to there.  
```bash
mv /tmp/*.kext* ./kexts/
```

With all kexts and symbol files in the kexts directory we can start the real analysis.  
jtool2 can help with disassembly of kexts.  
But since the kexts were extracted with joker which is old and jtool2 does not fully have kext extraction working yet we must add the kernel symbols from the kernel's .ARM64 file to all .ARM64 files of the kexts.  
Why? You may ask. It's because the kexts use the symbols from the kernel most of the times.  
Because the .ARM64 are very logically structured it takes a simple command to add the symbols to all kexts:
```bash
for kext in kexts/*.kext.ARM64.*; do 
         cat kernelcache.release.n71.ARM64.* >> $kext;
done
```

From this point we have all kernel extensions in one directory useful to be disassembled by a disassembler.  
jtool2 can disasemble the kexts and the kernel, radare2 and Ghidra may do a better job.  
For those who are used to it I can recommend IDA, it is not free software and highly expensive but a true swiss army knife.  Scripting in IDA python is pretty easy to learn and it can speed up your general research a lot.  
