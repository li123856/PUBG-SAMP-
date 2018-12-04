#define NONTOX_MOVE_SPEED 	15.0
#define START_SATE_MOVE 	300.0
#define SATE_MOVE_SPEED 	0.5
#define MAX_GAME_PERCENT 	0.75
#define SHOW_ZONE_TIME 		50
new GameTickCount;
N::GameMain_OnPlayerSpawn(playerid)
{
	if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
	{
	    //printf("GameMain_OnPlayerSpawn0 %s",Account[playerid][_Name]);
		if(pLastAlive[playerid][_Game_PlaneDown]==true)
		{
		    //printf("GameMain_OnPlayerSpawn1 %s",Account[playerid][_Name]);
			pLastAlive[playerid][_Game_PlaneDown]=false;
			SetPlayerVirtualWorld(playerid,GameRoom(pGameID(playerid)));
			SetPlayerInterior(playerid,0);
			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_GAME_IN_TIP3));
			return true;
		}
	}
	return false;
}
N::GameMain@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerInState[playerid]==PLAYER_IN_WAITROOM&&PlayerInStateID[playerid]>0)
    {
  		if(PRESSED(KEY_CTRL_BACK))
		{
		    if(Iter_Contains(WaitRoom,PlayerInStateID[playerid]))
			{
		        if(WaitRoom[PlayerInStateID[playerid]][_Open]==false)
		        {
		            if(WaitRoom[PlayerInStateID[playerid]][_Owner]==Account[playerid][_Key])
		        	{
		        	    if(GetWaitPlayerAmouts(PlayerInStateID[playerid])>=2)
		        	    {
					    	Dialog@Show(playerid,_PRESON_ROOM_START,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG5),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG6),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG7),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG8));
						}
						else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG19));
					}
				}
			}
		}
    }
	if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
	{
		if(PRESSED(KEY_YES))
		{
			HideUserInvPanel(playerid,false);
			ShowUserInvPanel(playerid,false);
			SelectTextDraw(playerid, 0xFF4040AA);
			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_GAME_CLOSE_BAG));
		}
		if(PRESSED(KEY_NO))
		{
		    if(pLastAlive[playerid][_Game_SpectatePlane]==false)
		    {
				if(pLastAlive[playerid][_Show_SmallMap]==true)HidePlayerSmallMap(playerid);
				else
				{
					ShowPlayerSmallMap(playerid);
					SCM(playerid,-1,ReturnMLStr(pLang(playerid),_GAME_CLOSE_MAP));
                }
			}
		}
		if(PRESSED(KEY_SECONDARY_ATTACK))
		{
			if(pLastAlive[playerid][_Game_SpectatePlane]==true&&LastAliveGame[pGameID(playerid)][_TimeLine]>2)
			{
				pLastAlive[playerid][_Game_SpectatePlane]=false;
                pLastAlive[playerid][_Game_PlaneDown]=true;
                GetPlayerPos(playerid,pLastAlive[playerid][_Game_PlaneDown_Pos][0],pLastAlive[playerid][_Game_PlaneDown_Pos][1],pLastAlive[playerid][_Game_PlaneDown_Pos][2]);
                GetVehicleZAngle(LastAliveGame[pGameID(playerid)][_Plane_ID],pLastAlive[playerid][_Game_PlaneDown_Pos][3]);
				SetSpawnInfo(playerid,NO_TEAM,Account[playerid][_Skin],pLastAlive[playerid][_Game_PlaneDown_Pos][0],pLastAlive[playerid][_Game_PlaneDown_Pos][1],pLastAlive[playerid][_Game_PlaneDown_Pos][2],pLastAlive[playerid][_Game_PlaneDown_Pos][3],46,99999,0,0,0,0);
                TogglePlayerSpectating(playerid,0);
                HidePlayerFlyMapBackGround(playerid);
                if(LastAliveGame[pGameID(playerid)][_Plane_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Plane_Draw]);
                SendJumpPlaneMsg(playerid,pGameID(playerid),-1,_AIR_DROP);
               	ShowPlayerHitList(playerid);//伤害显示
			}
		}
		if(PRESSED(KEY_CROUCH))
		{
			if(!IsPlayerInAnyDynamicVehicle(playerid))
			{
			    if(GetPlayerInDeathBoxAreaID(playerid)!=NONE)SelectTextDraw(playerid, 0xFF4040AA);
			}
		}
		if(PRESSED(KEY_WALK))
		{
			if(!IsPlayerInAnyDynamicVehicle(playerid))
			{
				if(Iter_Count(PickItem[pGameID(playerid)])>0)
				{
				    new gameid=pGameID(playerid);
				    foreach(new i:PickItem[gameid])
				    {
			            if(IsPlayerInRangeOfPoint(playerid,5.0,PickItem[gameid][i][_x],PickItem[gameid][i][_y],PickItem[gameid][i][_z]))
			            {
				        	new ItemID=PickItem[gameid][i][_ItemID];
				        	switch(Item[ItemID][_Type])
				        	{
				        	    case ITEM_AMMO:
								{
									if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[pGameID(playerid)][i][_Amout],PickItem[gameid][i][_Ammo],0.0)==INVENTORY_FULL)
									{
									    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
									    return 1;
				  					}
			                    }
								case ITEM_HELMET,ITEM_ARMOUR:
								{
									if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[gameid][i][_Amout],0,PickItem[gameid][i][_Durable])==INVENTORY_FULL)
									{
									    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
									    return 1;
				  					}
			                    }
								default:
								{
									if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[gameid][i][_Amout],0,0.0)==INVENTORY_FULL)
									{
									    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
									    return 1;
				  					}
			                    }
							}
							if(PickItem[gameid][i][_From]!=NONE)
							{
							    LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][i][_From]]--;
								if(LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][i][_From]]<=0)
								{
								    if(LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][i][_From]]!=INVALID_STREAMER_ID)
								    {
								    	DestroyDynamicMapIcon(LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][i][_From]]);
								    	LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][i][_From]]=INVALID_STREAMER_ID;
								    }
								    LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][i][_From]]=0;
								}
							}
					        DestroyDynamicObject(PickItem[gameid][i][_Obj]);
					        DestroyDynamic3DTextLabel(PickItem[gameid][i][_Text]);
					        DestroyDynamicArea(PickItem[gameid][i][_Area]);
					        PickItem[gameid][i][_Obj]=INVALID_STREAMER_ID;
					        PickItem[gameid][i][_Text]=Text3D:INVALID_STREAMER_ID;
					        PickItem[gameid][i][_Area]=INVALID_STREAMER_ID;
			    			new	cur = i;
			   				Iter_SafeRemove(PickItem[gameid],cur,i);
			            }
   					}
   				}
			}
		}
		if(HOLDING(128))
		{
	        new weaponid=GetPlayerWeapon(playerid);
			if(IsBulletWeapon(weaponid)||weaponid==WEAPON_CAMERA)
			{
				HideAttach[playerid]=true;
	            RestPlayerAttach(playerid,true);
			}
		}
		if(RELEASED(128))
		{
			if(HideAttach[playerid]==true)
			{
			    HideAttach[playerid]=false;
			    GivePlayerAttach(playerid);
			    new weaponid=GetPlayerWeapon(playerid);
			    GamePlayerGunAttach(playerid,weaponid);
			    RestBodyDressAttach(playerid);
			}
		}
	}
	return 1;
}
N::GameUpdateSecond()
{
	foreach(new i:LastAliveGame)
	{   
	    if(LastAliveGame[i][_Ready]==true)
	    {
	        switch(LastAliveGame[i][_State])
	        {
	            case LASTALIVE_STATE_START:
	            {
				    if(LastAliveGame[i][_Plane_Flying]==true)
				    {
						if(LastAliveGame[i][_Plane_Draw]!=Text:INVALID_TEXT_DRAW)
						{
						    foreach(new s:Player)
						    {
							    if(Online(s))
							    {
							        if(pGameID(s)==i)
							        {
						        		if(pLastAlive[s][_Game_SpectatePlane]==true)TextDrawHideForPlayer(s,LastAliveGame[i][_Plane_Draw]);
						            }
								}
						    }
				    		TextDrawDestroy(LastAliveGame[i][_Plane_Draw]);
				    		LastAliveGame[i][_Plane_Draw]=Text:INVALID_TEXT_DRAW;
						}
			    		new Float:xyz[3];
			    		FCNPC_GetPosition(LastAliveGame[i][_Npc_Driver_ID],xyz[0],xyz[1],xyz[2]);
			   			new Float:MapX=floatadd(103.0,floatdiv(floatsub(xyz[0],0.0),27.3972602739726));
						new Float:MapY=floatsub(328.0,floatdiv(floatsub(xyz[1],0.0),27.3972602739726));
						LastAliveGame[i][_Plane_Draw]=CreateGamePlaneDraw(MapX,MapY);
					    foreach(new s:Player)
					    {
						    if(Online(s))
						    {
						        if(pGameID(s)==i)
						        {
						            if(pLastAlive[s][_Game_SpectatePlane]==true)TextDrawShowForPlayer(s,LastAliveGame[i][_Plane_Draw]);
					            }
							}
					    }
				    }
					foreach(new s:gVehicle[i])
					{
					    if(gVehicle[i][s][_VehicleEngine]==true)
					    {
						    if(gVehicle[i][s][_VehicleFuel]>0.0)
						    {
						        gVehicle[i][s][_VehicleFuel]=floatsub(gVehicle[i][s][_VehicleFuel],0.0833333333333333);
						        if(gVehicle[i][s][_VehicleFuel]<0.0)gVehicle[i][s][_VehicleFuel]=0.0;
						    }
						    else
						    {
						        gVehicle[i][s][_VehicleEngine]=false;
						        SetDynamicVehicleParamsEx(gVehicle[i][s][_VehicleID],0,0,0,0,0,0,0);
						    }
						}
					}
	                if(LastAliveGame[i][_TimeLine]>=LastAliveGame[i][_Weather_Count])
	                {
	                    LastAliveGame[i][_Weather_ID]=random(21);
	                    SetLastAliveGameWeather(i,LastAliveGame[i][_Weather_ID]);
	                    SendLastAliveGameMsg(i,-1,_GAME_WEATHER_MSG);
	                    LastAliveGame[i][_Weather_Count]=LastAliveGame[i][_TimeLine]+Randoms(180, 600);
	                }
	                if(LastAliveGame[i][_TimeLine]>=LastAliveGame[i][_AirBox_Count])
	                {
	                    printf("_AirBox_Count1");
	                    PlayGameAudioStream(i,MUSIC_GAMEBOX);
						if(CreatRandAirDropBox(i))SendLastAliveGameMsg(i,-1,_GAME_BOX_MSG);
						printf("_AirBox_Count2");
	                    LastAliveGame[i][_AirBox_Count]=LastAliveGame[i][_TimeLine]+Randoms(120, 600);
	                }
	                if(LastAliveGame[i][_TimeLine]==SHOW_ZONE_TIME)
	                {
	                    PlayGameAudioStream(i,MUSIC_GAMEZONE);
	                    ChangeToxicCircle(i,0*NONTOX_MOVE_SPEED);
				     	ChangeSafeCircle(i,0*START_SATE_MOVE);
				     	SendLastAliveGameMsg(i,-1,_GAME_CIRCLE_0);
	                }
					LastAliveGame[i][_TimeLine]++;
					if(GetGameAlivePlayerAmouts(i)<=1)
					{
					    printf("房间 %i 结束 无人");
						CloseLastAliveGame(i);
						new	cur = i;
						Iter_SafeRemove(LastAliveGame,cur,i);
						return 1;
					}
					//printf("SafeZoneSize %f",GetSafeZoneSize(i));
					/*if(GetSafeZoneSize(i)<0.1)
					{
					    printf("房间 %i 结束 安全区过小");
						CloseLastAliveGame(i);
						new	cur = i;
						Iter_SafeRemove(LastAliveGame,cur,i);
						return 1;
					}*/
	            }
	        }
		}
	}
	return 1;
}
N::PlayGameAudioStream(gameid,music[])
{
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid)
			{
			    if(pMusic[i][_Playing]==false)PlayAudioStreamForPlayer(i,music);
            }
        }
	}
	return 1;
}
N::WaitRoomUpdateSecond()
{
    new NeedAmout=1;
	foreach(new i:WaitRoom)
	{
	    new PlayerAmout=GetWaitPlayerAmouts(i);
		/*if(i==0)NeedAmout=5;
	    else NeedAmout=1;*/
	    UpdateRoomAmoutDraw(i,GetWaitPlayerAmouts(i));
	    if(WaitRoom[i][_Open]==true)
	    {
			if(PlayerAmout>NeedAmout)
			{
			    WaitRoom[i][_Countdown]--;
			    if(WaitRoom[i][_Countdown]<=0)
			    {
					if(CreateLastAliveGame(i))
					{
					    if(i!=0)
					    {
							new	cur = i;
	 						Iter_SafeRemove(WaitRoom,cur,i);
	 						printf("阶段9  %i ms",GetTickCount()-GameTickCount);
 						}
					}
					else
					{
					    WaitRoom[i][_Countdown]=MAX_WAIT_TIME;
					    UpdateRoomCountDownDraw(i,ReturnCountDownStr(WaitRoom[i][_Countdown]));
					    ShowWaitPlayerGameText(i,false);
					}
			    }
				else
				{
				    UpdateRoomCountDownDraw(i,ReturnCountDownStr(WaitRoom[i][_Countdown]));
				    if(WaitRoom[i][_Countdown]<10)ShowWaitPlayerGameText(i,true);
				    else ShowWaitPlayerGameText(i,false);
				}
			}
			else
			{
			    if(i==0)WaitRoom[i][_Countdown]=MAX_WAIT_TIME;
			    else
			    {
			        WaitRoom[i][_Open]=false;
			        WaitRoom[i][_Countdown]=0;
			    }
			    UpdateRoomCountDownDraw(i,ReturnCountDownStr(WaitRoom[i][_Countdown]));
			    ShowWaitPlayerGameText(i,false);
			}
		}
		WaitRoom[i][_WeatherCount]++;
		if(WaitRoom[i][_WeatherCount]>=WaitRoom[i][_WeatherChange])
		{
		    WaitRoom[i][_Weather]=random(21);
			SetWaitRoomGameWeather(i,WaitRoom[i][_Weather]);
			WaitRoom[i][_WeatherCount]=0;
			WaitRoom[i][_WeatherChange]=Randoms(180,480);
			SendWaitRoomGameMsg(i,-1,_GAME_WEATHER_MSG);
		}
	}
	return 1;
}
N::ShowWaitPlayerGameText(Type,bool:sound)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(PlayerInState[i]==PLAYER_IN_WAITROOM)
			{
			    if(PlayerInStateID[i]==Type)
			    {
					if(sound==true)PlayerPlaySound(i,1056,0.0,0.0,0.0);
					//TextDrawShowForPlayer(i,WaitRoomCountdownPrive[Type]);
			    }
			}
		}
	}
	return 1;
}

N::SetPlayerToWaitRoom(playerid,Type)
{
    Dialog@Close(playerid);
    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
    PlayerInState[playerid]=PLAYER_IN_WAITROOM;
    PlayerInStateID[playerid]=Type;
    PauseTime[playerid]=0;
    HidePlayerFaceMenu(playerid);
    CloseGiftBox(playerid);
    StopPlayerRotCamera(playerid,false,true);
    TogglePlayerControllable(playerid,1);
    CreatePlayerCompass(playerid);
    new Float:Tpos[3];
    GetRandomPointInCircle(-2392.1558,-2204.7432,6.0,Tpos[0],Tpos[1]);
    Tryg3D::MapAndreasFindZ(Tpos[0],Tpos[1],Tpos[2]);
    SetPlayerPos(playerid,Tpos[0],Tpos[1],Tpos[2]+0.5);
    WaitForStreamObjectLoadFinish(playerid,3000);
    SetPlayerInterior(playerid,0);
   	SetPlayerVirtualWorld(playerid,GameWaitRoom(Type));
	SetPlayerWeather(playerid,WaitRoom[Type][_Weather]);
   	SetPlayerHealth(playerid,10000);
   	ShowPlayerWaitRoomPrive(playerid,Type);
	if(Type==0)SCM(playerid,-1,ReturnMLStr(pLang(playerid),_WAITROOM_MSG));
	else
	{
		if(WaitRoom[Type][_Owner]==Account[playerid][_Key])SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG10));
		else
		{
	      	fLine_128(ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG9),Select@GetPlayerNameByKey(WaitRoom[Type][_Owner]));
	       	SCM(playerid,-1,line);
		}
	}
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG3));
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG2));
	SetPlayerWorldBounds(playerid,0.0,-2950.0,0.0,-2950.0);
	if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_WAIT);
	return 1;
}
N::SetPlayerToLastAliveGame(playerid,gameid)
{
    Dialog@Close(playerid);
    CancelSelectTextDraw(playerid);
    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
    //DestoryWaitRoom(playerid);
    ResetPlayerWeapons(playerid);
    HidePlayerWaitRoomPrive(playerid);
    pGameID(playerid)=gameid;
    PlayerInState[playerid]=PLAYER_IN_GAMEROOM;
    PlayerInStateID[playerid]=gameid;
    pLastAlive[playerid][_Game_In]=true;
    pLastAlive[playerid][_Game_Death]=false;
    pLastAlive[playerid][_Game_SpectatePlane]=false;
    pLastAlive[playerid][_Game_PlaneDown]=false;
    pLastAlive[playerid][_Game_Kills]=0;
    pLastAlive[playerid][_Game_Deaths]=0;
    pLastAlive[playerid][_Show_SmallMap]=false;
	LastTimeWeapon[playerid]=0;
 	forex(s,12)LastTimeAmmo[playerid][s]=0;
  	pBuffID[playerid]=NONE;
	pBuffCount[playerid]=0;
	pCacheID[playerid]=NONE;
	pCacheCount[playerid]=0;
	PauseTime[playerid]=0;
	
    SetPlayerGunSkill(playerid);
	SetPlayerVirtualWorld(playerid,GameRoom(gameid));
	SetPlayerInterior(playerid,0);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerWeather(playerid,LastAliveGame[gameid][_Weather_ID]);

    CreatePlayerRaderDraw(playerid);//显示地域
    ShowPlayerGameScorePanel(playerid);//显示积分框
    ShowPlayerGameAlive(playerid);//显示生存栏
    CreatePlayerGameKillDraw(playerid);//玩家杀人数DRAW
    ShowPlayerGameKillDraw(playerid);//显示击杀栏
    UpdatePlayerGameKillDraw(playerid,pLastAlive[playerid][_Game_Kills]);//更新击杀栏
    UpdateGameAliveDraw(pGameID(playerid),GetGameAlivePlayerAmouts(pGameID(playerid)));//更新生存栏
	ShowPlayerValuePanelPrevie(playerid);//显示血量 武器 护甲栏
	ShowPlayerTimeLineBackGround(playerid);//显示时间轴背景
	DestoryPlayerTempCar(playerid,false);
 	DsetoryPlayerTempCarSelectGui(playerid);
	//ShowPlayerTimeLineTime(playerid);//显示时间轴时间
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_GAME_IN_TIP1));
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_GAME_IN_TIP2));
	//Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerNameTag[playerid],E_STREAMER_DRAW_DISTANCE,0.0);
    RestPlayerAttach(playerid,false);
    HandlePlayerSignature(playerid,false);
	if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_GAMESTART);
	return 1;
}
N::SetPlayerLeaveLastAliveGame(playerid,bool:disconnect,bool:showrank)
{
	if(pGameID(playerid)!=NONE)
	{
	    ResetPlayerWeapons(playerid);
	    RemovePlayerFromVehicle(playerid);
		RestPlayerAttach(playerid,false);
	    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
	    ClosePlayerSpectated(playerid);
    	//Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerNameTag[playerid],E_STREAMER_DRAW_DISTANCE,50.0);
	    pLastAlive[playerid][_Game_In]=false;
   		new gameid=pGameID(playerid);
	    UpdateGameAliveDraw(pGameID(playerid),GetGameAlivePlayerAmouts(pGameID(playerid)));
	    pLastAlive[playerid][_Game_Death]=false;
	    pLastAlive[playerid][_Game_SpectatePlane]=false;
	    pLastAlive[playerid][_Game_PlaneDown]=false;
	    pLastAlive[playerid][_Game_Deaths]=0;
	    pLastAlive[playerid][_Show_SmallMap]=false;
  		LastTimeWeapon[playerid]=0;
  		forex(s,12)LastTimeAmmo[playerid][s]=0;
  		pBuffID[playerid]=NONE;
		pBuffCount[playerid]=0;
		pCacheID[playerid]=NONE;
		pCacheCount[playerid]=0;
	    
		SetPlayerVirtualWorld(playerid,PersonalRoom(playerid));
		SetPlayerInterior(playerid,0);
		SetPlayerWeather(playerid,random(21));
		HandlePlayerSignature(playerid,true);

	    HidePlayerGameScorePanel(playerid);//隐藏积分框
	    HidePlayerGameAlive(playerid);//隐藏生存栏
	    DestoryPlayerGameKillDraw(playerid);//删除击杀栏
		DestoryPlayerValuePanelDraw(playerid);//删除血量 武器 护甲栏
		HidePlayerTimeLineBackGround(playerid);//隐藏时间轴背景
		HidePlayerTimeLineTime(playerid);//隐藏时间轴时间
		DestoryPlayerInvDraw(playerid);//删除背包
		DestoryPlayerInvItemBottonDo(playerid);//删除玩家使用菜单
		DestoryPlayerBodyDressDraw(playerid);//删除玩家背包页面的饰品栏显示
		DestoryPlayerInvDraw(playerid);//删除玩家背包页面的背包栏显示
		DestoryPlayerNearByDraw(playerid);//删除玩家背包页面的附近栏显示
		DestoryPlayerUseWeaponDraw(playerid);//删除玩家背包页面的武器栏显示
		DestoryPlayerValuePanelDraw(playerid);//删除玩家血量 护甲 护头显示
		DestorypBuffBar(playerid);//删除玩家食物进度条显示
		DestorypCacheBar(playerid);//删除玩家药物进度条显示
		HidePlayerSmallMap(playerid);//删除玩家小地图显示
		HidePlayerFlyMapBackGround(playerid);//隐藏玩家小地图
		DestoryPlayerGameOverPrive(playerid,false);//删除玩家结束界面
		HidePlayerSpeedoMeter(playerid);//隐藏速度表
		HidePlayerDeathBox(playerid);//删除箱子Draw
		DestoryPlayerCompass(playerid);//删除角度指针
		DestoryPlayerRaderDraw(playerid);//删除地域显示
		HidePlayerHitList(playerid);//删除伤害显示
		ClearPlayerHitList(playerid);//删除清除伤害
		HidePlayerLeftGui(gameid,playerid);//隐藏离开提示
		HidePlayerPickGuiTipY(playerid);//隐藏物品提示
		HidePlayerPickGuiTipC(playerid);//隐藏物品提示
		DestoryPlayerTempCar(playerid,false);
		CancelSelectTextDraw(playerid);

		RestPlayerInventoryData(playerid);
		
		if(showrank==true)
		{
		    new Reward=0;
			new Rank=GetPlayerGameRank(playerid,pGameID(playerid));
			//printf("Rank %i",Rank);
			if(Rank!=NONE)
			{
				if(GetGameAlivePlayerAmouts(pGameID(playerid))<1)
				{
 					if(LastAliveGame[gameid][_TimeLine]<180)Reward=0;
					else
					{
						Reward=floatround(LastAliveGame[gameid][_TimeLine]/100,floatround_ceil);
						Account[playerid][_Gold]+=Reward;
						Update@AccountGold(playerid,Account[playerid][_Gold]);
					}
			        ShowPlayerGameOverDraw(playerid,"Winner_Winner_Winner,_Chicken_Dinner_!",Rank+1,pLastAlive[playerid][_Game_Kills],GetGameAlivePlayerAmouts(gameid)+1,LastAliveGame[pGameID(playerid)][_MaxPlayers],Reward,pLastAlive[playerid][_Game_CountDown]);
			       	SendWinMsgToPlayer(playerid,gameid,-1,_GAME_WIN);
			       	if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_GAMEWIN);
				}
			    else
			    {
 					if(LastAliveGame[gameid][_TimeLine]<180)Reward=0;
					else
					{
						Reward=floatround(LastAliveGame[gameid][_TimeLine]/300,floatround_ceil);
						Account[playerid][_Gold]+=Reward;
						Update@AccountGold(playerid,Account[playerid][_Gold]);
					}
			        ShowPlayerGameOverDraw(playerid,"Good_Luck_,_Guy",Rank+1,pLastAlive[playerid][_Game_Kills],GetGameAlivePlayerAmouts(gameid)+1,LastAliveGame[pGameID(playerid)][_MaxPlayers],Reward,pLastAlive[playerid][_Game_CountDown]);
                    if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_GAMEFAIL);
			    }
			}
			else
			{
				if(LastAliveGame[gameid][_TimeLine]<180)Reward=0;
				else
				{
					Reward=floatround(LastAliveGame[gameid][_TimeLine]/300,floatround_ceil);
					Account[playerid][_Gold]+=Reward;
					Update@AccountGold(playerid,Account[playerid][_Gold]);
				}
			    ShowPlayerGameOverDraw(playerid,"Good_Luck_,_Guy",Rank+1,pLastAlive[playerid][_Game_Kills],GetGameAlivePlayerAmouts(gameid)+1,LastAliveGame[pGameID(playerid)][_MaxPlayers],Reward,pLastAlive[playerid][_Game_CountDown]);
				if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_GAMEFAIL);
			}
		}
  		pLastAlive[playerid][_Game_Kills]=0;
	    pGameID(playerid)=NONE;
	    RefreshGameRank(gameid);
     	ClearDeathList(playerid);
	    if(disconnect==false)
	    {
	    	PlayerInState[playerid]=PLAYER_IN_WAITLEAVE;
	    	PlayerInStateID[playerid]=NONE;
	    }
	    else
	    {
	        SendLastAliveDeathMessage(gameid,playerid,INVALID_PLAYER_ID,NONE,true);
	    	PlayerInState[playerid]=PLAYER_IN_NULL;
	    	PlayerInStateID[playerid]=NONE;
	    }
	}
	if(disconnect==true)
	{
	    HidePlayerGameScorePanel(playerid);//隐藏积分框
	    HidePlayerGameAlive(playerid);//隐藏生存栏
	    DestoryPlayerGameKillDraw(playerid);//删除击杀栏
		DestoryPlayerValuePanelDraw(playerid);//删除血量 武器 护甲栏
		HidePlayerTimeLineBackGround(playerid);//隐藏时间轴背景
		HidePlayerTimeLineTime(playerid);//隐藏时间轴时间
		DestoryPlayerInvDraw(playerid);//删除背包
		DestoryPlayerInvItemBottonDo(playerid);//删除玩家使用菜单
		DestoryPlayerBodyDressDraw(playerid);//删除玩家背包页面的饰品栏显示
		DestoryPlayerInvDraw(playerid);//删除玩家背包页面的背包栏显示
		DestoryPlayerNearByDraw(playerid);//删除玩家背包页面的附近栏显示
		DestoryPlayerUseWeaponDraw(playerid);//删除玩家背包页面的武器栏显示
		DestoryPlayerValuePanelDraw(playerid);//删除玩家血量 护甲 护头显示
		DestorypBuffBar(playerid);//删除玩家食物进度条显示
		DestorypCacheBar(playerid);//删除玩家药物进度条显示
		HidePlayerSmallMap(playerid);//删除玩家小地图显示
		HidePlayerFlyMapBackGround(playerid);//隐藏玩家小地图
		DestoryPlayerGameOverPrive(playerid,disconnect);//删除玩家结束界面
		HidePlayerSpeedoMeter(playerid);//隐藏速度表
		HidePlayerDeathBox(playerid);//删除箱子Draw
		DestoryPlayerCompass(playerid);//删除角度指针
		HidePlayerHitList(playerid);//删除伤害显示
		ClearPlayerHitList(playerid);//删除清除伤害
		HidePlayerPickGuiTipY(playerid);//隐藏物品提示
		HidePlayerPickGuiTipC(playerid);//隐藏物品提示
	}
	return 1;
}
N::CloseLastAliveGame(gameid)
{
    LastAliveGame[gameid][_Key]=NONE;
	LastAliveGame[gameid][_Ready]=false;
	LastAliveGame[gameid][_State]=LASTALIVE_STATE_NONE;
    foreach(new s:Player)
    {
	    if(Online(s))
	    {
	        if(pGameID(s)==gameid&&pGameIn(s)==true)
			{
		        if(PlayerInState[s]==PLAYER_IN_GAMEROOM)
				{
					DalayLeaveLastAliveGame(s,gameid);
				}
			}
	    }
	}
    forex(s,MAX_GAME_CIRCLE_POS)
	{
		forex(j,MAX_GAME_CIRCLE_POS)
		{
	    	ToxicCircleStartPosA[gameid][s][j]=ToxicCircleStartPos[s][j];
	    }
	}
    forex(s,MAX_GAME_CIRCLE_POS)
	{
	    if(GameToxicCircle[gameid][s][_GangZoneID]!=INVALID_GANG_ZONE)GangZoneDestroy(GameToxicCircle[gameid][s][_GangZoneID]);
	    if(GameSafeCircle[gameid][s][_GangZoneID]!=INVALID_GANG_ZONE)GangZoneDestroy(GameSafeCircle[gameid][s][_GangZoneID]);
		GameToxicCircle[gameid][s][_GangZoneID]=INVALID_GANG_ZONE;
		GameSafeCircle[gameid][s][_GangZoneID]=INVALID_GANG_ZONE;
		forex(k,MAX_GAME_CIRCLE_POS)SafeCircleStaticStartPos[gameid][s][k]=0.0;
	}
	if(LastAliveGame[gameid][Timer:_Wait]!=NONE)KillTimer(LastAliveGame[gameid][Timer:_Wait]);
    if(LastAliveGame[gameid][Timer:_Nontox]!=NONE)KillTimer(LastAliveGame[gameid][Timer:_Nontox]);
    if(LastAliveGame[gameid][Timer:_Safe]!=NONE)KillTimer(LastAliveGame[gameid][Timer:_Safe]);
    StopLeftGui(gameid);
	LastAliveGame[gameid][Timer:_Wait]=NONE;
	LastAliveGame[gameid][Timer:_Nontox]=NONE;
	LastAliveGame[gameid][Timer:_Safe]=NONE;
	LastAliveGame[gameid][_Type]=LASTALIVE_TYPE_NONE;
	LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_NONE;
	LastAliveGame[gameid][_TimeLine]=0;
	LastAliveGame[gameid][_SafeLine]=NONE;
	LastAliveGame[gameid][_SafeAmout]=0.0;
	LastAliveGame[gameid][_NontoxAmout]=0;
	LastAliveGame[gameid][_WaitTimeLine]=0;
	LastAliveGame[gameid][_Rate]=0;
	LastAliveGame[gameid][_RoundTimes]=0;
	LastAliveGame[gameid][_MaxPlayers]=0;
	LastAliveGame[gameid][_ZoneShow]=false;
    LastAliveGame[gameid][_Weather_ID]=0;
    LastAliveGame[gameid][_Weather_Count]=0;
    LastAliveGame[gameid][_AirBox_Count]=0;
	
	if(LastAliveGame[gameid][_NontoxicZone]!=INVALID_GANG_ZONE)GangZoneDestroy(LastAliveGame[gameid][_NontoxicZone]);
	LastAliveGame[gameid][_NontoxicZone]=INVALID_GANG_ZONE;
	LastAliveGame[gameid][_NontoxicMinX]=0.0;
	LastAliveGame[gameid][_NontoxicMinY]=0.0;
	LastAliveGame[gameid][_NontoxicMaxX]=0.0;
	LastAliveGame[gameid][_NontoxicMaxY]=0.0;
	LastAliveGame[gameid][_SafeZone]=INVALID_GANG_ZONE;
	LastAliveGame[gameid][_SafeMinX]=0.0;
	LastAliveGame[gameid][_SafeMinY]=0.0;
	LastAliveGame[gameid][_SafeMaxX]=0.0;
	LastAliveGame[gameid][_SafeMaxY]=0.0;
	if(LastAliveGame[gameid][_Npc_Driver_ID]!=INVALID_PLAYER_ID)
	{
	    FCNPC_RemoveFromVehicle(LastAliveGame[gameid][_Npc_Driver_ID]);
	    FCNPC_Destroy(LastAliveGame[gameid][_Npc_Driver_ID]);
	}
	LastAliveGame[gameid][_Npc_Driver_ID]=INVALID_PLAYER_ID;
	if(LastAliveGame[gameid][_Plane_ID]!=INVALID_VEHICLE_ID)DestroyVehicle(LastAliveGame[gameid][_Plane_ID]);
	LastAliveGame[gameid][_Plane_ID]=INVALID_VEHICLE_ID;
	LastAliveGame[gameid][_Plane_Flying]=false;
	if(LastAliveGame[gameid][_Plane_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(LastAliveGame[gameid][_Plane_Draw]);
    LastAliveGame[gameid][_Plane_Draw]=Text:INVALID_TEXT_DRAW;
    if(LastAliveGame[gameid][_SmallMap_Toxic_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(LastAliveGame[gameid][_SmallMap_Toxic_Circle]);
	LastAliveGame[gameid][_SmallMap_Toxic_Circle]=Text:INVALID_TEXT_DRAW;
	if(LastAliveGame[gameid][_SmallMap_Safe_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(LastAliveGame[gameid][_SmallMap_Safe_Circle]);
	LastAliveGame[gameid][_SmallMap_Safe_Circle]=Text:INVALID_TEXT_DRAW;
    LastAliveGame[gameid][_Time_Line_Warn]=0;
	foreach(new s:gVehicle[gameid])DestroyDynamicVehicle(gVehicle[gameid][s][_VehicleID]);
    forex(s,MAX_GAME_VEHICLE)
    {
      	gVehicle[gameid][s][_VehicleID]=INVALID_VEHICLE_ID;
       	gVehicle[gameid][s][_VehicleKey]=0;
       	gVehicle[gameid][s][_VehicleEngine]=false;
       	gVehicle[gameid][s][_VehicleFuel]=0.0;
    }
	Iter_Clear(gVehicle[gameid]);
    foreach(new s:PickItem[gameid])
    {
        DestroyDynamicObject(PickItem[gameid][s][_Obj]);
        DestroyDynamic3DTextLabel(PickItem[gameid][s][_Text]);
        DestroyDynamicArea(PickItem[gameid][s][_Area]);
	}
    forex(s,MAX_PICKITEM)
    {
        PickItem[gameid][s][_Obj]=INVALID_STREAMER_ID;
        PickItem[gameid][s][_Text]=Text3D:INVALID_STREAMER_ID;
        PickItem[gameid][s][_Area]=INVALID_STREAMER_ID;
	    if(LastAliveGame[gameid][_PickItem_MapIcon][s]!=INVALID_STREAMER_ID)DestroyDynamicMapIcon(LastAliveGame[gameid][_PickItem_MapIcon][s]);
		LastAliveGame[gameid][_PickItem_MapIcon][s]=INVALID_STREAMER_ID;
		LastAliveGame[gameid][_PickItem_MapAmout][s]=0;
    }
    DestoryToxicZoneWall(gameid);
    RestGameRank(gameid);
   	ClearGameDeathBox(gameid);
    Iter_Clear(PickItem[gameid]);
	return 1;
}
N::GetWeaponAmmoTypeItemID(Type)
{
	forex(i,sizeof(Item))
	{
		if(Item[i][_Type]==ITEM_AMMO&&Item[i][_WeaponAmmoType]==Type)return i;
	}
	return NONE;
}
N::CreateLastAliveGame(Type)
{
    GameTickCount=GetTickCount();
    if(Iter_Count(LastAliveGame)>=MAX_LASTALIVE_GAMES-1)return 0;
	new i=Iter_Free(LastAliveGame);
	LastAliveGame[i][_Key]=GetTickCount();
	LastAliveGame[i][_Ready]=false;
	LastAliveGame[i][_Type]=Type;
	LastAliveGame[i][_Type]=LASTALIVE_TYPE_NONE;
	LastAliveGame[i][_State]=LASTALIVE_STATE_START;
	LastAliveGame[i][_TimeLine]=0;
	LastAliveGame[i][_RoundTimes]=MAX_GAME_ROUND_TIME;
	LastAliveGame[i][_MaxPlayers]=0;
	LastAliveGame[i][_ZoneShow]=false;
    LastAliveGame[i][_Weather_ID]=random(21);
    LastAliveGame[i][_Weather_Count]=LastAliveGame[i][_TimeLine]+Randoms(120, 300);
    LastAliveGame[i][_AirBox_Count]=MAX_GAME_ROUND_TIME+random(60);
   	CreateSafeCircle(i);
   	Iter_Add(LastAliveGame,i);
   	
   	printf("阶段1  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
   	
	ClearGameDeathBox(i);
	
   	printf("阶段2  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
   	
	new itemtype=0,Amouts=0,itemid,Float:Tpos[2];
	forex(s,sizeof(PickItemSpawnPos))
	{
	    if(random(6)<4)
	    {
		    Amouts=Randoms(2,3);
		    //Amouts=Randoms(10,20);
		    itemtype=random(2);
		    if(itemtype==0)
		    {
		        new ammoid=NONE;
			    forex(j,Amouts)
			    {
					if(ammoid==NONE)
					{
	                	itemid=Randoms(0,13);
	                	ammoid=GetWeaponAmmoTypeItemID(Item[itemid][_WeaponAmmoType]);
	    				GetRandomPointInCircle(PickItemSpawnPos[s][_X],PickItemSpawnPos[s][_Y],1.5,Tpos[0],Tpos[1]);
	           		    CreatePickItem(i,s,itemid,1,Item[itemid][_AmmoAmout],Item[itemid][_Durable],Tpos[0],Tpos[1],PickItemSpawnPos[s][_Z]-0.8,0.0,0.0,0.0,0,50.0,2.5,0);
	                    LastAliveGame[i][_PickItem_MapAmout][s]++;
	                }
					else
					{
					    itemid=ammoid;
	    				GetRandomPointInCircle(PickItemSpawnPos[s][_X],PickItemSpawnPos[s][_Y],1.5,Tpos[0],Tpos[1]);
					    CreatePickItem(i,s,itemid,1,Item[itemid][_AmmoAmout],Item[itemid][_Durable],Tpos[0],Tpos[1],PickItemSpawnPos[s][_Z]-0.8,0.0,0.0,0.0,0,50.0,2.5,0);
	                    LastAliveGame[i][_PickItem_MapAmout][s]++;
					}
			    }
		    }
		    else
		    {
			    forex(j,Amouts)
			    {
	                itemid=Randoms(13,sizeof(Item));
	    			GetRandomPointInCircle(PickItemSpawnPos[s][_X],PickItemSpawnPos[s][_Y],1.5,Tpos[0],Tpos[1]);
	                CreatePickItem(i,s,itemid,1,Item[itemid][_AmmoAmout],Item[itemid][_Durable],Tpos[0],Tpos[1],PickItemSpawnPos[s][_Z]-0.8,0.0,0.0,0.0,0,50.0,2.5,0);
	                LastAliveGame[i][_PickItem_MapAmout][s]++;
			    }
		    }
	    }
	}
	forex(s,sizeof(PickItemSpawnPos))
	{
		if(LastAliveGame[i][_PickItem_MapAmout][s]>0)
		{
		    if(LastAliveGame[i][_PickItem_MapIcon][s]!=INVALID_STREAMER_ID)
		    {
				DestroyDynamicMapIcon(LastAliveGame[i][_PickItem_MapIcon][s]);
		    	LastAliveGame[i][_PickItem_MapIcon][s]=INVALID_STREAMER_ID;
		    }
		    LastAliveGame[i][_PickItem_MapIcon][s]=CreateDynamicMapIcon(PickItemSpawnPos[s][_X],PickItemSpawnPos[s][_Y],PickItemSpawnPos[s][_Z],37,0x000040C8,GameRoom(i),0,-1,50.0,MAPICON_GLOBAL);
		}
	}
	printf("GAME #%i 生成 %i 个物资",i,Iter_Count(PickItem[i]));
	
   	printf("阶段3  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
   	
	/*Iter_Clear(TempVehicePos);
	forex(s,sizeof(VehicleSpawnPos))Iter_Add(TempVehicePos,s);*/
	new local=random(MAX_TESTPOS);
	foreach(new s:testpos[local])
 	{
 	    new vehiclemodel=UsedVehicleID[random(sizeof(UsedVehicleID))];
		CreateGameVehicle(i,vehiclemodel,testpos[local][s][_testx],testpos[local][s][_testy],testpos[local][s][_testz]+1.5,RandFloat(360.0),random(255),random(255),0);
 	}
	/*forex(s,MAX_GAME_VEHICLE)
	{
	    new vehiclemodel=UsedVehicleID[random(sizeof(UsedVehicleID))];
		new SpawnPosID=Iter_Random(TempVehicePos);
	    CreateGameVehicle(i,vehiclemodel,VehicleSpawnPos[SpawnPosID][_X],VehicleSpawnPos[SpawnPosID][_Y],VehicleSpawnPos[SpawnPosID][_Z],VehicleSpawnPos[SpawnPosID][_A],random(255),random(255),0);
        Iter_Remove(TempVehicePos,SpawnPosID);
	}*/
	//Iter_Clear(TempVehicePos);
	
   	printf("阶段4  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
   	
    UpdateGameAliveDraw(i,GetGameAlivePlayerAmouts(i));
    
    LastAliveGame[i][_WaitTimeLine]=LastAliveGame[i][_RoundTimes];
    LastAliveGame[i][Timer:_Wait]=SetTimerEx("Game_Wait_Time",1000,true,"ii",i,0);
    LastAliveGame[i][_Round]=LASTALIVE_ROUND_WAIT;

   	printf("阶段5  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
    
    fLine_64("NpcDriver_%i_%i",i,random(10000));
    LastAliveGame[i][_Npc_Driver_ID]=FCNPC_Create(line);
	FCNPC_Spawn(LastAliveGame[i][_Npc_Driver_ID],162,0.0,0.0,0.0);
    SetPlayerColor(LastAliveGame[i][_Npc_Driver_ID],0xFFFFFF00);
    FCNPC_SetVirtualWorld(LastAliveGame[i][_Npc_Driver_ID],GameRoom(i));
    FCNPC_SetInterior(LastAliveGame[i][_Npc_Driver_ID],0);
    new PlaneMap=random(4);
    
    FCNPC_SetPosition(LastAliveGame[i][_Npc_Driver_ID],PlaneFullMapPos[PlaneMap][0],PlaneFullMapPos[PlaneMap][1],700.0);
    LastAliveGame[i][_Plane_ID]=CreateVehicle(592,PlaneFullMapPos[PlaneMap][0],PlaneFullMapPos[PlaneMap][1],700.0,0,-1,-1,-1);
   	SetVehicleVirtualWorld(LastAliveGame[i][_Plane_ID],GameRoom(i));
    LinkVehicleToInterior(LastAliveGame[i][_Plane_ID],0);
	FCNPC_PutInVehicle(LastAliveGame[i][_Npc_Driver_ID],LastAliveGame[i][_Plane_ID],0);

   	printf("阶段6  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();

	foreach(new s:Player)
	{
	    if(Online(s))
	    {
	        if(PlayerInState[s]==PLAYER_IN_WAITROOM)
			{
			    if(PlayerInStateID[s]==Type)
				{
				    StopMusicForPlayer(s);
					SetPlayerToLastAliveGame(s,i);
					SetPlayerPos(s,PlaneFullMapPos[PlaneMap][0],PlaneFullMapPos[PlaneMap][1],700.0);
                }
			}
	    }
	}
    foreach(new s:Player)
    {
	    if(Online(s))
	    {
	        if(pGameID(s)==i&&pGameIn(s)==true)
	        {
				SetPlayerPos(s,PlaneFullMapPos[PlaneMap][0],PlaneFullMapPos[PlaneMap][1],700.0);
	            pLastAlive[s][_Game_SpectatePlane]=true;
				TogglePlayerSpectating(s, 1);
				PlayerSpectateVehicle(s, LastAliveGame[i][_Plane_ID]);
				ShowPlayerFlyMapBackGround(s);
				LastAliveGame[i][_MaxPlayers]++;
				
	        }
		}
    }
    CreateGameRank(i);
    FCNPC_GoTo(LastAliveGame[i][_Npc_Driver_ID],PlaneFullMapPos[PlaneMap][2],PlaneFullMapPos[PlaneMap][3],700.0,FCNPC_MOVE_TYPE_DRIVE,13.0);
    LastAliveGame[i][_Plane_Flying]=true;
   	printf("阶段7  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
    foreach(new s:Player)
    {
	    if(Online(s))
	    {
	        if(pGameID(s)==i&&pGameIn(s)==true)SetPlayerWorldBounds(s,3000.0,-3000.0,3000.0,-3000.0);
        }
    }
   	LastAliveGame[i][_Ready]=true;
   	printf("阶段8  %i ms",GetTickCount()-GameTickCount);
   	GameTickCount=GetTickCount();
	return 1;
}
N::GetNpcDriverID(npcid)
{
 	foreach(new i:LastAliveGame)
 	{
		if(LastAliveGame[i][_Npc_Driver_ID]==npcid)return i;
 	}
 	return NONE;
}
public FCNPC_OnReachDestination(npcid)
{
	new index=GetNpcDriverID(npcid);
	if(index!=NONE)
	{
	    LastAliveGame[index][_Plane_Flying]=false;
	    foreach(new i:Player)
	    {
		    if(Online(i))
		    {
		        if(pGameID(i)==index&&pGameIn(i)==true)
		        {
                    if(pLastAlive[i][_Game_SpectatePlane]==true)
                    {
                    	pLastAlive[i][_Game_SpectatePlane]=false;
                    	pLastAlive[i][_Game_PlaneDown]=true;
                    	GetPlayerPos(i,pLastAlive[i][_Game_PlaneDown_Pos][0],pLastAlive[i][_Game_PlaneDown_Pos][1],pLastAlive[i][_Game_PlaneDown_Pos][2]);
                    	GetVehicleZAngle(LastAliveGame[pGameID(i)][_Plane_ID],pLastAlive[i][_Game_PlaneDown_Pos][3]);
						SetSpawnInfo(i,NO_TEAM,Account[i][_Skin],pLastAlive[i][_Game_PlaneDown_Pos][0],pLastAlive[i][_Game_PlaneDown_Pos][1],pLastAlive[i][_Game_PlaneDown_Pos][2],pLastAlive[i][_Game_PlaneDown_Pos][3],46,1,0,0,0,0);
						TogglePlayerSpectating(i,0);
						HidePlayerFlyMapBackGround(i);
						if(LastAliveGame[pGameID(i)][_Plane_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(i,LastAliveGame[pGameID(i)][_Plane_Draw]);
					}
		        }
			}
	    }
		FCNPC_RemoveFromVehicle(LastAliveGame[index][_Npc_Driver_ID]);
		FCNPC_Destroy(LastAliveGame[index][_Npc_Driver_ID]);
		DestroyVehicle(LastAliveGame[index][_Plane_ID]);
		LastAliveGame[index][_Npc_Driver_ID]=INVALID_PLAYER_ID;
		LastAliveGame[index][_Plane_ID]=INVALID_VEHICLE_ID;
	}
	return 1;
}

N::Game_Wait_Time(gameid,type)
{
    if(LastAliveGame[gameid][_State]==LASTALIVE_STATE_START)
    {
	    LastAliveGame[gameid][_WaitTimeLine]--;
		switch(type)
		{
		    case 0:
		    {
		        UpdatePlayerTimeLineTime(gameid,LastAliveGame[gameid][_WaitTimeLine]);
			    if(LastAliveGame[gameid][_WaitTimeLine]<=0)
			    {
			        KillTimer(LastAliveGame[gameid][Timer:_Wait]);
			        LastAliveGame[gameid][Timer:_Wait]=NONE;
					LastAliveGame[gameid][_NontoxAmout]=0;
					LastAliveGame[gameid][Timer:_Nontox]=SetTimerEx("Game_Nontox_Time",1000,true,"i",gameid);
					LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_NONTOXIC;
					LastAliveGame[gameid][_ZoneShow]=true;
			     	SendLastAliveGameMsg(gameid,-1,_GAME_CIRCLE_1);
			     	PlayGameAudioStream(gameid,MUSIC_TOXIC);
			    }
		    }
		    case 1:
		    {
		        UpdatePlayerTimeLineTime(gameid,LastAliveGame[gameid][_WaitTimeLine]);
			    if(LastAliveGame[gameid][_WaitTimeLine]<=0)
			    {
			        KillTimer(LastAliveGame[gameid][Timer:_Wait]);
			        LastAliveGame[gameid][Timer:_Wait]=NONE;
					LastAliveGame[gameid][_SafeLine]=1;
			 		LastAliveGame[gameid][Timer:_Safe]=SetTimerEx("Game_Safe_Time",1000,true,"i",gameid);
			 		LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_SAFE;
			 		SendLastAliveGameMsg(gameid,-1,_GAME_CIRCLE_2);
			 		PlayGameAudioStream(gameid,MUSIC_SAFE);
			    }
		    }
		    case 2:
		    {
		        UpdatePlayerTimeLineTime(gameid,LastAliveGame[gameid][_WaitTimeLine]);
			    if(LastAliveGame[gameid][_WaitTimeLine]<=0)
			    {
			        KillTimer(LastAliveGame[gameid][Timer:_Wait]);
			        LastAliveGame[gameid][Timer:_Wait]=NONE;
			        LastAliveGame[gameid][_NontoxAmout]=0;
			        ChangeToxicCircle(gameid,LastAliveGame[gameid][_NontoxAmout]*NONTOX_MOVE_SPEED);
			     	ChangeSafeCircle(gameid,(0.5+LastAliveGame[gameid][_SafeAmout])*START_SATE_MOVE);
					LastAliveGame[gameid][Timer:_Nontox]=SetTimerEx("Game_Nontox_Time",1000,true,"i",gameid);
					LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_NONTOXIC;
					SendLastAliveGameMsg(gameid,-1,_GAME_CIRCLE_3);
					PlayGameAudioStream(gameid,MUSIC_TOXIC);
			    }
		    }
		    case 3:
		    {
		        UpdatePlayerTimeLineTime(gameid,65535);
		    }
	    }
	}
	return 1;
}
N::Game_Nontox_Time(gameid)
{
    if(LastAliveGame[gameid][_State]==LASTALIVE_STATE_START)
    {
	    UpdatePlayerTimeLineTime(gameid,0);
		if(LastAliveGame[gameid][_SafeAmout]<=0.0)ChangeSafeCircle(gameid,0*START_SATE_MOVE);
		else ChangeSafeCircle(gameid,(0.5+LastAliveGame[gameid][_SafeAmout])*START_SATE_MOVE);
	    LastAliveGame[gameid][_NontoxAmout]++;
	    /*new string[128];
		format(string,sizeof(string),"毒圈[%i]",LastAliveGame[gameid][_NontoxAmout]);
		SendClientMessageToAll(-1,string);*/
	    if(ChangeToxicCircle(gameid,LastAliveGame[gameid][_NontoxAmout]*NONTOX_MOVE_SPEED)==1)
		{
			KillTimer(LastAliveGame[gameid][Timer:_Nontox]);
	        LastAliveGame[gameid][Timer:_Nontox]=NONE;
	        LastAliveGame[gameid][_RoundTimes]=floatround(floatmul(LastAliveGame[gameid][_RoundTimes],MAX_GAME_PERCENT));
			LastAliveGame[gameid][_WaitTimeLine]=LastAliveGame[gameid][_RoundTimes];
	 		/*fLine_64("毒圈完成 开始等待 [%i]",LastAliveGame[gameid][_WaitTimeLine]);
			SendClientMessageToAll(-1,line);*/
	 		LastAliveGame[gameid][Timer:_Wait]=SetTimerEx("Game_Wait_Time",1000,true,"ii",gameid,1);
	 		LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_WAIT;
		}
	}
	return 1;
}
N::Game_Safe_Time(gameid)
{
    if(LastAliveGame[gameid][_State]==LASTALIVE_STATE_START)
    {
        //if(GetSafeZoneSize(gameid)>5000.0)
        //{
		    UpdatePlayerTimeLineTime(gameid,0);
		    LastAliveGame[gameid][_SafeLine]--;
		    LastAliveGame[gameid][_SafeAmout]+=SATE_MOVE_SPEED;
		    //ChangeToxicCircle(gameid,LastAliveGame[gameid][_NontoxAmout]*NONTOX_MOVE_SPEED);
		    if((0.5+LastAliveGame[gameid][_SafeAmout])*START_SATE_MOVE>=1040.0)
		    {
		        KillTimer(LastAliveGame[gameid][Timer:_Safe]);
		        LastAliveGame[gameid][Timer:_Safe]=NONE;
				LastAliveGame[gameid][_SafeLine]=0;
				LastAliveGame[gameid][_RoundTimes]=floatround(floatmul(LastAliveGame[gameid][_RoundTimes],MAX_GAME_PERCENT));
			    LastAliveGame[gameid][_WaitTimeLine]=LastAliveGame[gameid][_RoundTimes];
			    LastAliveGame[gameid][Timer:_Wait]=SetTimerEx("Game_Wait_Time",1000,true,"ii",gameid,3);
		  		LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_WAIT;
		    }
		    else
		    {
			    ChangeSafeCircle(gameid,(0.5+LastAliveGame[gameid][_SafeAmout])*START_SATE_MOVE);
			    //printf("Safe %f",(0.5+LastAliveGame[gameid][_SafeAmout])*START_SATE_MOVE);
			    if(LastAliveGame[gameid][_SafeLine]<=0)
			    {
			        KillTimer(LastAliveGame[gameid][Timer:_Safe]);
			        LastAliveGame[gameid][Timer:_Safe]=NONE;
					LastAliveGame[gameid][_SafeLine]=0;
					LastAliveGame[gameid][_RoundTimes]=floatround(floatmul(LastAliveGame[gameid][_RoundTimes],MAX_GAME_PERCENT));
				    LastAliveGame[gameid][_WaitTimeLine]=LastAliveGame[gameid][_RoundTimes];
			 		/*fLine_64("安全区完成 开始等待 [%i]",LastAliveGame[gameid][_WaitTimeLine]);
					SendClientMessageToAll(-1,line);*/
				    LastAliveGame[gameid][Timer:_Wait]=SetTimerEx("Game_Wait_Time",1000,true,"ii",gameid,2);
			  		LastAliveGame[gameid][_Round]=LASTALIVE_ROUND_WAIT;
			    }
		    }
		//}
    }
	return 1;
}
N::SetWaitRoomGameWeather(type,weatherid)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(PlayerInState[i]==PLAYER_IN_WAITROOM)SetPlayerWeather(i,weatherid);
	    }
	}
	return 1;
}
N::SendWaitRoomLeaveMsg(playerid,color,languageid)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(PlayerInState[i]==PLAYER_IN_WAITROOM)
	        {
                if(i!=playerid)
				{
				    fLine_128(ReturnMLStr(pLang(i),languageid),Color[Account[playerid][_NameColor]][_hex_str],Account[playerid][_Name]);
					SendClientMessage(i,color,line);
				}
	        }
	    }
	}
	return 1;
}
N::SendWaitRoomGameMsg(waitid,color,languageid)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(PlayerInState[i]==PLAYER_IN_WAITROOM&&PlayerInStateID[i]==waitid)SendClientMessage(i,color,ReturnMLStr(pLang(i),languageid));
	    }
	}
	return 1;
}
N::SetLastAliveGameWeather(gameid,weatherid)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid)SetPlayerWeather(i,weatherid);
	    }
	}
	return 1;
}
N::SendLastAliveGameMsg(gameid,color,languageid)
{
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid)SendClientMessage(i,color,ReturnMLStr(pLang(i),languageid));
	    }
	}
	return 1;
}
N::SendLastAliveDeathMessage(gameid,playerid,killerid,reason,bool:disconnect)
{
	new line[128];
	if(disconnect==true)
	{
		foreach(new i:Player)
		{
		    if(Online(i))
		    {
		        if(pGameID(i)==gameid)
				{
			    	format(line,sizeof(line),ReturnMLStr(pLang(i),_GAME_DEATH_3),Account[playerid][_Name],GetGameAlivePlayerAmouts(gameid));
					SCM(i,-1,line);
				}
			}
		}
		return 1;
	}
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid)
			{
				SendDeathMessageToPlayer(i,killerid,playerid,reason);
			}
	    }
	}
	new raesonstr[32];
	if(reason>=0&&reason<=46)format(raesonstr,sizeof(raesonstr),WeaponNames[reason]);
	else
	{
	    switch(reason)
	    {
	        case 47:format(raesonstr,sizeof(raesonstr),"Fake Pistol");
	        case 49:format(raesonstr,sizeof(raesonstr),"Vehicle");
	        case 50:format(raesonstr,sizeof(raesonstr),"Helicopter Blades");
	        case 51:format(raesonstr,sizeof(raesonstr),"Explosion");
	        case 53:format(raesonstr,sizeof(raesonstr),"Drowned");
	        case 54:format(raesonstr,sizeof(raesonstr),"Splat");
	        default:format(raesonstr,sizeof(raesonstr),"Null");
	    }
	}
	if(killerid==INVALID_PLAYER_ID)
	{
		foreach(new i:Player)
		{
		    if(Online(i))
		    {
		        if(pGameID(i)==gameid)
				{
			    	format(line,sizeof(line),ReturnMLStr(pLang(i),_GAME_DEATH_2),Account[playerid][_Name],raesonstr,GetGameAlivePlayerAmouts(gameid)-1);
					SCM(i,-1,line);
				}
			}
		}
	}
	else
	{
		foreach(new i:Player)
		{
		    if(Online(i))
		    {
		        if(pGameID(i)==gameid)
				{
					format(line,sizeof(line),ReturnMLStr(pLang(i),_GAME_DEATH_1),Account[playerid][_Name],Account[killerid][_Name],raesonstr,GetGameAlivePlayerAmouts(gameid)-1);
                    SCM(i,-1,line);
				}
			}
		}
	}
	format(line,sizeof(line),"~w~ID(~p~%i~w~) ~w~OUT  -  ~y~%i PLAYERS LEFT",GetGameAlivePlayerAmouts(gameid));
	ShowLeftGui(gameid,line);
	return 1;
}

/*****************************************/
N::GetGameAlivePlayerAmouts(gameid)
{
	new Amouts=0;
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid&&pGameIn(i)==true)Amouts++;
	    }
	}
	return Amouts;
}
N::GetWaitPlayerAmouts(Type)
{
	new Amouts=0;
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(PlayerInState[i]==PLAYER_IN_WAITROOM)
			{
			    if(PlayerInStateID[i]==Type)Amouts++;
			}
	    }
	}
	return Amouts;
}
/***********************************************************/
N::StopDalayLeaveLastAliveGame(playerid)
{
	if(pLastAlive[playerid][Timer:LeaveTimer]!=NONE)KillTimer(pLastAlive[playerid][Timer:LeaveTimer]);
	pLastAlive[playerid][Timer:LeaveTimer]=NONE;
	return 1;
}
N::DalayLeaveLastAliveGame(playerid,gameid)
{
	if(pLastAlive[playerid][Timer:LeaveTimer]!=NONE)KillTimer(pLastAlive[playerid][Timer:LeaveTimer]);
	pLastAlive[playerid][Timer:LeaveTimer]=NONE;
	pLastAlive[playerid][_Game_CountDown]=MAX_PLAYER_LEAVE_TIME;
	pLastAlive[playerid][Timer:LeaveTimer]=SetTimerEx("LeaveLastAliveGameCountDown",1000,true,"i",playerid);
	SetPlayerLeaveLastAliveGame(playerid,false,true);
	RefreshGameRank(gameid);
	//if(pLastAlive[playerid][_Game_SpectatePlane]==false)
	printf("%s,%i",Account[playerid][_Name],GetPlayerState(playerid));
	if(GetPlayerState(playerid)!=PLAYER_STATE_SPECTATING)
	{
		TogglePlayerSpectating(playerid,1);
	}
	PlayerConnectPosChange(playerid);
	return 1;
}
N::LeaveLastAliveGameCountDown(playerid)
{
    pLastAlive[playerid][_Game_CountDown]--;
    if(pGameOverTimeLeft[playerid]!=PlayerText:INVALID_TEXT_DRAW)
    {
        new line[64];
        format(line,sizeof(line),"%is",pLastAlive[playerid][_Game_CountDown]);
        PlayerTextDrawSetString(playerid,pGameOverTimeLeft[playerid],line);
        PlayerTextDrawShow(playerid,pGameOverTimeLeft[playerid]);
    }
    if(pLastAlive[playerid][_Game_CountDown]<=0)
    {
 		if(pLastAlive[playerid][Timer:LeaveTimer]!=NONE)KillTimer(pLastAlive[playerid][Timer:LeaveTimer]);
		pLastAlive[playerid][Timer:LeaveTimer]=NONE;
		pLastAlive[playerid][_Game_Death]=false;
		StopPlayerConnectPosChange(playerid);
		HidePlayerGameOverDraw(playerid);
   		SetSpawnInfo(playerid,NO_TEAM,Account[playerid][_Skin],pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z],pRotCam[playerid][_A],0,0,0,0,0,0);
        TogglePlayerSpectating(playerid,0);
    }
	return 1;
}
/**********************************************/
#define MAX_RANKS 100
enum GameRank_Info
{
	_Owner,
	_Playerid,
	_Score
}
new GameRank[MAX_LASTALIVE_GAMES][MAX_RANKS][GameRank_Info];
N::CreateGameRank(gameid)
{
	RestGameRank(gameid);
	new Count=0;
	foreach(new i:Player)
	{
	    if(Online(i))
	    {
	        if(pGameID(i)==gameid)
	        {
	            GameRank[gameid][Count][_Score]=1;
	            GameRank[gameid][Count][_Playerid]=i;
	            GameRank[gameid][Count][_Owner]=Account[i][_Key];
	            Count++;
	        }
	    }
	}
	return 1;
}
/*N::PrintfGameRank(gameid)
{
    RefreshGameRank(gameid);
	forex(i,MAX_RANKS)
	{
	    if(GameRank[gameid][i][_Playerid]!=NONE&&GameRank[gameid][i][_Owner]!=NONE)
	    {
	        printf("%i,%i,%i",GameRank[gameid][i][_Score],GameRank[gameid][i][_Playerid],GameRank[gameid][i][_Owner]);
	    }
    }
	return 1;
}
CMD:ph(playerid, params[], help)
{
    PrintfGameRank(pGameID(playerid));
	return 1;
}*/
CMD:de(playerid, params[], help)
{
    DamagePlayer(playerid,1000);
	return 1;
}
N::RestGameRank(gameid)
{
	forex(i,MAX_RANKS)
	{
		GameRank[gameid][i][_Score]=0;
		GameRank[gameid][i][_Playerid]=NONE;
		GameRank[gameid][i][_Owner]=NONE;
	}
	return 1;
}
N::GetPlayerGameRank(playerid,gameid)
{
    RefreshGameRank(gameid);
	new Rank=NONE/*,Score=0*/;
/* 	printf("*******************ID:%i*******************",playerid);
	forex(i,MAX_RANKS)
	{
        printf("序列%i-Score:%i,Playerid:%i,Owner:%i",i,GameRank[gameid][i][_Score],GameRank[gameid][i][_Playerid],GameRank[gameid][i][_Owner]);
    }
 	printf("*********************************************************");*/
	forex(i,MAX_RANKS)
	{
	    if(GameRank[gameid][i][_Playerid]!=NONE&&GameRank[gameid][i][_Owner]!=NONE)
	    {
		    if(GameRank[gameid][i][_Playerid]==playerid&&GameRank[gameid][i][_Owner]==Account[playerid][_Key])
		    {
		        Rank=i;
		        //Score=GameRank[gameid][i][_Score];
		    }
	    }
	}
/*	forex(i,MAX_RANKS)
	{
	    if(GameRank[gameid][i][_Playerid]!=NONE&&GameRank[gameid][i][_Owner]!=NONE)
	    {
		    if(GameRank[gameid][i][_Score]==Score)
		    {
                Rank=i;
                return Rank;
		    }
	    }
	}*/
	return Rank;
}
N::UpdateGameRank(playerid,gameid,score)
{
	forex(i,MAX_RANKS)
	{
	    if(GameRank[gameid][i][_Playerid]!=NONE&&GameRank[gameid][i][_Owner]!=NONE)
	    {
		    if(GameRank[gameid][i][_Playerid]==playerid&&GameRank[gameid][i][_Owner]==Account[playerid][_Key])
		    {
		        GameRank[gameid][i][_Score]=score+1;
		    }
	    }
	}
	RefreshGameRank(gameid);
	return 1;
}
N::RefreshGameRank(gameid)
{
	new TempRand[MAX_RANKS][3];
	forex(i,MAX_RANKS)
	{
		TempRand[i][0]=0;
		TempRand[i][1]=NONE;
		TempRand[i][2]=NONE;
	}
	forex(i,MAX_RANKS)
	{
		TempRand[i][0]=GameRank[gameid][i][_Score];
		TempRand[i][1]=GameRank[gameid][i][_Playerid];
		TempRand[i][2]=GameRank[gameid][i][_Owner];
	}
	forex(i,MAX_RANKS)
	{
	    if(Online(TempRand[i][1]))
	    {
	        if(Account[TempRand[i][1]][_Key]==TempRand[i][2])
	        {
	            if(pGameID(TempRand[i][1])!=gameid)
			    {
					TempRand[i][0]=0;
					TempRand[i][1]=NONE;
					TempRand[i][2]=NONE;
			    }
	        }
		    else
		    {
				TempRand[i][0]=0;
				TempRand[i][1]=NONE;
				TempRand[i][2]=NONE;
		    }
	    }
	    else
	    {
			TempRand[i][0]=0;
			TempRand[i][1]=NONE;
			TempRand[i][2]=NONE;
	    }
	}
/* 	printf("=======================================");
	forex(i,MAX_RANKS)
	{
        printf("序列%i-Score:%i,Playerid:%i,Owner:%i",i,GameRank[gameid][i][_Score],GameRank[gameid][i][_Playerid],GameRank[gameid][i][_Owner]);
    }
 	printf("=======================================");*/
	SortDeepArray(TempRand,0);
	new count=0;
	forex(i,MAX_RANKS)
	{
		GameRank[gameid][i][_Score]=0;
		GameRank[gameid][i][_Playerid]=NONE;
		GameRank[gameid][i][_Owner]=NONE;
	}
	for (new i=MAX_RANKS-1;i>NONE;i--)
	{
		GameRank[gameid][count][_Score]=TempRand[i][0];
  		GameRank[gameid][count][_Playerid]=TempRand[i][1];
    	GameRank[gameid][count][_Owner]=TempRand[i][2];
    	count++;
	}
	return 1;
}

/**********************************************/
N::OnPlayerAnimIndexChange(playerid,NewAnimIndex,OldAnimIndex)
{
/*    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
        new weaponid=GetPlayerWeapon(playerid);
		if(IsBulletWeapon(weaponid))
		{
			if(NewAnimIndex==1161||NewAnimIndex==1167||NewAnimIndex==1365||NewAnimIndex==1159)
			{
                HideAttach[playerid]=true;
                RestPlayerAttach(playerid,true);
			}
			else
			{
				if(HideAttach[playerid]==true)
				{
				    HideAttach[playerid]=false;
				    GivePlayerAttach(playerid);
				    RestBodyDressAttach(playerid);
				}
			}
		}
		else
		{
			if(HideAttach[playerid]==true)
			{
			    HideAttach[playerid]=false;
			    GivePlayerAttach(playerid);
			    RestBodyDressAttach(playerid);
			}
		}
	}
	else
	{
		if(HideAttach[playerid]==true)
		{
		    HideAttach[playerid]=false;
	    	GivePlayerAttach(playerid);
	    	RestBodyDressAttach(playerid);
		}
	}*/
	return 1;
}

CMD:exit(playerid, params[], help)
{
	switch(PlayerInState[playerid])
	{
	    case PLAYER_IN_GAMEROOM:
	    {
		    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
		    {
		        DalayLeaveLastAliveGame(playerid,pGameIn(playerid));
		    }
	    }
	    case PLAYER_IN_WAITROOM:
		{
		    DestoryPlayerWaitRoom(playerid);
		    SendWaitRoomLeaveMsg(playerid,-1,_COME_LOBBY);
			RemovePlayerFromVehicle(playerid);
			new Float:xyz[3];
			GetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
			SetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
			TogglePlayerSpectating(playerid, 1);
			SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
	    	PlayerInState[playerid]=PLAYER_IN_WAITLEAVE;
	    	PlayerInStateID[playerid]=NONE;
			SetPlayerLeaveLastAliveGame(playerid,false,true);
	 		if(pLastAlive[playerid][Timer:LeaveTimer]!=NONE)KillTimer(pLastAlive[playerid][Timer:LeaveTimer]);
			pLastAlive[playerid][Timer:LeaveTimer]=NONE;
			pLastAlive[playerid][_Game_Death]=false;
			StopPlayerConnectPosChange(playerid);
	   		SetSpawnInfo(playerid,NO_TEAM,Account[playerid][_Skin],pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z],pRotCam[playerid][_A],0,0,0,0,0,0);
	        TogglePlayerSpectating(playerid,0);
			HidePlayerGameOverDraw(playerid);
 	    	HidePlayerWaitRoomPrive(playerid);
 	    	DestoryPlayerCompass(playerid);
 	    	DsetoryPlayerTempCarSelectGui(playerid);
		}
	    case PLAYER_IN_SPECPLAYER:SetPlayerNotSpec(playerid);
	}
 	return 1;
}
N::CreatePlayerWaitRoom(playerid)
{
    if(Iter_Count(WaitRoom)>=MAX_WAITROOM_TYPES)return INVENTORY_FULL;
    new i=Iter_Free(WaitRoom);
    WaitRoom[i][_Owner]=Account[playerid][_Key];
    WaitRoom[i][_Key]=GetTickCount();
    UpdatePlayerWaitRoomObjectText(i);
    Iter_Add(WaitRoom,i);
    return i;
}
N::IsPlayerHaveWaitRoom(playerid)
{
	new have=0;
	foreach(new i:WaitRoom)
	{
	    if(i!=0)
	    {
		    if(WaitRoom[i][_Owner]==Account[playerid][_Key])have=1;
	    }
	}
	return have;
}
CMD:rkick(playerid, params[], help)
{
	new pid;
	if(sscanf(params, "i",pid))return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG13));
	switch(PlayerInState[playerid])
	{
	    case PLAYER_IN_WAITROOM:
		{
		    if(PlayerInStateID[playerid]!=0)
		    {
		        if(WaitRoom[PlayerInStateID[playerid]][_Owner]==Account[playerid][_Key])
		        {
		            if(Online(pid))
		            {
		                if(PlayerInState[pid]==PLAYER_IN_WAITROOM&&PlayerInStateID[pid]==PlayerInStateID[playerid])
		                {
		                    if(pid!=playerid)
		                    {
		                        PC_EmulateCommand(pid,"/exit");
		                        new line[128];
		                        format(line,sizeof(line),ReturnMLStr(pLang(pid),_PERSON_ROOM_MSG12),Select@GetPlayerNameByKey(WaitRoom[PlayerInStateID[playerid]][_Owner]));
						       	SCM(pid,-1,line);
						       	format(line,sizeof(line),ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG16),Account[pid][_Name]);
						       	SCM(playerid,-1,line);
					       	}
					       	else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG21));
		                }
		                else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG15));
		            }
		            else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG15));
		        }
		    }
		}
	}
 	return 1;
}
N::DestoryPlayerWaitRoom(playerid)
{
	new roomid=NONE;
	foreach(new i:WaitRoom)
	{
	    if(i!=0)
	    {
		    if(WaitRoom[i][_Owner]==Account[playerid][_Key])roomid=i;
	    }
	}
	if(roomid!=NONE)
	{
	    new line[128],Pname[32];
	    format(Pname,sizeof(Pname),Select@GetPlayerNameByKey(WaitRoom[roomid][_Owner]));
	    foreach(new i:Player)
	    {
		    if(Online(i))
		    {
				if(i!=playerid)
				{
			        if(PlayerInState[i]==PLAYER_IN_WAITROOM&&PlayerInStateID[i]==roomid)
			        {
                        PC_EmulateCommand(i,"/exit");
                        format(line,sizeof(line),ReturnMLStr(pLang(i),_PERSON_ROOM_MSG11),Pname);
				       	SCM(i,-1,line);
			        }
				}
		    }
		}
		Iter_Remove(WaitRoom,roomid);
	}
	return 1;
}
N::UpdatePlayerWaitRoomObjectText(index)
{
    new line[2048];
	format(line,sizeof(line),"房主:{FF8000}%s",Select@GetPlayerNameByKey(WaitRoom[index][_Owner]));
	SetDynamicObjectMaterialText(WaitRoom[index][_Obj1],0,line,OBJECT_MATERIAL_SIZE_512x64,"宋体",60,0,0xFFFFFFFF,0xFF000000,1);
	format(line,sizeof(line),"Owner:{FF8000}%s",Select@GetPlayerNameByKey(WaitRoom[index][_Owner]));
	SetDynamicObjectMaterialText(WaitRoom[index][_Obj2],0,line,OBJECT_MATERIAL_SIZE_512x64,"Arial",60,0,0xFFFFFFFF,0xFF000000,1);
	return 1;
}
N::GameMain@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case _ROOM_SELECT:
        {
		    if(response)SetPlayerToWaitRoom(playerid,0);
			else Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
        }
        case _PRESON_ROOM_START:
        {
		    if(response)
		    {
			    if(Iter_Contains(WaitRoom,PlayerInStateID[playerid]))
				{
			        if(WaitRoom[PlayerInStateID[playerid]][_Open]==false)
			        {
			            if(WaitRoom[PlayerInStateID[playerid]][_Owner]==Account[playerid][_Key])
			        	{
			        	    if(GetWaitPlayerAmouts(PlayerInStateID[playerid])>=2)
			        	    {
				        	    WaitRoom[PlayerInStateID[playerid]][_Countdown]=10;
				        	    WaitRoom[PlayerInStateID[playerid]][_Open]=true;
				        	    new line[128];
				        	    foreach(new i:Player)
								{
								    if(Online(i))
								    {
								        if(PlayerInState[i]==PLAYER_IN_WAITROOM&&PlayerInStateID[i]==PlayerInStateID[playerid])
								        {
								            line=" ";
								            format(line,sizeof(line),ReturnMLStr(pLang(i),_PERSON_ROOM_MSG22),Account[playerid][_Name]);
								            SCM(i,-1,line);
								        }
								    }
                                }
							}
							else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG19));
			        	}
					}
	            }
		    }
        }
		case _PRESON_ROOM:
		{
		    if(response)
		    {
                switch(listitem)
                {
                    case 0:
                    {
                        //if(Account[playerid][_Level]<1)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG14));
                        if(!IsPlayerHaveWaitRoom(playerid))
                        {
                        	new index=CreatePlayerWaitRoom(playerid);
                        	if(index!=INVENTORY_FULL)
							{
								SetPlayerToWaitRoom(playerid,index);
							}
                        }
                    }
                    case 1:
                    {
                        Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
                    }
                }
		    }
		}
		case _PRESON_ROOM_LIST:
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
						Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					}
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(WaitRoom[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])
						{
							Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						}
						if(!Iter_Contains(WaitRoom,index))
						{
							Dialog@Show(playerid,_PRESON_ROOM_LIST,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG4),ShowWaitRooms(playerid,1),ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SPEC_MSG5));
						}
                        SetPlayerToWaitRoom(playerid,index);
					}
				}
			}
		}
	}
 	return 1;
}
stock ShowWaitRooms(playerid,pager)
{
    DialogBoxID[playerid]=1;
	foreach(new i:WaitRoom)
	{
	    if(i!=0)
	    {
			DialogBox[playerid][DialogBoxID[playerid]]=i;
			DialogBoxKey[playerid][DialogBoxID[playerid]]=WaitRoom[i][_Key];
	   		DialogBoxID[playerid]++;
   		}
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_PERSON_ROOM_MSG3));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
	    new string[128];
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    format(string,sizeof(string),"%i\t%s\t%iP\n",index,Select@GetPlayerNameByKey(WaitRoom[index][_Owner]),GetWaitPlayerAmouts(index));
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
N::GameMain@OnPlayerDisconnect(playerid,reason)
{
    DestoryPlayerWaitRoom(playerid);
 	return 1;
}
