N::OnPlayerClickMallItem(playerid,index)
{
    fLine_128(ReturnMLStr(pLang(playerid),_MALL_DIALOG2),MallItem[MallPrevieBox[playerid][index]][_Name],MallItem[MallPrevieBox[playerid][index]][_Price]);
    Dialog@Show(playerid,_MALL_BUY,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_MALL_DIALOG1),line,ReturnMLStr(pLang(playerid),_MALL_DIALOG3),ReturnMLStr(pLang(playerid),_MALL_DIALOG4));
	SetPVarInt(playerid,"_ClickMallItem",index);
	return 1;
}
N::UpdateGoldDraw(playerid,amout)
{
    fLine_32("%i",amout);
	if(PlayerMallMyMoney[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawSetString(playerid,PlayerMallMyMoney[playerid],line);
	UpdatePlayerFaceMenuCdsDraw(playerid,line);
}
N::DestoryPlayerMallDraw(playerid)//删除商城
{
	forex(i,MAX_MALL_SHOW_LIST)
	{
		if(PlayerMallModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallModelDraw[playerid][i]);
		if(PlayerMallBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallBackGround[playerid][i]);
		if(PlayerMallName[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallName[playerid][i]);
		if(PlayerMallPriceIcon[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallPriceIcon[playerid][i]);
		if(PlayerMallPrice[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallPrice[playerid][i]);
		PlayerMallModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallName[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallPriceIcon[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallPrice[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(PlayerMallSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallSliderBar[playerid]);
	if(PlayerMallBottonUp[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallBottonUp[playerid]);
	if(PlayerMallBottonDown[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallBottonDown[playerid]);
	if(PlayerMallMyMoney[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallMyMoney[playerid]);
	PlayerMallSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerMallBottonUp[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerMallBottonDown[playerid]=PlayerText:INVALID_TEXT_DRAW;
	PlayerMallMyMoney[playerid]=PlayerText:INVALID_TEXT_DRAW;
	return 1;
}
N::RefreshPlayerMallPrevie(playerid,pages,type)//刷新商城
{
	forex(i,MAX_MALL_SHOW_LIST)
	{
		if(PlayerMallModelDraw[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallModelDraw[playerid][i]);
		if(PlayerMallBackGround[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallBackGround[playerid][i]);
		if(PlayerMallName[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallName[playerid][i]);
		if(PlayerMallPriceIcon[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallPriceIcon[playerid][i]);
		if(PlayerMallPrice[playerid][i]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallPrice[playerid][i]);
		PlayerMallModelDraw[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallBackGround[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallName[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallPriceIcon[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallPrice[playerid][i]=PlayerText:INVALID_TEXT_DRAW;
	}
	if(PlayerMallSliderBar[playerid]!=PlayerText:INVALID_TEXT_DRAW)PlayerTextDrawDestroy(playerid,PlayerMallSliderBar[playerid]);
	PlayerMallSliderBar[playerid]=PlayerText:INVALID_TEXT_DRAW;
	CreatePlayerMallPage(playerid,type,pages,true);
	return 1;
}
/********************************************************************************/
N::ShowPlayerMallBackGround(playerid)
{
	forex(i,MAX_MALL_BACKGROUND)TextDrawShowForPlayer(playerid,MallBackGround[i]);
	return 1;
}
N::HidePlayerMallBackGround(playerid)
{
	forex(i,MAX_MALL_BACKGROUND)TextDrawHideForPlayer(playerid,MallBackGround[i]);
	return 1;
}
stock PlayerText:CreatePlayerMallSliderBar(playerid,pages,type)
{
    new ItemAmout=GetMallItemAmout(type);
    if(ItemAmout<=0)ItemAmout=1;
    new Float:BarTextSize=floatdiv(28,floatround(floatdiv(ItemAmout,MAX_MALL_SHOW_LIST),floatround_ceil));
	if(pages<=0)pages=0;
	else pages--;
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, 537.000000, 153.000000+floatmul(pages,BarTextSize)*0.75, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, BarTextSize);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 541.500000, 107.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, -56);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}

stock PlayerText:CreateMallBackBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:up");//前页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 10.500000, 11.000000);
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
stock PlayerText:CreateMallNextBottonPrevie(playerid,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "ld_beat:down");//后页按钮
	PlayerTextDrawFont(playerid, PlayerTextDraw, 4);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 10.500000, 11.000000);
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
stock PlayerText:CreateMallPrevieBackGround(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 1);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 7.550000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 240.000000, 142.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 9145343);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateMallPrevieModel(playerid,model,Float:Xpos, Float:Ypos,color)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos, "~n~");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 10.100000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 63.500000, 70.500000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 2);
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
stock PlayerText:CreateMallPreviePriceIcon(playerid,model,Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,"Nowy_TextDraw");
	PlayerTextDrawFont(playerid, PlayerTextDraw, 5);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 12.500000, 14.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 1);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 0);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerTextDraw, model);
	PlayerTextDrawSetPreviewRot(playerid, PlayerTextDraw, -90.000000, 0.000000, 3.000000, 0.769999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerTextDraw, 1, 1);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateMallPreviePrice(playerid,price[],Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,price);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.541665, 1.700000);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
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
stock PlayerText:CreateMallPrevieName(playerid,name[],Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid, Xpos, Ypos,name);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.429165, 1.399999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetShadow(playerid, PlayerTextDraw, 0);
	PlayerTextDrawAlignment(playerid, PlayerTextDraw, 3);
	PlayerTextDrawColor(playerid, PlayerTextDraw, -16776961);
	PlayerTextDrawBackgroundColor(playerid, PlayerTextDraw, 255);
	PlayerTextDrawBoxColor(playerid, PlayerTextDraw, 50);
	PlayerTextDrawUseBox(playerid, PlayerTextDraw, 0);
	PlayerTextDrawSetProportional(playerid, PlayerTextDraw, 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTextDraw, 0);
	PlayerTextDrawShow(playerid,PlayerTextDraw);
    return PlayerTextDraw;
}
stock PlayerText:CreateMallMyMoneyPrevie(playerid,money[],Float:Xpos, Float:Ypos)
{
	new PlayerText:PlayerTextDraw = CreatePlayerTextDraw(playerid,Xpos, Ypos, money);
	PlayerTextDrawFont(playerid, PlayerTextDraw, 2);
	PlayerTextDrawLetterSize(playerid, PlayerTextDraw, 0.287499, 1.899999);
	PlayerTextDrawTextSize(playerid, PlayerTextDraw, 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTextDraw, 0);
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

N::CreatePlayerMallPage(playerid,type,pages,bool:refresh)
{
	new index=0,ItemAmout=0;
    MallPrevieRate[playerid]=0;
    MallPrevieCount[playerid]=1;
    MallClickID[playerid]=NONE;
	forex(i,sizeof(MallItem))
	{
	    if(MallItem[i][_Type]==type)
		{
		    if(MallItem[i][_Sell]==true)
		    {
			    if(ItemAmout<MAX_MALL_BOX_ITEMS-2)
			    {
					MallPrevieBox[playerid][MallPrevieCount[playerid]]=i;
		   			MallPrevieCount[playerid]++;
		   			ItemAmout++;
			    }
		    }
	    }
	}
	if(pages<1)pages=1;
	if(pages>floatround((MallPrevieCount[playerid]-1)/float(MAX_MALL_SHOW_LIST),floatround_ceil))pages=floatround((MallPrevieCount[playerid]-1)/float(MAX_MALL_SHOW_LIST),floatround_ceil);
    MallPreviePage[playerid]=pages;
    pages=(pages-1)*MAX_MALL_SHOW_LIST;
    if(pages<=0)pages=1;else pages++;
    new BreakLine=0,NowLine=0;
	Loop(i,pages,pages+MAX_MALL_SHOW_LIST)
	{
	    index=MallPrevieBox[playerid][i];
	    if(i<MallPrevieCount[playerid])
		{
		    if(BreakLine>=3)
			{
				NowLine++;
				BreakLine=0;
			}
			new Float:BackGroundX=168.000000+(MallPrevieRate[playerid]-NowLine*3)*146.0;
			new Float:BackGroundY=137.000000+NowLine*72.3;
			
			new Float:ModelX=96.000000+(MallPrevieRate[playerid]-NowLine*3)*146.0;
			new Float:ModelY=136.000000+NowLine*72.3;

			new Float:IconX=152.000000+(MallPrevieRate[playerid]-NowLine*3)*146.0;
			new Float:IconY=188.000000+NowLine*72.3;
			
			new Float:PriceX=166.000000+(MallPrevieRate[playerid]-NowLine*3)*146.0;
			new Float:PriceY=187.000000+NowLine*72.3;
			
			new Float:NameX=238.000000+(MallPrevieRate[playerid]-NowLine*3)*146.0;
			new Float:NameY=136.000000+NowLine*72.3;
			
			PlayerMallBackGround[playerid][MallPrevieRate[playerid]] = CreateMallPrevieBackGround(playerid,BackGroundX,BackGroundY);
			PlayerMallModelDraw[playerid][MallPrevieRate[playerid]] = CreateMallPrevieModel(playerid,MallItem[index][_Model],ModelX,ModelY,MallItem[index][_Extra1]);
			new str[32];
			format(str,sizeof(str),"%s",MallItem[index][_Name]);
			PlayerMallName[playerid][MallPrevieRate[playerid]]=CreateMallPrevieName(playerid,str,NameX, NameY);
			PlayerMallPriceIcon[playerid][MallPrevieRate[playerid]]=CreateMallPreviePriceIcon(playerid,1855,IconX, IconY);
            format(str,sizeof(str),"%i",MallItem[index][_Price]);
			PlayerMallPrice[playerid][MallPrevieRate[playerid]]=CreateMallPreviePrice(playerid,str,PriceX,PriceY);
			MallPrevieRate[playerid]++;
			BreakLine++;
		}
		if(i>=MallPrevieCount[playerid])break;
	}
	PlayerMallSliderBar[playerid] = CreatePlayerMallSliderBar(playerid,pages,type);//进度条
	if(refresh==false)
	{
		PlayerMallBottonUp[playerid] = CreateMallBackBottonPrevie(playerid,534.000000, 139.000000);//前页按钮
		PlayerMallBottonDown[playerid] = CreateMallNextBottonPrevie(playerid,534.000000, 409.000000);//后页按钮
		fLine_32("%i",Account[playerid][_Gold]);
		PlayerMallMyMoney[playerid]= CreateMallMyMoneyPrevie(playerid,line,476.000000, 107.000000);//玩家金币
	}
	return 1;
}
N::GetMallItemAmout(type)
{
	new amout=0;
	forex(i,sizeof(MallItem))
	{
	    if(MallItem[i][_Type]==type)
		{
		    if(MallItem[i][_Sell]==true)amout++;
		}
	}
	return amout;
}
N::ShowUserMall(playerid,type)
{
    HideUserBag(playerid,false);
    HideUserMall(playerid,false);
    MallPrevieType[playerid]=type;
    ShowPlayerMallBackGround(playerid);
	CreatePlayerMallPage(playerid,type,1,false);
	HidePlayerFaceMenuCdsDraw(playerid);
    return 1;
}
N::HideUserMall(playerid,bool:disconnect)
{
    MallPrevieType[playerid]=TYPE_SKIN;
    DestoryPlayerMallDraw(playerid);
    HidePlayerMallBackGround(playerid);
    if(disconnect==false)ShowPlayerFaceMenuCdsDraw(playerid);
    return 1;
}
N::ClearPlayerMallClickState(playerid)
{
	if(MallClickID[playerid]!=NONE)
	{
		PlayerTextDrawBackgroundColor(playerid, PlayerMallBackGround[playerid][MallClickID[playerid]], 255);
		PlayerTextDrawBoxColor(playerid, PlayerMallBackGround[playerid][MallClickID[playerid]], 9145343);
        PlayerTextDrawShow(playerid,PlayerMallBackGround[playerid][MallClickID[playerid]]);
	}
	MallClickID[playerid]=NONE;
	return 1;
}

