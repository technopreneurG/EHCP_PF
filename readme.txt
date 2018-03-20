This readme.txt file may be old. have a look at www.ehpc.net for more recent info.

EHCP is a Free Hosting Control Panel for Ubuntu/Debian/Mint and similars, a web based software for managing your hosting server. You can manage your domains, ftp, emails and more using EHCP

EHCP is now being used by thousands of servers worldwide.
Please consider supporting/contributing/donating by any means, as described in http://ehcp.net/?q=node/25

prerequisities:
only clean debian/ubuntu (apt-get) compatible linux system.

to install copy and paste following on your linux console:

wget http://www.ehcp.net/download
tar -zxvf ehcp_latest.tgz
cd ehcp
./install.sh



after installation,
panel username: admin,
pass: whatever you set in install.




Running ehcp:
------------------------
after you finish ehcp, it should already run as a daemon.
if daemon is not run somehow,
you may execute
./ehcpdaemon.sh
in where you installed ehcp.

this will start the program in daemon mod.

the web interface will at the web server where you installed your files.
for local computer, call
http://localhost/
and you will see your login dialog.
admin account: admin

after logged in, you may add/delete users, as well as domains/email users etc.

soma files such as ehcp_postfix.sh, ehcp_postfix2.sh, install_old.sh and so, are not used anymore, only left for historical purposes.


send any comments/questions to: info@ehcp.net
msn/email:info@ehcp.net

Hope, you will find ehcp useful.

have a look at www.ehcp.net for ore info..

Thanks
ehcp developer





ehcp General Features:
* Full php, full opensource, easily modifiable, customazible, ehcp templates
* Unlimited "resellers, panel users, domains, ftp users, emails, mysqls"
* Domains, subdomains, ftp, mysql, dns (automatic), email etc. management
* password protected domains,
* Email forwarding, autoreply, catch-all emails,
* Web-stats (webalizer)
* web-ftp (net2ftp)
* Easy Install Scripts (scripts easily downloaded and copied by means of server)
* Disk quota control,
* Custom http, custom dns, domain aliases, domain redirect,
* Ssl support
* Different languages, templates support, a few lang/templates included,
* Different Menus/pages for Server Admin, Reseller, domain admin, email user (4 level) (ehcp user levels explained: http://www.ehcp.net/?q=node/920)
* server backup/restore (files+db)
* domain transfer to another ehcp user
* simple, light, fast, host hundreds of domains in it.
* supports Ubuntu 6-10.04, debian 4,5, all debian based linux'es,
* Any server related program may be installed with Ubuntu's apt-get command,
* Almost all programs are always up-to-date when you update your server, with Ubuntu's: apt-get update ; apt-get upgrade
* Opensource, GPL, free, full php, object oriented, modular, easily modifiable/extendable design..
* More features that I forgot to write..

new with 0.29.12:
* Customizable, templates,
* add domain to my ftp,
* add ftp with any directory under home,
* add ftp with subdomain,
* add ftp with subdirectory under domainname,
* list related/similar functions in ehcp
* edit dns/apache template for a domain
* domain aliases,
* email forwardings,
* catch all email,
* default domain settable for ehcp gui
* "fix apache configuration" link in options
* "fix email (postfix) configuration" link in options
* apache ssl support
* new default theme: xp5-z7
* more "easy install scripts", a total of 30 scripts,
* disk quota support
* smtp auth support
* more options for ehcp,
* bulk add domain feature
* multi server intro: separate mysql server support,
* improved installer,

Important information/posts on this site:
If you need to upgrade, follow: http://www.ehcp.net/?q=node/529
Ehcp Features: http://www.ehcp.net/?q=node/794
Howto Debug ehcp: http://ehcp.net/?q=node/771

Ehcp help/howto: http://www.ehcp.net/helper/yardim/cats.php
Dns/hosting things: http://www.ehcp.net/?q=node/536
ehcp installation for newbie: http://ehcp.net/?q=node/567
Some important articles: http://www.ehcp.net/?q=node/262
Download ehcp and related: http://ehcp.net/?q=node/153
Feature Requests: http://www.ehcp.net/?q=node/683 (https://blueprints.launchpad.net/ehcp/)

ehcp ram usage: http://www.ehcp.net/?q=node/639

Ehcp Wiki: http://www.ehcp.net/wiki

(link to this page: http://www.ehcp.net/?q=node/794)