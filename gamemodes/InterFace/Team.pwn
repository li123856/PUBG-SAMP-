N::CreateTeam(playerid)
{
    if(Iter_Count(Teams)>=MAX_GAME_TEAMS)return TEAM_FULL;
    new i=Iter_Free(Teams);
    Teams[i][_Key]=GetTickCount();
    Teams[i][_TeamOwnerKey]=Account[playerid][_Key];
    forex(s,4)Teams[i][_TeamMember][s]=NONE;
    Iter_Add(Teams,i);
    JoinTeam(playerid,i);
   	return TEAM_SUCCESS;
}
N::GetFreeTeamSlot(playerid,index)
{
	forex(i,4)
	{
	    if(Teams[index][_TeamMember][i]==NONE)return i;
	}
    return NONE;
}
CMD:jt(playerid, params[], help)
{
    printf("jt %i",JoinTeam(playerid,0));
    return 1;
}
N::JoinTeam(playerid,index)
{
	if(!Iter_Contains(Teams,index))return 0;
	if(pTeam[playerid]!=NONE)return 0;
	new slotid=GetFreeTeamSlot(playerid,index);
	if(slotid==NONE)return 0;
	Teams[index][_TeamMember][slotid]=Account[playerid][_Key];
	pTeam[playerid]=index;
   	return 1;
}
N::LeaveTeam(playerid)
{
	new TeamID=pTeam[playerid];
	if(TeamID!=NONE)
	{
    	if(Teams[TeamID][_TeamOwnerKey]==Account[playerid][_Key])DestoryTeam(playerid);
    	else
    	{
			pTeam[playerid]=NONE;
  		}
	}
   	return 1;
}
N::DestoryTeam(playerid)
{
	new TeamID=pTeam[playerid];
	if(TeamID!=NONE)
	{
        if(Iter_Contains(Teams,TeamID))
        {
			foreach(new i:Player)
			{
			    if(Online(i))
			    {
			        if(pTeam[i]==TeamID)pTeam[i]=NONE;
			    }
			}
			Iter_Remove(Teams,TeamID);
        }
    }
   	return 1;
}
N::ShowPlayerTeamState(playerid)
{
    new body[512];
	if(pTeam[playerid]!=NONE)
	{
	    if(Teams[pTeam[playerid]][_TeamOwnerKey]==Account[playerid][_Key])format(body,sizeof(body),ReturnMLStr(pLang(playerid),_TEAM_DIALOG2),ReturnMLStr(pLang(playerid),_TEAM_MODE2));
		else format(body,sizeof(body),ReturnMLStr(pLang(playerid),_TEAM_DIALOG2),ReturnMLStr(pLang(playerid),_TEAM_MODE3));
	}
	else format(body,sizeof(body),ReturnMLStr(pLang(playerid),_TEAM_DIALOG2),ReturnMLStr(pLang(playerid),_TEAM_MODE1));
	
	Dialog@Show(playerid,_TEAM_MODE_SET,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_TEAM_DIALOG1),body,ReturnMLStr(pLang(playerid),_TEAM_DIALOG3),ReturnMLStr(pLang(playerid),_TEAM_DIALOG4));
   	return 1;
}
N::ShowPlayerTeamMember(playerid,index)
{
    new body[512],string[64],amount=0;
	forex(i,4)
	{
		if(Teams[index][_TeamMember][i]!=NONE)
		{
		    amount++;
			if(Teams[index][_TeamOwnerKey]==Teams[index][_TeamMember][i])format(string,sizeof(string),"%s\t%s\n",Select@GetPlayerNameByKey(Teams[index][_TeamMember][i]),ReturnMLStr(pLang(playerid),_TEAM_MSG11));
			else format(string,sizeof(string),"%s\t%s\n",Select@GetPlayerNameByKey(Teams[index][_TeamMember][i]),ReturnMLStr(pLang(playerid),_TEAM_MSG12));
		}
		else format(string,sizeof(string),"%s\t\n",ReturnMLStr(pLang(playerid),_TEAM_MSG7));
		strcat(body,string);
	}
	format(string,sizeof(string),ReturnMLStr(pLang(playerid),_TEAM_MSG8),amount);
	Dialog@Show(playerid,_TEAM_MODE_MEMBERS,DIALOG_STYLE_TABLIST,string,body,ReturnMLStr(pLang(playerid),_TEAM_MSG9),ReturnMLStr(pLang(playerid),_TEAM_MSG10));
   	return 1;
}
N::Team@DialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case _TEAM_MODE_SET:
        {
            if(response)
            {
	            switch(listitem)
	            {
	                case 1:
	                {
	                    if(pTeam[playerid]!=NONE)
	                    {
	                        ShowPlayerTeamState(playerid);
	                        return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG1));
	                    }
	                    if(CreateTeam(playerid)==TEAM_FULL)
	                    {
	                        ShowPlayerTeamState(playerid);
	                        return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG6));
	                    }
	                    else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG3));
	                }
	                case 2:
	                {
	                    if(pTeam[playerid]==NONE)
	                    {
	                        ShowPlayerTeamState(playerid);
	                        return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG2));
	                    }
	                    SetPVarInt(playerid,"_Team_Key",Teams[pTeam[playerid]][_Key]);
	                    return ShowPlayerTeamMember(playerid,pTeam[playerid]);
	                }
	                case 3:
	                {
	                    if(pTeam[playerid]==NONE)
	                    {
	                        ShowPlayerTeamState(playerid);
	                        return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG2));
	                    }
	                    if(Teams[pTeam[playerid]][_TeamOwnerKey]==Account[playerid][_Key])
						{
							DestoryTeam(playerid);
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG5));
						}
	                    else
						{
							LeaveTeam(playerid);
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG4));
						}
	                }
	            }
	            ShowPlayerTeamState(playerid);
            }
        }
        case _TEAM_MODE_MEMBERS:
        {
            if(response)
            {
				if(pTeam[playerid]==NONE)
                {
                	ShowPlayerTeamState(playerid);
                	return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG2));
                }
				new TeamKey=GetPVarInt(playerid,"_Team_Key");
    			if(TeamKey!=Teams[pTeam[playerid]][_Key])
    			{
                	ShowPlayerTeamState(playerid);
                	return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ARRAY_ERROR));
    			}
                if(Teams[pTeam[playerid]][_TeamOwnerKey]!=Account[playerid][_Key])
                {
                	ShowPlayerTeamMember(playerid,pTeam[playerid]);
                	return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG13));
                }
                if(Teams[pTeam[playerid]][_TeamOwnerKey]==Teams[pTeam[playerid]][_TeamMember][listitem]&&Teams[pTeam[playerid]][_TeamOwnerKey]==Account[playerid][_Key])
                {
                	ShowPlayerTeamMember(playerid,pTeam[playerid]);
                	return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG14));
                }
                if(Teams[pTeam[playerid]][_TeamMember][listitem]==NONE)
                {
				    Dialog@Show(playerid,_MY_FRIENDS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG1),ShowPlayerFriends(playerid,1),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG3),ReturnMLStr(pLang(playerid),_FRIENDS_DIALOG4));
				    return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG17));
                }
				else
				{
                    new pid=GetKeyPlayerID(Teams[pTeam[playerid]][_TeamMember][listitem]);
                    if(pid!=NONE)
					{
                    	LeaveTeam(pid);
                    	fLine_128(ReturnMLStr(pLang(playerid),_TEAM_MSG15),Account[pid][_Name]);
                    	SCM(playerid,-1,line);
                    	foreach(new i:Player)
						{
						    if(Online(i))
						    {
						        if(pTeam[playerid]==pTeam[i])
						        {
						            if(Dialog@GetIndex(playerid)!=NONE&&Dialog@GetIndex(playerid)==_TEAM_MODE_MEMBERS)ShowPlayerTeamMember(i,pTeam[i]);
						        }
						    }
						}
                    }
                    else
                    {
                		ShowPlayerTeamMember(playerid,pTeam[playerid]);
                		return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEAM_MSG16));
                    }
				}
            }
            else ShowPlayerTeamState(playerid);
        }
    }
   	return 1;
}
