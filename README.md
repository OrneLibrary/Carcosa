# Carcosa
C2 Profiles for Cobalt Strike


Things to think about when setting flags

You could change dns_idle to target DNS to blend in better

If you know the useragent of target, change to that:
http://www.useragentstring.com/pages/useragentstring.php

Recommended Spawnto: armsvc, SearchIndexer, conhost, MpCopyAccelerator, SearchApp, userinit or just use something that blends in

Sysinternals has a command you can run to look at SMB pipe names to blend in better
sysinternals: handle.exe -a | findstr /i namedpipe
DO NOT USE AN EXISTING NAMEDPIPE, BEACON DOESN'T CHECK FOR CONFLICTS!

spawnto also has spawnto_x86 and spawnto_x64, default is rundll32.exe, do better than that


## **Get Requests**

You can set multiple URIs for the profile with a space. Cobalt Strike will randomly assign a URI to each host when it checks in. No URIs can be duplicated between http-get and http-post; all URIs must be unique. Recommend 10 once you get it working. 

The compiled http-get client request size must be less than 252 bytes to be considered stable

4 encoding types:

base64

nqveOtUC+NlNAyHPVkSLMA==

base64url

hf2D_5jHAA9ftoOe_ZY3zQ

netbios 

haklhhicanfeldpmgkefkhgjmhccgbmp

netbiosu 

HHHHGLGDJDELLEKFMDKAANJCLHIEFEMC