public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    foreach(new i:Player)
	{
	    if(Online(i))
	    {
	    	if(GetPlayerState(i)==PLAYER_STATE_SPECTATING&&pSpectateID[i]==playerid)SetPlayerInterior(i,newinteriorid);
		}
	}
    return 1;
}

N::SetPlayerToSpecPlayer(playerid,specplayerid)
{
    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
	PlayerInState[playerid]=PLAYER_IN_SPECPLAYER;
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, specplayerid);
	SetPlayerVirtualWorld(playerid,GameRoom(specplayerid));
	SetPlayerInterior(playerid,0);
	pSpectateID[playerid]=specplayerid;
	return 1;
}
N::SetPlayerNotSpec(playerid)
{
	if(pSpectateID[playerid]!=INVALID_PLAYER_ID)
	{
		PlayerInState[playerid]=PLAYER_IN_WAITLEAVE;
		pSpectateID[playerid]=INVALID_PLAYER_ID;
		TogglePlayerSpectating(playerid, 0);
	}
    return 1;
}
N::ClosePlayerSpectated(playerid)
{
    foreach(new i:Player)
	{
	    if(Online(i))
	    {
	    	if(GetPlayerState(i)==PLAYER_STATE_SPECTATING&&pSpectateID[i]==playerid)SetPlayerNotSpec(playerid);
		}
	}
    return 1;
}
CMD:specp(playerid, params[], help)
{
	new pid;
	if(sscanf(params, "i",pid))return SCM(playerid,-1,"/specp 玩家ID");
	if(!Online(pid))return SCM(playerid,-1,"对方不在线");
    if(pGameID(pid)==NONE||pGameIn(pid)==false)return SCM(playerid,-1,"对方不在游戏房间里");
    SetPlayerToSpecPlayer(playerid,pid);
    return 1;
}
stock ShowGameRooms(playerid,pager)
{
    DialogBoxID[playerid]=1;
	foreach(new i:LastAliveGame)
	{
	    if(LastAliveGame[i][_Ready]==true)
	    {
			DialogBox[playerid][DialogBoxID[playerid]]=i;
			DialogBoxKey[playerid][DialogBoxID[playerid]]=LastAliveGame[i][_Key];
	   		DialogBoxID[playerid]++;
   		}
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_SPEC_MSG1));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
	    new string[128];
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    format(string,sizeof(string),"%i\t%i\n",index+1,GetGameAlivePlayerAmouts(index));
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
stock ShowGameRoomPlayers(playerid,gameid,pager)
{
    DialogBoxID[playerid]=1;
 	foreach(new i:Player)
    {
	    if(Online(i))
		{
		    if(pGameID(i)==gameid&&pGameIn(i)==true)
		    {
				DialogBox[playerid][DialogBoxID[playerid]]=i;
				DialogBoxKey[playerid][DialogBoxID[playerid]]=Account[i][_Key];
		   		DialogBoxID[playerid]++;
	   		}
   		}
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_SPEC_MSG1));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
	    new string[128];
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    format(string,sizeof(string),"%i\t%s%s\n",index,Color[Account[index][_NameColor]][_hex_str],Account[index][_Name]);
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
N::Spec@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
		case _SPEC_ROOMS:
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
						Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(LastAliveGame[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])
						{
							Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						}
						if(!Iter_Contains(LastAliveGame,index))
						{
							Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG5));
						}
						if(LastAliveGame[index][_Ready]==false)
						{
							Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG6));
						}
						SetPVarInt(playerid,"_GameRoom_Index",index);
						SetPVarInt(playerid,"_GameRoom_Key",DialogBoxKey[playerid][pager+listitem-1]);
						Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,index,1),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					}
				}
			}
		}
		case _SPEC_PLAYERS:
		{
			if(response)
			{
			    new gameid=GetPVarInt(playerid,"_GameRoom_Index");
			   	new gameKey=GetPVarInt(playerid,"_GameRoom_Key");
				if(LastAliveGame[gameid][_Key]!=gameKey)
				{
					Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
				}
				if(!Iter_Contains(LastAliveGame,gameid))
				{
					Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG5));
				}
				if(LastAliveGame[gameid][_Ready]==false)
				{
					Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG6));
				}
			   	
				new pager=(DialogPage[playerid]-1)*MAX_BOX_LIST;
				if(pager==0)pager = 1;
				else pager++;
				switch(listitem)
				{
				    case 0:
				  	{
				    	DialogPage[playerid]--;
				    	if(DialogPage[playerid]<1)DialogPage[playerid]=1;
						Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(!Online(index))
						{
						    Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,1),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_OFFLINE));
						}
						if(Account[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])
						{
							Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,1),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						}
						if(pGameID(index)!=gameid||pGameIn(index)==false)
						{
							Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,1),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG8));
						}
						if(pLastAlive[index][_Game_SpectatePlane]==true)
						{
							Dialog@Show(playerid,_SPEC_PLAYERS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG4),ShowGameRoomPlayers(playerid,gameid,1),ReturnMLStr(pLang(playerid),_SPEC_MSG7),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG9));
						}
						SetPlayerToSpecPlayer(playerid,index);
					}
				}
			}
		}
    }
    return 1;
}
