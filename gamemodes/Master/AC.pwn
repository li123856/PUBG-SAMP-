new Socket:SocketID=Socket:NONE;
new Clientid=NONE;
enum PlayerAC_Info
{
	bool:_UseAC,
	_IpPort[64],
	_MachineCode[128],
	_SocketHandle,
	_UseMod
};
new PlayerAC[MAX_PLAYERS][PlayerAC_Info];
N::AC_OnAccountLoginGame(playerid,playername[],languageid)
{
/*    LoadPlayerACDate(playerid,playername);
	if(PlayerAC[playerid][_UseAC]==true)
	{
    	fLine_256("%s [ip:%s ������:%s ���Ӿ��:%i]���������",playername,PlayerAC[playerid][_IpPort],PlayerAC[playerid][_MachineCode],PlayerAC[playerid][_SocketHandle]);
    	AntiCheatPlayerLog(line);
	}
	else
	{
		SCM(playerid,-1,ReturnMLStr(languageid,_AC_MSG1));
		SetTimerEx("DelayKicke",100,false,"i",playerid);
	}*/
	return 1;
}
N::LoadPlayerACDate(playerid,playername[])
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT * FROM `"MYSQL_AC_SERCHACK"` WHERE `name` = '%s' ORDER BY `"MYSQL_AC_SERCHACK"`.`time` DESC ",playername);
	mysql_query(Ac@Handle,Query);
	if(cache_num_rows(Ac@Handle)>0)
	{
		PlayerAC[playerid][_UseAC]=true;
		cache_get_field_content(0,"ip",PlayerAC[playerid][_IpPort],Ac@Handle,64);
		cache_get_field_content(0,"code",PlayerAC[playerid][_MachineCode],Ac@Handle,128);
		PlayerAC[playerid][_SocketHandle]=cache_get_field_content_int(0,"handle",Ac@Handle);
		PlayerAC[playerid][_UseMod]=cache_get_field_content_int(0,"usemod",Ac@Handle);
		return 1;
	}
	PlayerAC[playerid][_UseAC]=false;
	return 0;
}
N::GetPlayerSocketHandle(playerid)
{
	fLine_128("SELECT `handle` FROM `"MYSQL_AC_SERCHACK"` WHERE `name` = '%s' LIMIT 1",Account[playerid][_Name]);
	mysql_query(Ac@Handle,line);
	return cache_get_field_content_int(0,"handle",Ac@Handle);
}
N::AC_OnGameModeExit()
{
    if(is_socket_valid(SocketID))
    {
 		socket_stop_listen(SocketID);
		socket_destroy(SocketID);
		SocketID=Socket:NONE;
		printf("�ر������������ɹ�!");
		mysql_query(Ac@Handle,"TRUNCATE TABLE `userchack`");
    }
    return 1;
}
N::AC_OnGameModeInit()
{
	new line[128];
	printf(">>���������ݿ� ��ʼ����");
    mysql_log(LOG_ERROR|LOG_WARNING);
    Ac@Handle=mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_AC_DB,MYSQL_PASS);
    mysql_set_charset("gbk",Ac@Handle);
	if(Ac@Handle)format(line,sizeof(line),"AC�����߳�[%i]`%s`@'%s' ���ӳɹ�",Ac@Handle,MYSQL_AC_DB,MYSQL_HOST);
	else format(line,sizeof(line),"AC�����߳�[%i]`%s`@'%s' ����ʧ��",Ac@Handle,MYSQL_AC_DB,MYSQL_HOST);
	printf(line);
	
    SocketID=socket_create(TCP);
    if(is_socket_valid(SocketID))
    {
        printf("���������������ɹ�!");
        socket_set_max_connections(SocketID,1);
        socket_bind(SocketID,"samp_server");
        socket_listen(SocketID, 65000);
    }
	return 1;
}
N::AC_OnPlayerConnect(playerid)
{
    PlayerAC[playerid][_UseAC]=false;
 	return 1;
}
public onSocketRemoteConnect(Socket:socketidx, remote_client[], remote_clientid)
{
    if(SocketID==socketidx)Clientid=remote_clientid;
    printf("%s>%i���ӵ�������",remote_client,remote_clientid);
    return 1;
}
public onSocketRemoteDisconnect(Socket:socketidx, remote_clientid)
{
    if(SocketID==socketidx)Clientid=NONE;
    printf(">%i�뿪������",remote_clientid);
    return 1;
}
N::Strong_onSocketReceiveData(Socket:socketidx, remote_clientid, data[], data_len)
{
    new startstr[32],endstr[32],datestr[1024],para1[64],para2[128],para3[128];
    strmid(startstr,data,0,7);
    strmid(endstr,data,data_len-5,data_len);
	if(!strcmp(startstr,"start1|")&&!strcmp(endstr,"|end1"))
	{
        strmid(datestr,data,7,data_len-5);
        if(!sscanf(datestr,"p<,>s[64]s[128]s[128]",para1,para2,para3))
        {
            new pid=GetPlayeridFromName(para1);
		    if(pid!=NONE)
			{
			    SCM(pid,-1,ReturnMLStr(pLang(pid),_AC_MSG2));
			    fLine_128("%s[ip:%s ������:%s ���Ӿ��:%i]>[���г���]%s",Account[pid][_Name],PlayerAC[pid][_IpPort],PlayerAC[pid][_MachineCode],PlayerAC[pid][_SocketHandle],para2);
			    AntiCheatPlayerLog(line);
			    SetTimerEx("DelayKicke",100,false,"i",pid);
			}
        }
	}
	if(!strcmp(startstr,"start2|")&&!strcmp(endstr,"|end2"))
	{
        strmid(datestr,data,7,data_len-5);
        if(!sscanf(datestr,"p<,>s[64]s[128]s[128]",para1,para2,para3))
        {
            new pid=GetPlayeridFromName(para1);
		    if(pid!=NONE)
			{
				SCM(pid,-1,ReturnMLStr(pLang(pid),_AC_MSG2));
			    fLine_128("%s[ip:%s ������:%s ���Ӿ��:%i]>[��װ����]%s",Account[pid][_Name],PlayerAC[pid][_IpPort],PlayerAC[pid][_MachineCode],PlayerAC[pid][_SocketHandle],para2);
			    AntiCheatPlayerLog(line);
			    SetTimerEx("DelayKicke",100,false,"i",pid);
			}
        }
	}
    return 1;
}
public onSocketReceiveData(Socket:socketidx, remote_clientid, data[], data_len)
{
	new count=0,tempstr[128];
    new findindex=strfind(data,"@",true);
    while(findindex!=-1)
    {
        strmid(tempstr,data,0,findindex);
        Strong_onSocketReceiveData(socketidx,remote_clientid,tempstr,strlen(tempstr));
        strdel(data,0,findindex+1);
        count++;
        findindex=strfind(data,"@",true);
    }
   	return 1;
}
N::GetPlayeridFromName(playername[])
{
	foreach(new i:Player)
	{
		if(Online(i))
		{
		    if(!strcmp(playername,Account[i][_Name],true))return i;
	    }
	}
	return NONE;
}
N::AntiCheatPlayerLog(body[])
{
	fLine_512("INSERT INTO `"MYSQL_AC_LOG"`(`����`) VALUES ('%s')",body);
   	mysql_query(Ac@Handle,line,false);
	return 1;
}
CMD:acf(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))return 1;
	new type,pid;
	if(sscanf(params, "ii",type,pid))return SCM(playerid,-1,"�÷�:/acf ����[0����1�ļ�] ���ID");
	if(!Online(pid))return SCM(playerid,-1,"�Է�������");
	if(PlayerAC[pid][_UseAC]==false)return SCM(playerid,-1,"�Է�ûʹ�÷�����");
    if(type<0||type>1)return SCM(playerid,-1,"0����1�ļ�");
    if(strlen(PlayerAC[pid][_IpPort])<5)return SCM(playerid,-1,"�Է�������");
    new handleid=GetPlayerSocketHandle(pid);
    if(handleid==0)return SCM(playerid,-1,"�Է������Ч");
	new line[64];
	if(type==0)
	{
        format(line,sizeof(line),"seerunapp%i",handleid);
    	socket_sendto_remote_client(SocketID,Clientid,line);
	}
	else
	{
	    format(line,sizeof(line),"seeuseapp%i",handleid);
	    socket_sendto_remote_client(SocketID,Clientid,line);
	}
    SCM(playerid,-1,"���ͳɹ�,���������ݿ�");
	return 1;
}
CMD:cap(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))return 1;
	new pid;
	if(sscanf(params, "i",pid))return SCM(playerid,-1,"�÷�:/cap ���ID");
	if(!Online(pid))return SCM(playerid,-1,"�Է�������");
	if(PlayerAC[pid][_UseAC]==false)return SCM(playerid,-1,"�Է�ûʹ�÷�����");
    if(strlen(PlayerAC[pid][_IpPort])<5)return SCM(playerid,-1,"�Է�������");
    new line[128];
    format(line,sizeof(line),"*** %s ��IP��ַ:%s",Account[pid][_Name],PlayerAC[pid][_IpPort]);
    SCM(playerid,-1,line);
    format(line,sizeof(line),"*** %s �Ļ�����:%s",Account[pid][_Name],PlayerAC[pid][_MachineCode]);
    SCM(playerid,-1,line);
    format(line,sizeof(line),"*** %s �����Ӿ��:%i",Account[pid][_Name],GetPlayerSocketHandle(pid));
    SCM(playerid,-1,line);
	return 1;
}
