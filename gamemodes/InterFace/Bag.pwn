N::OnPlayerClickPlayerBagItem(playerid,index)
{
    if(Iter_Contains(Bag[playerid],PlayerBagPrevieBox[playerid][index]))
    {
		if(PlayerBagPrevieBoxKey[playerid][index]==Bag[playerid][PlayerBagPrevieBox[playerid][index]][_Key])
  		{
		    fLine_128(ReturnMLStr(pLang(playerid),_BAG_DIALOG1),MallItem[PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])][_Name],PlayerBagItemAmout(playerid,PlayerBagPrevieBox[playerid][index]));
		    Dialog@Show(playerid,_BAG_USE,DIALOG_STYLE_LIST,line,ReturnMLStr(pLang(playerid),_BAG_DIALOG2),ReturnMLStr(pLang(playerid),_BAG_DIALOG3),ReturnMLStr(pLang(playerid),_BAG_DIALOG4));
			SetPVarInt(playerid,"_PlayerBagItem",index);
        }
    }
   	return 1;
}

N::GetPlayerBagAllItemAmout(playerid)
{
	new Amout=0;
	foreach(new i:Bag[playerid])Amout+=PlayerBagItemAmout(playerid,i);
   	return Amout;
}
N::GetPlayerBagItemNumberByType(playerid,type)
{
    new Amout=0;
    foreach(new i:Bag[playerid])
    {
        if(MallItem[PlayerBagItemID(playerid,i)][_Type]==type)Amout++;
    }
   	return Amout;
}
N::AddItemToPlayerBag(playerid,itemID,amout)//道具添加到背包
{
	if(amout<1)return BAG_SUCCESS;
	if(Iter_Count(Bag[playerid])>=MAX_PLAYER_BAG)return BAG_FULL;
	if(Iter_Count(Bag[playerid])>LevelRank[Account[playerid][_Level]][_bagslots])return BAG_FULL;
	if(GetPlayerBagAllItemAmout(playerid)>LevelRank[Account[playerid][_Level]][_bagslots])return BAG_FULL;
	if(GetPlayerBagAllItemAmout(playerid)+amout>LevelRank[Account[playerid][_Level]][_bagslots])return BAG_FULL;
	new bool:rate=false;
	foreach(new i:Bag[playerid])
   	{
   	    if(Bag[playerid][i][_ItemID]==itemID)
   	    {
   	        Bag[playerid][i][_Amout]+=amout;
   	        new Query[128];
		    format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_BAG"` SET  `数量` =  '%i' WHERE  `"MYSQL_DB_BAG"`.`编号` ='%i'",Bag[playerid][i][_Amout],Bag[playerid][i][_Key]);
			mysql_query(User@Handle,Query,false);
	        rate=true;
   	    }
	}
	if(!rate)
	{
    	new i=Iter_Free(Bag[playerid]);
    	Bag[playerid][i][_ItemID]=itemID;
    	Bag[playerid][i][_Owner]=Account[playerid][_Key];
    	Bag[playerid][i][_Amout]=amout;

    	new Query[256];
        format(Query,sizeof(Query),"INSERT INTO `"MYSQL_DB_BAG"`(`归属`,`道具ID`,`数量`) VALUES ('%i','%i','%i')",Bag[playerid][i][_Owner],Bag[playerid][i][_ItemID],Bag[playerid][i][_Amout]);
   		mysql_query(User@Handle,Query,true);
   		
        Bag[playerid][i][_Key]=cache_insert_id();
        Iter_Add(Bag[playerid],i);
	}
	return BAG_SUCCESS;
}
N::DelPlayerBagByIndex(playerid,index,amout)//背包删除道具
{
    if(amout<1)return BAG_SUCCESS;
	new bool:rate=false;
	foreach(new i:Bag[playerid])
   	{
   	    if(i==index)
   	    {
   	        if(Bag[playerid][i][_Amout]>amout)
   	        {
   	            Bag[playerid][i][_Amout]-=amout;

	   	        new Query[128];
			    format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_BAG"` SET  `数量` =  '%i' WHERE  `"MYSQL_DB_BAG"`.`编号` ='%i'",Bag[playerid][i][_Amout],Bag[playerid][i][_Key]);
				mysql_query(User@Handle,Query,false);
   	        }
   	        else
	   		{
	   		    new Query[128];
	   		    format(Query,sizeof(Query),"DELETE FROM `"MYSQL_DB_BAG"` WHERE `编号`='%i'",Bag[playerid][i][_Key]);
				mysql_query(User@Handle,Query,false);

    			new	cur = i;
   				Iter_SafeRemove(Bag[playerid],cur,i);
 			}
   	        rate=true;
   	    }
	}
	if(!rate)return BAG_NOEXIST;//不存在
	return BAG_SUCCESS;//成功
}
N::Bag@OnGameModeInit()
{
	new Text:MallDraw=Text:INVALID_TEXT_DRAW;
	MallDraw = TextDrawCreate(519.000000, 81.000000, "~n~");//bagground
	TextDrawFont(MallDraw, 0);
	TextDrawLetterSize(MallDraw, 0.600000, 40.699996);
	TextDrawTextSize(MallDraw, 400.000000, 243.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 1714657791);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[0]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(519.000000, 81.000000, "~n~");//bagcaptionground
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 400.000000, 242.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -1);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[1]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(399.000000, 82.000000, "ld_beat:cross");//close
	TextDrawFont(MallDraw, 4);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 14.000000, 16.000000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	BagBackGround[2]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(519.000000, 81.000000, "MY BAG");//bagtag
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.600000, 2.000000);
	TextDrawTextSize(MallDraw, 400.000000, 132.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, 255);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[3]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(514.000000, 126.000000, "~n~");//background1
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, 0.600000, 35.249988);
	TextDrawTextSize(MallDraw, 400.000000, 227.500000);
	TextDrawSetOutline(MallDraw, 1);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -2686721);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 9145343);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[4]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(428.000000, 104.000000, "~n~");//tag1
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, -0.066665, 1.899999);
	TextDrawTextSize(MallDraw, 282.000000, 56.500000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -2016478465);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[5]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(489.000000, 104.000000, "~n~");//tag2
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, -0.066665, 1.899999);
	TextDrawTextSize(MallDraw, 282.000000, 56.500000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -2016478465);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[6]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(550.000000, 104.000000, "~n~");//tag3
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, -0.066665, 1.899999);
	TextDrawTextSize(MallDraw, 282.000000, 56.500000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -2016478465);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[7]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(611.000000, 104.000000, "~n~");//tag4
	TextDrawFont(MallDraw, 1);
	TextDrawLetterSize(MallDraw, -0.066665, 1.899999);
	TextDrawTextSize(MallDraw, 282.000000, 56.500000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 2);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, -2016478465);
	TextDrawUseBox(MallDraw, 1);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 0);
	BagBackGround[8]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;
	
	MallDraw = TextDrawCreate(403.000000, 105.000000, "SKINS");
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.416666, 1.600000);
	TextDrawTextSize(MallDraw, 450.500000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	BagBackGround[9]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;
	
	MallDraw = TextDrawCreate(460.000000, 105.000000, "adorn");
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.416666, 1.600000);
	TextDrawTextSize(MallDraw, 516.000000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	BagBackGround[10]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;

	MallDraw = TextDrawCreate(528.000000, 105.000000, "boxs");
	TextDrawFont(MallDraw, 2);
	TextDrawLetterSize(MallDraw, 0.416666, 1.600000);
	TextDrawTextSize(MallDraw, 572.000000, 17.000000);
	TextDrawSetOutline(MallDraw, 0);
	TextDrawSetShadow(MallDraw, 0);
	TextDrawAlignment(MallDraw, 1);
	TextDrawColor(MallDraw, -1);
	TextDrawBackgroundColor(MallDraw, 255);
	TextDrawBoxColor(MallDraw, 50);
	TextDrawUseBox(MallDraw, 0);
	TextDrawSetProportional(MallDraw, 1);
	TextDrawSetSelectable(MallDraw, 1);
	BagBackGround[11]=MallDraw;
	MallDraw=Text:INVALID_TEXT_DRAW;
	return 1;
}
stock PlayerText:CreatePlayerBagSliderBar(playerid,pages,type)//进度条
{
    new ItemAmout=GetPlayerBagItemNumberByType(playerid,type);
    if(ItemAmout<=0)ItemAmout=1;
    new Float:BarTextSize=floatdiv(32.650020,floatround(floatdiv(ItemAmout,MAX_PLAYERBAG_SHOW_LIST),floatround_ceil));
	if(pages<=0)pages=0;
	else pages--;
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, 635.000000, 138.000000+floatmul(pages,BarTextSize)*0.75, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, BarTextSize);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 5.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagBackBottonPrevie(playerid,Float:Xpos, Float:Ypos)//前页按钮
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:up");//前页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, -0.941666, 14.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 12.000000, 11.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagNextBottonPrevie(playerid,Float:Xpos, Float:Ypos)//后页按钮
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:down");//后页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, -0.941666, 14.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 12.000000, 11.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagPrevieCapacity(playerid,string[],Float:Xpos, Float:Ypos)//背包容量
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, string);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.250000, 0.899999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 3);
	PlayerTextDrawColor(playerid, PlayerTextDraw, 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagPrevieBackGround(playerid, Float:Xpos, Float:Ypos)//单元背景
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.633333, 8.250000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 71.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 1296911871);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagPrevieModel(playerid,model,Float:Xpos, Float:Ypos,color)//单元模型
{
    new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 90.500000, 83.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, color);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBagPrevieAmount(playerid,amount[],Float:Xpos, Float:Ypos)//单元数量
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, amount);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.204163, 1.250000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
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
stock PlayerText:CreatePlayerBagPrevieName(playerid,string[],Float:Xpos, Float:Ypos)//单元名
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, string);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.275000, 1.149999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -2686721);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::CreatePlayerBagPage(playerid,type,pages,bool:refresh)//创建背包单元项目
{
	new index=0,ItemAmout=0;
    PlayerBagPrevieRate[playerid]=0;
    PlayerBagPrevieCount[playerid]=1;
    PlayerBagClickID[playerid]=NONE;
    
    foreach(new i:Bag[playerid])
    {
        if(MallItem[PlayerBagItemID(playerid,i)][_Type]==type)
        {
		    if(ItemAmout<MAX_PLAYERBAG_BOX_ITEMS-2)
		    {
				PlayerBagPrevieBox[playerid][PlayerBagPrevieCount[playerid]]=i;
				PlayerBagPrevieBoxKey[playerid][PlayerBagPrevieCount[playerid]]=Bag[playerid][i][_Key];
	   			PlayerBagPrevieCount[playerid]++;
	   			ItemAmout++;
		    }
	    }
	}
	if(pages<1)pages=1;
	if(pages>floatround((PlayerBagPrevieCount[playerid]-1)/float(MAX_PLAYERBAG_SHOW_LIST),floatround_ceil))pages=floatround((PlayerBagPrevieCount[playerid]-1)/float(MAX_PLAYERBAG_SHOW_LIST),floatround_ceil);
    PlayerBagPreviePage[playerid]=pages;
    pages=(pages-1)*MAX_PLAYERBAG_SHOW_LIST;
    if(pages<=0)pages=1;else pages++;
    new BreakLine=0,NowLine=0;
	Loop(i,pages,pages+MAX_PLAYERBAG_SHOW_LIST)
	{
	    index=PlayerBagPrevieBox[playerid][i];
	    if(i<PlayerBagPrevieCount[playerid])
		{
		    if(BreakLine>=3)
			{
				NowLine++;
				BreakLine=0;
			}
			new Float:BackGroundX=438.000000+(PlayerBagPrevieRate[playerid]-NowLine*3)*76.0;
			new Float:BackGroundY=128.000000+NowLine*79.5;

			new Float:ModelX=392.000000+(PlayerBagPrevieRate[playerid]-NowLine*3)*76.0;
			new Float:ModelY=123.000000+NowLine*79.5;

			new Float:AmountX=474.000000+(PlayerBagPrevieRate[playerid]-NowLine*3)*76.0;
			new Float:AmountY=192.000000+NowLine*79.5;

			new Float:NameX=403.000000+(PlayerBagPrevieRate[playerid]-NowLine*3)*76.0;
			new Float:NameY=126.000000+NowLine*79.5;

			PlayerBagBackGround[playerid][PlayerBagPrevieRate[playerid]] = CreatePlayerBagPrevieBackGround(playerid,BackGroundX,BackGroundY);
			PlayerBagModelDraw[playerid][PlayerBagPrevieRate[playerid]] = CreatePlayerBagPrevieModel(playerid,MallItem[PlayerBagItemID(playerid,index)][_Model],ModelX,ModelY,MallItem[PlayerBagItemID(playerid,index)][_Extra1]);
			new str[32];
			format(str,sizeof(str),"%s",MallItem[PlayerBagItemID(playerid,index)][_Name]);
			PlayerBagName[playerid][PlayerBagPrevieRate[playerid]]=CreatePlayerBagPrevieName(playerid,str,NameX,NameY);
            format(str,sizeof(str),"%i",PlayerBagItemAmout(playerid,index));
			PlayerBagAmount[playerid][PlayerBagPrevieRate[playerid]]=CreatePlayerBagPrevieAmount(playerid,str,AmountX,AmountY);
			PlayerBagPrevieRate[playerid]++;
			BreakLine++;
		}
		if(i>=PlayerBagPrevieCount[playerid])break;
	}
  	PlayerBagSliderBar[playerid]=CreatePlayerBagSliderBar(playerid,pages,type);
	fLine_32("(%i/%i)",GetPlayerBagAllItemAmout(playerid),LevelRank[Account[playerid][_Level]][_bagslots]);
	PlayerBagCapacity[playerid]=CreatePlayerBagPrevieCapacity(playerid,line,640.000000, 91.000000);
	if(refresh==false)
	{
		PlayerBagBottonUp[playerid]=CreatePlayerBagBackBottonPrevie(playerid,629.000000, 125.000000);
		PlayerBagBottonDown[playerid]=CreatePlayerBagNextBottonPrevie(playerid,629.000000, 435.000000);
	}
	return 1;
}
N::DestoryPlayerBagDraw(playerid)//删除商城
{
	forex(i,MAX_PLAYERBAG_SHOW_LIST)
	{
		if(PlayerBagModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagModelDraw[playerid][i]);
		if(PlayerBagBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagBackGround[playerid][i]);
		if(PlayerBagName[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagName[playerid][i]);
		if(PlayerBagAmount[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagAmount[playerid][i]);
		PlayerBagModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagName[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagAmount[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(PlayerBagSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagSliderBar[playerid]);
	if(PlayerBagBottonUp[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagBottonUp[playerid]);
	if(PlayerBagBottonDown[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagBottonDown[playerid]);
	if(PlayerBagCapacity[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagCapacity[playerid]);
	PlayerBagSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBagBottonUp[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBagBottonDown[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBagCapacity[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::RefreshPlayerBagPrevie(playerid,pages,type)//刷新商城
{
	forex(i,MAX_PLAYERBAG_SHOW_LIST)
	{
		if(PlayerBagModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagModelDraw[playerid][i]);
		if(PlayerBagBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagBackGround[playerid][i]);
		if(PlayerBagName[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagName[playerid][i]);
		if(PlayerBagAmount[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagAmount[playerid][i]);
		PlayerBagModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagName[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagAmount[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(PlayerBagSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagSliderBar[playerid]);
	PlayerBagSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	if(PlayerBagCapacity[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBagCapacity[playerid]);
	PlayerBagCapacity[playerid]=PlayerText:INVALID_TEXT_DRAW;
	CreatePlayerBagPage(playerid,type,pages,true);
	return 1;
}
N::ShowUserBag(playerid,type)
{
    HideUserMall(playerid,false);
    HideUserBag(playerid,false);
    ShowPlayerBagBackGround(playerid);
	CreatePlayerBagPage(playerid,type,1,false);
	HidePlayerFaceMenuCdsDraw(playerid);
    return 1;
}
N::HideUserBag(playerid,bool:disconnect)
{
    DestoryPlayerBagDraw(playerid);
    HidePlayerBagBackGround(playerid);
    if(disconnect==false)ShowPlayerFaceMenuCdsDraw(playerid);
    return 1;
}
N::ClearPlayerBagClickState(playerid)
{
	if(PlayerBagClickID[playerid]!=NONE)
	{
		PlayerTextDrawBackgroundColor(playerid, PlayerBagBackGround[playerid][PlayerBagClickID[playerid]], 255);
		PlayerTextDrawBoxColor(playerid, PlayerBagBackGround[playerid][PlayerBagClickID[playerid]], 9145343);
        PlayerTextDrawShow(playerid,PlayerBagBackGround[playerid][PlayerBagClickID[playerid]]);
	}
	PlayerBagClickID[playerid]=NONE;
	return 1;
}
N::ShowPlayerBagBackGround(playerid)
{
	forex(i,MAX_BAG_BACKGROUND)TextDrawShowForPlayer(playerid,BagBackGround[i]);
	return 1;
}
N::HidePlayerBagBackGround(playerid)
{
	forex(i,MAX_BAG_BACKGROUND)TextDrawHideForPlayer(playerid,BagBackGround[i]);
	return 1;
}

stock PlayerText:CreatePlayerBoxBackPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 15.100000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 207.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBoxModelPrevie(playerid,Float:Xpos, Float:Ypos,model,color)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 63.500000, 57.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, color);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -10.000000, 0.000000, -1.000000, 0.800000);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBoxTagPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "BOX_OPENED");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
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
stock PlayerText:CreatePlayerBoxClosePrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:cross");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 7.500000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 11.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBoxGiftPrevie(playerid,Float:Xpos, Float:Ypos,model,color)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 66.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, color);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreatePlayerBoxGiftTextPrevie(playerid,Float:Xpos, Float:Ypos,itemname[])
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, itemname);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.191666, 1.099998);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -741092353);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
N::CloseGiftBox(playerid)
{
	if(PlayerBoxBackDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxBackDraw[playerid]);
	if(PlayerBoxModelDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxModelDraw[playerid]);
	if(PlayerBoxTagDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxTagDraw[playerid]);
	if(PlayerBoxCloseDraw[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxCloseDraw[playerid]);
	PlayerBoxBackDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBoxModelDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBoxTagDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerBoxCloseDraw[playerid]=PlayerText:INVALID_TEXT_DRAW;
	forex(i,MAX_PLAYER_GIFTS)
	{
	    if(PlayerBoxGiftDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftDraw[playerid][i]);
	    if(PlayerBoxGiftTextDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerBoxGiftTextDraw[playerid][i]);
        PlayerBoxGiftDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
        PlayerBoxGiftTextDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBoxGift[playerid][i]=NONE;
	}
	return 1;
}
N::IsGiftGetDown(playerid)
{
	new amount=0;
	forex(i,MAX_PLAYER_GIFTS)
	{
	    if(PlayerBoxGift[playerid][i]!=NONE)amount++;
	}
	return amount;
}
N::OpenGiftBox(playerid,type,boxitemid)
{
    CloseGiftBox(playerid);
    new gift1=NONE,gift2=NONE,gift3=NONE;
	PlayerBoxBackDraw[playerid]=CreatePlayerBoxBackPrevie(playerid,320.000000, 144.000000);
	PlayerBoxModelDraw[playerid]=CreatePlayerBoxModelPrevie(playerid,288.000000, 156.000000,MallItem[boxitemid][_Model],MallItem[boxitemid][_Extra1]);
	PlayerBoxTagDraw[playerid]=CreatePlayerBoxTagPrevie(playerid,320.000000, 144.000000);
	PlayerBoxCloseDraw[playerid]=CreatePlayerBoxClosePrevie(playerid,414.000000, 143.000000);
	switch(type)
	{
	    case 1:
	    {
            gift1=random(sizeof(MallItem));
            PlayerBoxGift[playerid][0]=gift1;
            PlayerBoxGiftDraw[playerid][0]=CreatePlayerBoxGiftPrevie(playerid,286.000000, 214.000000,MallItem[gift1][_Model],MallItem[gift1][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][0]=CreatePlayerBoxGiftTextPrevie(playerid,286.000000+33.0, 214.000000+58.0,MallItem[gift1][_Name]);
	    }
	    case 2:
	    {
            gift1=random(sizeof(MallItem));
            gift2=random(sizeof(MallItem));
            PlayerBoxGift[playerid][0]=gift1;
            PlayerBoxGift[playerid][1]=gift2;
            PlayerBoxGiftDraw[playerid][0]=CreatePlayerBoxGiftPrevie(playerid,218.000000, 214.000000,MallItem[gift1][_Model],MallItem[gift1][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][0]=CreatePlayerBoxGiftTextPrevie(playerid,218.000000+33.0, 214.000000+58.0,MallItem[gift1][_Name]);
            PlayerBoxGiftDraw[playerid][1]=CreatePlayerBoxGiftPrevie(playerid,354.000000, 214.000000,MallItem[gift2][_Model],MallItem[gift2][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][1]=CreatePlayerBoxGiftTextPrevie(playerid,354.000000+33.0, 214.000000+58.0,MallItem[gift2][_Name]);
	    }
	    case 3:
	    {
            gift1=random(sizeof(MallItem));
            gift2=random(sizeof(MallItem));
            gift3=random(sizeof(MallItem));
            PlayerBoxGift[playerid][0]=gift1;
            PlayerBoxGift[playerid][1]=gift2;
            PlayerBoxGift[playerid][2]=gift3;
            PlayerBoxGiftDraw[playerid][0]=CreatePlayerBoxGiftPrevie(playerid,218.000000, 214.000000,MallItem[gift1][_Model],MallItem[gift1][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][0]=CreatePlayerBoxGiftTextPrevie(playerid,218.000000+33.0, 214.000000+58.0,MallItem[gift1][_Name]);
            PlayerBoxGiftDraw[playerid][1]=CreatePlayerBoxGiftPrevie(playerid,286.000000, 214.000000,MallItem[gift2][_Model],MallItem[gift2][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][1]=CreatePlayerBoxGiftTextPrevie(playerid,286.000000+33.0, 214.000000+58.0,MallItem[gift2][_Name]);
            PlayerBoxGiftDraw[playerid][2]=CreatePlayerBoxGiftPrevie(playerid,354.000000, 214.000000,MallItem[gift3][_Model],MallItem[gift3][_Extra1]);
            PlayerBoxGiftTextDraw[playerid][2]=CreatePlayerBoxGiftTextPrevie(playerid,354.000000+33.0, 214.000000+58.0,MallItem[gift3][_Name]);
	    }
	}
	return 1;
}
