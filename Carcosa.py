##
##Strange is the night where black stars rise,
##And strange moons circle through the skies
##But stranger still is
##Lost Carcosa
##
##Written by: ChickySticky
##

import os
import sys 
import random
import string
import subprocess
import shutil

WORKINGDIR = "/home/cpt"
CSLOCATION = WORKINGDIR + "/cobaltstrike"
CSPROFILE = CSLOCATION + "/httpsProfiles/"
CERTS = CSLOCATION + "/certs/"
DOMAINPKCS = CERTS + "carcosa.p12"
DOMAINSTORE = CERTS + "carcosa.store"


def setup():
    ##Check Super User Status
    if os.geteuid() !=0:
        sys.exit("I had never yet done such a thing in life, but now I felt a desire to mock. \nPlease run Carcosa as Sudo." )

    print ("IMPORTANT: Ensure you have downloaded certs from rproxy in /home/cpt/cobaltstrike/certs")
    input ("Press Enter to Continue")

    ##Check If Certs and Profile Folders Exists
    if not os.path.exists(CERTS):
        sys.exit("I had never yet done such a thing in life, but now I felt a desire to mock. \nYou Must Create the Certs directory inside the Cobalt Strike Folder and Place Your SSL Certs into it.")

    print("Certs Are There!")

    if not os.path.exists(CSPROFILE):
        os.makedirs(CSPROFILE)

    print("Creating httpsProfiles Directory in Cobalt Strike...")

    ##List All Profiles Inside Carcosa and Make Selection
    print("Please Select a Profile to Use...")

    profiles = os.listdir('/home/cpt/Carcosa/Profiles')
    fileList = [name for name in profiles if name.endswith(".profile")]
    
    for cnt, fileName in enumerate(fileList, 1):
        print(f"[{cnt}] {fileName}")
    choice = int(input(f"Select Profile [1-{cnt}]: ")) -1
    profilename = fileList[choice]
    shutil.copyfile(f"/home/cpt/Carcosa/Profiles/{profilename}", f"{CSPROFILE}/{profilename}")

    return(profilename)
        
def inject(choice):
    ##Take Profile Choice and Inject SSL Cert into Profile
    os.chdir(CERTS)
    if os.path.exists('/home/cpt/cobaltstrike/certs/carcosa.store'):
        os.remove('/home/cpt/cobaltstrike/certs/carcosa.store')
    if os.path.exists('/home/cpt/cobaltstrike/carcosa.p12'):
        os.remove('/home/cpt/cobaltstrike/certs/carcosa.p12')

    #Randomize Password
    characters = string.digits + string.ascii_letters
    password = ''.join(random.choice(characters) for i in range (16))
        
    ##Building OpenSSL Cert and PKCS12
    print("[Starting] Building PKCS12 .p12 cert...")
    subprocess.run (f"openssl pkcs12 -export -in fullchain*.pem -inkey privkey*.pem -out {DOMAINPKCS} -name \"carcosa\" -passout pass:{password}", shell=True)
    print("[Success] Built DOMAINPKCS PKCS12 CERT!!!")
    
    ##Build Java Keystore and Add Password
    print("[Starting] Building Java keystore via keytool...")
    subprocess.run (f"keytool -importkeystore -deststorepass {password} -destkeypass {password} -destkeystore {DOMAINSTORE} -srckeystore {DOMAINPKCS} -srcstoretype PKCS12 -srcstorepass {password} -alias \"carcosa\"", shell=True)
    print("[Success] Java keystore DOMAINSTORE built")

    ##Inject Cert then Output Combined Profile
    
    httpscert = f"""\nhttps-certificate {{
    set keystore "{DOMAINSTORE}";
    set password "{password}"; \n}}
    """
    os.chdir(CSPROFILE)
    with open(choice, "a") as fp:
        fp.write(httpscert)
        fp.close()
    
    return("Your Profile is Built, Please use the Profile You Selected for Cobalt Strike")

def main():
    choice = setup()
    print("Loading Selected Profile")
    inject(choice)

if __name__ == "__main__":
    main()