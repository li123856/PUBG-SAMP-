N::PlayerMailRest(playerid)
{
   	Iter_Clear(pMails[playerid]);
	return 1;
}
N::DB_LoadPlayerMails(playerid)
{
	new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_MAIL"` WHERE `玩家归属`=%i ORDER BY `"MYSQL_DB_MAIL"`.`编号` ASC",Account[playerid][_Key]);
    mysql_tquery(User@Handle,Query, "OnPlayerMailsLoad", "i",playerid);
}
N::OnPlayerMailsLoad(playerid)
{
    forex(i,cache_num_rows())
	{
	    if(i<MAX_PLAYER_MAILS)
	    {
	    	pMails[playerid][i][_Key]=cache_get_field_content_int(i,"编号",User@Handle);
	    	pMails[playerid][i][_Type]=cache_get_field_content_int(i,"类型",User@Handle);
			pMails[playerid][i][_Owner_Key]=cache_get_field_content_int(i,"玩家归属",User@Handle);
			pMails[playerid][i][_Sender_Key]=cache_get_field_content_int(i,"发送者归属",User@Handle);
			cache_get_field_content(i,"标题",pMails[playerid][i][_Tag],User@Handle,64);
			cache_get_field_content(i,"内容",pMails[playerid][i][_Content],User@Handle,256);
			cache_get_field_content(i,"发送时间",pMails[playerid][i][_SendTime],User@Handle,32);
			pMails[playerid][i][_Gold]=cache_get_field_content_int(i,"金币",User@Handle);
			pMails[playerid][i][_Item_ID]=cache_get_field_content_int(i,"道具ID",User@Handle);
			pMails[playerid][i][_Item_Amount]=cache_get_field_content_int(i,"道具数量",User@Handle);
			pMails[playerid][i][_Extra]=cache_get_field_content_int(i,"其他",User@Handle);
			pMails[playerid][i][_Readed]=cache_get_field_content_int(i,"已读",User@Handle);
			Iter_Add(pMails[playerid],i);
		}
		else
		{
		    printf("%s 的邮箱数据溢出[%i],请修改MAX_PLAYER_MAILS",Account[playerid][_Name],MAX_PLAYER_MAILS);
			break;
		}
	}
	UpdatePlayerMailsBotton(playerid);
	return 1;
}

N::SendMailToOnlinePlayer(playerid,fromplayerid,type,tag[],content[],gold,itemid,itemamount,extra)
{
    if(Iter_Count(pMails[playerid])>=MAX_PLAYER_MAILS)return MAIL_FULL;
    new i=Iter_Free(pMails[playerid]);
    
    pMails[playerid][i][_Type]=type;
    pMails[playerid][i][_Owner_Key]=Account[playerid][_Key];
    if(pMails[playerid][i][_Type]==MAIL_TYPE_SYSTEM)pMails[playerid][i][_Sender_Key]=NONE;
    else pMails[playerid][i][_Sender_Key]=Account[fromplayerid][_Key];
    format(pMails[playerid][i][_Tag],64,tag);
    format(pMails[playerid][i][_Content],256,content);
    format(pMails[playerid][i][_SendTime],32,PrintDate());
    pMails[playerid][i][_Gold]=gold;
	pMails[playerid][i][_Item_ID]=itemid;
	pMails[playerid][i][_Item_Amount]=itemamount;
	pMails[playerid][i][_Extra]=extra;
	pMails[playerid][i][_Readed]=0;
	Iter_Add(pMails[playerid],i);
	
	new Query[1024];
	format(Query, sizeof(Query),\
	"INSERT INTO `"MYSQL_DB_MAIL"` (\
	`类型`,`玩家归属`,`发送者归属`,`标题`,`内容`,`金币`,\
	`道具ID`,`道具数量`,`其他`,`发送时间`) VALUES \
	('%i','%i','%i','%s','%s','%i','%i','%i','%i','%s')",\
	type,\
	pMails[playerid][i][_Owner_Key],\
	pMails[playerid][i][_Sender_Key],\
	pMails[playerid][i][_Tag],\
	pMails[playerid][i][_Content],\
	gold,\
	itemid,\
	itemamount,\
	extra,\
	pMails[playerid][i][_SendTime]);
	mysql_query(User@Handle,Query);
	pMails[playerid][i][_Key]=cache_insert_id();
	if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_MAIL);
	UpdatePlayerMailsBotton(playerid);
    return MAIL_SUCCESS;
}
N::SendMailToOfflinePlayer(playerkey,fromplayerid,type,tag[],content[],gold,itemid,itemamount,extra)
{
	if(!IsPlayerKeyFexist(playerkey))return MAIL_NOT_EXIST;
	if(GetOfflinePlayerKeyMailAmout(playerkey)>=MAX_PLAYER_MAILS)return MAIL_FULL;
    new Query[1024];
    format(Query, sizeof(Query),"INSERT INTO `"MYSQL_DB_MAIL"`(`类型`,`玩家归属`,`发送者归属`,`标题`,`内容`,`金币`,`道具ID`,`道具数量`,`其他`,`发送时间`)\
	VALUES ('%i','%i','%i','%s','%s','%i','%i','%i','%i','%s')",type,playerkey,Account[fromplayerid][_Key],tag,content,gold,itemid,itemamount,extra,PrintDate());
	mysql_query(User@Handle,Query,false);
    return MAIL_SUCCESS;
}
N::DestoryPlayerMail(playerid,index)
{
    if(!Iter_Contains(pMails[playerid],index))return MAIL_NOT_EXIST;
	new Query[256];
	format(Query, sizeof(Query), "DELETE FROM `"MYSQL_DB_MAIL"` WHERE `编号` = '%i'",pMails[playerid][index][_Key]);
	mysql_query(User@Handle,Query);

    Iter_Remove(pMails[playerid],index);
	UpdatePlayerMailsBotton(playerid);
	return MAIL_SUCCESS;
}
N::ClearPlayerMail(playerid)
{
	new Query[256];
	format(Query, sizeof(Query), "DELETE FROM `"MYSQL_DB_MAIL"` WHERE `玩家归属` = '%i'",Account[playerid][_Key]);
	mysql_query(User@Handle,Query);

    Iter_Clear(pMails[playerid]);
	UpdatePlayerMailsBotton(playerid);
	return MAIL_SUCCESS;
}
N::GetOfflinePlayerKeyMailAmout(Key)
{
    new Query[128];
	format(Query,sizeof(Query),"SELECT * FROM `"MYSQL_DB_MAIL"` WHERE `玩家归属`=%i",Key);
	mysql_query(User@Handle,Query);
	return cache_num_rows(User@Handle);
}
N::GetPlayerUnReadMails(playerid)
{
	new amount=0;
	foreach(new i:pMails[playerid])
	{
	    if(pMails[playerid][i][_Readed]==0)amount++;
	}
	return amount;
}
N::UpdateMailReaded(playerid,index,isread)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_MAIL"` SET  `已读`='%i' WHERE  `"MYSQL_DB_MAIL"`.`编号` ='%i'",isread,pMails[playerid][index][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::UpdateMailGold(playerid,index,gold)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_MAIL"` SET  `金币`='%i' WHERE  `"MYSQL_DB_MAIL"`.`编号` ='%i'",gold,pMails[playerid][index][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::ClearMailGold(playerid)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_MAIL"` SET  `金币`=0 WHERE  `"MYSQL_DB_MAIL"`.`玩家归属` ='%i'",Account[playerid][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
N::UpdateMailItem(playerid,index,itemid,amount)
{
	new Query[128];
	format(Query, sizeof(Query),"UPDATE `"MYSQL_DB_MAIL"` SET  `道具ID`='%i',`道具数量`='%i' WHERE  `"MYSQL_DB_MAIL"`.`编号` ='%i'",itemid,amount,pMails[playerid][index][_Key]);
	mysql_query(User@Handle,Query,false);
    return 1;
}
stock ShowPlayerMails(playerid,pager)
{
    DialogBoxID[playerid]=1;
    for(new i=Iter_End(pMails[playerid]);(i=Iter_Prev(pMails[playerid],i))!=Iter_Begin(pMails[playerid]);)
	{
		DialogBox[playerid][DialogBoxID[playerid]]=i;
		DialogBoxKey[playerid][DialogBoxID[playerid]]=pMails[playerid][i][_Key];
      	DialogBoxID[playerid]++;
	}
    new body[2048],end=0,index;
    if(pager<1)pager=1;
    DialogPage[playerid]=pager;
    pager=(pager-1)*MAX_BOX_LIST;
    if(pager==0)pager=1;else pager++;
	format(body,sizeof(body), ReturnMLStr(pLang(playerid),_PLAYER_MAIL2));
	strcat(body,ReturnMLStr(pLang(playerid),_PREV_PAGE));
	new string[256];
	Loop(i,pager,pager+MAX_BOX_LIST)
	{
		index=DialogBox[playerid][i];
		if(i<DialogBoxID[playerid])
		{
			if(pMails[playerid][index][_Readed])
			{
			    if(pMails[playerid][index][_Type]==MAIL_TYPE_SYSTEM)format(string,sizeof(string),"%s\t{FFFFFF}%s\t{FFFFFF}%s\n",ReturnMLStr(pLang(playerid),_MAIL_EXTRACT5),pMails[playerid][index][_Tag],pMails[playerid][index][_SendTime]);
				else format(string,sizeof(string),"%s\t{FFFFFF}%s\t{FFFFFF}%s\n",Select@GetPlayerNameByKey(pMails[playerid][index][_Sender_Key]),pMails[playerid][index][_Tag],pMails[playerid][index][_SendTime]);
			}
			else
			{
				if(pMails[playerid][index][_Type]==MAIL_TYPE_SYSTEM)format(string,sizeof(string),"%s\t{408080}%s\t{408080}%s\n",ReturnMLStr(pLang(playerid),_MAIL_EXTRACT5),pMails[playerid][index][_Tag],pMails[playerid][index][_SendTime]);
				else format(string,sizeof(string),"%s\t{408080}%s\t{408080}%s\n",Select@GetPlayerNameByKey(pMails[playerid][index][_Sender_Key]),pMails[playerid][index][_Tag],pMails[playerid][index][_SendTime]);
			}
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
stock ShowPlayerMailBody(playerid,index)
{
    new body[2048],string[256];
    if(pMails[playerid][index][_Type]==MAIL_TYPE_SYSTEM)format(string,sizeof(string),ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY1),ReturnMLStr(pLang(playerid),_MAIL_EXTRACT5));
    else format(string,sizeof(string),ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY1),Select@GetPlayerNameByKey(pMails[playerid][index][_Sender_Key]));
	strcat(body,string);
    format(string,sizeof(string),ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY2),pMails[playerid][index][_SendTime]);
	strcat(body,string);
	strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY3));
    format(string,sizeof(string),pMails[playerid][index][_Content]);
    strcat(body,string);
    strcat(body,"\n\n");
    strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY4));
	new bool:IsHaveAttachMents=false;
    if(pMails[playerid][index][_Gold]>0)
    {
        format(string,sizeof(string),ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY6),pMails[playerid][index][_Gold]);
        strcat(body,string);
		IsHaveAttachMents=true;
    }
    if(pMails[playerid][index][_Item_ID]!=NONE&&pMails[playerid][index][_Item_Amount]>0)
    {
        format(string,sizeof(string),ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY7),MallItem[pMails[playerid][index][_Item_ID]][_Name],pMails[playerid][index][_Item_Amount]);
        strcat(body,string);
        IsHaveAttachMents=true;
    }
    switch(pMails[playerid][index][_Type])
    {
        case MAIL_TYPE_PLAYER:
		{
		    if(IsHaveAttachMents==true)
			{
				strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY5));
				format(string,sizeof(string),pMails[playerid][index][_Tag]);
		  		Dialog@Show(playerid,_MY_MAILS_SHOW2,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ1),ReturnMLStr(pLang(playerid),_MAIL_READ2));

			}
			else
			{
			    format(string,sizeof(string),pMails[playerid][index][_Tag]);
		 		Dialog@Show(playerid,_MY_MAILS_SHOW1,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ2),"");
			}
		}
        case MAIL_TYPE_SYSTEM:
		{
		    if(IsHaveAttachMents==true)
			{
				strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY5));
				format(string,sizeof(string),pMails[playerid][index][_Tag]);
		  		Dialog@Show(playerid,_MY_MAILS_SHOW2,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ1),ReturnMLStr(pLang(playerid),_MAIL_READ2));

			}
			else
			{
			    format(string,sizeof(string),pMails[playerid][index][_Tag]);
		 		Dialog@Show(playerid,_MY_MAILS_SHOW1,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ2),"");
			}
		}
        case MAIL_TYPE_ADDFRIEND:
		{
			strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY5));
			format(string,sizeof(string),pMails[playerid][index][_Tag]);
	  		Dialog@Show(playerid,_MY_MAILS_SHOW2,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ3),ReturnMLStr(pLang(playerid),_MAIL_READ4));
		}
        case MAIL_TYPE_TEAM:
		{
			strcat(body,ReturnMLStr(pLang(playerid),_CHACK_MAIL_BODY5));
			format(string,sizeof(string),pMails[playerid][index][_Tag]);
	  		Dialog@Show(playerid,_MY_MAILS_SHOW2,DIALOG_STYLE_MSGBOX,string,body,ReturnMLStr(pLang(playerid),_MAIL_READ3),ReturnMLStr(pLang(playerid),_MAIL_READ4));
		}
    }
    pMails[playerid][index][_Readed]=1;
    UpdateMailReaded(playerid,index,pMails[playerid][index][_Readed]);
    return 1;
}
N::bool:ExtractAttachments(playerid,index)
{
    new bool:IsHaveAttachMents=false;
    if(index!=NONE)
    {
	    if(pMails[playerid][index][_Gold]>0)
	    {
	        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT1),pMails[playerid][index][_Gold]);
	        SCM(playerid,-1,line);
	        Account[playerid][_Gold]+=pMails[playerid][index][_Gold];
	  		UpdateGoldDraw(playerid,Account[playerid][_Gold]);
	        pMails[playerid][index][_Gold]=0;
	        UpdateMailGold(playerid,index,pMails[playerid][index][_Gold]);
	        Update@AccountGold(playerid,Account[playerid][_Gold]);
	        IsHaveAttachMents=true;
	    }
	    if(pMails[playerid][index][_Item_ID]!=NONE&&pMails[playerid][index][_Item_Amount]>0)
	    {
	        if(AddItemToPlayerBag(playerid,pMails[playerid][index][_Item_ID],pMails[playerid][index][_Item_Amount])!=BAG_SUCCESS)
	        {
		        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT3),MallItem[pMails[playerid][index][_Item_ID]][_Name],pMails[playerid][index][_Item_Amount]);
		        SCM(playerid,-1,line);
	        }
	        else
	        {
		        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT2),MallItem[pMails[playerid][index][_Item_ID]][_Name],pMails[playerid][index][_Item_Amount]);
		        SCM(playerid,-1,line);
		        pMails[playerid][index][_Item_ID]=NONE;
				pMails[playerid][index][_Item_Amount]=0;
				UpdateMailItem(playerid,index,pMails[playerid][index][_Item_ID],pMails[playerid][index][_Item_Amount]);
	        }
	        IsHaveAttachMents=true;
	    }
    }
	else
	{
	    new golds=0;
		foreach(new i:pMails[playerid])
		{
			if(pMails[playerid][i][_Gold]>0)
			{
				golds+=pMails[playerid][i][_Gold];
				pMails[playerid][i][_Gold]=0;
			}
		}
		if(golds>0)
		{
			Account[playerid][_Gold]+=golds;
			UpdateGoldDraw(playerid,Account[playerid][_Gold]);
	        Update@AccountGold(playerid,Account[playerid][_Gold]);
	        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT1),golds);
	        SCM(playerid,-1,line);
	        ClearMailGold(playerid);
	        IsHaveAttachMents=true;
        }

		foreach(new i:pMails[playerid])
		{
		    if(pMails[playerid][i][_Item_ID]!=NONE&&pMails[playerid][i][_Item_Amount]>0)
		    {
		        if(AddItemToPlayerBag(playerid,pMails[playerid][i][_Item_ID],pMails[playerid][i][_Item_Amount])!=BAG_SUCCESS)
		        {
			        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT3),MallItem[pMails[playerid][i][_Item_ID]][_Name],pMails[playerid][i][_Item_Amount]);
			        SCM(playerid,-1,line);
			        break;
		        }
		        else
		        {
			        fLine_128(ReturnMLStr(pLang(playerid),_MAIL_EXTRACT2),MallItem[pMails[playerid][i][_Item_ID]][_Name],pMails[playerid][i][_Item_Amount]);
			        SCM(playerid,-1,line);
			        pMails[playerid][i][_Item_ID]=NONE;
					pMails[playerid][i][_Item_Amount]=0;
					UpdateMailItem(playerid,index,pMails[playerid][i][_Item_ID],pMails[playerid][i][_Item_Amount]);
		        }
		        IsHaveAttachMents=true;
		    }
		}
	}
    return IsHaveAttachMents;
}
N::Mail@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
		case _MY_MAILS:
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
                    	fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                    	Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
					}
					case MAX_BOX_LIST+1:
					{
			    		DialogPage[playerid]++;
                    	fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                    	Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
				    }
					default:
					{
						new index=DialogBox[playerid][pager+listitem-1];
						if(pMails[playerid][index][_Key]!=DialogBoxKey[playerid][pager+listitem-1])
						{
                    		fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                    		Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,DialogPage[playerid]),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
							return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
						}
						SetPVarInt(playerid,"_Mails_Chack_Index",index);
						SetPVarInt(playerid,"_Mails_Chack_Key",DialogBoxKey[playerid][pager+listitem-1]);
						fLine_64(ReturnMLStr(pLang(playerid),_CHACK_MAIL1),pMails[playerid][index][_Tag]);
						Dialog@Show(playerid,_MY_MAILS_CHACK,DIALOG_STYLE_LIST,line,ReturnMLStr(pLang(playerid),_CHACK_MAIL2),ReturnMLStr(pLang(playerid),_CHACK_MAIL3),ReturnMLStr(pLang(playerid),_CHACK_MAIL4));
					}
				}
			}
        }
        case _MY_MAILS_CHACK:
        {
			if(response)
			{
			    new index=GetPVarInt(playerid,"_Mails_Chack_Index");
			    new key=GetPVarInt(playerid,"_Mails_Chack_Key");
			    if(pMails[playerid][index][_Key]!=key)
				{
					fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                	Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
				}
				switch(listitem)
				{
				    case 0:ShowPlayerMailBody(playerid,index);
				    case 1:
				    {
				        DestoryPlayerMail(playerid,index);
						fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
	                	Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
						return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_BOX1));
				    }
				    case 2:
				    {
     					if(ExtractAttachments(playerid,NONE)==false)
				 		{
					 		SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_EXTRACT4));
				 		}
				    }
				    case 3:
				    {
                        if(Iter_Count(pMails[playerid])<=0)return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_BOX3));
				        ClearPlayerMail(playerid);
						fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                		Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
						return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_BOX2));
				    }
				}
			}
			else
			{
				fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
			}
        }
		case _MY_MAILS_SHOW2:
		{
			if(response)
			{
			    new index=GetPVarInt(playerid,"_Mails_Chack_Index");
			    new key=GetPVarInt(playerid,"_Mails_Chack_Key");
			    if(pMails[playerid][index][_Key]!=key)
				{
					fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
                	Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
					return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
				}
			    switch(pMails[playerid][index][_Type])
			    {
			        case MAIL_TYPE_PLAYER:
					{
     					if(ExtractAttachments(playerid,index)==false)
				 		{
					 		SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_EXTRACT4));
				 		}
					}
			        case MAIL_TYPE_SYSTEM:
					{
					    if(ExtractAttachments(playerid,index)==false)
						{
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MAIL_EXTRACT4));
						}
					}
					case MAIL_TYPE_TEAM:
					{
					    if(pTeam[playerid]==NONE)
					    {
							new pid=GetKeyPlayerID(pMails[playerid][index][_Sender_Key]);
						    if(pid!=NONE)
						    {
	                            if(pTeam[pid]!=NONE)
	                            {
	                                if(Teams[pTeam[pid]][_TeamOwnerKey]==Account[pid][_Key])
	                                {
	                                    if(Teams[pTeam[pid]][_Key]==pMails[playerid][index][_Extra])
	                                    {
	                                        JoinTeam(playerid,pTeam[pid]);
	                                        fLine_64(ReturnMLStr(pLang(playerid),_JOIN_TEAM4),Account[pid][_Name]);
	                                        SCM(playerid,-1,line);
	                                        DestoryPlayerMail(playerid,index);
	                                    }
	                                }
	                                else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_JOIN_TEAM3));
	                            }
	                            else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_JOIN_TEAM2));
						    }
							else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_JOIN_TEAM1));
						}
						else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG1));
					}
			        case MAIL_TYPE_ADDFRIEND:
					{
					    new pid=GetKeyPlayerID(pMails[playerid][index][_Sender_Key]);
					    if(pid!=NONE)
					    {
					        switch(AddPlayerOnLineFriend(playerid,pid))
					        {
					            case FRIEND_NOT_ONLINE:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP1));
					            case FRIEND_EXIST:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP2));
					            case FRIEND_FULL:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP3));
					            case FRIEND_SUCCESS:
					            {
					                fLine_64(ReturnMLStr(pLang(playerid),_FRIEND_TIP5),Account[pid][_Name]);
					                SCM(playerid,-1,line);
					                format(line,64,ReturnMLStr(pLang(pid),_FRIEND_TIP6),Account[playerid][_Name]);
					                SCM(pid,-1,line);
					                DestoryPlayerMail(playerid,index);
				            	}
					        }
					    }
						else
						{
						    switch(AddPlayerOffLineFriend(playerid,pMails[playerid][index][_Sender_Key]))
						    {
					            case FRIEND_NOT_ONLINE:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP1));
					            case FRIEND_EXIST:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP2));
					            case FRIEND_ERROR:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP4));
					            case FRIEND_SUCCESS:
					            {
					                fLine_64(ReturnMLStr(pLang(playerid),_FRIEND_TIP5),Select@GetPlayerNameByKey(pMails[playerid][index][_Sender_Key]));
					                SCM(playerid,-1,line);
					                format(line,64,ReturnMLStr(pLang(Select@GetPlayerLanguageByKey(pMails[playerid][index][_Sender_Key])),_FRIEND_TIP6),Account[playerid][_Name]);
                                    SendMailToOfflinePlayer(pMails[playerid][index][_Sender_Key],playerid,MAIL_TYPE_PLAYER,"好友添加成功",line,0,NONE,0,NONE);
                                    DestoryPlayerMail(playerid,index);
					            }
					            case FRIEND_FULL:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FRIEND_TIP3));
						    }
						}
					}
				}
				fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
        		Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
			}
			else
			{
				fLine_64(ReturnMLStr(pLang(playerid),_PLAYER_MAIL1),GetPlayerUnReadMails(playerid));
        		Dialog@Show(playerid,_MY_MAILS,DIALOG_STYLE_TABLIST_HEADERS,line,ShowPlayerMails(playerid,1),ReturnMLStr(pLang(playerid),_PLAYER_MAIL3),ReturnMLStr(pLang(playerid),_PLAYER_MAIL4));
			}
		}
    }
    return 1;
}





