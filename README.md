Carcosa

Updated Carcosa Should be on the gold image. If you'd like to be sure it's the most up-to-date version of Carcosa
please `cd` into the Carcosa folder and type `git clone` 

*** IMPORTANT *** Ensure that the Certificates that you are going to use are in the correct location in the Cobalt Strike Folder
`/home/cpt/cobaltstrike/certs`

type `sudo python3 Carcosa.py` to run

Select one of the available profile options for SSL Certificate Injection  
Profiles are stored within the profiles folder `Carcosa/Profiles`

* amazon:                emulates web traffic to amazon (**operational**) 
* office365_calendar:    emulates web traffic to an office 365 calendar (**non-operational**) 
* reddit:                emulates web traffic to reddit (**operational**)  
* slack:                 emulates web traffic to a slack chat room (**non-operational**)  
* youtube:               emulates web traffic to youtube (**non-operational**)
* zoom:                  emulates web traffic for a zoom call (**operational**)  

You may now utilize the profile you selected as your Cobalt Strike Profile. It will be placed in `/home/cpt/cobaltstrike/httpsProfile`
