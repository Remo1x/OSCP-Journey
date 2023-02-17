#!/bin/bash

echo "Welcome To Rem01x DNS Enumeration Tool"
echo "                  =================================================="
        echo "            #     Please Select A Tool To Enumerate With     #"  
        echo "            #     1)dnsenum                                  #"
        echo "            #     2)dnsrecon                                 #"
        echo "            #     3)FLP (Forward Lookup)                     #"
        echo "            #     4)RLP (Reverse Lookup)                     #"
        echo "            #     5)ZoneT (Zone Transfer)                    #"
echo "                  =================================================="
if [ -z "$1" ] 
then
        echo "Usage: $0 <Tool Name>"

else

if [ $1 == "dnsenum" ]
then
        echo "Please Enter The Domain Name You Wanna Enumerate :)"
        read domain
        echo "Please Enter The Path To The Wordlist"
        read list
        dnsenum -d $domain -D $list -t brt



elif [ $1 == "dnsrecon" ]
then
        echo "Please Enter The Domain Name You Wanna Enumerate :)"
        read domain
        dnsrecon -d $domain -t axfr


elif [ $1 == "FLP" ]
then
        echo "Please Enter The Domain To Make Forward Lookup"
        read domain
        host -t A $domain
        echo "Do You Wanna Do Forward Lookup Brute Force Y/N"
        read answer
        if [ $answer == "Y" -o  $answer == "y" ]
        then
                echo "Please Enter The Path To The Wordlist You Want"
                read list
                echo "[*] BruteForcing..." 
                for word in $(cat $list);do host -t A $word.$domain | grep -v "not found" | grep $domain;done 
        else
                echo "Okay Have A Nice Time Sir :)"
        fi

elif [ $1 == "RLP" ]
then
        echo "Please Enter The IP To Make Reverse Lookup"
        read IP
        host -t PTR $IP
        echo "Do You Wanna Do Reverse Lookup Brute Force Y/N"
        read answer
        if [ $answer == "Y" -o $answer == "y" ]
        then
                echo "Please Enter The First 3 Places In The IP EX:192.168.1"
                read IP
                echo "[*] BruteForcing..."
                for i in {1..255};do host -t PTR $IP.$i |grep -v "not found" ;done
        else
                echo "Okay Have A Nice Time Sir"
        fi


elif  [ $1 == "ZoneT" ]
then
        echo "Please Enter The Domain Name To Make Zone Transfer"
        read domain
        for ns in $(host -t ns $domain | cut -d " " -f 4);do host -l $domain $ns | grep "has address";done

else
        echo "Please Select A Valid Input :)"
fi
fi
