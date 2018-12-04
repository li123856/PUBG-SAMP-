N::OnPlayerClickNearByItem(playerid,index)
{
    if(IsPlayerInAnyDynamicVehicle(playerid))return GameTextForPlayer(playerid, "You need get off to pick up", 3000, 3);
    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
    {
	    if(Iter_Contains(PickItem[pGameID(playerid)],NearByPrevieBox[playerid][index]))
	    {
	        if(NearByPrevieBoxKey[playerid][index]==PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Key])
	        {
	        	new ItemID=PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_ItemID];
	        	switch(Item[ItemID][_Type])
	        	{
	        	    case ITEM_AMMO:
					{
						if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Amout],PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Ammo],0.0)==INVENTORY_FULL)
						{
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
						    return 1;
	  					}
                    }
					case ITEM_HELMET,ITEM_ARMOUR:
					{
						if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Amout],0,PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Durable])==INVENTORY_FULL)
						{
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
						    return 1;
	  					}
                    }
					default:
					{
						if(AddThingToPlayerInventoy(playerid,ItemID,PickItem[pGameID(playerid)][NearByPrevieBox[playerid][index]][_Amout],0,0.0)==INVENTORY_FULL)
						{
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BAG_FULL));
						    return 1;
	  					}
                    }
				}
				DestoryPickItem(pGameID(playerid),NearByPrevieBox[playerid][index]);
	        	RefreshPlayerInventoryPrevie(playerid,InventoryPreviePage[playerid]);
	        }
	    }
    }
    RefreshPlayerNearByPrevie(playerid,pGameID(playerid),PLAYER_FIND_NEARBY_DISTANCE,NearByPreviePage[playerid]);
	return 1;
}
N::CreatePickItem(gameid,from,item,amout,ammo,Float:durable,Float:_@x,Float:_@y,Float:_@z,Float:_@rx,Float:_@ry,Float:_@rz,_@interior,Float:_@streamdistance,Float:_@areasize,_@testlos)
{
    if(Iter_Count(PickItem[gameid])>=MAX_PICKITEM)return 0;
    new i=Iter_Free(PickItem[gameid]);
    PickItem[gameid][i][_Key]=GetTickCount();
    PickItem[gameid][i][_From]=from;
	PickItem[gameid][i][_ItemID]=item;
	PickItem[gameid][i][_Amout]=amout;
	PickItem[gameid][i][_Ammo]=ammo;
	PickItem[gameid][i][_Durable]=durable;
	PickItem[gameid][i][_x]=_@x;
	PickItem[gameid][i][_y]=_@y;
	PickItem[gameid][i][_z]=_@z;
	PickItem[gameid][i][_rx]=_@rx;
	PickItem[gameid][i][_ry]=_@ry;
	PickItem[gameid][i][_rz]=_@ry;
	PickItem[gameid][i][_Interior]=_@interior;
	PickItem[gameid][i][_Obj]=CreateDynamicObject(Item[item][_Model],_@x,_@y,_@z,_@rx,_@ry,_@rz,GameRoom(gameid),_@interior,-1,_@streamdistance);
	PickItem[gameid][i][_Text]=CreateDynamic3DTextLabel(" ",-1,_@x,_@y,_@z+0.2,_@streamdistance,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,STREAMER_VEHICLE_TYPE_DYNAMIC,_@testlos,GameRoom(gameid),_@interior);
	PickItem[gameid][i][_Area]=CreateDynamicSphere(_@x,_@y,_@z,_@areasize,GameRoom(gameid),_@interior);
	Iter_Add(PickItem[gameid],i);
	new str[32];
	switch(Item[item][_Type])
	{
		case ITEM_WEAPON:format(str,sizeof(str),"{80FFFF}");
		case ITEM_AMMO:format(str,sizeof(str),"{00FFFF}");
		case ITEM_ARMOUR:format(str,sizeof(str),"{00FF80}");
		case ITEM_HELMET:format(str,sizeof(str),"{00FF80}");
		case ITEM_MASK:format(str,sizeof(str),"{C0C0C0}");
		case ITEM_MEDICAL:format(str,sizeof(str),"{FF8040}");
		case ITEM_BACKPACK:format(str,sizeof(str),"{FF80FF}");
		case ITEM_FOOD:format(str,sizeof(str),"{FF8000}");
		case ITEM_GLASS:format(str,sizeof(str),"{C0C0C0}");
		case ITEM_DRINK:format(str,sizeof(str),"{FF8000}");
	}
	fLine_64("%s%s\n%s",str,Item[item][_ChineseName],Item[item][_Name]);
	UpdatePickItemText(gameid,i,-1,line);
	return 1;
}
N::UpdatePickItemText(gameid,index,color,text[])
{
    if(Iter_Contains(PickItem[gameid],index))UpdateDynamic3DTextLabelText(PickItem[gameid][index][_Text],color,text);
	return 1;
}
N::DestoryPickItem(gameid,index)
{
    if(Iter_Contains(PickItem[gameid],index))
    {
		if(PickItem[gameid][index][_From]!=NONE)
		{
		    LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][index][_From]]--;
			if(LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][index][_From]]<=0)
			{
			    if(LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][index][_From]]!=INVALID_STREAMER_ID)
			    {
			    	DestroyDynamicMapIcon(LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][index][_From]]);
			    	LastAliveGame[gameid][_PickItem_MapIcon][PickItem[gameid][index][_From]]=INVALID_STREAMER_ID;
			    }
			    LastAliveGame[gameid][_PickItem_MapAmout][PickItem[gameid][index][_From]]=0;
			}
		}
        DestroyDynamicObject(PickItem[gameid][index][_Obj]);
        DestroyDynamic3DTextLabel(PickItem[gameid][index][_Text]);
        DestroyDynamicArea(PickItem[gameid][index][_Area]);
        PickItem[gameid][index][_Obj]=INVALID_STREAMER_ID;
        PickItem[gameid][index][_Text]=Text3D:INVALID_STREAMER_ID;
        PickItem[gameid][index][_Area]=INVALID_STREAMER_ID;
        Iter_Remove(PickItem[gameid],index);
    }
	return 1;
}
N::PickItemInRange(gameid,Float:_@x,Float:_@y,Float:_@range)
{
	if(Iter_Count(PickItem[gameid])>0)
	{
	    foreach(new i:PickItem[gameid])
	    {
	        new Float:distancez=GetDistanceBetweenPoints2D(PickItem[gameid][i][_x],PickItem[gameid][i][_y],_@x,_@y);
	        if(distancez<_@range)return true;
	    }
    }
	return false;
}

