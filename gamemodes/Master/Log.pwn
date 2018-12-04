N::Log_OnGameModeInit()
{
	new line[128];
	printf(">>日志数据库 开始连接");
    mysql_log(LOG_ERROR|LOG_WARNING);
    Log@Handle=mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_LOG_DB,MYSQL_PASS);
    mysql_set_charset("gbk",Log@Handle);
	if(Log@Handle)format(line,sizeof(line),"日志数据线程[%i]`%s`@'%s' 连接成功",Log@Handle,MYSQL_LOG_DB,MYSQL_HOST);
	else format(line,sizeof(line),"日志数据线程[%i]`%s`@'%s' 连接失败",Log@Handle,MYSQL_LOG_DB,MYSQL_HOST);
    printf(line);
	return 1;
}
N::AddPlayerCheatLog(playerid,body[])
{
	fLine_512("INSERT INTO `"MYSQL_ANTI_LOG"`(`归属`,`用户名`,`内容`) VALUES ('%i','%s','%s')",Account[playerid][_Key],Account[playerid][_Name],body);
   	mysql_query(Log@Handle,line,false);
	return 1;
}
