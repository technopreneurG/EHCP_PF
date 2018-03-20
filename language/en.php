<?php
// ehcp language file
$this->lang['en']=
array(
'undefined_limittype'=>'Undefined limittype.',
'norecordfound'=>'Nothing/No Record Found.',
'recordcount'=>'Record Count:',
'areyousuretodelete'=>'Are you sure to delete ? <br>',
'error_occured'=>'Error Occured ',
'write_yourmessage_here'=>'Write Your Messsage Here',
'name_surname'=>'Name Surname',
'enter_yourcontactinfo'=>'Enter Your Contact Info Here',
'yourmessage_received'=>'Thanks. We Received Your Message.',
'search_'=>'Search',
'list_all'=>'List All',
'int_undefined_limittype'=>'internal ehcp error: undefined limittype',
'perhaps_db_error'=>'This may mean that your db settings are not correct, you cannot connect to db; or your db/html table has missing rows.<br> You may edit config.php for ehcp mysql user password. <br> Try<a href=misc/mysqltroubleshooter.php>mysql troubleshooter</a> to solve this problem.',
'welcome to world'=>'Welcome to World...',
'Panel Home'=>'Panel Home/Deselect',
'Domain Home'=>'Domain Home',
'Domains'=>'Domains',
'Selected Domain'=>'Selected Domain',
'domain_deactivated_contact_administrator'=>'This domain is deactivated by owner/admin. Contact Your domain administrator..  / Bu domain, sahibi ya da yoneticisi tarafindan kapatilmistir. yonetici ile irtibata geciniz.',
'updatehostsfile'=>'This machine is used for Desktop access too (Update hosts file with domains)',
'dnsip'=>'dnsip (outside/real/static ip of server)',
'dnsipv6'=>'dnsip V6(outside/real/static V6 ip of server)',
'disablecustomhttp'=>'Disable Custom http',
'disableeditapachetemplate'=>'Disable Custom http for non-admins',
'disableeditdnstemplate'=>'Disable Custom dns for non-admins',
'turnoffoverquotadomains'=>'Turn off over quota domains',
'domain_format_wrong'=>'(Sub)Domain format is not suitable, check it..',
'similar_options_text'=>
"
	<br><a href='?op=options&edit=1'>Edit/Change Options</a><br>
	<br><a href='?op=changemypass'>Change My Password</a>
	<br><a href='?op=listpanelusers'>List/Add Panelusers/Resellers</a>
	<br><a href='?op=dosyncdns'>Sync Dns</a>
	<br><a href='?op=dosyncdomains'>Sync Domains</a><br>
	<br><a href='?op=dosyncftp'>Sync Ftp (for non standard home dirs)</a><br>
	<hr><a href='?op=advancedsettings'>Advanced Settings</a><br><br>
	<br><a href='?op=dofixmailconfiguration'>Fix Mail Configuration<br>Fix ehcp Configuration</a> (This is used after changing ehcp mysql user pass, or if you upgraded from a previous version, in some cases)<br>
	<br><br><a href='?op=dofixapacheconfigssl'>Fix Apache Configuration with ssl</a>(use with caution,may be risky)<br><br>
	<br><a href='?op=dofixapacheconfignonssl'>Fix Apache Configuration without ssl</a><br>
	<br><a href='?op=dofixapacheconfignonssl2'>Fix Apache Configuration without ssl, way2</a> - use this if first wone does not work. this disables custom apache configurations, if any<br>
	<br>
	<hr>
	<a href='?op=listservers'>List/Add Servers/ IP's</a><br>
	<hr>
	Roles: <a href='?op=list_roles'>List</a> - <a href='?op=assign_role'>Assign Role</a><br>

	<hr>
	Experimental:
	<br><a href='?op=donewsyncdns'>New Sync Dns - Multiserver</a>
	<br><a href='?op=donewsyncdomains'>New Sync Domains - Multiserver</a><br>
	<br><a href='?op=multiserver_add_domain'>Multiserver Add Domain</a>
	<hr>

	"
,
'select_language'=>
"
(<a href='?op=setlanguage&id=en'>En</a>
<a href='?op=setlanguage&id=tr'>Tr</a>
<a href='?op=setlanguage&id=german'>German</a>
<a href='?op=setlanguage&id=spanish'>Spanish</a>
<a href='?op=setlanguage&id=fr'>Fr</a>
<a href='?op=setlanguage&id=lv'>Latvie&#353;u</a>
<a href='?op=setlanguage&id=it'>Italian</a>
<a href='?op=setlanguage&id=zh'>Taiwan</a>
)
<br>
<table>
<tr>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=en'><img height=30 width=50 src=images/en.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=tr'><img height=30 width=50 src=images/tr.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=german'><img height=30 width=50 src=images/german.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=spanish'><img height=30 width=50 src=images/spanish.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=fr'><img height=30 width=50 src=images/fr.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=lv'><img height=30 width=50 src=images/lv.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=it'><img height=30 width=50 src=images/it.jpg border=0></a></td>
<td style=\" padding: 3px; \"><a href='?op=setlanguage&id=zh'><img height=30 width=50 src=images/zh.jpg border=0></a></td>

</tr>
</table>
",

''=>''
);




?>
