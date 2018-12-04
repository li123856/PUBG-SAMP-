stock PlayerText:CreateNearByPrevieBackGround(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 5.350002);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 150.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateNearByPrevieModel(playerid,model, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "Nowy_TextDraw");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 46.000000, 48.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 1687547198);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -741092608);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -10.000000, 0.000000, -20.000000, 0.810000);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateNearByPrevieNameTag(playerid,Float:Xpos, Float:Ypos,text[])
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.191666, 1.200000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateNearByPrevieAmout(playerid,Float:Xpos, Float:Ypos,text[])
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 3);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.337500, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
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
stock PlayerText:CreateNearByBackBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "LD_BEAT:left");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.329165, 2.049998);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 19.500000, 15.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateNearByNextBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "LD_BEAT:right");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.329165, 2.049998);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 19.500000, 15.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateNearByPagePrevie(playerid,Float:Xpos, Float:Ypos,itemamout,pages)
{
	new MaxPages=floatround(floatdiv(itemamout,MAX_NEARBY_SHOW_LIST),floatround_ceil);
	if(itemamout<=0)
	{
	    pages=0;
		MaxPages=0;
	}
    fLine_64("~w~%i/%i",pages,MaxPages);
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,line);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.266665, 1.399999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::DestoryPlayerNearByDraw(playerid)
{
	forex(i,MAX_NEARBY_SHOW_LIST)
	{
		if(NearByBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByBackGround[playerid][i]);
		if(NearByModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByModelDraw[playerid][i]);
		if(NearByNameTag[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByNameTag[playerid][i]);
		if(NearByItemAmout[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByItemAmout[playerid][i]);
		NearByBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByNameTag[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByItemAmout[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(NearByBackBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByBackBotton[playerid]);
	if(NearByNextBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByNextBotton[playerid]);
	if(NearByPage[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByPage[playerid]);
	NearByBackBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	NearByNextBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	NearByPage[playerid]=PlayerText:INVALID_TEXT_DRAW;
    return 1;
}
N::ShowPlayerNearByPrevie(playerid,gameid,Float:_@distance,pages,bool:refresh)
{
	new index=0,ItemAmout=0;
    NearByPrevieRate[playerid]=0;
    NearByPrevieCount[playerid]=1;
    NearByClickID[playerid]=NONE;
    for(new i=Iter_End(PickItem[gameid]);(i=Iter_Prev(PickItem[gameid],i))!=Iter_Begin(PickItem[gameid]);)
	{
	    if(ItemAmout<MAX_NEARBY_BOX_ITEMS-2)
	    {
		    if(IsPlayerInRangeOfPoint(playerid,_@distance,PickItem[gameid][i][_x],PickItem[gameid][i][_y],PickItem[gameid][i][_z])&&GetPlayerInterior(playerid)==PickItem[gameid][i][_Interior]&&GetPlayerVirtualWorld(playerid)==GameRoom(gameid)&&pGameID(playerid)==gameid)
		    {
				NearByPrevieBox[playerid][NearByPrevieCount[playerid]]=i;
				NearByPrevieBoxKey[playerid][NearByPrevieCount[playerid]]=PickItem[gameid][i][_Key];
	   			NearByPrevieCount[playerid]++;
	   			ItemAmout++;
		    }
	    }
	}
	if(pages<1)pages=1;
	if(pages>floatround((NearByPrevieCount[playerid]-1)/float(MAX_NEARBY_SHOW_LIST),floatround_ceil))pages=floatround((NearByPrevieCount[playerid]-1)/float(MAX_NEARBY_SHOW_LIST),floatround_ceil);
    NearByPreviePage[playerid]=pages;
    pages=(pages-1)*MAX_NEARBY_SHOW_LIST;
    if(pages<=0)pages=1;else pages++;
	Loop(i,pages,pages+MAX_NEARBY_SHOW_LIST)
	{
	    index=NearByPrevieBox[playerid][i];
	    if(i<NearByPrevieCount[playerid])
		{
			NearByBackGround[playerid][NearByPrevieRate[playerid]] = CreateNearByPrevieBackGround(playerid, 39.000000, 88.000000+NearByPrevieRate[playerid]*50.8);
			NearByModelDraw[playerid][NearByPrevieRate[playerid]] = CreateNearByPrevieModel(playerid,Item[PickItem[gameid][index][_ItemID]][_Model], 39.000000, 88.000000+NearByPrevieRate[playerid]*50.8);
			fLine_64("%s~n~~r~%s~n~~g~%0.1fM",Item[PickItem[gameid][index][_ItemID]][_Name],Item[PickItem[gameid][index][_ItemID]][_SizeName],GetPlayerDistanceFromPoint(playerid,PickItem[gameid][index][_x],PickItem[gameid][index][_y],PickItem[gameid][index][_z]));
			NearByNameTag[playerid][NearByPrevieRate[playerid]] = CreateNearByPrevieNameTag(playerid,87.000000, 103.000000+NearByPrevieRate[playerid]*50.8,line);
			switch(Item[PickItem[gameid][index][_ItemID]][_Type])
			{
			    case ITEM_AMMO:format(line,64,"%i",PickItem[gameid][index][_Ammo]);
			    case ITEM_WEAPON:format(line,64," ");
			    case ITEM_ARMOUR,ITEM_HELMET:
				{
				    new Float:percent=ReturnPercent(PickItem[gameid][index][_Durable],Item[PickItem[gameid][index][_ItemID]][_Durable]);
					format(line,64,"%0.1f%%",percent);
				}
			    default:format(line,64,"X%i",PickItem[gameid][index][_Amout]);
			}
			NearByItemAmout[playerid][NearByPrevieRate[playerid]] = CreateNearByPrevieAmout(playerid,149.000000, 88.000000+NearByPrevieRate[playerid]*50.8,line);
			NearByPrevieRate[playerid]++;
		}
		if(i>=NearByPrevieCount[playerid])break;
	}
	NearByPage[playerid]=CreateNearByPagePrevie(playerid,97.000000, 395.000000,ItemAmout,NearByPreviePage[playerid]);
	if(refresh==false)
	{
		NearByBackBotton[playerid]=CreateNearByBackBottonPrevie(playerid,47.000000, 395.000000);
		NearByNextBotton[playerid]=CreateNearByNextBottonPrevie(playerid,125.000000, 395.000000);
	}
	return 1;
}
N::RefreshPlayerNearByPrevie(playerid,gameid,Float:_@distance,pages)
{
	forex(i,MAX_NEARBY_SHOW_LIST)
	{
		if(NearByBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByBackGround[playerid][i]);
		if(NearByModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByModelDraw[playerid][i]);
		if(NearByNameTag[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByNameTag[playerid][i]);
		if(NearByItemAmout[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByItemAmout[playerid][i]);
		NearByBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByNameTag[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		NearByItemAmout[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(NearByPage[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,NearByPage[playerid]);
	NearByPage[playerid]=PlayerText:INVALID_TEXT_DRAW;
	ShowPlayerNearByPrevie(playerid,gameid,_@distance,pages,true);
	return 1;
}
