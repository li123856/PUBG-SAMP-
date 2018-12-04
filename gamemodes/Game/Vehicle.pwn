N::Veh@OnPlayerConnect(playerid)
{
    CreatePlayerSpeedoMeter(playerid);
	return 1;
}
N::Veh@OnPlayerDisconnect(playerid,reason)
{
    DestoryPlayerSpeedoMeter(playerid);
	return 1;
}
N::Veh@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
   	{
		if(PRESSED(KEY_FIRE))
		{
			if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
			{
			    new vehicleid=GetPlayerDynamicVehicleID(playerid);
			    new Vid=GetGameVehicleID(pGameID(playerid),vehicleid);
				if(Vid!=NONE)
				{
				    if(gVehicle[pGameID(playerid)][Vid][_VehicleEngine]==false)
				    {
				        if(gVehicle[pGameID(playerid)][Vid][_VehicleFuel]<=0.0)
				        {
				            GameTextForPlayer(playerid, "Car No Fuel ~n~ Can't Turn On...", 3000, 3);
				            return 1;
				        }
				        GameTextForPlayer(playerid, "Car Turn OnIng...", 3000, 3);
				        if(Timer:TurnOnEngineTimer[playerid]!=NONE)KillTimer(Timer:TurnOnEngineTimer[playerid]);
				        Timer:TurnOnEngineTimer[playerid]=NONE;
				        Timer:TurnOnEngineTimer[playerid]=SetTimerEx("PlayerStartSendingCar",3000,false,"ii",playerid,Vid);
				    }
				    else
				    {
				        if(Timer:TurnOnEngineTimer[playerid]!=NONE)KillTimer(Timer:TurnOnEngineTimer[playerid]);
				        Timer:TurnOnEngineTimer[playerid]=NONE;
				        SetDynamicVehicleParamsEx(vehicleid,0,0,0,0,0,0,0);
						gVehicle[pGameID(playerid)][Vid][_VehicleEngine]=false;
						GameTextForPlayer(playerid, "Car Turn Off", 2000, 3);
				    }
				}
			}
		}
	}
	return 1;
}
N::Veh@OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(Online(playerid))
	{
 		if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    	{
    	    if(newstate==PLAYER_STATE_ONFOOT&&(oldstate==PLAYER_STATE_DRIVER||oldstate==PLAYER_STATE_PASSENGER))
    	    {
    	        if(pBuffID[playerid]!=NONE)
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
    	        if(pCacheID[playerid]!=NONE)
    	        {
					if(AddThingToPlayerInventoy(playerid,pCacheID[playerid],1,0,0.0)==INVENTORY_FULL)
					{
					    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
					}
					ClearPlayerCache(playerid);
    	        }
    	    }
    	    if(newstate==PLAYER_STATE_DRIVER&&oldstate==PLAYER_STATE_ONFOOT)
    	    {
    	        if(pBuffID[playerid]!=NONE)
				{
				    if(pBuffCount[playerid]==Item[pBuffID[playerid]][_BuffTime])AddThingToPlayerInventoy(playerid,pBuffID[playerid],1,0,0.0);
				    else ClearPlayerBuff(playerid);
				}
    	        if(pCacheID[playerid]!=NONE)
    	        {
    	            if(pCacheCount[playerid]>0)
    	            {
    	                AddThingToPlayerInventoy(playerid,pCacheID[playerid],1,0,0.0);
    	            	ClearPlayerCache(playerid);
    	            }
    	            else ClearPlayerCache(playerid);
    	        }
    	    }
    	    if(newstate==PLAYER_STATE_PASSENGER&&oldstate==PLAYER_STATE_ONFOOT)
    	    {
    	        if(pBuffID[playerid]!=NONE)
				{
				    if(pBuffCount[playerid]==Item[pBuffID[playerid]][_BuffTime])AddThingToPlayerInventoy(playerid,pBuffID[playerid],1,0,0.0);
				    else ClearPlayerBuff(playerid);
				}
    	        if(pCacheID[playerid]!=NONE)
    	        {
    	            if(pCacheCount[playerid]>0)
    	            {
    	                AddThingToPlayerInventoy(playerid,pCacheID[playerid],1,0,0.0);
    	            	ClearPlayerCache(playerid);
    	            }
    	            else ClearPlayerCache(playerid);
    	        }
    	    }
			if(newstate==PLAYER_STATE_DRIVER||newstate==PLAYER_STATE_PASSENGER)
			{
				if(newstate==PLAYER_STATE_PASSENGER)ShowPlayerSpeedoMeter(playerid);
				else
				{
				    ShowPlayerSpeedoMeter(playerid);
					new vehicleid=GetPlayerDynamicVehicleID(playerid);
					new Vid=GetGameVehicleID(pGameID(playerid),GetPlayerVehicleID(playerid));
					if(Vid!=NONE)
					{
					    if(gVehicle[pGameID(playerid)][Vid][_VehicleEngine]==true)
					    {
					        SetDynamicVehicleParamsEx(vehicleid,1,0,0,0,0,0,0);
					    }
					    else
					    {
					        SetDynamicVehicleParamsEx(vehicleid,0,0,0,0,0,0,0);
				         	GameTextForPlayer(playerid, "Press ~k~~VEHICLE_FIREWEAPON~ To Start The Car", 3000, 3);
					    }
					}
				}
			}
			else
			{
				HidePlayerSpeedoMeter(playerid);
			}
		}
	}
	return 1;
}
N::GetGameVehicleID(gameid,vehicleid)
{
	foreach(new i:gVehicle[gameid])
	{
	    if(gVehicle[gameid][i][_VehicleID]==vehicleid)return i;
	}
	return NONE;
}
N::CreateGameVehicle(gameid,vehiclemodel,Float:_@x,Float:_@y,Float:_@z,Float:_@angle,_@color1,_@color2,interior)
{
    new i=Iter_Free(gVehicle[gameid]);
    gVehicle[gameid][i][_VehicleID]=CreateDynamicVehicle(vehiclemodel,_@x,_@y,_@z,_@angle,_@color1,_@color2,-1,0,GameRoom(gameid),interior,-1,STREAMER_VEHICLE_SD);
    gVehicle[gameid][i][_VehicleKey]=GetTickCount();
    gVehicle[gameid][i][_VehicleFuel]=50.0;
    gVehicle[gameid][i][_VehicleEngine]=false;
    SetDynamicVehicleParamsEx(gVehicle[gameid][i][_VehicleID],0,0,0,0,0,0,0);
    Iter_Add(gVehicle[gameid],i);
    return 0;
}
N::DestoryGameVehicle(gameid,index)
{
    if(Iter_Contains(gVehicle[gameid],index))
    {
		DestroyDynamicVehicle(gVehicle[gameid][index][_VehicleID]);
        Iter_Remove(gVehicle[gameid],index);
    }
	return 1;
}
N::GameVehicleInRange(gameid,Float:_@x,Float:_@y,Float:_@range)
{
	if(Iter_Count(gVehicle[gameid])>0)
	{
	    new Float:vpos[3];
	    foreach(new i:gVehicle[gameid])
	    {
	    	GetDynamicVehiclePos(gVehicle[gameid][i][_VehicleID],vpos[0],vpos[1],vpos[2]);
	        new Float:distancez=GetDistanceBetweenPoints2D(vpos[0],vpos[1],_@x,_@y);
	        if(distancez<_@range)return true;
	    }
    }
	return false;
}

N::CreatePlayerSpeedoMeter(playerid)
{
	PlayerSpeedoMetersDraw[playerid] = CreatePlayerTextDraw(playerid,537.379943, 334.666961, "999");
	PlayerTextDrawLetterSize(playerid,PlayerSpeedoMetersDraw[playerid], 0.362517, 2.889167);
	PlayerTextDrawAlignment(playerid,PlayerSpeedoMetersDraw[playerid], 1);
	PlayerTextDrawColor(playerid,PlayerSpeedoMetersDraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoMetersDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid,PlayerSpeedoMetersDraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,PlayerSpeedoMetersDraw[playerid], 255);
	PlayerTextDrawFont(playerid,PlayerSpeedoMetersDraw[playerid], 2);
	PlayerTextDrawSetProportional(playerid,PlayerSpeedoMetersDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoMetersDraw[playerid], 0);
	//Pos min 537.056274  max 606.0
	PlayerSpeedoArrowDraw[playerid] = CreatePlayerTextDraw(playerid,606.0, 372.784301, "~D~");
	PlayerTextDrawLetterSize(playerid,PlayerSpeedoArrowDraw[playerid], 0.298799, 1.279165);
	PlayerTextDrawAlignment(playerid,PlayerSpeedoArrowDraw[playerid], 1);
	PlayerTextDrawColor(playerid,PlayerSpeedoArrowDraw[playerid], -5963521);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoArrowDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid,PlayerSpeedoArrowDraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,PlayerSpeedoArrowDraw[playerid], 255);
	PlayerTextDrawFont(playerid,PlayerSpeedoArrowDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid,PlayerSpeedoArrowDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoArrowDraw[playerid], 0);
	//TextSize min 543.382629  max 607.8
	PlayerSpeedoBarDraw[playerid]=CreatePlayerTextDraw(playerid,544.382629, 398.300122, "Hp,White");
	PlayerTextDrawLetterSize(playerid,PlayerSpeedoBarDraw[playerid], 0.000000, 0.479873);
	PlayerTextDrawTextSize(playerid,PlayerSpeedoBarDraw[playerid], 609.8, 0.000000);
	PlayerTextDrawAlignment(playerid,PlayerSpeedoBarDraw[playerid], 1);
	PlayerTextDrawColor(playerid,PlayerSpeedoBarDraw[playerid], -1);
	PlayerTextDrawUseBox(playerid,PlayerSpeedoBarDraw[playerid], 1);
	PlayerTextDrawBoxColor(playerid,PlayerSpeedoBarDraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoBarDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid,PlayerSpeedoBarDraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,PlayerSpeedoBarDraw[playerid], 255);
	PlayerTextDrawFont(playerid,PlayerSpeedoBarDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid,PlayerSpeedoBarDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoBarDraw[playerid], 0);
	//TextSize min 537.056274 max  608.0
	PlayerSpeedoFuelBarDraw[playerid] = CreatePlayerTextDraw(playerid,544.738708, 378.249969, "box");
	PlayerTextDrawLetterSize(playerid,PlayerSpeedoFuelBarDraw[playerid], 0.000000, 0.580430);
	PlayerTextDrawTextSize(playerid,PlayerSpeedoFuelBarDraw[playerid], 608.0, 0.000000);
	PlayerTextDrawAlignment(playerid,PlayerSpeedoFuelBarDraw[playerid], 1);
	PlayerTextDrawColor(playerid,PlayerSpeedoFuelBarDraw[playerid], -1);
	PlayerTextDrawUseBox(playerid,PlayerSpeedoFuelBarDraw[playerid], 1);
	PlayerTextDrawBoxColor(playerid,PlayerSpeedoFuelBarDraw[playerid], -216);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoFuelBarDraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid,PlayerSpeedoFuelBarDraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,PlayerSpeedoFuelBarDraw[playerid], 255);
	PlayerTextDrawFont(playerid,PlayerSpeedoFuelBarDraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid,PlayerSpeedoFuelBarDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PlayerSpeedoFuelBarDraw[playerid], 0);
	return 1;
}
N::DestoryPlayerSpeedoMeter(playerid)
{
	if(PlayerSpeedoMetersDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerSpeedoMetersDraw[playerid]);
	if(PlayerSpeedoArrowDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerSpeedoArrowDraw[playerid]);
	if(PlayerSpeedoBarDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerSpeedoBarDraw[playerid]);
	if(PlayerSpeedoFuelBarDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerSpeedoFuelBarDraw[playerid]);
	PlayerSpeedoMetersDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerSpeedoArrowDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerSpeedoBarDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerSpeedoFuelBarDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::ShowPlayerSpeedoMeter(playerid)
{
    forex(i,MAX_SPEEDO_BACKGROUND_DRAWS)TextDrawShowForPlayer(playerid,SpeedoMetersBackGroundDraw[i]);
    PlayerTextDrawShow(playerid,PlayerSpeedoMetersDraw[playerid]);
    PlayerTextDrawShow(playerid,PlayerSpeedoArrowDraw[playerid]);
    PlayerTextDrawShow(playerid,PlayerSpeedoBarDraw[playerid]);
    PlayerTextDrawShow(playerid,PlayerSpeedoFuelBarDraw[playerid]);
	return 1;
}
N::UpdatePlayerSpeedoMeter(playerid)
{
	new line[32];
    new pSpeed=floatround(GetPlayerAllStateSpeed(playerid));
	format(line,sizeof(line),"%i",pSpeed);
	PlayerTextDrawSetString(playerid,PlayerSpeedoMetersDraw[playerid],line);
	new Float:vHealth,vehicleid=GetPlayerDynamicVehicleID(playerid);
	GetDynamicVehicleHealth(vehicleid,vHealth);
    vHealth=floatsub(vHealth,350.0);
    if(vHealth<0.0)vHealth=0.0;
	new Float:BarTextSize=floatmul(floatdiv(vHealth,650.0),65.417371);
	PlayerTextDrawTextSize(playerid,PlayerSpeedoBarDraw[playerid], floatadd(544.382629,BarTextSize), 0.000000);
	PlayerTextDrawShow(playerid,PlayerSpeedoBarDraw[playerid]);
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
        new Vid=GetGameVehicleID(pGameID(playerid),vehicleid);
        if(Vid!=NONE)
        {
            BarTextSize=floatmul(floatdiv(gVehicle[pGameID(playerid)][Vid][_VehicleFuel],50.0),68.943726);
			if(PlayerSpeedoArrowDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerSpeedoArrowDraw[playerid]);
			PlayerSpeedoArrowDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
			
			PlayerSpeedoArrowDraw[playerid] = CreatePlayerTextDraw(playerid,floatadd(537.056274,BarTextSize), 372.784301, "~D~");
			PlayerTextDrawLetterSize(playerid,PlayerSpeedoArrowDraw[playerid], 0.298799, 1.279165);
			PlayerTextDrawAlignment(playerid,PlayerSpeedoArrowDraw[playerid], 1);
			PlayerTextDrawColor(playerid,PlayerSpeedoArrowDraw[playerid], -5963521);
			PlayerTextDrawSetShadow(playerid,PlayerSpeedoArrowDraw[playerid], 0);
			PlayerTextDrawSetOutline(playerid,PlayerSpeedoArrowDraw[playerid], 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerSpeedoArrowDraw[playerid], 255);
			PlayerTextDrawFont(playerid,PlayerSpeedoArrowDraw[playerid], 1);
			PlayerTextDrawSetProportional(playerid,PlayerSpeedoArrowDraw[playerid], 1);
			PlayerTextDrawSetShadow(playerid,PlayerSpeedoArrowDraw[playerid], 0);
			PlayerTextDrawShow(playerid,PlayerSpeedoArrowDraw[playerid]);

			PlayerTextDrawTextSize(playerid,PlayerSpeedoFuelBarDraw[playerid],floatadd(537.056274,BarTextSize+2.5), 0.000000);
			PlayerTextDrawShow(playerid,PlayerSpeedoFuelBarDraw[playerid]);
        }
  	}
	return 1;
}
N::HidePlayerSpeedoMeter(playerid)
{
    forex(i,MAX_SPEEDO_BACKGROUND_DRAWS)TextDrawHideForPlayer(playerid,SpeedoMetersBackGroundDraw[i]);
    if(PlayerSpeedoMetersDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawHide(playerid,PlayerSpeedoMetersDraw[playerid]);
    if(PlayerSpeedoArrowDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawHide(playerid,PlayerSpeedoArrowDraw[playerid]);
    if(PlayerSpeedoBarDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawHide(playerid,PlayerSpeedoBarDraw[playerid]);
   	if(PlayerSpeedoFuelBarDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawHide(playerid,PlayerSpeedoFuelBarDraw[playerid]);
	return 1;
}
N::PlayerSpeedoUpdate(playerid)
{
	if(Online(playerid))
	{
   	    if(IsPlayerInAnyDynamicVehicle(playerid)&&pLastAlive[playerid][_Game_In]==true)UpdatePlayerSpeedoMeter(playerid);
	}
	return 1;
}

