N::Account@OnGameModeInit()
{
	new line[128];
	printf(">>数据库 开始连接");
    mysql_log(LOG_ERROR|LOG_WARNING);
    User@Handle=mysql_connect(MYSQL_HOST,MYSQL_USER,MYSQL_DB,MYSQL_PASS);
    mysql_set_charset("gbk",User@Handle);
	if(User@Handle)format(line,sizeof(line),"玩家数据线程[%i]`%s`@'%s' 连接成功",User@Handle,MYSQL_DB,MYSQL_HOST);
	else format(line,sizeof(line),"玩家数据线程[%i]`%s`@'%s' 连接失败",User@Handle,MYSQL_DB,MYSQL_HOST);
	printf(line);
	return 1;
}
N::Account@OnPlayerDisconnect(playerid,reason)
{
	if(Account[playerid][_Login]!=false)SendComeInMsgToNoGameIngPlayer(playerid,0x000000C8,_COME_OUT);
    PlayerBagRest(playerid);
    PlayerMailRest(playerid);
    PlayerFriendRest(playerid);
    PlayerAttachRest(playerid);
    if(PlayerNameTag[playerid]!=Text3D:INVALID_STREAMER_ID)DestroyDynamic3DTextLabel(PlayerNameTag[playerid]);
    PlayerNameTag[playerid]=Text3D:INVALID_STREAMER_ID;
    if(PlayerAfkTag[playerid]!=Text3D:INVALID_STREAMER_ID)DestroyDynamic3DTextLabel(PlayerAfkTag[playerid]);
    PlayerAfkTag[playerid]=Text3D:INVALID_STREAMER_ID;
    LastPauseTime[playerid]=0;
    return 1;
}
N::Account@OnPlayerConnect(playerid)
{
    PlayerBagRest(playerid);
    PlayerMailRest(playerid);
    PlayerFriendRest(playerid);
    if(PlayerNameTag[playerid]!=Text3D:INVALID_STREAMER_ID)DestroyDynamic3DTextLabel(PlayerNameTag[playerid]);
    PlayerNameTag[playerid]=Text3D:INVALID_STREAMER_ID;
    if(PlayerAfkTag[playerid]!=Text3D:INVALID_STREAMER_ID)DestroyDynamic3DTextLabel(PlayerAfkTag[playerid]);
    PlayerAfkTag[playerid]=Text3D:INVALID_STREAMER_ID;
    PlayerNameTag[playerid]=CreateDynamic3DTextLabel(" ",-1,0.0,0.0,0.15,50.0,playerid);
    PlayerAfkTag[playerid]=CreateDynamic3DTextLabel(" ",-1,0.0,0.0,-0.7,10.0,playerid,INVALID_VEHICLE_ID,STREAMER_VEHICLE_TYPE_DYNAMIC,1);
    LastPauseTime[playerid]=0;
    return 1;
}

N::IsPlayerKeyFexist(Key)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT `名字` FROM `"MYSQL_DB_USER"` WHERE `编号` = '%i' LIMIT 1",Key);
	mysql_query(User@Handle,Query);
	return cache_get_row_count(User@Handle);
}
stock Select@GetPlayerNameByKey(Key)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT `名字` FROM `"MYSQL_DB_USER"` WHERE `编号` = '%i' LIMIT 1",Key);
	mysql_query(User@Handle,Query,true);
	new line[32];
	cache_get_field_content(0,"名字",line,User@Handle,32);
	return line;
}
stock Select@GetPlayerLanguageByKey(Key)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT `语言` FROM `"MYSQL_DB_USER"` WHERE `编号` = '%i' LIMIT 1",Key);
	mysql_query(User@Handle,Query,true);
	return cache_get_field_content_int(0,"语言",User@Handle);
}
N::Update@AccountSkin(playerid,skinid)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `皮肤`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",skinid,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountGold(playerid,gold)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `金币`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",gold,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountLanguage(playerid,language)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `语言`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",language,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountSceneRot(playerid,isrot)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `主界面旋转`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",isrot,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountSceneID(playerid,sceneid)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `主界面场景`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",sceneid,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountMute(playerid,mutetime)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `禁言期限`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",mutetime,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountNameColor(playerid,colorid)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `名字颜色`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",colorid,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Update@AccountSign(playerid,signid)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `表情`='%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",signid,Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::Account@GetAccountInfo(playerid)
{
	GetPlayerNameEx(playerid,Account[playerid][_Name],64);
	new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_USER"` WHERE `名字`='%s' LIMIT 1",Account[playerid][_Name]);
    mysql_tquery(User@Handle,Query, "OnAccountDataLoad","i",playerid);
	return 1;
}

N::OnAccountDataLoad(playerid)
{
    ClearChat(playerid);
    new line[128];
	if(cache_num_rows(User@Handle))
	{
	    Account[playerid][_Language]=cache_get_field_content_int(0,"语言",User@Handle);
	    AC_OnAccountLoginGame(playerid,Account[playerid][_Name],pLang(playerid));
	    //Dialog@Show(playerid,_TEST_ENTER,DIALOG_STYLE_INPUT,ReturnMLStr(pLang(playerid),_TEST_DIALOG1),ReturnMLStr(pLang(playerid),_TEST_DIALOG2),ReturnMLStr(pLang(playerid),_TEST_DIALOG3),ReturnMLStr(pLang(playerid),_TEST_DIALOG4));
	    format(line,sizeof(line),ReturnMLStr(pLang(playerid),_LOGIN_BODY),Account[playerid][_Name],cache_get_field_content_int(0,"编号",User@Handle));
	    Dialog@Show(playerid,_LOGIN,DIALOG_STYLE_PASSWORD,ReturnMLStr(pLang(playerid),_LOGIN_TITLE),line,ReturnMLStr(pLang(playerid),_LOGIN_BOTTON1),ReturnMLStr(pLang(playerid),_LOGIN_BOTTON2));
//		SCM(playerid,-1,ReturnMLStr(pLang(playerid),_COME_IN_MSG1));
	}
	else
	{
	    ShowPlayerLangMenu(playerid);
	}
	return 1;
}
N::OnAccountLoginGame(playerid)
{
    Hooks("DB_LoadPlayerBag","i",playerid);
    Hooks("DB_LoadPlayerAttach","i",playerid);
    Hooks("DB_LoadPlayerFriends","i",playerid);
    Hooks("DB_LoadPlayerMails","i",playerid);
    Hooks("ShowPlayerSignature","i",playerid);
    
    HidePlayerConnectDraw(playerid);
    SetPlayerScore(playerid,Account[playerid][_Level]);
    SendComeInMsgToNoGameIngPlayer(playerid,0x000000C8,_COME_IN);
    PlayerRandMusicForPlayer(playerid);
 	//if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_COMEIN);
    Account[playerid][_Login]=true;
    PlayerInState[playerid]=PLAYER_IN_INTERFACE;
    PlayerInStateID[playerid]=NONE;
	StopPlayerConnectPosChange(playerid);
   	SetSpawnInfo(playerid,NO_TEAM,Account[playerid][_Skin],pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z],pRotCam[playerid][_A],0,0,0,0,0,0);
   	TogglePlayerSpectating(playerid,false);
	SetPlayerPos(playerid,pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z]);
	SetPlayerFacingAngle(playerid,pRotCam[playerid][_A]);
    TogglePlayerControllable(playerid,0);
	ShowPlayerFaceMenu(playerid,false);
    SetPlayerInterior(playerid,0);
    SetPlayerVirtualWorld(playerid,PersonalRoom(playerid));
    StartPlayerRotCamera(playerid);
    SetPlayerWorldBounds(playerid,pRotCam[playerid][_X]+2.0,pRotCam[playerid][_X]-2.0,pRotCam[playerid][_Y]+2.0,pRotCam[playerid][_Y]-2.0);
    SetPlayerTime(playerid,ServerHour,ServerMinute);
    SetPlayerWeather(playerid,random(21));
    SetPlayerColor(playerid,Color[Account[playerid][_NameColor]][_hex]);
    
    fLine_64("ID:%i\n%s%s",playerid,Color[Account[playerid][_NameColor]][_hex_str],Account[playerid][_Name]);
 	UpdateDynamic3DTextLabelText(PlayerNameTag[playerid],-1,line);
 	
    Dialog@Show(playerid,_UPDATE_LOG,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_UPDATE_DIALOG1),ReturnMLStr(pLang(playerid),_UPDATE_DIALOG2),ReturnMLStr(pLang(playerid),_UPDATE_DIALOG3),"");
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_COME_IN_MSG1));
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FPS_MSG1));
   	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG1));
   	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG4));
	return 1;
}
N::UpdatePlayerAfk(playerid)
{
	if(IsPlayerPaused(playerid))
	{
		PauseTime[playerid]++;
	    if(LastPauseTime[playerid]!=PauseTime[playerid])UpdatePlayerAfkText(playerid,PauseTime[playerid]);
		LastPauseTime[playerid]=PauseTime[playerid];
	}
    else
	{
	    PauseTime[playerid]=0;
	    if(LastPauseTime[playerid]!=PauseTime[playerid])UpdatePlayerAfkText(playerid,PauseTime[playerid]);
		LastPauseTime[playerid]=PauseTime[playerid];
    }
	return 1;
}
N::UpdatePlayerAfkText(playerid,timeline)
{
	if(PlayerAfkTag[playerid]==Text3D:INVALID_STREAMER_ID)return 1;
	if(timeline==0)return UpdateDynamic3DTextLabelText(PlayerAfkTag[playerid],-1," ");
	switch(PlayerInState[playerid])
    {
		case PLAYER_IN_GAMEROOM:
  		{
		    fLine_64("离开[AFK]\n{FFFFFF}%s/{FF0000}03:00",ReturnCountDownStr(timeline));
		 	UpdateDynamic3DTextLabelText(PlayerAfkTag[playerid],0x408080C8,line);
		}
		case PLAYER_IN_WAITROOM:
		{
		    fLine_64("离开[AFK]\n%s",ReturnAfkStr(timeline));
		 	UpdateDynamic3DTextLabelText(PlayerAfkTag[playerid],0x408080C8,line);
		}
        default:
        {
            UpdateDynamic3DTextLabelText(PlayerAfkTag[playerid],-1," ");
        }
	}
	return 1;
}
N::OnPlayerLocalStateChange(playerid,NewState,OldState)
{
	switch(PlayerInState[playerid])
    {
		case PLAYER_IN_GAMEROOM:
  		{

		}
		case PLAYER_IN_WAITROOM:
		{

		}
        default:UpdatePlayerAfkText(playerid,0);
	}
	return 1;
}
stock GetPlayerNameFromKey(Key)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT `名字` FROM `"MYSQL_DB_USER"` WHERE `编号` = '%i' LIMIT 1",Key);
	mysql_query(User@Handle,Query);
	new line[64];
	cache_get_field_content(0,"名称",line,User@Handle,24);
	return line;
}
/*******************************************/
N::DB_LoadPlayerBag(playerid)//读取玩家背包
{
	new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_BAG"` WHERE `归属`=%i ORDER BY `"MYSQL_DB_BAG"`.`编号` ASC",Account[playerid][_Key]);
    mysql_tquery(User@Handle,Query, "OnPlayerBagLoad", "i",playerid);
}
N::OnPlayerBagLoad(playerid)
{
    forex(i,cache_num_rows())
	{
	    if(i<MAX_PLAYER_BAG)
	    {
	    	Bag[playerid][i][_Key]=cache_get_field_content_int(i,"编号",User@Handle);
			Bag[playerid][i][_Owner]=cache_get_field_content_int(i,"归属",User@Handle);
			Bag[playerid][i][_ItemID]=cache_get_field_content_int(i,"道具ID",User@Handle);
            Bag[playerid][i][_Amout]=cache_get_field_content_int(i,"数量",User@Handle);
			Iter_Add(Bag[playerid],i);
		}
		else
		{
		    printf("%s的背包数据溢出[%i],请修改MAX_BAG_ITEM",Account[playerid][_Name],MAX_PLAYER_BAG);
			break;
		}
	}
	return 1;
}
N::PlayerBagRest(playerid)
{
   	Iter_Clear(Bag[playerid]);
	return 1;
}
/*******************************************/
N::DB_LoadPlayerAttach(playerid)//读取玩家装饰
{
	new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_ATTACH"` WHERE `归属`=%i ORDER BY `"MYSQL_DB_ATTACH"`.`编号` ASC",Account[playerid][_Key]);
    mysql_tquery(User@Handle,Query, "OnPlayerAttachLoad", "i",playerid);
}
N::OnPlayerAttachLoad(playerid)
{
//    printf("OnPlayerAttachLoad");
    forex(i,cache_num_rows())
	{
	    if(i<MAX_PLAYER_ATTACHS)
	    {
	    	pAttach[playerid][i][_Key]=cache_get_field_content_int(i,"编号",User@Handle);
			pAttach[playerid][i][_Owner]=cache_get_field_content_int(i,"归属",User@Handle);
			pAttach[playerid][i][_ItemID]=cache_get_field_content_int(i,"道具ID",User@Handle);
			Iter_Add(pAttach[playerid],i);
		}
		else
		{
		    printf("%s的饰品数据溢出[%i],请修改MAX_PLAYER_ATTACHS",Account[playerid][_Name],MAX_PLAYER_ATTACHS);
			break;
		}
	}
	//GivePlayerAttach(playerid);
	return 1;
}
N::GivePlayerAttach(playerid)
{
 //   printf("GivePlayerAttach");
 	forex(i,MAX_PLAYER_ATTACHED_OBJECTS)RemovePlayerAttachedObject(playerid,i);
	new Float:arr[9];
	foreach(new i:pAttach[playerid])
	{
        arr[0]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetX];
        arr[1]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetY];
        arr[2]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetZ];
        arr[3]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotX];
        arr[4]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotY];
        arr[5]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotZ];
        arr[6]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleX];
        arr[7]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleY];
        arr[8]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleZ];
//        printf("%i,%i,%i,%f,%f,%f,%f,%f,%f,%f,%f,%f",i+7,MallItem[pAttach[playerid][i][_ItemID]][_Model],MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_Bone],arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8]);
        SetPlayerAttachedObject(playerid,i+7,MallItem[pAttach[playerid][i][_ItemID]][_Model],MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_Bone],arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8]);
	}
	return 1;
}
N::PlayerAttachRest(playerid)
{
   	Iter_Clear(pAttach[playerid]);
	return 1;
}
N::AddAttachForPlayer(playerid,itemid)
{
	if(Iter_Count(pAttach[playerid])>=MAX_PLAYER_ATTACHS)return 0;
	new i=Iter_Free(pAttach[playerid]);
	pAttach[playerid][i][_Owner]=Account[playerid][_Key];
	pAttach[playerid][i][_ItemID]=itemid;
   	new Query[256];
    format(Query,sizeof(Query),"INSERT INTO `"MYSQL_DB_ATTACH"`(`归属`,`道具ID`) VALUES ('%i','%i')",pAttach[playerid][i][_Owner],pAttach[playerid][i][_ItemID]);
	mysql_query(User@Handle,Query,true);
    pAttach[playerid][i][_Key]=cache_insert_id();
    Iter_Add(pAttach[playerid],i);
	new Float:arr[9];
    arr[0]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetX];
    arr[1]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetY];
    arr[2]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fOffsetZ];
    arr[3]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotX];
    arr[4]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotY];
    arr[5]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fRotZ];
    arr[6]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleX];
    arr[7]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleY];
    arr[8]=MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_fScaleZ];
    SetPlayerAttachedObject(playerid,i+7,MallItem[pAttach[playerid][i][_ItemID]][_Model],MallItemDiffPos[pAttach[playerid][i][_ItemID]][_Attach_Bone],arr[0],arr[1],arr[2],arr[3],arr[4],arr[5],arr[6],arr[7],arr[8]);
	return 1;
}
N::RemoveAttachForPlayer(playerid,index)
{
    if(!Iter_Contains(pAttach[playerid],index))return 0;
	new Query[128];
	format(Query,sizeof(Query),"DELETE FROM `"MYSQL_DB_ATTACH"` WHERE `编号`='%i'",pAttach[playerid][index][_Key]);
	mysql_query(User@Handle,Query,false);
	Iter_Remove(pAttach[playerid],index);
	RemovePlayerAttachedObject(playerid,index+7);
	return 1;
}
new AttachmentBonesCn[][24] = {
	{"脊柱"},
	{"头部"},
	{"左上臂"},
	{"右上臂"},
	{"左手"},
	{"右手"},
	{"左大腿"},
	{"右大腿"},
	{"左脚"},
	{"右脚"},
	{"右小腿"},
	{"左小腿"},
	{"左前臂"},
	{"右前臂"},
	{"左锁骨"},
	{"右锁骨"},
	{"脖子"},
	{"下巴"}
};
new AttachmentBonesEn[][24] = {
	{"Spine"},
	{"Head"},
	{"Left upper arm"},
	{"Right upper arm"},
	{"Left hand"},
	{"Right hand"},
	{"Left thigh"},
	{"Right thigh"},
	{"Left foot"},
	{"Right foot"},
	{"Right calf"},
	{"Left calf"},
	{"Left forearm"},
	{"Right forearm"},
	{"Left clavicle"},
	{"Right clavicle"},
	{"Neck"},
	{"Jaw"}
};
stock ReturnPlayerAttachList(playerid)
{
	new line[256],slotid[3];
	slotid[0]=MallItemDiffPos[PlayerAttachItem(playerid,0)][_Attach_Bone]-1;
	slotid[1]=MallItemDiffPos[PlayerAttachItem(playerid,1)][_Attach_Bone]-1;
	slotid[2]=MallItemDiffPos[PlayerAttachItem(playerid,2)][_Attach_Bone]-1;
	if(pLang(playerid)==1)
	{
        format(line,sizeof(line),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG2),MallItem[PlayerAttachItem(playerid,0)][_Name],AttachmentBonesEn[slotid[0]],MallItem[PlayerAttachItem(playerid,1)][_Name],AttachmentBonesEn[slotid[1]],MallItem[PlayerAttachItem(playerid,2)][_Name],AttachmentBonesEn[slotid[2]]);
	}
	else
	{
        format(line,sizeof(line),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG2),MallItem[PlayerAttachItem(playerid,0)][_Name],AttachmentBonesCn[slotid[0]],MallItem[PlayerAttachItem(playerid,1)][_Name],AttachmentBonesCn[slotid[1]],MallItem[PlayerAttachItem(playerid,2)][_Name],AttachmentBonesCn[slotid[2]]);
	}
	return line;
}
stock ReturnPlayerSignName(playerid)
{
	new line[32];
	if(pLang(playerid)==0)format(line,sizeof(line),"%s",Signature[Account[playerid][_SignID]][_CnName]);
	else format(line,sizeof(line),"%s",Signature[Account[playerid][_SignID]][_EnName]);
    return line;
}
stock ReturnPlayerColorShow(playerid)
{
    fLine_64("%s||||||||||",Color[Account[playerid][_NameColor]][_hex_str]);
    return line;
}
stock ReturnPlayerColorSelectShow(playerid)
{
	new string[1024],str[80];
	strcat(string,ReturnMLStr(pLang(playerid),_MENU_COLOR_STR1));
	forex(i,sizeof(Color))
	{
	    format(str,sizeof(str),"%s||||||||||\t${80FF00}%i\n",Color[i][_hex_str],Color[i][_price]);
	    strcat(string,str);
	}
    return string;
}
N::PlayerLevelUpdate(playerid)//每分钟更新等级经验
{
	if(Account[playerid][_Exp]<LevelRank[Account[playerid][_Level]+1][_needexp])Account[playerid][_Exp]++;
	else
	{
	    Account[playerid][_Level]++;
        SetPlayerScore(playerid,Account[playerid][_Level]);
        fLine_128(ReturnMLStr(pLang(playerid),_LEVEL_MSG2),Account[playerid][_Level],LevelRank[Account[playerid][_Level]][_bonus]);
        SendMailToOnlinePlayer(playerid,NONE,MAIL_TYPE_SYSTEM,ReturnMLStr(pLang(playerid),_LEVEL_MSG1),line,LevelRank[Account[playerid][_Level]][_bonus],-1,0,-1);
	}
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_USER"` SET  `等级` = '%i',`经验` = '%i' WHERE  `"MYSQL_DB_USER"`.`编号` ='%i'",Account[playerid][_Level],Account[playerid][_Exp],Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
	UpdatePlayerFaceMenuLevel(playerid,Account[playerid][_Level],Account[playerid][_Exp],LevelRank[Account[playerid][_Level]+1][_needexp]);
	return 1;
}
