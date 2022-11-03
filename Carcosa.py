##
##Strange is the night where black stars rise,
##And strange moons circle through the skies
##But stranger still is
##Lost Carcosa
##
##Written by: ChickySticky
##


import base64
import os
import sys 
import random
import string
import subprocess

DOMAINPKCS = "carcosa.p12"
DOMAINSTORE = "carcosa.store"
WORKINGDIR = "/home/cpt"
CSLOCATION = WORKINGDIR + "/cobaltstrike"
CSPROFILE = CSLOCATION + "/httpsProfile"

def setup():
    ##Check Super User Status
    if os.geteuid() !=0:
        sys.exit("I had never yet done such a thing in life, but now I felt a desire to mock. \nPlease run Carcosa as Sudo." )

    print ("IMPORTANT: Ensure you have downloaded certs from rproxy in /home/cpt/cobaltstrike/certs")
    input ("Press Enter to Continue")

    ##Check If Certs and Profile Folders Exists
    if not os.path.exists('/home/cpt/cobaltstrike/certs'):
        os.makedirs('/home/cpt/cobaltstrike/certs')

    print("Creating certs Directory in Cobalt Strike...")

    if not os.path.exists('/home/cpt/cobaltstrike/httpsProfiles'):
        os.makedirs('/home/cpt/cobaltstrike/httpsProfiles')

    print("Creating httpsProfiles Directory in Cobalt Strike...")

    ##List All Profiles Inside Carcosa and Make Selection
    print("Please Select a Profile to Use...")

    profiles = os.listdir('/home/cpt/Carcosa/Profiles')
    fileList = [name for name in profiles if name.endswith(".profile")]

    for cnt, fileName in enumerate(fileList, 1):
        print(f"[{cnt}] {fileName}")

    choice = int(input(f"Select Profile [1-{cnt}]: ")) -1
    print(fileList[choice])
    print("Loading Selected Profile")
    

def inject():
    ##Take Profile Choice and Inject SSL Cert into Profile

    #Randomize Password
    PASSWORD = ''.join(random.choice(string.printable) for i in range (16))

    print("[Starting] Building PKCS12 .p12 cert.")
    
    subprocess.run (["openssl", "pkcs12", "-export", "-in fullchain*.pem", "-inkey privkey*.pem", "-out " + DOMAINPKCS, "-name \"carcosa\"", "-passout pass: " + PASSWORD])

    
