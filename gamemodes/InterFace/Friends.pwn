N::PlayerFriendRest(playerid)
{
   	Iter_Clear(pFriends[playerid]);
	return 1;
}
N::DB_LoadPlayerFriends(playerid)
{
	new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_FRIEND"` WHERE `ÕÊº“πÈ Ù`=%i ORDER BY `"MYSQL_DB_FRIEND"`.`±‡∫≈` ASC",Account[playerid][_Key]);
    mysql_tquery(User@Handle,Query, "OnPlayerFriendsLoad", "i",playerid);
}
N::OnPlayerFriendsLoad(playerid)
{
    forex(i,cache_num_rows())
	{
	    if(i<MAX_PLAYER_FRIENDS)
	    {
	    	pFriends[playerid][i][_Key]=cache_get_field_content_int(i,"±‡∫≈",User@Handle);
			pFriends[playerid][i][_Owner_Key]=cache_get_field_content_int(i,"ÕÊº“πÈ Ù",User@Handle);
			pFriends[playerid][i][_Friend_Key]=cache_get_field_content_int(i,"∫√”—πÈ Ù",User@Handle);
			Iter_Add(pFriends[playerid],i);
		}
		else
		{
		    printf("%s µƒ∫√”— ˝æ›“Á≥ˆ[%i],«Î–ﬁ∏ƒMAX_PLAYER_FRIENDS",Account[playerid][_Name],MAX_PLAYER_FRIENDS);
			break;
		}
	}
	UpdatePlayerFriendsBotton(playerid);
	return 1;
}

N::AddPlayerOffLineFriend(playerid,otherplayerKey)
{
    if(!Online(playerid))return FRIEND_NOT_ONLINE;
    if(GetKeyPlayerID(otherplayerKey)!=NONE)return FRIEND_ERROR;
	if(!IsPlayerKeyFexist(otherplayerKey))return FRIEND_NOT_EXIST;
	foreach(new i:pFriends[playerid])if(pFriends[playerid][i][_Friend_Key]==otherplayerKey)return FRIEND_EXIST;
	if(IsPlayerKeyFriendFexist(otherplayerKey,Account[playerid][_Key]))return FRIEND_EXIST;
    if(Iter_Count(pFriends[playerid])>=MAX_PLAYER_FRIENDS)return FRIEND_FULL;
    if(GetPlayerKeyFriendAmount(otherplayerKey)>=MAX_PLAYER_FRIENDS)return FRIEND_FULL;
    
    
	new i=Iter_Free(pFriends[playerid]);
	pFriends[playerid][i][_Owner_Key]=Account[playerid][_Key];
	pFriends[playerid][i][_Friend_Key]=otherplayerKey;
	Iter_Add(pFriends[playerid],i);

	new Query[512];
	format(Query, sizeof(Query),\
	"INSERT INTO `"MYSQL_DB_FRIEND"` (\
	`ÕÊº“πÈ Ù`,`∫√”—πÈ Ù`) VALUES \
	('%i','%i')",\
	pFriends[playerid][i][_Owner_Key],\
	pFriends[playerid][i][_Friend_Key]);
	mysql_query(User@Handle,Query,true);
	pFriends[playerid][i][_Key]=cache_insert_id();
/*********************************************************************/
	format(Query, sizeof(Query),\
	"INSERT INTO `"MYSQL_DB_FRIEND"` (\
	`ÕÊº“πÈ Ù`,`∫√”—πÈ Ù`) VALUES \
	('%i','%i')",\
	otherplayerKey,\
	Account[playerid][_Key]);
	mysql_query(User@Handle,Query,true);
	
	UpdatePlayerFriendsBotton(playerid);
	return FRIEND_SUCCESS;
}
N::AddPlayerOnLineFriend(playerid,otherplayerid)
{
    if(!Online(playerid)||!Online(otherplayerid))return FRIEND_NOT_ONLINE;
    foreach(new i:pFriends[playerid])if(pFriends[playerid][i][_Friend_Key]==Account[otherplayerid][_Key])return FRIEND_EXIST;
    foreach(new i:pFriends[otherplayerid])if(pFriends[otherplayerid][i][_Friend_Key]==Account[playerid][_Key])return FRIEND_EXIST;
    if(Iter_Count(pFriends[playerid])>=MAX_PLAYER_FRIENDS)return FRIEND_FULL;
	if(Iter_Count(pFriends[otherplayerid])>=MAX_PLAYER_FRIENDS)return FRIEND_FULL;
/*********************************************************************/
	new i=Iter_Free(pFriends[playerid]);
	pFriends[playerid][i][_Owner_Key]=Account[playerid][_Key];
	pFriends[playerid][i][_Friend_Key]=Account[otherplayerid][_Key];
	Iter_Add(pFriends[playerid],i);
	
	new Query[512];
	format(Query, sizeof(Query),\
	"INSERT INTO `"MYSQL_DB_FRIEND"` (\
	`ÕÊº“πÈ Ù`,`∫√”—πÈ Ù`) VALUES \
	('%i','%i')",\
	pFriends[playerid][i][_Owner_Key],\
	pFriends[playerid][i][_Friend_Key]);
	mysql_query(User@Handle,Query,true);
	pFriends[playerid][i][_Key]=cache_insert_id();
/*********************************************************************/
	new s=Iter_Free(pFriends[otherplayerid]);
	pFriends[otherplayerid][s][_Owner_Key]=Account[otherplayerid][_Key];
	pFriends[otherplayerid][s][_Friend_Key]=Account[playerid][_Key];
	Iter_Add(pFriends[otherplayerid],s);
	
	format(Query, sizeof(Query),\
	"INSERT INTO `"MYSQL_DB_FRIEND"` (\
	`ÕÊº“πÈ Ù`,`∫√”—πÈ Ù`) VALUES \
	('%i','%i')",\
	pFriends[otherplayerid][s][_Owner_Key],\
	pFriends[otherplayerid][s][_Friend_Key]);
	mysql_query(User@Handle,Query,true);
	pFriends[otherplayerid][s][_Key]=cache_insert_id();
/*********************************************************************/
	UpdatePlayerFriendsBotton(playerid);
	UpdatePlayerFriendsBotton(otherplayerid);
	return FRIEND_SUCCESS;
}
N::DeletePlayerFriend(playerid,playerindex)
{
    if(!Iter_Contains(pFriends[playerid],playerindex))return FRIEND_NOT_EXIST;
	new FriendPlayerid=GetKeyPlayerID(pFriends[playerid][playerindex][_Friend_Key]);
    if(FriendPlayerid!=NONE)
    {
	   	foreach(new i:pFriends[FriendPlayerid])
		{
            if(pFriends[FriendPlayerid][i][_Friend_Key]==Account[FriendPlayerid][_Key])
            {
                new	cur = i;
   				Iter_SafeRemove(pFriends[FriendPlayerid],cur,i);
				UpdatePlayerFriendsBotton(FriendPlayerid);
            }
        }
    }
	new Query[256];
	format(Query, sizeof(Query), "DELETE FROM `"MYSQL_DB_FRIEND"` WHERE `ÕÊº“πÈ Ù` = '%i' AND `∫√”—πÈ Ù` = '%i'",pFriends[playerid][playerindex][_Friend_Key],Account[playerid][_Key]);
	mysql_query(User@Handle,Query);


	format(Query,sizeof(Query),"DELETE FROM `"MYSQL_DB_FRIEND"` WHERE `ÕÊº“πÈ Ù` = '%i' AND `∫√”—πÈ Ù` = '%i'",Account[playerid][_Key],pFriends[playerid][playerindex][_Friend_Key]);
	mysql_query(User@Handle,Query);

    Iter_Remove(pFriends[playerid],playerindex);
    
    UpdatePlayerFriendsBotton(playerid);
	return FRIEND_SUCCESS;
}
N::IsPlayerKeyFriendFexist(playerkey,friendkey)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT * FROM `"MYSQL_DB_FRIEND"` WHERE `ÕÊº“πÈ Ù` = '%i' AND `∫√”—πÈ Ù` = '%i' LIMIT 1",playerkey,friendkey);
	mysql_query(User@Handle,Query);
	return cache_get_row_count(User@Handle);
}
N::GetPlayerKeyFriendAmount(playerkey)
{
    new Query[128];
	format(Query, sizeof(Query), "SELECT * FROM `"MYSQL_DB_FRIEND"` WHERE `ÕÊº“πÈ Ù` = '%i' LIMIT 1",playerkey);
	mysql_query(User@Handle,Query);
	return cache_get_row_count(User@Handle);
}
/***********************************************************************/
stock ShowPlayerFriends(playerid,pager)
{
    DialogBoxID[playerid]=1;
	foreach(new i:pFriends[playerid])
	{
	    if(GetKeyPlayerID(pFriends[playerid][i][_Friend_Key])!=NONE)
		{
			DialogBox[playerid][DialogBoxID[playerid]]=i;
			DialogBoxKey[playerid][DialogBoxID[playerid]]=pFriends[playerid][i][_Key];
	   		DialogBoxID[playerid]++;
   		}
	}
	foreach(new i:pFriends[playerid])
	{
		if(GetKeyPlayerID(pFriends[playerid][i][_Friend_Key])==NONE)
		{
			DialogBox[playerid][DialogBoxID[playerid]]=i;
			DialogBoxKey[playerid][DialogBoxID[playerid]]=pFriends[playerid][i][_Key];
	   		DialogBoxID[playerid]++;
   		}
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG2));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	new string[128],str[64];
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    new pid=GetKeyPlayerID(pFriends[playerid][index][_Friend_Key]);
		    if(pid==NONE)
			{
				format(string,sizeof(string),"{408080}%s\t \n",Select@GetPlayerNameByKey(pFriends[playerid][index][_Friend_Key]));
			}
			else
			{
				switch(PlayerInState[pid])
				{
					case PLAYER_IN_NULL:format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT1));
					case PLAYER_IN_INTERFACE:format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT2));
					case PLAYER_IN_WAITROOM:
					{
					    switch(PlayerInStateID[playerid])
					    {
					        case 0:format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT3),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG17));
					        default:
							{
							    new srt1[32];
								format(srt1,sizeof(srt1),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG18),PlayerInStateID[index]);
								format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT3),srt1);
	                        }
					    }
    				}
					case PLAYER_IN_GAMEROOM:
					{
						format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT4),pGameID(index));
					}
					case PLAYER_IN_WAITLEAVE:format(str,sizeof(str),ReturnMLStr(pLang(playerid),_PLAYER_LOCAT5));
				}
				format(string,sizeof(string),"{FFFFFF}%s\t%s\n",Select@GetPlayerNameByKey(pFriends[playerid][index][_Friend_Key]),str);
			}
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
N::Friend@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case _MY_FRIENDS_LIST:
        {
			if(response)
			{
			    new index=GetPVarInt(playerid,"_Friends_Index");
			    new key=GetPVarInt(playerid,"_Friends_Key");
			    if(pFriends[playerid][index][_Key]!=key)
				{
				    Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
				}
				switch(listitem)
				{
				    case 0:
				    {
						if(pTeam[playerid]!=NONE)
						{
							if(Teams[pTeam[playerid]][_TeamOwnerKey]==Account[playerid][_Key])
                			{
						        new pid=GetKeyPlayerID(pFriends[playerid][index][_Friend_Key]);
						        if(pid==NONE)
						        {
								    Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
									return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_EMAIL1));
						        }
						        fLine_128(ReturnMLStr(pLang(playerid),_TEAM_EMAIL2),Account[playerid][_Name]);
						        if(SendMailToOnlinePlayer(pid,playerid,MAIL_TYPE_TEAM,"∫√”—◊È∂”—˚«Î",line,0,NONE,0,Teams[pTeam[playerid]][_Key])==MAIL_SUCCESS)SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_EMAIL3));
								else
								{
									Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
									return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_EMAIL4));
								}
							}
							else
							{
								Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
								SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG13));
							}
						}
						else
						{
							Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG2));
                        }
				    }
				    case 1:
				    {
				        if(DeletePlayerFriend(playerid,index)==FRIEND_SUCCESS)SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_LIST5));
				        else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_LIST6));
				    }
				}
			}
			else Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
        }
        case _MY_FRIENDS:
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
				    	Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(pFriends[playerid][index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						SetPVarInt(playerid,"_Friends_Index",index);
						SetPVarInt(playerid,"_Friends_Key",DialogBoxKey[playerid][pager+listitem-1]);
						fLine_64(ReturnMLStr(pLang(playerid),_FRIEND_LIST2),Select@GetPlayerNameByKey(pFriends[playerid][index][_Friend_Key]));
						Dialog@Show(playerid,_MY_FRIENDS_LIST,DIALOG_STYLE_LIST,line,ReturnMLStr(pLang(playerid),_FRIEND_LIST1),ReturnMLStr(pLang(playerid),_FRIEND_LIST3),ReturnMLStr(pLang(playerid),_FRIEND_LIST4));
					}
				}
			}
			else Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
        }
        case _ONLINE_ADD_FRIEND:
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
				    	Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(!Online(index))
						{
						    Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_OFFLINE));
						}
						if(Account[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])
						{
						    Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						}
						SetPVarInt(playerid,"_Onlines_AddFriend_Index",index);
						SetPVarInt(playerid,"_Onlines_AddFriend_Key",DialogBoxKey[playerid][pager+listitem-1]);
						fLine_64(ReturnMLStr(pLang(playerid),_ONLINES_ADDFRIEND2),Account[index][_Name]);
						Dialog@Show(playerid,_ONLINE_ADDFRIENDS_TIP,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_ONLINES_ADDFRIEND1),line,ReturnMLStr(pLang(playerid),_ONLINES_ADDFRIEND3),ReturnMLStr(pLang(playerid),_ONLINES_ADDFRIEND4));
					}
				}
			}
        }
        case _ONLINE_ADDFRIENDS_TIP:
        {
			if(response)
			{
			    new index=GetPVarInt(playerid,"_Onlines_AddFriend_Index");
			    new key=GetPVarInt(playerid,"_Onlines_AddFriend_Key");
			    if(!Online(index))
				{
				    Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_OFFLINE));
				}
			    if(Account[index][_Key]!=key)
				{
				    Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
				}
			    if(IsPlayerKeyFriendFexist(Account[playerid][_Key],Account[index][_Key]))
				{
				    Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
				    fLine_64(ReturnMLStr(pLang(playerid),_ADDFRIEND_MSG1),Account[index][_Name]);
					return SCM(playerid,-1,line);
				}
			    fLine_256(ReturnMLStr(pLang(index),_ADDFRIEND_MSG2),Account[playerid][_Name]);
			    if(SendMailToOnlinePlayer(index,playerid,MAIL_TYPE_ADDFRIEND,ReturnMLStr(pLang(index),_ADDFRIEND_MSG3),line,0,NONE,0,NONE)==MAIL_SUCCESS)
				{
					format(line,256,ReturnMLStr(pLang(playerid),_ADDFRIEND_MSG4),Account[index][_Name]);
                	SCM(playerid,-1,line);
                }
                else
				{
					Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
					SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_EMAIL4));
				}
			}
			else Dialog@Show(playerid,_ONLINE_ADD_FRIEND,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ONLINES_DIALOG1),ShowOnLinePlayers(playerid,1),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG3),ReturnMLStr(pLang(playerid),_ONLINES_DIALOG4));
        }
    }
    return 1;
}
