<?php
// ehcp language file
$this->lang['zh']=
array(
'undefined_limittype'=>'未定義限制類型。',
'norecordfound'=>'沒有/沒找到紀錄。',
'recordcount'=>'紀錄筆數:',
'areyousuretodelete'=>'您確定要刪除嗎? <br>',
'error_occured'=>'發生錯誤 ',
'write_yourmessage_here'=>'在這裡寫上您的訊息',
'name_surname'=>'姓名',
'enter_yourcontactinfo'=>'在這裡輸入您的聯絡資訊',
'yourmessage_received'=>'感謝。我們已收到您的訊息。',
'search_'=>'搜尋',
'list_all'=>'列出全部',
'int_undefined_limittype'=>'EHCP 內部錯誤: 未定義限制類型',
'perhaps_db_error'=>'這個可能的原因是您的資料庫設定不正確，您無法連到資料庫;或是您的資料庫/網頁欄位已經不見了。<br> 您可能要編輯 config.php 來設定 ehcp mysql 帳號密碼。 <br> 試用<a href=misc/mysqltroubleshooter.php>mysql 狀況排除</a> 來解決這個問題。',
'welcome to world'=>'歡迎來到這裡...',
'Panel Home'=>'管理首頁/取消選擇',
'Domain Home'=>'網域首頁',
'Domains'=>'網域',
'Selected Domain'=>'已選擇的網域',
'domain_deactivated_contact_administrator'=>'這個網域已經被擁有者/管理員停用了。聯絡您的網域管理員..  / Bu domain, sahibi ya da yoneticisi tarafindan kapatilmistir. yonetici ile irtibata geciniz.',
'updatehostsfile'=>'This machine is used for Desktop access too (Update hosts file with domains)- (write here in chinese..)',
'dnsip'=>'dnsip (outside/real/static ip of server)',
'dnsipv6'=>'dnsip V6(outside/real/static V6 ip of server)',
'disablecustomhttp'=>'Disable Custom http',
'disableeditapachetemplate'=>'Disable Custom http for non-admins',
'disableeditdnstemplate'=>'Disable Custom dns for non-admins',
'turnoffoverquotadomains'=>'Turn off over quota domains',
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
