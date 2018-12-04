N::Gui@OnPlayerConnect(playerid)
{
    PlayerPlayBottonCount[playerid]=0;
    CreatePlayerFaceMenuModeDraw(playerid);
	return 1;
}
N::Gui@OnPlayerDisconnect(playerid,reason)
{
    PlayerPlayBottonCount[playerid]=0;
	SetPlayerLeaveLastAliveGame(playerid,true,false);
	DestoryPlayerFaceMenuModeDraw(playerid);
	PlayerModeTeam[playerid][_Mode]=0;
	DestoryPlayerFaceMenuCdsDraw(playerid);
	DestoryPlayerFaceMenuBotton(playerid);
	DestoryPlayerFaceMenuLevel(playerid);
	DestoryPlayerFaceMenuTimes(playerid);
	DestoryPlayerFaceMenuCounts(playerid);
	DestoryPlayerRaderDraw(playerid);
	DestoryTeam(playerid);
	HideUserMall(playerid,true);
	HideUserBag(playerid,true);
	CloseGiftBox(playerid);
	RestPlayerDamagePrive(playerid);
	LeaveTeam(playerid);
	return 1;
}
/******************************************************************************/
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid != Text:INVALID_TEXT_DRAW)
    {
        if(PlayerInState[playerid]==PLAYER_IN_WAITLEAVE)return 1;

        switch(PlayerInState[playerid])
        {
            case PLAYER_IN_INTERFACE:
            {
			    if(clickedid == FaceMenuDraw[10])
			    {
                    ShowPlayerTeamState(playerid);
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[8])
			    {
			        if(PlayerPlayBottonCount[playerid]<10)
			        {
			        	fLine_128(ReturnMLStr(pLang(playerid),_CLICK_MSG1),10-PlayerPlayBottonCount[playerid]);
			            SCM(playerid,-1,line);
			            return 1;
			        }
			        if(Iter_Count(WaitRoom)-1>0)
			        {
			        	Dialog@Show(playerid,_ROOM_SELECT,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_ROOM_SELECT_MSG1),ReturnMLStr(pLang(playerid),_ROOM_SELECT_MSG2),ReturnMLStr(pLang(playerid),_ROOM_SELECT_MSG3),ReturnMLStr(pLang(playerid),_ROOM_SELECT_MSG4));
                        return 1;
					}
					SetPlayerToWaitRoom(playerid,0);
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[4])
			    {
			        ShowUserMall(playerid,MallPrevieType[playerid]);
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[3])
			    {
			        ShowUserBag(playerid,PlayerBagPrevieType[playerid]);
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[5])
			    {
			        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
			        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[6])
			    {
			        Dialog@Show(playerid,_CREDITS,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_CREDITS_DIALOG1),ReturnMLStr(pLang(playerid),_CREDITS_DIALOG2),ReturnMLStr(pLang(playerid),_CREDITS_DIALOG4),ReturnMLStr(pLang(playerid),_CREDITS_DIALOG3));
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[17])
			    {
			        if(Account[playerid][_Level]<5)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG10));
					Dialog@Show(playerid,_SPEC_ROOMS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SPEC_MSG3),ShowGameRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
			        return 1;
			    }
			    if(clickedid == FaceMenuDraw[19])
			    {
			        //if(Account[playerid][_Level]<5)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG10));
					if(PlayerPlayBottonCount[playerid]<10)
			        {
			        	fLine_128(ReturnMLStr(pLang(playerid),_CLICK_MSG1),10-PlayerPlayBottonCount[playerid]);
			            SCM(playerid,-1,line);
			            return 1;
			        }
			        fLine_128(ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG2),Iter_Count(WaitRoom)-1);
        			Dialog@Show(playerid,_PRESON_ROOM,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
					return 1;
			    }
			    if(clickedid == MallBackGround[16])
			    {
			        HideUserMall(playerid,false);
			        return 1;
			    }
			    if(clickedid == MallBackGround[12])//皮肤
			    {
			        MallPrevieType[playerid]=TYPE_SKIN;
			        RefreshPlayerMallPrevie(playerid,1,MallPrevieType[playerid]);
			        return 1;
			    }
			    if(clickedid == MallBackGround[13])//饰品
			    {
			        MallPrevieType[playerid]=TYPE_ADORN;
			        RefreshPlayerMallPrevie(playerid,1,MallPrevieType[playerid]);
			        return 1;
			    }
			    if(clickedid == MallBackGround[14])//箱子
			    {
			        MallPrevieType[playerid]=TYPE_BOX;
			        RefreshPlayerMallPrevie(playerid,1,MallPrevieType[playerid]);
			        return 1;
			    }
			    if(clickedid == BagBackGround[2])
			    {
			        HideUserBag(playerid,false);
			        return 1;
			    }
			    if(clickedid == BagBackGround[9])
			    {
			        PlayerBagPrevieType[playerid]=TYPE_SKIN;
			        RefreshPlayerBagPrevie(playerid,1,PlayerBagPrevieType[playerid]);//皮肤
			        return 1;
			    }
			    if(clickedid == BagBackGround[10])
			    {
                    PlayerBagPrevieType[playerid]=TYPE_ADORN;
                    RefreshPlayerBagPrevie(playerid,1,PlayerBagPrevieType[playerid]);//饰品
			        return 1;
			    }
			    if(clickedid == BagBackGround[11])
			    {
			        PlayerBagPrevieType[playerid]=TYPE_BOX;
			        RefreshPlayerBagPrevie(playerid,1,PlayerBagPrevieType[playerid]);//箱子
			        return 1;
			    }
            }
            case PLAYER_IN_NULL:
            {
			    if(clickedid == FLAG_CHINA/*LangMenuDraw[4]*/)
			    {
			        HidePlayerLangMenu(playerid);
			        SetPVarInt(playerid,"pLang",0);
			        AC_OnAccountLoginGame(playerid,Account[playerid][_Name],0);
			        ClearChat(playerid);
			        //SCM(playerid,-1,ReturnMLStr(0,_COME_IN_MSG1));
			        new line[128];
		    		format(line,sizeof(line),ReturnMLStr(0,_REG_BODY),Account[playerid][_Name]);
		    		Dialog@Show(playerid,_REG,DIALOG_STYLE_INPUT,ReturnMLStr(0,_REG_TITLE),line,ReturnMLStr(0,_REG_BOTTON1),ReturnMLStr(0,_REG_BOTTON2));
                    return 1;
			    }
			    if(clickedid == FLAG_USA/*LangMenuDraw[5]*/)
			    {
			        HidePlayerLangMenu(playerid);
			        SetPVarInt(playerid,"pLang",1);
			        AC_OnAccountLoginGame(playerid,Account[playerid][_Name],1);
			        ClearChat(playerid);
			        //SCM(playerid,-1,ReturnMLStr(1,_COME_IN_MSG1));
			        new line[128];
		    		format(line,sizeof(line),ReturnMLStr(1,_REG_BODY),Account[playerid][_Name]);
		    		Dialog@Show(playerid,_REG,DIALOG_STYLE_INPUT,ReturnMLStr(1,_REG_TITLE),line,ReturnMLStr(1,_REG_BOTTON1),ReturnMLStr(1,_REG_BOTTON2));
                    return 1;
			    }
            }
            case PLAYER_IN_GAMEROOM:
            {
 			    if(clickedid == DeathBoxGround[2])
			    {
                    HidePlayerDeathBox(playerid);
                    CancelSelectTextDraw(playerid);
                    return 1;
			    }
 			    if(clickedid == HitListDraw[2])
			    {
                    HidePlayerHitList(playerid);
                    return 1;
			    }
            }
        }
        
		if(clickedid == MusicPlayerGui[3])//关闭
		{
		    if(pMusic[playerid][_Playing]==true)
		    {
 	    		/*StopAudioStreamForPlayer(playerid);
 	    		pMusic[playerid][_Playing]=false;
				if(pMusic[playerid][Timer:_EndTimer]!=NONE)KillTimer(pMusic[playerid][Timer:_EndTimer]);
				pMusic[playerid][Timer:_EndTimer]=NONE;
				UpdateMusicGuiForPlayer(playerid," "," ","00:00",pMusic[playerid][_Mode]);*/
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
        
        DestoryPlayerInvItemBottonDo(playerid);
    }
    else
    {
        switch(PlayerInState[playerid])
        {
            case PLAYER_IN_INTERFACE:
            {
			    SelectTextDraw(playerid, 0xFF4040AA);
				return 1;
            }
            case PLAYER_IN_NULL:
            {
			    SelectTextDraw(playerid, 0xFF4040AA);
				return 1;
            }
		}
        HideUserInvPanel(playerid,false);
    }
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid != PlayerText:INVALID_TEXT_DRAW)
    {
    	if(PlayerInState[playerid]==PLAYER_IN_WAITLEAVE||PlayerInState[playerid]==PLAYER_IN_NULL)return 1;
        switch(PlayerInState[playerid])
        {
            case PLAYER_IN_INTERFACE:
            {
                if(playertextid == FriendsBotton[playerid])
                {
                    printf("#OnPlayerClickPlayerTextDraw0");
                    Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
                    return 1;
                }
                if(playertextid == MailsBotton[playerid])
                {
                    printf("#OnPlayerClickPlayerTextDraw1");
                    fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                    Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
                    return 1;
                }
                if(playertextid == OthersBotton[playerid])
                {
                    Dialog@Show(playerid,_MUSIC_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_MUSIC_MSG4),ShowMusicBoxSongs(playerid,1),ReturnMLStr(pLang(playerid),_MUSIC_MSG2),ReturnMLStr(pLang(playerid),_MUSIC_MSG3));
                    return 1;
                }

			    if(playertextid == PlayerBoxCloseDraw[playerid])
				{
				    printf("#OnPlayerClickPlayerTextDraw3");
					CloseGiftBox(playerid);
				}
			    if(playertextid == PlayerBoxGiftDraw[playerid][0])
			    {
			        printf("#OnPlayerClickPlayerTextDraw4");
					if(PlayerBoxGift[playerid][0]!=NONE)
					{
				        if(AddItemToPlayerBag(playerid,PlayerBoxGift[playerid][0],1)==BAG_SUCCESS)
				        {
						    if(PlayerBoxGiftDraw[playerid][0]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftDraw[playerid][0]);
					        PlayerBoxGiftDraw[playerid][0]=PlayerText:INVALID_TEXT_DRAW;
						    if(PlayerBoxGiftTextDraw[playerid][0]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftTextDraw[playerid][0]);
					        PlayerBoxGiftTextDraw[playerid][0]=PlayerText:INVALID_TEXT_DRAW;
							PlayerBoxGift[playerid][0]=NONE;
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BOX_GIFT_MSG2));
							if(IsGiftGetDown(playerid)<=0)CloseGiftBox(playerid);
				        }
				        else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
					}
		    	}
			    if(playertextid == PlayerBoxGiftDraw[playerid][1])
			    {
			        printf("#OnPlayerClickPlayerTextDraw5");
					if(PlayerBoxGift[playerid][1]!=NONE)
					{
				        if(AddItemToPlayerBag(playerid,PlayerBoxGift[playerid][1],1)==BAG_SUCCESS)
				        {
						    if(PlayerBoxGiftDraw[playerid][1]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftDraw[playerid][1]);
					        PlayerBoxGiftDraw[playerid][1]=PlayerText:INVALID_TEXT_DRAW;
						    if(PlayerBoxGiftTextDraw[playerid][1]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftTextDraw[playerid][1]);
					        PlayerBoxGiftTextDraw[playerid][1]=PlayerText:INVALID_TEXT_DRAW;
							PlayerBoxGift[playerid][1]=NONE;
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BOX_GIFT_MSG2));
							if(IsGiftGetDown(playerid)<=0)CloseGiftBox(playerid);
				        }
				        else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
					}
			    }
			    if(playertextid == PlayerBoxGiftDraw[playerid][2])
			    {
			        printf("#OnPlayerClickPlayerTextDraw6");
					if(PlayerBoxGift[playerid][2]!=NONE)
					{
				        if(AddItemToPlayerBag(playerid,PlayerBoxGift[playerid][2],1)==BAG_SUCCESS)
				        {
						    if(PlayerBoxGiftDraw[playerid][2]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftDraw[playerid][2]);
					        PlayerBoxGiftDraw[playerid][2]=PlayerText:INVALID_TEXT_DRAW;
						    if(PlayerBoxGiftTextDraw[playerid][2]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftTextDraw[playerid][2]);
					        PlayerBoxGiftTextDraw[playerid][2]=PlayerText:INVALID_TEXT_DRAW;
							PlayerBoxGift[playerid][2]=NONE;
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BOX_GIFT_MSG2));
							if(IsGiftGetDown(playerid)<=0)CloseGiftBox(playerid);
				        }
				        else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
					}
			    }
            }
		}
		//==========================================================================//
		if(playertextid == pSongModeDraw[playerid])
		{
            printf("#OnPlayerClickPlayerTextDraw26");
		    if(pMusic[playerid][_Playing]==true)
		    {
			    pMusic[playerid][_Mode]++;
			    if(pMusic[playerid][_Mode]>2)pMusic[playerid][_Mode]=0;
			    ShowPlayerMusicBox(playerid,pMusic[playerid][_SongID]);
		      	fLine_64(ReturnMLStr(pLang(playerid),_MUSIC_MSG12),GetMusicModeName(playerid,pMusic[playerid][_Mode]));
		       	SCM(playerid,-1,line);
		    }
		    return 1;
		}
        //==========================================================================//
        if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
        {
			forex(i,MAX_DEATHBOX_SHOW_LIST)
			{
			    if(playertextid==DeathBoxUseIcon[playerid][i])
				{
				    printf("#OnPlayerClickPlayerTextDraw7");
	                if(DeathBoxClickID[playerid]==NONE)
	                {
	     				PlayerTextDrawBackgroundColor(playerid, DeathBoxBackGround[playerid][i], -16776961);
						PlayerTextDrawBoxColor(playerid, DeathBoxBackGround[playerid][i], -16777166);
	                    PlayerTextDrawShow(playerid,DeathBoxBackGround[playerid][i]);
	    				DeathBoxClickID[playerid]=i;
	                    new pages=DeathBoxPreviePage[playerid]-1;
	                    if(pages<1)pages=0;
	                    new index=pages*MAX_DEATHBOX_SHOW_LIST+i+1;
	                    return OnPlayerClickDeathBoxItem(playerid,pGameID(playerid),PlayerDeathBoxID[playerid],index);
	                }
					else
					{
						PlayerTextDrawBackgroundColor(playerid, DeathBoxBackGround[playerid][DeathBoxClickID[playerid]], 255);
						PlayerTextDrawBoxColor(playerid, DeathBoxBackGround[playerid][DeathBoxClickID[playerid]], 50);
	                    PlayerTextDrawShow(playerid,DeathBoxBackGround[playerid][DeathBoxClickID[playerid]]);
	   					DeathBoxClickID[playerid]=i;
						PlayerTextDrawBackgroundColor(playerid, DeathBoxBackGround[playerid][i], -16776961);
						PlayerTextDrawBoxColor(playerid, DeathBoxBackGround[playerid][i], -16777166);
		                PlayerTextDrawShow(playerid,DeathBoxBackGround[playerid][i]);
	                    new pages=DeathBoxPreviePage[playerid]-1;
	                    if(pages<1)pages=0;
	                    new index=pages*MAX_DEATHBOX_SHOW_LIST+i+1;
	                    return OnPlayerClickDeathBoxItem(playerid,pGameID(playerid),PlayerDeathBoxID[playerid],index);
					}
				}
			}
			if(playertextid==DeathBoxBottonUp[playerid])
			{
			    printf("#OnPlayerClickPlayerTextDraw8");
			    new pages=DeathBoxPreviePage[playerid];
	      		DeathBoxPreviePage[playerid]--;
				if(DeathBoxPreviePage[playerid]<1)DeathBoxPreviePage[playerid]=1;
				if(pages!=DeathBoxPreviePage[playerid])
				{
					return RefreshPlayerDeathBoxPrevie(playerid,pGameID(playerid),PlayerDeathBoxID[playerid],DeathBoxPreviePage[playerid]);
	           	}
			}
			if(playertextid==DeathBoxBottonDown[playerid])
			{
			    printf("#OnPlayerClickPlayerTextDraw9");
	            new pages=DeathBoxPreviePage[playerid];
	            DeathBoxPreviePage[playerid]++;
	            if(DeathBoxPreviePage[playerid]>floatround((DeathBoxPrevieCount[playerid]-1)/float(MAX_DEATHBOX_SHOW_LIST),floatround_ceil))DeathBoxPreviePage[playerid]--;
				if(pages!=DeathBoxPreviePage[playerid])
				{
					return RefreshPlayerDeathBoxPrevie(playerid,pGameID(playerid),PlayerDeathBoxID[playerid],DeathBoxPreviePage[playerid]);
	           	}
			}
		}
        //==========================================================================//
		forex(i,MAX_PLAYERBAG_SHOW_LIST)
		{
		    if(playertextid==PlayerBagModelDraw[playerid][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw10");
                if(PlayerBagClickID[playerid]==NONE)
                {
     				PlayerTextDrawBackgroundColor(playerid, PlayerBagBackGround[playerid][i], -16776961);
					PlayerTextDrawBoxColor(playerid, PlayerBagBackGround[playerid][i], -16777166);
                    PlayerTextDrawShow(playerid,PlayerBagBackGround[playerid][i]);
    				PlayerBagClickID[playerid]=i;
                    new pages=PlayerBagPreviePage[playerid]-1;
                    if(pages<1)pages=0;
                    new index=pages*MAX_PLAYERBAG_SHOW_LIST+i+1;
                    return OnPlayerClickPlayerBagItem(playerid,index);
                }
				else
				{
					PlayerTextDrawBackgroundColor(playerid, PlayerBagBackGround[playerid][PlayerBagClickID[playerid]], 255);
					PlayerTextDrawBoxColor(playerid, PlayerBagBackGround[playerid][PlayerBagClickID[playerid]], 1296911871);
                    PlayerTextDrawShow(playerid,PlayerBagBackGround[playerid][PlayerBagClickID[playerid]]);
   					PlayerBagClickID[playerid]=i;
					PlayerTextDrawBackgroundColor(playerid, PlayerBagBackGround[playerid][i], -16776961);
					PlayerTextDrawBoxColor(playerid, PlayerBagBackGround[playerid][i], -16777166);
	                PlayerTextDrawShow(playerid,PlayerBagBackGround[playerid][i]);
                    new pages=PlayerBagPreviePage[playerid]-1;
                    if(pages<1)pages=0;
                    new index=pages*MAX_PLAYERBAG_SHOW_LIST+i+1;
                    return OnPlayerClickPlayerBagItem(playerid,index);
				}
			}
		}
		if(playertextid==PlayerBagBottonUp[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw11");
		    new pages=PlayerBagPreviePage[playerid];
      		PlayerBagPreviePage[playerid]--;
			if(PlayerBagPreviePage[playerid]<1)PlayerBagPreviePage[playerid]=1;
			if(pages!=PlayerBagPreviePage[playerid])
			{
				return RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
           	}
		}
		if(playertextid==PlayerBagBottonDown[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw12");
            new pages=PlayerBagPreviePage[playerid];
            PlayerBagPreviePage[playerid]++;
            if(PlayerBagPreviePage[playerid]>floatround((PlayerBagPrevieCount[playerid]-1)/float(MAX_PLAYERBAG_SHOW_LIST),floatround_ceil))PlayerBagPreviePage[playerid]--;
			if(pages!=PlayerBagPreviePage[playerid])
			{
				return RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
           	}
		}
        //==========================================================================//
		forex(i,MAX_MALL_SHOW_LIST)
		{
		    if(playertextid==PlayerMallModelDraw[playerid][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw13");
                if(MallClickID[playerid]==NONE)
                {
     				PlayerTextDrawBackgroundColor(playerid, PlayerMallBackGround[playerid][i], -16776961);
					PlayerTextDrawBoxColor(playerid, PlayerMallBackGround[playerid][i], -16777166);
                    PlayerTextDrawShow(playerid,PlayerMallBackGround[playerid][i]);
    				MallClickID[playerid]=i;
                    new pages=MallPreviePage[playerid]-1;
                    if(pages<1)pages=0;
                    new index=pages*MAX_MALL_SHOW_LIST+i+1;
                    return OnPlayerClickMallItem(playerid,index);
                }
				else
				{
					PlayerTextDrawBackgroundColor(playerid, PlayerMallBackGround[playerid][MallClickID[playerid]], 255);
					PlayerTextDrawBoxColor(playerid, PlayerMallBackGround[playerid][MallClickID[playerid]], 9145343);
                    PlayerTextDrawShow(playerid,PlayerMallBackGround[playerid][MallClickID[playerid]]);
   					MallClickID[playerid]=i;
					PlayerTextDrawBackgroundColor(playerid, PlayerMallBackGround[playerid][i], -16776961);
					PlayerTextDrawBoxColor(playerid, PlayerMallBackGround[playerid][i], -16777166);
	                PlayerTextDrawShow(playerid,PlayerMallBackGround[playerid][i]);
                    new pages=MallPreviePage[playerid]-1;
                    if(pages<1)pages=0;
                    new index=pages*MAX_MALL_SHOW_LIST+i+1;
                    return OnPlayerClickMallItem(playerid,index);
				}
			}
		}
		if(playertextid==PlayerMallBottonUp[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw14");
		    new pages=MallPreviePage[playerid];
      		MallPreviePage[playerid]--;
			if(MallPreviePage[playerid]<1)MallPreviePage[playerid]=1;
			if(pages!=MallPreviePage[playerid])
			{
				return RefreshPlayerMallPrevie(playerid,MallPreviePage[playerid],MallPrevieType[playerid]);
           	}
		}
		if(playertextid==PlayerMallBottonDown[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw15");
            new pages=MallPreviePage[playerid];
            MallPreviePage[playerid]++;
            if(MallPreviePage[playerid]>floatround((MallPrevieCount[playerid]-1)/float(MAX_MALL_SHOW_LIST),floatround_ceil))MallPreviePage[playerid]--;
			if(pages!=MallPreviePage[playerid])
			{
				return RefreshPlayerMallPrevie(playerid,MallPreviePage[playerid],MallPrevieType[playerid]);
           	}
		}
        //==========================================================================//
		if(playertextid==InventoryDropItemBotton[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw16");
			if(InventoryClickID[playerid]!=NONE)
			{
				new pages=InventoryPreviePage[playerid]-1;
    			if(pages<1)pages=0;
   				new index=pages*MAX_INVENTORY_SHOW_LIST+InventoryClickID[playerid]+1;
   				return OnPlayerDropInventoryItem(playerid,index);
			}
		}
		if(playertextid==InventoryUseItemBotton[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw17");
			if(InventoryClickID[playerid]!=NONE)
			{
				new pages=InventoryPreviePage[playerid]-1;
    			if(pages<1)pages=0;
   				new index=pages*MAX_INVENTORY_SHOW_LIST+InventoryClickID[playerid]+1;
				return OnPlayerUseInventoryItem(playerid,index);
			}
		}
		DestoryPlayerInvItemBottonDo(playerid);
		//==========================================================================//
		forex(i,MAX_INVENTORY_SHOW_LIST)
		{
		    if(playertextid==InventoryModelDraw[playerid][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw18");
                if(InventoryClickID[playerid]==NONE)
                {
     				PlayerTextDrawBackgroundColor(playerid, InventoryBackGround[playerid][i], -16776961);
					PlayerTextDrawBoxColor(playerid, InventoryBackGround[playerid][i], -16777166);
                    PlayerTextDrawShow(playerid,InventoryBackGround[playerid][i]);
    				InventoryClickID[playerid]=i;
					return CreatePlayerInvItemBottonDo(playerid,i);
                }
				else
				{
                    if(InventoryClickID[playerid]==i)
                    {
                        ClearPlayerInvClickState(playerid);
                        new pages=InventoryPreviePage[playerid]-1;
                        if(pages<1)pages=0;
                        new index=pages*MAX_INVENTORY_SHOW_LIST+i+1;
                        return OnPlayerUseInventoryItem(playerid,index);
                    }
                    else
                    {
                   		PlayerTextDrawBackgroundColor(playerid, InventoryBackGround[playerid][InventoryClickID[playerid]], 255);
						PlayerTextDrawBoxColor(playerid, InventoryBackGround[playerid][InventoryClickID[playerid]], 50);
                        PlayerTextDrawShow(playerid,InventoryBackGround[playerid][InventoryClickID[playerid]]);
    					InventoryClickID[playerid]=i;
					 	PlayerTextDrawBackgroundColor(playerid, InventoryBackGround[playerid][i], -16776961);
						PlayerTextDrawBoxColor(playerid, InventoryBackGround[playerid][i], -16777166);
	                    PlayerTextDrawShow(playerid,InventoryBackGround[playerid][i]);
  						return CreatePlayerInvItemBottonDo(playerid,i);
                    }
				}
			}
		}
		ClearPlayerInvClickState(playerid);
		if(playertextid==InventorySliderBarButtonBack[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw19");
		    new pages=InventoryPreviePage[playerid];
      		InventoryPreviePage[playerid]--;
			if(InventoryPreviePage[playerid]<1)InventoryPreviePage[playerid]=1;
			if(pages!=InventoryPreviePage[playerid])
			{
			   return RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
           	}
		}
		if(playertextid==InventorySliderBarButtonNext[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw20");
            new pages=InventoryPreviePage[playerid];
            InventoryPreviePage[playerid]++;
            if(InventoryPreviePage[playerid]>floatround((InventoryPrevieCount[playerid]-1)/float(MAX_INVENTORY_SHOW_LIST),floatround_ceil))InventoryPreviePage[playerid]--;
			if(pages!=InventoryPreviePage[playerid])
			{
			   return RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
           	}
		}
		//==========================================================================//
		forex(i,MAX_NEARBY_SHOW_LIST)
		{
		    if(playertextid==NearByModelDraw[playerid][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw21");
                if(NearByClickID[playerid]==NONE)
                {
                    PlayerTextDrawBackgroundColor(playerid, NearByBackGround[playerid][i], 255);
					PlayerTextDrawBoxColor(playerid, NearByBackGround[playerid][i], 1747094322);
                    PlayerTextDrawShow(playerid,NearByBackGround[playerid][i]);
    				NearByClickID[playerid]=i;
    				return 1;
                }
				else
				{
                    if(NearByClickID[playerid]==i)
                    {
                        ClearPlayerNearByClickState(playerid);
                        new pages=NearByPreviePage[playerid]-1;
                        if(pages<1)pages=0;
                        new index=pages*MAX_NEARBY_SHOW_LIST+i+1;
                        return OnPlayerClickNearByItem(playerid,index);
                    }
                    else
                    {
                   		PlayerTextDrawBackgroundColor(playerid, NearByBackGround[playerid][NearByClickID[playerid]], 255);
						PlayerTextDrawBoxColor(playerid, NearByBackGround[playerid][NearByClickID[playerid]], 50);
                        PlayerTextDrawShow(playerid,NearByBackGround[playerid][NearByClickID[playerid]]);
    					InventoryClickID[playerid]=i;
					 	PlayerTextDrawBackgroundColor(playerid, NearByBackGround[playerid][i], 255);
						PlayerTextDrawBoxColor(playerid, NearByBackGround[playerid][i], 1747094322);
	                    PlayerTextDrawShow(playerid,NearByBackGround[playerid][i]);
    					NearByClickID[playerid]=i;
    					return 1;
                    }
				}
			}
		}
		ClearPlayerNearByClickState(playerid);
		if(playertextid==NearByBackBotton[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw22");
		    new pages=NearByPreviePage[playerid];
      		NearByPreviePage[playerid]--;
			if(NearByPreviePage[playerid]<1)NearByPreviePage[playerid]=1;
			if(pages!=NearByPreviePage[playerid])
			{
			   return RefreshPlayerNearByPrevie(playerid,pGameID(playerid),PLAYER_FIND_NEARBY_DISTANCE,NearByPreviePage[playerid]);
           	}
		}
		if(playertextid==NearByNextBotton[playerid])
		{
		    printf("#OnPlayerClickPlayerTextDraw23");
            new pages=NearByPreviePage[playerid];
            NearByPreviePage[playerid]++;
            if(NearByPreviePage[playerid]>floatround((NearByPrevieCount[playerid]-1)/float(MAX_NEARBY_SHOW_LIST),floatround_ceil))NearByPreviePage[playerid]--;
			if(pages!=NearByPreviePage[playerid])
			{
			   return RefreshPlayerNearByPrevie(playerid,pGameID(playerid),PLAYER_FIND_NEARBY_DISTANCE,NearByPreviePage[playerid]);
           	}
		}
		//==========================================================================//
		forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
		{
		    if(playertextid==pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw24");
                if(HandWeaponClickID[playerid]==NONE)
                {
					HandWeaponClickID[playerid]=i;
					return 1;
                }
				else
				{
				    if(HandWeaponClickID[playerid]==i)
                    {
                    	AC@ResetPlayerWeaponsEx(playerid);
                        if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot]!=HAND_WEAPON_SLOT_4&&Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot]!=NONE)
						{
							if(AddThingToPlayerInventoy(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i],1,0,0.0)!=INVENTORY_SUCCESS)
							{
							    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
							    return 1;
							}
						}
                        //printf("now %i-%i",i,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot]);
						pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]=NONE;
						/*forex(s,MAX_PLAYER_WEAPON_SLOT_DRAW)
						{
						    printf("2>%i,%i",s,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][s]);
						}*/
						UpdateHandWeaponPrevieList(playerid,i);
						RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
						ResetPlayerWeaponsEx(playerid);
						HandWeaponClickID[playerid]=NONE;
						return 1;
                    }
                    else
                    {
                        HandWeaponClickID[playerid]=i;
                        return 1;
                    }
				}
			}
		}
		//==========================================================================//
		forex(i,MAX_PLAYER_BODY_SLOT_DRAW)
		{
		    if(playertextid==pLastAliveBodyDress[playerid][_Body_Dress_Draw][i])
			{
			    printf("#OnPlayerClickPlayerTextDraw25");
                if(BodyDressClickID[playerid]==NONE)
                {
					BodyDressClickID[playerid]=i;
					return 1;
                }
				else
				{
				    if(BodyDressClickID[playerid]==i)
                    {
						if(AddThingToPlayerInventoy(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Item][i],1,0,pLastAliveBodyDress[playerid][_Body_Dress_Durable][i])==INVENTORY_FULL&&pLastAliveBodyDress[playerid][_Body_Dress_Item][i]!=NONE)
						{
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
						    return 1;
						}
                        new itemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][i];
                        pLastAliveBodyDress[playerid][_Body_Dress_Item][i]=NONE;
                        pLastAliveBodyDress[playerid][_Body_Dress_Durable][i]=0.0;
                        UpdateBodyDressPrevieList(playerid,i,itemid);
						RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
						BodyDressClickID[playerid]=NONE;
						if(i==2||i==3)ShowPlayerValuePanelPrevie(playerid);
						return 1;
                    }
                    else
                    {
                        BodyDressClickID[playerid]=i;
                        return 1;
                    }
				}
			}
		}
		//==========================================================================//
	}
    return 1;
}
/******************************************************************************/
N::CreatePlayerGameKillDraw(playerid)//玩家杀人数DRAW
{
	pLastAlive[playerid][_Game_Kill_Draw] = CreatePlayerTextDraw(playerid,553.000000, 52.000000, "0");
	PlayerTextDrawFont(playerid,pLastAlive[playerid][_Game_Kill_Draw], 2);
	PlayerTextDrawLetterSize(playerid,pLastAlive[playerid][_Game_Kill_Draw], 0.275000, 2.049998);
	PlayerTextDrawTextSize(playerid,pLastAlive[playerid][_Game_Kill_Draw], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid,pLastAlive[playerid][_Game_Kill_Draw], 0);
	PlayerTextDrawSetShadow(playerid,pLastAlive[playerid][_Game_Kill_Draw], 0);
	PlayerTextDrawAlignment(playerid,pLastAlive[playerid][_Game_Kill_Draw], 2);
	PlayerTextDrawColor(playerid,pLastAlive[playerid][_Game_Kill_Draw], -1);
	PlayerTextDrawBackgroundColor(playerid,pLastAlive[playerid][_Game_Kill_Draw], 255);
	PlayerTextDrawBoxColor(playerid,pLastAlive[playerid][_Game_Kill_Draw], 50);
	PlayerTextDrawUseBox(playerid,pLastAlive[playerid][_Game_Kill_Draw], 0);
	PlayerTextDrawSetProportional(playerid,pLastAlive[playerid][_Game_Kill_Draw], 1);
	PlayerTextDrawSetSelectable(playerid,pLastAlive[playerid][_Game_Kill_Draw], 0);
    return 1;
}
N::ShowPlayerGameKillDraw(playerid)
{
	PlayerTextDrawShow(playerid,pLastAlive[playerid][_Game_Kill_Draw]);
	return 1;
}
N::UpdatePlayerGameKillDraw(playerid,amout)
{
    fLine_32("%i",amout);
	PlayerTextDrawSetString(playerid,pLastAlive[playerid][_Game_Kill_Draw],line);
	PlayerTextDrawShow(playerid,pLastAlive[playerid][_Game_Kill_Draw]);
	return 1;
}
N::DestoryPlayerGameKillDraw(playerid)
{
	if(pLastAlive[playerid][_Game_Kill_Draw]!=PlayerText:INVALID_TEXT_DRAW)
	{
		PlayerTextDrawDestroy(playerid,pLastAlive[playerid][_Game_Kill_Draw]);
		pLastAlive[playerid][_Game_Kill_Draw]=PlayerText:INVALID_TEXT_DRAW;
	}
    return 1;
}
/******************************************************************************/
stock Text:CreateGamePlaneDraw(Float:PosX,Float:PosY)
{
	new Text:PlayerTextDraw = TextDrawCreate(PosX,PosY,"HUD:radar_airyard");
	TextDrawFont(PlayerTextDraw, 4);
	TextDrawLetterSize(PlayerTextDraw, 0.600000, 2.000000);
	TextDrawTextSize(PlayerTextDraw, 16.000000, 16.000000);
	TextDrawSetOutline(PlayerTextDraw, 1);
	TextDrawSetShadow(PlayerTextDraw, 0);
	TextDrawAlignment(PlayerTextDraw, 1);
	TextDrawColor(PlayerTextDraw, -1);
	TextDrawBackgroundColor(PlayerTextDraw, 255);
	TextDrawBoxColor(PlayerTextDraw, 50);
	TextDrawUseBox(PlayerTextDraw, 1);
	TextDrawSetProportional(PlayerTextDraw, 1);
	TextDrawSetSelectable(PlayerTextDraw, 0);
    return PlayerTextDraw;
}
/******************************************************************************/
stock Text:CreateGameAliveDraw()//战局存活数DRAW
{
	new Text:PlayerTextDraw = TextDrawCreate(553.000000, 26.000000, "0");
	TextDrawFont(PlayerTextDraw, 2);
	TextDrawLetterSize(PlayerTextDraw, 0.275000, 2.049998);
	TextDrawTextSize(PlayerTextDraw, 400.000000, 17.000000);
	TextDrawSetOutline(PlayerTextDraw, 0);
	TextDrawSetShadow(PlayerTextDraw, 0);
	TextDrawAlignment(PlayerTextDraw, 2);
	TextDrawColor(PlayerTextDraw, -1);
	TextDrawBackgroundColor(PlayerTextDraw, 255);
	TextDrawBoxColor(PlayerTextDraw, 50);
	TextDrawUseBox(PlayerTextDraw, 0);
	TextDrawSetProportional(PlayerTextDraw, 1);
	TextDrawSetSelectable(PlayerTextDraw, 0);
    return PlayerTextDraw;
}
N::UpdateGameAliveDraw(GameID,Amout)
{
    if(GameID!=NONE)
    {
	    fLine_32("%i",Amout);
		TextDrawSetString(LastAliveGame[GameID][_Alive_Draw],line);
	}
	return 1;
}
N::DestoryGameAliveDraw(GameID)
{
	if(LastAliveGame[GameID][_Alive_Draw]!=Text:INVALID_TEXT_DRAW)
	{
	    TextDrawDestroy(LastAliveGame[GameID][_Alive_Draw]);
	    LastAliveGame[GameID][_Alive_Draw]=Text:INVALID_TEXT_DRAW;
    }
    return 1;
}
N::ShowPlayerGameAlive(playerid)
{
	if(pGameID(playerid)!=NONE)TextDrawShowForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Alive_Draw]);
    return 1;
}
N::HidePlayerGameAlive(playerid)
{
    if(pGameID(playerid)!=NONE)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Alive_Draw]);
    return 1;
}
/******************************************************************************/
stock Text:CreateGameTimeLineTimeDraw()
{
	new Text:GameTextDraw = TextDrawCreate(73.000000, 318.000000, "00:00");
	TextDrawFont(GameTextDraw, 2);
	TextDrawLetterSize(GameTextDraw, 0.208331, 1.099997);
	TextDrawTextSize(GameTextDraw, 400.000000, 17.000000);
	TextDrawSetOutline(GameTextDraw, 0);
	TextDrawSetShadow(GameTextDraw, 0);
	TextDrawAlignment(GameTextDraw, 1);
	TextDrawColor(GameTextDraw, -1);
	TextDrawBackgroundColor(GameTextDraw, 255);
	TextDrawBoxColor(GameTextDraw, 50);
	TextDrawUseBox(GameTextDraw, 0);
	TextDrawSetProportional(GameTextDraw, 1);
	TextDrawSetSelectable(GameTextDraw, 0);
    return GameTextDraw;
}
N::ShowPlayerTimeLineTime(playerid)
{
	TextDrawShowForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Time_Line_Time_Draw]);
    return 1;
}
N::UpdatePlayerTimeLineTime(gameid,timeline)
{
    new Str[64];
    if(timeline==65535)
    {
    	if(LastAliveGame[gameid][_Time_Line_Warn]==0)
		{
			format(Str,sizeof(Str),"~b~KILL THEMS");
			LastAliveGame[gameid][_Time_Line_Warn]=1;
		}
		else
		{
			format(Str,sizeof(Str),"~p~KILL THEMS");
			LastAliveGame[gameid][_Time_Line_Warn]=0;
		}
    }
	else
	{
	    if(timeline>0)format(Str,sizeof(Str),"%s",ReturnCountDownStr(timeline));
	    else
		{
		    if(LastAliveGame[gameid][_Time_Line_Warn]==0)
			{
				format(Str,sizeof(Str),"~r~RUN!");
				LastAliveGame[gameid][_Time_Line_Warn]=1;
			}
			else
			{
				format(Str,sizeof(Str),"~y~RUN!");
				LastAliveGame[gameid][_Time_Line_Warn]=0;
			}
		}
	}
	TextDrawSetString(LastAliveGame[gameid][_Time_Line_Time_Draw],Str);
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
        	if(pGameID(i)==gameid&&pGameIn(i)==true)
	        {
         		if(pLastAlive[i][_Game_SpectatePlane]==false)TextDrawShowForPlayer(i,LastAliveGame[gameid][_Time_Line_Time_Draw]);
	        }
		}
    }
    return 1;
}
N::HidePlayerTimeLineTime(playerid)
{
	if(pGameID(playerid)!=NONE)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Time_Line_Time_Draw]);
	DestoryPlayerTimeLinePerson(playerid);
    return 1;
}
/******************************************************************************/
N::ShowPlayerGameScorePanel(playerid)
{
	forex(i,MAX_GAMESCOREDRAW_PANEL_DRAW)TextDrawShowForPlayer(playerid,GameScorePanel[i]);
    return 1;
}
N::HidePlayerGameScorePanel(playerid)
{
	forex(i,MAX_GAMESCOREDRAW_PANEL_DRAW)TextDrawHideForPlayer(playerid,GameScorePanel[i]);
    return 1;
}
/******************************************************************************/
N::GameDrawInit()
{
	//----------------------------战局积分框----------------------------------//
	GameScorePanel[0] = TextDrawCreate(586.000000, 52.000000, "~n~");//killback1
	TextDrawFont(GameScorePanel[0], 1);
	TextDrawLetterSize(GameScorePanel[0], 0.600000, 2.349998);
	TextDrawTextSize(GameScorePanel[0], 400.000000, 41.500000);
	TextDrawSetOutline(GameScorePanel[0], 1);
	TextDrawSetShadow(GameScorePanel[0], 0);
	TextDrawAlignment(GameScorePanel[0], 2);
	TextDrawColor(GameScorePanel[0], -1);
	TextDrawBackgroundColor(GameScorePanel[0], 255);
	TextDrawBoxColor(GameScorePanel[0], -1094795521);
	TextDrawUseBox(GameScorePanel[0], 1);
	TextDrawSetProportional(GameScorePanel[0], 1);
	TextDrawSetSelectable(GameScorePanel[0], 0);

	GameScorePanel[1] = TextDrawCreate(586.000000, 26.000000, "~n~");//aliveback1
	TextDrawFont(GameScorePanel[1], 1);
	TextDrawLetterSize(GameScorePanel[1], 0.600000, 2.349998);
	TextDrawTextSize(GameScorePanel[1], 400.000000, 41.500000);
	TextDrawSetOutline(GameScorePanel[1], 1);
	TextDrawSetShadow(GameScorePanel[1], 0);
	TextDrawAlignment(GameScorePanel[1], 2);
	TextDrawColor(GameScorePanel[1], -1);
	TextDrawBackgroundColor(GameScorePanel[1], 255);
	TextDrawBoxColor(GameScorePanel[1], -1094795521);
	TextDrawUseBox(GameScorePanel[1], 1);
	TextDrawSetProportional(GameScorePanel[1], 1);
	TextDrawSetSelectable(GameScorePanel[1], 0);

	GameScorePanel[2] = TextDrawCreate(553.000000, 52.000000, "~n~");//killback2
	TextDrawFont(GameScorePanel[2], 1);
	TextDrawLetterSize(GameScorePanel[2], 0.600000, 2.349998);
	TextDrawTextSize(GameScorePanel[2], 400.000000, 18.000000);
	TextDrawSetOutline(GameScorePanel[2], 1);
	TextDrawSetShadow(GameScorePanel[2], 0);
	TextDrawAlignment(GameScorePanel[2], 2);
	TextDrawColor(GameScorePanel[2], -1);
	TextDrawBackgroundColor(GameScorePanel[2], 255);
	TextDrawBoxColor(GameScorePanel[2], 1296911871);
	TextDrawUseBox(GameScorePanel[2], 1);
	TextDrawSetProportional(GameScorePanel[2], 1);
	TextDrawSetSelectable(GameScorePanel[2], 0);

	GameScorePanel[3] = TextDrawCreate(553.000000, 26.000000, "~n~");//aliveback2
	TextDrawFont(GameScorePanel[3], 1);
	TextDrawLetterSize(GameScorePanel[3], 0.600000, 2.349998);
	TextDrawTextSize(GameScorePanel[3], 400.000000, 18.000000);
	TextDrawSetOutline(GameScorePanel[3], 1);
	TextDrawSetShadow(GameScorePanel[3], 0);
	TextDrawAlignment(GameScorePanel[3], 2);
	TextDrawColor(GameScorePanel[3], -1);
	TextDrawBackgroundColor(GameScorePanel[3], 255);
	TextDrawBoxColor(GameScorePanel[3], 1296911871);
	TextDrawUseBox(GameScorePanel[3], 1);
	TextDrawSetProportional(GameScorePanel[3], 1);
	TextDrawSetSelectable(GameScorePanel[3], 0);

	GameScorePanel[4] = TextDrawCreate(587.000000, 51.000000, "KILLS");//kills
	TextDrawFont(GameScorePanel[4], 2);
	TextDrawLetterSize(GameScorePanel[4], 0.329165, 2.249999);
	TextDrawTextSize(GameScorePanel[4], 400.000000, 17.000000);
	TextDrawSetOutline(GameScorePanel[4], 0);
	TextDrawSetShadow(GameScorePanel[4], 0);
	TextDrawAlignment(GameScorePanel[4], 2);
	TextDrawColor(GameScorePanel[4], -1);
	TextDrawBackgroundColor(GameScorePanel[4], 255);
	TextDrawBoxColor(GameScorePanel[4], 50);
	TextDrawUseBox(GameScorePanel[4], 0);
	TextDrawSetProportional(GameScorePanel[4], 1);
	TextDrawSetSelectable(GameScorePanel[4], 0);

	GameScorePanel[5] = TextDrawCreate(587.000000, 25.000000, "ALIVE");//ALIVE
	TextDrawFont(GameScorePanel[5], 2);
	TextDrawLetterSize(GameScorePanel[5], 0.329165, 2.249999);
	TextDrawTextSize(GameScorePanel[5], 400.000000, 17.000000);
	TextDrawSetOutline(GameScorePanel[5], 0);
	TextDrawSetShadow(GameScorePanel[5], 0);
	TextDrawAlignment(GameScorePanel[5], 2);
	TextDrawColor(GameScorePanel[5], -1);
	TextDrawBackgroundColor(GameScorePanel[5], 255);
	TextDrawBoxColor(GameScorePanel[5], 50);
	TextDrawUseBox(GameScorePanel[5], 0);
	TextDrawSetProportional(GameScorePanel[5], 1);
	TextDrawSetSelectable(GameScorePanel[5], 0);
	//------------------------------------------------------------------//
	//----------------------------背包背景----------------------------------//
	InventoryBackGroundDraw[0] = TextDrawCreate(313.000000, -11.000000, "~n~");
	TextDrawFont(InventoryBackGroundDraw[0], 1);
	TextDrawLetterSize(InventoryBackGroundDraw[0], 0.600000, 51.849945);
	TextDrawTextSize(InventoryBackGroundDraw[0], 488.000000, 663.000000);
	TextDrawSetOutline(InventoryBackGroundDraw[0], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[0], 0);
	TextDrawAlignment(InventoryBackGroundDraw[0], 2);
	TextDrawColor(InventoryBackGroundDraw[0], -1);
	TextDrawBackgroundColor(InventoryBackGroundDraw[0], 255);
	TextDrawBoxColor(InventoryBackGroundDraw[0], 99);
	TextDrawUseBox(InventoryBackGroundDraw[0], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[0], 1);
	TextDrawSetSelectable(InventoryBackGroundDraw[0], 0);
	
/*  InventoryBackGroundDraw[0] = TextDrawCreate(0.453902, 0.416655, "box");
	TextDrawLetterSize(InventoryBackGroundDraw[0], 0.000000, 49.262069);
	TextDrawTextSize(InventoryBackGroundDraw[0], 642.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[0], 1);
	TextDrawColor(InventoryBackGroundDraw[0], -1);
	TextDrawUseBox(InventoryBackGroundDraw[0], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[0], 99);
	TextDrawSetShadow(InventoryBackGroundDraw[0], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[0], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[0], 255);
	TextDrawFont(InventoryBackGroundDraw[0], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[0], 0);
	TextDrawSetShadow(InventoryBackGroundDraw[0], 0);*/

	InventoryBackGroundDraw[1] = TextDrawCreate(37.935607, 73.333343, "Nearby");
	TextDrawLetterSize(InventoryBackGroundDraw[1], 0.268344, 1.448333);
	TextDrawAlignment(InventoryBackGroundDraw[1], 1);
	TextDrawColor(InventoryBackGroundDraw[1], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[1], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[1], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[1], 255);
	TextDrawFont(InventoryBackGroundDraw[1], 2);
	TextDrawSetProportional(InventoryBackGroundDraw[1], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[1], 0);

	InventoryBackGroundDraw[2] = TextDrawCreate(156.471450, 41.250019, "inventory");
	TextDrawLetterSize(InventoryBackGroundDraw[2], 0.268344, 1.448333);
	TextDrawAlignment(InventoryBackGroundDraw[2], 1);
	TextDrawColor(InventoryBackGroundDraw[2], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[2], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[2], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[2], 255);
	TextDrawFont(InventoryBackGroundDraw[2], 2);
	TextDrawSetProportional(InventoryBackGroundDraw[2], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[2], 0);

	InventoryBackGroundDraw[3] = TextDrawCreate(155.065902, 58.166709, "bg line");
	TextDrawLetterSize(InventoryBackGroundDraw[3], 0.000000, 21.057102);
	TextDrawTextSize(InventoryBackGroundDraw[3], 154.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[3], 1);
	TextDrawColor(InventoryBackGroundDraw[3], -1);
	TextDrawUseBox(InventoryBackGroundDraw[3], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[3], 255);
	TextDrawSetShadow(InventoryBackGroundDraw[3], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[3], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[3], 255);
	TextDrawFont(InventoryBackGroundDraw[3], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[3], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[3], 0);

	InventoryBackGroundDraw[4] = TextDrawCreate(404.787719, 147.999908, "#1 Whiteline");
	TextDrawLetterSize(InventoryBackGroundDraw[4], 0.000000, -0.448020);
	TextDrawTextSize(InventoryBackGroundDraw[4], 596.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[4], 1);
	TextDrawColor(InventoryBackGroundDraw[4], -1);
	TextDrawUseBox(InventoryBackGroundDraw[4], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[4], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[4], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[4], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[4], 255);
	TextDrawFont(InventoryBackGroundDraw[4], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[4], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[4], 0);

	InventoryBackGroundDraw[5] = TextDrawCreate(407.598937, 232.583312, "#2 Whiteline");
	TextDrawLetterSize(InventoryBackGroundDraw[5], 0.000000, -0.494872);
	TextDrawTextSize(InventoryBackGroundDraw[5], 596.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[5], 1);
	TextDrawColor(InventoryBackGroundDraw[5], -1);
	TextDrawUseBox(InventoryBackGroundDraw[5], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[5], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[5], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[5], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[5], 255);
	TextDrawFont(InventoryBackGroundDraw[5], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[5], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[5], 0);

	InventoryBackGroundDraw[6] = TextDrawCreate(403.382537, 326.299896, "#3 Whiteline");
	TextDrawLetterSize(InventoryBackGroundDraw[6], 0.000000, -0.635429);
	TextDrawTextSize(InventoryBackGroundDraw[6], 595.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[6], 1);
	TextDrawColor(InventoryBackGroundDraw[6], -1);
	TextDrawUseBox(InventoryBackGroundDraw[6], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[6], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[6], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[6], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[6], 255);
	TextDrawFont(InventoryBackGroundDraw[6], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[6], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[6], 0);

	InventoryBackGroundDraw[7] = TextDrawCreate(401.508270, 86.166641, "#1");
	TextDrawLetterSize(InventoryBackGroundDraw[7], 0.282869, 1.109997);
	TextDrawTextSize(InventoryBackGroundDraw[7], 415.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[7], 1);
	TextDrawColor(InventoryBackGroundDraw[7], 255);
	TextDrawUseBox(InventoryBackGroundDraw[7], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[7], -181);
	TextDrawSetShadow(InventoryBackGroundDraw[7], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[7], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[7], 255);
	TextDrawFont(InventoryBackGroundDraw[7], 3);
	TextDrawSetProportional(InventoryBackGroundDraw[7], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[7], 0);

	InventoryBackGroundDraw[8] = TextDrawCreate(403.850891, 160.833221, "#2");
	TextDrawLetterSize(InventoryBackGroundDraw[8], 0.282869, 1.109997);
	TextDrawTextSize(InventoryBackGroundDraw[8], 417.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[8], 1);
	TextDrawColor(InventoryBackGroundDraw[8], 255);
	TextDrawUseBox(InventoryBackGroundDraw[8], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[8], -181);
	TextDrawSetShadow(InventoryBackGroundDraw[8], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[8], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[8], 255);
	TextDrawFont(InventoryBackGroundDraw[8], 3);
	TextDrawSetProportional(InventoryBackGroundDraw[8], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[8], 0);

	InventoryBackGroundDraw[9] = TextDrawCreate(405.256439, 245.999816, "#3");
	TextDrawLetterSize(InventoryBackGroundDraw[9], 0.282869, 1.109997);
	TextDrawTextSize(InventoryBackGroundDraw[9], 419.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[9], 1);
	TextDrawColor(InventoryBackGroundDraw[9], 255);
	TextDrawUseBox(InventoryBackGroundDraw[9], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[9], -181);
	TextDrawSetShadow(InventoryBackGroundDraw[9], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[9], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[9], 255);
	TextDrawFont(InventoryBackGroundDraw[9], 3);
	TextDrawSetProportional(InventoryBackGroundDraw[9], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[9], 0);

	InventoryBackGroundDraw[10] = TextDrawCreate(505.051818, 333.500152, "3&4 white line");
	TextDrawLetterSize(InventoryBackGroundDraw[10], 0.000000, 2.456809);
	TextDrawTextSize(InventoryBackGroundDraw[10], 500.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[10], 1);
	TextDrawColor(InventoryBackGroundDraw[10], -1);
	TextDrawUseBox(InventoryBackGroundDraw[10], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[10], -1);
	TextDrawSetShadow(InventoryBackGroundDraw[10], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[10], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[10], 255);
	TextDrawFont(InventoryBackGroundDraw[10], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[10], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[10], 0);


	InventoryBackGroundDraw[11] = TextDrawCreate(307.335418, 188.249954, "Helmet");
	TextDrawLetterSize(InventoryBackGroundDraw[11], 0.000000, 3.019035);
	TextDrawTextSize(InventoryBackGroundDraw[11], 331.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[11], 1);
	TextDrawColor(InventoryBackGroundDraw[11], -1);
	TextDrawUseBox(InventoryBackGroundDraw[11], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[11], -197);
	TextDrawSetShadow(InventoryBackGroundDraw[11], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[11], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[11], 255);
	TextDrawFont(InventoryBackGroundDraw[11], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[11], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[11], 0);

	InventoryBackGroundDraw[12] = TextDrawCreate(354.656402, 187.666641, "mianzhao");
	TextDrawLetterSize(InventoryBackGroundDraw[12], 0.000000, 3.019035);
	TextDrawTextSize(InventoryBackGroundDraw[12], 379.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[12], 1);
	TextDrawColor(InventoryBackGroundDraw[12], -1);
	TextDrawUseBox(InventoryBackGroundDraw[12], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[12], -197);
	TextDrawSetShadow(InventoryBackGroundDraw[12], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[12], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[12], 255);
	TextDrawFont(InventoryBackGroundDraw[12], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[12], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[12], 0);

	InventoryBackGroundDraw[13] = TextDrawCreate(354.656494, 154.416687, "Glasses");
	TextDrawLetterSize(InventoryBackGroundDraw[13], 0.000000, 3.019035);
	TextDrawTextSize(InventoryBackGroundDraw[13], 379.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[13], 1);
	TextDrawColor(InventoryBackGroundDraw[13], -1);
	TextDrawUseBox(InventoryBackGroundDraw[13], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[13], -197);
	TextDrawSetShadow(InventoryBackGroundDraw[13], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[13], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[13], 255);
	TextDrawFont(InventoryBackGroundDraw[13], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[13], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[13], 0);

	InventoryBackGroundDraw[14] = TextDrawCreate(307.336029, 222.083450, "Ammour");
	TextDrawLetterSize(InventoryBackGroundDraw[14], 0.000000, 2.878478);
	TextDrawTextSize(InventoryBackGroundDraw[14], 331.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[14], 1);
	TextDrawColor(InventoryBackGroundDraw[14], -1);
	TextDrawUseBox(InventoryBackGroundDraw[14], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[14], -197);
	TextDrawSetShadow(InventoryBackGroundDraw[14], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[14], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[14], 255);
	TextDrawFont(InventoryBackGroundDraw[14], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[14], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[14], 0);

	InventoryBackGroundDraw[15] = TextDrawCreate(307.335662, 255.333251, "Bag");
	TextDrawLetterSize(InventoryBackGroundDraw[15], 0.000000, 2.644217);
	TextDrawTextSize(InventoryBackGroundDraw[15], 331.000000, 0.000000);
	TextDrawAlignment(InventoryBackGroundDraw[15], 1);
	TextDrawColor(InventoryBackGroundDraw[15], -1);
	TextDrawUseBox(InventoryBackGroundDraw[15], 1);
	TextDrawBoxColor(InventoryBackGroundDraw[15], -197);
	TextDrawSetShadow(InventoryBackGroundDraw[15], 0);
	TextDrawSetOutline(InventoryBackGroundDraw[15], 0);
	TextDrawBackgroundColor(InventoryBackGroundDraw[15], 255);
	TextDrawFont(InventoryBackGroundDraw[15], 1);
	TextDrawSetProportional(InventoryBackGroundDraw[15], 1);
	TextDrawSetShadow(InventoryBackGroundDraw[15], 0);
	//---------------------状态背景---------------------------------------//
	
/*	GamePlayerValuePanelBackGround[0] = TextDrawCreate(325.000000, 397.000000, "_");
	TextDrawFont(GamePlayerValuePanelBackGround[0], 1);
	TextDrawLetterSize(GamePlayerValuePanelBackGround[0], 0.600000, 1.650002);
	TextDrawTextSize(GamePlayerValuePanelBackGround[0], 447.000000, 129.500000);
	TextDrawSetOutline(GamePlayerValuePanelBackGround[0], 0);
	TextDrawSetShadow(GamePlayerValuePanelBackGround[0], 0);
	TextDrawAlignment(GamePlayerValuePanelBackGround[0], 2);
	TextDrawColor(GamePlayerValuePanelBackGround[0], -1);
	TextDrawBackgroundColor(GamePlayerValuePanelBackGround[0], 1296911871);
	TextDrawBoxColor(GamePlayerValuePanelBackGround[0], 125);
	TextDrawUseBox(GamePlayerValuePanelBackGround[0], 1);
	TextDrawSetProportional(GamePlayerValuePanelBackGround[0], 1);
	TextDrawSetSelectable(GamePlayerValuePanelBackGround[0], 1);*/
	GamePlayerValuePanelBackGround[0] = TextDrawCreate(320.000000, 394.000000, "~n~");
	TextDrawFont(GamePlayerValuePanelBackGround[0], 1);
	TextDrawLetterSize(GamePlayerValuePanelBackGround[0], 0.600000, 1.550000);
	TextDrawTextSize(GamePlayerValuePanelBackGround[0], 400.000000, 167.500000);
	TextDrawSetOutline(GamePlayerValuePanelBackGround[0], 3);
	TextDrawSetShadow(GamePlayerValuePanelBackGround[0], 0);
	TextDrawAlignment(GamePlayerValuePanelBackGround[0], 2);
	TextDrawColor(GamePlayerValuePanelBackGround[0], -1);
	TextDrawBackgroundColor(GamePlayerValuePanelBackGround[0], 255);
	TextDrawBoxColor(GamePlayerValuePanelBackGround[0], 96);
	TextDrawUseBox(GamePlayerValuePanelBackGround[0], 1);
	TextDrawSetProportional(GamePlayerValuePanelBackGround[0], 1);
	TextDrawSetSelectable(GamePlayerValuePanelBackGround[0], 0);
	
/*	GamePlayerValuePanelBackGround[1] = TextDrawCreate(325.000000, 385.000000, "_");
	TextDrawFont(GamePlayerValuePanelBackGround[1], 1);
	TextDrawLetterSize(GamePlayerValuePanelBackGround[1], 0.595833, 0.300000);
	TextDrawTextSize(GamePlayerValuePanelBackGround[1], 439.000000, 129.500000);
	TextDrawSetOutline(GamePlayerValuePanelBackGround[1], 0);
	TextDrawSetShadow(GamePlayerValuePanelBackGround[1], 0);
	TextDrawAlignment(GamePlayerValuePanelBackGround[1], 2);
	TextDrawColor(GamePlayerValuePanelBackGround[1], -1);
	TextDrawBackgroundColor(GamePlayerValuePanelBackGround[1], 1296911871);
	TextDrawBoxColor(GamePlayerValuePanelBackGround[1], 125);
	TextDrawUseBox(GamePlayerValuePanelBackGround[1], 1);
	TextDrawSetProportional(GamePlayerValuePanelBackGround[1], 1);
	TextDrawSetSelectable(GamePlayerValuePanelBackGround[1], 1);
	
	GamePlayerValuePanelBackGround[2] = TextDrawCreate(325.000000, 373.000000, "_");
	TextDrawFont(GamePlayerValuePanelBackGround[2], 1);
	TextDrawLetterSize(GamePlayerValuePanelBackGround[2], 0.595833, 0.300000);
	TextDrawTextSize(GamePlayerValuePanelBackGround[2], 439.000000, 129.500000);
	TextDrawSetOutline(GamePlayerValuePanelBackGround[2], 0);
	TextDrawSetShadow(GamePlayerValuePanelBackGround[2], 0);
	TextDrawAlignment(GamePlayerValuePanelBackGround[2], 2);
	TextDrawColor(GamePlayerValuePanelBackGround[2], -1);
	TextDrawBackgroundColor(GamePlayerValuePanelBackGround[2], 1296911871);
	TextDrawBoxColor(GamePlayerValuePanelBackGround[2], 125);
	TextDrawUseBox(GamePlayerValuePanelBackGround[2], 1);
	TextDrawSetProportional(GamePlayerValuePanelBackGround[2], 1);
	TextDrawSetSelectable(GamePlayerValuePanelBackGround[2], 1);*/
	
	//-----------------------------速度表背景----------------------------------//
	SpeedoMetersBackGroundDraw[0] = TextDrawCreate(555.720214, 374.450042, "I____I____I____I");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[0], 0.222430, 1.564999);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[0], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[0], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[0], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[0], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[0], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[0], 2);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[0], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[0], 0);

	SpeedoMetersBackGroundDraw[1] = TextDrawCreate(545.438232, 379.283630, "IIII_IIII_IIII_IIII_IIII");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[1], 0.219150, 0.853332);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[1], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[1], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[1], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[1], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[1], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[1], 2);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[1], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[1], 0);

	SpeedoMetersBackGroundDraw[2] = TextDrawCreate(539.539794, 361.833282, "E");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[2], 0.297392, 1.372497);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[2], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[2], -2147483393);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[2], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[2], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[2], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[2], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[2], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[2], 0);

	SpeedoMetersBackGroundDraw[3] = TextDrawCreate(608.406433, 363.333435, "F");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[3], 0.325504, 1.214999);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[3], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[3], 8388863);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[3], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[3], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[3], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[3], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[3], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[3], 0);

	SpeedoMetersBackGroundDraw[4] = TextDrawCreate(613.685729, 377.833465, "box");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[4], 0.000000, 0.957542);
	TextDrawTextSize(SpeedoMetersBackGroundDraw[4], 610.000000, 0.000000);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[4], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[4], -1);
	TextDrawUseBox(SpeedoMetersBackGroundDraw[4], 1);
	TextDrawBoxColor(SpeedoMetersBackGroundDraw[4], 255);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[4], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[4], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[4], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[4], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[4], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[4], 0);

	SpeedoMetersBackGroundDraw[5] = TextDrawCreate(543.406860, 377.833587, "box");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[5], 0.000000, 0.910690);
	TextDrawTextSize(SpeedoMetersBackGroundDraw[5], 541.000000, 0.000000);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[5], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[5], -1);
	TextDrawUseBox(SpeedoMetersBackGroundDraw[5], 1);
	TextDrawBoxColor(SpeedoMetersBackGroundDraw[5], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[5], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[5], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[5], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[5], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[5], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[5], 0);

	SpeedoMetersBackGroundDraw[6] = TextDrawCreate(543.639038, 388.116699, "Fuel,bg,line");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[6], 0.000000, -0.260610);
	TextDrawTextSize(SpeedoMetersBackGroundDraw[6], 609.000000, 0.000000);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[6], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[6], -1);
	TextDrawUseBox(SpeedoMetersBackGroundDraw[6], 1);
	TextDrawBoxColor(SpeedoMetersBackGroundDraw[6], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[6], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[6], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[6], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[6], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[6], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[6], 0);

	SpeedoMetersBackGroundDraw[7] = TextDrawCreate(612.279663, 377.833587, "box");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[7], 0.000000, 0.910690);
	TextDrawTextSize(SpeedoMetersBackGroundDraw[7], 610.000000, 0.000000);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[7], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[7], -1);
	TextDrawUseBox(SpeedoMetersBackGroundDraw[7], 1);
	TextDrawBoxColor(SpeedoMetersBackGroundDraw[7], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[7], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[7], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[7], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[7], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[7], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[7], 0);

	SpeedoMetersBackGroundDraw[8] = TextDrawCreate(568.302490, 346.150177, "km/h");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[8], 0.240701, 1.337501);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[8], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[8], -1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[8], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[8], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[8], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[8], 2);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[8], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[8], 0);

	SpeedoMetersBackGroundDraw[9] = TextDrawCreate(542.839111, 397.216796, "Hp,Bg");
	TextDrawLetterSize(SpeedoMetersBackGroundDraw[9], 0.000000, 0.771687);
	TextDrawTextSize(SpeedoMetersBackGroundDraw[9], 610.866943, 0.000000);
	TextDrawAlignment(SpeedoMetersBackGroundDraw[9], 1);
	TextDrawColor(SpeedoMetersBackGroundDraw[9], -1);
	TextDrawUseBox(SpeedoMetersBackGroundDraw[9], 1);
	TextDrawBoxColor(SpeedoMetersBackGroundDraw[9], 97);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[9], 0);
	TextDrawSetOutline(SpeedoMetersBackGroundDraw[9], 0);
	TextDrawBackgroundColor(SpeedoMetersBackGroundDraw[9], 255);
	TextDrawFont(SpeedoMetersBackGroundDraw[9], 1);
	TextDrawSetProportional(SpeedoMetersBackGroundDraw[9], 1);
	TextDrawSetShadow(SpeedoMetersBackGroundDraw[9], 0);
	
	//-----------------------------小地图背景----------------------------------//
	SmallMapBackGround[0] = TextDrawCreate(122.000000, 12.000000, "~n~");
	TextDrawFont(SmallMapBackGround[0], 1);
	TextDrawLetterSize(SmallMapBackGround[0], 0.600000, 41.049999);
	TextDrawTextSize(SmallMapBackGround[0], 489.500000, 17.000000);
	TextDrawSetOutline(SmallMapBackGround[0], 1);
	TextDrawSetShadow(SmallMapBackGround[0], 0);
	TextDrawAlignment(SmallMapBackGround[0], 1);
	TextDrawColor(SmallMapBackGround[0], -1);
	TextDrawBackgroundColor(SmallMapBackGround[0], 255);
	TextDrawBoxColor(SmallMapBackGround[0], 99);
	TextDrawUseBox(SmallMapBackGround[0], 1);
	TextDrawSetProportional(SmallMapBackGround[0], 1);
	TextDrawSetSelectable(SmallMapBackGround[0], 0);
	
	SmallMapBackGround[1] = TextDrawCreate(126.000000, 16.000000, "samaps:gtasamapbit1");
	TextDrawFont(SmallMapBackGround[1], 4);
	TextDrawLetterSize(SmallMapBackGround[1], 0.600000, 2.000000);
	TextDrawTextSize(SmallMapBackGround[1], 180.500000, 180.500000);
	TextDrawSetOutline(SmallMapBackGround[1], 1);
	TextDrawSetShadow(SmallMapBackGround[1], 0);
	TextDrawAlignment(SmallMapBackGround[1], 1);
	TextDrawColor(SmallMapBackGround[1], -1);
	TextDrawBackgroundColor(SmallMapBackGround[1], 255);
	TextDrawBoxColor(SmallMapBackGround[1], 50);
	TextDrawUseBox(SmallMapBackGround[1], 1);
	TextDrawSetProportional(SmallMapBackGround[1], 1);
	TextDrawSetSelectable(SmallMapBackGround[1], 0);

	SmallMapBackGround[2] = TextDrawCreate(306.000000, 16.000000, "samaps:gtasamapbit2");
	TextDrawFont(SmallMapBackGround[2], 4);
	TextDrawLetterSize(SmallMapBackGround[2], 0.600000, 2.000000);
	TextDrawTextSize(SmallMapBackGround[2], 180.500000, 180.500000);
	TextDrawSetOutline(SmallMapBackGround[2], 1);
	TextDrawSetShadow(SmallMapBackGround[2], 0);
	TextDrawAlignment(SmallMapBackGround[2], 1);
	TextDrawColor(SmallMapBackGround[2], -1);
	TextDrawBackgroundColor(SmallMapBackGround[2], 255);
	TextDrawBoxColor(SmallMapBackGround[2], 50);
	TextDrawUseBox(SmallMapBackGround[2], 1);
	TextDrawSetProportional(SmallMapBackGround[2], 1);
	TextDrawSetSelectable(SmallMapBackGround[2], 0);

	SmallMapBackGround[3] = TextDrawCreate(126.000000, 196.000000, "samaps:gtasamapbit3");
	TextDrawFont(SmallMapBackGround[3], 4);
	TextDrawLetterSize(SmallMapBackGround[3], 0.600000, 2.000000);
	TextDrawTextSize(SmallMapBackGround[3], 180.500000, 180.500000);
	TextDrawSetOutline(SmallMapBackGround[3], 1);
	TextDrawSetShadow(SmallMapBackGround[3], 0);
	TextDrawAlignment(SmallMapBackGround[3], 1);
	TextDrawColor(SmallMapBackGround[3], -1);
	TextDrawBackgroundColor(SmallMapBackGround[3], 255);
	TextDrawBoxColor(SmallMapBackGround[3], 50);
	TextDrawUseBox(SmallMapBackGround[3], 1);
	TextDrawSetProportional(SmallMapBackGround[3], 1);
	TextDrawSetSelectable(SmallMapBackGround[3], 0);

	SmallMapBackGround[4] = TextDrawCreate(306.000000, 196.000000, "samaps:gtasamapbit4");
	TextDrawFont(SmallMapBackGround[4], 4);
	TextDrawLetterSize(SmallMapBackGround[4], 0.600000, 2.000000);
	TextDrawTextSize(SmallMapBackGround[4], 180.500000, 180.500000);
	TextDrawSetOutline(SmallMapBackGround[4], 1);
	TextDrawSetShadow(SmallMapBackGround[4], 0);
	TextDrawAlignment(SmallMapBackGround[4], 1);
	TextDrawColor(SmallMapBackGround[4], -1);
	TextDrawBackgroundColor(SmallMapBackGround[4], 255);
	TextDrawBoxColor(SmallMapBackGround[4], 50);
	TextDrawUseBox(SmallMapBackGround[4], 1);
	TextDrawSetProportional(SmallMapBackGround[4], 1);
	TextDrawSetSelectable(SmallMapBackGround[4], 0);
	
	SmallMapBackGround[5] = TextDrawCreate(162.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[5], 1);
	TextDrawLetterSize(SmallMapBackGround[5], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[5], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[5], 1);
	TextDrawSetShadow(SmallMapBackGround[5], 0);
	TextDrawAlignment(SmallMapBackGround[5], 2);
	TextDrawColor(SmallMapBackGround[5], -1);
	TextDrawBackgroundColor(SmallMapBackGround[5], 255);
	TextDrawBoxColor(SmallMapBackGround[5], -121);
	TextDrawUseBox(SmallMapBackGround[5], 1);
	TextDrawSetProportional(SmallMapBackGround[5], 1);
	TextDrawSetSelectable(SmallMapBackGround[5], 0);

	SmallMapBackGround[6] = TextDrawCreate(209.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[6], 1);
	TextDrawLetterSize(SmallMapBackGround[6], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[6], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[6], 1);
	TextDrawSetShadow(SmallMapBackGround[6], 0);
	TextDrawAlignment(SmallMapBackGround[6], 2);
	TextDrawColor(SmallMapBackGround[6], -1);
	TextDrawBackgroundColor(SmallMapBackGround[6], 255);
	TextDrawBoxColor(SmallMapBackGround[6], -121);
	TextDrawUseBox(SmallMapBackGround[6], 1);
	TextDrawSetProportional(SmallMapBackGround[6], 1);
	TextDrawSetSelectable(SmallMapBackGround[6], 0);

	SmallMapBackGround[7] = TextDrawCreate(259.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[7], 1);
	TextDrawLetterSize(SmallMapBackGround[7], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[7], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[7], 1);
	TextDrawSetShadow(SmallMapBackGround[7], 0);
	TextDrawAlignment(SmallMapBackGround[7], 2);
	TextDrawColor(SmallMapBackGround[7], -1);
	TextDrawBackgroundColor(SmallMapBackGround[7], 255);
	TextDrawBoxColor(SmallMapBackGround[7], -121);
	TextDrawUseBox(SmallMapBackGround[7], 1);
	TextDrawSetProportional(SmallMapBackGround[7], 1);
	TextDrawSetSelectable(SmallMapBackGround[7], 0);

	SmallMapBackGround[8] = TextDrawCreate(304.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[8], 1);
	TextDrawLetterSize(SmallMapBackGround[8], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[8], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[8], 1);
	TextDrawSetShadow(SmallMapBackGround[8], 0);
	TextDrawAlignment(SmallMapBackGround[8], 2);
	TextDrawColor(SmallMapBackGround[8], -1);
	TextDrawBackgroundColor(SmallMapBackGround[8], 255);
	TextDrawBoxColor(SmallMapBackGround[8], -121);
	TextDrawUseBox(SmallMapBackGround[8], 1);
	TextDrawSetProportional(SmallMapBackGround[8], 1);
	TextDrawSetSelectable(SmallMapBackGround[8], 0);

	SmallMapBackGround[9] = TextDrawCreate(351.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[9], 1);
	TextDrawLetterSize(SmallMapBackGround[9], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[9], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[9], 1);
	TextDrawSetShadow(SmallMapBackGround[9], 0);
	TextDrawAlignment(SmallMapBackGround[9], 2);
	TextDrawColor(SmallMapBackGround[9], -1);
	TextDrawBackgroundColor(SmallMapBackGround[9], 255);
	TextDrawBoxColor(SmallMapBackGround[9], -121);
	TextDrawUseBox(SmallMapBackGround[9], 1);
	TextDrawSetProportional(SmallMapBackGround[9], 1);
	TextDrawSetSelectable(SmallMapBackGround[9], 0);

	SmallMapBackGround[10] = TextDrawCreate(400.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[10], 1);
	TextDrawLetterSize(SmallMapBackGround[10], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[10], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[10], 1);
	TextDrawSetShadow(SmallMapBackGround[10], 0);
	TextDrawAlignment(SmallMapBackGround[10], 2);
	TextDrawColor(SmallMapBackGround[10], -1);
	TextDrawBackgroundColor(SmallMapBackGround[10], 255);
	TextDrawBoxColor(SmallMapBackGround[10], -121);
	TextDrawUseBox(SmallMapBackGround[10], 1);
	TextDrawSetProportional(SmallMapBackGround[10], 1);
	TextDrawSetSelectable(SmallMapBackGround[10], 0);

	SmallMapBackGround[11] = TextDrawCreate(444.000000, 17.000000, "_");
	TextDrawFont(SmallMapBackGround[11], 1);
	TextDrawLetterSize(SmallMapBackGround[11], 0.075000, 39.700000);
	TextDrawTextSize(SmallMapBackGround[11], 230.500000, -3.000000);
	TextDrawSetOutline(SmallMapBackGround[11], 1);
	TextDrawSetShadow(SmallMapBackGround[11], 0);
	TextDrawAlignment(SmallMapBackGround[11], 2);
	TextDrawColor(SmallMapBackGround[11], -1);
	TextDrawBackgroundColor(SmallMapBackGround[11], 255);
	TextDrawBoxColor(SmallMapBackGround[11], -121);
	TextDrawUseBox(SmallMapBackGround[11], 1);
	TextDrawSetProportional(SmallMapBackGround[11], 1);
	TextDrawSetSelectable(SmallMapBackGround[11], 0);

	SmallMapBackGround[12] = TextDrawCreate(306.000000, 71.000000, "_");
	TextDrawFont(SmallMapBackGround[12], 1);
	TextDrawLetterSize(SmallMapBackGround[12], 0.075000, -0.399928);
	TextDrawTextSize(SmallMapBackGround[12], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[12], 1);
	TextDrawSetShadow(SmallMapBackGround[12], 0);
	TextDrawAlignment(SmallMapBackGround[12], 2);
	TextDrawColor(SmallMapBackGround[12], -1);
	TextDrawBackgroundColor(SmallMapBackGround[12], 255);
	TextDrawBoxColor(SmallMapBackGround[12], -121);
	TextDrawUseBox(SmallMapBackGround[12], 1);
	TextDrawSetProportional(SmallMapBackGround[12], 1);
	TextDrawSetSelectable(SmallMapBackGround[12], 0);

	SmallMapBackGround[13] = TextDrawCreate(306.000000, 132.000000, "_");
	TextDrawFont(SmallMapBackGround[13], 1);
	TextDrawLetterSize(SmallMapBackGround[13], 0.075000, -0.399928);
	TextDrawTextSize(SmallMapBackGround[13], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[13], 1);
	TextDrawSetShadow(SmallMapBackGround[13], 0);
	TextDrawAlignment(SmallMapBackGround[13], 2);
	TextDrawColor(SmallMapBackGround[13], -1);
	TextDrawBackgroundColor(SmallMapBackGround[13], 255);
	TextDrawBoxColor(SmallMapBackGround[13], -121);
	TextDrawUseBox(SmallMapBackGround[13], 1);
	TextDrawSetProportional(SmallMapBackGround[13], 1);
	TextDrawSetSelectable(SmallMapBackGround[13], 0);

	SmallMapBackGround[14] = TextDrawCreate(306.000000, 195.000000, "_");
	TextDrawFont(SmallMapBackGround[14], 1);
	TextDrawLetterSize(SmallMapBackGround[14], 0.075000, -0.399928);
	TextDrawTextSize(SmallMapBackGround[14], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[14], 1);
	TextDrawSetShadow(SmallMapBackGround[14], 0);
	TextDrawAlignment(SmallMapBackGround[14], 2);
	TextDrawColor(SmallMapBackGround[14], -1);
	TextDrawBackgroundColor(SmallMapBackGround[14], 255);
	TextDrawBoxColor(SmallMapBackGround[14], -121);
	TextDrawUseBox(SmallMapBackGround[14], 1);
	TextDrawSetProportional(SmallMapBackGround[14], 1);
	TextDrawSetSelectable(SmallMapBackGround[14], 0);

	SmallMapBackGround[15] = TextDrawCreate(306.000000, 257.000000, "_");
	TextDrawFont(SmallMapBackGround[15], 1);
	TextDrawLetterSize(SmallMapBackGround[15], 0.075000, -0.399928);
	TextDrawTextSize(SmallMapBackGround[15], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[15], 1);
	TextDrawSetShadow(SmallMapBackGround[15], 0);
	TextDrawAlignment(SmallMapBackGround[15], 2);
	TextDrawColor(SmallMapBackGround[15], -1);
	TextDrawBackgroundColor(SmallMapBackGround[15], 255);
	TextDrawBoxColor(SmallMapBackGround[15], -121);
	TextDrawUseBox(SmallMapBackGround[15], 1);
	TextDrawSetProportional(SmallMapBackGround[15], 1);
	TextDrawSetSelectable(SmallMapBackGround[15], 0);

	SmallMapBackGround[16] = TextDrawCreate(306.000000, 321.000000, "_");
	TextDrawFont(SmallMapBackGround[16], 1);
	TextDrawLetterSize(SmallMapBackGround[16], 0.075000, -0.399928);
	TextDrawTextSize(SmallMapBackGround[16], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[16], 1);
	TextDrawSetShadow(SmallMapBackGround[16], 0);
	TextDrawAlignment(SmallMapBackGround[16], 2);
	TextDrawColor(SmallMapBackGround[16], -1);
	TextDrawBackgroundColor(SmallMapBackGround[16], 255);
	TextDrawBoxColor(SmallMapBackGround[16], -121);
	TextDrawUseBox(SmallMapBackGround[16], 1);
	TextDrawSetProportional(SmallMapBackGround[16], 1);
	TextDrawSetSelectable(SmallMapBackGround[16], 0);

	SmallMapBackGround[17] = TextDrawCreate(143.000000, 4.000000, "A");
	TextDrawFont(SmallMapBackGround[17], 2);
	TextDrawLetterSize(SmallMapBackGround[17], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[17], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[17], 1);
	TextDrawSetShadow(SmallMapBackGround[17], 0);
	TextDrawAlignment(SmallMapBackGround[17], 2);
	TextDrawColor(SmallMapBackGround[17], -1);
	TextDrawBackgroundColor(SmallMapBackGround[17], 255);
	TextDrawBoxColor(SmallMapBackGround[17], -121);
	TextDrawUseBox(SmallMapBackGround[17], 0);
	TextDrawSetProportional(SmallMapBackGround[17], 1);
	TextDrawSetSelectable(SmallMapBackGround[17], 0);

	SmallMapBackGround[18] = TextDrawCreate(187.000000, 4.000000, "B");
	TextDrawFont(SmallMapBackGround[18], 2);
	TextDrawLetterSize(SmallMapBackGround[18], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[18], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[18], 1);
	TextDrawSetShadow(SmallMapBackGround[18], 0);
	TextDrawAlignment(SmallMapBackGround[18], 2);
	TextDrawColor(SmallMapBackGround[18], -1);
	TextDrawBackgroundColor(SmallMapBackGround[18], 255);
	TextDrawBoxColor(SmallMapBackGround[18], -121);
	TextDrawUseBox(SmallMapBackGround[18], 0);
	TextDrawSetProportional(SmallMapBackGround[18], 1);
	TextDrawSetSelectable(SmallMapBackGround[18], 0);

	SmallMapBackGround[19] = TextDrawCreate(236.000000, 4.000000, "C");
	TextDrawFont(SmallMapBackGround[19], 2);
	TextDrawLetterSize(SmallMapBackGround[19], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[19], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[19], 1);
	TextDrawSetShadow(SmallMapBackGround[19], 0);
	TextDrawAlignment(SmallMapBackGround[19], 2);
	TextDrawColor(SmallMapBackGround[19], -1);
	TextDrawBackgroundColor(SmallMapBackGround[19], 255);
	TextDrawBoxColor(SmallMapBackGround[19], -121);
	TextDrawUseBox(SmallMapBackGround[19], 0);
	TextDrawSetProportional(SmallMapBackGround[19], 1);
	TextDrawSetSelectable(SmallMapBackGround[19], 0);

	SmallMapBackGround[20] = TextDrawCreate(282.000000, 4.000000, "D");
	TextDrawFont(SmallMapBackGround[20], 2);
	TextDrawLetterSize(SmallMapBackGround[20], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[20], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[20], 1);
	TextDrawSetShadow(SmallMapBackGround[20], 0);
	TextDrawAlignment(SmallMapBackGround[20], 2);
	TextDrawColor(SmallMapBackGround[20], -1);
	TextDrawBackgroundColor(SmallMapBackGround[20], 255);
	TextDrawBoxColor(SmallMapBackGround[20], -121);
	TextDrawUseBox(SmallMapBackGround[20], 0);
	TextDrawSetProportional(SmallMapBackGround[20], 1);
	TextDrawSetSelectable(SmallMapBackGround[20], 0);

	SmallMapBackGround[21] = TextDrawCreate(327.000000, 4.000000, "E");
	TextDrawFont(SmallMapBackGround[21], 2);
	TextDrawLetterSize(SmallMapBackGround[21], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[21], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[21], 1);
	TextDrawSetShadow(SmallMapBackGround[21], 0);
	TextDrawAlignment(SmallMapBackGround[21], 2);
	TextDrawColor(SmallMapBackGround[21], -1);
	TextDrawBackgroundColor(SmallMapBackGround[21], 255);
	TextDrawBoxColor(SmallMapBackGround[21], -121);
	TextDrawUseBox(SmallMapBackGround[21], 0);
	TextDrawSetProportional(SmallMapBackGround[21], 1);
	TextDrawSetSelectable(SmallMapBackGround[21], 0);

	SmallMapBackGround[22] = TextDrawCreate(374.000000, 4.000000, "F");
	TextDrawFont(SmallMapBackGround[22], 2);
	TextDrawLetterSize(SmallMapBackGround[22], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[22], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[22], 1);
	TextDrawSetShadow(SmallMapBackGround[22], 0);
	TextDrawAlignment(SmallMapBackGround[22], 2);
	TextDrawColor(SmallMapBackGround[22], -1);
	TextDrawBackgroundColor(SmallMapBackGround[22], 255);
	TextDrawBoxColor(SmallMapBackGround[22], -121);
	TextDrawUseBox(SmallMapBackGround[22], 0);
	TextDrawSetProportional(SmallMapBackGround[22], 1);
	TextDrawSetSelectable(SmallMapBackGround[22], 0);

	SmallMapBackGround[23] = TextDrawCreate(422.000000, 4.000000, "G");
	TextDrawFont(SmallMapBackGround[23], 2);
	TextDrawLetterSize(SmallMapBackGround[23], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[23], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[23], 1);
	TextDrawSetShadow(SmallMapBackGround[23], 0);
	TextDrawAlignment(SmallMapBackGround[23], 2);
	TextDrawColor(SmallMapBackGround[23], -1);
	TextDrawBackgroundColor(SmallMapBackGround[23], 255);
	TextDrawBoxColor(SmallMapBackGround[23], -121);
	TextDrawUseBox(SmallMapBackGround[23], 0);
	TextDrawSetProportional(SmallMapBackGround[23], 1);
	TextDrawSetSelectable(SmallMapBackGround[23], 0);

	SmallMapBackGround[24] = TextDrawCreate(465.000000, 4.000000, "H");
	TextDrawFont(SmallMapBackGround[24], 2);
	TextDrawLetterSize(SmallMapBackGround[24], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[24], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[24], 1);
	TextDrawSetShadow(SmallMapBackGround[24], 0);
	TextDrawAlignment(SmallMapBackGround[24], 2);
	TextDrawColor(SmallMapBackGround[24], -1);
	TextDrawBackgroundColor(SmallMapBackGround[24], 255);
	TextDrawBoxColor(SmallMapBackGround[24], -121);
	TextDrawUseBox(SmallMapBackGround[24], 0);
	TextDrawSetProportional(SmallMapBackGround[24], 1);
	TextDrawSetSelectable(SmallMapBackGround[24], 0);

	SmallMapBackGround[25] = TextDrawCreate(124.000000, 34.000000, "1");
	TextDrawFont(SmallMapBackGround[25], 2);
	TextDrawLetterSize(SmallMapBackGround[25], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[25], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[25], 1);
	TextDrawSetShadow(SmallMapBackGround[25], 0);
	TextDrawAlignment(SmallMapBackGround[25], 2);
	TextDrawColor(SmallMapBackGround[25], -1);
	TextDrawBackgroundColor(SmallMapBackGround[25], 255);
	TextDrawBoxColor(SmallMapBackGround[25], -121);
	TextDrawUseBox(SmallMapBackGround[25], 0);
	TextDrawSetProportional(SmallMapBackGround[25], 1);
	TextDrawSetSelectable(SmallMapBackGround[25], 0);

	SmallMapBackGround[26] = TextDrawCreate(124.000000, 94.000000, "2");
	TextDrawFont(SmallMapBackGround[26], 2);
	TextDrawLetterSize(SmallMapBackGround[26], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[26], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[26], 1);
	TextDrawSetShadow(SmallMapBackGround[26], 0);
	TextDrawAlignment(SmallMapBackGround[26], 2);
	TextDrawColor(SmallMapBackGround[26], -1);
	TextDrawBackgroundColor(SmallMapBackGround[26], 255);
	TextDrawBoxColor(SmallMapBackGround[26], -121);
	TextDrawUseBox(SmallMapBackGround[26], 0);
	TextDrawSetProportional(SmallMapBackGround[26], 1);
	TextDrawSetSelectable(SmallMapBackGround[26], 0);

	SmallMapBackGround[27] = TextDrawCreate(124.000000, 152.000000, "3");
	TextDrawFont(SmallMapBackGround[27], 2);
	TextDrawLetterSize(SmallMapBackGround[27], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[27], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[27], 1);
	TextDrawSetShadow(SmallMapBackGround[27], 0);
	TextDrawAlignment(SmallMapBackGround[27], 2);
	TextDrawColor(SmallMapBackGround[27], -1);
	TextDrawBackgroundColor(SmallMapBackGround[27], 255);
	TextDrawBoxColor(SmallMapBackGround[27], -121);
	TextDrawUseBox(SmallMapBackGround[27], 0);
	TextDrawSetProportional(SmallMapBackGround[27], 1);
	TextDrawSetSelectable(SmallMapBackGround[27], 0);

	SmallMapBackGround[28] = TextDrawCreate(124.000000, 214.000000, "4");
	TextDrawFont(SmallMapBackGround[28], 2);
	TextDrawLetterSize(SmallMapBackGround[28], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[28], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[28], 1);
	TextDrawSetShadow(SmallMapBackGround[28], 0);
	TextDrawAlignment(SmallMapBackGround[28], 2);
	TextDrawColor(SmallMapBackGround[28], -1);
	TextDrawBackgroundColor(SmallMapBackGround[28], 255);
	TextDrawBoxColor(SmallMapBackGround[28], -121);
	TextDrawUseBox(SmallMapBackGround[28], 0);
	TextDrawSetProportional(SmallMapBackGround[28], 1);
	TextDrawSetSelectable(SmallMapBackGround[28], 0);

	SmallMapBackGround[29] = TextDrawCreate(124.000000, 278.000000, "5");
	TextDrawFont(SmallMapBackGround[29], 2);
	TextDrawLetterSize(SmallMapBackGround[29], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[29], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[29], 1);
	TextDrawSetShadow(SmallMapBackGround[29], 0);
	TextDrawAlignment(SmallMapBackGround[29], 2);
	TextDrawColor(SmallMapBackGround[29], -1);
	TextDrawBackgroundColor(SmallMapBackGround[29], 255);
	TextDrawBoxColor(SmallMapBackGround[29], -121);
	TextDrawUseBox(SmallMapBackGround[29], 0);
	TextDrawSetProportional(SmallMapBackGround[29], 1);
	TextDrawSetSelectable(SmallMapBackGround[29], 0);

	SmallMapBackGround[30] = TextDrawCreate(124.000000, 341.000000, "6");
	TextDrawFont(SmallMapBackGround[30], 2);
	TextDrawLetterSize(SmallMapBackGround[30], 0.324999, 2.000070);
	TextDrawTextSize(SmallMapBackGround[30], 199.500000, -363.000000);
	TextDrawSetOutline(SmallMapBackGround[30], 1);
	TextDrawSetShadow(SmallMapBackGround[30], 0);
	TextDrawAlignment(SmallMapBackGround[30], 2);
	TextDrawColor(SmallMapBackGround[30], -1);
	TextDrawBackgroundColor(SmallMapBackGround[30], 255);
	TextDrawBoxColor(SmallMapBackGround[30], -121);
	TextDrawUseBox(SmallMapBackGround[30], 0);
	TextDrawSetProportional(SmallMapBackGround[30], 1);
	TextDrawSetSelectable(SmallMapBackGround[30], 0);
	//-----------------------------时间轴背景----------------------------------//
	Time_Line_BackGround[0] = TextDrawCreate(56.000000, 312.000000, "~n~");
	TextDrawFont(Time_Line_BackGround[0], 1);
	TextDrawLetterSize(Time_Line_BackGround[0], 0.600000, 0.349999);
	TextDrawTextSize(Time_Line_BackGround[0], 119.000000, 17.000000);
	TextDrawSetOutline(Time_Line_BackGround[0], 1);
	TextDrawSetShadow(Time_Line_BackGround[0], 0);
	TextDrawAlignment(Time_Line_BackGround[0], 1);
	TextDrawColor(Time_Line_BackGround[0], -1);
	TextDrawBackgroundColor(Time_Line_BackGround[0], 255);
	TextDrawBoxColor(Time_Line_BackGround[0], 50);
	TextDrawUseBox(Time_Line_BackGround[0], 1);
	TextDrawSetProportional(Time_Line_BackGround[0], 1);
	TextDrawSetSelectable(Time_Line_BackGround[0], 0);

	Time_Line_BackGround[1] = TextDrawCreate(56.000000, 312.000000, "~n~");
	TextDrawFont(Time_Line_BackGround[1], 1);
	TextDrawLetterSize(Time_Line_BackGround[1], 0.600000, 0.349999);
	TextDrawTextSize(Time_Line_BackGround[1], 58.000000, 17.000000);
	TextDrawSetOutline(Time_Line_BackGround[1], 0);
	TextDrawSetShadow(Time_Line_BackGround[1], 0);
	TextDrawAlignment(Time_Line_BackGround[1], 1);
	TextDrawColor(Time_Line_BackGround[1], -1);
	TextDrawBackgroundColor(Time_Line_BackGround[1], 255);
	TextDrawBoxColor(Time_Line_BackGround[1], 65535);
	TextDrawUseBox(Time_Line_BackGround[1], 1);
	TextDrawSetProportional(Time_Line_BackGround[1], 1);
	TextDrawSetSelectable(Time_Line_BackGround[1], 0);

	Time_Line_BackGround[2] = TextDrawCreate(117.000000, 312.000000, "~n~");
	TextDrawFont(Time_Line_BackGround[2], 1);
	TextDrawLetterSize(Time_Line_BackGround[2], 0.600000, 0.349999);
	TextDrawTextSize(Time_Line_BackGround[2], 119.000000, 11.000000);
	TextDrawSetOutline(Time_Line_BackGround[2], 0);
	TextDrawSetShadow(Time_Line_BackGround[2], 0);
	TextDrawAlignment(Time_Line_BackGround[2], 1);
	TextDrawColor(Time_Line_BackGround[2], -1);
	TextDrawBackgroundColor(Time_Line_BackGround[2], 255);
	TextDrawBoxColor(Time_Line_BackGround[2], -1);
	TextDrawUseBox(Time_Line_BackGround[2], 1);
	TextDrawSetProportional(Time_Line_BackGround[2], 1);
	TextDrawSetSelectable(Time_Line_BackGround[2], 0);
	//-----------------------------飞行背景----------------------------------//
	FlyMap_BackGround[0] = TextDrawCreate(115.000000, 222.000000, "~n~");
	TextDrawFont(FlyMap_BackGround[0], 1);
	TextDrawLetterSize(FlyMap_BackGround[0], 0.600000, 24.849962);
	TextDrawTextSize(FlyMap_BackGround[0], 466.500000, 221.500000);
	TextDrawSetOutline(FlyMap_BackGround[0], 1);
	TextDrawSetShadow(FlyMap_BackGround[0], 0);
	TextDrawAlignment(FlyMap_BackGround[0], 2);
	TextDrawColor(FlyMap_BackGround[0], -1);
	TextDrawBackgroundColor(FlyMap_BackGround[0], 255);
	TextDrawBoxColor(FlyMap_BackGround[0], -206);
	TextDrawUseBox(FlyMap_BackGround[0], 1);
	TextDrawSetProportional(FlyMap_BackGround[0], 1);
	TextDrawSetSelectable(FlyMap_BackGround[0], 0);
	
	FlyMap_BackGround[1] = TextDrawCreate(6.000000, 225.000000, "samaps:map");
	TextDrawFont(FlyMap_BackGround[1], 4);
	TextDrawLetterSize(FlyMap_BackGround[1], 0.600000, 2.000000);
	TextDrawTextSize(FlyMap_BackGround[1], 217.500000, 217.500000);
	TextDrawSetOutline(FlyMap_BackGround[1], 1);
	TextDrawSetShadow(FlyMap_BackGround[1], 0);
	TextDrawAlignment(FlyMap_BackGround[1], 1);
	TextDrawColor(FlyMap_BackGround[1], -1);
	TextDrawBackgroundColor(FlyMap_BackGround[1], 255);
	TextDrawBoxColor(FlyMap_BackGround[1], 50);
	TextDrawUseBox(FlyMap_BackGround[1], 1);
	TextDrawSetProportional(FlyMap_BackGround[1], 1);
	TextDrawSetSelectable(FlyMap_BackGround[1], 0);
	
	//-----------------------------GAMEOVER背景----------------------------------//
    new Text:GameOverDraw=Text:INVALID_TEXT_DRAW;
	GameOverDraw = TextDrawCreate(319.000000, -2.000000, "~n~");
	TextDrawFont(GameOverDraw, 1);
	TextDrawLetterSize(GameOverDraw, 0.600000, 53.699981);
	TextDrawTextSize(GameOverDraw, 400.000000, 643.500000);
	TextDrawSetOutline(GameOverDraw, 1);
	TextDrawSetShadow(GameOverDraw, 0);
	TextDrawAlignment(GameOverDraw, 2);
	TextDrawColor(GameOverDraw, -1);
	TextDrawBackgroundColor(GameOverDraw, 255);
	TextDrawBoxColor(GameOverDraw, 100);
	TextDrawUseBox(GameOverDraw, 1);
	TextDrawSetProportional(GameOverDraw, 1);
	TextDrawSetSelectable(GameOverDraw, 0);
	GameOverPrive[0]=GameOverDraw;
	GameOverDraw=Text:INVALID_TEXT_DRAW;

	GameOverDraw = TextDrawCreate(31.000000, 172.000000, "~n~");
	TextDrawFont(GameOverDraw, 1);
	TextDrawLetterSize(GameOverDraw, 0.600000, -0.399998);
	TextDrawTextSize(GameOverDraw, 606.500000, 52.500000);
	TextDrawSetOutline(GameOverDraw, 1);
	TextDrawSetShadow(GameOverDraw, 0);
	TextDrawAlignment(GameOverDraw, 1);
	TextDrawColor(GameOverDraw, -1);
	TextDrawBackgroundColor(GameOverDraw, 255);
	TextDrawBoxColor(GameOverDraw, -1);
	TextDrawUseBox(GameOverDraw, 1);
	TextDrawSetProportional(GameOverDraw, 1);
	TextDrawSetSelectable(GameOverDraw, 0);
	GameOverPrive[1]=GameOverDraw;
	GameOverDraw=Text:INVALID_TEXT_DRAW;

	GameOverDraw = TextDrawCreate(31.000000, 305.000000, "~n~");
	TextDrawFont(GameOverDraw, 1);
	TextDrawLetterSize(GameOverDraw, 0.600000, -0.399998);
	TextDrawTextSize(GameOverDraw, 606.500000, 52.500000);
	TextDrawSetOutline(GameOverDraw, 1);
	TextDrawSetShadow(GameOverDraw, 0);
	TextDrawAlignment(GameOverDraw, 1);
	TextDrawColor(GameOverDraw, -1);
	TextDrawBackgroundColor(GameOverDraw, 255);
	TextDrawBoxColor(GameOverDraw, -1);
	TextDrawUseBox(GameOverDraw, 1);
	TextDrawSetProportional(GameOverDraw, 1);
	TextDrawSetSelectable(GameOverDraw, 0);
	GameOverPrive[2]=GameOverDraw;
	GameOverDraw=Text:INVALID_TEXT_DRAW;

	GameOverDraw = TextDrawCreate(32.000000, 221.000000, "REWARD");
	TextDrawFont(GameOverDraw, 2);
	TextDrawLetterSize(GameOverDraw, 0.612500, 2.949999);
	TextDrawTextSize(GameOverDraw, 400.000000, 17.000000);
	TextDrawSetOutline(GameOverDraw, 1);
	TextDrawSetShadow(GameOverDraw, 0);
	TextDrawAlignment(GameOverDraw, 1);
	TextDrawColor(GameOverDraw, -1);
	TextDrawBackgroundColor(GameOverDraw, 255);
	TextDrawBoxColor(GameOverDraw, 50);
	TextDrawUseBox(GameOverDraw, 0);
	TextDrawSetProportional(GameOverDraw, 1);
	TextDrawSetSelectable(GameOverDraw, 0);
	GameOverPrive[3]=GameOverDraw;
	GameOverDraw=Text:INVALID_TEXT_DRAW;

	GameOverDraw = TextDrawCreate(150.000000, 226.000000, "HUD:radar_race");
	TextDrawFont(GameOverDraw, 5);
	TextDrawLetterSize(GameOverDraw, 0.600000, 2.000000);
	TextDrawTextSize(GameOverDraw, 20.000000, 20.000000);
	TextDrawSetOutline(GameOverDraw, 1);
	TextDrawSetShadow(GameOverDraw, 0);
	TextDrawAlignment(GameOverDraw, 1);
	TextDrawColor(GameOverDraw, -1);
	TextDrawBackgroundColor(GameOverDraw, 0);
	TextDrawBoxColor(GameOverDraw, 50);
	TextDrawUseBox(GameOverDraw, 1);
	TextDrawSetProportional(GameOverDraw, 1);
	TextDrawSetSelectable(GameOverDraw, 0);
	TextDrawSetPreviewModel(GameOverDraw, 1855);
	TextDrawSetPreviewRot(GameOverDraw, -97.000000, 1.000000, -169.000000, 0.970000);
	TextDrawSetPreviewVehCol(GameOverDraw, 1, 1);
	GameOverPrive[4]=GameOverDraw;
	GameOverDraw=Text:INVALID_TEXT_DRAW;
	
	//-----------------------------等待显示人数背景----------------------------------//
	WaitRoomPrive[0] = TextDrawCreate(556.000000, 3.000000, "~n~");
	TextDrawFont(WaitRoomPrive[0], 1);
	TextDrawLetterSize(WaitRoomPrive[0], 0.600000, 2.049993);
	TextDrawTextSize(WaitRoomPrive[0], 335.000000, 31.500000);
	TextDrawSetOutline(WaitRoomPrive[0], 1);
	TextDrawSetShadow(WaitRoomPrive[0], 0);
	TextDrawAlignment(WaitRoomPrive[0], 2);
	TextDrawColor(WaitRoomPrive[0], -1);
	TextDrawBackgroundColor(WaitRoomPrive[0], 255);
	TextDrawBoxColor(WaitRoomPrive[0], 1296911871);
	TextDrawUseBox(WaitRoomPrive[0], 1);
	TextDrawSetProportional(WaitRoomPrive[0], 1);
	TextDrawSetSelectable(WaitRoomPrive[0], 0);

	WaitRoomPrive[1] = TextDrawCreate(606.000000, 3.000000, "~n~");
	TextDrawFont(WaitRoomPrive[1], 1);
	TextDrawLetterSize(WaitRoomPrive[1], 0.600000, 2.049993);
	TextDrawTextSize(WaitRoomPrive[1], 334.000000, 61.500000);
	TextDrawSetOutline(WaitRoomPrive[1], 1);
	TextDrawSetShadow(WaitRoomPrive[1], 0);
	TextDrawAlignment(WaitRoomPrive[1], 2);
	TextDrawColor(WaitRoomPrive[1], -1);
	TextDrawBackgroundColor(WaitRoomPrive[1], 255);
	TextDrawBoxColor(WaitRoomPrive[1], -1094795521);
	TextDrawUseBox(WaitRoomPrive[1], 1);
	TextDrawSetProportional(WaitRoomPrive[1], 1);
	TextDrawSetSelectable(WaitRoomPrive[1], 0);

	WaitRoomPrive[2] = TextDrawCreate(606.000000, 2.000000, "JOINED");
	TextDrawFont(WaitRoomPrive[2], 2);
	TextDrawLetterSize(WaitRoomPrive[2], 0.379166, 2.000000);
	TextDrawTextSize(WaitRoomPrive[2], 400.000000, 17.000000);
	TextDrawSetOutline(WaitRoomPrive[2], 0);
	TextDrawSetShadow(WaitRoomPrive[2], 0);
	TextDrawAlignment(WaitRoomPrive[2], 2);
	TextDrawColor(WaitRoomPrive[2], -1);
	TextDrawBackgroundColor(WaitRoomPrive[2], 255);
	TextDrawBoxColor(WaitRoomPrive[2], 50);
	TextDrawUseBox(WaitRoomPrive[2], 0);
	TextDrawSetProportional(WaitRoomPrive[2], 1);
	TextDrawSetSelectable(WaitRoomPrive[2], 0);

	WaitRoomPrive[3] = TextDrawCreate(320.000000, 75.000000, "~n~");
	TextDrawFont(WaitRoomPrive[3], 1);
	TextDrawLetterSize(WaitRoomPrive[3], 0.600000, 4.299993);
	TextDrawTextSize(WaitRoomPrive[3], 400.000000, 129.000000);
	TextDrawSetOutline(WaitRoomPrive[3], 1);
	TextDrawSetShadow(WaitRoomPrive[3], 0);
	TextDrawAlignment(WaitRoomPrive[3], 2);
	TextDrawColor(WaitRoomPrive[3], -1);
	TextDrawBackgroundColor(WaitRoomPrive[3], 255);
	TextDrawBoxColor(WaitRoomPrive[3], 70);
	TextDrawUseBox(WaitRoomPrive[3], 1);
	TextDrawSetProportional(WaitRoomPrive[3], 1);
	TextDrawSetSelectable(WaitRoomPrive[3], 0);

	WaitRoomPrive[4] = TextDrawCreate(320.000000, 74.000000, "~n~");
	TextDrawFont(WaitRoomPrive[4], 1);
	TextDrawLetterSize(WaitRoomPrive[4], 0.600000, -0.250000);
	TextDrawTextSize(WaitRoomPrive[4], 400.000000, 129.000000);
	TextDrawSetOutline(WaitRoomPrive[4], 1);
	TextDrawSetShadow(WaitRoomPrive[4], 0);
	TextDrawAlignment(WaitRoomPrive[4], 2);
	TextDrawColor(WaitRoomPrive[4], -1);
	TextDrawBackgroundColor(WaitRoomPrive[4], 255);
	TextDrawBoxColor(WaitRoomPrive[4], -1);
	TextDrawUseBox(WaitRoomPrive[4], 1);
	TextDrawSetProportional(WaitRoomPrive[4], 1);
	TextDrawSetSelectable(WaitRoomPrive[4], 0);

	WaitRoomPrive[5] = TextDrawCreate(320.000000, 116.000000, "~n~");
	TextDrawFont(WaitRoomPrive[5], 1);
	TextDrawLetterSize(WaitRoomPrive[5], 0.600000, -0.250000);
	TextDrawTextSize(WaitRoomPrive[5], 400.000000, 129.000000);
	TextDrawSetOutline(WaitRoomPrive[5], 1);
	TextDrawSetShadow(WaitRoomPrive[5], 0);
	TextDrawAlignment(WaitRoomPrive[5], 2);
	TextDrawColor(WaitRoomPrive[5], -1);
	TextDrawBackgroundColor(WaitRoomPrive[5], 255);
	TextDrawBoxColor(WaitRoomPrive[5], -1);
	TextDrawUseBox(WaitRoomPrive[5], 1);
	TextDrawSetProportional(WaitRoomPrive[5], 1);
	TextDrawSetSelectable(WaitRoomPrive[5], 0);

	WaitRoomPrive[6] = TextDrawCreate(321.000000, 30.000000, "MATCH_START_COUNTDOWN");
	TextDrawFont(WaitRoomPrive[6], 2);
	TextDrawLetterSize(WaitRoomPrive[6], 0.424998, 4.449996);
	TextDrawTextSize(WaitRoomPrive[6], 400.000000, 302.000000);
	TextDrawSetOutline(WaitRoomPrive[6], 1);
	TextDrawSetShadow(WaitRoomPrive[6], 0);
	TextDrawAlignment(WaitRoomPrive[6], 2);
	TextDrawColor(WaitRoomPrive[6], 255);
	TextDrawBackgroundColor(WaitRoomPrive[6], -1);
	TextDrawBoxColor(WaitRoomPrive[6], 50);
	TextDrawUseBox(WaitRoomPrive[6], 0);
	TextDrawSetProportional(WaitRoomPrive[6], 1);
	TextDrawSetSelectable(WaitRoomPrive[6], 0);
	/*****************************商城*******************************/
	new Text:MallDraw=Text:INVALID_TEXT_DRAW;
	MallDraw = TextDrawCreate(320.000000, 66.000000, "~n~");//background1
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 40.550006);
	TextDrawTextSize(MallDraw, 400.000000, 467.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -16777166);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[0]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(320.000000, 70.000000, "~n~");//background2
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 39.750019);
	TextDrawTextSize(MallDraw, 400.000000, 460.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 1296911871);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[1]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(320.000000, 66.000000, "STORE");//caption
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.612500, 3.450000);
	TextDrawTextSize(MallDraw, 400.000000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -16776961);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[2]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(320.000000, 98.000000, "~n~");//line1
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, -0.299997);
	TextDrawTextSize(MallDraw, 400.000000, 459.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -741092353);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 16711935);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[3]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(320.000000, 136.000000, "~n~");//line2
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, -0.299997);
	TextDrawTextSize(MallDraw, 400.000000, 447.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[4]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(320.000000, 425.000000, "~n~");//line3
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, -0.299997);
	TextDrawTextSize(MallDraw, 400.000000, 447.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[5]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(95.000000, 136.000000, "~n~");//line4
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 31.799957);
	TextDrawTextSize(MallDraw, 400.000000, -2.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[6]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(545.000000, 136.000000, "~n~");//line5
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 31.799957);
	TextDrawTextSize(MallDraw, 400.000000, -2.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[7]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(137.000000, 104.000000, "~n~");//botton1
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 2.549998);
	TextDrawTextSize(MallDraw, 400.000000, 82.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1378294017);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[8]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(228.000000, 104.000000, "~n~");//botton2
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 2.549998);
	TextDrawTextSize(MallDraw, 400.000000, 82.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1378294017);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[9]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(319.000000, 104.000000, "~n~");//botton3
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 2.549998);
	TextDrawTextSize(MallDraw, 400.000000, 82.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1378294017);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[10]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(410.000000, 104.000000, "~n~");//botton4
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 2.549998);
	TextDrawTextSize(MallDraw, 400.000000, 82.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1378294017);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	MallBackGround[11]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(103.000000, 106.000000, "SKINS");//botton1tag
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 170.500000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, 255);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	MallBackGround[12]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(186.000000, 106.000000, "adorn");//botton2tag
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 268.000000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, 255);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	MallBackGround[13]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(287.000000, 106.000000, "boxs");//botton3tag
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 352.000000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, 255);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	MallBackGround[14]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(457.000000, 108.000000, "Nowy_TextDraw");//icon
	TextDrawFont(MallDraw, 5);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 16.500000, 17.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 0);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	TextDrawSetPreviewModel(MallDraw, 1855);
	TextDrawSetPreviewRot(MallDraw, -90.000000, 0.000000, 3.000000, 0.769999);
	TextDrawSetPreviewVehCol(MallDraw, 1, 1);
	MallBackGround[15]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(527.000000, 72.000000, "ld_beat:cross");//close
	TextDrawFont(MallDraw, 4);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 21.500000, 20.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	MallBackGround[16]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;
	/*************************死亡宝箱************************************/
	new Text:DeathBoxDraw=Text:INVALID_TEXT_DRAW;
	DeathBoxDraw = TextDrawCreate(197.000000, 82.000000, "~n~");//boxback
	TextDrawFont(DeathBoxDraw, 1);
	TextDrawLetterSize(DeathBoxDraw, 0.600000, 27.800033);
	TextDrawTextSize(DeathBoxDraw, 400.000000, 129.000000);
	TextDrawSetOutline(DeathBoxDraw, 1);
	TextDrawSetShadow(DeathBoxDraw, 0);
	TextDrawAlignment(DeathBoxDraw, 2);
	TextDrawColor(DeathBoxDraw, -1);
	TextDrawBackgroundColor(DeathBoxDraw, 255);
	TextDrawBoxColor(DeathBoxDraw, 50);
	TextDrawUseBox(DeathBoxDraw, 1);
	TextDrawSetProportional(DeathBoxDraw, 1);
	TextDrawSetSelectable(DeathBoxDraw, 0);
	DeathBoxGround[0]=DeathBoxDraw;
	DeathBoxDraw=Text:INVALID_TEXT_DRAW;

	DeathBoxDraw = TextDrawCreate(197.000000, 82.000000, "~n~");//tagbox
	TextDrawFont(DeathBoxDraw, 1);
	TextDrawLetterSize(DeathBoxDraw, 0.600000, 2.000000);
	TextDrawTextSize(DeathBoxDraw, 400.000000, 129.000000);
	TextDrawSetOutline(DeathBoxDraw, 3);
	TextDrawSetShadow(DeathBoxDraw, 0);
	TextDrawAlignment(DeathBoxDraw, 2);
	TextDrawColor(DeathBoxDraw, -1);
	TextDrawBackgroundColor(DeathBoxDraw, 255);
	TextDrawBoxColor(DeathBoxDraw, -156);
	TextDrawUseBox(DeathBoxDraw, 1);
	TextDrawSetProportional(DeathBoxDraw, 1);
	TextDrawSetSelectable(DeathBoxDraw, 0);
	DeathBoxGround[1]=DeathBoxDraw;
	DeathBoxDraw=Text:INVALID_TEXT_DRAW;

	DeathBoxDraw = TextDrawCreate(251.000000, 87.000000, "ld_beat:cross");//CLOSE
	TextDrawFont(DeathBoxDraw, 4);
	TextDrawLetterSize(DeathBoxDraw, 0.600000, 2.000000);
	TextDrawTextSize(DeathBoxDraw, 10.500000, 10.000000);
	TextDrawSetOutline(DeathBoxDraw, 1);
	TextDrawSetShadow(DeathBoxDraw, 0);
	TextDrawAlignment(DeathBoxDraw, 1);
	TextDrawColor(DeathBoxDraw, -1);
	TextDrawBackgroundColor(DeathBoxDraw, 255);
	TextDrawBoxColor(DeathBoxDraw, 50);
	TextDrawUseBox(DeathBoxDraw, 1);
	TextDrawSetProportional(DeathBoxDraw, 1);
	TextDrawSetSelectable(DeathBoxDraw, 1);
	DeathBoxGround[2]=DeathBoxDraw;
	DeathBoxDraw=Text:INVALID_TEXT_DRAW;
	/***********************************************************************/
	CompassPrive[0] = TextDrawCreate(316.000000, 4.000000, "~D~");//downarrow
	TextDrawFont(CompassPrive[0], 2);
	TextDrawLetterSize(CompassPrive[0], 0.220832, 1.099998);
	TextDrawTextSize(CompassPrive[0], 392.000000, 17.000000);
	TextDrawSetOutline(CompassPrive[0], 0);
	TextDrawSetShadow(CompassPrive[0], 0);
	TextDrawAlignment(CompassPrive[0], 2);
	TextDrawColor(CompassPrive[0], -1);
	TextDrawBackgroundColor(CompassPrive[0], 255);
	TextDrawBoxColor(CompassPrive[0], 50);
	TextDrawUseBox(CompassPrive[0], 0);
	TextDrawSetProportional(CompassPrive[0], 1);
	TextDrawSetSelectable(CompassPrive[0], 0);

	CompassPrive[1] = TextDrawCreate(320.000000, 16.000000, "~n~");//back
	TextDrawFont(CompassPrive[1], 1);
	TextDrawLetterSize(CompassPrive[1], 0.600000, 1.000000);
	TextDrawTextSize(CompassPrive[1], 400.000000, 271.000000);
	TextDrawSetOutline(CompassPrive[1], 1);
	TextDrawSetShadow(CompassPrive[1], 0);
	TextDrawAlignment(CompassPrive[1], 2);
	TextDrawColor(CompassPrive[1], -1);
	TextDrawBackgroundColor(CompassPrive[1], 255);
	TextDrawBoxColor(CompassPrive[1], 20);
	TextDrawUseBox(CompassPrive[1], 1);
	TextDrawSetProportional(CompassPrive[1], 1);
	TextDrawSetSelectable(CompassPrive[1], 0);
	
	/***********************************************************************/
	ConnectDraw[0] = TextDrawCreate(321.000000, 51.000000, "~n~");
	TextDrawFont(ConnectDraw[0], 0);
	TextDrawLetterSize(ConnectDraw[0], 0.600000, 3.499999);
	TextDrawTextSize(ConnectDraw[0], 400.000000, 572.000000);
	TextDrawSetOutline(ConnectDraw[0], 1);
	TextDrawSetShadow(ConnectDraw[0], 0);
	TextDrawAlignment(ConnectDraw[0], 2);
	TextDrawColor(ConnectDraw[0], -1);
	TextDrawBackgroundColor(ConnectDraw[0], -1);
	TextDrawBoxColor(ConnectDraw[0], -132);
	TextDrawUseBox(ConnectDraw[0], 1);
	TextDrawSetProportional(ConnectDraw[0], 1);
	TextDrawSetSelectable(ConnectDraw[0], 0);

	ConnectDraw[1] = TextDrawCreate(321.000000, 53.000000, "~n~");
	TextDrawFont(ConnectDraw[1], 0);
	TextDrawLetterSize(ConnectDraw[1], 0.600000, 3.049999);
	TextDrawTextSize(ConnectDraw[1], 400.000000, 568.500000);
	TextDrawSetOutline(ConnectDraw[1], 1);
	TextDrawSetShadow(ConnectDraw[1], 0);
	TextDrawAlignment(ConnectDraw[1], 2);
	TextDrawColor(ConnectDraw[1], -1);
	TextDrawBackgroundColor(ConnectDraw[1], -1);
	TextDrawBoxColor(ConnectDraw[1], -1523963153);
	TextDrawUseBox(ConnectDraw[1], 1);
	TextDrawSetProportional(ConnectDraw[1], 1);
	TextDrawSetSelectable(ConnectDraw[1], 0);

	ConnectDraw[2] = TextDrawCreate(57.000000, 55.000000, "PLAYERUNKNOWN");
	TextDrawFont(ConnectDraw[2], 2);
	TextDrawLetterSize(ConnectDraw[2], 0.520833, 2.399999);
	TextDrawTextSize(ConnectDraw[2], 755.000000, 17.000000);
	TextDrawSetOutline(ConnectDraw[2], 1);
	TextDrawSetShadow(ConnectDraw[2], 0);
	TextDrawAlignment(ConnectDraw[2], 1);
	TextDrawColor(ConnectDraw[2], -1);
	TextDrawBackgroundColor(ConnectDraw[2], 255);
	TextDrawBoxColor(ConnectDraw[2], 50);
	TextDrawUseBox(ConnectDraw[2], 0);
	TextDrawSetProportional(ConnectDraw[2], 1);
	TextDrawSetSelectable(ConnectDraw[2], 0);

	ConnectDraw[3] = TextDrawCreate(399.000000, 55.000000, "BATTLEGROUNDS");
	TextDrawFont(ConnectDraw[3], 2);
	TextDrawLetterSize(ConnectDraw[3], 0.520833, 2.399999);
	TextDrawTextSize(ConnectDraw[3], 755.000000, 17.000000);
	TextDrawSetOutline(ConnectDraw[3], 1);
	TextDrawSetShadow(ConnectDraw[3], 0);
	TextDrawAlignment(ConnectDraw[3], 1);
	TextDrawColor(ConnectDraw[3], -1);
	TextDrawBackgroundColor(ConnectDraw[3], 255);
	TextDrawBoxColor(ConnectDraw[3], 50);
	TextDrawUseBox(ConnectDraw[3], 0);
	TextDrawSetProportional(ConnectDraw[3], 1);
	TextDrawSetSelectable(ConnectDraw[3], 0);
	
	ConnectDraw[4] = TextDrawCreate(260.000000, 5.000000, "LD_DRV:gold");
	TextDrawFont(ConnectDraw[4], 4);
	TextDrawLetterSize(ConnectDraw[4], 0.600000, 12.499999);
	TextDrawTextSize(ConnectDraw[4], 115.500000, 125.000000);
	TextDrawSetOutline(ConnectDraw[4], 1);
	TextDrawSetShadow(ConnectDraw[4], 0);
	TextDrawAlignment(ConnectDraw[4], 2);
	TextDrawColor(ConnectDraw[4], -1);
	TextDrawBackgroundColor(ConnectDraw[4], 0);
	TextDrawBoxColor(ConnectDraw[4], 50);
	TextDrawUseBox(ConnectDraw[4], 1);
	TextDrawSetProportional(ConnectDraw[4], 1);
	TextDrawSetSelectable(ConnectDraw[4], 0);

	ConnectDraw[5] = TextDrawCreate(267.000000, 10.000000, "LD_PLAN:AirLogo");
	TextDrawFont(ConnectDraw[5], 5);
	TextDrawLetterSize(ConnectDraw[5], 0.600000, 12.499999);
	TextDrawTextSize(ConnectDraw[5], 132.000000, 122.500000);
	TextDrawSetOutline(ConnectDraw[5], 1);
	TextDrawSetShadow(ConnectDraw[5], 0);
	TextDrawAlignment(ConnectDraw[5], 2);
	TextDrawColor(ConnectDraw[5], -1);
	TextDrawBackgroundColor(ConnectDraw[5], 0);
	TextDrawBoxColor(ConnectDraw[5], 50);
	TextDrawUseBox(ConnectDraw[5], 1);
	TextDrawSetProportional(ConnectDraw[5], 1);
	TextDrawSetSelectable(ConnectDraw[5], 0);
	TextDrawSetPreviewModel(ConnectDraw[5], 489);
	TextDrawSetPreviewRot(ConnectDraw[5], -10.000000, 0.000000, -20.000000, 1.000000);
	TextDrawSetPreviewVehCol(ConnectDraw[5], 1, 1);

	ConnectDraw[6] = TextDrawCreate(272.000000, 3.000000, "Nowy_TextDraw");
	TextDrawFont(ConnectDraw[6], 5);
	TextDrawLetterSize(ConnectDraw[6], 0.600000, 2.000000);
	TextDrawTextSize(ConnectDraw[6], 79.000000, 75.500000);
	TextDrawSetOutline(ConnectDraw[6], 1);
	TextDrawSetShadow(ConnectDraw[6], 0);
	TextDrawAlignment(ConnectDraw[6], 1);
	TextDrawColor(ConnectDraw[6], -1);
	TextDrawBackgroundColor(ConnectDraw[6], 0);
	TextDrawBoxColor(ConnectDraw[6], 50);
	TextDrawUseBox(ConnectDraw[6], 1);
	TextDrawSetProportional(ConnectDraw[6], 1);
	TextDrawSetSelectable(ConnectDraw[6], 0);
	TextDrawSetPreviewModel(ConnectDraw[6], 355);
	TextDrawSetPreviewRot(ConnectDraw[6], -7.000000, -86.000000, 11.000000, 3.139997);
	TextDrawSetPreviewVehCol(ConnectDraw[6], 1, 1);
	
	ConnectDraw[7] = TextDrawCreate(303.000000, -4.000000, "Nowy_TextDraw");
	TextDrawFont(ConnectDraw[7], 5);
	TextDrawLetterSize(ConnectDraw[7], 0.600000, 2.000000);
	TextDrawTextSize(ConnectDraw[7], 79.000000, 75.500000);
	TextDrawSetOutline(ConnectDraw[7], 1);
	TextDrawSetShadow(ConnectDraw[7], 0);
	TextDrawAlignment(ConnectDraw[7], 1);
	TextDrawColor(ConnectDraw[7], -1);
	TextDrawBackgroundColor(ConnectDraw[7], 0);
	TextDrawBoxColor(ConnectDraw[7], 50);
	TextDrawUseBox(ConnectDraw[7], 1);
	TextDrawSetProportional(ConnectDraw[7], 1);
	TextDrawSetSelectable(ConnectDraw[7], 0);
	TextDrawSetPreviewModel(ConnectDraw[7], 356);
	TextDrawSetPreviewRot(ConnectDraw[7], -9.000000, -299.000000, 7.000000, 3.139997);
	TextDrawSetPreviewVehCol(ConnectDraw[7], 1, 1);
	
	ConnectDraw[8] = TextDrawCreate(253.000000, 7.000000, "Nowy_TextDraw");
	TextDrawFont(ConnectDraw[8], 5);
	TextDrawLetterSize(ConnectDraw[8], 0.600000, 2.000000);
	TextDrawTextSize(ConnectDraw[8], 104.000000, 117.500000);
	TextDrawSetOutline(ConnectDraw[8], 1);
	TextDrawSetShadow(ConnectDraw[8], 0);
	TextDrawAlignment(ConnectDraw[8], 1);
	TextDrawColor(ConnectDraw[8], -1);
	TextDrawBackgroundColor(ConnectDraw[8], 0);
	TextDrawBoxColor(ConnectDraw[8], 50);
	TextDrawUseBox(ConnectDraw[8], 1);
	TextDrawSetProportional(ConnectDraw[8], 1);
	TextDrawSetSelectable(ConnectDraw[8], 0);
	TextDrawSetPreviewModel(ConnectDraw[8], 299);
	TextDrawSetPreviewRot(ConnectDraw[8], -10.000000, 0.000000, -20.000000, 1.000000);
	TextDrawSetPreviewVehCol(ConnectDraw[8], 1, 1);

	ConnectDraw[9] = TextDrawCreate(278.000000, 4.000000, "Nowy_TextDraw");
	TextDrawFont(ConnectDraw[9], 5);
	TextDrawLetterSize(ConnectDraw[9], 0.600000, 2.000000);
	TextDrawTextSize(ConnectDraw[9], 107.000000, 124.500000);
	TextDrawSetOutline(ConnectDraw[9], 1);
	TextDrawSetShadow(ConnectDraw[9], 0);
	TextDrawAlignment(ConnectDraw[9], 1);
	TextDrawColor(ConnectDraw[9], -1);
	TextDrawBackgroundColor(ConnectDraw[9], 0);
	TextDrawBoxColor(ConnectDraw[9], 50);
	TextDrawUseBox(ConnectDraw[9], 1);
	TextDrawSetProportional(ConnectDraw[9], 1);
	TextDrawSetSelectable(ConnectDraw[9], 0);
	TextDrawSetPreviewModel(ConnectDraw[9], 90);
	TextDrawSetPreviewRot(ConnectDraw[9], -10.000000, 0.000000, -20.000000, 1.000000);
	TextDrawSetPreviewVehCol(ConnectDraw[9], 1, 1);
	
	ConnectDraw[10] = TextDrawCreate(319.000000, 130.000000, "~w~Present ~g~For ~y~San Andreas ~g~And ~b~Sa-mp");
	TextDrawFont(ConnectDraw[10], 0);
	TextDrawLetterSize(ConnectDraw[10], 0.345833, 1.750000);
	TextDrawTextSize(ConnectDraw[10], 550.500000, 217.000000);
	TextDrawSetOutline(ConnectDraw[10], 1);
	TextDrawSetShadow(ConnectDraw[10], 0);
	TextDrawAlignment(ConnectDraw[10], 2);
	TextDrawColor(ConnectDraw[10], -421070081);
	TextDrawBackgroundColor(ConnectDraw[10], 255);
	TextDrawBoxColor(ConnectDraw[10], 50);
	TextDrawUseBox(ConnectDraw[10], 0);
	TextDrawSetProportional(ConnectDraw[10], 1);
	TextDrawSetSelectable(ConnectDraw[10], 0);
	return 1;
}
N::ShowPlayerConnectDraw(playerid)
{
	forex(i,MAX_CONNECTDRAW)TextDrawShowForPlayer(playerid,ConnectDraw[i]);
    return 1;
}
N::HidePlayerConnectDraw(playerid)
{
	forex(i,MAX_CONNECTDRAW)TextDrawHideForPlayer(playerid,ConnectDraw[i]);
    return 1;
}
N::ShowPlayerWaitRoomPrive(playerid,type)
{
	forex(i,MAX_WAITROOM_DRAWS)TextDrawShowForPlayer(playerid,WaitRoomPrive[i]);
	TextDrawShowForPlayer(playerid,WaitRoomAmoutPrive[type]);
	TextDrawShowForPlayer(playerid,WaitRoomCountdownPrive[type]);
    return 1;
}
N::HidePlayerWaitRoomPrive(playerid)
{
	forex(i,MAX_WAITROOM_DRAWS)TextDrawHideForPlayer(playerid,WaitRoomPrive[i]);
	forex(i,MAX_WAITROOM_TYPES)
	{
		TextDrawHideForPlayer(playerid,WaitRoomAmoutPrive[i]);
		TextDrawHideForPlayer(playerid,WaitRoomCountdownPrive[i]);
	}
    return 1;
}
N::UpdateRoomAmoutDraw(type,amout)
{
    fLine_32("%i",amout);
	TextDrawSetString(WaitRoomAmoutPrive[type],line);
    return 1;
}
N::UpdateRoomCountDownDraw(type,string[])
{
    TextDrawSetString(WaitRoomCountdownPrive[type],string);
    return 1;
}
stock Text:CreateWaitRoomAmoutDraw()
{
    new Text:GameDraw=Text:INVALID_TEXT_DRAW;
	GameDraw = TextDrawCreate(556.000000, 2.000000, "0");
	TextDrawFont(GameDraw, 2);
	TextDrawLetterSize(GameDraw, 0.379166, 2.000000);
	TextDrawTextSize(GameDraw, 400.000000, 17.000000);
	TextDrawSetOutline(GameDraw, 0);
	TextDrawSetShadow(GameDraw, 0);
	TextDrawAlignment(GameDraw, 2);
	TextDrawColor(GameDraw, -1);
	TextDrawBackgroundColor(GameDraw, 255);
	TextDrawBoxColor(GameDraw, 50);
	TextDrawUseBox(GameDraw, 0);
	TextDrawSetProportional(GameDraw, 1);
	TextDrawSetSelectable(GameDraw, 0);
	return Text:GameDraw;
}
stock Text:CreateWaitRoomCountDownDraw()
{
    new Text:GameDraw=Text:INVALID_TEXT_DRAW;
	GameDraw = TextDrawCreate(320.000000, 72.000000, "00:00");
	TextDrawFont(GameDraw, 2);
	TextDrawLetterSize(GameDraw, 0.708333, 4.249993);
	TextDrawTextSize(GameDraw, 400.000000, 17.000000);
	TextDrawSetOutline(GameDraw, 1);
	TextDrawSetShadow(GameDraw, 0);
	TextDrawAlignment(GameDraw, 2);
	TextDrawColor(GameDraw, -1);
	TextDrawBackgroundColor(GameDraw, 255);
	TextDrawBoxColor(GameDraw, 50);
	TextDrawUseBox(GameDraw, 0);
	TextDrawSetProportional(GameDraw, 1);
	TextDrawSetSelectable(GameDraw, 0);
	return GameDraw;
}
/**************************************************************************/
N::ShowPlayerFlyMapBackGround(playerid)
{
	forex(i,MAX_FLAYBACKGROUND_DRAW)TextDrawShowForPlayer(playerid,FlyMap_BackGround[i]);
    return 1;
}
N::HidePlayerFlyMapBackGround(playerid)
{
	forex(i,MAX_FLAYBACKGROUND_DRAW)TextDrawHideForPlayer(playerid,FlyMap_BackGround[i]);
    return 1;
}
/**********************************************************************/
N::ShowPlayerTimeLineBackGround(playerid)
{
	forex(i,MAX_TIME_LINE_BACKGROUND)TextDrawShowForPlayer(playerid,Time_Line_BackGround[i]);
    return 1;
}
N::HidePlayerTimeLineBackGround(playerid)
{
	forex(i,MAX_TIME_LINE_BACKGROUND)TextDrawHideForPlayer(playerid,Time_Line_BackGround[i]);
    return 1;
}
/**********************************************************************/
N::ShowPlayerGameOverBackGroud(playerid)
{
	forex(i,MAX_GAMEOVER_DRAWS)TextDrawShowForPlayer(playerid,GameOverPrive[i]);
	return 1;
}
N::HidePlayerGameOverBackGroud(playerid)
{
    forex(i,MAX_GAMEOVER_DRAWS)TextDrawHideForPlayer(playerid,GameOverPrive[i]);
    CancelSelectTextDraw(playerid);
	return 1;
}
/**********************************************************************/
N::ShowPlayerSmallMapBackGround(playerid)
{
	forex(i,MAX_SMALLMAP_DRAW)TextDrawShowForPlayer(playerid,SmallMapBackGround[i]);
    return 1;
}
N::HidePlayerSmallMapBackGround(playerid)
{
	forex(i,MAX_SMALLMAP_DRAW)TextDrawHideForPlayer(playerid,SmallMapBackGround[i]);
    return 1;
}

N::ShowInventoryBackGroundPrevie(playerid)
{
	forex(i,MAX_INVENROYBACKGROUND_DRAW)TextDrawShowForPlayer(playerid,InventoryBackGroundDraw[i]);
	return 1;
}
N::HideInventoryBackGroundPrevie(playerid)
{
	forex(i,MAX_INVENROYBACKGROUND_DRAW)TextDrawHideForPlayer(playerid,InventoryBackGroundDraw[i]);
	return 1;
}
//****************************************************************************************/
N::CreatePlayerInvItemBottonDo(playerid,index)
{
	InventoryUseItemBotton[playerid] = CreatePlayerTextDraw(playerid, 234.000000, 79.000000+index*43+3, "LD_CHAT:thumbup");
	PlayerTextDrawFont(playerid, InventoryUseItemBotton[playerid], 4);
	PlayerTextDrawLetterSize(playerid, InventoryUseItemBotton[playerid], 0.391665, 1.649999);
	PlayerTextDrawTextSize(playerid, InventoryUseItemBotton[playerid], 18.000000, 13.900000);
	PlayerTextDrawSetOutline(playerid, InventoryUseItemBotton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, InventoryUseItemBotton[playerid], 0);
	PlayerTextDrawAlignment(playerid, InventoryUseItemBotton[playerid], 1);
	PlayerTextDrawColor(playerid, InventoryUseItemBotton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InventoryUseItemBotton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, InventoryUseItemBotton[playerid], 65380);
	PlayerTextDrawUseBox(playerid, InventoryUseItemBotton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InventoryUseItemBotton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, InventoryUseItemBotton[playerid], 1);
	PlayerTextDrawShow(playerid,InventoryUseItemBotton[playerid]);

	InventoryDropItemBotton[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 79.000000+index*43+3, "LD_CHAT:thumbdn");
	PlayerTextDrawFont(playerid, InventoryDropItemBotton[playerid], 4);
	PlayerTextDrawLetterSize(playerid, InventoryDropItemBotton[playerid], 0.391665, 1.649999);
	PlayerTextDrawTextSize(playerid, InventoryDropItemBotton[playerid], 18.000000, 13.900000);
	PlayerTextDrawSetOutline(playerid, InventoryDropItemBotton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, InventoryDropItemBotton[playerid], 0);
	PlayerTextDrawAlignment(playerid, InventoryDropItemBotton[playerid], 1);
	PlayerTextDrawColor(playerid, InventoryDropItemBotton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InventoryDropItemBotton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, InventoryDropItemBotton[playerid], 65380);
	PlayerTextDrawUseBox(playerid, InventoryDropItemBotton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InventoryDropItemBotton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, InventoryDropItemBotton[playerid], 1);
	PlayerTextDrawShow(playerid,InventoryDropItemBotton[playerid]);
    return 1;
}
N::DestoryPlayerInvItemBottonDo(playerid)
{
	if(InventoryUseItemBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryUseItemBotton[playerid]);
	InventoryUseItemBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(InventoryDropItemBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryDropItemBotton[playerid]);
	InventoryDropItemBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::ClearPlayerInvClickState(playerid)
{
	if(InventoryClickID[playerid]!=NONE)
	{
		PlayerTextDrawBackgroundColor(playerid, InventoryBackGround[playerid][InventoryClickID[playerid]], 255);
		PlayerTextDrawBoxColor(playerid, InventoryBackGround[playerid][InventoryClickID[playerid]], 50);
        PlayerTextDrawShow(playerid,InventoryBackGround[playerid][InventoryClickID[playerid]]);
	}
	InventoryClickID[playerid]=NONE;
	return 1;
}
N::ClearPlayerNearByClickState(playerid)
{
	if(NearByClickID[playerid]!=NONE)
	{
		PlayerTextDrawBackgroundColor(playerid, NearByBackGround[playerid][NearByClickID[playerid]], 255);
		PlayerTextDrawBoxColor(playerid, NearByBackGround[playerid][NearByClickID[playerid]], 50);
        PlayerTextDrawShow(playerid,NearByBackGround[playerid][NearByClickID[playerid]]);
	}
	NearByClickID[playerid]=NONE;
	return 1;
}
/****************************************************************/
N::DestoryPlayerGameOverPrive(playerid,bool:disconnect)
{
    if(disconnect==true)StopDalayLeaveLastAliveGame(playerid);
	if(pGameOverChicken[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverChicken[playerid]);
	if(pGameOverTeamRank[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverTeamRank[playerid]);
	if(pGameOverKills[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverKills[playerid]);
	if(pGameOverNumber[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverNumber[playerid]);
	if(pGameOverReward[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverReward[playerid]);
	if(pGameOverTimeLeft[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pGameOverTimeLeft[playerid]);
	pGameOverChicken[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pGameOverTeamRank[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pGameOverKills[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pGameOverNumber[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pGameOverReward[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pGameOverTimeLeft[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::ShowPlayerGameOverPrive(playerid,Body[],Rank,Kills,Number,Players,Reward,TimeLeft)
{
    DestoryPlayerGameOverPrive(playerid,false);
    new line[128];
    format(line,sizeof(line),Body);
	pGameOverChicken[playerid] = CreatePlayerTextDraw(playerid, 34.000000, 46.000000,line);
	PlayerTextDrawFont(playerid, pGameOverChicken[playerid], 1);
	PlayerTextDrawLetterSize(playerid, pGameOverChicken[playerid], 0.479166, 5.349997);
	PlayerTextDrawTextSize(playerid, pGameOverChicken[playerid], 400.000000, 38.500000);
	PlayerTextDrawSetOutline(playerid, pGameOverChicken[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverChicken[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverChicken[playerid], 1);
	PlayerTextDrawColor(playerid, pGameOverChicken[playerid], 16711935);
	PlayerTextDrawBackgroundColor(playerid, pGameOverChicken[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverChicken[playerid], -65486);
	PlayerTextDrawUseBox(playerid, pGameOverChicken[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverChicken[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverChicken[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverChicken[playerid]);

    format(line,sizeof(line),"TEAM_RANK__%i",Rank);
	pGameOverTeamRank[playerid] = CreatePlayerTextDraw(playerid, 32.000000, 138.000000, line);
	PlayerTextDrawFont(playerid, pGameOverTeamRank[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pGameOverTeamRank[playerid], 0.612500, 2.949999);
	PlayerTextDrawTextSize(playerid, pGameOverTeamRank[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pGameOverTeamRank[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverTeamRank[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverTeamRank[playerid], 1);
	PlayerTextDrawColor(playerid, pGameOverTeamRank[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pGameOverTeamRank[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverTeamRank[playerid], 50);
	PlayerTextDrawUseBox(playerid, pGameOverTeamRank[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverTeamRank[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverTeamRank[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverTeamRank[playerid]);

    format(line,sizeof(line),"KILL_%i_PLAYERS",Kills);
	pGameOverKills[playerid] = CreatePlayerTextDraw(playerid, 249.000000, 138.000000, line);
	PlayerTextDrawFont(playerid, pGameOverKills[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pGameOverKills[playerid], 0.612500, 2.949999);
	PlayerTextDrawTextSize(playerid, pGameOverKills[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pGameOverKills[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverKills[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverKills[playerid], 1);
	PlayerTextDrawColor(playerid, pGameOverKills[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pGameOverKills[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverKills[playerid], 50);
	PlayerTextDrawUseBox(playerid, pGameOverKills[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverKills[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverKills[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverKills[playerid]);

    format(line,sizeof(line),"NO.%i/%i",Number,Players);
	pGameOverNumber[playerid] = CreatePlayerTextDraw(playerid, 563.000000, 22.000000, line);
	PlayerTextDrawFont(playerid, pGameOverNumber[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pGameOverNumber[playerid], 0.620832, 4.549993);
	PlayerTextDrawTextSize(playerid, pGameOverNumber[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pGameOverNumber[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverNumber[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverNumber[playerid], 2);
	PlayerTextDrawColor(playerid, pGameOverNumber[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pGameOverNumber[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverNumber[playerid], 50);
	PlayerTextDrawUseBox(playerid, pGameOverNumber[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverNumber[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverNumber[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverNumber[playerid]);

	format(line,sizeof(line),"%i",Reward);
	pGameOverReward[playerid] = CreatePlayerTextDraw(playerid, 170.000000, 224.000000, line);
	PlayerTextDrawFont(playerid, pGameOverReward[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pGameOverReward[playerid], 0.508333, 2.349997);
	PlayerTextDrawTextSize(playerid, pGameOverReward[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pGameOverReward[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverReward[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverReward[playerid], 1);
	PlayerTextDrawColor(playerid, pGameOverReward[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pGameOverReward[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverReward[playerid], 50);
	PlayerTextDrawUseBox(playerid, pGameOverReward[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverReward[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverReward[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverReward[playerid]);
	
	format(line,sizeof(line),"%is",TimeLeft);
	pGameOverTimeLeft[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 422.000000, line);
	PlayerTextDrawFont(playerid, pGameOverTimeLeft[playerid], 2);
	PlayerTextDrawLetterSize(playerid, pGameOverTimeLeft[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, pGameOverTimeLeft[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pGameOverTimeLeft[playerid], 1);
	PlayerTextDrawSetShadow(playerid, pGameOverTimeLeft[playerid], 0);
	PlayerTextDrawAlignment(playerid, pGameOverTimeLeft[playerid], 2);
	PlayerTextDrawColor(playerid, pGameOverTimeLeft[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, pGameOverTimeLeft[playerid], 255);
	PlayerTextDrawBoxColor(playerid, pGameOverTimeLeft[playerid], 50);
	PlayerTextDrawUseBox(playerid, pGameOverTimeLeft[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pGameOverTimeLeft[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, pGameOverTimeLeft[playerid], 0);
	PlayerTextDrawShow(playerid,pGameOverTimeLeft[playerid]);
	return 1;
}

N::RestPlayerDamagePrive(playerid)
{
	if(Timer:PlayerDamageTimer[playerid]!=NONE)KillTimer(Timer:PlayerDamageTimer[playerid]);
	Timer:PlayerDamageTimer[playerid]=NONE;
	if(PlayerDamageDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerDamageDraw[playerid]);
    PlayerDamageDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerDamageAmout[playerid]=0;
}
N::ShowPlayerDamagePrive(playerid,amout)
{
	RestPlayerDamagePrive(playerid);
	PlayerDamageAmout[playerid]=amout;
    PlayerDamageDraw[playerid] = CreatePlayerTextDraw(playerid, 318.000000, -2.000000, "~n~");
	PlayerTextDrawFont(playerid, PlayerDamageDraw[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlayerDamageDraw[playerid], 0.600000, 50.549991);
	PlayerTextDrawTextSize(playerid, PlayerDamageDraw[playerid], 400.000000, 655.000000);
	PlayerTextDrawSetOutline(playerid, PlayerDamageDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PlayerDamageDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerDamageDraw[playerid], 2);
	PlayerTextDrawColor(playerid, PlayerDamageDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerDamageDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PlayerDamageDraw[playerid], -16777216+PlayerDamageAmout[playerid]);
	PlayerTextDrawUseBox(playerid, PlayerDamageDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerDamageDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerDamageDraw[playerid], 0);
	PlayerTextDrawShow(playerid, PlayerDamageDraw[playerid]);
	new speeds=floatround(floatdiv(1000.0,amout));
	Timer:PlayerDamageTimer[playerid]=SetTimerEx("UpdatePlayerDamagePrive",speeds, true, "i", playerid);
	return 1;
}
