Float:GetSafeZoneSize(gameid)
{
    new Float:Xdiff=floatsub(LastAliveGame[gameid][_SafeMaxX],LastAliveGame[gameid][_SafeMinX]);
    new Float:Ydiff=floatsub(LastAliveGame[gameid][_SafeMaxY],LastAliveGame[gameid][_SafeMinY]);
	if(Xdiff<0.0||Ydiff<0.0)return 0.0;
	return floatmul(Xdiff,Ydiff);
}
stock IsPlayerInSafeZone(playerid,Float:x,Float:y)
{
    return (x>LastAliveGame[pGameID(playerid)][_SafeMinX]&&x<LastAliveGame[pGameID(playerid)][_SafeMaxX]&&y>LastAliveGame[pGameID(playerid)][_SafeMinY]&&y<LastAliveGame[pGameID(playerid)][_SafeMaxY]);
}
stock IsPlayerInNontoxZone(playerid,Float:x,Float:y)
{
    return (x>LastAliveGame[pGameID(playerid)][_NontoxicMinX]&&x<LastAliveGame[pGameID(playerid)][_NontoxicMaxX]&&y>LastAliveGame[pGameID(playerid)][_NontoxicMinY]&&y<LastAliveGame[pGameID(playerid)][_NontoxicMaxY]);
}

N::ChangeToxicCircle(gameid,Float:amout)
{
    forex(i,MAX_GAME_CIRCLE_POS)
	{
	    if(GameToxicCircle[gameid][i][_GangZoneID]!=INVALID_GANG_ZONE)
	    {
	        GangZoneDestroy(GameToxicCircle[gameid][i][_GangZoneID]);
	        GameToxicCircle[gameid][i][_GangZoneID]=INVALID_GANG_ZONE;
	    }
	}
	if(LastAliveGame[gameid][_NontoxicZone]!=INVALID_GANG_ZONE)
    {
        GangZoneDestroy(LastAliveGame[gameid][_NontoxicZone]);
        LastAliveGame[gameid][_NontoxicZone]=INVALID_GANG_ZONE;
    }
	new Float:ZSetPos[MAX_GAME_CIRCLE_POS][MAX_GAME_CIRCLE_POS];
	new bool:ToxicCoincide[MAX_GAME_CIRCLE_POS];
	forex(i,MAX_GAME_CIRCLE_POS)ToxicCoincide[i]=false;
    forex(i,MAX_GAME_CIRCLE_POS)
	{
		switch(i)
		{
		    case 0:
		    {
		        if(ToxicCircleStartPosA[gameid][0][1]-amout<=LastAliveGame[gameid][_SafeMaxY])
				{
					ZSetPos[1][0]=LastAliveGame[gameid][_SafeMaxY];
					ZSetPos[1][1]=LastAliveGame[gameid][_SafeMaxY]+10.0;
					ToxicCoincide[i]=true;
				}
		        else
				{
					ZSetPos[1][0]=ToxicCircleStartPosA[gameid][0][1]-amout;
					ZSetPos[1][1]=ToxicCircleStartPosA[gameid][0][3]-amout;
					ToxicCoincide[i]=false;
				}
		    	ZSetPos[1][2]=ToxicCircleStartPosA[gameid][0][0]+amout;
		    	ZSetPos[1][3]=ToxicCircleStartPosA[gameid][0][2]-amout;
		    }
		    case 1://左 0
		    {
		        if(ToxicCircleStartPosA[gameid][1][0]-amout<=LastAliveGame[gameid][_SafeMaxX])
				{
					ZSetPos[0][0]=LastAliveGame[gameid][_SafeMaxX];
					ZSetPos[0][1]=LastAliveGame[gameid][_SafeMaxX]+10.0;
					ToxicCoincide[i]=true;
				}
		        else
				{
					ZSetPos[0][0]=ToxicCircleStartPosA[gameid][1][0]-amout;
					ZSetPos[0][1]=ToxicCircleStartPosA[gameid][1][2]-amout;
					ToxicCoincide[i]=false;
				}
		    	ZSetPos[0][2]=ToxicCircleStartPosA[gameid][1][1]+amout;
		    	ZSetPos[0][3]=ToxicCircleStartPosA[gameid][1][3]-amout;
		    }
		    case 2://下 3
		    {
		        if(ToxicCircleStartPosA[gameid][2][3]+amout>=LastAliveGame[gameid][_SafeMinY])
				{
					ZSetPos[3][0]=LastAliveGame[gameid][_SafeMinY];
					ZSetPos[3][1]=LastAliveGame[gameid][_SafeMinY]-10.0;
					ToxicCoincide[i]=true;
				}
		        else
				{
					ZSetPos[3][0]=ToxicCircleStartPosA[gameid][2][3]+amout;
					ZSetPos[3][1]=ToxicCircleStartPosA[gameid][2][1]+amout;
					ToxicCoincide[i]=false;
				}
		    	ZSetPos[3][2]=ToxicCircleStartPosA[gameid][2][0]+amout;
		    	ZSetPos[3][3]=ToxicCircleStartPosA[gameid][2][2]-amout;
		    }
		    case 3://右 2
		    {
		        if(ToxicCircleStartPosA[gameid][3][2]+amout>=LastAliveGame[gameid][_SafeMinX])
				{
					ZSetPos[2][0]=LastAliveGame[gameid][_SafeMinX];
					ZSetPos[2][1]=LastAliveGame[gameid][_SafeMinX]-10.0;
					ToxicCoincide[i]=true;
				}
		        else
				{
					ZSetPos[2][0]=ToxicCircleStartPosA[gameid][3][2]+amout;
					ZSetPos[2][1]=ToxicCircleStartPosA[gameid][3][0]+amout;
					ToxicCoincide[i]=false;
				}
		    	ZSetPos[2][2]=ToxicCircleStartPosA[gameid][3][1]+amout;
		    	ZSetPos[2][3]=ToxicCircleStartPosA[gameid][3][3]-amout;
		    }
		}
	}
	LastAliveGame[gameid][_NontoxicMinX]=ZSetPos[2][0];
	LastAliveGame[gameid][_NontoxicMinY]=ZSetPos[3][0];
	LastAliveGame[gameid][_NontoxicMaxX]=ZSetPos[0][0];
	LastAliveGame[gameid][_NontoxicMaxY]=ZSetPos[1][0];
	forex(i,MAX_GAME_CIRCLE_POS)
	{
	    switch(i)
	    {
			case 0://上
			{
				GameToxicCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[1][0],ZSetPos[0][0]+10.0,ZSetPos[1][0]+10.0);
			}
			case 1://左
			{
			    GameToxicCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[3][0]-10.0,ZSetPos[2][0],ZSetPos[1][0]+10.0);
			}
			case 2://下
			{
			    GameToxicCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[3][0]-10.0,ZSetPos[0][0]+10.0,ZSetPos[3][0]);
			}
			case 3://右
			{
			    GameToxicCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[0][0],ZSetPos[3][0],ZSetPos[0][0]+10.0,ZSetPos[1][0]);
			}
	    }
	}
	LastAliveGame[gameid][_NontoxicZone]=GangZoneCreate(ZSetPos[2][0],ZSetPos[3][0],ZSetPos[0][0],ZSetPos[1][0]);
	CreateToxicZoneWall(gameid,19946,ZSetPos[2][0],ZSetPos[3][0],ZSetPos[0][0],ZSetPos[1][0]);
	foreach(new s:Player)
	{
		if(Online(s))
		{
	 		if(pGameID(s)==gameid&&pGameIn(s)==true)
	 		{
				forex(i,MAX_GAME_CIRCLE_POS)
				{
				    GangZoneShowForPlayer(s,GameToxicCircle[gameid][i][_GangZoneID],0x345ACFFF);
				}
				GangZoneShowForPlayer(s,LastAliveGame[gameid][_NontoxicZone],0);
			}
		}
	}
	new Completed=0;
	forex(i,MAX_GAME_CIRCLE_POS)
	{
	    if(ToxicCoincide[i]==true)
		{
			Completed++;
		}
	}
	UpdateSmallMapCricle(gameid,0,ZSetPos[2][0],ZSetPos[3][0],ZSetPos[0][0],ZSetPos[1][0]);
	if(Completed>=4)
	{
	    ToxicCircleStartPosA[gameid][0][0]=ZSetPos[2][0]-10.0;
	    ToxicCircleStartPosA[gameid][0][1]=ZSetPos[1][0];
	    ToxicCircleStartPosA[gameid][0][2]=ZSetPos[0][0]+10.0;
	    ToxicCircleStartPosA[gameid][0][3]=ZSetPos[1][0]+10.0;
	    
	    ToxicCircleStartPosA[gameid][1][0]=ZSetPos[0][0];
	    ToxicCircleStartPosA[gameid][1][1]=ZSetPos[3][0]-10.0;
	    ToxicCircleStartPosA[gameid][1][2]=ZSetPos[0][0]+10.0;
	    ToxicCircleStartPosA[gameid][1][3]=ZSetPos[1][0]+10.0;
	    
	    ToxicCircleStartPosA[gameid][2][0]=ZSetPos[2][0]-10.0;
	    ToxicCircleStartPosA[gameid][2][1]=ZSetPos[3][0]-10.0;
	    ToxicCircleStartPosA[gameid][2][2]=ZSetPos[0][0]+10.0;
	    ToxicCircleStartPosA[gameid][2][3]=ZSetPos[3][0];
	    
	    ToxicCircleStartPosA[gameid][3][0]=ZSetPos[2][0]-10.0;
	    ToxicCircleStartPosA[gameid][3][1]=ZSetPos[3][0];
	    ToxicCircleStartPosA[gameid][3][2]=ZSetPos[2][0];
	    ToxicCircleStartPosA[gameid][3][3]=ZSetPos[1][0];
		return 1;
	}
    return 0;
}
N::CreateSafeCircle(gameid)
{
    new Float:StartMinX,Float:StartMinY,Float:StartMaxX,Float:StartMaxY,Float:CenterX,Float:CenterY,Float:CenterZ;
    StartMinX=frandoms(3000.0,-3000.0);
    StartMinY=frandoms(3000.0,-3000.0);
    while(StartMinX+2800.0+10.0>3000.0)StartMinX=frandoms(3000.0,-3000.0);
    while(StartMinY+2800.0+10.0>3000.0)StartMinY=frandoms(3000.0,-3000.0);
    StartMaxX=StartMinX+2800.0+10.0;
    StartMaxY=StartMinY+2800.0+10.0;
    GetZoneCenterPoint(StartMinX,StartMinY,StartMaxX,StartMaxY,CenterX,CenterY);
    Tryg3D::MapAndreasFindZ(CenterX,CenterY,CenterZ);
    while(CenterZ<3.0)
    {
	    StartMinX=frandoms(3000.0,-3000.0);
	    StartMinY=frandoms(3000.0,-3000.0);
	    while(StartMinX+2800.0+10.0>3000.0)StartMinX=frandoms(3000.0,-3000.0);
	    while(StartMinY+2800.0+10.0>3000.0)StartMinY=frandoms(3000.0,-3000.0);
	    StartMaxX=StartMinX+2800.0+10.0;
	    StartMaxY=StartMinY+2800.0+10.0;
	    GetZoneCenterPoint(StartMinX,StartMinY,StartMaxX,StartMaxY,CenterX,CenterY);
	    Tryg3D::MapAndreasFindZ(CenterX,CenterY,CenterZ);
    }
    
    SafeCircleStaticStartPos[gameid][0][0]=StartMinX;
    SafeCircleStaticStartPos[gameid][0][1]=StartMaxY-10.0;
    SafeCircleStaticStartPos[gameid][0][2]=StartMaxX;
    SafeCircleStaticStartPos[gameid][0][3]=StartMaxY;
    
    SafeCircleStaticStartPos[gameid][1][0]=StartMaxX-10.0;
    SafeCircleStaticStartPos[gameid][1][1]=StartMinY;
    SafeCircleStaticStartPos[gameid][1][2]=StartMaxX;
    SafeCircleStaticStartPos[gameid][1][3]=StartMaxY;
    
    SafeCircleStaticStartPos[gameid][2][0]=StartMinX;
    SafeCircleStaticStartPos[gameid][2][1]=StartMinY;
    SafeCircleStaticStartPos[gameid][2][2]=StartMaxX;
    SafeCircleStaticStartPos[gameid][2][3]=StartMinY+10.0;
    
    SafeCircleStaticStartPos[gameid][3][0]=StartMinX;
    SafeCircleStaticStartPos[gameid][3][1]=StartMinY;
    SafeCircleStaticStartPos[gameid][3][2]=StartMinX+10.0;
    SafeCircleStaticStartPos[gameid][3][3]=StartMaxY;
    
	LastAliveGame[gameid][_SafeMinX]=StartMinX;
	LastAliveGame[gameid][_SafeMinY]=StartMinY;
	LastAliveGame[gameid][_SafeMaxX]=StartMaxY;
	LastAliveGame[gameid][_SafeMaxY]=StartMaxY;
    return 1;
}
N::ChangeSafeCircle(gameid,Float:amout)
{
	new Float:ZSetPos[4][4];
    forex(i,MAX_GAME_CIRCLE_POS)
	{
		switch(i)
		{
		    case 0://上 1
		    {
		    	ZSetPos[1][0]=SafeCircleStaticStartPos[gameid][0][1]-amout;
		    	ZSetPos[1][1]=SafeCircleStaticStartPos[gameid][0][3]-amout;
		    	ZSetPos[1][2]=SafeCircleStaticStartPos[gameid][0][0]+amout;
		    	ZSetPos[1][3]=SafeCircleStaticStartPos[gameid][0][2]-amout;
		    }
		    case 1://左 0
		    {
		    	ZSetPos[0][0]=SafeCircleStaticStartPos[gameid][1][0]-amout;
		    	ZSetPos[0][1]=SafeCircleStaticStartPos[gameid][1][2]-amout;
		    	ZSetPos[0][2]=SafeCircleStaticStartPos[gameid][1][1]+amout;
		    	ZSetPos[0][3]=SafeCircleStaticStartPos[gameid][1][3]-amout;
		    }
		    case 2://下 3
		    {
		        ZSetPos[3][0]=SafeCircleStaticStartPos[gameid][2][3]+amout;
		        ZSetPos[3][1]=SafeCircleStaticStartPos[gameid][2][1]+amout;
		    	ZSetPos[3][2]=SafeCircleStaticStartPos[gameid][2][0]+amout;
		    	ZSetPos[3][3]=SafeCircleStaticStartPos[gameid][2][2]-amout;
		    }
		    case 3://右 2
		    {
		        ZSetPos[2][0]=SafeCircleStaticStartPos[gameid][3][2]+amout;
		        ZSetPos[2][1]=SafeCircleStaticStartPos[gameid][3][0]+amout;
		    	ZSetPos[2][2]=SafeCircleStaticStartPos[gameid][3][1]+amout;
		    	ZSetPos[2][3]=SafeCircleStaticStartPos[gameid][3][3]-amout;
		    }
		}
	}
    forex(i,MAX_GAME_CIRCLE_POS)
	{
	    if(GameSafeCircle[gameid][i][_GangZoneID]!=INVALID_GANG_ZONE)
	    {
	        GangZoneDestroy(GameSafeCircle[gameid][i][_GangZoneID]);
	        GameSafeCircle[gameid][i][_GangZoneID]=INVALID_GANG_ZONE;
	    }
	}
	if(LastAliveGame[gameid][_SafeZone]!=INVALID_GANG_ZONE)
    {
        GangZoneDestroy(LastAliveGame[gameid][_SafeZone]);
        LastAliveGame[gameid][_SafeZone]=INVALID_GANG_ZONE;
    }
	forex(i,MAX_GAME_CIRCLE_POS)
	{
	    switch(i)
	    {
			case 0://上
			{
				GameSafeCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[1][0],ZSetPos[0][0]+10.0,ZSetPos[1][0]+10.0);
			}
			case 1://左
			{
			    GameSafeCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[3][0]-10.0,ZSetPos[2][0],ZSetPos[1][0]+10.0);
			}
			case 2://下
			{
			    GameSafeCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[2][0]-10.0,ZSetPos[3][0]-10.0,ZSetPos[0][0]+10.0,ZSetPos[3][0]);
			}
			case 3://右
			{
			    GameSafeCircle[gameid][i][_GangZoneID]=GangZoneCreate(ZSetPos[0][0],ZSetPos[3][0],ZSetPos[0][0]+10.0,ZSetPos[1][0]);
			}
	    }
	}
	LastAliveGame[gameid][_SafeMinX]=ZSetPos[2][0];
	LastAliveGame[gameid][_SafeMinY]=ZSetPos[3][0];
	LastAliveGame[gameid][_SafeMaxX]=ZSetPos[0][0];
	LastAliveGame[gameid][_SafeMaxY]=ZSetPos[1][0];
	LastAliveGame[gameid][_SafeZone]=GangZoneCreate(ZSetPos[2][0],ZSetPos[3][0],ZSetPos[0][0],ZSetPos[1][0]);
    UpdateSmallMapCricle(gameid,1,ZSetPos[2][0],ZSetPos[3][0],ZSetPos[0][0],ZSetPos[1][0]);
	foreach(new s:Player)
	{
		if(Online(s))
		{
	 		if(pGameID(s)==gameid&&pGameIn(s)==true)
	 		{
				forex(i,MAX_GAME_CIRCLE_POS)
				{
				    GangZoneShowForPlayer(s,GameSafeCircle[gameid][i][_GangZoneID],0xFFFFFFFF);
				}
				GangZoneShowForPlayer(s,LastAliveGame[gameid][_SafeZone],0);
			}
		}
	}
    return 1;
}
N::DestroyPlayerSmallArrow(playerid)
{
	if(pLastAlive[playerid][_Small_Arrow_Draw]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    PlayerTextDrawHide(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		PlayerTextDrawDestroy(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		pLastAlive[playerid][_Small_Arrow_Draw]=PlayerText:INVALID_TEXT_DRAW;
	}
    return 1;
}
N::UpdatePlayerSmallArrow(playerid)
{
	DestroyPlayerSmallArrow(playerid);
	new Float:MapX=floatadd(296.0,floatdiv(floatsub(PlayerPos[playerid][_X],0.0),16.66666666666667));
	new Float:MapY=floatsub(186.0,floatdiv(floatsub(PlayerPos[playerid][_Y],0.0),16.66666666666667));
 	if((PlayerPos[playerid][_A]>=337.5&&PlayerPos[playerid][_A]<=360.0)||(PlayerPos[playerid][_A]>=0.0&&PlayerPos[playerid][_A]<22.5))CreatePlayerSmallArrow(playerid,0,MapX,MapY);
	else if(PlayerPos[playerid][_A]>=22.5&&PlayerPos[playerid][_A]<67.5)CreatePlayerSmallArrow(playerid,1,MapX,MapY);
	else if(PlayerPos[playerid][_A]>=67.5&&PlayerPos[playerid][_A]<112.5)CreatePlayerSmallArrow(playerid,2,MapX,MapY);
	else if(PlayerPos[playerid][_A]>=112.5&&PlayerPos[playerid][_A]<157.5)CreatePlayerSmallArrow(playerid,3,MapX,MapY);
	else if(PlayerPos[playerid][_A]>=112.5&&PlayerPos[playerid][_A]<202.5)CreatePlayerSmallArrow(playerid,4,MapX,MapY);
	else if(PlayerPos[playerid][_A]>=202.5&&PlayerPos[playerid][_A]<247.5)CreatePlayerSmallArrow(playerid,5,MapX,MapY);
    else if(PlayerPos[playerid][_A]>=247.5&&PlayerPos[playerid][_A]<292.5)CreatePlayerSmallArrow(playerid,6,MapX,MapY);
    else if(PlayerPos[playerid][_A]>=292.5&&PlayerPos[playerid][_A]<337.5)CreatePlayerSmallArrow(playerid,7,MapX,MapY);
    return 1;
}
N::CreatePlayerSmallArrow(playerid,type,Float:xx,Float:yy)
{
	switch(type)
	{
		case 0:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:up");//0
		case 1:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:upl");//1
		case 2:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:left");//2
		case 3:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:downl");//3
		case 4:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:down");//4
		case 5:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:downr");//5
		case 6:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:right");//6
		case 7:pLastAlive[playerid][_Small_Arrow_Draw] = CreatePlayerTextDraw(playerid,xx,yy,"LD_BEAT:upr");//7
	}
	PlayerTextDrawFont(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 4);
	PlayerTextDrawLetterSize(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 15.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 1);
	PlayerTextDrawSetShadow(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 0);
	PlayerTextDrawAlignment(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 1);
	PlayerTextDrawColor(playerid,pLastAlive[playerid][_Small_Arrow_Draw], -1);
	PlayerTextDrawBackgroundColor(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 255);
	PlayerTextDrawBoxColor(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 50);
	PlayerTextDrawUseBox(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 1);
	PlayerTextDrawSetProportional(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 1);
	PlayerTextDrawSetSelectable(playerid,pLastAlive[playerid][_Small_Arrow_Draw], 0);
	PlayerTextDrawShow(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
	return 1;
}
stock Text:CreateToxicBox(Float:Xpos,Float:Ypos,Float:LetterSizeY,Float:TextSizeX)
{
	new Text:GameTextDraw = TextDrawCreate(Xpos+10.0, Ypos+10.0, "~n~");
	TextDrawFont(GameTextDraw, 1);
	TextDrawLetterSize(GameTextDraw, 0.600000,LetterSizeY);
	TextDrawTextSize(GameTextDraw,TextSizeX+10.0, 17.000000);
	TextDrawSetOutline(GameTextDraw, 1);
	TextDrawSetShadow(GameTextDraw, 0);
	TextDrawAlignment(GameTextDraw, 1);
	TextDrawColor(GameTextDraw, -1);
	TextDrawBackgroundColor(GameTextDraw, 255);
	TextDrawBoxColor(GameTextDraw, 65316);
	TextDrawUseBox(GameTextDraw, 1);
	TextDrawSetProportional(GameTextDraw, 1);
	TextDrawSetSelectable(GameTextDraw, 0);
    return GameTextDraw;
}
stock Text:CreateSafeBox(Float:Xpos,Float:Ypos,Float:LetterSizeY,Float:TextSizeX)
{
	new Text:GameTextDraw = TextDrawCreate(Xpos+10.0, Ypos+10.0, "~n~");
	TextDrawFont(GameTextDraw, 1);
	TextDrawLetterSize(GameTextDraw, 0.600000,LetterSizeY);
	TextDrawTextSize(GameTextDraw,TextSizeX+10.0, 17.000000);
	TextDrawSetOutline(GameTextDraw, 1);
	TextDrawSetShadow(GameTextDraw, 0);
	TextDrawAlignment(GameTextDraw, 1);
	TextDrawColor(GameTextDraw, -1);
	TextDrawBackgroundColor(GameTextDraw, 255);
	TextDrawBoxColor(GameTextDraw, -150);
	TextDrawUseBox(GameTextDraw, 1);
	TextDrawSetProportional(GameTextDraw, 1);
	TextDrawSetSelectable(GameTextDraw, 0);
    return GameTextDraw;
}
N::UpdateSmallMapCricle(gameid,type,Float:MinX,Float:MinY,Float:MaxX,Float:MaxY)
{
	switch(type)
	{
	    case 0:
	    {
			if(LastAliveGame[gameid][_SmallMap_Toxic_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(LastAliveGame[gameid][_SmallMap_Toxic_Circle]);
			LastAliveGame[gameid][_SmallMap_Toxic_Circle]=Text:INVALID_TEXT_DRAW;
		    new Float:_minx=floatadd(296.0,floatdiv(floatsub(MinX,0.0),16.66666666666667));
			new Float:_miny=floatsub(186.0,floatdiv(floatsub(MinY,0.0),16.66666666666667));
		    new Float:_maxx=floatadd(296.0,floatdiv(floatsub(MaxX,0.0),16.66666666666667));
			new Float:_maxy=floatsub(186.0,floatdiv(floatsub(MaxY,0.0),16.66666666666667));
			LastAliveGame[gameid][_SmallMap_Toxic_Circle]=CreateToxicBox(_minx,_maxy,floatdiv(floatsub(_miny,_maxy),9.000),_maxx);
			foreach(new s:Player)
			{
				if(Online(s))
				{
			 		if(pGameID(s)==gameid&&pGameIn(s)==true)
			 		{
			 		    if(pLastAlive[s][_Show_SmallMap]==true)TextDrawShowForPlayer(s,LastAliveGame[gameid][_SmallMap_Toxic_Circle]);
					}
				}
			}
	    }
	    case 1:
	    {
			if(LastAliveGame[gameid][_SmallMap_Safe_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawDestroy(LastAliveGame[gameid][_SmallMap_Safe_Circle]);
			LastAliveGame[gameid][_SmallMap_Safe_Circle]=Text:INVALID_TEXT_DRAW;
		    new Float:_minx=floatadd(296.0,floatdiv(floatsub(MinX,0.0),16.66666666666667));
			new Float:_miny=floatsub(186.0,floatdiv(floatsub(MinY,0.0),16.66666666666667));
		    new Float:_maxx=floatadd(296.0,floatdiv(floatsub(MaxX,0.0),16.66666666666667));
			new Float:_maxy=floatsub(186.0,floatdiv(floatsub(MaxY,0.0),16.66666666666667));
			LastAliveGame[gameid][_SmallMap_Safe_Circle]=CreateSafeBox(_minx,_maxy,floatdiv(floatsub(_miny,_maxy),9.000),_maxx);
			foreach(new s:Player)
			{
				if(Online(s))
				{
			 		if(pGameID(s)==gameid&&pGameIn(s)==true)
			 		{
						if(pLastAlive[s][_Show_SmallMap]==true)TextDrawShowForPlayer(s,LastAliveGame[gameid][_SmallMap_Safe_Circle]);
					}
				}
			}
	    }
	}
	return 1;
}

N::ShowPlayerSmallMap(playerid)
{
	HidePlayerSmallMapBackGround(playerid);
    if(LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]);
    if(LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]);
	if(pLastAlive[playerid][_Small_Arrow_Draw]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    PlayerTextDrawHide(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		PlayerTextDrawDestroy(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		pLastAlive[playerid][_Small_Arrow_Draw]=PlayerText:INVALID_TEXT_DRAW;
	}
    pLastAlive[playerid][_Show_SmallMap]=true;
    if(LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawShowForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]);
    if(LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawShowForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]);
    ShowPlayerSmallMapBackGround(playerid);
    ShowPayerDeathBoxMapIcon(playerid,pGameID(playerid));
	return 1;
}
N::HidePlayerSmallMap(playerid)
{
    pLastAlive[playerid][_Show_SmallMap]=false;
	HidePlayerSmallMapBackGround(playerid);
	if(pGameID(playerid)!=NONE)
	{
	    HidePayerDeathBoxMapIcon(playerid,pGameID(playerid));
    	if(LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Toxic_Circle]);
    	if(LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]!=Text:INVALID_TEXT_DRAW)TextDrawHideForPlayer(playerid,LastAliveGame[pGameID(playerid)][_SmallMap_Safe_Circle]);
	}
	if(pLastAlive[playerid][_Small_Arrow_Draw]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    PlayerTextDrawHide(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		PlayerTextDrawDestroy(playerid,pLastAlive[playerid][_Small_Arrow_Draw]);
		pLastAlive[playerid][_Small_Arrow_Draw]=PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}
N::DestoryToxicZoneWall(gameid)
{
	forex(i,MAX_WALL)
	{
	    if(LastAliveGame[gameid][Wall0][i]!=INVALID_STREAMER_ID)
	    {
	        DestroyDynamicObject(LastAliveGame[gameid][Wall0][i]);
	        LastAliveGame[gameid][Wall0][i]=INVALID_STREAMER_ID;
	    }
	    if(LastAliveGame[gameid][Wall1][i]!=INVALID_STREAMER_ID)
	    {
	        DestroyDynamicObject(LastAliveGame[gameid][Wall1][i]);
	        LastAliveGame[gameid][Wall1][i]=INVALID_STREAMER_ID;
	    }
	    if(LastAliveGame[gameid][Wall2][i]!=INVALID_STREAMER_ID)
	    {
	        DestroyDynamicObject(LastAliveGame[gameid][Wall2][i]);
	        LastAliveGame[gameid][Wall2][i]=INVALID_STREAMER_ID;
	    }
	    if(LastAliveGame[gameid][Wall3][i]!=INVALID_STREAMER_ID)
	    {
	        DestroyDynamicObject(LastAliveGame[gameid][Wall3][i]);
	        LastAliveGame[gameid][Wall3][i]=INVALID_STREAMER_ID;
	    }
	}
	return 1;
}
N::CreateToxicZoneWall(gameid,model,Float:minX,Float:minY,Float:maxX,Float:maxY)
{
    DestoryToxicZoneWall(gameid);
	new pointdistance[4];
	pointdistance[0]=floatround(GetDistanceBetweenPoints2D(minX,minY,minX,maxY));
	pointdistance[1]=floatround(GetDistanceBetweenPoints2D(minX,minY,maxX,minY));
	pointdistance[2]=floatround(GetDistanceBetweenPoints2D(maxX,minY,maxX,maxY));
	pointdistance[3]=floatround(GetDistanceBetweenPoints2D(maxX,maxY,minX,maxY));
	new amouts[4];
	if(amouts[0]>=MAX_WALL||amouts[1]>=MAX_WALL||amouts[2]>=MAX_WALL||amouts[3]>=MAX_WALL)return 0;
	amouts[0]=floatround(pointdistance[0]/16);
	amouts[1]=floatround(pointdistance[1]/16);
	amouts[2]=floatround(pointdistance[2]/16);
	amouts[3]=floatround(pointdistance[3]/16);
	for(new i=0;i<amouts[0];i++)
	{
	    //Tryg3D::MapAndreasFindZ(minX,minY+(((maxY-minY)/amouts[0])*i),tempZ);
		LastAliveGame[gameid][Wall0][i]=CreateDynamicObject(model,minX,minY+(((maxY-minY)/amouts[0])*i),0.0,0.0000,0.0000,0.0000,GameRoom(gameid),0,-1,500.0);
        SetDynamicObjectMaterial(LastAliveGame[gameid][Wall0][i],0,19604,"ballyswater","waterclear256");
	}
	for(new i=0;i<amouts[1];i++)
	{
	    //Tryg3D::MapAndreasFindZ(minX+(((maxX-minX)/amouts[1])*i),minY,tempZ);
		LastAliveGame[gameid][Wall1][i]=CreateDynamicObject(model,minX+(((maxX-minX)/amouts[1])*i),minY,0.0,0.0000,0.0000,0.0000,GameRoom(gameid),0,-1,500.0);
        SetDynamicObjectMaterial(LastAliveGame[gameid][Wall1][i],0,19604,"ballyswater","waterclear256");
    }
	for(new i=0;i<amouts[2];i++)
	{
	   //Tryg3D::MapAndreasFindZ(maxX,minY+(((maxY-minY)/amouts[2])*i),tempZ);
		LastAliveGame[gameid][Wall2][i]=CreateDynamicObject(model,maxX,minY+(((maxY-minY)/amouts[2])*i),0.0,0.0000,0.0000,0.0000,GameRoom(gameid),0,-1,500.0);
		SetDynamicObjectMaterial(LastAliveGame[gameid][Wall2][i],0,19604,"ballyswater","waterclear256");
    }
	for(new i=0;i<amouts[3];i++)
	{
	    //Tryg3D::MapAndreasFindZ(maxX-(((maxX-minX)/amouts[3])*i),maxY,tempZ);
		LastAliveGame[gameid][Wall3][i]=CreateDynamicObject(model,maxX-(((maxX-minX)/amouts[3])*i),maxY,0.0,0.0000,0.0000,0.0000,GameRoom(gameid),0,-1,500.0);
		SetDynamicObjectMaterial(LastAliveGame[gameid][Wall3][i],0,19604,"ballyswater","waterclear256");
	}
	return 1;
}
N::CreateZoneWall(model,Float:minX,Float:minY,Float:maxX,Float:maxY,world)
{
	new pointdistance[4];
	pointdistance[0]=floatround(GetDistanceBetweenPoints2D(minX,minY,minX,maxY));
	pointdistance[1]=floatround(GetDistanceBetweenPoints2D(minX,minY,maxX,minY));
	pointdistance[2]=floatround(GetDistanceBetweenPoints2D(maxX,minY,maxX,maxY));
	pointdistance[3]=floatround(GetDistanceBetweenPoints2D(maxX,maxY,minX,maxY));
	new amouts[4];
	if(amouts[0]>=MAX_WALL||amouts[1]>=MAX_WALL||amouts[2]>=MAX_WALL||amouts[3]>=MAX_WALL)return 0;
	amouts[0]=floatround(pointdistance[0]/16);
	amouts[1]=floatround(pointdistance[1]/16);
	amouts[2]=floatround(pointdistance[2]/16);
	amouts[3]=floatround(pointdistance[3]/16);
	new objectid;
	for(new i=0;i<amouts[0];i++)
	{
	    //Tryg3D::MapAndreasFindZ(minX,minY+(((maxY-minY)/amouts[0])*i),tempZ);
		objectid=CreateDynamicObject(model,minX,minY+(((maxY-minY)/amouts[0])*i),-1.0,0.0000,0.0000,0.0000,world,0,-1,500.0);
        SetDynamicObjectMaterial(objectid,0,19604,"ballyswater","waterclear256");
	}
	for(new i=0;i<amouts[1];i++)
	{
	    //Tryg3D::MapAndreasFindZ(minX+(((maxX-minX)/amouts[1])*i),minY,tempZ);
		objectid=CreateDynamicObject(model,minX+(((maxX-minX)/amouts[1])*i),minY,-1.0,0.0000,0.0000,0.0000,world,0,-1,500.0);
        SetDynamicObjectMaterial(objectid,0,19604,"ballyswater","waterclear256");
    }
	for(new i=0;i<amouts[2];i++)
	{
	   //Tryg3D::MapAndreasFindZ(maxX,minY+(((maxY-minY)/amouts[2])*i),tempZ);
		objectid=CreateDynamicObject(model,maxX,minY+(((maxY-minY)/amouts[2])*i),-1.0,0.0000,0.0000,0.0000,world,0,-1,500.0);
		SetDynamicObjectMaterial(objectid,0,19604,"ballyswater","waterclear256");
    }
	for(new i=0;i<amouts[3];i++)
	{
	    //Tryg3D::MapAndreasFindZ(maxX-(((maxX-minX)/amouts[3])*i),maxY,tempZ);
		objectid=CreateDynamicObject(model,maxX-(((maxX-minX)/amouts[3])*i),maxY,-1.0,0.0000,0.0000,0.0000,world,0,-1,500.0);
		SetDynamicObjectMaterial(objectid,0,19604,"ballyswater","waterclear256");
	}
	return 1;
}
