N::ShowPlayerFaceMenu(playerid,bool:showgametype)
{
    ClearChat(playerid);
    forex(i,20)
	{
	    TextDrawShowForPlayer(playerid,FaceMenuDraw[i]);
	}
	fLine_32("%i",Account[playerid][_Gold]);
	CreatePlayerFaceMenuCdsDraw(playerid,line);
	CreatePlayerFaceMenuBotton(playerid,Iter_Count(pFriends[playerid]),Iter_Count(pMails[playerid]),Iter_Count(MusicBox));
	CreatePlayerFaceMenuLevel(playerid,Account[playerid][_Level],Account[playerid][_Exp],LevelRank[Account[playerid][_Level]+1][_needexp]);
	CreatePlayerFaceMenuTimes(playerid);
	CreatePlayerFaceMenuCounts(playerid);
	SelectTextDraw(playerid, 0xFF4040AA);
	PlayerPlayBottonCount[playerid]=0;
	return 1;
}
N::HidePlayerFaceMenu(playerid)
{
    forex(i,MAX_FACEMENU_DRAWS)TextDrawHideForPlayer(playerid,FaceMenuDraw[i]);
    HidePlayerFaceMenuModeDraw(playerid);
	DestoryPlayerFaceMenuCdsDraw(playerid);
	HideUserMall(playerid,true);
	HideUserBag(playerid,true);
	DestoryPlayerFaceMenuBotton(playerid);
	DestoryPlayerFaceMenuLevel(playerid);
	DestoryPlayerFaceMenuTimes(playerid);
	DestoryPlayerFaceMenuCounts(playerid);
    CancelSelectTextDraw(playerid);
	return 1;
}
N::FaceMenu@OnGameModeInit()
{
	new Text:FaceMenuText=Text:INVALID_TEXT_DRAW;//upbackground
	FaceMenuText = TextDrawCreate(321.000000, 26.000000, "~n~");
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.250000);
	TextDrawTextSize(FaceMenuText, 400.000000, 647.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 40);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[0]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(321.000000, 25.000000, "~n~");//upupline
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, -0.249998);
	TextDrawTextSize(FaceMenuText, 400.000000, 647.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[1]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(321.000000, 50.000000, "~n~");//updownline
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, -0.249998);
	TextDrawTextSize(FaceMenuText, 400.000000, 647.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[2]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(152.000000, 27.000000, "MYBAG");//homebotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.491665, 1.850000);
	TextDrawTextSize(FaceMenuText, 208.000000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[3]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(270.000000, 27.000000, "ITEM&STORE");//characterbotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.491665, 1.850000);
	TextDrawTextSize(FaceMenuText, 385.000000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[4]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(441.000000, 26.000000, "CONFIG");//statsbotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.491665, 1.850000);
	TextDrawTextSize(FaceMenuText, 505.000000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[5]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(553.000000, 26.000000, "CREDITS");//otherbotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.491665, 1.850000);
	TextDrawTextSize(FaceMenuText, 634.000000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[6]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(-72.000000, -98.000000, "~n~");//playbackground
	TextDrawFont(FaceMenuText, 5);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 165.500000, 226.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -16776961);
	TextDrawBackgroundColor(FaceMenuText, 0);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	TextDrawSetPreviewModel(FaceMenuText, 8324);
	TextDrawSetPreviewRot(FaceMenuText, 188.000000, -32.000000, 3.000000, 0.930000);
	TextDrawSetPreviewVehCol(FaceMenuText, 1, 1);
	FaceMenuDraw[7]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(0.000000, 6.000000, "PLAY");//playbotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.537499, 3.249999);
	TextDrawTextSize(FaceMenuText, 48.500000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -65281);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[8]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(113.000000, 26.000000, "~n~");//upverticalline
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.299998);
	TextDrawTextSize(FaceMenuText, 400.000000, -1.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[9]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(57.000000, 30.000000, "MODE");//modebotton
	TextDrawFont(FaceMenuText, 2);
	TextDrawLetterSize(FaceMenuText, 0.387499, 1.450000);
	TextDrawTextSize(FaceMenuText, 102.000000, 17.000000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1378294017);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	FaceMenuDraw[10]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

/*	FaceMenuText = TextDrawCreate(417.000000, 115.000000, "~n~");
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.399997);
	TextDrawTextSize(FaceMenuText, 400.000000, 103.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 65);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[11]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;*/

	FaceMenuText = TextDrawCreate(366.000000, 115.000000, "CD:");
	TextDrawFont(FaceMenuText, 5);
	TextDrawLetterSize(FaceMenuText, 0.524999, 2.000000);
	TextDrawTextSize(FaceMenuText, 19.500000, 20.000000);
	TextDrawSetOutline(FaceMenuText, 2);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 0);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 0);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	TextDrawSetPreviewModel(FaceMenuText, 1855);
	TextDrawSetPreviewRot(FaceMenuText, -89.000000, 0.000000, 1.000000, 0.779999);
	TextDrawSetPreviewVehCol(FaceMenuText, 1, 1);
	FaceMenuDraw[11]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(160.000000, 415.000000, "~n~");//friendback
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 400.000000, 111.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[12]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(320.000000, 415.000000, "~n~");//mailback
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 400.000000, 111.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[13]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(480.000000, 415.000000, "~n~");//otherback
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 400.000000, 111.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[14]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(320.000000, 441.000000, "~n~");//levelback
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 0.549999);
	TextDrawTextSize(FaceMenuText, 400.000000, 656.000000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -226);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[15]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(0.000000, 192.000000, "~n~");//cameraback
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.474999, 2.849997);
	TextDrawTextSize(FaceMenuText, 27.500000, 137.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -233);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[16]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(0.000000, 191.000000, "~n~");//camera
	TextDrawFont(FaceMenuText, 5);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 27.000000, 29.000000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 0);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	TextDrawSetPreviewModel(FaceMenuText, 1253);
	TextDrawSetPreviewRot(FaceMenuText, -10.000000, 0.000000, 175.000000, 0.870000);
	TextDrawSetPreviewVehCol(FaceMenuText, 1, 1);
	FaceMenuDraw[17]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;
	
	FaceMenuText = TextDrawCreate(0.000000, 230.000000, "~n~");
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.474999, 2.849997);
	TextDrawTextSize(FaceMenuText, 27.500000, 137.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 1);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -156);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[18]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(0.000000, 230.000000, "~n~");
	TextDrawFont(FaceMenuText, 5);
	TextDrawLetterSize(FaceMenuText, 0.600000, 2.000000);
	TextDrawTextSize(FaceMenuText, 27.000000, 29.000000);
	TextDrawSetOutline(FaceMenuText, 0);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, 255);
	TextDrawBackgroundColor(FaceMenuText, 0);
	TextDrawBoxColor(FaceMenuText, 255);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 1);
	TextDrawSetPreviewModel(FaceMenuText, 1314);
	TextDrawSetPreviewRot(FaceMenuText, -3.000000, 0.000000, 188.000000, 0.750000);
	TextDrawSetPreviewVehCol(FaceMenuText, 1, 1);
	FaceMenuDraw[19]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;
	
	FaceMenuText = TextDrawCreate(74.000000, 51.000000, "~n~");//modebackground
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 7.849977);
	TextDrawTextSize(FaceMenuText, 400.000000, 74.000000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, 50);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[20]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(113.000000, 51.000000, "~n~");//modeline1
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 8.049988);
	TextDrawTextSize(FaceMenuText, 400.000000, -1.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[21]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(35.000000, 51.000000, "~n~");//modeline2
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, 8.049988);
	TextDrawTextSize(FaceMenuText, 400.000000, -1.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[22]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(74.000000, 126.000000, "~n~");//modeline3
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, -0.249998);
	TextDrawTextSize(FaceMenuText, 400.000000, 76.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[23]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(74.000000, 75.000000, "~n~");//modeline4
	TextDrawFont(FaceMenuText, 1);
	TextDrawLetterSize(FaceMenuText, 0.600000, -0.249998);
	TextDrawTextSize(FaceMenuText, 400.000000, 76.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[24]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;

	FaceMenuText = TextDrawCreate(74.000000, 100.000000, "~n~");//modeline5
	TextDrawFont(FaceMenuText, 0);
	TextDrawLetterSize(FaceMenuText, 0.600000, -0.249998);
	TextDrawTextSize(FaceMenuText, 400.000000, 76.500000);
	TextDrawSetOutline(FaceMenuText, 1);
	TextDrawSetShadow(FaceMenuText, 0);
	TextDrawAlignment(FaceMenuText, 2);
	TextDrawColor(FaceMenuText, -1);
	TextDrawBackgroundColor(FaceMenuText, 255);
	TextDrawBoxColor(FaceMenuText, -3841);
	TextDrawUseBox(FaceMenuText, 1);
	TextDrawSetProportional(FaceMenuText, 1);
	TextDrawSetSelectable(FaceMenuText, 0);
	FaceMenuDraw[25]=FaceMenuText;
	FaceMenuText=Text:INVALID_TEXT_DRAW;
	return 1;
}
N::UpdatePlayerFriendsBotton(playerid)
{
	if(FriendsBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    fLine_64("FRIENDS(%i)",Iter_Count(pFriends[playerid]));
	    PlayerTextDrawSetString(playerid,FriendsBotton[playerid],line);
	}
	return 1;
}
N::UpdatePlayerMailsBotton(playerid)
{
	if(MailsBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    fLine_64("MAILS(%i)",Iter_Count(pMails[playerid]));
	    PlayerTextDrawSetString(playerid,MailsBotton[playerid],line);
	}
	return 1;
}

N::CreatePlayerFaceMenuCounts(playerid)
{
    DestoryPlayerFaceMenuCounts(playerid);
    fLine_64("Online Times %s",ReturnOnlineStr(Account[playerid][_OnlineCounts]));
	FaceMenuOnlineCountDraw[playerid] = CreatePlayerTextDraw(playerid, 45.000000, 438.000000, line);
	PlayerTextDrawFont(playerid, FaceMenuOnlineCountDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, FaceMenuOnlineCountDraw[playerid], 0.170833, 1.049999);
	PlayerTextDrawTextSize(playerid, FaceMenuOnlineCountDraw[playerid], 400.000000, 177.000000);
	PlayerTextDrawSetOutline(playerid, FaceMenuOnlineCountDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FaceMenuOnlineCountDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, FaceMenuOnlineCountDraw[playerid], 2);
	PlayerTextDrawColor(playerid, FaceMenuOnlineCountDraw[playerid], 0xC0C0C0C8);
	PlayerTextDrawBackgroundColor(playerid, FaceMenuOnlineCountDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FaceMenuOnlineCountDraw[playerid], -2686926);
	PlayerTextDrawUseBox(playerid, FaceMenuOnlineCountDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FaceMenuOnlineCountDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FaceMenuOnlineCountDraw[playerid], 0);
	PlayerTextDrawShow(playerid,FaceMenuOnlineCountDraw[playerid]);
	return 1;
}
N::UpdatePlayerFaceMenuCounts(playerid)
{
	Account[playerid][_OnlineCounts]++;
    if(FaceMenuOnlineCountDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)
    {
    	fLine_64("Online Times %s",ReturnOnlineStr(Account[playerid][_OnlineCounts]));
    	PlayerTextDrawSetString(playerid,FaceMenuOnlineCountDraw[playerid],line);
    }
	return 1;
}
N::DestoryPlayerFaceMenuCounts(playerid)
{
	if(FaceMenuOnlineCountDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,FaceMenuOnlineCountDraw[playerid]);
	FaceMenuOnlineCountDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}


N::CreatePlayerFaceMenuTimes(playerid)
{
    DestoryPlayerFaceMenuTimes(playerid);
	new TempHour=0,TempMinute=0,TempSecond=0,TempYear=0,TempMonth=0,TempDay=0;
    gettime(TempHour,TempMinute,TempSecond);
    getdate(TempYear,TempMonth,TempDay);
    
    fLine_64("%i/%02i/%02i %02i:%02i:%02i",TempYear,TempMonth,TempDay,TempHour,TempMinute,TempSecond);
	FaceMenuTimeDraw[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 438.000000, line);
	PlayerTextDrawFont(playerid, FaceMenuTimeDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, FaceMenuTimeDraw[playerid], 0.170833, 1.049999);
	PlayerTextDrawTextSize(playerid, FaceMenuTimeDraw[playerid], 400.000000, 177.000000);
	PlayerTextDrawSetOutline(playerid, FaceMenuTimeDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FaceMenuTimeDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, FaceMenuTimeDraw[playerid], 2);
	PlayerTextDrawColor(playerid, FaceMenuTimeDraw[playerid], 0xC0C0C0C8);
	PlayerTextDrawBackgroundColor(playerid, FaceMenuTimeDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FaceMenuTimeDraw[playerid], -2686926);
	PlayerTextDrawUseBox(playerid, FaceMenuTimeDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FaceMenuTimeDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FaceMenuTimeDraw[playerid], 0);
	PlayerTextDrawShow(playerid,FaceMenuTimeDraw[playerid]);
	return 1;
}
N::UpdatePlayerFaceMenuTimes(playerid,Hour,Minute,Second)
{
    if(FaceMenuTimeDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)
    {
		new TempYear=0,TempMonth=0,TempDay=0;
    	getdate(TempYear,TempMonth,TempDay);
    	fLine_64("%i/%s/%s %s:%s:%s",TempYear,OutputNumber(TempMonth),OutputNumber(TempDay),OutputNumber(Hour),OutputNumber(Minute),OutputNumber(Second));
    	PlayerTextDrawSetString(playerid,FaceMenuTimeDraw[playerid],line);
    }
	return 1;
}
N::DestoryPlayerFaceMenuTimes(playerid)
{
	if(FaceMenuTimeDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,FaceMenuTimeDraw[playerid]);
	FaceMenuTimeDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

N::CreatePlayerFaceMenuLevel(playerid,level,exp,needexp)
{
    DestoryPlayerFaceMenuLevel(playerid);
    fLine_64("LEVEL %i   EXP %i/%i",level,exp,needexp);
	FaceMenuLevelDraw[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 438.000000, line);
	PlayerTextDrawFont(playerid, FaceMenuLevelDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, FaceMenuLevelDraw[playerid], 0.170833, 1.049999);
	PlayerTextDrawTextSize(playerid, FaceMenuLevelDraw[playerid], 400.000000, 177.000000);
	PlayerTextDrawSetOutline(playerid, FaceMenuLevelDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FaceMenuLevelDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, FaceMenuLevelDraw[playerid], 2);
	PlayerTextDrawColor(playerid, FaceMenuLevelDraw[playerid], 0x00FF80C8);
	PlayerTextDrawBackgroundColor(playerid, FaceMenuLevelDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FaceMenuLevelDraw[playerid], -2686926);
	PlayerTextDrawUseBox(playerid, FaceMenuLevelDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FaceMenuLevelDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FaceMenuLevelDraw[playerid], 0);
	PlayerTextDrawShow(playerid,FaceMenuLevelDraw[playerid]);
	return 1;
}
N::UpdatePlayerFaceMenuLevel(playerid,level,exp,needexp)
{
    if(FaceMenuLevelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)
    {
    	fLine_64("LEVEL %i   EXP %i/%i",level,exp,needexp);
    	PlayerTextDrawSetString(playerid,FaceMenuLevelDraw[playerid],line);
    }
	return 1;
}
N::DestoryPlayerFaceMenuLevel(playerid)
{
	if(FaceMenuLevelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,FaceMenuLevelDraw[playerid]);
	FaceMenuLevelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::CreatePlayerFaceMenuBotton(playerid,friends,mails,others)
{
    DestoryPlayerFaceMenuBotton(playerid);
	fLine_64("FRIENDS(%i)",friends);
	FriendsBotton[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 415.000000, line);
	PlayerTextDrawFont(playerid, FriendsBotton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, FriendsBotton[playerid], 0.379166, 1.849998);
	PlayerTextDrawTextSize(playerid, FriendsBotton[playerid], 400.000000, 102.500000);
	PlayerTextDrawSetOutline(playerid, FriendsBotton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FriendsBotton[playerid], 0);
	PlayerTextDrawAlignment(playerid, FriendsBotton[playerid], 2);
	PlayerTextDrawColor(playerid, FriendsBotton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FriendsBotton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FriendsBotton[playerid], 50);
	PlayerTextDrawUseBox(playerid, FriendsBotton[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FriendsBotton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FriendsBotton[playerid], 1);
	PlayerTextDrawShow(playerid,FriendsBotton[playerid]);

	format(line,64,"MAILS(%i)",mails);
	MailsBotton[playerid] = CreatePlayerTextDraw(playerid, 321.000000, 415.000000, line);
	PlayerTextDrawFont(playerid, MailsBotton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, MailsBotton[playerid], 0.379166, 1.849998);
	PlayerTextDrawTextSize(playerid, MailsBotton[playerid], 400.000000, 47.500000);
	PlayerTextDrawSetOutline(playerid, MailsBotton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MailsBotton[playerid], 0);
	PlayerTextDrawAlignment(playerid, MailsBotton[playerid], 2);
	PlayerTextDrawColor(playerid, MailsBotton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MailsBotton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MailsBotton[playerid], 50);
	PlayerTextDrawUseBox(playerid, MailsBotton[playerid], 0);
	PlayerTextDrawSetProportional(playerid, MailsBotton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MailsBotton[playerid], 1);
	PlayerTextDrawShow(playerid,MailsBotton[playerid]);

    format(line,64,"SONGS(%i)",others);
	OthersBotton[playerid] = CreatePlayerTextDraw(playerid, 480.000000, 415.000000, line);
	PlayerTextDrawFont(playerid, OthersBotton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, OthersBotton[playerid], 0.379166, 1.849998);
	PlayerTextDrawTextSize(playerid, OthersBotton[playerid], 400.000000, 47.500000);
	PlayerTextDrawSetOutline(playerid, OthersBotton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, OthersBotton[playerid], 0);
	PlayerTextDrawAlignment(playerid, OthersBotton[playerid], 2);
	PlayerTextDrawColor(playerid, OthersBotton[playerid], 0x80FF80C8);
	PlayerTextDrawBackgroundColor(playerid, OthersBotton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, OthersBotton[playerid], 50);
	PlayerTextDrawUseBox(playerid, OthersBotton[playerid], 0);
	PlayerTextDrawSetProportional(playerid, OthersBotton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, OthersBotton[playerid], 1);
	PlayerTextDrawShow(playerid,OthersBotton[playerid]);
	return 1;
}
N::DestoryPlayerFaceMenuBotton(playerid)
{
	if(FriendsBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,FriendsBotton[playerid]);
	if(MailsBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,MailsBotton[playerid]);
	if(OthersBotton[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,OthersBotton[playerid]);
	FriendsBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	MailsBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	OthersBotton[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::CreatePlayerFaceMenuCdsDraw(playerid,amout[])
{
    DestoryPlayerFaceMenuCdsDraw(playerid);
	FaceMenuCdsDraw[playerid] = CreatePlayerTextDraw(playerid, 388.000000, 114.000000, amout);
	PlayerTextDrawFont(playerid, FaceMenuCdsDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, FaceMenuCdsDraw[playerid], 0.600000, 2.299998);
	PlayerTextDrawTextSize(playerid, FaceMenuCdsDraw[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, FaceMenuCdsDraw[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FaceMenuCdsDraw[playerid], 0);
	PlayerTextDrawAlignment(playerid, FaceMenuCdsDraw[playerid], 1);
	PlayerTextDrawColor(playerid, FaceMenuCdsDraw[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FaceMenuCdsDraw[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FaceMenuCdsDraw[playerid], 50);
	PlayerTextDrawUseBox(playerid, FaceMenuCdsDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FaceMenuCdsDraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FaceMenuCdsDraw[playerid], 0);
	PlayerTextDrawShow(playerid,FaceMenuCdsDraw[playerid]);
	return 1;
}
N::HidePlayerFaceMenuCdsDraw(playerid)
{
	TextDrawHideForPlayer(playerid,FaceMenuDraw[11]);
	if(FaceMenuCdsDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawHide(playerid,FaceMenuCdsDraw[playerid]);
	return 1;
}
N::ShowPlayerFaceMenuCdsDraw(playerid)
{
	TextDrawShowForPlayer(playerid,FaceMenuDraw[11]);
	if(FaceMenuCdsDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawShow(playerid,FaceMenuCdsDraw[playerid]);
	return 1;
}
N::UpdatePlayerFaceMenuCdsDraw(playerid,amout[])
{
	if(FaceMenuCdsDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawSetString(playerid,FaceMenuCdsDraw[playerid],amout);
	return 1;
}
N::DestoryPlayerFaceMenuCdsDraw(playerid)
{
	if(FaceMenuCdsDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,FaceMenuCdsDraw[playerid]);
	FaceMenuCdsDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::CreatePlayerFaceMenuModeDraw(playerid)
{
    DestoryPlayerFaceMenuModeDraw(playerid);
	new PlayerText:MenuText=PlayerText:INVALID_TEXT_DRAW;
	MenuText = CreatePlayerTextDraw(playerid, 74.000000, 51.000000, "~n~");//solobottonbackground
	PlayerTextDrawFont(playerid, MenuText, 2);
	PlayerTextDrawLetterSize(playerid, MenuText, 0.291666, 2.349997);
	PlayerTextDrawTextSize(playerid, MenuText, 265.000000, 74.000000);
	PlayerTextDrawSetOutline(playerid, MenuText, 1);
	PlayerTextDrawSetShadow(playerid, MenuText, 0);
	PlayerTextDrawAlignment(playerid, MenuText, 2);
	PlayerTextDrawColor(playerid, MenuText, -1);
	PlayerTextDrawBackgroundColor(playerid, MenuText, 255);
	PlayerTextDrawBoxColor(playerid, MenuText, 9145270);
	PlayerTextDrawUseBox(playerid, MenuText, 1);
	PlayerTextDrawSetProportional(playerid, MenuText, 1);
	PlayerTextDrawSetSelectable(playerid, MenuText, 0);
	PlayerFaceModeMenu[playerid][0]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;
	
	MenuText = CreatePlayerTextDraw(playerid, 74.000000, 76.000000, "~n~");//2pteambottonbackground
	PlayerTextDrawFont(playerid, MenuText, 2);
	PlayerTextDrawLetterSize(playerid, MenuText, 0.291666, 2.349997);
	PlayerTextDrawTextSize(playerid, MenuText, 265.000000, 74.000000);
	PlayerTextDrawSetOutline(playerid, MenuText, 1);
	PlayerTextDrawSetShadow(playerid, MenuText, 0);
	PlayerTextDrawAlignment(playerid, MenuText, 2);
	PlayerTextDrawColor(playerid, MenuText, -1);
	PlayerTextDrawBackgroundColor(playerid, MenuText, 255);
	PlayerTextDrawBoxColor(playerid, MenuText, 9145270);
	PlayerTextDrawUseBox(playerid, MenuText, 1);
	PlayerTextDrawSetProportional(playerid, MenuText, 1);
	PlayerTextDrawSetSelectable(playerid, MenuText, 0);
	PlayerFaceModeMenu[playerid][1]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;

	MenuText = CreatePlayerTextDraw(playerid, 74.000000, 101.000000, "~n~");//4pteambottonbackground
	PlayerTextDrawFont(playerid, MenuText, 2);
	PlayerTextDrawLetterSize(playerid, MenuText, 0.291666, 2.349997);
	PlayerTextDrawTextSize(playerid, MenuText, 265.000000, 74.000000);
	PlayerTextDrawSetOutline(playerid, MenuText, 1);
	PlayerTextDrawSetShadow(playerid, MenuText, 0);
	PlayerTextDrawAlignment(playerid, MenuText, 2);
	PlayerTextDrawColor(playerid, MenuText, -1);
	PlayerTextDrawBackgroundColor(playerid, MenuText, 255);
	PlayerTextDrawBoxColor(playerid, MenuText, 9145270);
	PlayerTextDrawUseBox(playerid, MenuText, 1);
	PlayerTextDrawSetProportional(playerid, MenuText, 1);
	PlayerTextDrawSetSelectable(playerid, MenuText, 0);
	PlayerFaceModeMenu[playerid][2]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;
	
	MenuText = CreatePlayerTextDraw(playerid,50.000000, 54.000000, "S_O_L_O");//solobotton
	PlayerTextDrawFont(playerid,MenuText, 2);
	PlayerTextDrawLetterSize(playerid,MenuText, 0.345833, 1.549998);
	PlayerTextDrawTextSize(playerid,MenuText, 99.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid,MenuText, 0);
	PlayerTextDrawSetShadow(playerid,MenuText, 0);
	PlayerTextDrawAlignment(playerid,MenuText, 1);
	PlayerTextDrawColor(playerid,MenuText, 255);
	PlayerTextDrawBackgroundColor(playerid,MenuText, 255);
	PlayerTextDrawBoxColor(playerid,MenuText, 50);
	PlayerTextDrawUseBox(playerid,MenuText, 0);
	PlayerTextDrawSetProportional(playerid,MenuText, 1);
	PlayerTextDrawSetSelectable(playerid,MenuText, 1);
	PlayerFaceModeMenu[playerid][3]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;

	MenuText = CreatePlayerTextDraw(playerid,44.000000, 79.000000, "2P_TEAM");//2pteambotton
	PlayerTextDrawFont(playerid,MenuText, 2);
	PlayerTextDrawLetterSize(playerid,MenuText, 0.345833, 1.549998);
	PlayerTextDrawTextSize(playerid,MenuText, 104.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid,MenuText, 0);
	PlayerTextDrawSetShadow(playerid,MenuText, 0);
	PlayerTextDrawAlignment(playerid,MenuText, 1);
	PlayerTextDrawColor(playerid,MenuText, 255);
	PlayerTextDrawBackgroundColor(playerid,MenuText, 255);
	PlayerTextDrawBoxColor(playerid,MenuText, 50);
	PlayerTextDrawUseBox(playerid,MenuText, 0);
	PlayerTextDrawSetProportional(playerid,MenuText, 1);
	PlayerTextDrawSetSelectable(playerid,MenuText, 1);
	PlayerFaceModeMenu[playerid][4]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;

	MenuText = CreatePlayerTextDraw(playerid,44.000000, 104.000000, "4P_TEAM");//4pteambotton
	PlayerTextDrawFont(playerid,MenuText, 2);
	PlayerTextDrawLetterSize(playerid,MenuText, 0.345833, 1.549998);
	PlayerTextDrawTextSize(playerid,MenuText, 104.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid,MenuText, 0);
	PlayerTextDrawSetShadow(playerid,MenuText, 0);
	PlayerTextDrawAlignment(playerid,MenuText, 1);
	PlayerTextDrawColor(playerid,MenuText, 255);
	PlayerTextDrawBackgroundColor(playerid,MenuText, 255);
	PlayerTextDrawBoxColor(playerid,MenuText, 50);
	PlayerTextDrawUseBox(playerid,MenuText, 0);
	PlayerTextDrawSetProportional(playerid,MenuText, 1);
	PlayerTextDrawSetSelectable(playerid,MenuText, 1);
	PlayerFaceModeMenu[playerid][5]=MenuText;
	MenuText=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::HidePlayerFaceMenuModeDraw(playerid)
{
	forex(i,MAX_PLAYER_FACE_MODE_DRAWS)PlayerTextDrawHide(playerid,PlayerFaceModeMenu[playerid][i]);
    Loop(i,20,MAX_FACEMENU_DRAWS)TextDrawHideForPlayer(playerid,FaceMenuDraw[i]);
	return 1;
}
N::DestoryPlayerFaceMenuModeDraw(playerid)
{
	forex(i,MAX_PLAYER_FACE_MODE_DRAWS)
	{
	    if(PlayerFaceModeMenu[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerFaceModeMenu[playerid][i]);
	    PlayerFaceModeMenu[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

