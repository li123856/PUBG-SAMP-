N::Car@OnPlayerDisconnect(playerid,reason)
{
	DestoryPlayerTempCar(playerid,true);
	DsetoryPlayerTempCarSelectGui(playerid);
    CarSelectGui[playerid][_LookID]=0;
	RestPlayerTempCarSelectData(playerid);
	DsetoryPlayerTempCarSelectGui(playerid);
	return 1;
}
N::CreatePlayerTempCar(playerid,model,color0,color1)
{
	if(pCar[playerid][_Vid]!=INVALID_VEHICLE_ID)DestroyDynamicVehicle(pCar[playerid][_Vid]);
	new Float:xyz[4];
	GetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
	GetPlayerFacingAngle(playerid,xyz[3]);
	pCar[playerid][_Vid]=CreateDynamicVehicle(model,xyz[0],xyz[1],xyz[2]+2.0,xyz[3],color0,color1,-1,0,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid),-1,STREAMER_VEHICLE_SD);
	pCar[playerid][_Model]=model;
	pCar[playerid][_Color0]=color0;
	pCar[playerid][_Color1]=color1;
	PutPlayerInDynamicVehicle(playerid,pCar[playerid][_Vid],0);
	SetDynamicVehicleParamsEx(pCar[playerid][_Vid],1,0,0,0,0,0,0);
	SetDynamicVehicleZAngle(pCar[playerid][_Vid],xyz[3]);
	return 1;
}
N::UpdatePlayerTempCar(playerid)
{
	if(pCar[playerid][_Vid]!=INVALID_VEHICLE_ID)
	{
	    if(PlayerInState[playerid]==PLAYER_IN_WAITROOM)
	    {
			SetDynamicVehicleHealth(pCar[playerid][_Vid],1000.0);
			RepairDynamicVehicle(pCar[playerid][_Vid]);
		}
    }
	return 1;
}
N::DestoryPlayerTempCar(playerid,bool:disconnect)
{
	if(pCar[playerid][_Vid]!=INVALID_VEHICLE_ID)
	{
		DestroyDynamicVehicle(pCar[playerid][_Vid]);
		pCar[playerid][_Vid]=INVALID_VEHICLE_ID;
	}
	if(disconnect==true)
	{
		pCar[playerid][_Model]=0;
		pCar[playerid][_Color0]=random(255);
		pCar[playerid][_Color1]=random(255);
	}
	return 1;
}
N::IsUseVehicleEx(model)
{
	forex(i,sizeof(UsedVehicleID))
	{
	    if(UsedVehicleID[i]==model)return 1;
	}
	return 0;
}
N::IsUseVehicle(model)
{
	forex(i,sizeof(UsedVehicleIDEx))
	{
	    if(UsedVehicleIDEx[i]==model)return 1;
	}
	return 0;
}
N::IsTempCar(vehicleid)
{
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
	        if(pCar[i][_Vid]!=INVALID_VEHICLE_ID&&pCar[i][_Vid]==vehicleid)return 1;
	    }
	}
	return 0;
}
N::Car@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerInState[playerid]==PLAYER_IN_WAITROOM)
	{
		if(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
		    new vehicleid=GetPlayerDynamicVehicleID(playerid);
			if(PRESSED(KEY_FIRE))
			{
			    if(IsTempCar(vehicleid))AddDynamicVehicleComponent(vehicleid,1010);
		    }
	    	if(PRESSED(KEY_ANALOG_UP))
		    {
				if(IsTempCar(vehicleid))
				{
				    pCar[playerid][_Color0]++;
				    if(pCar[playerid][_Color0]>255)pCar[playerid][_Color0]=0;
				    ChangeDynamicVehicleColor(pCar[playerid][_Vid],pCar[playerid][_Color0],pCar[playerid][_Color1]);
				}
			}
			if(PRESSED(KEY_ANALOG_DOWN))
			{
				if(IsTempCar(vehicleid))
				{
				    pCar[playerid][_Color1]++;
				    if(pCar[playerid][_Color1]>255)pCar[playerid][_Color1]=0;
	    			ChangeDynamicVehicleColor(pCar[playerid][_Vid],pCar[playerid][_Color0],pCar[playerid][_Color1]);
				}
			}
		}
		if(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
		{
			if(PRESSED(KEY_YES))
			{
				if(CarSelectGui[playerid][_Show]==false)
				{
					CreatePlayerTempCarSelectGui(playerid);
					SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEMPCAR_MSG1));
				}
				else DsetoryPlayerTempCarSelectGui(playerid);
			}
			if(PRESSED(KEY_FIRE))if(CarSelectGui[playerid][_Show]==true)UpdatePlayerTempCarSelectGui(playerid,true);
			if(PRESSED(KEY_HANDBRAKE))if(CarSelectGui[playerid][_Show]==true)UpdatePlayerTempCarSelectGui(playerid,false);
			if(PRESSED(KEY_SECONDARY_ATTACK))
			{
				if(CarSelectGui[playerid][_Show]==true)
				{
				    CreateTempCar(playerid,UsedVehicleID[CarSelectGui[playerid][_SelectID][3]],pCar[playerid][_Color0],pCar[playerid][_Color1]);
				    DsetoryPlayerTempCarSelectGui(playerid);
				}
			}
		}
	}
	return 1;
}
N::Car@OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(PlayerInState[playerid]==PLAYER_IN_WAITROOM)
	{
		if(newstate==PLAYER_STATE_DRIVER)
		{
			new vehicleid=GetPlayerDynamicVehicleID(playerid);
		    if(IsTempCar(vehicleid))
			{
			    if(pCar[playerid][_Vid]!=INVALID_VEHICLE_ID&&pCar[playerid][_Vid]==vehicleid)
				{
				    SetDynamicVehicleParamsEx(vehicleid,1,0,0,0,0,0,0);
					fLine_128(ReturnMLStr(pLang(playerid),_CAR_MSG1),VehName[pCar[playerid][_Model]-400]);
	       			SCM(playerid,-1,line);
				}
			    else
			    {
			        new Float:xyz[3];
			        GetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
			        SetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]+0.5);
			    }
			}
			if(CarSelectGui[playerid][_Show]==true)DsetoryPlayerTempCarSelectGui(playerid);
		}
	    if(oldstate==PLAYER_STATE_DRIVER)
		{
		    if(pCar[playerid][_Vid]!=INVALID_VEHICLE_ID)
			{
				SetDynamicVehParamsForPlayer(pCar[playerid][_Vid],playerid,1,0);
			}
		}
	}
	return 1;
}
N::CreateTempCar(playerid,model,color0,color1)
{
	/*new model,color0,color1;
	if(sscanf(params, "iD(0)D(0)",model,color0,color1))
	{
	    if(pCar[playerid][_Model]==0)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_VEHICLE_MSG1));
	    else CreatePlayerTempCar(playerid,pCar[playerid][_Model],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	    return 1;
	}*/
    //if(!IsUseVehicleEx(model))return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_VEHICLE_MSG2));
    if(PlayerInState[playerid]!=PLAYER_IN_WAITROOM)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_VEHICLE_MSG3));
	CreatePlayerTempCar(playerid,model,color0,color1);
	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_VEHICLE_MSG4));
	return 1;
}
public OnDynamicVehicleStreamIn(vehicleid, forplayerid)
{
    if(Online(forplayerid))
    {
	    if(pCar[forplayerid][_Vid]!=INVALID_VEHICLE_ID&&pCar[forplayerid][_Vid]==vehicleid)SetDynamicVehParamsForPlayer(vehicleid,forplayerid,1,0);
		else SetDynamicVehParamsForPlayer(vehicleid,forplayerid,0,0);
    }
	return 1;
}

N::RestPlayerTempCarSelectData(playerid)
{
	forex(i,7)CarSelectGui[playerid][_SelectID][i]=NONE;
	new index=0;
	forex(i,7)
	{
	    index=CarSelectGui[playerid][_LookID]-3+i;
		if(index>=sizeof(UsedVehicleID)||index<0)CarSelectGui[playerid][_SelectID][i]=NONE;
		else CarSelectGui[playerid][_SelectID][i]=index;
	}
	return 1;
}
N::UpdatePlayerTempCarSelectGui(playerid,bool:order)
{
	if(CarSelectGui[playerid][_Show]==true)
	{
		if(order==true)
		{
		    CarSelectGui[playerid][_LookID]++;
		    if(CarSelectGui[playerid][_LookID]>=sizeof(UsedVehicleID))CarSelectGui[playerid][_LookID]--;
		    else
		    {
				forex(i,7)
				{
				    new index=0;
				    index=CarSelectGui[playerid][_LookID]-3+i;
					if(index>=sizeof(UsedVehicleID)||index<0)
					{
						CarSelectGui[playerid][_SelectID][i]=NONE;
						PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][i], NULL_MODEL);
						PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][i],pCar[playerid][_Color0],pCar[playerid][_Color1]);
						PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][i]);
	                }
					else
					{
						CarSelectGui[playerid][_SelectID][i]=index;
						PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][i], UsedVehicleID[index]);
						PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][i],pCar[playerid][_Color0],pCar[playerid][_Color1]);
						PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][i]);
					}
				}
		    }
		}
		else
		{
		    CarSelectGui[playerid][_LookID]--;
		    if(CarSelectGui[playerid][_LookID]<0)CarSelectGui[playerid][_LookID]++;
		    else
		    {
		        new index=0;
				forex(i,7)
				{
				    index=CarSelectGui[playerid][_LookID]-3+i;
					if(index>=sizeof(UsedVehicleID)||index<0)
					{
						CarSelectGui[playerid][_SelectID][i]=NONE;
						PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][i], NULL_MODEL);
						PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][i],pCar[playerid][_Color0],pCar[playerid][_Color1]);
						PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][i]);
	                }
					else
					{
						CarSelectGui[playerid][_SelectID][i]=index;
						PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][i], UsedVehicleID[index]);
						PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][i],pCar[playerid][_Color0],pCar[playerid][_Color1]);
						PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][i]);
					}
				}
		    }
		}
	}
	return 1;
}
N::DsetoryPlayerTempCarSelectGui(playerid)
{
	CarSelectGui[playerid][_Show]=false;
	forex(i,7)
	{
	    if(CarSelectGui[playerid][_SelectDraw][i]!=PlayerText:INVALID_TEXT_DRAW)
	    {
	    	PlayerTextDrawDestroy(playerid,CarSelectGui[playerid][_SelectDraw][i]);
	    	CarSelectGui[playerid][_SelectDraw][i]=PlayerText:INVALID_TEXT_DRAW;
		}
	}
	RestPlayerTempCarSelectData(playerid);
	forex(i,6)TextDrawHideForPlayer(playerid,TempCarSelectGui[i]);
	return 1;
}
N::TempCarSelectGuiInt()
{
	TempCarSelectGui[0] = TextDrawCreate(314.000000, 224.000000, "~d~");
	TextDrawFont(TempCarSelectGui[0], 1);
	TextDrawLetterSize(TempCarSelectGui[0], 0.850000, 2.749994);
	TextDrawTextSize(TempCarSelectGui[0], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[0], 1);
	TextDrawSetShadow(TempCarSelectGui[0], 0);
	TextDrawAlignment(TempCarSelectGui[0], 1);
	TextDrawColor(TempCarSelectGui[0], -1);
	TextDrawBackgroundColor(TempCarSelectGui[0], 255);
	TextDrawBoxColor(TempCarSelectGui[0], 50);
	TextDrawUseBox(TempCarSelectGui[0], 0);
	TextDrawSetProportional(TempCarSelectGui[0], 1);
	TextDrawSetSelectable(TempCarSelectGui[0], 0);

	TempCarSelectGui[1] = TextDrawCreate(325.000000, 201.000000, "F");
	TextDrawFont(TempCarSelectGui[1], 2);
	TextDrawLetterSize(TempCarSelectGui[1], 0.891664, 2.649996);
	TextDrawTextSize(TempCarSelectGui[1], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[1], 1);
	TextDrawSetShadow(TempCarSelectGui[1], 0);
	TextDrawAlignment(TempCarSelectGui[1], 2);
	TextDrawColor(TempCarSelectGui[1], 16711935);
	TextDrawBackgroundColor(TempCarSelectGui[1], 255);
	TextDrawBoxColor(TempCarSelectGui[1], 50);
	TextDrawUseBox(TempCarSelectGui[1], 0);
	TextDrawSetProportional(TempCarSelectGui[1], 1);
	TextDrawSetSelectable(TempCarSelectGui[1], 0);

	TempCarSelectGui[2] = TextDrawCreate(27.000000, 283.000000, "~<~");
	TextDrawFont(TempCarSelectGui[2], 1);
	TextDrawLetterSize(TempCarSelectGui[2], 0.850000, 2.749994);
	TextDrawTextSize(TempCarSelectGui[2], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[2], 1);
	TextDrawSetShadow(TempCarSelectGui[2], 0);
	TextDrawAlignment(TempCarSelectGui[2], 1);
	TextDrawColor(TempCarSelectGui[2], -1);
	TextDrawBackgroundColor(TempCarSelectGui[2], 255);
	TextDrawBoxColor(TempCarSelectGui[2], 50);
	TextDrawUseBox(TempCarSelectGui[2], 0);
	TextDrawSetProportional(TempCarSelectGui[2], 1);
	TextDrawSetSelectable(TempCarSelectGui[2], 0);

	TempCarSelectGui[3] = TextDrawCreate(592.000000, 283.000000, "~>~");
	TextDrawFont(TempCarSelectGui[3], 1);
	TextDrawLetterSize(TempCarSelectGui[3], 0.850000, 2.749994);
	TextDrawTextSize(TempCarSelectGui[3], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[3], 1);
	TextDrawSetShadow(TempCarSelectGui[3], 0);
	TextDrawAlignment(TempCarSelectGui[3], 1);
	TextDrawColor(TempCarSelectGui[3], -1);
	TextDrawBackgroundColor(TempCarSelectGui[3], 255);
	TextDrawBoxColor(TempCarSelectGui[3], 50);
	TextDrawUseBox(TempCarSelectGui[3], 0);
	TextDrawSetProportional(TempCarSelectGui[3], 1);
	TextDrawSetSelectable(TempCarSelectGui[3], 0);

	TempCarSelectGui[4] = TextDrawCreate(13.000000, 291.000000, "RMB");
	TextDrawFont(TempCarSelectGui[4], 2);
	TextDrawLetterSize(TempCarSelectGui[4], 0.220833, 1.299998);
	TextDrawTextSize(TempCarSelectGui[4], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[4], 1);
	TextDrawSetShadow(TempCarSelectGui[4], 0);
	TextDrawAlignment(TempCarSelectGui[4], 2);
	TextDrawColor(TempCarSelectGui[4], -1);
	TextDrawBackgroundColor(TempCarSelectGui[4], 255);
	TextDrawBoxColor(TempCarSelectGui[4], 50);
	TextDrawUseBox(TempCarSelectGui[4], 0);
	TextDrawSetProportional(TempCarSelectGui[4], 1);
	TextDrawSetSelectable(TempCarSelectGui[4], 0);

	TempCarSelectGui[5] = TextDrawCreate(626.000000, 291.000000, "LMB");
	TextDrawFont(TempCarSelectGui[5], 2);
	TextDrawLetterSize(TempCarSelectGui[5], 0.220833, 1.299998);
	TextDrawTextSize(TempCarSelectGui[5], 400.000000, 17.000000);
	TextDrawSetOutline(TempCarSelectGui[5], 1);
	TextDrawSetShadow(TempCarSelectGui[5], 0);
	TextDrawAlignment(TempCarSelectGui[5], 2);
	TextDrawColor(TempCarSelectGui[5], -1);
	TextDrawBackgroundColor(TempCarSelectGui[5], 255);
	TextDrawBoxColor(TempCarSelectGui[5], 50);
	TextDrawUseBox(TempCarSelectGui[5], 0);
	TextDrawSetProportional(TempCarSelectGui[5], 1);
	TextDrawSetSelectable(TempCarSelectGui[5], 0);
	return 1;
}
N::CreatePlayerTempCarSelectGui(playerid)
{
    DsetoryPlayerTempCarSelectGui(playerid);
    forex(i,6)TextDrawShowForPlayer(playerid,TempCarSelectGui[i]);
	CarSelectGui[playerid][_SelectDraw][4] = CreatePlayerTextDraw(playerid, 384.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][4], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][4], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][4], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][4], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][4], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][4], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][4], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][4], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][4], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][4], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][4], 0);
	if(CarSelectGui[playerid][_SelectID][4]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][4], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][4], UsedVehicleID[CarSelectGui[playerid][_SelectID][4]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][4], -10.000000, 0.000000, -40.000000, 0.779999);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][4],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][4]);

	CarSelectGui[playerid][_SelectDraw][5] = CreatePlayerTextDraw(playerid, 455.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][5], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][5], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][5], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][5], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][5], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][5], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][5], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][5], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][5], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][5], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][5], 0);
	if(CarSelectGui[playerid][_SelectID][5]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][5], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][5], UsedVehicleID[CarSelectGui[playerid][_SelectID][5]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][5], -10.000000, 0.000000, -40.000000, 0.779999);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][5],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][5]);

	CarSelectGui[playerid][_SelectDraw][6] = CreatePlayerTextDraw(playerid, 526.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][6], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][6], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][6], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][6], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][6], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][6], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][6], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][6], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][6], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][6], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][6], 0);
	if(CarSelectGui[playerid][_SelectID][6]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][6], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][6], UsedVehicleID[CarSelectGui[playerid][_SelectID][6]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][6], -10.000000, 0.000000, -40.000000, 0.779999);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][6],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][6]);

	CarSelectGui[playerid][_SelectDraw][3] = CreatePlayerTextDraw(playerid, 262.000000, 229.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][3], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][3], 121.500000, 132.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][3], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][3], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][3], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][3], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][3], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][3], -256);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][3], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][3], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][3], 0);
	if(CarSelectGui[playerid][_SelectID][3]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][3], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][3], UsedVehicleID[CarSelectGui[playerid][_SelectID][3]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][3], -10.000000, 0.000000, -40.000000, 0.909999);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][3],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][3]);

	CarSelectGui[playerid][_SelectDraw][2] = CreatePlayerTextDraw(playerid, 191.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][2], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][2], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][2], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][2], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][2], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][2], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][2], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][2], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][2], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][2], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][2], 0);
	if(CarSelectGui[playerid][_SelectID][2]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][2], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][2], UsedVehicleID[CarSelectGui[playerid][_SelectID][2]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][2], -10.000000, 0.000000, -40.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][2],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][2]);

	CarSelectGui[playerid][_SelectDraw][1] = CreatePlayerTextDraw(playerid, 120.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][1], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][1], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][1], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][1], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][1], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][1], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][1], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][1], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][1], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][1], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][1], 0);
	if(CarSelectGui[playerid][_SelectID][1]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][1], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][1], UsedVehicleID[CarSelectGui[playerid][_SelectID][1]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][1], -10.000000, 0.000000, -40.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][1],pCar[playerid][_Color0],pCar[playerid][_Color1]);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][1]);

	CarSelectGui[playerid][_SelectDraw][0] = CreatePlayerTextDraw(playerid, 49.000000, 264.000000, " ");
	PlayerTextDrawFont(playerid, CarSelectGui[playerid][_SelectDraw][0], 5);
	PlayerTextDrawLetterSize(playerid, CarSelectGui[playerid][_SelectDraw][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, CarSelectGui[playerid][_SelectDraw][0], 70.000000, 62.000000);
	PlayerTextDrawSetOutline(playerid, CarSelectGui[playerid][_SelectDraw][0], 1);
	PlayerTextDrawSetShadow(playerid, CarSelectGui[playerid][_SelectDraw][0], 2);
	PlayerTextDrawAlignment(playerid, CarSelectGui[playerid][_SelectDraw][0], 1);
	PlayerTextDrawColor(playerid, CarSelectGui[playerid][_SelectDraw][0], -1);
	PlayerTextDrawBackgroundColor(playerid, CarSelectGui[playerid][_SelectDraw][0], 0);
	PlayerTextDrawBoxColor(playerid, CarSelectGui[playerid][_SelectDraw][0], 0);
	PlayerTextDrawUseBox(playerid, CarSelectGui[playerid][_SelectDraw][0], 1);
	PlayerTextDrawSetProportional(playerid, CarSelectGui[playerid][_SelectDraw][0], 1);
	PlayerTextDrawSetSelectable(playerid, CarSelectGui[playerid][_SelectDraw][0], 0);
	if(CarSelectGui[playerid][_SelectID][0]==NONE)PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][0], NULL_MODEL);
	else PlayerTextDrawSetPreviewModel(playerid, CarSelectGui[playerid][_SelectDraw][0], UsedVehicleID[CarSelectGui[playerid][_SelectID][0]]);
	PlayerTextDrawSetPreviewRot(playerid, CarSelectGui[playerid][_SelectDraw][0], -10.000000, 0.000000, -40.000000, 0.780000);
	PlayerTextDrawSetPreviewVehCol(playerid, CarSelectGui[playerid][_SelectDraw][0], 1, 1);
	PlayerTextDrawShow(playerid, CarSelectGui[playerid][_SelectDraw][0]);
	CarSelectGui[playerid][_Show]=true;
	return 1;
}
