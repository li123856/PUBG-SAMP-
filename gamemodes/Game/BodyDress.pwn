stock PlayerText:CreateBodyDressPrevie(playerid,list,model)
{
    new PlayerText:PlayerTextDraw=PlayerText:INVALID_TEXT_DRAW;
	switch(list)
	{
	    case 2:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,292.174316, 179.500015, "");//
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 56.000000, 44.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 110.000000, 1.000000);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
            PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 4:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,295.454132, 250.083267, "");
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 46.000000, 34.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 172.000000, 1.000000);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
            PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 1:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,346.054290, 173.083374, "");
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 56.000000, 44.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetSelectable(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 269.000000, 333.000000, 184.000000, 1.000000);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
            PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 0:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,341.838073, 139.833389, "");
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 48.000000, 51.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 110.000000, 1.000000);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
            PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 3:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,295.922851, 213.916885, "");
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 48.000000, 44.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 84.000000, 264.000000, 104.000000, 1.000000);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
            PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	}
    return PlayerTextDraw;
}
N::UpdateBodyDressPrevieList(playerid,slot,olditemid)
{
    if(PlayerInvShow[playerid])
    {
		if(pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]);
		pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]=PlayerText:INVALID_TEXT_DRAW;
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]!=NONE)
		{
			pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]=CreateBodyDressPrevie(playerid,slot,Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]][_Model]);
			if(IsPlayerAttachedObjectSlotUsed(playerid, Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]][_BodyDressSlot]-1))RemovePlayerAttachedObject(playerid, Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]][_BodyDressSlot]-1);
	        new itemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][slot];
			SetPlayerAttachedObject(playerid, Item[itemid][_BodyDressSlot]-1, Item[itemid][_Model], Item[itemid][_Bone],ItemDiffPos[itemid][_Attach_fOffsetX],ItemDiffPos[itemid][_Attach_fOffsetY],ItemDiffPos[itemid][_Attach_fOffsetZ],ItemDiffPos[itemid][_Attach_fRotX],ItemDiffPos[itemid][_Attach_fRotY],ItemDiffPos[itemid][_Attach_fRotZ],ItemDiffPos[itemid][_Attach_fScaleX],ItemDiffPos[itemid][_Attach_fScaleY],ItemDiffPos[itemid][_Attach_fScaleZ]);
		}
		else
		{
			pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]=CreateBodyDressPrevie(playerid,slot,NULL_MODEL);
			if(IsPlayerAttachedObjectSlotUsed(playerid, Item[olditemid][_BodyDressSlot]-1))RemovePlayerAttachedObject(playerid, Item[olditemid][_BodyDressSlot]-1);
		}
	}
	else
	{
		if(pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]!=NONE)
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid, Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]][_BodyDressSlot]-1))RemovePlayerAttachedObject(playerid, Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][slot]][_BodyDressSlot]-1);
	        new itemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][slot];
			SetPlayerAttachedObject(playerid, Item[itemid][_BodyDressSlot]-1, Item[itemid][_Model], Item[itemid][_Bone],ItemDiffPos[itemid][_Attach_fOffsetX],ItemDiffPos[itemid][_Attach_fOffsetY],ItemDiffPos[itemid][_Attach_fOffsetZ],ItemDiffPos[itemid][_Attach_fRotX],ItemDiffPos[itemid][_Attach_fRotY],ItemDiffPos[itemid][_Attach_fRotZ],ItemDiffPos[itemid][_Attach_fScaleX],ItemDiffPos[itemid][_Attach_fScaleY],ItemDiffPos[itemid][_Attach_fScaleZ]);
		}
	}
	return 1;
}
N::RestBodyDressPrevieList(playerid,slot,olditemid)
{
	if(pLastAliveBodyDress[playerid][_Body_Dress_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)UpdateBodyDressPrevieList(playerid,slot,olditemid);
	else if(IsPlayerAttachedObjectSlotUsed(playerid, Item[olditemid][_BodyDressSlot]-1))RemovePlayerAttachedObject(playerid, Item[olditemid][_BodyDressSlot]-1);
	return 1;
}
N::RestBodyDressAttach(playerid)
{
	forex(i,MAX_PLAYER_BODY_SLOT_DRAW)
	{
	    if(pLastAliveBodyDress[playerid][_Body_Dress_Item][i]!=NONE)
	    {
        	new itemid=pLastAliveBodyDress[playerid][_Body_Dress_Item][i];
			SetPlayerAttachedObject(playerid, Item[itemid][_BodyDressSlot]-1, Item[itemid][_Model], Item[itemid][_Bone],ItemDiffPos[itemid][_Attach_fOffsetX],ItemDiffPos[itemid][_Attach_fOffsetY],ItemDiffPos[itemid][_Attach_fOffsetZ],ItemDiffPos[itemid][_Attach_fRotX],ItemDiffPos[itemid][_Attach_fRotY],ItemDiffPos[itemid][_Attach_fRotZ],ItemDiffPos[itemid][_Attach_fScaleX],ItemDiffPos[itemid][_Attach_fScaleY],ItemDiffPos[itemid][_Attach_fScaleZ]);
	    }
	}
	return 1;
}
N::ShowPlayerBodyDressPrevie(playerid)//Íæ¼Ò´©×Å¿Õ²Û
{
    BodyDressClickID[playerid]=NONE;
	forex(i,MAX_PLAYER_BODY_SLOT_DRAW)
	{
	    if(pLastAliveBodyDress[playerid][_Body_Dress_Item][i]!=NONE)
	    {
	    	pLastAliveBodyDress[playerid][_Body_Dress_Draw][i]=CreateBodyDressPrevie(playerid,i,Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][i]][_Model]);
	    }
	    else
	    {
	        pLastAliveBodyDress[playerid][_Body_Dress_Draw][i]=CreateBodyDressPrevie(playerid,i,NULL_MODEL);
	    }
	}
	return 1;
}

N::DestoryPlayerBodyDressDraw(playerid)
{
	forex(i,MAX_PLAYER_BODY_SLOT_DRAW)
	{
	    if(pLastAliveBodyDress[playerid][_Body_Dress_Draw][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Draw][i]);
		pLastAliveBodyDress[playerid][_Body_Dress_Draw][i]=PlayerText:INVALID_TEXT_DRAW;
	}
    return 1;
}
N::GetPlayerBodyDressSlotFree(playerid,type)
{
	new FreeSlot=NONE;
	switch(type)
	{
	    case BODY_DRESS_SLOT_1:
	    {
			if(pLastAliveBodyDress[playerid][_Body_Dress_Item][0]==NONE)
		    {
		        FreeSlot=0;
		        return FreeSlot;
		    }
	    }
	    case BODY_DRESS_SLOT_2:
	    {
			if(pLastAliveBodyDress[playerid][_Body_Dress_Item][1]==NONE)
		    {
		        FreeSlot=1;
		        return FreeSlot;
		    }
	    }
	    case BODY_DRESS_SLOT_3:
	    {
		    if(pLastAliveBodyDress[playerid][_Body_Dress_Item][2]==NONE)
		    {
		        FreeSlot=2;
		        return FreeSlot;
		    }
	    }
	    case BODY_DRESS_SLOT_4:
	    {
		    if(pLastAliveBodyDress[playerid][_Body_Dress_Item][3]==NONE)
		    {
		        FreeSlot=3;
		        return FreeSlot;
		    }
	    }
	    case BODY_DRESS_SLOT_5:
	    {
		    if(pLastAliveBodyDress[playerid][_Body_Dress_Item][4]==NONE)
		    {
		        FreeSlot=4;
		        return FreeSlot;
		    }
	    }
	}
    return FreeSlot;
}
N::GetPlayerBodyDressItemID(playerid,type)
{
	switch(type)
	{
	    case BODY_DRESS_SLOT_1:return pLastAliveBodyDress[playerid][_Body_Dress_Item][0];
	    case BODY_DRESS_SLOT_2:return pLastAliveBodyDress[playerid][_Body_Dress_Item][1];
	    case BODY_DRESS_SLOT_3:return pLastAliveBodyDress[playerid][_Body_Dress_Item][2];
	    case BODY_DRESS_SLOT_4:return pLastAliveBodyDress[playerid][_Body_Dress_Item][3];
	    case BODY_DRESS_SLOT_5:return pLastAliveBodyDress[playerid][_Body_Dress_Item][4];
	}
    return NONE;
}
