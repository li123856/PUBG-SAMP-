N::OnPlayerClickDeathBoxItem(playerid,gameid,boxid,index)
{
    if(Iter_Contains(DeathBox[gameid],boxid))
    {
		if(DeathBoxPrevieBoxKey[playerid][index]==DeathBox[gameid][boxid][_Key][DeathBoxPrevieBox[playerid][index]])
  		{
			if(DeathBox[gameid][boxid][_ItemID][DeathBoxPrevieBox[playerid][index]]!=NONE)
			{
				if(AddThingToPlayerInventoy(playerid,DeathBox[gameid][boxid][_ItemID][DeathBoxPrevieBox[playerid][index]],DeathBox[gameid][boxid][_Amout][DeathBoxPrevieBox[playerid][index]],DeathBox[gameid][boxid][_Ammo][DeathBoxPrevieBox[playerid][index]],DeathBox[gameid][boxid][_Durable][DeathBoxPrevieBox[playerid][index]])==INVENTORY_FULL)
				{
				    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
				}
				else
				{
				    DeathBox[gameid][boxid][_Key][DeathBoxPrevieBox[playerid][index]]=NONE;
				    DeathBox[gameid][boxid][_ItemID][DeathBoxPrevieBox[playerid][index]]=NONE;
				    DeathBox[gameid][boxid][_Amout][DeathBoxPrevieBox[playerid][index]]=0;
				    DeathBox[gameid][boxid][_Ammo][DeathBoxPrevieBox[playerid][index]]=0;
				    DeathBox[gameid][boxid][_Durable][DeathBoxPrevieBox[playerid][index]]=0.0;
				    if(GetDeathBoxItemAmout(gameid,boxid)<1)
					{
						DestoryGameDeathBox(gameid,boxid);
						DestoryPlayerDeathBoxDraw(playerid);
						CancelSelectTextDraw(playerid);
						return 1;
					}
				}
			}
        }
    }
    RefreshPlayerDeathBoxPrevie(playerid,gameid,boxid,DeathBoxPreviePage[playerid]);
	return 1;
}
N::CreatePlayerGameDeathBox(gameid,playerid,Float:_@x,Float:_@y,Float:_@z,_@interior,Float:_@streamdistance,Float:_@areasize)
{
	if(Iter_Count(Inventory[playerid])<=0)return 0;
    if(Iter_Count(DeathBox[gameid])>=MAX_GAME_DEATHBOXS)return 0;
    new i=Iter_Free(DeathBox[gameid]);
    DeathBox[gameid][i][_Type]=BOX_TYPE_PLAYER;
	DeathBox[gameid][i][_Obj]=CreateDynamicObject(2912,_@x,_@y,_@z-0.5,0.0,0.0,0.0,GameRoom(gameid),_@interior,-1,_@streamdistance);
	DeathBox[gameid][i][_Text]=CreateDynamic3DTextLabel(" ",-1,_@x,_@y,_@z+0.2,_@streamdistance,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,STREAMER_VEHICLE_TYPE_DYNAMIC,0,GameRoom(gameid),_@interior);
	DeathBox[gameid][i][_Area]=CreateDynamicSphere(_@x,_@y,_@z,_@areasize,GameRoom(gameid),_@interior);
	DeathBox[gameid][i][_Owner]=Account[playerid][_Key];
	DeathBox[gameid][i][_Map]=INVALID_STREAMER_ID;
	new count=0;
	foreach(new s:Inventory[playerid])
   	{
   	    if(count<MAX_GAME_DEATHBOX_THINGS)
   	    {
			DeathBox[gameid][i][_Key][count]=Inventory[playerid][s][_Key];
		    DeathBox[gameid][i][_ItemID][count]=Inventory[playerid][s][_ItemID];
		    DeathBox[gameid][i][_Amout][count]=Inventory[playerid][s][_Amout];
		    DeathBox[gameid][i][_Ammo][count]=Inventory[playerid][s][_Ammo];
		    DeathBox[gameid][i][_Durable][count]=Inventory[playerid][s][_Durable];
		    count++;
	    }
   	}
    Iter_Add(DeathBox[gameid],i);
	return 1;
}
N::ShowPayerDeathBoxMapIcon(playerid,gameid)
{
	foreach(new i:DeathBox[gameid])
   	{
   	    if(DeathBox[gameid][i][_Draw]!=Text:INVALID_TEXT_DRAW)
   	    {
   	    	TextDrawShowForPlayer(playerid,DeathBox[gameid][i][_Draw]);
   	    }
   	}
 	return 1;
}
N::HidePayerDeathBoxMapIcon(playerid,gameid)
{
	foreach(new i:DeathBox[gameid])
   	{
   	    if(DeathBox[gameid][i][_Draw]!=Text:INVALID_TEXT_DRAW)
   	    {
   	    	TextDrawHideForPlayer(playerid,DeathBox[gameid][i][_Draw]);
   	    }
   	}
 	return 1;
}
stock Text:CreateDeathBoxMapIcon(Float:Xpos, Float:Ypos)
{
	new Text:TextDraw = TextDrawCreate(Xpos, Ypos, "HUD:radar_flag");
	TextDrawFont(TextDraw, 4);
	TextDrawLetterSize(TextDraw, 0.600000, 2.000000);
	TextDrawTextSize(TextDraw, 9.500000, 10.500000);
	TextDrawSetOutline(TextDraw, 1);
	TextDrawSetShadow(TextDraw, 0);
	TextDrawAlignment(TextDraw, 2);
	TextDrawColor(TextDraw, -1);
	TextDrawBackgroundColor(TextDraw, 255);
	TextDrawBoxColor(TextDraw, 50);
	TextDrawUseBox(TextDraw, 1);
	TextDrawSetProportional(TextDraw, 1);
	TextDrawSetSelectable(TextDraw, 0);
    return TextDraw;
}
N::CreateGameAirDropBox(gameid,itemlist[],counts,Float:_@x,Float:_@y,Float:_@z,_@interior,Float:_@streamdistance,Float:_@areasize)
{
    if(Iter_Count(DeathBox[gameid])>=MAX_GAME_DEATHBOXS)return 0;
    new i=Iter_Free(DeathBox[gameid]);
    DeathBox[gameid][i][_Type]=BOX_TYPE_AIRDROP;
	DeathBox[gameid][i][_Obj]=CreateDynamicObject(5259,_@x,_@y,_@z-0.5,0.0,0.0,0.0,GameRoom(gameid),_@interior,-1,_@streamdistance);
	DeathBox[gameid][i][_Text]=CreateDynamic3DTextLabel(" ",-1,_@x,_@y,_@z+0.2,_@streamdistance,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,STREAMER_VEHICLE_TYPE_DYNAMIC,0,GameRoom(gameid),_@interior);
	DeathBox[gameid][i][_Area]=CreateDynamicSphere(_@x,_@y,_@z,_@areasize,GameRoom(gameid),_@interior);
	DeathBox[gameid][i][_Owner]=NONE;
	DeathBox[gameid][i][_Map]=CreateDynamicMapIcon(_@x,_@y,_@z,53,0x000040C8,GameRoom(gameid),0,-1,9999999.0,MAPICON_GLOBAL);
    if(DeathBox[gameid][i][_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(DeathBox[gameid][i][_Draw]);
    DeathBox[gameid][i][_Draw]=Text:INVALID_TEXT_DRAW;
	new Float:MapX=floatadd(296.0,floatdiv(floatsub(_@x,0.0),16.66666666666667));
	new Float:MapY=floatsub(186.0,floatdiv(floatsub(_@y,0.0),16.66666666666667));
    DeathBox[gameid][i][_Draw]=CreateDeathBoxMapIcon(MapX,MapY);
	new count=0;
	forex(s,counts)
	{
   	    if(count<MAX_GAME_DEATHBOX_THINGS)
   	    {
			DeathBox[gameid][i][_Key][count]=GetTickCount();
		    DeathBox[gameid][i][_ItemID][count]=itemlist[s];
		    DeathBox[gameid][i][_Amout][count]=1;
		    DeathBox[gameid][i][_Ammo][count]=Item[itemlist[s]][_AmmoAmout];
		    DeathBox[gameid][i][_Durable][count]=Item[itemlist[s]][_Durable];
		    count++;
		}
	}
    Iter_Add(DeathBox[gameid],i);
	return 1;
}
N::DestoryGameDeathBox(gameid,index)
{
    if(!Iter_Contains(DeathBox[gameid],index))return 1;
    DestroyDynamicObject(DeathBox[gameid][index][_Obj]);
    DestroyDynamic3DTextLabel(DeathBox[gameid][index][_Text]);
    DestroyDynamicArea(DeathBox[gameid][index][_Area]);
    DestroyDynamicMapIcon(DeathBox[gameid][index][_Map]);
    DeathBox[gameid][index][_Obj]=INVALID_STREAMER_ID;
    DeathBox[gameid][index][_Text]=Text3D:INVALID_STREAMER_ID;
    DeathBox[gameid][index][_Area]=INVALID_STREAMER_ID;
    DeathBox[gameid][index][_Owner]=NONE;
    DeathBox[gameid][index][_Type]=BOX_TYPE_NONE;
    DeathBox[gameid][index][_Map]=INVALID_STREAMER_ID;
    if(DeathBox[gameid][index][_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(DeathBox[gameid][index][_Draw]);
    DeathBox[gameid][index][_Draw]=Text:INVALID_TEXT_DRAW;
    forex(i,MAX_GAME_DEATHBOX_THINGS)
    {
	    DeathBox[gameid][index][_Key][i]=NONE;
	    DeathBox[gameid][index][_ItemID][i]=NONE;
	    DeathBox[gameid][index][_Amout][i]=0;
	    DeathBox[gameid][index][_Ammo][i]=0;
	    DeathBox[gameid][index][_Durable][i]=0.0;
    }
    Iter_Remove(DeathBox[gameid],index);
	return 1;
}
N::ClearGameDeathBox(gameid)
{
	foreach(new i:DeathBox[gameid])
   	{
	    DestroyDynamicObject(DeathBox[gameid][i][_Obj]);
	    DestroyDynamic3DTextLabel(DeathBox[gameid][i][_Text]);
	    DestroyDynamicArea(DeathBox[gameid][i][_Area]);
     	DestroyDynamicMapIcon(DeathBox[gameid][i][_Map]);
	    DeathBox[gameid][i][_Obj]=INVALID_STREAMER_ID;
	    DeathBox[gameid][i][_Text]=Text3D:INVALID_STREAMER_ID;
	    DeathBox[gameid][i][_Area]=INVALID_STREAMER_ID;
	    DeathBox[gameid][i][_Map]=INVALID_STREAMER_ID;
	    DeathBox[gameid][i][_Owner]=NONE;
    	if(DeathBox[gameid][i][_Draw]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(DeathBox[gameid][i][_Draw]);
    	DeathBox[gameid][i][_Draw]=Text:INVALID_TEXT_DRAW;
	    forex(s,MAX_GAME_DEATHBOX_THINGS)
	    {
		    DeathBox[gameid][i][_Key][s]=NONE;
		    DeathBox[gameid][i][_ItemID][s]=NONE;
		    DeathBox[gameid][i][_Amout][s]=0;
		    DeathBox[gameid][i][_Ammo][s]=0;
		    DeathBox[gameid][i][_Durable][s]=0.0;
	    }
   	}
   	Iter_Clear(DeathBox[gameid]);
    forex(i,MAX_GAME_DEATHBOXS)
	{
	    DeathBox[gameid][i][_Owner]=NONE;
     	DeathBox[gameid][i][_Type]=BOX_TYPE_NONE;
		forex(s,MAX_GAME_DEATHBOX_THINGS)
		{
		    DeathBox[gameid][i][_Key][s]=NONE;
		    DeathBox[gameid][i][_ItemID][s]=NONE;
		    DeathBox[gameid][i][_Amout][s]=0;
		    DeathBox[gameid][i][_Ammo][s]=0;
		    DeathBox[gameid][i][_Durable][s]=0.0;
		}
		DeathBox[gameid][i][_x]=0.0;
		DeathBox[gameid][i][_y]=0.0;
		DeathBox[gameid][i][_z]=0.0;
		DeathBox[gameid][i][_rx]=0.0;
		DeathBox[gameid][i][_ry]=0.0;
		DeathBox[gameid][i][_rz]=0.0;
		DeathBox[gameid][i][_Interior]=0;
		DeathBox[gameid][i][_Obj]=INVALID_STREAMER_ID;
		DeathBox[gameid][i][_Area]=INVALID_STREAMER_ID;
		DeathBox[gameid][i][_Text]=Text3D:INVALID_STREAMER_ID;
		DeathBox[gameid][i][_Map]=INVALID_STREAMER_ID;
	}
	return 1;
}
N::GetDeathBoxItemAmout(gameid,index)
{
	new count=0;
    forex(i,MAX_GAME_DEATHBOX_THINGS)
    {
	    if(DeathBox[gameid][index][_ItemID][i]!=NONE)count++;
    }
    return count;
}
N::ShowPlayerDeathBox(playerid,gameid,boxid)
{
    if(Iter_Count(DeathBox[gameid])<=0)return 0;
	if(!Iter_Contains(DeathBox[gameid],boxid))return 0;
    HidePlayerDeathBox(playerid);
    ShowPlayerDeathBoxBackGround(playerid);
    CreatePlayerDeathBoxPage(playerid,gameid,boxid,1,false);
    return 1;
}
N::HidePlayerDeathBox(playerid)
{
    DestoryPlayerDeathBoxDraw(playerid);
    HidePlayerDeathBoxBackGround(playerid);
    PlayerDeathBoxID[playerid]=NONE;
    return 1;
}

N::ShowPlayerDeathBoxBackGround(playerid)
{
	forex(i,MAX_DEATHBOX_BACKGROUND)TextDrawShowForPlayer(playerid,DeathBoxGround[i]);
	return 1;
}
N::HidePlayerDeathBoxBackGround(playerid)
{
	forex(i,MAX_DEATHBOX_BACKGROUND)TextDrawHideForPlayer(playerid,DeathBoxGround[i]);
	return 1;
}


stock PlayerText:CreatePlayerDeathBoxSliderBar(gameid,index,playerid,pages)
{
    new ItemAmout=GetDeathBoxItemAmout(gameid,index);
    if(ItemAmout<=0)ItemAmout=1;
    new Float:BarTextSize=floatdiv(22.500022,floatround(floatdiv(ItemAmout,MAX_DEATHBOX_SHOW_LIST),floatround_ceil));
	if(pages<=0)pages=0;
	else pages--;
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, 258.000000, 117.000000+floatmul(pages,BarTextSize)*1.80, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, BarTextSize);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 6.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -206);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxBackBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:up");//前页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 10.500000, 9.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxNextBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:down");//后页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 10.500000, 9.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxPrevieBackGround(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 4.649991);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 117.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxPrevieModel(playerid,model,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 57.000000, 50.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, 0.000000, 0.000000, 59.000000, 2.509999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxPrevieUseIcon(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_chat:thumbup");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 14.500000, 14.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxPrevieInfo(playerid,info[],Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,info);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.233333, 1.350002);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 3);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateDeathBoxPrevieTag(playerid,tag[],Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,tag);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.375000, 1.950000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::RefreshPlayerDeathBoxPrevie(playerid,gameid,boxid,pages)
{
	forex(i,MAX_DEATHBOX_SHOW_LIST)
	{
		if(DeathBoxModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxModelDraw[playerid][i]);
		if(DeathBoxBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxBackGround[playerid][i]);
		if(DeathBoxInfo[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxInfo[playerid][i]);
		if(DeathBoxUseIcon[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxUseIcon[playerid][i]);
		DeathBoxModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxInfo[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxUseIcon[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(DeathBoxSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxSliderBar[playerid]);
	DeathBoxSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	CreatePlayerDeathBoxPage(playerid,gameid,boxid,pages,true);
	return 1;
}
N::DestoryPlayerDeathBoxDraw(playerid)
{
	forex(i,MAX_DEATHBOX_SHOW_LIST)
	{
		if(DeathBoxModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxModelDraw[playerid][i]);
		if(DeathBoxBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxBackGround[playerid][i]);
		if(DeathBoxInfo[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxInfo[playerid][i]);
		if(DeathBoxUseIcon[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxUseIcon[playerid][i]);
		DeathBoxModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxInfo[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxUseIcon[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(DeathBoxSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxSliderBar[playerid]);
	if(DeathBoxBottonUp[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxBottonUp[playerid]);
	if(DeathBoxBottonDown[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxBottonDown[playerid]);
	if(DeathBoxTag[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,DeathBoxTag[playerid]);
	DeathBoxSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	DeathBoxBottonUp[playerid]=PlayerText:INVALID_TEXT_DRAW;
	DeathBoxBottonDown[playerid]=PlayerText:INVALID_TEXT_DRAW;
	DeathBoxTag[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::CreatePlayerDeathBoxPage(playerid,gameid,boxid,pages,bool:refresh)
{
	if(!Iter_Contains(DeathBox[gameid],boxid))return DestoryPlayerDeathBoxDraw(playerid);
	new index=0,ItemAmout=0;
    DeathBoxPrevieRate[playerid]=0;
    DeathBoxPrevieCount[playerid]=1;
    DeathBoxClickID[playerid]=NONE;
    forex(i,MAX_GAME_DEATHBOX_THINGS)
    {
	    if(DeathBox[gameid][boxid][_ItemID][i]!=NONE)
	    {
		    if(ItemAmout<MAX_DEATHBOX_BOX_ITEMS-2)
		    {
				DeathBoxPrevieBox[playerid][DeathBoxPrevieCount[playerid]]=i;
				DeathBoxPrevieBoxKey[playerid][DeathBoxPrevieCount[playerid]]=DeathBox[gameid][boxid][_Key][i];
	   			DeathBoxPrevieCount[playerid]++;
	   			ItemAmout++;
		    }
	    }
	}
	if(pages<1)pages=1;
	if(pages>floatround((DeathBoxPrevieCount[playerid]-1)/float(MAX_DEATHBOX_SHOW_LIST),floatround_ceil))pages=floatround((DeathBoxPrevieCount[playerid]-1)/float(MAX_DEATHBOX_SHOW_LIST),floatround_ceil);
    DeathBoxPreviePage[playerid]=pages;
    pages=(pages-1)*MAX_DEATHBOX_SHOW_LIST;
    if(pages<=0)pages=1;else pages++;
	Loop(i,pages,pages+MAX_DEATHBOX_SHOW_LIST)
	{
	    index=DeathBoxPrevieBox[playerid][i];
	    if(i<DeathBoxPrevieCount[playerid])
		{
			DeathBoxBackGround[playerid][DeathBoxPrevieRate[playerid]] = CreateDeathBoxPrevieBackGround(playerid, 193.000000, 105.000000+DeathBoxPrevieRate[playerid]*46.0);
			DeathBoxModelDraw[playerid][DeathBoxPrevieRate[playerid]] = CreateDeathBoxPrevieModel(playerid,Item[DeathBox[gameid][boxid][_ItemID][index]][_Model],136.000000, 89.000000+DeathBoxPrevieRate[playerid]*46.0);
			new line[128],str[64];
			format(line,128,"~r~%s~n~~y~%s~n~~w~",Item[DeathBox[gameid][boxid][_ItemID][index]][_SizeName],Item[DeathBox[gameid][boxid][_ItemID][index]][_Name]);
			switch(Item[DeathBox[gameid][boxid][_ItemID][index]][_Type])
			{
			    case ITEM_AMMO:format(str,64,"%i",DeathBox[gameid][boxid][_Amout][index]);
			    case ITEM_WEAPON:format(str,64," ");
			    case ITEM_ARMOUR,ITEM_HELMET:
				{
				    new Float:percent=ReturnPercent(DeathBox[gameid][boxid][_Durable][index],Item[DeathBox[gameid][boxid][_ItemID][index]][_Durable]);
					format(str,64,"%0.1f%%",percent);
				}
			    default:format(str,64,"X%i",DeathBox[gameid][boxid][_Amout][index]);
			}
			strcat(line,str);
			DeathBoxInfo[playerid][DeathBoxPrevieRate[playerid]] = CreateDeathBoxPrevieInfo(playerid,line,231.000000, 104.000000+DeathBoxPrevieRate[playerid]*46.0);
			DeathBoxUseIcon[playerid][DeathBoxPrevieRate[playerid]] = CreateDeathBoxPrevieUseIcon(playerid,235.000000, 130.000000+DeathBoxPrevieRate[playerid]*46.0);
			DeathBoxPrevieRate[playerid]++;
		}
		if(i>=DeathBoxPrevieCount[playerid])break;
	}
	DeathBoxSliderBar[playerid] = CreatePlayerDeathBoxSliderBar(gameid,boxid,playerid,pages);
	if(refresh==false)
	{
		DeathBoxBottonUp[playerid] =CreateDeathBoxBackBottonPrevie(playerid,253.000000, 105.000000);
		DeathBoxBottonDown[playerid] = CreateDeathBoxNextBottonPrevie(playerid,253.000000, 323.000000);
		if(DeathBox[gameid][boxid][_Type]==BOX_TYPE_AIRDROP)DeathBoxTag[playerid]=CreateDeathBoxPrevieTag(playerid,"~r~AIRDROP_BOX",197.000000, 81.000000);
        else DeathBoxTag[playerid]=CreateDeathBoxPrevieTag(playerid,"PLAYER_BOX",197.000000, 81.000000);
	}
	return 1;
}
CMD:cdb(playerid, params[], help)
{
    if(IsPlayerAdmin(playerid))
    {
		new Float:xyz[3];
		GetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
		Tryg3D::MapAndreasFindZ(xyz[0],xyz[1],xyz[2]);
		CreatePlayerGameDeathBox(pGameID(playerid),playerid,xyz[0],xyz[1],xyz[2]-0.5,GetPlayerInterior(playerid),100.0,2.0);
	}
	return 1;
}
CMD:a(playerid, params[], help)
{
    if(IsPlayerAdmin(playerid))CreatRandAirDropBox(pGameID(playerid));
	return 1;
}
N::CreatRandAirDropBox(gameid)
{
	new amount=Randoms(30,MAX_GAME_DEATHBOX_THINGS-1);
	new itemlist[MAX_GAME_DEATHBOX_THINGS];
	forex(i,MAX_GAME_DEATHBOX_THINGS)
	{
	    if(i<=amount)
	    {
	    	itemlist[i]=Randoms(0,sizeof(Item));
	    }
	    else itemlist[i]=NONE;
	}
    new Float:randx=frandoms(LastAliveGame[gameid][_SafeMaxX],LastAliveGame[gameid][_SafeMinX]);
    new Float:randy=frandoms(LastAliveGame[gameid][_SafeMaxY],LastAliveGame[gameid][_SafeMinY]);
	new Float:randz;
    Tryg3D::MapAndreasFindZ(randx,randy,randz);
    while(randz<1.0)
    {
    	randx=frandoms(LastAliveGame[gameid][_SafeMaxX],LastAliveGame[gameid][_SafeMinX]);
    	randy=frandoms(LastAliveGame[gameid][_SafeMaxY],LastAliveGame[gameid][_SafeMinY]);
       	Tryg3D::MapAndreasFindZ(randx,randy,randz);
    }
	return CreateGameAirDropBox(gameid,itemlist,amount,randx,randy,randz+1.0,0,200.0,10.0);
}
ReturnBoxOwner(Language,gameid,boxid)
{
	new string[64];
	if(DeathBox[gameid][boxid][_Type]==BOX_TYPE_AIRDROP)
	{
	    if(Language==0)format(string,64,"空投箱");
	    else format(string,64,"Airdrop Box");
	}
	else
	{
	    if(Language==0)format(string,64,"%s 的死亡物资箱",Select@GetPlayerNameByKey(DeathBox[gameid][boxid][_Owner]));
	    else format(string,64,"%s's death kits",Select@GetPlayerNameByKey(DeathBox[gameid][boxid][_Owner]));
	}
	return string;
}
N::GetPlayerInDeathBoxAreaID(playerid)
{
	if(PlayerDeathBoxID[playerid]==NONE)return NONE;
	foreach(new i:DeathBox[pGameID(playerid)])
   	{
   		if(IsPlayerInDynamicArea(playerid,DeathBox[pGameID(playerid)][i][_Area]))
   		{
   		    if(PlayerDeathBoxID[playerid]==i)return i;
   		}
   	}
   	return NONE;
}
public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	if(!IsPlayerInAnyDynamicVehicle(playerid))
	{
		if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
		{
			foreach(new i:DeathBox[pGameID(playerid)])
		   	{
		   	    if(DeathBox[pGameID(playerid)][i][_Area]==areaid)
		   	    {
		   	        ShowPlayerDeathBox(playerid,pGameID(playerid),i);
	      			fLine_256(ReturnMLStr(pLang(playerid),_BOX_MSG1),ReturnBoxOwner(pLang(playerid),pGameID(playerid),i));
	       			SCM(playerid,-1,line);
		   	        PlayerDeathBoxID[playerid]=i;
		   	        ShowPlayerPickGuiTipC(playerid);
		   	        return 1;
		   	    }
		   	}
			foreach(new i:PickItem[pGameID(playerid)])
		   	{
		   	    if(PickItem[pGameID(playerid)][i][_Area]==areaid)
		   	    {
		   	        ShowPlayerPickGuiTipY(playerid);
		   	    	return 1;
		   	    }
		   	}
	   	}
   	}
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
	{
		foreach(new i:DeathBox[pGameID(playerid)])
	   	{
	   	    if(DeathBox[pGameID(playerid)][i][_Area]==areaid)
	   	    {
	   	        HidePlayerPickGuiTipC(playerid);
                HidePlayerDeathBox(playerid);
                CancelSelectTextDraw(playerid);
                return 1;
	   	    }
	   	}
		foreach(new i:PickItem[pGameID(playerid)])
	   	{
	   	    if(PickItem[pGameID(playerid)][i][_Area]==areaid)
	   	    {
	   	        HidePlayerPickGuiTipY(playerid);
	   	    	return 1;
	   	    }
	   	}
   	}
	return 1;
}

