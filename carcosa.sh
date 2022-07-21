#
#Strange is the night where black stars rise,
#And strange moons circle through the skies
#But stranger still is
#Lost Carcosa
#
#Written by: @ChickySticky
#

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root" 1>&2
    exit 1
fi

echo -n "IMPORTANT: Ensure you have downloaded certs from rproxy and place in /home/cpt/cobaltstrike/certs"
read -p "Press [Enter] key to continue..."


if test -f /home/cpt/cobaltstrike/certs/privkey*; then
    echo "Good Job, You Added the Certs!!!"
else    
    echo "You Didn't Add the Certs Did You?"
    exit 1
fi 

workingdir="/home/cpt"
##check /root/cobaltstrike
cslocation="$workingdir/cobaltstrike"
echo

domainPkcs="carcosa.p12"
domainStore="carcosa.store"
cobaltStrikeProfilePath="$cslocation/httpsProfile"

cd /home/cpt/cobaltstrike/certs
echo '[Starting] Building PKCS12 .p12 cert.'
Password=$(openssl rand -hex 10 | base64)
openssl pkcs12 -export -in fullchain*.pem -inkey privkey*.pem -out $domainPkcs -name "carcosa" -passout pass:$Password
echo '[Success] Built $domainPkcs PKCS12 cert.'
echo '[Starting] Building Java keystore via keytool.'
keytool -importkeystore -deststorepass $Password -destkeypass $Password -destkeystore $domainStore -srckeystore $domainPkcs -srcstoretype PKCS12 -srcstorepass $Password -alias "carcosa"
echo '[Success] Java keystore $domainStore built.'
mkdir $cobaltStrikeProfilePath
cp $domainStore $cobaltStrikeProfilePath
echo '[Success] Moved Java keystore to CS profile Folder.'
cd $cobaltStrikeProfilePath
echo '[Starting] Cloning into youtube.profile for testing.'
wget https://raw.githubusercontent.com/OrneLibrary/Carcosa/main/youtube.profile --no-check-certificate -O youtube.profile
##wget https://raw.githubusercontent.com/OrneLibrary/Carcosa/main/youtube.profile --no-check-certificate -O youtube.profile    
echo '[Success] youtube.profile cloned.'
echo '[Starting] Adding java keystore / password to youtube.profile.'
echo " " >> youtube.profile
echo 'https-certificate {' >> youtube.profile
echo   set keystore \"$domainStore\"\; >> youtube.profile
echo   set password \"$Password\"\; >> youtube.profile
echo '}' >> youtube.profile
echo '[Success] youtube.profile updated with HTTPs settings.'
##echo '[Starting] Adding java keystore / password to oscp.profile.'
##echo " " >> ocsp.profile
##echo 'https-certificate {' >> ocsp.profile
##echo   set keystore \"$domainStore\"\; >> ocsp.profile
##echo   set password \"$password\"\; >> ocsp.profile
##echo '}' >> ocsp.profile
##echo '[Success] ocsp.profile updated with HTTPs settings.'

