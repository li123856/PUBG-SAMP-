N::CreatePlayerCompass(playerid)
{
    DestoryPlayerCompass(playerid);
	pCompassDraw[playerid][0] = CreatePlayerTextDraw(playerid, 200.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][0], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][0], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][0], 0);

	pCompassDraw[playerid][1] = CreatePlayerTextDraw(playerid, 240.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][1], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][1], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][1], 0);

	pCompassDraw[playerid][2] = CreatePlayerTextDraw(playerid, 280.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][2], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][2], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][2], 0);

	pCompassDraw[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][3], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][3], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][3], 0);

	pCompassDraw[playerid][4] = CreatePlayerTextDraw(playerid, 360.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][4], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][4], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][4], 0);

	pCompassDraw[playerid][5] = CreatePlayerTextDraw(playerid, 400.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][5], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][5], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][5], 0);

	pCompassDraw[playerid][6] = CreatePlayerTextDraw(playerid, 440.000000, 13.000000, " ");
	PlayerTextDrawFont(playerid, pCompassDraw[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, pCompassDraw[playerid][6], 0.287499, 1.399999);
	PlayerTextDrawTextSize(playerid, pCompassDraw[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, pCompassDraw[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, pCompassDraw[playerid][6], 2);
	PlayerTextDrawColor(playerid, pCompassDraw[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, pCompassDraw[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, pCompassDraw[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, pCompassDraw[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, pCompassDraw[playerid][6], 0);
	ShowPlayerCompassPrive(playerid);
	CompassDirection[playerid]=NONE;
	return 1;
}
N::DestoryPlayerCompass(playerid)
{
	forex(i,MAX_UICOMPASS_TD)
	{
		if(pCompassDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)
		{
			PlayerTextDrawDestroy(playerid,pCompassDraw[playerid][i]);
		    pCompassDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		}
	}
	HidePlayerCompassPrive(playerid);
	return 1;
}
N::ShowPlayerCompassPrive(playerid)
{
	forex(i,MAX_COMPASSPRIVES)TextDrawShowForPlayer(playerid,CompassPrive[i]);
	return 1;
}
N::HidePlayerCompassPrive(playerid)
{
	forex(i,MAX_COMPASSPRIVES)TextDrawHideForPlayer(playerid,CompassPrive[i]);
	return 1;
}
N::OnPlayerCompassDirectionChange(playerid,NewDirection,OldDirection)
{
    if(PlayerInState[playerid]==PLAYER_IN_WAITROOM||PlayerInState[playerid]==PLAYER_IN_GAMEROOM)
    {
		new bool:drawok=true;
		forex(i,MAX_UICOMPASS_TD)
		{
			if(pCompassDraw[playerid][i]==PlayerText:INVALID_TEXT_DRAW)drawok=false;
		}
		if(drawok==true)
		{
		    static const
		        step_1 = 15 * 1,
		        step_2 = 15 * 2,
		        step_3 = 15 * 3;

		    static
		        north,
		        result;
		    result = NewDirection;
		    north = CompassHeadingNorth(result);

		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][0], CreateCompassString(result - step_3));
		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][1], CreateCompassString(result - step_2));
		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][2], CreateCompassString(result - step_1));

		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][3], CreateCompassString(result));

		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][4], CreateCompassString(result + step_1));
		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][5], CreateCompassString(result + step_2));
		    PlayerTextDrawSetString(playerid, pCompassDraw[playerid][6], CreateCompassString(result + step_3));

		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][0], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][0]);
		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][1], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][1]);
		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][2], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][2]);
		    if(north!=3)
		    {
				PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][3], 1);
				PlayerTextDrawColor(playerid, pCompassDraw[playerid][3], 255);
				PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][3], -1);
				PlayerTextDrawShow(playerid, pCompassDraw[playerid][3]);
			}
			else
			{
				PlayerTextDrawSetOutline(playerid, pCompassDraw[playerid][3], 1);
				PlayerTextDrawBackgroundColor(playerid, pCompassDraw[playerid][3], 255);
			}
		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][4], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][4]);
		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][5], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][5]);
		    PlayerTextDrawColor(playerid, pCompassDraw[playerid][6], 0xFFFFFFFF);
		    PlayerTextDrawShow(playerid, pCompassDraw[playerid][6]);

		    if (0 <= north < MAX_UICOMPASS_TD)
		    {
		        PlayerTextDrawColor(playerid, pCompassDraw[playerid][north], 0xFFFF00FF);
		        PlayerTextDrawShow(playerid, pCompassDraw[playerid][north]);
		    }
		}
	}
	return 1;
}

