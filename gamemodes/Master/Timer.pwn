/************************************************************/
N::UpdateServerTime()
{
	new TempHour=0,TempMinute=0,TempSecond=0;
    gettime(TempHour,TempMinute,TempSecond);
    if(TempSecond!=ServerSecond)
    {
		Hooks("OnServerSecondChange","iii",TempHour,TempMinute,TempSecond);
    }
    if(TempMinute!=ServerMinute)
    {
		Hooks("OnServerMinuteChange","iii",TempHour,TempMinute,TempSecond);
    }
    if(TempHour!=ServerHour)
    {
        Hooks("OnServerHourChange","iii",TempHour,TempMinute,TempSecond);
    }
    ServerHour=TempHour,ServerMinute=TempMinute,ServerSecond=TempSecond;
    return 1;
}
N::OnServerSecondChange(hours,minutes,seconds)
{
    foreach(new i:Player)
    {
	    if(Online(i))UpdatePlayerFaceMenuTimes(i,hours,minutes,seconds);
    }
    return 1;
}
N::OnServerMinuteChange(hours,minutes,seconds)
{
    ServerSet@SaveServerRunTime();
	SendSystemBroadcast();
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
	    	SetPlayerTime(i,hours,minutes);
	    	PlayerLevelUpdate(i);
	    }
    }
    return 1;
}
N::OnServerHourChange(hours,minutes,seconds)
{
    foreach(new i:Player)
	{
	    if(Online(i))
	    {
        	fLine_64(ReturnMLStr(pLang(i),_CLOCK_MSG1),hours);
            SCM(i,-1,line);
    		if(pMusic[i][_Playing]==false)PlayAudioStreamForPlayer(i,MUSIC_WHOLETIME);
   		}
    }
    return 1;
}

N::_ScondUpdateTimer()
{
    UpdateServerTime();
    GameUpdateSecond();
    WaitRoomUpdateSecond();
    UpdateBlinkIngObject();
    foreach(new i:Player)
	{
	    if(Online(i))
	    {
			PlayerSecondUpdate(i);
			//printf("FPS:%i",GetPlayerFPS(i));
		}
	}
	HostNameChangeCount++;
	if(HostNameChangeCount>=HOSTNAME_CHANGETIME)
	{
	    if(HostNameChange==0)
	    {
	        HostNameChange=1;
			SendRconCommand("hostname "SERVER_HOSTNAME2"");
	    }
	 	else
	 	{
	 	    HostNameChange=0;
	 	    SendRconCommand("hostname "SERVER_HOSTNAME1"");
	 	}
	    HostNameChangeCount=0;
	}
	return 1;
}
N::_200msUpdateTimer()
{
	new Float:xyza[4];
    foreach(new playerid:Player)
	{
	    if(IsPlayerInAnyDynamicVehicle(playerid))
		{
			new vehicleid=GetPlayerDynamicVehicleID(playerid);
			GetDynamicVehiclePos(vehicleid,xyza[0],xyza[1],xyza[2]);
			GetDynamicVehicleZAngle(vehicleid,xyza[3]);
	    }
	    else
	    {
	      	GetPlayerPos(playerid,xyza[0],xyza[1],xyza[2]);
	        GetPlayerFacingAngle(playerid,xyza[3]);
	    }
	    new Speed=floatround(GetPlayerAllStateSpeed(playerid));
	   	//printf("%f %f %f",xyza[2],PlayerPos[playerid][_Z],xyza[2]-PlayerPos[playerid][_Z]);
	    //if(playerid==0)printf("新速度 %i,旧速度 %i,速度差 %i",Speed,PlayerPos[playerid][_LastSpeed],Speed-PlayerPos[playerid][_LastSpeed]);
	    AntiCheat@ChackPlayerSpeed(playerid,xyza[0],xyza[1],xyza[2],Speed,200);
	    AntiCheat@SavePlayerPos(playerid,xyza[0],xyza[1],xyza[2],xyza[3]);
	    PlayerPos[playerid][_LastSpeed]=Speed;
	    //GetPlayerCameraZAngle(playerid,PlayerPos[playerid][_Cam_A]);
		PlayerSpeedoUpdate(playerid);
	}
	return 1;
}
N::AntiCheat@SavePlayerPos(playerid,Float:x,Float:y,Float:z,Float:a)
{
	PlayerPos[playerid][_X]=x;
	PlayerPos[playerid][_Y]=y;
	PlayerPos[playerid][_Z]=z;
	PlayerPos[playerid][_A]=a;
	return 1;
}
N::_500msUpdateTimer()
{
/*    foreach(new playerid:Player)
    {
	    if(Online(playerid))
	    {
		    if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid=GetPlayerVehicleID(playerid);
				GetVehiclePos(vehicleid,PlayerPos[playerid][_X],PlayerPos[playerid][_Y],PlayerPos[playerid][_Z]);
				GetVehicleZAngle(vehicleid,PlayerPos[playerid][_A]);
            }
            else
            {
	        	GetPlayerPos(playerid,PlayerPos[playerid][_X],PlayerPos[playerid][_Y],PlayerPos[playerid][_Z]);
            	GetPlayerFacingAngle(playerid,PlayerPos[playerid][_A]);
            }
 	    }
    }*/
	return 1;
}
/************************************************************/
N::PlayerSecondUpdate(playerid)
{
    if(Online(playerid))
    {
        AnimRate[playerid]++;
        if(PlayerInState[playerid]==PLAYER_IN_INTERFACE)
        {
            if(pMusic[playerid][_Playing]==true)
            {
	            if(AnimRate[playerid]>=AnimNextRate[playerid])
	            {
	                new index=random(sizeof(AnimList));
	                ApplyAnimation(playerid,AnimList[index][_Name],AnimList[index][_Action],AnimList[index][_fDelta],AnimList[index][_loop],AnimList[index][_lockx],AnimList[index][_locky],AnimList[index][_freeze],AnimList[index][_time],1);
	                AnimNextRate[playerid]=AnimRate[playerid]+Randoms(10,20);
				}
			}
			else
			{
				ClearAnimations(playerid);
			}
        }
        UpdatePlayerRaderDraw(playerid);
        UpdatePlayerFaceMenuCounts(playerid);
        ChackPlayerWeapon(playerid);
        UpdatePlayerAfk(playerid);
        UpdatePlayerTempCar(playerid);
        PlayerPlayBottonCount[playerid]++;
        if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
        {
            ChackPlayerUnderGround(playerid);
            if(PauseTime[playerid]>180)
            {
                SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PAUSE_KICK_MSG));
                SetTimerEx("DelayKicke",100,false,"i",playerid);
            }

            if(LastAliveGame[pGameID(playerid)][_State]==LASTALIVE_STATE_START)
            {
                if(IsPlayerInAnyDynamicVehicle(playerid))SetPlayerArmedWeapon(playerid,0);
	            if(pLastAlive[playerid][_Game_SpectatePlane]==true)
	            {
	                if(!IsVehicleStreamedIn(LastAliveGame[pGameID(playerid)][_Plane_ID], playerid))
	                {
	                    pLastAlive[playerid][_Game_SpectatePlane]=false;
	                    pLastAlive[playerid][_Game_PlaneDown]=true;
	                    GetPlayerPos(playerid,pLastAlive[playerid][_Game_PlaneDown_Pos][0],pLastAlive[playerid][_Game_PlaneDown_Pos][1],pLastAlive[playerid][_Game_PlaneDown_Pos][2]);
	                    GetVehicleZAngle(LastAliveGame[pGameID(playerid)][_Plane_ID],pLastAlive[playerid][_Game_PlaneDown_Pos][3]);
						SetSpawnInfo(playerid,NO_TEAM,Account[playerid][_Skin],pLastAlive[playerid][_Game_PlaneDown_Pos][0],pLastAlive[playerid][_Game_PlaneDown_Pos][1],pLastAlive[playerid][_Game_PlaneDown_Pos][2],pLastAlive[playerid][_Game_PlaneDown_Pos][3],46,1,0,0,0,0);
	                    TogglePlayerSpectating(playerid,0);
	                    HidePlayerFlyMapBackGround(playerid);
	                    if(LastAliveGame[pGameID(playerid)][_Plane_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_Plane_Draw]);
                        SendJumpPlaneMsg(playerid,pGameID(playerid),-1,_AIR_DROP);
                        ShowPlayerHitList(playerid);//伤害显示
	                }
	            }
	            else
	            {
	                DestoryPlayerTimeLinePerson(playerid);
					if(IsPlayerInSafeZone(playerid,PlayerPos[playerid][_X],PlayerPos[playerid][_Y]))
					{
					    pLastAlive[playerid][_Time_Line_Person_Draw]=CreateTimeLinePersonPrevie(playerid,112.000000, 300.000000);
					}
					else if(IsPlayerInNontoxZone(playerid,PlayerPos[playerid][_X],PlayerPos[playerid][_Y]))
					{
					    pLastAlive[playerid][_Time_Line_Person_Draw]=CreateTimeLinePersonPrevie(playerid,81.5, 300.000000);
					}
					else
					{
				    	pLastAlive[playerid][_Time_Line_Person_Draw]=CreateTimeLinePersonPrevie(playerid,51.0, 300.000000);
					}
	            }
	            if(pLastAlive[playerid][_Show_SmallMap]==true)UpdatePlayerSmallArrow(playerid);
			    if(LastAliveGame[pGameID(playerid)][_ZoneShow]==true)
			    {
					if(!IsPlayerInNontoxZone(playerid,PlayerPos[playerid][_X],PlayerPos[playerid][_Y]))
	                {
	                	if(pBuffID[playerid]==NONE&&pCacheID[playerid]==NONE)
	                	{
	                    	DamagePlayer(playerid,1.0);
	                    }
	                }
	            }
	            if(pBuffID[playerid]!=NONE)
	            {
	                if(!IsPlayerMoving(playerid))
	                {
		                if(pBuffCount[playerid]<=0)
		                {
							ClearPlayerBuff(playerid);
		                }
		                else UpdatepBuffBar(playerid);
		                pBuffCount[playerid]--;
	                }
	                else
	                {
	                    if(pBuffCount[playerid]==Item[pBuffID[playerid]][_BuffTime])
						{
							if(AddThingToPlayerInventoy(playerid,pBuffID[playerid],1,0,0.0)==INVENTORY_FULL)
							{
							    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
							}
						}
	                    UpdatepBuffBar(playerid);
	                    ClearPlayerBuff(playerid);
	                }
	            }
	            if(pCacheID[playerid]!=NONE)
	            {
	                if(!IsPlayerMoving(playerid))
	                {
		                if(pCacheCount[playerid]<=0)
		                {
		                    HealPlayer(playerid,floatmul(Item[pCacheID[playerid]][_BuffEffect],100.0));
		                    ClearPlayerCache(playerid);
		                }
		                else UpdatepCacheBar(playerid);
		                pCacheCount[playerid]--;
	                }
	                else
	                {
						if(AddThingToPlayerInventoy(playerid,pCacheID[playerid],1,0,0.0)==INVENTORY_FULL)
						{
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
						}
						ClearPlayerCache(playerid);
	                }
	            }
			}
        }
    }
	return 1;
}
/************************************************************/
/************************************************************/
N::CBugFreezeOver(playerid)
{
	TogglePlayerControllable(playerid,true);
	pCBugging[playerid] = false;
	Timer:pCBugFreezeOver[playerid]=NONE;
	return 1;
}
/************************************************************/
N::ResetSpawnVehicle(vid)
{
	SetDynamicVehicleToRespawn(vid);
	return 1;
}
/************************************************************/
N::PlayerStartSendingCar(playerid,vehicleid)
{
	if(pGameID(playerid)!=NONE)
   	{
       	if(gVehicle[pGameID(playerid)][vehicleid][_VehicleEngine]==false)
       	{
       	    gVehicle[pGameID(playerid)][vehicleid][_VehicleEngine]=true;
       	    SetDynamicVehicleParamsEx(gVehicle[pGameID(playerid)][vehicleid][_VehicleID],1,0,0,0,0,0,0);
       	}
	}
    Timer:TurnOnEngineTimer[playerid]=NONE;
    return 1;
}
N::DelayKicke(playerid)
{
	if(!IsPlayerNPC(playerid))Kick(playerid);
	return 1;
}
/********************************************************/
N::UpdatePlayerDamagePrive(playerid)
{
    PlayerDamageAmout[playerid]--;
    if(PlayerDamageAmout[playerid]<=0)
    {
        PlayerTextDrawHide(playerid,PlayerDamageDraw[playerid]);
		if(PlayerDamageDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerDamageDraw[playerid]);
	    PlayerDamageDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
		PlayerDamageAmout[playerid]=0;
		KillTimer(Timer:PlayerDamageTimer[playerid]);
		Timer:PlayerDamageTimer[playerid]=NONE;
    }
    else
    {
    	PlayerTextDrawBoxColor(playerid,PlayerDamageDraw[playerid],-16777216+PlayerDamageAmout[playerid]);
    	PlayerTextDrawShow(playerid,PlayerDamageDraw[playerid]);
    }
	return 1;
}
/********************************************************/
N::WaitForStreamObjectLoadFinish(playerid,needtime)
{
    TogglePlayerControllable(playerid,0);
    SetTimerEx("UnFreezePlayer",needtime,false,"i",playerid);
	return 1;
}
N::UnFreezePlayer(playerid)
{
    TogglePlayerControllable(playerid,1);
    return 1;
}
