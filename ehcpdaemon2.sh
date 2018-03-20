#!/bin/bash
# This small shell is written to re-run php based daemon in case of failure.. 
# because php based daemon quits sometime ocasionally or un-expectedly...

echo "running ehcp daemon in shell background..."

function check_program(){
		php -l $1
		if [ $? -ne 0 ] ; then
			echo "ehcp -> programda hata var: $1" | sendmail "my_ehcp_setup_AT_admin_email.com"
		fi
}

hatasayisi=0

function check_programs(){
	for i in *.php config/*.php language/*.php
	do	
		php -l $i
		if [ $? -ne 0 ] ; then
			echo "Error - Hata : $i " 
			echo "ehcp -> programda hata var: $i   " > email
			php -l $i 2>&1 >> email			
			cat email | sendmail "my_ehcp_setup_AT_admin_email.com"

			let hatasayisi=hatasayisi+1
			if [ $hatasayisi > 5 ] ; then
				echo "Too many errors, check your system or re-download ehcp. You may have problem in php configuration/installation"
				exit
			fi			
		fi
		
		sayi=`grep "<?php" $i | wc -l`
		if [ $sayi -eq 0 ] ; then
			echo "Dikkat! php dosyasinda <?php tagi yok."
			#exit
		fi
	done

}


# Changed the way this works by using a function that respawns the php script if it exits.
# Changed by:  earnolmartin@gmail.com
function startPHPDaemon(){
	cd /var/www/new/ehcp
	until php index.php daemon ; do
	echo "Server php index.php daemon crashed with exit code -1.  Respawning..." >&2
	sleep 3
	done
	startPHPDaemon
}
cd /var/www/new/ehcp
check_programs

# Start the initial loop
startPHPDaemon
