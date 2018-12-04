N::ServerSet@OnGameModeInit()
{
	new line[128];
    Set@Handle=mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_SEVRVER_DB,MYSQL_PASS);
    mysql_set_charset("gbk",Set@Handle);
	if(Set@Handle)format(line,sizeof(line),"配置数据线程[%i]`%s`@'%s' 连接成功",Set@Handle,MYSQL_SEVRVER_DB,MYSQL_HOST);
	else format(line,sizeof(line),"配置数据线程[%i]`%s`@'%s' 连接失败",Set@Handle,MYSQL_SEVRVER_DB,MYSQL_HOST);
	printf(line);
	DB_LoadWorldTime();
	DB_LoadMusicBoxs();
	return 1;
}
N::ServerSet@SaveServerRunTime()
{
	if(SeverState[_ServerRun]==true)
	{
	    SeverState[_RunTimes]++;
	    new Query[128];
		format(Query,sizeof(Query),"UPDATE `"MYSQL_SEVRVER_SET"` SET  `运行时间` = '%i'",SeverState[_RunTimes]);
		mysql_query(Set@Handle,Query,false);
	}
	return 1;
}
N::DB_LoadWorldTime()
{
	mysql_query(Set@Handle,"SELECT * FROM `"MYSQL_SEVRVER_SET"`",true);
	SeverState[_RunTimes]=cache_get_field_content_int(0,"运行时间",Set@Handle);
	SeverState[_ServerRun]=false;
	return 1;
}
