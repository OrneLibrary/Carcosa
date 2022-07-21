#
#
#Artfully Stolen and Edited by: @ChickySticky
#
#

if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root" 1>&2
    exit 1
fi

echo -n "IMPORTANT: Ensure you have downloaded certs from rproxy and place in /home/cpt/certs"
echo ""
echo -n "NOTE:  Traffic profiles should only be added to https communications!"
echo ""
read -p "Enter your DNS (A) record for domain [ENTER]: " -r domain
echo ""
read -p "Enter your common password to be used [ENTER]: " -r password
echo ""
workingdir="/home/cpt"
##check /root/cobaltstrike
cslocation="$workingdir/cobaltstrike"
read -e -i "$cslocation" -p "Enter the folder-path to cobaltstrike [ENTER]: " -r cobaltStrike
cobaltStrike="${cobaltStrike:-$cslocation}"
echo

domainPkcs="$domain.p12"
domainStore="$domain.store"
cobaltStrikeProfilePath="$cobaltStrike/httpsProfile"

## Make Directory in Gold Image $workingdir/certs
cd /home/cpt/certs/$domain
echo '[Starting] Building PKCS12 .p12 cert.'
openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out $domainPkcs -name $domain -passout pass:$password
echo '[Success] Built $domainPkcs PKCS12 cert.'
echo '[Starting] Building Java keystore via keytool.'
keytool -importkeystore -deststorepass $password -destkeypass $password -destkeystore $domainStore -srckeystore $domainPkcs -srcstoretype PKCS12 -srcstorepass $password -alias $domain
echo '[Success] Java keystore $domainStore built.'
mkdir $cobaltStrikeProfilePath
cp $domainStore $cobaltStrikeProfilePath
echo '[Success] Moved Java keystore to CS profile Folder.'
cd $cobaltStrikeProfilePath
echo '[Starting] Cloning into youtube.profile for testing.'
wget https://github.com/OrneLibrary/Carcosa/blob/main/youtube.profile --no-check-certificate -O youtube.profile
##wget https://github.com/OrneLibrary/Carcosa/blob/main/youtube.profile --no-check-certificate -O youtube.profile    
echo '[Success] youtube.profile cloned.'
echo '[Starting] Adding java keystore / password to youtube.profile.'
echo " " >> youtube.profile
echo 'https-certificate {' >> youtube.profile
echo   set keystore \"$domainStore\"\; >> youtube.profile
echo   set password \"$password\"\; >> youtube.profile
echo '}' >> youtube.profile
echo '[Success] youtube.profile updated with HTTPs settings.'
##echo '[Starting] Adding java keystore / password to oscp.profile.'
##echo " " >> ocsp.profile
##echo 'https-certificate {' >> ocsp.profile
##echo   set keystore \"$domainStore\"\; >> ocsp.profile
##echo   set password \"$password\"\; >> ocsp.profile
##echo '}' >> ocsp.profile
##echo '[Success] ocsp.profile updated with HTTPs settings.'

