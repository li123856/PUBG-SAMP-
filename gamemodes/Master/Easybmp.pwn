#define MAX_BMP_STRING 256
native GetImageRAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY);
native GetImageGAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY);
native GetImageBAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY);
native GetImageWidth(const BMP24BIT_FileName[]);
native GetImageHeight(const BMP24BIT_FileName[]);
native SetPixelRGBAAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY,red,green,blue,alpha=0);
native SetImageSize(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY);
//native GetImageRGBAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY,&DecimalRed,&DecimalGreen,&DecimalBlue);//sorry I don't know how to set adresses from a plugin...
//fast image processing
native FImageOpen(const BMP24BIT_FileName[]);
native FImageSave();// only save the image when you have used FSet*
native FGetImageRAtPos(BMP_PosX,BMP_PosY);
native FGetImageGAtPos(BMP_PosX,BMP_PosY);
native FGetImageBAtPos(BMP_PosX,BMP_PosY);
native FGetImageWidth();
native FGetImageHeight();
native FSetPixelRGBAAtPos(BMP_PosX,BMP_PosY,red,green,blue,alpha=0);
native FSetImageSize(BMP_PosX,BMP_PosY);
//native FGetImageRGBAtPos(const BMP_PosX,BMP_PosY,&DecimalRed,&DecimalGreen,&DecimalBlue);//sorry I don't know how to set adresses from a plugin...
enum ColorIndex
{
	 R
	,G
	,B
}
stock SetPixelRGBAtPosEx(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY,val,{ Color_Index, _ }: color)
{
	new
	     red
	    ,green
	    ,blue
	    ;
	    
	switch(color)
	{
	    case R:
	    {
			red = val;
			green = GetImageGAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
			blue = GetImageBAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
	    }
	    case G:
	    {
			red = GetImageRAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
			green = val;
			blue = GetImageBAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
	    }
	    case B:
	    {
			red = GetImageRAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
			green = GetImageGAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
			blue = val;
	    }
	    default:
	    {
	        return 0;
	    }
	}
	SetPixelRGBAAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY,red,green,blue);
	return 1;
}

stock GetImageRGBAtPos(const BMP24BIT_FileName[],BMP_PosX,BMP_PosY,&DecimalRed,&DecimalGreen,&DecimalBlue)
{
	DecimalRed = GetImageRAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
	DecimalGreen = GetImageGAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
	DecimalBlue = GetImageBAtPos(BMP24BIT_FileName,BMP_PosX,BMP_PosY);
	return 1;
}

stock FGetImageRGBAtPos(BMP_PosX,BMP_PosY,&DecimalRed,&DecimalGreen,&DecimalBlue)
{
	DecimalRed = FGetImageRAtPos(BMP_PosX,BMP_PosY);
	DecimalGreen = FGetImageGAtPos(BMP_PosX,BMP_PosY);
	DecimalBlue = FGetImageBAtPos(BMP_PosX,BMP_PosY);
	return 1;
}
stock PutTextIntoImage(const BMP24BIT_FileName[],string[],mode = 0)
{
	new lenght = strlen(string);
	if(lenght >= MAX_BMP_STRING-1)
	{
	    return 0;
	}
	switch(mode)
	{
	    case 0:
	    {
			for(new i = 0; i < lenght; i++)
			{
			    SetPixelRGBAtPosEx(BMP24BIT_FileName,i,0,ASCIItoINT(string[i]),0);
			}
			SetPixelRGBAtPosEx(BMP24BIT_FileName,lenght+1,0,255,0);
		}
	    case 1:
	    {
			for(new i = 0; i < lenght; i++)
			{
			    SetPixelRGBAtPosEx(BMP24BIT_FileName,i,0,ASCIItoINT(string[i]),1);
			}
			SetPixelRGBAtPosEx(BMP24BIT_FileName,lenght+1,0,255,1);
		}
	    case 2:
	    {
			for(new i = 0; i < lenght; i++)
			{
			    SetPixelRGBAtPosEx(BMP24BIT_FileName,i,0,ASCIItoINT(string[i]),2);
			}
			SetPixelRGBAtPosEx(BMP24BIT_FileName,lenght+1,0,255,2);
		}
		default: return 0;
	}
	return 1;
}
stock ReadTextFromImage(const BMP24BIT_FileName[],mode = 0)
{
	new string[MAX_BMP_STRING];
	switch(mode)
	{
	    case 0:
	    {
			for(new i = 0; i < MAX_BMP_STRING; i++)
			{
			    string[i] = GetImageRAtPos(BMP24BIT_FileName,i,0);
			    if(string[i] == 255)
			    {
			        string[i] = '\0';
			        break;
			    }
			}
		}
		case 1:
		{
			for(new i = 0; i < MAX_BMP_STRING; i++)
			{
			    string[i] = GetImageGAtPos(BMP24BIT_FileName,i,0);
			    if(string[i] == 255)
			    {
			        string[i] = '\0';
			        break;
			    }
			}
		}
		case 2:
		{
			for(new i = 0; i < MAX_BMP_STRING; i++)
			{
			    string[i] = GetImageBAtPos(BMP24BIT_FileName,i,0);
			    if(string[i] == 255)
			    {
			        string[i] = '\0';
			        break;
			    }
			}
		}
		default: string[0] = '\0';
	}
	return string;
}
stock ASCIItoINT(const char_[])// only 1 character at a time!
{
	new charx[4];
	format(charx,4,"%d",char_);
	return strval(charx);
}
stock INTtoASCII(int_)
{
	if(int_ > 255 || int_ < 0)return 0;
	new str[2];
	format(str,2,"%s",int_);
	return str;
}

stock HexToInt(string[]) {
  if (string[0]==0) return 0;
  new i;
  new cur=1;
  new res=0;
  for (i=strlen(string);i>0;i--) {
    if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    cur=cur*16;
  }
  return res;
}
stock IntToHex(number)
{
	new m=1;
	new depth=0;
	while (number>=m) {
		m = m*16;
		depth++;
	}
	depth--;
	new str[256];
	for (new i = depth; i >= 0; i--)
	{
		str[i] = ( number & 0x0F) + 0x30; // + (tmp > 9 ? 0x07 : 0x00)
		str[i] += (str[i] > '9') ? 0x07 : 0x00;
		number >>= 4;
	}
	if(strlen(str) == 0)strins(str,"00",0);
	else
	if(strlen(str) == 1)strins(str,"0",0);
	str[8] = '\0';
	return str;
}
stock RGBAToColor(red,green,blue,alpha = 255)
{
	new StrHex[16];
	format(StrHex,16,"%s%s%s%s",IntToHex(red),IntToHex(green),IntToHex(blue),IntToHex(alpha));
	return HexToInt(StrHex);
}
stock RGBAToHex(red,green,blue,alpha = 255)
{
	new StrHex[16];
	format(StrHex,16,"%s%s%s%s",IntToHex(red),IntToHex(green),IntToHex(blue),IntToHex(alpha));
	return StrHex;
}
stock RGBToHex(red,green,blue)
{
	new StrHex[16];
	format(StrHex,16,"%s%s%s",IntToHex(red),IntToHex(green),IntToHex(blue));
	return StrHex;
}
N::Make2DImageIn3DSpaceOnPlayer(const BMP24BIT_FileName[],Float:bmpworldX,Float:bmpworldY,Float:bmpworldZ,playerid)
{
	forex(i,MAX_PLAYER_SIGN)
	{
        if(PlayerBodySignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
        {
		    DestroyDynamic3DTextLabel(PlayerBodySignature[playerid][i]);
			PlayerBodySignature[playerid][i]=Text3D:INVALID_STREAMER_ID;
		}
	}
    FImageOpen(BMP24BIT_FileName);
	new
		 X = FGetImageWidth()
		,Y = FGetImageHeight()
		,temp[ColorIndex]
		,SuperLargeString[16384]
		,Float:index=0.0
		,count=0
		;
	for(new b = 0; b < Y; b++)
	{
	    format(SuperLargeString,16384,"");
		for(new a = 0; a < X; a++)
		{
		    FGetImageRGBAtPos(a,b,temp[R],temp[G],temp[B]);
			strins(SuperLargeString,"{",strlen(SuperLargeString));
			strins(SuperLargeString,RGBToHex(temp[R],temp[G],temp[B]),strlen(SuperLargeString));
			strins(SuperLargeString,"}.",strlen(SuperLargeString));
			if(a == (X-1))
			{
			    if(count<MAX_PLAYER_SIGN)
			    {
				    PlayerBodySignature[playerid][count]=CreateDynamic3DTextLabel(SuperLargeString,0xFFFFFFFF,bmpworldX,bmpworldY,bmpworldZ-index,10.0,playerid,.testlos = 1);
					Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerBodySignature[playerid][count],E_STREAMER_EXTRA_ID,1001);
					index=index+0.016;
					count++;
				}
			}
		}
	}
	return 1;
}
N::Make2DImageIn3DSpaceOnGround(const BMP24BIT_FileName[],Float:bmpworldX,Float:bmpworldY,Float:bmpworldZ,playerid)
{
	forex(i,MAX_PLAYER_SIGN)
	{
        if(PlayerGroundSignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
        {
		    DestroyDynamic3DTextLabel(PlayerGroundSignature[playerid][i]);
			PlayerGroundSignature[playerid][i]=Text3D:INVALID_STREAMER_ID;
		}
	}
    FImageOpen(BMP24BIT_FileName);
	new
		 X = FGetImageWidth()
		,Y = FGetImageHeight()
		,temp[ColorIndex]
		,SuperLargeString[16384]
		,Float:index=0.0
		,count=0
		;
	for(new b = 0; b < Y; b++)
	{
	    format(SuperLargeString,16384,"");
		for(new a = 0; a < X; a++)
		{
		    FGetImageRGBAtPos(a,b,temp[R],temp[G],temp[B]);
			strins(SuperLargeString,"{",strlen(SuperLargeString));
			strins(SuperLargeString,RGBToHex(temp[R],temp[G],temp[B]),strlen(SuperLargeString));
			strins(SuperLargeString,"}.",strlen(SuperLargeString));
			if(a == (X-1))
			{
			    if(count<MAX_PLAYER_SIGN)
			    {
				    PlayerGroundSignature[playerid][count]=CreateDynamic3DTextLabel(SuperLargeString,0xFFFFFFFF,bmpworldX,bmpworldY,bmpworldZ-index,10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,STREAMER_VEHICLE_TYPE_DYNAMIC,0,PersonalRoom(playerid));
                    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL,PlayerGroundSignature[playerid][count],E_STREAMER_EXTRA_ID,1001);
					index=index+0.016;
					count++;
				}
			}
		}
	}
	return 1;
}
N::ShowPlayerSignature(playerid)
{
	if(Account[playerid][_SignID]!=0)
	{
    	fLine_64("scriptfiles/±íÇé°ü/%s.bmp",Signature[Account[playerid][_SignID]][_FileName]);
		Make2DImageIn3DSpaceOnPlayer(line,0.0,0.0,1.0,playerid);
		Make2DImageIn3DSpaceOnGround(line,pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z]+1.8,playerid);
	}
	return 1;
}
N::HandlePlayerSignature(playerid,bool:Show)
{
	if(Show==false)
	{
	    forex(i,MAX_PLAYER_SIGN)
		{
	        if(PlayerBodySignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
	        {
	        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBodySignature[playerid][i], E_STREAMER_DRAW_DISTANCE, 0.0);
			}
	        if(PlayerGroundSignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
	        {
	            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerGroundSignature[playerid][i], E_STREAMER_DRAW_DISTANCE, 0.0);
			}
		}
	}
	else
	{
    	forex(i,MAX_PLAYER_SIGN)
		{
	        if(PlayerBodySignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
	        {
	        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerBodySignature[playerid][i], E_STREAMER_DRAW_DISTANCE, 10.0);
			}
	        if(PlayerGroundSignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
	        {
	            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PlayerGroundSignature[playerid][i], E_STREAMER_DRAW_DISTANCE, 10.0);
			}
		}
	}
	return 1;
}
N::DestoryPlayerSignature(playerid)
{
    forex(i,MAX_PLAYER_SIGN)
	{
        if(PlayerBodySignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
        {
		    DestroyDynamic3DTextLabel(PlayerBodySignature[playerid][i]);
			PlayerBodySignature[playerid][i]=Text3D:INVALID_STREAMER_ID;
		}
        if(PlayerGroundSignature[playerid][i]!=Text3D:INVALID_STREAMER_ID)
        {
		    DestroyDynamic3DTextLabel(PlayerGroundSignature[playerid][i]);
			PlayerGroundSignature[playerid][i]=Text3D:INVALID_STREAMER_ID;
		}
	}
	return 1;
}
N::Easybmp@OnPlayerDisconnect(playerid,reason)
{
    DestoryPlayerSignature(playerid);
	return 1;
}
N::Easybmp@OnPlayerConnect(playerid)
{
    DestoryPlayerSignature(playerid);
	return 1;
}
stock ShowPlayerSignatures(playerid,pager)
{
    DialogBoxID[playerid]=1;
	forex(i,sizeof(Signature))
	{
		DialogBox[playerid][DialogBoxID[playerid]]=i;
		DialogBoxKey[playerid][DialogBoxID[playerid]]=Signature[i][_Key];
   		DialogBoxID[playerid]++;
	}
    new body[1024],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_SIGN_MSG2));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
	    new string[128];
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
		    if(pLang(playerid)==0)format(string,sizeof(string),"%s\t%i\n",Signature[index][_CnName],Signature[index][_Price]);
		    else format(string,sizeof(string),"%s\t%i\n",Signature[index][_EnName],Signature[index][_Price]);
		}
		if(i>=DialogBoxID[playerid])
		{
			end=1;
			break;
		}
		else strcat(body,string);
	}
	if(!end)strcat(body, ReturnMLStr(pLang(playerid),_NEXT_PAGE));
    return body;
}
N::Easybmp@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case _BUY_SIGNS:
        {
			if(response)
			{
				new pager=(DialogPage[playerid]-1)*MAX_BOX_LIST;
				if(pager==0)pager = 1;
				else pager++;
				switch(listitem)
				{
				    case 0:
				  	{
				    	DialogPage[playerid]--;
				    	if(DialogPage[playerid]<1)DialogPage[playerid]=1;
				    	Dialog@Show(playerid,_BUY_SIGNS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SIGN_MSG1),ShowPlayerSignatures(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_SIGN_MSG3),ReturnMLStr(pLang(playerid),_SIGN_MSG4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
						Dialog@Show(playerid,_BUY_SIGNS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SIGN_MSG1),ShowPlayerSignatures(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_SIGN_MSG3),ReturnMLStr(pLang(playerid),_SIGN_MSG4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(Signature[index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						if(index==0)
						{
						    StopPlayerRotCamera(playerid,true,false);
						    pRotCam[playerid][_Radius]= 4.0;
						    StartPlayerRotCamera(playerid);
						    Account[playerid][_SignID]=index;
							DestoryPlayerSignature(playerid);
							Update@AccountSign(playerid,index);
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SIGN_MSG6));
							return 1;
						}
						if(Account[playerid][_Gold]>=Signature[index][_Price])
						{
						    StopPlayerRotCamera(playerid,true,false);
						    pRotCam[playerid][_Radius]= 6.0;
						    StartPlayerRotCamera(playerid);
						    Account[playerid][_Gold]-=Signature[index][_Price];
						    Account[playerid][_SignID]=index;
						    Update@AccountGold(playerid,Account[playerid][_Gold]);
		        			UpdateGoldDraw(playerid,Account[playerid][_Gold]);
				        	Update@AccountSign(playerid,index);
		        			SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SIGN_MSG6));
		        			ShowPlayerSignature(playerid);
						}
						else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_SIGN_MSG5));
					}
				}
			}
            else
            {
		        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
		        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
            }
		}
    }
    return 1;
}
