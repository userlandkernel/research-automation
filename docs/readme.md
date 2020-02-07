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
