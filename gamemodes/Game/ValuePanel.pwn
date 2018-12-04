stock PlayerText:CreateWeaponModelPrevie(playerid,model,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "Nowy_TextDraw");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 123.500000, 107.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -3.000000, 0.000000, -20.000000, 1.659999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateWeaponAmmoPrevie(playerid,text[],Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.133332, 1.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -741092353);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateBodyArmorModelPrevie(playerid,model,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid,Xpos,Ypos, "Preview_Model");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 31.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -14.000000, -91.000000, -11.000000, 0.529999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateBodyCapModelPrevie(playerid,model, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid,Xpos, Ypos, "Preview_Model");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 31.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -14.000000, -91.000000, -11.000000, 0.529999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateBodyArmorTextPrevie(playerid,text[],Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.204162, 1.349997);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 335.000000, -72.500000);
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
stock PlayerText:CreateBodyCapTextPrevie(playerid,text[],Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.204163, 1.349997);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 335.000000, -72.500000);
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
stock PlayerText:CreateHealthBarPrevie(playerid,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.558333, 1.349999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 234.500000, 18.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -16776961);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateBuffBarPrevie(playerid,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, -0.049999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 234.500000, 15.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 65535);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatepCacheBarPrevie(playerid,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, -0.049999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 317.000000, 15.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -65281);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -65281);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::ShowPlayerValuePanelPrevie(playerid)
{
    DestoryPlayerValuePanelDraw(playerid);
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
		TextDrawShowForPlayer(playerid,GamePlayerValuePanelBackGround[0]);
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][3]!=NONE)
		{
			pBodyArmorModelDraw[playerid]=CreateBodyArmorModelPrevie(playerid,Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Model],199.000000,383.000000);
			pBodyArmorTextDraw[playerid]=CreateBodyArmorTextPrevie(playerid,"100%",214.000000, 388.000000);
		}
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][2]!=NONE)
		{
			pBodyCapModelDraw[playerid]=CreateBodyCapModelPrevie(playerid,Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Model],164.000000,383.000000);
			pBodyCapTextDraw[playerid]=CreateBodyCapTextPrevie(playerid,"100%",179.000000, 388.000000);
		}
		pHealthBar[playerid]=CreateHealthBarPrevie(playerid,237.000000, 395.000000);
	
		new Float:pHealth;
		GetPlayerHealth(playerid,pHealth);
		UpdatepHealthBar(playerid,pHealth);
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][3]!=NONE)UpdateBodyArmorDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][3],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Durable]);
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][2]!=NONE)UpdateBodyCapDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][2],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Durable]);
		new weaponid=GetPlayerWeapon(playerid);
		if(weaponid!=0)
		{
		    new itemid=GetPlayerHaveWeaponHandID(playerid,weaponid);
		    if(itemid!=NONE)
		    {
			    new model=GetWeaponModel(weaponid);
		    	pWeaponModel[playerid]=CreateWeaponModelPrevie(playerid,model,272.000000, 314.000000);
		    	new line[32];
		    	switch(Item[itemid][_HandWeaponSlot])
		    	{
		    	    case HAND_WEAPON_SLOT_1..HAND_WEAPON_SLOT_2:format(line,32,"%i",GetPlayerAmmoItemAmout(playerid,itemid));
		    	    case HAND_WEAPON_SLOT_3:format(line,32," ");
		    	    case HAND_WEAPON_SLOT_4:format(line,32,"%i",GetPlayerInvHaveWeaponAmout(playerid,itemid));
		    	}
		    	pWeaponAmoutText[playerid]=CreateWeaponAmmoPrevie(playerid,line,354.000000, 351.000000);
	    	}
	    }
	    else
	    {
			pWeaponModel[playerid]=CreateWeaponModelPrevie(playerid,NULL_MODEL,272.000000, 314.000000);
	 		pWeaponAmoutText[playerid]=CreateWeaponAmmoPrevie(playerid," ",354.000000, 351.000000);
	    }
    }
	return 1;
}
N::UpdateWeaponAmmoPrevie(playerid,itemid,weaponid)
{
	if(weaponid!=0)
	{
		if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW&&pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)
		{
	    	new line[32];
	    	switch(Item[itemid][_HandWeaponSlot])
	    	{
	    	    case HAND_WEAPON_SLOT_1..HAND_WEAPON_SLOT_2:format(line,32,"%i",GetPlayerAmmoItemAmout(playerid,itemid));
	    	    case HAND_WEAPON_SLOT_3:format(line,32," ");
	    	    case HAND_WEAPON_SLOT_4:format(line,32,"%i",GetPlayerInvHaveWeaponAmout(playerid,itemid));
	    	}
	    	PlayerTextDrawSetString(playerid,pWeaponAmoutText[playerid],line);
	    	PlayerTextDrawShow(playerid,pWeaponAmoutText[playerid]);
		}
	}
	return 1;
}
N::UpdateWeaponPrevie(playerid,weaponid)
{
	if(weaponid!=0)
	{
		if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW&&pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)
		{
		    new itemid=GetPlayerHaveWeaponHandID(playerid,weaponid);
		    if(itemid!=NONE)
		    {
				if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponModel[playerid]);
				if(pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponAmoutText[playerid]);
				pWeaponModel[playerid]=PlayerText:INVALID_TEXT_DRAW;
				pWeaponAmoutText[playerid]=PlayerText:INVALID_TEXT_DRAW;
			    new model=GetWeaponModel(weaponid);
		    	pWeaponModel[playerid]=CreateWeaponModelPrevie(playerid,model,272.000000, 314.000000);
		    	new line[32];
		    	switch(Item[itemid][_HandWeaponSlot])
		    	{
		    	    case HAND_WEAPON_SLOT_1..HAND_WEAPON_SLOT_2:format(line,32,"%i",GetPlayerAmmoItemAmout(playerid,itemid));
		    	    case HAND_WEAPON_SLOT_3:format(line,32," ");
		    	    case HAND_WEAPON_SLOT_4:format(line,32,"%i",GetPlayerInvHaveWeaponAmout(playerid,itemid));
		    	}
		    	pWeaponAmoutText[playerid]=CreateWeaponAmmoPrevie(playerid,line,354.000000, 351.000000);
	    	}
			else
			{
				if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponModel[playerid]);
				if(pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponAmoutText[playerid]);
				pWeaponModel[playerid]=PlayerText:INVALID_TEXT_DRAW;
				pWeaponAmoutText[playerid]=PlayerText:INVALID_TEXT_DRAW;
	    		pWeaponModel[playerid]=CreateWeaponModelPrevie(playerid,NULL_MODEL,272.000000, 314.000000);
		    	pWeaponAmoutText[playerid]=CreateWeaponAmmoPrevie(playerid," ",354.000000, 351.000000);
			}
		}
	}
	else
	{
		if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW&&pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)
		{
			if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponModel[playerid]);
			if(pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponAmoutText[playerid]);
			pWeaponModel[playerid]=PlayerText:INVALID_TEXT_DRAW;
			pWeaponAmoutText[playerid]=PlayerText:INVALID_TEXT_DRAW;
    		pWeaponModel[playerid]=CreateWeaponModelPrevie(playerid,NULL_MODEL,272.000000, 314.000000);
	    	pWeaponAmoutText[playerid]=CreateWeaponAmmoPrevie(playerid," ",354.000000, 351.000000);
		}
	}
	return 1;
}
N::UpdateBodyArmorDraw(playerid,Float:durable,Float:maxdurable)
{
    new Float:percent=ReturnPercent(durable,maxdurable);
    new olditemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][3];
	if(pBodyArmorModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW&&pBodyArmorTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)
	{
		if(percent<20.0)
		{
			PlayerTextDrawColor(playerid, pBodyArmorModelDraw[playerid], -16776961);
			PlayerTextDrawShow(playerid,pBodyArmorModelDraw[playerid]);
		}
		fLine_32("%0.1f%%",percent);
	    PlayerTextDrawSetString(playerid,pBodyArmorTextDraw[playerid],line);
	    PlayerTextDrawShow(playerid,pBodyArmorTextDraw[playerid]);
	    if(percent<=0.0)
	    {
			if(pBodyArmorModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyArmorModelDraw[playerid]);
			if(pBodyArmorTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyArmorTextDraw[playerid]);
            pBodyArmorModelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
            pBodyArmorTextDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	    }
	}
	if(percent<=0.0)
	{
		pLastAliveBodyDress[playerid][_Body_Dress_Item][3]=NONE;
		pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]=0.0;
		RestBodyDressPrevieList(playerid,3,olditemid);
	}
	return 1;
}
N::UpdateBodyCapDraw(playerid,Float:durable,Float:maxdurable)
{
    new Float:percent=ReturnPercent(durable,maxdurable);
    new olditemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][2];
	if(pBodyCapModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW&&pBodyCapTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)
	{
		if(percent<20.0)
		{
			PlayerTextDrawColor(playerid, pBodyCapModelDraw[playerid], -16776961);
			PlayerTextDrawShow(playerid,pBodyCapModelDraw[playerid]);
		}
		fLine_32("%0.1f%%",percent);
	    PlayerTextDrawSetString(playerid,pBodyCapTextDraw[playerid],line);
	    if(percent<=0.0)
	    {
			if(pBodyCapModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyCapModelDraw[playerid]);
			if(pBodyCapTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyCapTextDraw[playerid]);
            pBodyCapModelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
            pBodyCapTextDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	    }
	}
    if(percent<=0.0)
	{
		pLastAliveBodyDress[playerid][_Body_Dress_Item][2]=NONE;
		pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]=0.0;
		RestBodyDressPrevieList(playerid,2,olditemid);
	}
	return 1;
}
N::DestoryPlayerValuePanelDraw(playerid)
{
    TextDrawHideForPlayer(playerid,GamePlayerValuePanelBackGround[0]);
	if(pBodyArmorModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyArmorModelDraw[playerid]);
	if(pBodyCapModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyCapModelDraw[playerid]);
	if(pBodyArmorTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyArmorTextDraw[playerid]);
	if(pBodyCapTextDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBodyCapTextDraw[playerid]);
	if(pHealthBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pHealthBar[playerid]);
	if(pWeaponModel[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponModel[playerid]);
	if(pWeaponAmoutText[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pWeaponAmoutText[playerid]);
	pBodyArmorModelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pBodyCapModelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pBodyArmorTextDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pBodyCapTextDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pHealthBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pWeaponModel[playerid]=PlayerText:INVALID_TEXT_DRAW;
	pWeaponAmoutText[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::UpdatepHealthBar(playerid,Float:health)
{
	if(pHealthBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)
	{
	    new Float:BarTextSize=floatmul(floatdiv(health,100.0),166.0);
	    PlayerTextDrawTextSize(playerid,pHealthBar[playerid], floatadd(237.000000,BarTextSize), 18.000000);
	    PlayerTextDrawShow(playerid,pHealthBar[playerid]);
	}
	return 1;
}
N::UpdatepBuffBar(playerid)
{
   	if(pBuffID[playerid]!=NONE)
    {
		if(pBuffBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)
		{
		    new Float:BarTextSize=floatmul(floatdiv(pBuffCount[playerid],Item[pBuffID[playerid]][_BuffTime]),85.5);
		    PlayerTextDrawTextSize(playerid,pBuffBar[playerid], floatadd(234.500000,BarTextSize), 15.500000);
		    PlayerTextDrawShow(playerid,pBuffBar[playerid]);
		}
		HealPlayerPercent(playerid,Item[pBuffID[playerid]][_BuffEffect]);
	}
	return 1;
}
N::ShowBuffBar(playerid)
{
    DestorypBuffBar(playerid);
    pBuffBar[playerid]=CreateBuffBarPrevie(playerid,237.000000, 391.000000);
	return 1;
}
N::DestorypBuffBar(playerid)
{
	if(pBuffBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pBuffBar[playerid]);
	pBuffBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::ClearPlayerBuff(playerid)
{
	pBuffID[playerid]=NONE;
    pBuffCount[playerid]=0;
	DestorypBuffBar(playerid);
	return 1;
}
N::ClearPlayerCache(playerid)
{
    pCacheID[playerid]=NONE;
    pCacheCount[playerid]=0;
	DestorypCacheBar(playerid);
	return 1;
}
N::ShowpCacheBar(playerid)
{
    DestorypCacheBar(playerid);
    pCacheBar[playerid]=CreatepCacheBarPrevie(playerid,320.000000, 391.000000);
	return 1;
}
N::DestorypCacheBar(playerid)
{
	if(pCacheBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pCacheBar[playerid]);
	pCacheBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::UpdatepCacheBar(playerid)
{
   	if(pCacheID[playerid]!=NONE)
    {
		if(pCacheBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)
		{
		    new Float:BarTextSize=floatmul(floatdiv(pCacheCount[playerid],Item[pCacheID[playerid]][_BuffTime]),85.5);
		    PlayerTextDrawTextSize(playerid,pCacheBar[playerid], floatadd(317.500000,BarTextSize), 15.500000);
		    PlayerTextDrawShow(playerid,pCacheBar[playerid]);
		}
	}
	return 1;
}
/****************************************************/
stock PlayerText:CreateTimeLinePersonPrevie(playerid,Float:Xpos,Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "HUD:radar_gangn");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 10.500000, 13.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::CreatePlayerTimeLinePerson(playerid)
{
	DestoryPlayerTimeLinePerson(playerid);
    pLastAlive[playerid][_Time_Line_Person_Draw]=CreateTimeLinePersonPrevie(playerid,99.000000, 284.000000);
	return 1;
}
N::ShowPlayerTimeLinePerson(playerid)
{
    if(pLastAlive[playerid][_Time_Line_Person_Draw]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawShow(playerid,pLastAlive[playerid][_Time_Line_Person_Draw]);
	return 1;
}
N::DestoryPlayerTimeLinePerson(playerid)
{
	if(pLastAlive[playerid][_Time_Line_Person_Draw]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAlive[playerid][_Time_Line_Person_Draw]);
	pLastAlive[playerid][_Time_Line_Person_Draw]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

N::ShowUserInvPanel(playerid,bool:destoryvaluepanel)
{
    if(destoryvaluepanel==true)DestoryPlayerValuePanelDraw(playerid);
    PlayerInvShow[playerid]=true;
    ShowInventoryBackGroundPrevie(playerid);
    ShowPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid],false);
    ShowPlayerBodyDressPrevie(playerid);
    ShowPlayerHandWeaponPrevie(playerid);
    ShowPlayerNearByPrevie(playerid,pGameID(playerid),PLAYER_FIND_NEARBY_DISTANCE,NearByPreviePage[playerid],false);
	return 1;
}
N::HideUserInvPanel(playerid,bool:showvaluepanel)
{
	HideInventoryBackGroundPrevie(playerid);
	DestoryPlayerInvDraw(playerid);
	DestoryPlayerUseWeaponDraw(playerid);
	DestoryPlayerBodyDressDraw(playerid);
	DestoryPlayerNearByDraw(playerid);
	DestoryPlayerInvItemBottonDo(playerid);
	if(showvaluepanel==true)ShowPlayerValuePanelPrevie(playerid);
	PlayerInvShow[playerid]=false;
    return 1;
}
N::ShowPlayerGameOverDraw(playerid,Body[],Rank,Kills,Number,Players,Reward,TimeLeft)
{
   	ShowPlayerGameOverBackGroud(playerid);
   	ShowPlayerGameOverPrive(playerid,Body,Rank,Kills,Number,Players,Reward,TimeLeft);
    return 1;
}
N::HidePlayerGameOverDraw(playerid)
{
   	HidePlayerGameOverBackGroud(playerid);
   	DestoryPlayerGameOverPrive(playerid,true);
    return 1;
}





