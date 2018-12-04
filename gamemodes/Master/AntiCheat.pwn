N::Anti@OnPlayerConnect(playerid)
{
	Dialog@Rest(playerid);
    LastTimeWeapon[playerid]=0;
    forex(s,12)LastTimeAmmo[playerid][s]=0;
    
    LastTimeAnimIndex[playerid]=0;
    HideAttach[playerid]=false;
    
	pCBugging[playerid]=false;
	Timer:pCBugFreezeOver[playerid]=NONE;
	pLastFiredWeaponTick[playerid]=0;
	
	PauseTime[playerid]=0;
	
 	NoReloadInfractions[playerid]=0;
	ShotCounter[playerid]=0;
	SkillLevel[playerid]=999;
	RapidInfractions[playerid]=0;
	LastShotTick[playerid]=0;
	LastCrouchTick[playerid]=0;
	
	pFPSOpen[playerid]=true;
	TogglePlayerStreamItemForFPS(playerid,pFPSOpen[playerid]);
	return 1;
}
N::Anti@OnPlayerDisconnect(playerid,reason)
{
    LastTimeWeapon[playerid]=0;
    forex(s,12)LastTimeAmmo[playerid][s]=0;
    
    LastTimeAnimIndex[playerid]=0;
    HideAttach[playerid]=false;
    
	pCBugging[playerid]=false;
	if(Timer:pCBugFreezeOver[playerid]!=NONE)
	{
		KillTimer(Timer:pCBugFreezeOver[playerid]);
		Timer:pCBugFreezeOver[playerid]=NONE;
	}
	Timer:pCBugFreezeOver[playerid]=NONE;
	pLastFiredWeaponTick[playerid]=0;
	
	PauseTime[playerid]=0;

 	NoReloadInfractions[playerid]=0;
	ShotCounter[playerid]=0;
	SkillLevel[playerid]=999;
	RapidInfractions[playerid]=0;
	LastShotTick[playerid]=0;
	LastCrouchTick[playerid]=0;

	pFPSOpen[playerid]=true;
	
	Dialog@Close(playerid);
	return 1;
}
N::Anti@OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(GetServerTickRate()<100)return 1;
	new	magsize = WeaponMagSizes[weaponid-22],weaponstate=GetPlayerWeaponState(playerid);
	ShotCounter[playerid]++;
	if(SkillLevel[playerid] == 999)
	{
		if(weaponid==22||weaponid==26||weaponid==28||weaponid==32)magsize*=2;
	}
	if(ShotCounter[playerid]==magsize&&magsize>1)
	{
		if(weaponstate!=1)
		{
			NoReloadInfractions[playerid]++;
			if(NoReloadInfractions[playerid]==MAX_NORELOAD_INFRACTIONS)
			{
			    NoReloadInfractions[playerid]=0;
				AddPlayerCheatLog(playerid,"无限弹药,已T出");
				SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG6));
				printf("%s 武器:%i 次数:%i",Account[playerid][_Name],weaponid,ShotCounter[playerid]);
				//SetTimerEx("DelayKicke",100,false,"i",playerid);
		        return 0;
			}
		}
		else ShotCounter[playerid]=0;
		return 0;
	}
	
	new	interval=GetTickCountDifference(LastShotTick[playerid],GetTickCount()),weaponshotinterval=WeaponShotIntervals[weaponid-22]-20;
	if(SkillLevel[playerid]==999)
	{
		switch(weaponid)
		{
			case 22:weaponshotinterval=185;
			case 26:weaponshotinterval=140;
			case 28:weaponshotinterval=35;
			case 32:weaponshotinterval=35;
		}
	}
	if(weaponid==24)
	{
		if(GetTickCountDifference(LastCrouchTick[playerid],GetTickCount())<600)weaponshotinterval=100;
	}
	if(interval<weaponshotinterval)
	{
		RapidInfractions[playerid]++;
		if(RapidInfractions[playerid]==MAX_RAPIDFIRE_INFRACTIONS)
		{
			RapidInfractions[playerid]=0;
			AddPlayerCheatLog(playerid,"速射,已T出");
			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG7));
			printf("%s 武器:%i 速度:%i",Account[playerid][_Name],weaponid,interval);
			//SetTimerEx("DelayKicke",100,false,"i",playerid);
	        return 0;
		}
		return 0;
	}
	LastShotTick[playerid]=GetTickCount();
	return 1;
}
N::Anti@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys&KEY_CROUCH)LastCrouchTick[playerid]=GetTickCount();
	if(!pCBugging[playerid]&&GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_FIRE))
		{
			switch(GetPlayerWeapon(playerid))
			{
				case WEAPON_DEAGLE,WEAPON_SHOTGUN,WEAPON_SNIPER:
				{
					pLastFiredWeaponTick[playerid]=gettime();
				}
			}
		}
		else if(PRESSED(KEY_CROUCH))
		{
			if((gettime()-pLastFiredWeaponTick[playerid])<1)
			{
				TogglePlayerControllable(playerid,false);
				pCBugging[playerid]=true;
				GameTextForPlayer(playerid,"~r~~h~DON'T C-BUG!",3000,4);
				if(Timer:pCBugFreezeOver[playerid]!=NONE)
				{
					KillTimer(Timer:pCBugFreezeOver[playerid]);
					Timer:pCBugFreezeOver[playerid]=NONE;
				}
				Timer:pCBugFreezeOver[playerid]=SetTimerEx("CBugFreezeOver",1500,false,"i",playerid);
			}
		}
	}
	return 1;
}
N::ChackPlayerUnderGround(playerid)
{
	if(!IsPlayerSkydiving(playerid)&&!IsPlayerUsingParachute(playerid))
	{
		new Float:_@X=PlayerPos[playerid][_X],Float:_@Y=PlayerPos[playerid][_Y],Float:_@Z=PlayerPos[playerid][_Z],Float:_@A=PlayerPos[playerid][_A],Float:_@Zex=_@Z+0.5;

		new Flags=GetPointCollisionFlags(_@X,_@Y,_@Zex,0);
	    if(!CA_IsPlayerBlockedEx(1.5,0.5,_@X,_@Y,_@Z,_@A)&&!CA_IsPlayerOnSurfaceEx(2.0,_@X,_@Y,_@Z)&&IsCollisionFlag(Flags,POSITION_FLAG_UNDERGROUND)&&!IsCollisionFlag(Flags,POSITION_FLAG_WATER)&&!IsCollisionFlag(Flags,POSITION_FLAG_AIR))
	   	{
			Tryg3D::MapAndreasFindZ(_@X,_@Y,_@Z);
	        SetPlayerPos(playerid,_@X,_@Y,_@Z+0.5);
	        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG4));
			AddPlayerCheatLog(playerid,"可能穿墙了");
	    }
    }
	return 1;
}
stock CA_IsPlayerOnSurfaceEx(Float:tolerance=1.5,Float:x,Float:y,Float:z)
{
	if(!CA_RayCastLine(x, y, z, x, y, z-tolerance, x, y, z))return 0;
	return 1;
}
stock CA_IsPlayerBlockedEx(Float:dist=1.5, Float:height=0.5,Float:x,Float:y,Float:z,Float:fa)
{
	new Float:endx, Float:endy;
	z -= 1.0 + height;
	endx = (x + dist * floatsin(-fa,degrees));
	endy = (y + dist * floatcos(-fa,degrees));
	if(CA_RayCastLine(x, y, z, endx, endy, z, x, y, z))return 1;
	return 0;
}
new bool:DialogProtect_Opened[MAX_PLAYERS];
new DialogProtect_Key[MAX_PLAYERS];
new DialogProtect_Tick[MAX_PLAYERS];
N::Dialog@IsOpen(playerid)return DialogProtect_Opened[playerid];
N::Dialog@GetIndex(playerid)
{
	if(!DialogProtect_Opened[playerid])return NONE;
	return DialogProtect_Key[playerid];
}
N::Dialog@Rest(playerid)
{
    DialogProtect_Opened[playerid]=false;
	DialogProtect_Key[playerid]=NONE;
	DialogProtect_Tick[playerid]=0;
	return 1;
}
N::Dialog@Close(playerid)
{
    DialogProtect_Opened[playerid]=false;
	DialogProtect_Key[playerid]=NONE;
	DialogProtect_Tick[playerid]=0;
	ShowPlayerDialog(playerid,-1,DIALOG_STYLE_MSGBOX," ", " ", " ", "");
	return 1;
}
N::Dialog@Show(playerid,dialogid,style,caption[],info[],button1[],button2[])
{
	DialogProtect_Key[playerid]=dialogid;
	DialogProtect_Opened[playerid]=true;
	DialogProtect_Tick[playerid]=GetTickCount();
	ShowPlayerDialog(playerid,dialogid,style,caption,info,button1,button2);
	return 1;
}
N::IsPlayerNearBounds(playerid,Float:x,Float:y)
{
	switch(PlayerInState[playerid])
    {
        //SetPlayerWorldBounds(playerid,0.0,-2950.0,0.0,-2950.0);
		case PLAYER_IN_WAITROOM:
        {
            if(x>-50.0||x<-2900.0)return 1;
            if(y>-50.0||y<-2900.0)return 1;
        }
        //SetPlayerWorldBounds(s,3000.0,-3000.0,3000.0,-3000.0);
		case PLAYER_IN_GAMEROOM:
        {
            if(x>2950.0||x<-2950.0)return 1;
            if(y>2950.0||y<-2950.0)return 1;
        }
	}
	return 0;
}
stock GetSpeedForDistance(Float:distance,&Float:speed,rtime)
{
	if(rtime/1000.0<=0.0)speed=INVALID_MOVE_SPEED;
	else speed=floatdiv(distance,floatdiv(rtime,1000.0));
}
N::AntiCheat@ChackPlayerSpeed(playerid,Float:x,Float:y,Float:z,PlayerSpeed,time)
{
	if(PosChange[playerid]==false)
	{
	    if(GetTickCount()-ReturnsLastStop(playerid)> 1000+GetPlayerPing(playerid)*5)
	    {
	        if(!IsPlayerSpawned(playerid))return 1;
	        if(IsPlayerDying(playerid))return 1;
	        if(pLastAlive[playerid][_Game_SpectatePlane])return 1;
	        if(IsPlayerSkydiving(playerid)||IsPlayerUsingParachute(playerid))return 1;
	        if(PlayerInState[playerid]==PLAYER_IN_INTERFACE||PlayerInState[playerid]==PLAYER_IN_WAITROOM||PlayerInState[playerid]==PLAYER_IN_GAMEROOM)
	        {
				if(GetPlayerSurfingDynamicVehID(playerid)==INVALID_STREAMER_ID&&GetPlayerSurfingVehicleID(playerid)==INVALID_VEHICLE_ID&&GetPlayerSurfingObjectID(playerid)==INVALID_OBJECT_ID)
				{
					new Float:Speed,Float:Zdiff,Float:ZSpeed;
					switch(GetPlayerState(playerid))
			        {
						case PLAYER_STATE_NONE:
						{
						}
			            case PLAYER_STATE_ONFOOT:
						{
							GetSpeedForMoveTime2D(x,y,PlayerPos[playerid][_X],PlayerPos[playerid][_Y],Speed,time);
							if(GetPlayerAnimationIndex(playerid)!=1132&&Speed>35.0)
							{
							    if(!IsPlayerNearBounds(playerid,x,y))
							    {
				        			AddPlayerCheatLog(playerid,"步行超速,已T出");
				        			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG2));
									printf("%s Speed:%f",Account[playerid][_Name],Speed);
									SetTimerEx("DelayKicke",100,false,"i",playerid);
								}
							}
							Zdiff=floatsub(z,PlayerPos[playerid][_Z]);
							if(Zdiff>0.0)
							{
							    GetSpeedForDistance(Zdiff,ZSpeed,200);
							    if(ZSpeed>15.0)
								{
				        			AddPlayerCheatLog(playerid,"步行Z超速,已T出");
				        			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG8));
									printf("步行Z %s 差值:%f  速度:%f",Account[playerid][_Name],Zdiff,ZSpeed);
									SetTimerEx("DelayKicke",100,false,"i",playerid);
                                }
							}
						}
			            case PLAYER_STATE_DRIVER:
						{
							GetSpeedForMoveTime2D(x,y,PlayerPos[playerid][_X],PlayerPos[playerid][_Y],Speed,time);
							if(Speed>300.0)
							{
							    if(!IsPlayerNearBounds(playerid,x,y))
							    {
				        			AddPlayerCheatLog(playerid,"驾驶超速1,已T出");
									SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG2));
									printf("%s Speed:%f",Account[playerid][_Name],Speed);
									SetTimerEx("DelayKicke",100,false,"i",playerid);
								}
							}
							if(PlayerSpeed-PlayerPos[playerid][_LastSpeed]>30)
							{
							    if(!IsPlayerNearBounds(playerid,x,y))
							    {
				        			AddPlayerCheatLog(playerid,"驾驶超速2,已T出");
									SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG2));
									printf("%s ,NewSpeed %i ,OldSpeed %i , SpeedDeff:%i",Account[playerid][_Name],PlayerSpeed,PlayerPos[playerid][_LastSpeed],PlayerSpeed-PlayerPos[playerid][_LastSpeed]);
									SetTimerEx("DelayKicke",100,false,"i",playerid);
								}
							}
							Zdiff=floatsub(z,PlayerPos[playerid][_Z]);
							if(Zdiff>0)
							{
							    GetSpeedForDistance(Zdiff,ZSpeed,200);
							    if(ZSpeed>30.0)
								{
				        			AddPlayerCheatLog(playerid,"驾驶Z超速,已T出");
				        			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG9));
									printf("驾驶Z %s 差值:%f  速度:%f",Account[playerid][_Name],Zdiff,ZSpeed);
									SetTimerEx("DelayKicke",100,false,"i",playerid);
                                }
							}
						}
			            case PLAYER_STATE_PASSENGER:
						{
							GetSpeedForMoveTime2D(x,y,PlayerPos[playerid][_X],PlayerPos[playerid][_Y],Speed,time);
							if(Speed>250.0)
							{

							}
						}
			            case PLAYER_STATE_WASTED:
			            {
			            }
			            case PLAYER_STATE_SPAWNED:
			            {
			            }
			            case PLAYER_STATE_SPECTATING:
			            {
			            }
			            case PLAYER_STATE_EXIT_VEHICLE:
			            {
			            }
						case PLAYER_STATE_ENTER_VEHICLE_DRIVER:
						{
						}
						case PLAYER_STATE_ENTER_VEHICLE_PASSENGER:
						{
						}
			   		}
		   		}
	   		}
		}
    }
    return 1;
}
new SpeakSpeedWarn[MAX_PLAYERS];
new SpeakSpeed[MAX_PLAYERS];
new SpeakBodyWarn[MAX_PLAYERS];
new SpeakBody[MAX_PLAYERS][144];
new bool:SpeakSave[MAX_PLAYERS];
N::bool:AntiCheat@ChackPlayerText(playerid, text[])
{
    if(strlen(text)<1||strlen(text)>100)
	{
	    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_SAY_MSG1));
		return true;
	}
	if(GetTickCount()-SpeakSpeed[playerid]<1000)
	{
	    if(Account[playerid][_Mute]<=SERVER_RUNTIME)
	    {
			SpeakSpeedWarn[playerid]++;
			if(SpeakSpeedWarn[playerid]>=3)
		    {
		        Account[playerid][_Mute]=SERVER_RUNTIME+10;
		        Update@AccountMute(playerid,Account[playerid][_Mute]);
				AddPlayerCheatLog(playerid,"语速过快,被禁言 10 分钟");
		        return true;
		    }
		    fLine_128(ReturnMLStr(pLang(playerid),_SPEAK_WARN1),SpeakSpeedWarn[playerid],3);
	        SCM(playerid,-1,line);
	        SpeakSpeedWarn[playerid]=GetTickCount();
	        return true;
        }
	    else
	    {
			SpeakSpeedWarn[playerid]++;
			if(SpeakSpeedWarn[playerid]>=3)
		    {
        		AddPlayerCheatLog(playerid,"语速过快,已T出");
				SetTimerEx("DelayKicke",100,false,"i",playerid);
	        	return true;
		    }
	        SpeakSpeed[playerid]=GetTickCount();
        }
	}
	else
	{
    	if(Account[playerid][_Mute]>SERVER_RUNTIME)return false;
    	SpeakSpeed[playerid]=GetTickCount();
    	SpeakSpeedWarn[playerid]=0;
    }
    if(Account[playerid][_Mute]>SERVER_RUNTIME)return false;
 	if(SpeakSave[playerid]==false)
	{
	    format(SpeakBody[playerid],128,text);
	    SpeakSave[playerid]=true;
	}
	else
	{
	    if(!strcmp(text,SpeakBody[playerid],false))
	    {
	        SpeakBodyWarn[playerid]++;
	        if(SpeakBodyWarn[playerid]>=3)
	        {
		        Account[playerid][_Mute]=SERVER_RUNTIME+10;
		        Update@AccountMute(playerid,Account[playerid][_Mute]);
				AddPlayerCheatLog(playerid,"重复说话,被禁言 10 分钟");
		        return true;
	        }
	        fLine_128(ReturnMLStr(pLang(playerid),_SPEAK_WARN2),SpeakBodyWarn[playerid],3);
        	SCM(playerid,-1,line);
        	return true;
	    }
	    else
	    {
		    format(SpeakBody[playerid],144,text);
		    SpeakSave[playerid]=true;
		    SpeakBodyWarn[playerid]=0;
	    }
	}
	return false;
}
enum _WeaponInfo
{
	_WeaponDalay
};
new WeaponInfo[MAX_PLAYERS][13][_WeaponInfo];
stock AC@GivePlayerWeapon(playerid,weaponid,ammo)
{
    WeaponInfo[playerid][WeaponSlot(weaponid)][_WeaponDalay]=GetTickCount()+GetPlayerPing(playerid)*15;
    GivePlayerWeapon(playerid,weaponid,ammo);
	return 1;
}
#if defined _ALS_GivePlayerWeapon
	#undef GivePlayerWeapon
#else
	#define _ALS_GivePlayerWeapon
#endif
#define GivePlayerWeapon AC@GivePlayerWeapon
stock AC@SetPlayerAmmo(playerid,weaponslot,ammo)
{
	WeaponInfo[playerid][WeaponSlot(weaponslot)][_WeaponDalay]=GetTickCount()+GetPlayerPing(playerid)*15;
	SetPlayerAmmo(playerid,weaponslot,ammo);
	return 1;
}
#if defined _ALS_SetPlayerAmmo
	#undef SetPlayerAmmo
#else
	#define _ALS_SetPlayerAmmo
#endif
#define SetPlayerAmmo AC@SetPlayerAmmo

stock AC@ResetPlayerWeaponsEx(playerid)
{
	forex(i,13)
	{
    	WeaponInfo[playerid][i][_WeaponDalay]=GetTickCount()+GetPlayerPing(playerid)*15;
	}
	ResetPlayerWeapons(playerid);
	return 1;
}

stock AC@ResetPlayerWeapons(playerid)
{
	forex(i,13)
	{
    	WeaponInfo[playerid][i][_WeaponDalay]=GetTickCount()+GetPlayerPing(playerid)*15;
	}
	ResetPlayerWeapons(playerid);
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
	{
    	pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]=NONE;
	}
	return 1;
}

#if defined _ALS_ResetPlayerWeapons
	#undef ResetPlayerWeapons
#else
	#define _ALS_ResetPlayerWeapons
#endif
#define ResetPlayerWeapons AC@ResetPlayerWeapons

stock AC@SetPlayerSkillLevel(playerid,skill,level)
{
	SkillLevel[playerid]=level;
	return SetPlayerSkillLevel(playerid, skill, level);
}
#if defined _ALS_SetPlayerSkillLevel
	#undef SetPlayerSkillLevel
#else
	#define _ALS_SetPlayerSkillLevel
#endif
#define SetPlayerSkillLevel AC@SetPlayerSkillLevel

N::ChackPlayerWeapon(playerid)
{
    if(pLastAlive[playerid][_Game_Death]==false)
    {
        if(PlayerInState[playerid]!=PLAYER_IN_NULL&&PlayerInState[playerid]!=PLAYER_IN_WAITLEAVE)
        {
			new ammo,weaponid;
		    forex(i,13)
			{
			    if(GetTickCount()>=WeaponInfo[playerid][i][_WeaponDalay])
			    {
					GetPlayerWeaponData(playerid,i,weaponid,ammo);
					if(weaponid<46)
					{
					    if(ammo!=0)
					    {
							if(!IsPlayerHaveWeapon(playerid,weaponid))
							{
								fLine_128(ReturnMLStr(pLang(playerid),_ANTICHEAT_MSG3),WeaponNames[weaponid]);
								SCM(playerid,-1,line);
								format(line,sizeof(line),"非法武器[%s]",WeaponNames[weaponid]);
								AddPlayerCheatLog(playerid,line);
								format(line,sizeof(line),"%s 非法武器[%s]",Account[playerid][_Name],WeaponNames[weaponid]);
								printf(line);
								SetTimerEx("DelayKicke",100,false,"i",playerid);
						        return 1;
							}
						}
					}
				}
		    }
		}
    }
    return 1;
}
N::IsPlayerHaveWeapon(playerid,weaponid)
{
    if(weaponid==0)return 1;
	if(weaponid<46)
	{
		forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
		{
			if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
		    {
			    if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon]==weaponid)
			    {
		            switch(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot])
		            {
		                case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
						{
			        		if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])>0)return 1;
						}
						case HAND_WEAPON_SLOT_4:
						{
						    if(GetPlayerWeaponItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])>0)return 1;
						}
						default:return 1;
					}
	  		    }
			}
		}
	}
	return 0;
}
stock intdiffabs(tick1, tick2)
{
	if(tick1 > tick2)
	{
		new value = (tick1 - tick2);

		return value < 0 ? -value : value;
	}

	else
	{
		new value = (tick1 - tick2);

		return value < 0 ? -value : value;
	}
}

stock GetTickCountDifference(a, b)
{
	if ((a < 0) && (b > 0))
	{

		new dist;

		dist = intdiffabs(a, b);

		if(dist > 2147483647)
			return intdiffabs(a - 2147483647, b - 2147483647);

		else
			return dist;
	}

	return intdiffabs(a, b);
}
