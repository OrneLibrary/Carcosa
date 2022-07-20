#Carcosa

# C2 Profiles for Cobalt Strike


## Things to think about when setting flags

Change these settings to better blend into your environment:

dns-beacon.dns_idle
dns-beacon.maxdns
useragent
    http://www.useragentstring.com/pages/useragentstring.php
post-ex.spawnto_x86
post-ex.spawnto_x64

Recommended Spawntos: armsvc, SearchIndexer, conhost, MpCopyAccelerator, SearchApp, userinit or just use something that blends in with the environment. Don't just run something that's not on the box, unless you want to get caught. Default is rundll32 and will definitely get you caught.

Sysinternals has a command you can run to look at SMB pipe names to blend in better
sysinternals: handle.exe -a | findstr /i namedpipe
DO NOT USE AN EXISTING NAMEDPIPE, BEACON DOESN'T CHECK FOR CONFLICTS!

## **Get Requests**

You can set multiple URIs for the profile with a space. Cobalt Strike will randomly assign a URI to each host when it checks in. No URIs can be duplicated between http-get and http-post; all URIs must be unique. Recommend 5-10 once you get it working. 

The compiled http-get client request size must be less than 252 bytes to be considered stable

4 encoding examples:

base64

nqveOtUC+NlNAyHPVkSLMA==

base64url

hf2D_5jHAA9ftoOe_ZY3zQ

netbios 

haklhhicanfeldpmgkefkhgjmhccgbmp

netbiosu 

HHHHGLGDJDELLEKFMDKAANJCLHIEFEMC