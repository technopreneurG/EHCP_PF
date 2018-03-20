#!/bin/bash
# ehcp - Easy Hosting Control Panel install/remove by info@ehcp.net (actually, no remove yet)
# this is a basic shell installer, real installation in install_lib.php, which is called by install_1.php, install_2.php
#
# please contact me if you made any modifications.. or you need help
# msn/email: info@ehcp.net
# skype/yahoo/gtalk: bvidinli
#
# Main Developer: info@ehcp.net
# Marcel <marcelbutucea@gmail.com>
#	   - added initial support for yum (RedHat/CentOS) (not working now)
#	   - some code ordering, documentation and cleanup
#
# by earnolmartin@gmail.com : many fixes,
# by own3mall@gmail.com : many fixes,
# (Looking for other volunteer developers.. in future, maybe, we may have some budget... )
# last modified by ehcpdeveloper on 1.11.2014 (d-m-y)


ehcpversion="0.37.4.b"
emailenable=true  # write true/false lowercase for bash.. 

echo
echo
#echo "Please Wait... initializing.a	  If something is very slow, please report on our site: ehcp.net"
echo
echo
chmod -Rf a+r *

for j in "noapt" "unattended" "light" ; # read some install parameters.
do
	if [ "$1" == "$j" -o "$2" == "$j" -o "$3" == "$j" ] ; then
		eval $j=$j  # set parameter noapt to that string... and so for others.
		echo "Parameter $j is set:(${!j}) "
	fi
done

if [ "$1" == "-y" -o "$2" == "-y" -o "$3" == "-y" ] ; then
	unattended="unattended"
	echo "Unattended Enabled... "
fi

################################################################################################
# Function Definitions																		 #
################################################################################################

# Stub function for apt-get

function installaptget () {
	echo "now let's try to install apt-get on your system."
	echo "Not yet implemented"
}


function check_programs(){
	for i in *.php
	do
		php -l $i > /dev/null
		if [ $? -ne 0 ] ; then
			echo "programda hata var: $i"
			exit
		fi
	done

}

# Stub function fot yum

function installyum () {
	echo "now let's try to install yum on your system."
	echo "Not yet implemented"
}

# Initial Welcome Screen

function ehcpHeader() {
	echo
	echo
	echo "STAGE 1"
	echo "====================================================================="
	echo
	echo "--------------------EHCP PRE-INSTALLER $ehcpversion -------------------------"
	echo "-----Easy Hosting Control Panel for Ubuntu, Debian and alikes--------"
	echo "-------------------------www.ehcp.net--------------------------------"
	echo "---------------------------------------------------------------------"
	echo
	echo
	echo "Now, ehcp pre-installer begins, a series of operations will be performed and main installer will be invoked. "
	echo "if any problem occurs, refer to www.ehcp.net forum section, or contact me, mail/msn: info@ehcp.net"
	echo
	echo "For automated installs, use $0 unattended (passwords are default in this case)"

	echo "Please be patient, press enter to continue"
	echo
	if [ "$unattended" == "" ] ; then
		read
	fi

	echo
	echo "Note that ehcp can only be installed automatically on Debian based Linux OS'es or Linux'es with apt-get enabled..(Ubuntu, Kubuntu, debian and so on) Do not try to install ehcp with this installer on redhat, centos and non-debian Linux's... To use ehcp on no-debian systems, you need to manually install.. "
	echo "this installer is for installing onto a clean, newly installed Ubuntu/Debian. If you install it on existing system, some existing packages will be removed after prompting, if they conflict with packages that are used in ehcp, so, be careful to answer yes/no when using in non-new system"
	echo "Actually, I dont like saying like, 'No warranty, I cannot be responsible for any damage.... ', But, this is just a utility.. use at your own."
	echo "ehcp also sends some usage data to developer for statistical/improvement purposes"
	echo
	echo "Outline of install process:"
	echo "1- Install php command line version (Preinstaller)"
	echo "2- Run install_1.php and install_2.php to install other server related software, such as mysql/mariadb, apache, nginx (Main installer)"
	echo
	echo "press enter to continue"
	echo
	if [ "$unattended" == "" ] ; then
		read
	fi
}

# Check for yum

function checkyum () {
	which yum > /dev/null 2>&1
	if [ "$?" == "0"  ]; then
		echo "yum is available"
		return 0
	else
		# This should never happen
		echo "Please install yum"
		installyum
	fi
}

# Check for apt-get

function checkAptget(){

	sayi=`which apt-get | wc -w`
	if [ $sayi -eq 0 ] ; then
		echo "apt-get is not found. This is a serious problem. Note that ehcp can only be installed on Debian & Ubuntu & other debian/ubuntu based systems. We strongly suggest Ubuntu."
		installaptget
	fi

	echo "apt-get seems to be installed on your system."
	aptIsInstalled=1

	sayi=`grep -v "#" /etc/apt/sources.list | wc -l`

	if [ $sayi -lt 10 ] ; then
		echo
		echo "WARNING ! Your /etc/apt/sources.list  file contains very few sources, This may cause problems installing some packages.. see http://www.ehcp.net/?q=node/389 for an example file"
		echo "This may be normal for some versions of debian"
		echo "press enter to continue or Ctrl-C to cancel and fix that file"
		if [ "$unattended" == "" ] ; then
			read
		fi
	fi

}


# Retrieve statistics
# Marcel: This freezed the installer on one of my Centos Servers (needs more investigating)
# bvidinli:answer: this infomail may be disabled, only for statistical purposes... may hang if for 10 second if user is not connected to internet, or something is wrong with wget or dns resolution...
# no hanging longer than 10 sec should occur... i think.. btw, your code is perfect, Marcel

function infoMail(){
	if $emailenable ; then
        #SENDING INFO TO REMOTE - SKIP
		#ip=`ifconfig | grep "inet addr" | grep -v "127.0.0.1" | awk '{print $2}' `
		##wget -q -O /dev/null --timeout=10 http://www.iyibirisi.com/diger/msg.php?msg=$1.$ip > /dev/null 2>&1 &
	fi
}

# Function to be called when installing packages, by Marcel <marcelbutucea@gmail.com>

function installPack(){

	if [ -n "$noapt" ] ; then  # skip install
		echo "skipping apt-get install for:$1"
		return
	fi

	if [ $distro == "ubuntu" ] || [ $distro == "debian" ];then
		# first, try to install without any prompt, then if anything goes wrong, normal install..
		apt-get -y --no-remove --allow-unauthenticated install $1
		if [ $? -ne 0 ]; then
				apt-get --allow-unauthenticated install $1
		fi
	else
		# Yum is nice, you don't get prompted :)
		yum -y -t install $1
	fi
}

function logToFile(){
	logfile="ehcp-apt-get-install.log"
	echo "$1" >> $logfile
}

function aptget_Update(){
	if [ -n "$noapt" ] ; then  # skip install
		echo "skipping apt-get update"
		return
	fi

	apt-get update
}

function aptgetInstall(){

	if [ -n "$noapt" ] ; then  # skip install
		echo "skipping apt-get install for:$1"
		return
	fi

	killall update-manager > /dev/null 2>&1
	killall update-notifier > /dev/null 2>&1 # these cause other apt-get commands fail because of dpkg lock

	# first, try to install without any prompt, then if anything goes wrong, normal install..
	cmd="apt-get -y --no-remove --allow-unauthenticated install $1"
	echo "Running: $cmd"
	logToFile "$cmd"
	$cmd

	if [ $? -ne 0 ]; then
		cmd="apt-get --allow-unauthenticated install $1"
		logToFile "$cmd"
		$cmd
	fi

}

function aptgetRemove(){
	if [ -n "$noapt" ] ; then  # skip uninstall
		echo "skipping apt-get remove for:$1"
		return
	fi

	# first, try to uninstall without any prompt, then if anything goes wrong, normal uninstall..
	cmd="apt-get -y remove $1"
	logToFile "$cmd"
	$cmd

	if [ $? -ne 0 ]; then
		cmd="apt-get remove $1"
		logToFile "$cmd"
		$cmd
	fi
}

# Get distro name , by Marcel <marcelbutucea@gmail.com>, thanks to marcel for fixing whole code syntax
# No longer works in Ubuntu 13.04
# Fixed by Eric Martin <earnolmartin@gmail.com>
function checkDistro() {

		# Below code doesn't work

		#cat /etc/*release | grep -i ubuntu &> /dev/null && distro="ubuntu"
		#cat /etc/*release | grep -i red  &> /dev/null && distro="redhat" # not yet supported
		#cat /etc/*release | grep -i centos && distro="centos"
		#cat /etc/*release | grep -i debian &> /dev/null && distro="debian"

		# Get distro properly
		if [ -e /etc/issue ]; then
			distro=$( cat /etc/issue | awk '{ print $1 }' )
		fi

		if [ -z "$distro" ]; then
			if [ -e /etc/os-release ]; then
				distro=$( cat os-release | grep -o "^NAME=.*" | grep -o "[^NAME=\"].*[^\"]" )
			fi
		fi

		# Assume Ubuntu
		if [ -z "$distro" ]; then
			distro="ubuntu"
		else
			# Convert it to lowercase
			distro=$( echo $distro | awk '{print tolower($0)}' )
		fi


		# Get actual release version information
		version=$( cat /etc/issue | awk '{ print $2 }' )
		if [ -z "$version" ]; then
			version=$( lsb_release -r | awk '{ print $2 }' )
		fi

		# Separate year and version
		if [[ "$version" == *.* ]]; then
			yrelease=$( echo "$version" | cut -d. -f1 )
			mrelease=$( echo "$version" | cut -d. -f2 )
		fi

		# Get 64-bit OS or 32-bit OS [used in vsftpd fix]
		if [ $( uname -m ) == 'x86_64' ]; then
			OSBits=64
		else
			OSBits=32
		fi

		# Another way to get the version number
		# version=$(lsb_release -r | awk '{ print $2 }')

		echo "Your distro is $distro runnning version $version"

}

# Check if the running user is root, if not restart with sudo
function checkUser() {
		if [ `whoami` != "root" ];then
				echo "you are $who, you have to be root to use ehcp installation program.  switching to root mode, please enter password  or re-run install.sh as root"
				sudo $0 $@ # restart this with superuser-root privileges
				exit
		fi
}

# Function to kill any running ehcp / php daemons
function killallEhcp() {
		for i in `ps aux | grep ehcpdaemon.sh | grep -v grep | awk -F " " '{ print $2 }'`;do
				kill -9 $i
		done

		for i in `ps aux | grep 'php index.php' | grep -v grep | awk -F " " '{ print $2 }'`;do
				kill -9 $i
		done
}


function checkPhp(){
	which php
	if [ $? -eq 0 ] ; then
		echo "php seems installed. This is good.."
	else
		echo "PHP IS STILL NOT INSTALLED. THIS IS A SERIOUS PROBLEM.  MOST PROBABLY, YOU WILL NOT BE ABLE TO CONTINUE. TRY TO INSTLL PHP yourself."
		echo "if rest of install is successfull, then, this is a false alarm, just ignore"
	fi
}

function launchPanel(){
	firefox=`which firefox`
	if [ -n "$firefox" ] ; then
		echo "now, you should be able to navigate to your panel"
		echo "panel admin username: admin "
		echo "now will try to launch your control panel, if it is on local computer.. "
		echo -e "\nwill use firefox as browser...\n\n"
		$firefox "http://localhost" &
	fi
}

# Thanks a lot to  earnolmartin@gmail.com for fail2ban integration & vsftpd fixes.

function slaveDNSApparmorFix(){ # by earnolmartin@gmail.com
	if [ -e /etc/apparmor.d/usr.sbin.named ]; then
				echo -e "\nChanging bind apparmor rule to allow master DNS synchronization for slave setups.\n"
				sed -i 's#/etc/bind/\*\* r,#/etc/bind/\*\* rw,#g' /etc/apparmor.d/usr.sbin.named
	fi
}

function libldapFix(){ # by earnolmartin@gmail.com
	# install libldap, for vsftpd fix, without prompts
	#Remove originally installed libpam-ldap if it exists
	origDir=$(pwd)
	aptgetRemove libpam-ldap
	DEBIAN_FRONTEND=noninteractive apt-get -y install libpam-ldap
	cd $patchDir
	mkdir lib32gccfix
	cd lib32gccfix
	# wget -O "ldap_conf.tar.gz" http://dinofly.com/files/linux/ldap_conf_64bit_vsftpd.tar.gz
	# tar -zxvf ldap_conf.tar.gz
	# cp ldap.conf /etc/
	cd $origDir

	cp etc/ldap.conf ./
	cp etc/ldap.conf /etc/
}

function fixVSFTPConfig(){ # by earnolmartin@gmail.com
	sed -i 's/chroot_local_user=NO/chroot_local_user=YES/g' /etc/vsftpd.conf
	allowWriteValue=$( cat /etc/vsftpd.conf | grep -o "allow_writeable_chroot=.*" | grep -o "=.*$" | grep -o "[^=].*" )
	if [ -z "$allowWriteValue" ]; then
		sh -c "echo 'allow_writeable_chroot=YES' >> /etc/vsftpd.conf"
	else
		sed -i 's/allow_writeable_chroot=NO/allow_writeable_chroot=YES/g' /etc/vsftpd.conf
	fi


	if [ $OSBits -eq "64" ]; then
		#aptgetInstall libpam-ldap # this is required in buggy vsftpd installs.. ubuntu 12.04,12.10, 13.04, now...
		libldapFix
		aptgetInstall libgcc1
		# 64-bit 500 OOPS: priv_sock_get_cmd Fix
		# seccomp_sandbox=NO
		allowSandBox=$( cat /etc/vsftpd.conf | grep -o "seccomp_sandbox=.*" | grep -o "=.*$" | grep -o "[^=].*" )
		if [ -z "$allowSandBox" ]; then
			if [ "$yrelease" -ge "13" ] ; then
				sh -c "echo 'seccomp_sandbox=NO' >> /etc/vsftpd.conf"
			fi
		else
			sed -i 's/seccomp_sandbox=YES/seccomp_sandbox=NO/g' /etc/vsftpd.conf
		fi
	fi
	service vsftpd restart
}

function remove_vsftpd(){
	#Remove originally installed vsftpd
	aptgetRemove vsftpd
	# Just incase it's been installed already or another version has been installed using dpgk, let's remove it
	dpkg --remove vsftpd
}

function fixApacheDefault(){ # by own3mall@gmail.com
	ApacheFile="/etc/apache2/apache2.conf"
	confStr="IncludeOptional sites-enabled/\*.conf"
	correctConfStr="IncludeOptional sites-enabled/\*"
	if [ -e "$ApacheFile" ]; then
		ConfCheck=$( cat "$ApacheFile" | grep -o "$confStr" )
		if [ ! -z "$ConfCheck" ]; then
			sed -i "s#$confStr#$correctConfStr#g" "$ApacheFile"
			service apache2 restart
		fi
	fi
}

function removeNameVirtualHost(){ # by own3mall@gmail.com
	ApacheFile="/etc/apache2/ports.conf"
	confStr="NameVirtualHost \*"

	if [ -e "$ApacheFile" ]; then
		ConfCheck=$( cat "$ApacheFile" | grep -o "$confStr" )
		if [ ! -z "$ConfCheck" ]; then
			sed -i "s#$confStr##g" "$ApacheFile"
			service apache2 restart
		fi
	fi
}

function genUbuntuFixes(){ # by own3mall@gmail.com
	# Ubuntu packages keep coming with new features that mess things up
	# Thanks Ubuntu for the unneccessary headaches!
	if [ ! -z "$yrelease" ]; then
		if [ "$distro" == "ubuntu" ]; then
			if [[ "$yrelease" == "13" && "$mrelease" == "10" ]] || [ "$yrelease" -ge "14" ]; then
				fixApacheDefault
				removeNameVirtualHost
				addConfDFolder
			fi
		fi
	fi
}

function addConfDFolder(){
	if [ -e "/etc/apache2/apache2.conf" ]; then
		APACHECONFCONTENTS=$(cat "/etc/apache2/apache2.conf" | grep "IncludeOptional conf.d")
		if [ -z "$APACHECONFCONTENTS" ]; then
			echo "IncludeOptional conf.d/*" >> "/etc/apache2/apache2.conf"
		fi
	fi
}

function ubuntuVSFTPDFix(){ # by earnolmartin@gmail.com
	# Get currently working directory
	origDir=$( pwd )
	patchDir="/root/Downloads"
	if [ ! -e $patchDir ]; then
		mkdir $patchDir
	fi
	# Ubuntu VSFTPD Fixes
	if [ ! -z "$yrelease" ]; then
		if [ "$distro" == "ubuntu" ]; then
			if [ "$yrelease" == "12" ] ; then
				 if [ "$mrelease" == "04" ]; then
					# Run 12.04 Fix
					remove_vsftpd
					echo -e "\nRunning VSFTPD fix for Ubuntu 12.04\n"
					add-apt-repository -y ppa:thefrontiergroup/vsftpd
					aptget_Update
					aptgetInstall vsftpd
					fixVSFTPConfig

				 elif [ "$mrelease" == "10" ]; then
					# Run 12.10 Fix
					remove_vsftpd
					echo -e "\nRunning VSFTPD fix for Ubuntu 12.10\n"
					#get the code
					cd $patchDir
					if [ ! -e vsftpd_2.3.5-3ubuntu1.deb ]; then
						if [ $OSBits -eq "32" ]; then
							wget -O "vsftpd_2.3.5-3ubuntu1.deb" http://dinofly.com/files/linux/vsftpd_2.3.5-3ubuntu1_i386.deb
						else
							wget -O "vsftpd_2.3.5-3ubuntu1.deb" http://dinofly.com/files/linux/vsftpd_2.3.5-3.jme_amd64.deb
						fi
					fi
					#install
					dpkg -i vsftpd_2.3.5-3ubuntu1.deb
					cd $origDir
					fixVSFTPConfig
				 fi
			elif [ "$yrelease" == "13" ]; then
				# Ubuntu 13.04
				if [ "$mrelease" == "04" ]; then
					remove_vsftpd
					echo -e "\nRunning VSFTPD fix for Ubuntu 13.04\n"
					cd $patchDir
					if [ ! -e vsftpd_3.0.2-patched_ubuntu.deb ]; then
						if [ $OSBits -eq "32" ]; then
							wget -N -O "vsftpd_3.0.2-patched_ubuntu.deb" http://dinofly.com/files/linux/vsftpd_3.0.2-patched_ubuntu_13.04_x86.deb
						else
							wget -N -O "vsftpd_3.0.2-patched_ubuntu.deb" http://dinofly.com/files/linux/vsftpd_3.0.2-1ubuntu1_amd64_patched.deb
						fi
					fi
					sudo dpkg -i vsftpd_3.0.2-patched_ubuntu.deb
					cd $origDir
					fixVSFTPConfig
				fi

				# Ubuntu 13.10
				if [ "$mrelease" == "10" ]; then
					echo -e "\nRunning VSFTPD fix for Ubuntu 13.10\n"
					fixVSFTPConfig
				fi
			elif [ "$yrelease" -ge "14" ]; then
				echo -e "\nRunning VSFTPD fix for Ubuntu"
				if [ $OSBits -eq "64" ]; then
					remove_vsftpd
					# file now within ehcp files. We should check&update this when needed..
					# I will test normal vsftpd with U14.04, or seek another ftp solution which supports mysql auth.
					# wget -N -O "vsftpd_3.0.2-1ubuntu2.deb" http://dinofly.com/files/linux/vsftpd_3.0.2-1ubuntu2_amd64.deb
					# if [ $? -ne 0 ] ; then # just retry
					# 	wget -N -O "vsftpd_3.0.2-1ubuntu2.deb" http://dinofly.com/files/linux/vsftpd_3.0.2-1ubuntu2_amd64.deb
					# fi
					sudo dpkg -i vsftpd_3.0.2-1ubuntu2.deb
				fi
				fixVSFTPConfig
			fi
		fi
	fi
}

function logDirFix(){ # by earnolmartin@gmail.com
	chmod 755 log
	chmod 744 log/ehcp_failed_authentication.log
	chown www-data:www-data log/ehcp_failed_authentication.log
}

function fixBINDPerms(){ # by earnolmartin@gmail.com
	chmod -R 774 /etc/bind
}

function fix_permissions1(){
	# sometime, permissions are lost because of cile copying etc.
	chmod a+rx install*
	chmod a+rx *.sh
	chmod a+rx ehcp
	find ./ -type d -exec chmod a+rx {} \; # fix directory perms
}

function fixEHCPPerms(){ # by earnolmartin@gmail.com
	chmod a+rx /var/www/new/ehcp/
	chmod -R a+r /var/www/new/ehcp/
	find ./ -type d -exec chmod a+rx {} \;
	chown -R www-data:www-data /var/www/new/ehcp/webmail
	chmod 755 -R /var/www/new/ehcp/webmail
	chmod 755 /var/www/new/index.html
}

function fixPHPConfig(){ # by earnolmartin@gmail.com
	PHPConfFile="/etc/php5/cli/php.ini"
	if [ -e $PHPConfFile ]; then
		PHPConfCheck=$( cat $PHPConfFile | grep -o ";extension=mysql.so" )
		if [ -z "$PHPConfCheck" ]; then
			sed -i "s/extension=mysql.so/;extension=mysql.so/g" $PHPConfFile
			service apache2 restart
		fi
	fi
}

function fixPHPPerms(){ # by earnolmartin@gmail.com

	# PHP Runs Under www-data so www-data must own the vhosts directory
	# Set correct permissions on vhosts folder
	vhostsDir="/var/www/vhosts"
	# this is not a good idea, giving all files www-data permission would cause all files webserver writable, which is a high security issue.
	#if [ -e $vhostsDir ]; then
	#	chown -R www-data:www-data $vhostsDir
	#	chmod g+s -R $vhostsDir
	#	chmod 774 -R $vhostsDir
	#fi

	# Add vsftpd user as a member of the www-data group so that it may create/delete files
	sudo usermod -a -G www-data vsftpd # this is good, because otherwise, vsftpd cannot delete webserver written files.
}

function updateBeforeInstall(){ # by earnolmartin@gmail.com
	# Update packages before installing to avoid errors
	# return # cancelled now, user should do this his/herself.  a few reason: may be dangerous, user may choose to do it later, slowing down installation... etc..
	# without this function, apt-get installations cannot be done in a new server.. 
	
	if [ -n "$noapt" ] ; then  # skip install
		echo "skipping apt-get update"
		return
	fi

	if [ "$aptIsInstalled" -eq "1" ] ; then
		echo "Updating package information and downloading package updates before installation."
		apt-key update
		apt-get update -y
		# apt-get upgrade -y --allow-unauthenticated
	else
		echo "apt-get seems not installed, so, cannot update apt repository.. press Enter to continue"
		read a
	fi
}

function check_mysql(){
	# mysql hangs somehow on some systems. this checks if mysql working, and tries to start it if not.

	say=`php test_mysql.php | grep "t connect to local MySQL server through socket" | wc -l `
	if [ $say -gt 0 ] ; then
		echo "Mysql düzgün calısmıyor galiba.. yeniden deniyor."
		killall mysqld
		killall mysqld
		killall mysqld
		service mysql start
	fi
	say=`php test_mysql.php | grep "t connect to local MySQL server through socket" | wc -l `
	if [ $say -gt 0 ] ; then
		echo "Mysql düzgün calısmıyor galiba.. yeniden deniyor."
		killall mysqld
		killall mysqld
		killall mysqld
		service mysql start
	fi
	say=`php test_mysql.php | grep "t connect to local MySQL server through socket" | wc -l `
	if [ $say -gt 0 ] ; then
		echo "mysql hala çalışmıyor.. "
		ps aux | grep mysq[l] | grep -v grep | awk '{print $2}' | xargs kill -9
		ps aux | grep mysq[l] | grep -v grep | awk '{print $2}' | xargs kill -9
		service mysql start
	fi
	say=`php test_mysql.php | grep "t connect to local MySQL server through socket" | wc -l `
	if [ $say -gt 0 ] ; then
		echo "I am sory that, mysql seems still not working. We/You should fix this... This may be serious. Your panel may not work without mysql."
	fi
}

#############################################################
# End Functions & Start Install							 #
#############################################################
checkUser $@
ehcpHeader

fix_permissions1

dpkg --configure -a  # complete any pending operations, to avoid "dpkg interrupted" errors.

installdir=$(pwd)
if [ ! -f $installdir/install.sh ] ; then
	echo "install.sh is not in install dir. Run install.sh from within ehcp installation dir."
	exit 1
fi

#echo "`date`: initializing.b"  # i added these echo's because on some system, some stages are very slow. i need to investigate that.
#infoMail "ehcp_1_installstarted_ver_$ehcpversion"
#/etc/init.d/apparmor stop & > /dev/null  # apparmor causes many problems..
/etc/init.d/apparmor teardown & > /dev/null  # apparmor causes many problems..if anybody knows a better solution, let us know.
checkDistro
killallEhcp

if [ -z "$distro" ] ; then
	echo "Your system type could not be detected or detected to be ($distro), You may not install ehcp automatically on this system, anyway, to continue press enter"
	read
fi

checkAptget

#Update the system before installation
#If your package information is out of date, MySQL and others may fail to install
updateBeforeInstall

#----------------------start some install --------------------------------------
#echo "`date`: initializing.g"
mkdir /etc/ehcp
#aptget_Update

aptgetInstall python-software-properties # for add-apt-repository

# apt-get upgrade  # may be cancelled later... this may be dangerous... server owner should do it manually...
# alias ins='apt-get -y install $1'
# sftp://bv@10.0.2.2
aptgetInstall php5
aptgetInstall php5-mysqlnd  # why here: If I install php5-mysql after install_1.php started, mysqli_connect functions does not work.
aptgetInstall php5-cli
aptgetInstall sudo
aptgetInstall wget
aptgetInstall aptitude
aptgetInstall apache2-utils # for password protected directories

check_programs

# This is needed to provide a default answer for configuring certain packages such as mysql and phpmyadmin
if [ ! -z "$unattended" ]; then
	aptgetInstall debconf-utils
fi


#outside_ip=`echo "" > ip ; wget -q -O ip http://ehcp.net/diger/myip.php ; echo ip`
#rm -f ip

echo
echo

checkPhp
echo
echo
echo
echo "STAGE 2"
echo "====================================================================="
echo "now running install_1.php "
#infoMail ehcp_2_install-starting-install_1.php
php install_1.php $version $distro $noapt $unattended $light
if [ $? -gt 0 ] ; then
	echo "install_1.php returned error, check this.. "
	exit 1
else
	echo "php ended normally"
fi

echo
echo
echo "STAGE 3"
echo "====================================================================="
echo "now running install_2.php "
#infoMail ehcp_2_2_install-starting-install_2.php

#Send version to avoid installing nginx on Ubuntu 12.10 --- there is a bug and it's not supported
#php install_2.php $noapt || php /etc/ehcp/install_2.php $noapt  # start install_2.php if first install is successfull at php level. to prevent many errors.
php install_2.php $version $distro $noapt $unattended $light
if [ $? -gt 0 ] ; then
	echo "install_2.php returned error, check this.. "
	exit 1
else
	echo "php ended normally"
fi


########### Append ehcp restart to crontab, because, ehcp daemon dies sometime..
line="1 */6 * * * /etc/init.d/ehcp restart &"
say=`crontab -l | grep "ehcp restart" | wc -l`
if [ $say -eq 0 ] ; then
	(crontab -u root -l; echo "$line" ) | crontab -u root -
fi

# Post Install Functions by Eric Arnol-Martin

mv /var/www/new/ehcp/install_?.php /etc/ehcp/   # move it, to prevent later unauthorized access of installer from web
cd "/var/www/new/ehcp"
# Run VSFTPD Fix depending on version
ubuntuVSFTPDFix
# Run SlaveDNS Fix So that DNS Zones can be transfered
slaveDNSApparmorFix
# Run log chmod fix
logDirFix
# Configure Fail2Ban for EHCP if Fail2Ban is present and configured
# fail2banCheck # done in install*php files.
# Fix EHCP Permissions
fixEHCPPerms
# Fix extra mysql module getting loaded in the PHP config printing warning messages
fixPHPConfig
# Fix /etc/bind directory permissions required for slave dns
fixBINDPerms
# Fix Perms for PHP CHMOD Fix
fixPHPPerms
# Fix generic problems in Ubuntu
genUbuntuFixes

check_mysql

echo "$PATH" > path # fill this file, so that ehcp can run correctly in crontab or similar


infoMail "ehcp_8_install-finished-install.sh_ver_$ehcpversion.$outside_ip"
echo "now running ehcp daemon.."
cd /var/log
/etc/init.d/ehcp restart
echo "ehcp run/restart complete.."
sleep 5 # to let ehcp log fill a little






# you may disable following lines, these are for debug/check purposes.
ps aux > debug.txt
echo "============================================"  >> debug.txt
tail -100 /var/log/syslog >> debug.txt
tail -100 /var/log/ehcp.log >> debug.txt

if $emailenable ; then
	cat debug.txt | sendmail -s "ehcp installation debug info" my_ehcp_setup_AT_admin_email.com > /dev/null 2>&1
fi

echo "
A reseller account is setupd inside your ehcp, to support ehcp development, we will use it when we need some hosting, you may delete it if you want.
thank you for trying/using ehcp

if your server is behind a router/modem in your network, you need to Open/redirect necessary ports on your modem/router:
these ports need to be opened/redirected :
20,21,22,25,53,80,110,143 (tcp+udp)

ehcp install finished up to now.  we are continuing on simplifying the install process.
sory for any inconvenience. you can contact email/msn: info@ehcp.net
you may join us in developing this control panel.

You may visit http://www.ehcp.net
You may support by doing php coding, or html design, graphic design...
You may support by donating free dedicated or virtual servers for this project...
CURRENTLY I NEED A DEDICATED SERVER WITH 8 CORE, 8GRAM, 500G hdd at least.

ehcp : Finished all operations.. go to your panel at http://yourip/ now..."
