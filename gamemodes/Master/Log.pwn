N::Log_OnGameModeInit()
{
	new line[128];
	printf(">>��־���ݿ� ��ʼ����");
    mysql_log(LOG_ERROR|LOG_WARNING);
    Log@Handle=mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_LOG_DB,MYSQL_PASS);
    mysql_set_charset("gbk",Log@Handle);
	if(Log@Handle)format(line,sizeof(line),"��־�����߳�[%i]`%s`@'%s' ���ӳɹ�",Log@Handle,MYSQL_LOG_DB,MYSQL_HOST);
	else format(line,sizeof(line),"��־�����߳�[%i]`%s`@'%s' ����ʧ��",Log@Handle,MYSQL_LOG_DB,MYSQL_HOST);
    printf(line);
	return 1;
}
N::AddPlayerCheatLog(playerid,body[])
{
	fLine_512("INSERT INTO `"MYSQL_ANTI_LOG"`(`����`,`�û���`,`����`) VALUES ('%i','%s','%s')",Account[playerid][_Key],Account[playerid][_Name],body);
   	mysql_query(Log@Handle,line,false);
	return 1;
}
