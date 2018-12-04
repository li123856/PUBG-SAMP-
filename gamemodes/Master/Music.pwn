#define MAX_MUSICS 100
enum MusicBox_Info
{
	_Key,
	_Times,
	_Singer[32],
	_Name[32],
	_Link[128]
}
new MusicBox[MAX_MUSICS][MusicBox_Info];
new Iterator:MusicBox<MAX_MUSICS>;
enum pMusic_Info
{
	bool:_Playing,
	_Mode,
	_SongID,
	_Times,
	Timer:_EndTimer
}
new pMusic[MAX_PLAYERS][pMusic_Info];
new Text:MusicPlayerGui[6];
new PlayerText:pSongNameDraw[MAX_PLAYERS];
new PlayerText:pSongerDraw[MAX_PLAYERS];
new PlayerText:pSongTimeDraw[MAX_PLAYERS];
new PlayerText:pSongProgressDraw[MAX_PLAYERS];
new PlayerText:pSongModeDraw[MAX_PLAYERS];

N::DestoryMusicGuiForPlayer(playerid)//删除音乐面板GUI
{
	if(pSongNameDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pSongNameDraw[playerid]);
	pSongNameDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(pSongerDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pSongerDraw[playerid]);
	pSongerDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(pSongTimeDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pSongTimeDraw[playerid]);
	pSongTimeDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(pSongProgressDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pSongProgressDraw[playerid]);
	pSongProgressDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(pSongModeDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pSongModeDraw[playerid]);
	pSongModeDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::UpdateMusicGuiForPlayer(playerid,songname[],songer[],songtime[],modes)//更新曲目信息GUI
{
    if(pSongNameDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongerDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongTimeDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongProgressDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongModeDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
	PlayerTextDrawSetString(playerid,pSongNameDraw[playerid],songname);
	PlayerTextDrawSetString(playerid,pSongerDraw[playerid],songer);
	PlayerTextDrawSetString(playerid,pSongTimeDraw[playerid],songtime);
	switch(modes)
	{
	    case 0:
		{
			PlayerTextDrawSetString(playerid,pSongModeDraw[playerid],"LD_BEAT:square");
			PlayerTextDrawSetSelectable(playerid, pSongModeDraw[playerid], 1);
		}
	    case 1:
		{
			PlayerTextDrawSetString(playerid,pSongModeDraw[playerid],"LD_BEAT:triang");
			PlayerTextDrawSetSelectable(playerid, pSongModeDraw[playerid], 1);
		}
	    case 2:
		{
            PlayerTextDrawSetString(playerid,pSongModeDraw[playerid],"LD_BEAT:circle");
			PlayerTextDrawSetSelectable(playerid, pSongModeDraw[playerid], 1);
		}
	}
	
    PlayerTextDrawDestroy(playerid,pSongProgressDraw[playerid]);
    pSongProgressDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pSongProgressDraw[playerid] = CreatePlayerTextDraw(playerid, 503.000000, 135.000000, "LD_POOL:BALL");
	PlayerTextDrawFont(playerid, pSongProgressDraw[playerid], 4);
	PlayerTextDrawLetterSize(playerid, pSongProgressDraw[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, pSongProgressDraw[playerid], 5.500000, 6.500000);
	PlayerTextDrawSetOutline(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pSongProgressDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongProgressDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pSongProgressDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongProgressDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongProgressDraw[playerid], 0);
	
	PlayerTextDrawShow(playerid,pSongNameDraw[playerid]);
	PlayerTextDrawShow(playerid,pSongerDraw[playerid]);
	PlayerTextDrawShow(playerid,pSongTimeDraw[playerid]);
	PlayerTextDrawShow(playerid,pSongModeDraw[playerid]);
	PlayerTextDrawShow(playerid,pSongProgressDraw[playerid]);
	return 1;
}
N::UpdateMusicTimeGuiForPlayer(playerid,Float:_size,songtime[])//更新曲目进度条
{
    if(pSongNameDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongerDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongTimeDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongProgressDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    if(pSongModeDraw[playerid]==PlayerText:INVALID_TEXT_DRAW)return 1;
    PlayerTextDrawSetString(playerid,pSongTimeDraw[playerid],songtime);
    
    PlayerTextDrawDestroy(playerid,pSongProgressDraw[playerid]);
    pSongProgressDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pSongProgressDraw[playerid] = CreatePlayerTextDraw(playerid, 503.000000+_size, 135.000000, "LD_POOL:BALL");
	PlayerTextDrawFont(playerid, pSongProgressDraw[playerid], 4);
	PlayerTextDrawLetterSize(playerid, pSongProgressDraw[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, pSongProgressDraw[playerid], 5.500000, 6.500000);
	PlayerTextDrawSetOutline(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pSongProgressDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongProgressDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pSongProgressDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongProgressDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongProgressDraw[playerid], 0);
	
	PlayerTextDrawShow(playerid,pSongTimeDraw[playerid]);
	PlayerTextDrawShow(playerid,pSongProgressDraw[playerid]);
	return 1;
}
N::CreateMusicGuiForPlayer(playerid)//创建音乐播放器GUI
{
    DestoryMusicGuiForPlayer(playerid);
	pSongNameDraw[playerid] = CreatePlayerTextDraw(playerid, 502.000000, 107.000000, "All the things she said");
	PlayerTextDrawFont(playerid, pSongNameDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pSongNameDraw[playerid], 0.166666, 1.349997);
	PlayerTextDrawTextSize(playerid, pSongNameDraw[playerid], 636.000000, 110.000000);
	PlayerTextDrawSetOutline(playerid, pSongNameDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, pSongNameDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongNameDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongNameDraw[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, pSongNameDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongNameDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongNameDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pSongNameDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongNameDraw[playerid], 0);

	pSongerDraw[playerid] = CreatePlayerTextDraw(playerid, 604.000000, 120.000000, "- t.A.T.u.");
	PlayerTextDrawFont(playerid, pSongerDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pSongerDraw[playerid], 0.166666, 1.349997);
	PlayerTextDrawTextSize(playerid, pSongerDraw[playerid], 636.000000, 110.000000);
	PlayerTextDrawSetOutline(playerid, pSongerDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, pSongerDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongerDraw[playerid], 3);
	PlayerTextDrawColor(playerid, pSongerDraw[playerid], -16776961);
	PlayerTextDrawBackgroundColor(playerid, pSongerDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongerDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongerDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pSongerDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongerDraw[playerid], 0);

	pSongTimeDraw[playerid] = CreatePlayerTextDraw(playerid, 502.000000, 143.000000, "00:00");
	PlayerTextDrawFont(playerid, pSongTimeDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pSongTimeDraw[playerid], 0.220833, 1.100000);
	PlayerTextDrawTextSize(playerid, pSongTimeDraw[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pSongTimeDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, pSongTimeDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongTimeDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongTimeDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pSongTimeDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongTimeDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongTimeDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pSongTimeDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongTimeDraw[playerid], 0);

	pSongProgressDraw[playerid] = CreatePlayerTextDraw(playerid, 503.000000, 132.800000, "LD_POOL:BALL");
	PlayerTextDrawFont(playerid, pSongProgressDraw[playerid], 4);
	PlayerTextDrawLetterSize(playerid, pSongProgressDraw[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, pSongProgressDraw[playerid], 5.500000, 6.500000);
	PlayerTextDrawSetOutline(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pSongProgressDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongProgressDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pSongProgressDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongProgressDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, pSongProgressDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongProgressDraw[playerid], 0);
	
	pSongModeDraw[playerid] = CreatePlayerTextDraw(playerid, 560.000000, 141.000000, "ld_beat:cring");
	PlayerTextDrawFont(playerid, pSongModeDraw[playerid], 4);
	PlayerTextDrawLetterSize(playerid, pSongModeDraw[playerid], 0.600000, 4.049998);
	PlayerTextDrawTextSize(playerid, pSongModeDraw[playerid], 12.000000, 12.500000);
	PlayerTextDrawSetOutline(playerid, pSongModeDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pSongModeDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, pSongModeDraw[playerid], 1);
	PlayerTextDrawColor(playerid, pSongModeDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pSongModeDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pSongModeDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, pSongModeDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pSongModeDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pSongModeDraw[playerid], 1);
	return 1;
}
N::MusicPlayerGuiInt()//创建音乐播放器GUI
{
	MusicPlayerGui[0] = TextDrawCreate(553.000000, 104.000000, "~n~");
	TextDrawFont(MusicPlayerGui[0], 1);
	TextDrawLetterSize(MusicPlayerGui[0], -0.033332, 5.549990);
	TextDrawTextSize(MusicPlayerGui[0], 585.500000, 107.000000);
	TextDrawSetOutline(MusicPlayerGui[0], 1);
	TextDrawSetShadow(MusicPlayerGui[0], 0);
	TextDrawAlignment(MusicPlayerGui[0], 2);
	TextDrawColor(MusicPlayerGui[0], -1);
	TextDrawBackgroundColor(MusicPlayerGui[0], 255);
	TextDrawBoxColor(MusicPlayerGui[0], -206);
	TextDrawUseBox(MusicPlayerGui[0], 1);
	TextDrawSetProportional(MusicPlayerGui[0], 1);
	TextDrawSetSelectable(MusicPlayerGui[0], 0);

	MusicPlayerGui[1] = TextDrawCreate(500.000000, 104.000000, "LD_SPAC:backgnd");
	TextDrawFont(MusicPlayerGui[1], 4);
	TextDrawLetterSize(MusicPlayerGui[1], 0.600000, 2.000000);
	TextDrawTextSize(MusicPlayerGui[1], 106.000000, 50.000000);
	TextDrawSetOutline(MusicPlayerGui[1], 1);
	TextDrawSetShadow(MusicPlayerGui[1], 0);
	TextDrawAlignment(MusicPlayerGui[1], 1);
	TextDrawColor(MusicPlayerGui[1], -1);
	TextDrawBackgroundColor(MusicPlayerGui[1], 255);
	TextDrawBoxColor(MusicPlayerGui[1], 50);
	TextDrawUseBox(MusicPlayerGui[1], 1);
	TextDrawSetProportional(MusicPlayerGui[1], 1);
	TextDrawSetSelectable(MusicPlayerGui[1], 0);

	MusicPlayerGui[2] = TextDrawCreate(580.000000, 140.000000, "<");
	TextDrawFont(MusicPlayerGui[2], 2);
	TextDrawLetterSize(MusicPlayerGui[2], 0.300000, 1.600000);
	TextDrawTextSize(MusicPlayerGui[2], 400.000000, 6.000000);
	TextDrawSetOutline(MusicPlayerGui[2], 1);
	TextDrawSetShadow(MusicPlayerGui[2], 0);
	TextDrawAlignment(MusicPlayerGui[2], 2);
	TextDrawColor(MusicPlayerGui[2], -1);
	TextDrawBackgroundColor(MusicPlayerGui[2], 255);
	TextDrawBoxColor(MusicPlayerGui[2], 50);
	TextDrawUseBox(MusicPlayerGui[2], 0);
	TextDrawSetProportional(MusicPlayerGui[2], 1);
	TextDrawSetSelectable(MusicPlayerGui[2], 1);

	MusicPlayerGui[3] = TextDrawCreate(590.000000, 139.000000, "II");
	TextDrawFont(MusicPlayerGui[3], 2);
	TextDrawLetterSize(MusicPlayerGui[3], 0.300000, 1.600000);
	TextDrawTextSize(MusicPlayerGui[3], 400.000000, 6.000000);
	TextDrawSetOutline(MusicPlayerGui[3], 1);
	TextDrawSetShadow(MusicPlayerGui[3], 0);
	TextDrawAlignment(MusicPlayerGui[3], 2);
	TextDrawColor(MusicPlayerGui[3], -1);
	TextDrawBackgroundColor(MusicPlayerGui[3], 255);
	TextDrawBoxColor(MusicPlayerGui[3], 50);
	TextDrawUseBox(MusicPlayerGui[3], 0);
	TextDrawSetProportional(MusicPlayerGui[3], 1);
	TextDrawSetSelectable(MusicPlayerGui[3], 1);

	MusicPlayerGui[4] = TextDrawCreate(600.000000, 140.000000, ">");
	TextDrawFont(MusicPlayerGui[4], 2);
	TextDrawLetterSize(MusicPlayerGui[4], 0.300000, 1.600000);
	TextDrawTextSize(MusicPlayerGui[4], 400.000000, 6.000000);
	TextDrawSetOutline(MusicPlayerGui[4], 1);
	TextDrawSetShadow(MusicPlayerGui[4], 0);
	TextDrawAlignment(MusicPlayerGui[4], 2);
	TextDrawColor(MusicPlayerGui[4], -1);
	TextDrawBackgroundColor(MusicPlayerGui[4], 255);
	TextDrawBoxColor(MusicPlayerGui[4], 50);
	TextDrawUseBox(MusicPlayerGui[4], 0);
	TextDrawSetProportional(MusicPlayerGui[4], 1);
	TextDrawSetSelectable(MusicPlayerGui[4], 1);

	MusicPlayerGui[5] = TextDrawCreate(505.000000, 139.000000, "~n~");
	TextDrawFont(MusicPlayerGui[5], 2);
	TextDrawLetterSize(MusicPlayerGui[5], 0.300000, -0.299999);
	TextDrawTextSize(MusicPlayerGui[5], 602.000000, 97.500000);
	TextDrawSetOutline(MusicPlayerGui[5], 1);
	TextDrawSetShadow(MusicPlayerGui[5], 0);
	TextDrawAlignment(MusicPlayerGui[5], 1);
	TextDrawColor(MusicPlayerGui[5], -1);
	TextDrawBackgroundColor(MusicPlayerGui[5], 255);
	TextDrawBoxColor(MusicPlayerGui[5], -1);
	TextDrawUseBox(MusicPlayerGui[5], 1);
	TextDrawSetProportional(MusicPlayerGui[5], 1);
	TextDrawSetSelectable(MusicPlayerGui[5], 0);
	return 1;
}
CMD:restml(playerid, params[], help)//Mysql读取并更新数组内曲目数据
{
    Iter_Clear(MusicBox);
    DB_LoadMusicBoxs();
	return 1;
}
N::DB_LoadMusicBoxs()//Mysql读取曲目数据到数组内
{
	new Query[64];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_SEVRVER_MUSIC"`");
    mysql_tquery(Set@Handle,Query, "OnMusicBoxsLoad");
}
N::OnMusicBoxsLoad()//Mysql读取曲目数据到数组内
{
    forex(i,cache_num_rows())
	{
	    if(i<MAX_MUSICS)
	    {
	    	MusicBox[i][_Key]=cache_get_field_content_int(i,"编号",Set@Handle);
			MusicBox[i][_Times]=cache_get_field_content_int(i,"歌曲时间",Set@Handle);
			cache_get_field_content(i,"演唱者",MusicBox[i][_Singer],Set@Handle,32);
			cache_get_field_content(i,"歌曲名",MusicBox[i][_Name],Set@Handle,32);
			cache_get_field_content(i,"歌曲链接",MusicBox[i][_Link],Set@Handle,128);
			Iter_Add(MusicBox,i);
		}
		else
		{
			printf("音乐盒数据溢出[%i],请修改MAX_MUSICS",MAX_MUSICS);
			break;
		}
	}
	return 1;
}
N::ShowPlayerMusicBox(playerid,index)//显示播放器GUI给玩家
{
    forex(i,sizeof(MusicPlayerGui))TextDrawShowForPlayer(playerid,MusicPlayerGui[i]);
    UpdateMusicGuiForPlayer(playerid,MusicBox[index][_Name],MusicBox[index][_Singer],ReturnCountDownStr(pMusic[playerid][_Times]),pMusic[playerid][_Mode]);
	return 1;
}
N::HidePlayerMusicBox(playerid)//隐藏播放器GUI给玩家
{
	forex(i,sizeof(MusicPlayerGui))TextDrawHideForPlayer(playerid,MusicPlayerGui[i]);
	PlayerTextDrawHide(playerid,pSongNameDraw[playerid]);
	PlayerTextDrawHide(playerid,pSongerDraw[playerid]);
	PlayerTextDrawHide(playerid,pSongTimeDraw[playerid]);
	PlayerTextDrawHide(playerid,pSongModeDraw[playerid]);
	PlayerTextDrawHide(playerid,pSongProgressDraw[playerid]);
	return 1;
}
N::StopMusicForPlayer(playerid)//停止并隐藏玩家的音乐
{
    if(pMusic[playerid][_Playing]==true)
    {
	    StopAudioStreamForPlayer(playerid);
		pMusic[playerid][_Playing]=false;
		pMusic[playerid][_SongID]=0;
		if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
		pMusic[playerid][Timer:_EndTimer]=NONE;
		HidePlayerMusicBox(playerid);
		SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG11));
	}
	return 1;
}
N::Music@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)//按键触发音乐菜单
{
	if(PRESSED(KEY_ANALOG_RIGHT))
	{
        if(PlayerInState[playerid]==PLAYER_IN_WAITROOM||PlayerInState[playerid]==PLAYER_IN_GAMEROOM)
		{
			Dialog@Show(playerid,_MUSIC_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_MUSIC_MSG4),ShowMusicBoxSongs(playerid,1),ReturnMLStr(pLang(playerid),_MUSIC_MSG2),ReturnMLStr(pLang(playerid),_MUSIC_MSG3));
			SelectTextDraw(playerid,0xFFFFFFC8);
	    	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG13));
	    	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG14));
        }
    }
	return 1;
}
N::PlayerRandMusicForPlayer(playerid)//给玩家播放一首随机音乐
{
	new index=Iter_Random(MusicBox);
	PlayAudioStreamForPlayer(playerid,MusicBox[index][_Link]);
	pMusic[playerid][_Playing]=true;
	pMusic[playerid][_SongID]=index;
	if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
	pMusic[playerid][Timer:_EndTimer]=NONE;
	pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	pMusic[playerid][_Times]=0;
    ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
	return 1;
}
N::Music@OnPlayerConnect(playerid)
{
	pMusic[playerid][_Playing]=false;
	pMusic[playerid][_Mode]=0;
	pMusic[playerid][_SongID]=0;
	pMusic[playerid][_Times]=0;
	pMusic[playerid][Timer:_EndTimer]=NONE;
	CreateMusicGuiForPlayer(playerid);
	return 1;
}
N::Music@OnPlayerDisconnect(playerid,reason)
{
	pMusic[playerid][_Playing]=false;
	pMusic[playerid][_Mode]=0;
	pMusic[playerid][_SongID]=0;
	pMusic[playerid][_Times]=0;
	if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
	pMusic[playerid][Timer:_EndTimer]=NONE;
	DestoryMusicGuiForPlayer(playerid);
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
//加入下面代码
		if(clickedid == MusicPlayerGui[3])//关闭
		{
		    if(pMusic[playerid][_Playing]==true)
		    {
				StopMusicForPlayer(playerid);
				CancelSelectTextDraw(playerid);
				return 1;
			}
			else
			{
			    new index=pMusic[playerid][_SongID];
				PlayAudioStreamForPlayer(playerid,MusicBox[index][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=index;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                pMusic[playerid][_Times]=0;
                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
                return 1;
			}
		}
		if(clickedid == MusicPlayerGui[4])//前进
		{
		    if(pMusic[playerid][_Playing]==true)ChangePlayerMusicEx(playerid,0);
		    return 1;
		}
		if(clickedid == MusicPlayerGui[2])//后退
		{
		    if(pMusic[playerid][_Playing]==true)ChangePlayerMusicEx(playerid,1);
		    return 1;
		}
}
N::Music@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case _MUSIC_LIST:
        {
			if(response)
			{
				new pager=(DialogPage[playerid]-1)*MAX_BOX_LIST;
				if(pager==0)pager = 1;
				else pager++;
				switch(listitem)
				{
				    case 0:
				  	{
				    	DialogPage[playerid]--;
				    	if(DialogPage[playerid]<1)DialogPage[playerid]=1;
				    	Dialog@Show(playerid,_MUSIC_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_MUSIC_MSG4),ShowMusicBoxSongs(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MUSIC_MSG2),ReturnMLStr(pLang(playerid),_MUSIC_MSG3));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_MUSIC_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_MUSIC_MSG4),ShowMusicBoxSongs(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MUSIC_MSG2),ReturnMLStr(pLang(playerid),_MUSIC_MSG3));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(MusicBox[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
                        //StopAudioStreamForPlayer(playerid);
						PlayAudioStreamForPlayer(playerid,MusicBox[index][_Link]);
						pMusic[playerid][_Playing]=true;
						pMusic[playerid][_SongID]=index;
						if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
						pMusic[playerid][Timer:_EndTimer]=NONE;
						pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                        pMusic[playerid][_Times]=0;
                        ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
						fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
				       	SCM(playerid,-1,line);
					}
				}
			}
        }
    }
    return 1;
}
N::ChangePlayerMusicEx(playerid,modes)//曲目变化[手动]0前进 1后退 2循环
{
	switch(modes)
	{
	    case 0:
		{
		    new NextSongID=Iter_Next(MusicBox,pMusic[playerid][_SongID]);
		    if(!Iter_Contains(MusicBox,NextSongID))
		    {
				PlayAudioStreamForPlayer(playerid,MusicBox[0][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=0;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                pMusic[playerid][_Times]=0;
                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
                SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG6));
		      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		    else
		    {
				PlayAudioStreamForPlayer(playerid,MusicBox[NextSongID][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=NextSongID;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                pMusic[playerid][_Times]=0;
                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
				fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		}
	    case 1:
		{
	        new PrevSongID=Iter_Prev(MusicBox,pMusic[playerid][_SongID]);
		    if(!Iter_Contains(MusicBox,PrevSongID))
		    {
		        PrevSongID=Iter_Last(MusicBox);
				PlayAudioStreamForPlayer(playerid,MusicBox[PrevSongID][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=PrevSongID;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                pMusic[playerid][_Times]=0;
				ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
                SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG7));
		      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		    else
		    {
				PlayAudioStreamForPlayer(playerid,MusicBox[PrevSongID][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=PrevSongID;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
                pMusic[playerid][_Times]=0;
				ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
		      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		}
	    case 2:
	    {
	        new SongID=pMusic[playerid][_SongID];
			PlayAudioStreamForPlayer(playerid,MusicBox[SongID][_Link]);
			pMusic[playerid][_Playing]=true;
			pMusic[playerid][_SongID]=SongID;
			if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
			pMusic[playerid][Timer:_EndTimer]=NONE;
			pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
            pMusic[playerid][_Times]=0;
			ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
	      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
	       	SCM(playerid,-1,line);
	    }
	}
    return 1;
}
N::ChangePlayerMusic(playerid,modes)//曲目变化[自动]0前进 1后退 2循环
{
    pMusic[playerid][_Times]++;
    UpdateMusicTimeGuiForPlayer(playerid,floatmul(floatdiv(pMusic[playerid][_Times],MusicBox[pMusic[playerid][_SongID]][_Times]),97.0),ReturnCountDownStr(pMusic[playerid][_Times]));
    if(pMusic[playerid][_Times]>=MusicBox[pMusic[playerid][_SongID]][_Times])
    {
		switch(pMusic[playerid][_Mode])
		{
		    case 0:
			{
			    new NextSongID=Iter_Next(MusicBox,pMusic[playerid][_SongID]);
			    if(!Iter_Contains(MusicBox,NextSongID))
			    {
					PlayAudioStreamForPlayer(playerid,MusicBox[0][_Link]);
					pMusic[playerid][_Playing]=true;
					pMusic[playerid][_SongID]=0;
					if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
					pMusic[playerid][Timer:_EndTimer]=NONE;
					pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	                pMusic[playerid][_Times]=0;
	                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
	                SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG6));
			      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
			       	SCM(playerid,-1,line);
			    }
			    else
			    {
					PlayAudioStreamForPlayer(playerid,MusicBox[NextSongID][_Link]);
					pMusic[playerid][_Playing]=true;
					pMusic[playerid][_SongID]=NextSongID;
					if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
					pMusic[playerid][Timer:_EndTimer]=NONE;
					pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	                pMusic[playerid][_Times]=0;
	                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
					fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
			       	SCM(playerid,-1,line);
			    }
			}
		    case 1:
			{
		        new PrevSongID=Iter_Prev(MusicBox,pMusic[playerid][_SongID]);
			    if(!Iter_Contains(MusicBox,PrevSongID))
			    {
			        PrevSongID=Iter_Last(MusicBox);
					PlayAudioStreamForPlayer(playerid,MusicBox[PrevSongID][_Link]);
					pMusic[playerid][_Playing]=true;
					pMusic[playerid][_SongID]=PrevSongID;
					if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
					pMusic[playerid][Timer:_EndTimer]=NONE;
					pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	                pMusic[playerid][_Times]=0;
	                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
	                SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MUSIC_MSG7));
			      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
			       	SCM(playerid,-1,line);
			    }
			    else
			    {
					PlayAudioStreamForPlayer(playerid,MusicBox[PrevSongID][_Link]);
					pMusic[playerid][_Playing]=true;
					pMusic[playerid][_SongID]=PrevSongID;
					if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
					pMusic[playerid][Timer:_EndTimer]=NONE;
					pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	                pMusic[playerid][_Times]=0;
	                ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
			      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
			       	SCM(playerid,-1,line);
			    }
			}
		    case 2:
		    {
		        new SongID=pMusic[playerid][_SongID];
				PlayAudioStreamForPlayer(playerid,MusicBox[SongID][_Link]);
				pMusic[playerid][_Playing]=true;
				pMusic[playerid][_SongID]=SongID;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				pMusic[playerid][Timer:_EndTimer]=SetTimerEx("ChangePlayerMusic",1000,true,"ii",playerid,pMusic[playerid][_Mode]);
	            pMusic[playerid][_Times]=0;
	            ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
		      	fLine_256(ReturnMLStr(pLang(playerid),_MUSIC_MSG5),pMusic[playerid][_SongID]+1,MusicBox[pMusic[playerid][_SongID]][_Name],MusicBox[pMusic[playerid][_SongID]][_Singer],GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		}
	}
	return 1;
}
stock GetMusicModeName(playerid,modes)//获取当前循环模式名称
{
	new Line[32];
	switch(modes)
	{
	    case 0:format(Line,sizeof(Line), ReturnMLStr(pLang(playerid),_MUSIC_MSG8));
	    case 1:format(Line,sizeof(Line), ReturnMLStr(pLang(playerid),_MUSIC_MSG9));
	    case 2:format(Line,sizeof(Line), ReturnMLStr(pLang(playerid),_MUSIC_MSG10));
	}
	return Line;
}
stock ShowMusicBoxSongs(playerid,pager)//显示曲目的动态列表
{
    DialogBoxID[playerid]=1;
 	foreach(new i:MusicBox)
    {
		DialogBox[playerid][DialogBoxID[playerid]]=i;
		DialogBoxKey[playerid][DialogBoxID[playerid]]=MusicBox[i][_Key];
   		DialogBoxID[playerid]++;
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_MUSIC_MSG1));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
	    new string[128];
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    format(string,sizeof(string),"%s\t%s\n",MusicBox[index][_Name],MusicBox[index][_Singer]);
		}
		if(i>=DialogBoxID[playerid])
		{
			end=1;
			break;
		}
		else strcat(body,string);
	}
	if(!end)strcat(body, ReturnMLStr(pLang(playerid),_NEXT_PAGE));
    return body;
}
