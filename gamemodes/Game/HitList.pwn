N::AddPlayerHitList(playerid,string[])
{
	if(pGameIn(playerid)==true)
	{
	    pHitCount[playerid]++;
		if(pHitCount[playerid]>=MAX_HITLIST)
		{
		    for(new i=0;i<MAX_HITLIST-1;i++)
			{
			    HitList[playerid][i][_Use]=HitList[playerid][i+1][_Use];
			    format(HitList[playerid][i][_Line],64,HitList[playerid][i+1][_Line]);
			}
			pHitCount[playerid]=MAX_HITLIST-1;
		    HitList[playerid][pHitCount[playerid]][_Use]=true;
		    format(HitList[playerid][pHitCount[playerid]][_Line],64,string);
		}
		else
		{
		    HitList[playerid][pHitCount[playerid]][_Use]=true;
		    format(HitList[playerid][pHitCount[playerid]][_Line],64,string);
		}
		if(pHitShow[playerid]==true)
		{
			forex(i,MAX_HITLIST)
			{
			    if(HitList[playerid][i][_Use]==true)PlayerTextDrawSetString(playerid,pHitDraw[playerid][i],HitList[playerid][i][_Line]);
				else PlayerTextDrawSetString(playerid,pHitDraw[playerid][i]," ");
			}
		}
	}
	return 1;
}
N::CreateHitListGuiDraw(playerid)
{
    DestoryHitListGuiDraw(playerid);
	forex(i,MAX_HITLIST)
	{
	    if(HitList[playerid][i][_Use]==true)pHitDraw[playerid][i]=CreatePlayerTextDraw(playerid, 537.000000, floatadd(196.000000,floatmul(i,13.0)),HitList[playerid][i][_Line]);
		else pHitDraw[playerid][i]=CreatePlayerTextDraw(playerid, 537.000000, floatadd(196.000000,floatmul(i,13.0)), " ");
		PlayerTextDrawFont(playerid, pHitDraw[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, pHitDraw[playerid][i], 0.17100, 0.949999);
		PlayerTextDrawTextSize(playerid, pHitDraw[playerid][i], 700.000000, 142.500000);
		PlayerTextDrawSetOutline(playerid, pHitDraw[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, pHitDraw[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, pHitDraw[playerid][i], 1);
		PlayerTextDrawColor(playerid, pHitDraw[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, pHitDraw[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, pHitDraw[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, pHitDraw[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, pHitDraw[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, pHitDraw[playerid][i], 0);
		PlayerTextDrawShow(playerid,pHitDraw[playerid][i]);
	}
	return 1;
}
N::DestoryHitListGuiDraw(playerid)
{
	forex(i,MAX_HITLIST)
	{
	    if(pHitDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pHitDraw[playerid][i]);
	    pHitDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}
N::ShowPlayerHitList(playerid)
{
	forex(i,3)TextDrawShowForPlayer(playerid,HitListDraw[i]);
	CreateHitListGuiDraw(playerid);
	pHitShow[playerid]=true;
	return 1;
}
N::HidePlayerHitList(playerid)
{
	forex(i,3)TextDrawHideForPlayer(playerid,HitListDraw[i]);
	DestoryHitListGuiDraw(playerid);
	pHitShow[playerid]=false;
	return 1;
}
N::ClearPlayerHitList(playerid)
{
    forex(i,MAX_HITLIST)
    {
        HitList[playerid][i][_Use]=false;
        format(HitList[playerid][i][_Line],64," ");
    }
    pHitCount[playerid]=NONE;
    pHitShow[playerid]=false;
	return 1;
}
N::HitListGuiInt()
{
	HitListDraw[0] = TextDrawCreate(589.000000, 182.000000, "~n~");
	TextDrawFont(HitListDraw[0], 1);
	TextDrawLetterSize(HitListDraw[0], 0.600000, 15.700016);
	TextDrawTextSize(HitListDraw[0], 400.000000, 104.000000);
	TextDrawSetOutline(HitListDraw[0], 1);
	TextDrawSetShadow(HitListDraw[0], 0);
	TextDrawAlignment(HitListDraw[0], 2);
	TextDrawColor(HitListDraw[0], 1296911871);
	TextDrawBackgroundColor(HitListDraw[0], 255);
	TextDrawBoxColor(HitListDraw[0], 1296911686);
	TextDrawUseBox(HitListDraw[0], 1);
	TextDrawSetProportional(HitListDraw[0], 1);
	TextDrawSetSelectable(HitListDraw[0], 0);

	HitListDraw[1] = TextDrawCreate(589.000000, 182.000000, "DAMAGE BOX");
	TextDrawFont(HitListDraw[1], 2);
	TextDrawLetterSize(HitListDraw[1], 0.241666, 1.100000);
	TextDrawTextSize(HitListDraw[1], 644.000000, 102.000000);
	TextDrawSetOutline(HitListDraw[1], 0);
	TextDrawSetShadow(HitListDraw[1], 0);
	TextDrawAlignment(HitListDraw[1], 2);
	TextDrawColor(HitListDraw[1], -16776961);
	TextDrawBackgroundColor(HitListDraw[1], 255);
	TextDrawBoxColor(HitListDraw[1], 50);
	TextDrawUseBox(HitListDraw[1], 0);
	TextDrawSetProportional(HitListDraw[1], 1);
	TextDrawSetSelectable(HitListDraw[1], 0);

	HitListDraw[2] = TextDrawCreate(633.000000, 182.000000, "X");
	TextDrawFont(HitListDraw[2], 2);
	TextDrawLetterSize(HitListDraw[2], 0.216666, 1.100000);
	TextDrawTextSize(HitListDraw[2], 640.500000, 17.000000);
	TextDrawSetOutline(HitListDraw[2], 0);
	TextDrawSetShadow(HitListDraw[2], 0);
	TextDrawAlignment(HitListDraw[2], 1);
	TextDrawColor(HitListDraw[2], -1);
	TextDrawBackgroundColor(HitListDraw[2], 255);
	TextDrawBoxColor(HitListDraw[2], 50);
	TextDrawUseBox(HitListDraw[2], 0);
	TextDrawSetProportional(HitListDraw[2], 1);
	TextDrawSetSelectable(HitListDraw[2], 1);
	return 1;
}
N::HitList@OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_ANALOG_LEFT))
	{
	    if(pGameIn(playerid)==true)
	    {
	        if(pHitShow[playerid]==false)ShowPlayerHitList(playerid);
	        else HidePlayerHitList(playerid);
	    }
	}
    return 1;
}
N::ShowPlayerPickGuiTipY(playerid)
{
    TextDrawShowForPlayer(playerid,PickTipDraw[0]);
    TextDrawShowForPlayer(playerid,PickTipDraw[1]);
    return 1;
}
N::HidePlayerPickGuiTipY(playerid)
{
    TextDrawHideForPlayer(playerid,PickTipDraw[0]);
    TextDrawHideForPlayer(playerid,PickTipDraw[1]);
    return 1;
}
N::ShowPlayerPickGuiTipC(playerid)
{
    TextDrawShowForPlayer(playerid,PickTipDraw[2]);
    TextDrawShowForPlayer(playerid,PickTipDraw[3]);
    return 1;
}
N::HidePlayerPickGuiTipC(playerid)
{
    TextDrawHideForPlayer(playerid,PickTipDraw[2]);
    TextDrawHideForPlayer(playerid,PickTipDraw[3]);
    return 1;
}
N::ShowLeftGui(gameid,string[])
{
	if(LastAliveGame[gameid][Timer:_LeftPlayer_Timer]!=NONE)
	{
		KillTimer(LastAliveGame[gameid][Timer:_LeftPlayer_Timer]);
	    HideLeftGui(gameid);
	}
    TextDrawSetString(LastAliveGame[gameid][_LeftPlayer_Draw],string);
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
    		TextDrawShowForPlayer(i,PickTipDraw[4]);
    		TextDrawShowForPlayer(i,LastAliveGame[gameid][_LeftPlayer_Draw]);
		}
	}
	LastAliveGame[gameid][Timer:_LeftPlayer_Timer]=SetTimerEx("HidePlayerLeftGui",6000,false, "i", gameid);
    return 1;
}
N::HideLeftGui(gameid)
{
    TextDrawSetString(LastAliveGame[gameid][_LeftPlayer_Draw]," ");
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
    		TextDrawHideForPlayer(i,PickTipDraw[4]);
    		TextDrawHideForPlayer(i,LastAliveGame[gameid][_LeftPlayer_Draw]);
		}
	}
    LastAliveGame[gameid][Timer:_LeftPlayer_Timer]=NONE;
    return 1;
}
N::HidePlayerLeftGui(gameid,playerid)
{
	TextDrawHideForPlayer(playerid,PickTipDraw[4]);
    TextDrawHideForPlayer(playerid,LastAliveGame[gameid][_LeftPlayer_Draw]);
    return 1;
}
N::StopLeftGui(gameid)
{
	if(LastAliveGame[gameid][Timer:_LeftPlayer_Timer]!=NONE)
	{
		KillTimer(LastAliveGame[gameid][Timer:_LeftPlayer_Timer]);
	}
	HideLeftGui(gameid);
    return 1;
}
N::GameTipGuiInt()
{
	PickTipDraw[0] = TextDrawCreate(52.000000, 266.000000, "~n~");
	TextDrawFont(PickTipDraw[0], 1);
	TextDrawLetterSize(PickTipDraw[0], 0.600000, 1.199998);
	TextDrawTextSize(PickTipDraw[0], 400.000000, 104.500000);
	TextDrawSetOutline(PickTipDraw[0], 1);
	TextDrawSetShadow(PickTipDraw[0], 0);
	TextDrawAlignment(PickTipDraw[0], 2);
	TextDrawColor(PickTipDraw[0], 1296911871);
	TextDrawBackgroundColor(PickTipDraw[0], 255);
	TextDrawBoxColor(PickTipDraw[0], 1296911686);
	TextDrawUseBox(PickTipDraw[0], 1);
	TextDrawSetProportional(PickTipDraw[0], 1);
	TextDrawSetSelectable(PickTipDraw[0], 0);

	PickTipDraw[1] = TextDrawCreate(52.000000, 266.000000, "~w~Press ~r~~k~~CONVERSATION_YES~ ~w~Or ~r~~k~~SNEAK_ABOUT~~w~ To PickUp");
	TextDrawFont(PickTipDraw[1], 2);
	TextDrawLetterSize(PickTipDraw[1], 0.179166, 1.049998);
	TextDrawTextSize(PickTipDraw[1], 156.500000, 142.500000);
	TextDrawSetOutline(PickTipDraw[1], 0);
	TextDrawSetShadow(PickTipDraw[1], 0);
	TextDrawAlignment(PickTipDraw[1], 2);
	TextDrawColor(PickTipDraw[1], -1);
	TextDrawBackgroundColor(PickTipDraw[1], 255);
	TextDrawBoxColor(PickTipDraw[1], 50);
	TextDrawUseBox(PickTipDraw[1], 0);
	TextDrawSetProportional(PickTipDraw[1], 1);
	TextDrawSetSelectable(PickTipDraw[1], 0);

	PickTipDraw[2] = TextDrawCreate(31.000000, 281.000000, "~n~");
	TextDrawFont(PickTipDraw[2], 1);
	TextDrawLetterSize(PickTipDraw[2], 0.600000, 1.199998);
	TextDrawTextSize(PickTipDraw[2], 400.000000, 61.500000);
	TextDrawSetOutline(PickTipDraw[2], 1);
	TextDrawSetShadow(PickTipDraw[2], 0);
	TextDrawAlignment(PickTipDraw[2], 2);
	TextDrawColor(PickTipDraw[2], 1296911871);
	TextDrawBackgroundColor(PickTipDraw[2], 255);
	TextDrawBoxColor(PickTipDraw[2], 1296911686);
	TextDrawUseBox(PickTipDraw[2], 1);
	TextDrawSetProportional(PickTipDraw[2], 1);
	TextDrawSetSelectable(PickTipDraw[2], 0);

	PickTipDraw[3] = TextDrawCreate(31.000000, 281.000000, "~w~PRESS ~r~C ~w~TO PICK");
	TextDrawFont(PickTipDraw[3], 2);
	TextDrawLetterSize(PickTipDraw[3], 0.179166, 1.049998);
	TextDrawTextSize(PickTipDraw[3], 156.500000, 142.500000);
	TextDrawSetOutline(PickTipDraw[3], 0);
	TextDrawSetShadow(PickTipDraw[3], 0);
	TextDrawAlignment(PickTipDraw[3], 2);
	TextDrawColor(PickTipDraw[3], -1);
	TextDrawBackgroundColor(PickTipDraw[3], 255);
	TextDrawBoxColor(PickTipDraw[3], 50);
	TextDrawUseBox(PickTipDraw[3], 0);
	TextDrawSetProportional(PickTipDraw[3], 1);
	TextDrawSetSelectable(PickTipDraw[3], 0);

	PickTipDraw[4] = TextDrawCreate(59.000000, 251.000000, "~n~");
	TextDrawFont(PickTipDraw[4], 1);
	TextDrawLetterSize(PickTipDraw[4], 0.600000, 1.199998);
	TextDrawTextSize(PickTipDraw[4], 400.000000, 115.500000);
	TextDrawSetOutline(PickTipDraw[4], 1);
	TextDrawSetShadow(PickTipDraw[4], 0);
	TextDrawAlignment(PickTipDraw[4], 2);
	TextDrawColor(PickTipDraw[4], -3841);
	TextDrawBackgroundColor(PickTipDraw[4], 255);
	TextDrawBoxColor(PickTipDraw[4], -16777186);
	TextDrawUseBox(PickTipDraw[4], 1);
	TextDrawSetProportional(PickTipDraw[4], 1);
	TextDrawSetSelectable(PickTipDraw[4], 0);
	return 1;
}
stock Text:CreateLeftPlayerDraw()
{
	new Text:GameTextDraw = TextDrawCreate(59.000000, 251.000000, " ");
	TextDrawFont(GameTextDraw, 2);
	TextDrawLetterSize(GameTextDraw, 0.179166, 1.049998);
	TextDrawTextSize(GameTextDraw, 156.500000, 142.500000);
	TextDrawSetOutline(GameTextDraw, 0);
	TextDrawSetShadow(GameTextDraw, 0);
	TextDrawAlignment(GameTextDraw, 2);
	TextDrawColor(GameTextDraw, -1);
	TextDrawBackgroundColor(GameTextDraw, 255);
	TextDrawBoxColor(GameTextDraw, 50);
	TextDrawUseBox(GameTextDraw, 0);
	TextDrawSetProportional(GameTextDraw, 1);
	TextDrawSetSelectable(GameTextDraw, 0);
    return GameTextDraw;
}
