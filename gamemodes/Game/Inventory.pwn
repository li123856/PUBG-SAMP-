N::OnPlayerUseInventoryItem(playerid,index)
{
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
	    if(Iter_Contains(Inventory[playerid],InventoryPrevieBox[playerid][index]))
	    {
			if(InventoryPrevieBoxKey[playerid][index]==Inventory[playerid][InventoryPrevieBox[playerid][index]][_Key])
	  		{
			    new ItemID=PlayerInventoryItemID(playerid,InventoryPrevieBox[playerid][index]);
			    switch(Item[ItemID][_Type])
			    {
			        case ITEM_WEAPON:
			        {
			 			new FreeHandSlot=GetPlayerHandWeaponSlotFree(playerid,Item[ItemID][_HandWeaponSlot],ItemID);
			 			if(FreeHandSlot!=NONE)
			 			{
				            pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][FreeHandSlot]=ItemID;
				            switch(Item[ItemID][_HandWeaponSlot])
				            {
				                case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
								{
								    if(GetPlayerAmmoItemAmout(playerid,ItemID)<=0)GivePlayerWeapon(playerid,Item[ItemID][_Weapon],0);
									else GivePlayerWeapon(playerid,Item[ItemID][_Weapon],32767);
									DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],PlayerInventoryItemAmout(playerid,InventoryPrevieBox[playerid][index]));
     							}
								case HAND_WEAPON_SLOT_3:
								{
									GivePlayerWeapon(playerid,Item[ItemID][_Weapon],32767);
									DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],PlayerInventoryItemAmout(playerid,InventoryPrevieBox[playerid][index]));
								}
								case HAND_WEAPON_SLOT_4:
								{
								    GivePlayerWeapon(playerid,Item[ItemID][_Weapon],32767);
								}
				            }
							UpdateHandWeaponPrevieList(playerid,FreeHandSlot);
						}
			        }
			        case ITEM_ARMOUR,ITEM_HELMET,ITEM_MASK,ITEM_BACKPACK,ITEM_GLASS:
			        {
			 			new FreeHandSlot=GetPlayerBodyDressSlotFree(playerid,Item[ItemID][_BodyDressSlot]);
			 			if(FreeHandSlot!=NONE)
			 			{
				            pLastAliveBodyDress[playerid][_Body_Dress_Item][FreeHandSlot]=ItemID;
				            pLastAliveBodyDress[playerid][_Body_Dress_Durable][FreeHandSlot]=PlayerInventoryItemDurable(playerid,InventoryPrevieBox[playerid][index]);
							DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],1);
							UpdateBodyDressPrevieList(playerid,FreeHandSlot,FreeHandSlot);
							if(FreeHandSlot==2||FreeHandSlot==3)ShowPlayerValuePanelPrevie(playerid);
						}
			        }
			        case ITEM_FOOD,ITEM_DRINK:
			        {
					    if(pBuffID[playerid]==NONE)
					    {
					        pBuffID[playerid]=ItemID;
					        pBuffCount[playerid]=Item[ItemID][_BuffTime];
					        ShowBuffBar(playerid);
					        DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],1);
					    }
			        }
			        case ITEM_MEDICAL:
			        {
					    if(pCacheID[playerid]==NONE)
					    {
					        pCacheID[playerid]=ItemID;
					        pCacheCount[playerid]=Item[ItemID][_BuffTime];
					        ShowpCacheBar(playerid);
					        DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],1);
					    }
			        }
			    }
		    }
	    }
	}
    RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
    InventoryClickID[playerid]=NONE;
    DestoryPlayerInvItemBottonDo(playerid);
    return 1;
}
N::OnPlayerDropInventoryItem(playerid,index)
{
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
	    if(Iter_Contains(Inventory[playerid],InventoryPrevieBox[playerid][index]))
	    {
			if(InventoryPrevieBoxKey[playerid][index]==Inventory[playerid][InventoryPrevieBox[playerid][index]][_Key])
	  		{
	  		    new ItemID=PlayerInventoryItemID(playerid,InventoryPrevieBox[playerid][index]);
	  		    new Amout=PlayerInventoryItemAmout(playerid,InventoryPrevieBox[playerid][index]);
	  		    new Ammo=PlayerInventoryItemAmmo(playerid,InventoryPrevieBox[playerid][index]);
	  		    new Float:Durable=PlayerInventoryItemDurable(playerid,InventoryPrevieBox[playerid][index]);
	  		    DelIndexFromPlayerInventoy(playerid,InventoryPrevieBox[playerid][index],PlayerInventoryItemAmout(playerid,InventoryPrevieBox[playerid][index]));
				new Float:_@x,Float:_@y,Float:_@z;
				GetRandomXYInFrontOfPlayer(playerid,_@x,_@y,3.5);
				Tryg3D::MapAndreasFindZ(_@x,_@y,_@z);
				CreatePickItem(pGameID(playerid),NONE,ItemID,Amout,Ammo,Durable,_@x,_@y,_@z+0.3,0.0,0.0,0.0,GetPlayerInterior(playerid),50.0,2.5,0);
                RefreshPlayerNearByPrevie(playerid,pGameID(playerid),PLAYER_FIND_NEARBY_DISTANCE,NearByPreviePage[playerid]);
	  		}
	  	}
  	}
  	RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
    InventoryClickID[playerid]=NONE;
    DestoryPlayerInvItemBottonDo(playerid);
  	return 1;
}
N::AddThingToPlayerInventoy(playerid,itemid,amout,ammo,Float:durably)
{
    if(amout<1)return INVENTORY_SUCCESS;
    new bool:rate=false;
	if(!rate)
	{
	    if(Iter_Count(Inventory[playerid])>=MAX_PLAYERS_GAME_BAG)return INVENTORY_FULL;
		new BodyItemID=GetPlayerBodyDressItemID(playerid,BODY_DRESS_SLOT_5);
	    if(BodyItemID!=NONE)
	    {
	    	if(Iter_Count(Inventory[playerid])>=floatround(Item[BodyItemID][_BuffEffect],floatround_floor)+10)return INVENTORY_FULL;
	    }
	    else
		{
			if(Iter_Count(Inventory[playerid])>=10)return INVENTORY_FULL;
	    }
	    new i=Iter_Free(Inventory[playerid]);
	    Inventory[playerid][i][_Key]=GetTickCount();
	    Inventory[playerid][i][_ItemID]=itemid;
	    Inventory[playerid][i][_Amout]=amout;
	    if(Item[itemid][_Type]==ITEM_AMMO)Inventory[playerid][i][_Ammo]=ammo;
	    else Inventory[playerid][i][_Ammo]=0;
	    Inventory[playerid][i][_Durable]=durably;
	    Iter_Add(Inventory[playerid],i);
	    switch(Item[itemid][_Type])
	    {
	        case ITEM_WEAPON:
	        {
				new FreeHandSlot=GetPlayerHandWeaponSlotFree(playerid,Item[itemid][_HandWeaponSlot],itemid);
				if(FreeHandSlot!=NONE)
				{
					pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][FreeHandSlot]=itemid;
		            switch(Item[itemid][_HandWeaponSlot])
		            {
		                case HAND_WEAPON_SLOT_1,HAND_WEAPON_SLOT_2:
						{
						    DelIndexFromPlayerInventoy(playerid,i,PlayerInventoryItemAmout(playerid,i));
						    if(GetPlayerAmmoItemAmout(playerid,itemid)<=0)GivePlayerWeapon(playerid,Item[itemid][_Weapon],0);
							else GivePlayerWeapon(playerid,Item[itemid][_Weapon],32767);
						}
						case HAND_WEAPON_SLOT_3:
						{
						    DelIndexFromPlayerInventoy(playerid,i,PlayerInventoryItemAmout(playerid,i));
							GivePlayerWeapon(playerid,Item[itemid][_Weapon],32767);
						}
						case HAND_WEAPON_SLOT_4:
						{
						    if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]!=NONE)
						    {
						        if(pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][4]==itemid)
						        {
									GivePlayerWeapon(playerid,Item[itemid][_Weapon],32767);
						        }
							}
						}
		            }
					UpdateHandWeaponPrevieList(playerid,FreeHandSlot);
				}
	        }
	        case ITEM_AMMO:UpdatePlayerHandWeaponAmmo(playerid,itemid,true);
	        case ITEM_ARMOUR,ITEM_HELMET,ITEM_MASK,ITEM_BACKPACK,ITEM_GLASS:
	        {
	 			new FreeHandSlot=GetPlayerBodyDressSlotFree(playerid,Item[itemid][_BodyDressSlot]);
	 			if(FreeHandSlot!=NONE)
	 			{
		            pLastAliveBodyDress[playerid][_Body_Dress_Item][FreeHandSlot]=itemid;
		            pLastAliveBodyDress[playerid][_Body_Dress_Durable][FreeHandSlot]=PlayerInventoryItemDurable(playerid,i);
					DelIndexFromPlayerInventoy(playerid,i,1);
					UpdateBodyDressPrevieList(playerid,FreeHandSlot,FreeHandSlot);
					if(FreeHandSlot==2||FreeHandSlot==3)ShowPlayerValuePanelPrevie(playerid);
				}
	        }
	    }
	}
	return INVENTORY_SUCCESS;
}
N::DelItemFromPlayerInventoy(playerid,itemid,amout)
{
	new bool:rate=false;
	foreach(new i:Inventory[playerid])
   	{
   	    if(PlayerInventoryItemID(playerid,i)==itemid)
   	    {
   	        rate=true;
   	        if(Inventory[playerid][i][_Amout]>amout)
   	        {
   	            Inventory[playerid][i][_Amout]-=amout;
   	        }
   	        else
	   		{
    			new	cur = i;
   				Iter_SafeRemove(Inventory[playerid],cur,i);
   				break;
 			}
   	    }
	}
	if(!rate)return INVENTORY_NOEXIST;//不存在
    switch(Item[itemid][_Type])
    {
        case ITEM_AMMO:UpdatePlayerHandWeaponAmmo(playerid,itemid,true);
       	case ITEM_WEAPON:UpdatePlayerThrowHandWeaponAmmo(playerid,itemid);
    }
	return INVENTORY_SUCCESS;//成功
}
N::DelIndexFromPlayerInventoy(playerid,index,amout)
{
	new bool:rate=false,itemid=NONE;
	foreach(new i:Inventory[playerid])
   	{
   	    if(i==index)
   	    {
   	        itemid=PlayerInventoryItemID(playerid,i);
   	        if(Inventory[playerid][i][_Amout]>amout)
   	        {
   	            Inventory[playerid][i][_Amout]-=amout;
   	        }
   	        else
	   		{
    			new	cur = i;
   				Iter_SafeRemove(Inventory[playerid],cur,i);
 			}
   	        rate=true;
   	    }
	}
	if(!rate)return INVENTORY_NOEXIST;//不存在
	if(itemid!=NONE)
	{
	    switch(Item[itemid][_Type])
	    {
	        case ITEM_AMMO:UpdatePlayerHandWeaponAmmo(playerid,itemid,true);
         	case ITEM_WEAPON:UpdatePlayerThrowHandWeaponAmmo(playerid,itemid);
	    }
	}
	return INVENTORY_SUCCESS;//成功
}
N::GetPlayerInventoyItemAmout(playerid)return Iter_Count(Inventory[playerid]);
stock PlayerText:CreateInventoryPrevieBackGround(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.620832, 4.449999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 275.500000, 1.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
//PlayerTextDrawBackgroundColor(playerid, itemback1[playerid], -16776961);
//PlayerTextDrawBoxColor(playerid, itemback1[playerid], -16777166);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateInventoryPrevieModel(playerid, model, Float:Xpos, Float:Ypos, Float:Xrot, Float:Yrot, Float:Zrot, Float:mZoom)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos , Ypos , "Nowy_TextDraw");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 34.000000, 38.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, -741092520);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 3);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, Xrot, Yrot, Zrot, mZoom);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateInventoryPrevieNameTag(playerid,Float:Xpos, Float:Ypos ,text[])
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.216662, 1.499999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 408.000000, 17.000000);
	//PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.162499, 1.450000);
	//PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
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
stock PlayerText:CreateInventoryPrevieAmout(playerid,Float:Xpos, Float:Ypos,text[])
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, text);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 3);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.212500, 0.849999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 3);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateInventorySliderBar(playerid,pages)
{
    new ItemAmout=GetPlayerInventoyItemAmout(playerid);
    new Float:BarTextSize=floatdiv(35.100074,floatround(floatdiv(ItemAmout,MAX_INVENTORY_SHOW_LIST),floatround_ceil));
	if(pages<=0)pages=0;
	else pages--;
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, 282.000000, 92.000000+floatmul(pages,BarTextSize), "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, BarTextSize);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 288.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -171);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::RefreshPlayerInventoryPrevie(playerid,pages)//刷新背包
{
	forex(i,MAX_INVENTORY_SHOW_LIST)
	{
		if(InventoryBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryBackGround[playerid][i]);
		if(InventoryModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryModelDraw[playerid][i]);
		if(InventoryNameTag[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryNameTag[playerid][i]);
		if(InventoryItemAmout[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryItemAmout[playerid][i]);
		InventoryBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryNameTag[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryItemAmout[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(InventorySliderBarBackGround[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBarBackGround[playerid]);
	if(InventorySliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBar[playerid]);
	InventorySliderBarBackGround[playerid]=PlayerText:INVALID_TEXT_DRAW;
	InventorySliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	ShowPlayerInventoryPrevie(playerid,pages,true);
	return 1;
}
N::ShowPlayerInventoryPrevie(playerid,pages,bool:refresh)//显示背包
{
	new index=0,ItemAmout=0;
    InventoryPrevieRate[playerid]=0;
    InventoryPrevieCount[playerid]=1;
    InventoryClickID[playerid]=NONE;
    for(new i=Iter_End(Inventory[playerid]);(i=Iter_Prev(Inventory[playerid],i))!=Iter_Begin(Inventory[playerid]);)
	{
	    if(ItemAmout<MAX_INVENTORY_BOX_ITEMS-2)
	    {
			InventoryPrevieBox[playerid][InventoryPrevieCount[playerid]]=i;
			InventoryPrevieBoxKey[playerid][InventoryPrevieCount[playerid]]=Inventory[playerid][i][_Key];
	   		InventoryPrevieCount[playerid]++;
	   		ItemAmout++;
   		}
	}
	if(pages<1)pages=1;
	if(pages>floatround((InventoryPrevieCount[playerid]-1)/float(MAX_INVENTORY_SHOW_LIST),floatround_ceil))pages=floatround((InventoryPrevieCount[playerid]-1)/float(MAX_INVENTORY_SHOW_LIST),floatround_ceil);
    InventoryPreviePage[playerid]=pages;
    pages=(pages-1)*MAX_INVENTORY_SHOW_LIST;
    if(pages<=0)pages=1;else pages++;
	Loop(i,pages,pages+MAX_INVENTORY_SHOW_LIST)
	{
	    index=InventoryPrevieBox[playerid][i];
	    if(i<InventoryPrevieCount[playerid])
		{
            InventoryBackGround[playerid][InventoryPrevieRate[playerid]]=CreateInventoryPrevieBackGround(playerid, 159.000000, 57.000000+InventoryPrevieRate[playerid]*43);
            InventoryModelDraw[playerid][InventoryPrevieRate[playerid]]=CreateInventoryPrevieModel(playerid,Item[PlayerInventoryItemID(playerid,index)][_Model], 159.000000, 58.000000+InventoryPrevieRate[playerid]*43, -10.000000, 0.000000, 169.000000, 0.860000);
            fLine_64("%s~n~~r~%s",Item[PlayerInventoryItemID(playerid,index)][_Name],Item[PlayerInventoryItemID(playerid,index)][_SizeName]);
			InventoryNameTag[playerid][InventoryPrevieRate[playerid]]=CreateInventoryPrevieNameTag(playerid, 195.000000, 56.000000+InventoryPrevieRate[playerid]*43,line);
            switch(Item[PlayerInventoryItemID(playerid,index)][_Type])
            {
                case ITEM_AMMO:format(line,64,"%i",PlayerInventoryItemAmmo(playerid,index));
                case ITEM_WEAPON:format(line,64," ");
                case ITEM_ARMOUR,ITEM_HELMET:
				{
				    new Float:percent=ReturnPercent(PlayerInventoryItemDurable(playerid,index),Item[PlayerInventoryItemID(playerid,index)][_Durable]);
					format(line,64,"%0.1f%%",percent);
				}
                default:format(line,64,"X%i",PlayerInventoryItemAmout(playerid,index));
            }
            InventoryItemAmout[playerid][InventoryPrevieRate[playerid]]=CreateInventoryPrevieAmout(playerid, 192.000000, 87.500000+InventoryPrevieRate[playerid]*43,line);
			InventoryPrevieRate[playerid]++;
		}
		if(i>=InventoryPrevieCount[playerid])break;
	}
	InventorySliderBarBackGround[playerid] = CreatePlayerTextDraw(playerid, 280.000000, 89.000000, "~n~");
	PlayerTextDrawFont(playerid, InventorySliderBarBackGround[playerid], 1);
	PlayerTextDrawLetterSize(playerid, InventorySliderBarBackGround[playerid], 0.600000, 35.700080);
	PlayerTextDrawTextSize(playerid, InventorySliderBarBackGround[playerid], 290.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, InventorySliderBarBackGround[playerid], 1);
	PlayerTextDrawSetShadow(playerid, InventorySliderBarBackGround[playerid], 0);
	PlayerTextDrawAlignment(playerid, InventorySliderBarBackGround[playerid], 1);
	PlayerTextDrawColor(playerid, InventorySliderBarBackGround[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InventorySliderBarBackGround[playerid], 232);
	PlayerTextDrawBoxColor(playerid, InventorySliderBarBackGround[playerid], 149);
	PlayerTextDrawUseBox(playerid, InventorySliderBarBackGround[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InventorySliderBarBackGround[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, InventorySliderBarBackGround[playerid], 0);
	PlayerTextDrawShow(playerid,InventorySliderBarBackGround[playerid]);

	InventorySliderBar[playerid] = CreateInventorySliderBar(playerid,pages);
	if(refresh==false)
	{
		InventorySliderBarButtonBack[playerid] = CreatePlayerTextDraw(playerid, 277.000000, 70.000000, "LD_BEAT:up");
		PlayerTextDrawFont(playerid, InventorySliderBarButtonBack[playerid], 4);
		PlayerTextDrawLetterSize(playerid, InventorySliderBarButtonBack[playerid], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InventorySliderBarButtonBack[playerid], 16.500000, 18.000000);
		PlayerTextDrawSetOutline(playerid, InventorySliderBarButtonBack[playerid], 1);
		PlayerTextDrawSetShadow(playerid, InventorySliderBarButtonBack[playerid], 0);
		PlayerTextDrawAlignment(playerid, InventorySliderBarButtonBack[playerid], 1);
		PlayerTextDrawColor(playerid, InventorySliderBarButtonBack[playerid], -1);
		PlayerTextDrawBackgroundColor(playerid, InventorySliderBarButtonBack[playerid], 255);
		PlayerTextDrawBoxColor(playerid, InventorySliderBarButtonBack[playerid], 50);
		PlayerTextDrawUseBox(playerid, InventorySliderBarButtonBack[playerid], 1);
		PlayerTextDrawSetProportional(playerid, InventorySliderBarButtonBack[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, InventorySliderBarButtonBack[playerid], 1);
		PlayerTextDrawShow(playerid,InventorySliderBarButtonBack[playerid]);

		InventorySliderBarButtonNext[playerid] = CreatePlayerTextDraw(playerid, 277.000000, 412.000000, "LD_BEAT:down");
		PlayerTextDrawFont(playerid, InventorySliderBarButtonNext[playerid], 4);
		PlayerTextDrawLetterSize(playerid, InventorySliderBarButtonNext[playerid], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InventorySliderBarButtonNext[playerid], 16.500000, 18.000000);
		PlayerTextDrawSetOutline(playerid, InventorySliderBarButtonNext[playerid], 1);
		PlayerTextDrawSetShadow(playerid, InventorySliderBarButtonNext[playerid], 0);
		PlayerTextDrawAlignment(playerid, InventorySliderBarButtonNext[playerid], 1);
		PlayerTextDrawColor(playerid, InventorySliderBarButtonNext[playerid], -1);
		PlayerTextDrawBackgroundColor(playerid, InventorySliderBarButtonNext[playerid], 255);
		PlayerTextDrawBoxColor(playerid, InventorySliderBarButtonNext[playerid], 50);
		PlayerTextDrawUseBox(playerid, InventorySliderBarButtonNext[playerid], 1);
		PlayerTextDrawSetProportional(playerid, InventorySliderBarButtonNext[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, InventorySliderBarButtonNext[playerid], 1);
		PlayerTextDrawShow(playerid,InventorySliderBarButtonNext[playerid]);
	}
	return 1;
}
N::DestoryPlayerInvDraw(playerid)
{
	forex(i,MAX_INVENTORY_SHOW_LIST)
	{
		if(InventoryBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryBackGround[playerid][i]);
		if(InventoryModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryModelDraw[playerid][i]);
		if(InventoryNameTag[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryNameTag[playerid][i]);
		if(InventoryItemAmout[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventoryItemAmout[playerid][i]);
		InventoryBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryNameTag[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryItemAmout[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(InventorySliderBarBackGround[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBarBackGround[playerid]);
	if(InventorySliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBar[playerid]);
	if(InventorySliderBarButtonBack[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBarButtonBack[playerid]);
	if(InventorySliderBarButtonNext[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,InventorySliderBarButtonNext[playerid]);
	InventorySliderBarBackGround[playerid]=PlayerText:INVALID_TEXT_DRAW;
	InventorySliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	InventorySliderBarButtonBack[playerid]=PlayerText:INVALID_TEXT_DRAW;
	InventorySliderBarButtonNext[playerid]=PlayerText:INVALID_TEXT_DRAW;
	DestoryPlayerInvItemBottonDo(playerid);
    return 1;
}
N::RestPlayerInventoryData(playerid)
{
	ResetPlayerWeapons(playerid);
    forex(s,MAX_PLAYER_BODY_SLOT_DRAW)
	{
	    pLastAliveBodyDress[playerid][_Body_Dress_Item][s]=NONE;
	    pLastAliveBodyDress[playerid][_Body_Dress_Durable][s]=0.0;
	}
    forex(s,MAX_PLAYER_WEAPON_SLOT_DRAW)pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][s]=NONE;
    forex(s,MAX_PLAYER_WEAPON_SLOT_DRAW)pLastAliveHandWeapon[playerid][_Hand_Weapon_Item][s]=NONE;
    Iter_Clear(Inventory[playerid]);
	return 1;
}
