N::Weapon@OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW-2)
	{
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
	    {
	        if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon]==weaponid)
	        {
	            if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])>0)
	            {
	                ReducePlayerHandWeaponAmmo(playerid,i,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i],1,weaponid);
	            }
	        }
	    }
	}
	return 1;
}
stock PlayerText:CreateHandWeaponPrevieName(playerid,list,text[])
{
    new PlayerText:PlayerTextDraw=PlayerText:INVALID_TEXT_DRAW;
	switch(list)
	{
	    case 0:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,422.591796, 83.249969, text);
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.339091, 1.500833);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 1:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,423.997436, 157.333312, text);//ÎäÆ÷Ãû2
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.339091, 1.500833);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 2:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,425.871582, 242.499954, text);//ÎäÆ÷Ãû3
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.339091, 1.500833);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	}
    return PlayerTextDraw;
}
stock PlayerText:CreateHandWeaponPrevieNameTag(playerid,list,text[])
{
    new PlayerText:PlayerTextDraw=PlayerText:INVALID_TEXT_DRAW;
	switch(list)
	{
	    case 0:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,544.876220, 127.583320, text);//ÎäÆ÷¿Ú¾¶1
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 1:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,547.218444, 211.000000, text);//ÎäÆ÷¿Ú¾¶2
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 2:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,549.561035, 305.500122, text);//ÎäÆ÷¿Ú¾¶3
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	}
    return PlayerTextDraw;
}
stock PlayerText:CreateHandWeaponPrevieAmmo(playerid,list,text[])
{
    new PlayerText:PlayerTextDraw=PlayerText:INVALID_TEXT_DRAW;
	switch(list)
	{
	    case 0:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,565.491149, 82.666625, text);//ÎäÆ÷µ¯Ò©1
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 1:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,564.554016, 154.999938, text);//ÎäÆ÷µ¯Ò©2
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 2:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,565.491027, 241.333236, text);//ÎäÆ÷µ¯Ò©3
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.194315, 1.459998);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 1);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 255);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 2);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	}
    return PlayerTextDraw;
}
stock PlayerText:CreateHandWeaponPrevieModel(playerid,list,model)
{
    new PlayerText:PlayerTextDraw=PlayerText:INVALID_TEXT_DRAW;
	switch(list)
	{
	    case 0:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,428.982696, 45.916694, "");//ÎäÆ÷MODEL1
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 175.000000, 144.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 0.000000, 2.258064);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 1:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,427.577087, 126.416679, "");//ÎäÆ÷MODEL2
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 175.000000, 144.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 0.000000, 2.258064);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 2:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,420.549194, 198.750015, "");//ÎäÆ÷MODEL3
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 192.000000, 175.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 0.000000, 0.000000, 0.000000, 2.258064);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 3:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,414.458435, 341.083587, "");//×óÏÂÎäÆ÷
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 92.000000, 72.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 342.000000, 0.000000, 0.000000, 1.304985);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	    case 4:
	    {
			PlayerTextDraw = CreatePlayerTextDraw(playerid,524.092712, 336.416900, "");//ÓÒÏÂÎäÆ÷
			PlayerTextDrawLetterSize(playerid,PlayerTextDraw, 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid,PlayerTextDraw, 92.000000, 72.000000);
			PlayerTextDrawAlignment(playerid,PlayerTextDraw, 1);
			PlayerTextDrawColor(playerid,PlayerTextDraw, -1);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetOutline(playerid,PlayerTextDraw, 0);
			PlayerTextDrawBackgroundColor(playerid,PlayerTextDraw, 0);
			PlayerTextDrawFont(playerid,PlayerTextDraw, 5);
			PlayerTextDrawSetProportional(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetShadow(playerid,PlayerTextDraw, 0);
			PlayerTextDrawSetPreviewModel(playerid,PlayerTextDraw, model);
			PlayerTextDrawSetPreviewRot(playerid,PlayerTextDraw, 342.000000, 0.000000, 0.000000, 0.652490);
			if(model==NULL_MODEL)PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
			else PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
			PlayerTextDrawShow(playerid,PlayerTextDraw);
	    }
	}
    return PlayerTextDraw;
}
N::UpdateHandWeaponPrevieList(playerid,slot)
{
    if(PlayerInvShow[playerid])
    {
	    if(pLastAliveHandWeapon[playerid][_Hand_Name_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Name_Draw][slot]);
	    if(pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][slot]);
	    if(pLastAliveHandWeapon[playerid][_Hand_Model_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Model_Draw][slot]);
	    if(pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][slot]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][slot]);
		pLastAliveHandWeapon[playerid][_Hand_Name_Draw][slot]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][slot]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_Model_Draw][slot]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][slot]=PlayerText:INVALID_TEXT_DRAW;
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]!=NONE)
		{
		   	fLine_64("%s",Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]][_Name]);
			pLastAliveHandWeapon[playerid][_Hand_Name_Draw][slot] = CreateHandWeaponPrevieName(playerid,slot,line);
			format(line,64,"%s",Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]][_SizeName]);
			pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][slot] = CreateHandWeaponPrevieNameTag(playerid,slot,line);
			pLastAliveHandWeapon[playerid][_Hand_Model_Draw][slot] = CreateHandWeaponPrevieModel(playerid,slot,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]][_Model]);
			format(line,64,"X%i",GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]));
			pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][slot] = CreateHandWeaponPrevieAmmo(playerid,slot,line);
		}
		else
		{
			pLastAliveHandWeapon[playerid][_Hand_Name_Draw][slot] = CreateHandWeaponPrevieName(playerid,0," ");
			pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][slot] = CreateHandWeaponPrevieNameTag(playerid,0," ");
			pLastAliveHandWeapon[playerid][_Hand_Model_Draw][slot] = CreateHandWeaponPrevieModel(playerid,0,NULL_MODEL);
			pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][slot] = CreateHandWeaponPrevieAmmo(playerid,0," ");
		}
	}
	return 1;
}
N::ShowPlayerHandWeaponPrevie(playerid)
{
    HandWeaponClickID[playerid]=NONE;
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
	{
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
		{
	     	fLine_64("%s",Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Name]);
			pLastAliveHandWeapon[playerid][_Hand_Name_Draw][i] = CreateHandWeaponPrevieName(playerid,i,line);
			format(line,64,"%s",Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_SizeName]);
			pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][i] = CreateHandWeaponPrevieNameTag(playerid,i,line);
			pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i] = CreateHandWeaponPrevieModel(playerid,i,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Model]);
			format(line,64,"X%i",GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]));
			pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][i] = CreateHandWeaponPrevieAmmo(playerid,i,line);
		}
		else
		{
			pLastAliveHandWeapon[playerid][_Hand_Name_Draw][i] = CreateHandWeaponPrevieName(playerid,0," ");
			pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][i] = CreateHandWeaponPrevieNameTag(playerid,0," ");
			pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i] = CreateHandWeaponPrevieModel(playerid,0,NULL_MODEL);
			pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][i] = CreateHandWeaponPrevieAmmo(playerid,0," ");
		}
	}
	return 1;
}
N::DestoryPlayerUseWeaponDraw(playerid)
{
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
	{
	    if(pLastAliveHandWeapon[playerid][_Hand_Name_Draw][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Name_Draw][i]);
	    if(pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][i]);
	    if(pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i]);
	    if(pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][i]);
		pLastAliveHandWeapon[playerid][_Hand_Name_Draw][i]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_NameTag_Draw][i]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_Model_Draw][i]=PlayerText:INVALID_TEXT_DRAW;
		pLastAliveHandWeapon[playerid][_Hand_Ammo_Draw][i]=PlayerText:INVALID_TEXT_DRAW;
	}
    return 1;
}
N::GetPlayerHandWeaponSlotFree(playerid,type,itemid)
{
	new FreeSlot=NONE;
	switch(type)
	{
	    case HAND_WEAPON_SLOT_1:
	    {
			Loop(i,0,2)
			{
			    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]==NONE)
			    {
			        new Otherid;
			        if(i==0)Otherid=1;
			        else Otherid=0;
					if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][Otherid]!=NONE)
					{
					    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][Otherid]==itemid||WeaponSlot(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][Otherid]][_Weapon])==WeaponSlot(Item[itemid][_Weapon]))
					    {
							FreeSlot=NONE;
						}
						else FreeSlot=i;
					}
			        else FreeSlot=i;
			        return FreeSlot;
			    }
			}
	    }
	    case HAND_WEAPON_SLOT_2:
	    {
			if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][2]==NONE)
		    {
		        FreeSlot=2;
		        return FreeSlot;
		    }
	    }
	    case HAND_WEAPON_SLOT_3:
	    {
		    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][3]==NONE)
		    {
		        FreeSlot=3;
		        return FreeSlot;
		    }
	    }
	    case HAND_WEAPON_SLOT_4:
	    {
		    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]==NONE)
		    {
		        FreeSlot=4;
		        return FreeSlot;
		    }
	    }
	}
    return FreeSlot;
}
N::GetPlayerItemHaveAmmo(playerid,itemid)
{
	new AmmoAmout=NONE;
	foreach(new i:Inventory[playerid])
   	{
   	    if(Item[PlayerInventoryItemID(playerid,i)][_Type]==ITEM_AMMO)
   	    {
   	        if(Item[PlayerInventoryItemID(playerid,i)][_WeaponAmmoType]==Item[itemid][_WeaponAmmoType])
   	        {
   	            AmmoAmout=Item[PlayerInventoryItemID(playerid,i)][_AmmoAmout];
   	            new	cur = i;
   				Iter_SafeRemove(Inventory[playerid],cur,i);
   				break;
   	        }
   	    }
   	}
    return AmmoAmout;
}
N::GetPlayerHandWeaponForAmmoID(playerid,itemid)
{
    new handid=NONE;
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW-2)
	{
	    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
	    {
			if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_WeaponAmmoType]==Item[itemid][_WeaponAmmoType])
			{
			    handid=i;
			    break;
			}
	    }
	}
	return handid;
}
N::GetPlayerAmmoItemAmout(playerid,itemid)
{
    new AmmoAmout=0;
	foreach(new i:Inventory[playerid])
   	{
   	    if(Item[PlayerInventoryItemID(playerid,i)][_Type]==ITEM_AMMO)
   	    {
	   	    if(Item[PlayerInventoryItemID(playerid,i)][_WeaponAmmoType]==Item[itemid][_WeaponAmmoType])
	   	    {
	   	        AmmoAmout+=PlayerInventoryItemAmmo(playerid,i);
	   	    }
   	    }
   	}
  	return AmmoAmout;
}
N::GetPlayerInvHaveWeaponAmout(playerid,itemid)
{
    new WeaponAmout=0;
	foreach(new i:Inventory[playerid])
   	{
   	    if(Item[PlayerInventoryItemID(playerid,i)][_Type]==ITEM_WEAPON)
   	    {
	   	    if(Item[PlayerInventoryItemID(playerid,i)][_Weapon]==Item[itemid][_Weapon])
	   	    {
	   	        WeaponAmout++;
	   	    }
   	    }
   	}
	return WeaponAmout;
}
N::GetPlayerWeaponItemAmout(playerid,itemid)
{
    new AmmoAmout=0;
	foreach(new i:Inventory[playerid])
   	{
   	    if(Item[PlayerInventoryItemID(playerid,i)][_Type]==ITEM_WEAPON)
   	    {
	   	    if(Item[PlayerInventoryItemID(playerid,i)][_Weapon]==Item[itemid][_Weapon])
	   	    {
	   	        AmmoAmout++;
	   	    }
   	    }
   	}
  	return AmmoAmout;
}
N::UpdatePlayerHandWeaponAmmo(playerid,itemid,bool:refresh)
{
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW-2)
	{
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
	    {
		    if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_WeaponAmmoType]==Item[itemid][_WeaponAmmoType])
		    {
	            switch(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot])
	            {
	                case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
					{
						if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])<=0)SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],0);
						else GivePlayerWeapon(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
					}
					case HAND_WEAPON_SLOT_3:SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
					case HAND_WEAPON_SLOT_4:
					{
						if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])<=0)SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],0);
						else GivePlayerWeapon(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
					}
	            }
		        if(refresh==true)UpdateHandWeaponPrevieList(playerid,i);
		    }
		}
	}
	return 1;
}
N::UpdatePlayerThrowHandWeaponAmmo(playerid,itemid)
{
    if(Item[itemid][_HandWeaponSlot]==HAND_WEAPON_SLOT_4)
    {
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]!=NONE)
	    {
		    if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]][_Weapon]==Item[itemid][_Weapon])
		    {
		        new WeaponAmout=GetPlayerWeaponItemAmout(playerid,itemid);
		        UpdateWeaponAmmoPrevie(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4],Item[itemid][_Weapon]);
		        if(WeaponAmout<=0)
		        {
		            pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]=NONE;
		            UpdateHandWeaponPrevieList(playerid,4);
		            SetPlayerAmmo(playerid,Item[itemid][_Weapon],0);
		        }
		    }
		}
	}
	return 1;
}
N::ReducePlayerHandWeaponAmmo(playerid,slot,itemid,amout,onhandweapon)
{
	switch(Item[itemid][_HandWeaponSlot])
	{
	    case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
        {
			foreach(new i:Inventory[playerid])
		   	{
		   	    if(Item[PlayerInventoryItemID(playerid,i)][_Type]==ITEM_AMMO)
		   	    {
			   	    if(Item[PlayerInventoryItemID(playerid,i)][_WeaponAmmoType]==Item[itemid][_WeaponAmmoType])
			   	    {
			   	        PlayerInventoryItemAmmo(playerid,i)-=amout;
			   	        if(PlayerInventoryItemAmmo(playerid,i)<=0)
			   	        {
			   	        	new	cur = i;
		   					Iter_SafeRemove(Inventory[playerid],cur,i);
			   	        }
			   	        break;
			   	    }
		   	    }
		   	}
		   	if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot])<=0)
		   	{
				forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW-2)
				{
					if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
				    {
					    if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_WeaponAmmoType]==Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]][_WeaponAmmoType])
					    {
		   	    			SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],0);
		   	    		}
		   	    	}
		   	    }
		   	}
		   	UpdateWeaponAmmoPrevie(playerid,itemid,onhandweapon);
        }
        case HAND_WEAPON_SLOT_4:
        {
			if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]!=NONE)
            {
				if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot]][_Weapon]==onhandweapon)
				{
				    DelItemFromPlayerInventoy(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][slot],1);
				}
            }
        }
	}
    return 1;
}
N::OnPlayerWeaponChange(playerid,newweaponid,oldweaponid)
{
    //ChackPlayerWeapon(playerid);
    GamePlayerGunAttach(playerid,newweaponid);
    UpdateWeaponPrevie(playerid,newweaponid);
    ShotCounter[playerid]=0;
	return 1;
}
N::OnPlayerWeaponAmmoChange(playerid,weaponid,weaponammo,oldweaponammo)
{
	if(oldweaponammo>weaponammo)
	{
		switch(WeaponSlot(weaponid))
		{
			case 8:
			{
				if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]!=NONE)
            	{
			    	ReducePlayerHandWeaponAmmo(playerid,4,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4],1,weaponid);
				}
			}
		}
	}
	return 1;
}
#define GUN_ATTACH_NEAR 	4
#define GUN_ATTACH_MIDDEL 	5
#define GUN_ATTACH_FAR 		6
#define GUN_ATTACH_NONE 	0
N::GetPlayerGunAttachUnUseSlot(playerid)
{
	Loop(i,BODY_DRESS_SLOT_5,BODY_DRESS_SLOT_5+2)
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid,i))return i;
	}
	return NONE;
}
N::GamePlayerGunAttach(playerid,weaponid)
{
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
		Loop(i,BODY_DRESS_SLOT_5,BODY_DRESS_SLOT_5+2)if(IsPlayerAttachedObjectSlotUsed(playerid,i))RemovePlayerAttachedObject(playerid,i);
	    new count=0;
		forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
		{
			if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)count++;
		}
		if(count==0)return 1;
		new type;
		forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
		{
		    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
		    {
				if(weaponid!=Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon])
				{
				    new index=GetPlayerGunAttachUnUseSlot(playerid);
					if(index!=NONE)
					{
						type=GetWeaponType(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon]);
						switch(type)
						{
						    case GUN_ATTACH_NEAR:SetPlayerWeaponModelGunAttach(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],index);
						    case GUN_ATTACH_MIDDEL:SetPlayerWeaponModelGunAttach(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],index);
						    case GUN_ATTACH_FAR:SetPlayerWeaponModelGunAttach(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],index);
						}
					}
				}
			}
		}
	}
	return 1;
}
N::SetPlayerWeaponModelGunAttach(playerid,weaponid,slot)
{
	switch(weaponid)
	{
	    case 2..8:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),1, 0.199999, -0.139999, 0.030000, 0.500007, -115.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 9:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),1,-0.1169,0.149,0.254,-87.3999,175.2, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 22..24:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),8, -0.079999, -0.039999, 0.109999, -90.100006, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 25..27:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 28,29,32:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 30,31:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),1, 0.200000, -0.119999, -0.059999, 0.000000, 206.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	    case 33,34:SetPlayerAttachedObject(playerid, slot, GetWeaponModel(weaponid), 1, -0.164999, -0.164000, 0.128999, 1.000000, 49.099983, 3.300002, 1.000000, 1.000000, 1.000000);
	    case 35..37:SetPlayerAttachedObject(playerid, slot, GetWeaponModel(weaponid), 1, 0,-0.179, -0.129, 0, 0, 0, 1.000000, 1.000000, 1.000000);
	    case 38:SetPlayerAttachedObject(playerid,slot,GetWeaponModel(weaponid),1,0.5879,-0.18,0.2109,0,173.6,0, 1.099999, 1.000000, 1.000000);
	    case 10..15:SetPlayerAttachedObject(playerid, slot, GetWeaponModel(weaponid), 7, 0.008000, 0.074999, -0.161999, -87.099845, 157.899917, -169.400009, 1.000000, 1.000000, 1.000000);
	}
	return 1;
}
N::GetWeaponType(weaponid)
{
	switch(weaponid)
	{
	    case 2..15:return GUN_ATTACH_NEAR;
        case 22..24:return GUN_ATTACH_MIDDEL;
		case 25..38:return GUN_ATTACH_FAR;
	}
	return GUN_ATTACH_NONE;
}
N::GetPlayerHaveWeaponHandID(playerid,weaponid)
{
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
	{
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
	    {
		    if(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon]==weaponid)
		    {
				return pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i];
		    }
		}
	}
	return NONE;
}
N::ResetPlayerWeaponsEx(playerid)
{
    //ResetPlayerWeapons(playerid);
	forex(i,MAX_PLAYER_WEAPON_SLOT_DRAW)
	{
		if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]!=NONE)
	    {
            switch(Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_HandWeaponSlot])
            {
                case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
				{
					if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])<=0)SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],0);
					else GivePlayerWeapon(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
				}
				case HAND_WEAPON_SLOT_3:
				{
				    GivePlayerWeapon(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
					//SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
				}
				case HAND_WEAPON_SLOT_4:
				{
				    GivePlayerWeapon(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],32767);
//					if(GetPlayerAmmoItemAmout(playerid,pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i])<=0)SetPlayerAmmo(playerid,Item[pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][i]][_Weapon],0);
				}
            }
		}
	}
	return 1;
}
