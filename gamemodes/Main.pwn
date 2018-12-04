#define SERVER_HOSTNAME1 "*PUBG*[中国SA-MP大逃杀专业服务器]"
#define SERVER_HOSTNAME2 "*PUBG*[Battlegrounds Professional For Sa-mp]"
#define SERVER_GAMETEXT "QQ群:123279967"
#define SERVER_MAPNAME "PUBG-V5.0"
#define SERVER_WEBURL "www.gtace.com/bbs"
#define SERVER_LANGUAGE "中/English"
#define SERVER_OWNER "WDTK"

#define MUSIC_CONNECT "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201801/9610.mp3"
#define MUSIC_COMEIN "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201608/7591.mp3"
#define MUSIC_WAIT "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201608/7592.mp3"
#define MUSIC_GAMESTART "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201503/5664.mp3"
#define MUSIC_GAMEWIN "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201609/7758.mp3"
#define MUSIC_GAMEFAIL "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201606/7414.mp3"
#define MUSIC_GAMEZONE "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201712/9578.mp3"
#define MUSIC_GAMEBOX "http://xmdx.sc.chinaz.com/files/download/sound1/201208/1870.mp3"
#define MUSIC_MAIL "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201702/8307.mp3"
#define MUSIC_WHOLETIME "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201602/6886.mp3"
#define MUSIC_TOXIC "http://xmdx.sc.chinaz.com/Files/DownLoad/sound1/201502/5479.mp3"
#define MUSIC_SAFE "http://xmdx.sc.chinaz.com/files/download/sound1/201401/4025.mp3"

#define MAX_PLAYERS								(200)

#include <a_samp>
#include <foreach>
#include <Pawn.CMD>
#include <streamer1>
#include <mapandreas>
#include <colandreas>
#include <a_mysql>
#include <timerfix>
#include <sscanf2>
#include <a_mysql>
#include <sort>
#include <FCNPC>

enum PlayerPos_Info
{
	Float:_X,
	Float:_Y,
	Float:_Z,
	Float:_A,
	Float:_Cam_A,
	_LastSpeed
}
new PlayerPos[MAX_PLAYERS][PlayerPos_Info];
new bool:PosChange[MAX_PLAYERS];

#include <lagcomp>
#include <socket>
#include <3DTryg>
#include <times>
#include <UIC>

#pragma dynamic 4194304

#define IsValidVehicleModel(%0) \
    ((%0 > 399) && (%0 < 612))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define fLine_512( new line[512];format(line,sizeof(line),
#define fLine_256( new line[256];format(line,sizeof(line),
#define fLine_128( new line[128];format(line,sizeof(line),
#define fLine_64( new line[64];format(line,sizeof(line),
#define fLine_32( new line[32];format(line,sizeof(line),
#define FormatEx(%0,%1) new String[%1];format(String,%1,%0)
#define forex(%0,%1) for(new %0 = 0; %0 < %1; %0++)
#define Loop(%0,%1,%2) for(new %0 = %1; %0 < %2; %0++)
#define N::%1(%3) forward %1(%3);  public %1(%3)
#define GetDistanceBetweenPoints2D(%1,%2,%3,%4)			VectorSize((%1)-(%3),(%2)-(%4),0.0)
#define Hooks CallRemoteFunction
#define Timer: _@timer_
#define NONE -1
#define MAX_LASTALIVE_GAMES MAX_PLAYERS+1
#define GAME_ROOM_LIMIT 200000
#define GameRoom(%0) GAME_ROOM_LIMIT+%0
#define GAME_WAIT_ROOM_LIMIT 100000
#define GameWaitRoom(%0) GAME_WAIT_ROOM_LIMIT+%0
#define PERSONAL_DISPLAY_ROOM 300000
#define PersonalRoom(%0) PERSONAL_DISPLAY_ROOM+Account[%0][_Key]
#define ATTACH_EDIT_ROOM 400000
#define AttachEditRoom(%0) ATTACH_EDIT_ROOM+%0

#define MAX_WAIT_TIME 300
#define MAX_PLAYER_LEAVE_TIME 10
#define MAX_GAME_ROUND_TIME 250

#define GetPlayerSkin GetPlayerSkinEx

new Timer:ScondUpdate=NONE;
new Timer:100msUpdate=NONE;
new Timer:500msUpdate=NONE;
enum
{
	LASTALIVE_TYPE_NONE,
	LASTALIVE_TYPE_SINGLE,
	LASTALIVE_TYPE_TEAM
}
enum
{
	LASTALIVE_STATE_NONE,
	LASTALIVE_STATE_WAIT,
	LASTALIVE_STATE_START,
	LASTALIVE_STATE_FINISH
}
enum
{
    LASTALIVE_ROUND_NONE,
	LASTALIVE_ROUND_WAIT,
	LASTALIVE_ROUND_NONTOXIC,
	LASTALIVE_ROUND_SAFE
}
#define MAX_PICKITEM 3000
#define MAX_WALL 500
enum LastAliveGame_InFo
{
	_Key,
	bool:_Ready,
	_Type,
	_State,
	_Round,
	_RoundTimes,
	_Rate,
	_TimeLine,
    Timer:_Wait,
	Timer:_Nontox,
	Timer:_Safe,
	_WaitTimeLine,
	_SafeLine,
	Float:_SafeAmout,
	_NontoxAmout,
	_MaxPlayers,
	bool:_ZoneShow,

	_Weather_ID,//0-20
	_Weather_Count,
	_AirBox_Count,
	
	_NontoxicZone,
	_SafeZone,
	Float:_NontoxicMinX,
	Float:_NontoxicMinY,
	Float:_NontoxicMaxX,
	Float:_NontoxicMaxY,
	Float:_SafeMinX,
	Float:_SafeMinY,
	Float:_SafeMaxX,
	Float:_SafeMaxY,

	Wall0[MAX_WALL],
    Wall1[MAX_WALL],
    Wall2[MAX_WALL],
    Wall3[MAX_WALL],
    
	_PickItem_MapIcon[MAX_PICKITEM],
	_PickItem_MapAmout[MAX_PICKITEM],
	
	_Npc_Driver_ID,
	_Plane_ID,
	bool:_Plane_Flying,
	Text:_Plane_Draw,
	
	Text:_Alive_Draw,
	
	Text:_SmallMap_Toxic_Circle,
	Text:_SmallMap_Safe_Circle,
	
	_Time_Line_Warn,
	Text:_Time_Line_Time_Draw,
	Text:_LeftPlayer_Draw,
	Timer:_LeftPlayer_Timer
};
new LastAliveGame[MAX_LASTALIVE_GAMES][LastAliveGame_InFo];
new Iterator:LastAliveGame<MAX_LASTALIVE_GAMES>;
/********************************************************************************/
#define MAX_GAME_DEATHBOXS MAX_PLAYERS
#define MAX_GAME_DEATHBOX_THINGS 40
enum
{
    BOX_TYPE_NONE,
	BOX_TYPE_PLAYER,
	BOX_TYPE_AIRDROP
}
enum DeathBox_InFo
{
	_Type,
	_Owner,
	_ItemID[MAX_GAME_DEATHBOX_THINGS],
	_Amout[MAX_GAME_DEATHBOX_THINGS],
	_Ammo[MAX_GAME_DEATHBOX_THINGS],
	Float:_Durable[MAX_GAME_DEATHBOX_THINGS],
	_Key[MAX_GAME_DEATHBOX_THINGS],

	Float:_x,
	Float:_y,
	Float:_z,
	Float:_rx,
	Float:_ry,
	Float:_rz,
	_Interior,
	_Obj,
	_Area,
	_Map,
	Text3D:_Text,
	Text:_Draw
};
new DeathBox[MAX_LASTALIVE_GAMES][MAX_GAME_DEATHBOXS][DeathBox_InFo];
new Iterator:DeathBox[MAX_LASTALIVE_GAMES]<MAX_GAME_DEATHBOXS>;
new PlayerDeathBoxID[MAX_PLAYERS];

#define MAX_DEATHBOX_BACKGROUND 3
new Text:DeathBoxGround[MAX_DEATHBOX_BACKGROUND];

#define MAX_DEATHBOX_BOX_ITEMS MAX_GAME_DEATHBOX_THINGS+2//动态对话框数组最大值
#define MAX_DEATHBOX_SHOW_LIST 5
new DeathBoxPrevieBox[MAX_PLAYERS][MAX_DEATHBOX_BOX_ITEMS];
new DeathBoxPrevieBoxKey[MAX_PLAYERS][MAX_DEATHBOX_BOX_ITEMS];
new DeathBoxPrevieCount[MAX_PLAYERS];
new DeathBoxPreviePage[MAX_PLAYERS];
new DeathBoxPrevieRate[MAX_PLAYERS];

new DeathBoxClickID[MAX_PLAYERS];

new PlayerText:DeathBoxModelDraw[MAX_PLAYERS][MAX_DEATHBOX_SHOW_LIST];
new PlayerText:DeathBoxBackGround[MAX_PLAYERS][MAX_DEATHBOX_SHOW_LIST];
new PlayerText:DeathBoxInfo[MAX_PLAYERS][MAX_DEATHBOX_SHOW_LIST];
new PlayerText:DeathBoxUseIcon[MAX_PLAYERS][MAX_DEATHBOX_SHOW_LIST];

new PlayerText:DeathBoxSliderBar[MAX_PLAYERS];
new PlayerText:DeathBoxBottonUp[MAX_PLAYERS];
new PlayerText:DeathBoxBottonDown[MAX_PLAYERS];
new PlayerText:DeathBoxTag[MAX_PLAYERS];
/********************************************************************************/
#define MAX_GAME_VEHICLE 500
enum gVehicle_InFo
{
	_VehicleID,
	bool:_VehicleEngine,
	_VehicleKey,
	Float:_VehicleFuel
};
new gVehicle[MAX_LASTALIVE_GAMES][MAX_GAME_VEHICLE][gVehicle_InFo];
new Iterator:gVehicle[MAX_LASTALIVE_GAMES]<MAX_GAME_VEHICLE>;
/********************************************************************************/
new Iterator:TempVehicePos<706>;
/********************************************************************************/

enum PickItem_InFo
{
	_Key,
	_From,
	_ItemID,
	_Amout,
	_Ammo,
	Float:_Durable,
	Float:_x,
	Float:_y,
	Float:_z,
	Float:_rx,
	Float:_ry,
	Float:_rz,
	_Interior,
	_Obj,
	_Area,
	Text3D:_Text
};
new PickItem[MAX_LASTALIVE_GAMES][MAX_PICKITEM][PickItem_InFo];
new Iterator:PickItem[MAX_LASTALIVE_GAMES]<MAX_PICKITEM>;
/********************************************************************************/
enum pLastAlive_InFo
{
	_Game_Id,
	_Game_CountDown,
	bool:_Game_Death,
	bool:_Game_In,
	_Game_Kills,
	_Game_Deaths,
	_Game_BagVol,
	
	bool:_Game_SpectatePlane,
	bool:_Game_PlaneDown,
	Float:_Game_PlaneDown_Pos[4],
	
	
	PlayerText:_Game_Kill_Draw,
	
	bool:_Show_SmallMap,
	PlayerText:_Small_Arrow_Draw,
	
	PlayerText:_Time_Line_Person_Draw,

	Timer:LeaveTimer
};
new pLastAlive[MAX_PLAYERS][pLastAlive_InFo];
#define pGameID(%0) pLastAlive[%0][_Game_Id]
#define pGameIn(%0) pLastAlive[%0][_Game_In]
/********************************************************************************/
#define MAX_GAMESCOREDRAW_PANEL_DRAW 6
new Text:GameScorePanel[MAX_GAMESCOREDRAW_PANEL_DRAW];//战局积分面板
/********************************************************************************/
#define MAX_GAMEPLAYERVALUE_PANEL_BACKGROUND 1
new Text:GamePlayerValuePanelBackGround[MAX_GAMEPLAYERVALUE_PANEL_BACKGROUND];
/********************************************************************************/
#define MAX_TIME_LINE_BACKGROUND 3
new Text:Time_Line_BackGround[MAX_TIME_LINE_BACKGROUND];
/********************************************************************************/
enum
{
	ITEM_WEAPON,
	ITEM_AMMO,
	ITEM_ARMOUR,
	ITEM_HELMET,
	ITEM_MASK,
	ITEM_MEDICAL,
	ITEM_BACKPACK,
	ITEM_FOOD,
	ITEM_GLASS,
	ITEM_DRINK
}
enum
{
	AMMO_0,
	AMMO_1,
	AMMO_2,
	AMMO_3,
	AMMO_4,
	AMMO_5,
}
enum Item_Info
{
	_Type,
	_Order,
	_Name[64],
	_ChineseName[64],
	_SizeName[64],
	_Model,
	_Weapon,
	_WeaponAmmoType,
	_HandWeaponSlot,
	_BodyDressSlot,
	_AmmoAmout,
	_Bone,
	_BuffTime,
	_BuffKeep,
	Float:_BuffEffect,
	Float:_Durable
}
#define HAND_WEAPON_SLOT_NONE 	NONE
#define HAND_WEAPON_SLOT_1      1
#define HAND_WEAPON_SLOT_2      2
#define HAND_WEAPON_SLOT_3      3
#define HAND_WEAPON_SLOT_4      4

#define BODY_DRESS_SLOT_NONE 	NONE
#define BODY_DRESS_SLOT_1      1
#define BODY_DRESS_SLOT_2      2
#define BODY_DRESS_SLOT_3      3
#define BODY_DRESS_SLOT_4      4
#define BODY_DRESS_SLOT_5      5
enum ItemDiffPos_Info
{
	Float:_Attach_fOffsetX,
	Float:_Attach_fOffsetY,
	Float:_Attach_fOffsetZ,
	Float:_Attach_fRotX,
	Float:_Attach_fRotY,
	Float:_Attach_fRotZ,
	Float:_Attach_fScaleX,
	Float:_Attach_fScaleY,
	Float:_Attach_fScaleZ
}
new ItemDiffPos[][ItemDiffPos_Info]=
{
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    
    {0.071000,0.038999,-0.007999,-8.300007,86.099960,178.600082,1.136001,1.287000,1.000000},
    {0.056999,0.027999,-0.005999,0.000000,-3.100000,0.000000,1.000000,1.151000,1.222999},
    {0.056999,0.032999,0.000000,0.000000,0.000000,0.000000,1.000000,1.215000,1.154000},
    
    {0.153000,0.000000,0.000000,0.000000,0.000000,0.000000,1.086000,1.109000,1.067000},
    {0.073999,0.000000,0.000000,-82.600067,95.000022,166.099853,1.031999,1.278999,1.176999},
    {0.148999,0.000000,0.000000,0.000000,0.000000,0.000000,1.062999,1.000000,1.092000},
    {0.113999,0.000000,0.000000,0.000000,0.000000,0.000000,1.082000,1.109000,1.080000},
    
    {0.100999,0.025999,0.000000,11.199993,88.300003,98.600021,1.043000,1.152000,1.121000},
    {0.085000,0.018000,0.000000,-11.800003,84.999931,86.599990,1.141999,1.159999,1.126999},
    {0.093999,0.033000,0.000000,0.000000,77.899963,95.099990,1.046000,1.125000,1.131999},
    {0.064999,0.082000,-0.010999,-172.799728,96.099990,-15.399984,0.356999,0.550999,0.428999},
    {-0.043000,0.065999,-0.014000,-16.100028,170.100112,13.999999,1.111999,1.098000,1.120999},
    {0.087000,0.011999,0.000999,-96.799903,4.199979,-93.000053,0.905001,1.166000,1.089999},
    {0.087000,0.011999,0.000999,-96.799903,4.199979,-93.000053,0.905001,1.166000,1.089999},
    {0.087000,0.011999,0.000999,-96.799903,4.199979,-93.000053,0.905001,1.166000,1.089999},
    {0.087000,0.011999,0.000999,-96.799903,4.199979,-93.000053,0.905001,1.166000,1.089999},
    
    {0.092000,0.031999,0.000000,87.499961,82.400016,0.000000,1.000000,1.000000,1.000000},
    {0.092000,0.031999,0.000000,87.499961,82.400016,0.000000,1.000000,1.000000,1.000000},
    {0.092000,0.031999,0.000000,87.499961,82.400016,0.000000,1.000000,1.000000,1.000000},
    {0.092000,0.031999,0.000000,87.499961,82.400016,0.000000,1.000000,1.000000,1.000000},
    
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    
    {-0.090999,-0.079999,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
    {0.099999,-0.129000,-0.000999,-98.400001,1.900008,-90.000007,1.000000,1.000000,1.000000},
    {0.067999,-0.063999,0.000000,0.000000,89.000000,0.000000,1.000000,1.000000,1.000000},
    
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000}
};
new Item[][Item_Info]=
{
	{ITEM_WEAPON,1,"M4A1","M4A1","56.56X45MM",356,WEAPON_M4,AMMO_0,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,2,"Sniper Rifle","Sniper Rifle","7.62x39MM",358,WEAPON_SNIPER,AMMO_1,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,3,"Sniper shotgun","Sniper shotgun","7.62x39MM",357,WEAPON_RIFLE,AMMO_1,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,4,"AK-47","AK-47","7.62x39MM",355,WEAPON_AK47,AMMO_1,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,5,"chromegun 12","chromegun 12","12Gauge",351,WEAPON_SHOTGSPA,AMMO_5,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,6,"sawnoff","sawnoff","12Gauge",350,WEAPON_SAWEDOFF,AMMO_5,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,7,"Shotgun","Shotgun","12Gauge",349,WEAPON_SHOTGUN,AMMO_5,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,8,"TEC-9","TEC-9","9MM",372,WEAPON_TEC9,AMMO_2,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,9,"MP5","MP5",".45CP",353,WEAPON_MP5,AMMO_3,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,10,"micro UZI","micro UZI","9MM",352,WEAPON_UZI,AMMO_2,1,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,11,"Colt 45","Colt 45","9MM",346,WEAPON_COLT45,AMMO_2,2,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,12,"Brett 9mm","Brett 9mm","9MM",347,WEAPON_SILENCED,AMMO_2,2,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,13,"desert_eagle","desert_eagle",".50AE",348,WEAPON_DEAGLE,AMMO_4,2,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,14,"Billiard stick","Billiard stick","CLASS",338,WEAPON_POOLSTICK,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,15,"katana","katana","CLASS",339,WEAPON_KATANA,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,16,"Baton","Baton","CLASS",334,WEAPON_NITESTICK,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,17,"knifecur","knifecur","CLASS",335,WEAPON_KNIFE,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,18,"bat","bat","CLASS",336,WEAPON_BAT,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,19,"shovel","shovel","CLASS",338,WEAPON_POOLSTICK,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,20,"Golf club","Golf club","CLASS",333,WEAPON_GOLFCLUB,NONE,3,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,21,"grenade","grenade","CLASS",342,WEAPON_GRENADE,NONE,4,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,22,"teargas","teargas","CLASS",343,WEAPON_TEARGAS,NONE,4,-1,0,-1,-1,0,0.0,0.0},
	{ITEM_WEAPON,23,"Molotov Cocktail","Molotov Cocktail","CLASS",344,WEAPON_MOLTOV,NONE,4,-1,0,-1,-1,0,0.0,0.0},

	{ITEM_AMMO,1,"56x45MM","56x45MM型子弹","56x45MM",2358,NONE,AMMO_0,-1,-1,30,-1,-1,0,0.0,0.0},
	{ITEM_AMMO,2,"7.62x39MM","7.62x39MM型子弹","7.62x39MM",2061,NONE,AMMO_1,-1,-1,30,-1,-1,0,0.0,0.0},
	{ITEM_AMMO,3,"9MM","9MM型子弹","9MM",3014,NONE,AMMO_2,-1,-1,30,-1,-1,0,0.0,0.0},
	{ITEM_AMMO,4,".45CP",".45CP型子弹",".45CP",2043,NONE,AMMO_3,-1,-1,30,-1,-1,0,0.0,0.0},
	{ITEM_AMMO,5,".50AE",".50AE型子弹",".50AE",19995,NONE,AMMO_4,-1,-1,7,-1,-1,0,0.0,0.0},
	{ITEM_AMMO,6,"12Gauge","12Gauge型子弹","12Gauge",2040,NONE,AMMO_5,-1,-1,20,-1,-1,0,0.0,0.0},

	{ITEM_ARMOUR,1,"Armor(I)","民用防护衣","CLASS",19904,NONE,NONE,-1,4,0,1,-1,0,0.0,40.0},
	{ITEM_ARMOUR,2,"Armor(II)","警用防弹衣","CLASS",19142,NONE,NONE,-1,4,0,1,-1,0,0.0,70.0},
	{ITEM_ARMOUR,3,"Armor(III)","军用防弹衣","CLASS",19515,NONE,NONE,-1,4,0,1,-1,0,0.0,100.0},

	{ITEM_HELMET,1,"Helmet(I)","摩托车头盔","CLASS",19101,NONE,NONE,-1,3,0,2,-1,0,0.0,40.0},
	{ITEM_HELMET,2,"Helmet(II)","摩托车头盔","CLASS",18976,NONE,NONE,-1,3,0,2,-1,0,0.0,70.0},
	{ITEM_HELMET,3,"Helmet(III)","迷彩头盔","CLASS",19104,NONE,NONE,-1,3,0,2,-1,0,0.0,100.0},
	{ITEM_HELMET,4,"Helmet(IV)","警用头盔","CLASS",19141,NONE,NONE,-1,3,0,2,-1,0,0.0,130.0},

	{ITEM_MASK,1,"graymask","白色面具","CLASS",19036,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,2,"HockeyMask2","红色面具","CLASS",19037,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,3,"Greenhockeymask","绿色面具","CLASS",19038,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,4,"BDupsMask","恶魔面具","CLASS",11704,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,5,"gasmask","防毒面具","CLASS",19472,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,6,"Mask7","面罩7","CLASS",18917,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,7,"Mask3","面罩3","CLASS",18913,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,8,"Mask4","面罩4","CLASS",18914,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},
	{ITEM_MASK,9,"Mask10","面罩10","CLASS",18920,NONE,NONE,-1,2,0,2,-1,0,0.0,0.0},

	{ITEM_GLASS,1,"glass1","眼镜1","CLASS",19033,NONE,NONE,-1,1,0,2,-1,0,0.0,0.0},
	{ITEM_GLASS,2,"glass2","眼镜2","CLASS",19034,NONE,NONE,-1,1,0,2,-1,0,0.0,0.0},
	{ITEM_GLASS,3,"glass3","眼镜3","CLASS",19035,NONE,NONE,-1,1,0,2,-1,0,0.0,0.0},
	{ITEM_GLASS,4,"glass4","眼镜4","CLASS",19028,NONE,NONE,-1,1,0,2,-1,0,0.0,0.0},

	{ITEM_MEDICAL,1,"Bandage","绷带","CLASS",11747,NONE,NONE,-1,-1,0,-1,3,0,0.15,0.0},
	{ITEM_MEDICAL,2,"Medical kits","医疗包","CLASS",11736,NONE,NONE,-1,-1,0,-1,5,0,0.75,0.0},
	{ITEM_MEDICAL,3,"First aid kit","急救包","CLASS",11738,NONE,NONE,-1,-1,0,-1,8,0,0.9,0.0},

	{ITEM_BACKPACK,1,"backpack(I)","一级背包","CLASS",3026,NONE,NONE,-1,5,0,1,0,0,5.0,0.0},
	{ITEM_BACKPACK,2,"backpack(II)","二级背包","CLASS",11745,NONE,NONE,-1,5,0,1,0,0,10.0,0.0},
	{ITEM_BACKPACK,3,"backpack(III)","三级背包","CLASS",19559,NONE,NONE,-1,5,0,1,0,0,15.0,0.0},

	{ITEM_FOOD,1,"hamburger","汉堡包","CLASS",2703,NONE,NONE,-1,-1,0,-1,5,1,0.25,0.0},
	{ITEM_FOOD,2,"Toast","吐司","CLASS",19883,NONE,NONE,-1,-1,0,-1,3,1,0.12,0.0},
	{ITEM_FOOD,3,"bread","面包","CLASS",19579,NONE,NONE,-1,-1,0,-1,7,1,0.3,0.0},
	{ITEM_FOOD,4,"Little booger","鸡肉卷","CLASS",2769,NONE,NONE,-1,-1,0,-1,10,1,0.35,0.0},
	{ITEM_FOOD,5,"pizza","披萨","CLASS",2702,NONE,NONE,-1,-1,0,-1,13,1,0.4,0.0},

	{ITEM_DRINK,1,"Milk","牛奶","CLASS",19569,NONE,NONE,-1,-1,0,-1,3,1,0.15,0.0},
	{ITEM_DRINK,2,"Orange juice","橙汁","CLASS",19563,NONE,NONE,-1,-1,0,-1,5,1,0.3,0.0},
	{ITEM_DRINK,3,"Apple juice","苹果汁","CLASS",19564,NONE,NONE,-1,-1,0,-1,5,1,0.35,0.0},
	{ITEM_DRINK,4,"CerealBox","麦片盒","CLASS",19562,NONE,NONE,-1,-1,0,-1,7,1,0.45,0.0}
};
/********************************************************************************/
enum
{
	INVENTORY_SUCCESS,
	INVENTORY_ERROR,
	INVENTORY_NOEXIST,
	INVENTORY_FULL
}
#define MAX_PLAYERS_GAME_BAG MAX_GAME_DEATHBOX_THINGS
enum Inventory_InFo
{
	_Key,
	_ItemID,
	_Amout,
	_Ammo,
	Float:_Durable
};
new Inventory[MAX_PLAYERS][MAX_PLAYERS_GAME_BAG][Inventory_InFo];
new Iterator:Inventory[MAX_PLAYERS]<MAX_PLAYERS_GAME_BAG>;
#define PlayerInventoryItemID(%0,%1) Inventory[%0][%1][_ItemID]
#define PlayerInventoryItemAmout(%0,%1) Inventory[%0][%1][_Amout]
#define PlayerInventoryItemAmmo(%0,%1) Inventory[%0][%1][_Ammo]
#define PlayerInventoryItemDurable(%0,%1) Inventory[%0][%1][_Durable]
new bool:PlayerInvShow[MAX_PLAYERS];

#define NULL_MODEL 16678
/********************************************************************************/
#define MAX_PLAYER_BODY_SLOT_DRAW 5
enum pLastAliveBodyDress_InFo
{
	_Body_Dress_Item[MAX_PLAYER_BODY_SLOT_DRAW],
	Float:_Body_Dress_Durable[MAX_PLAYER_BODY_SLOT_DRAW],
    PlayerText:_Body_Dress_Draw[MAX_PLAYER_BODY_SLOT_DRAW]
};
new pLastAliveBodyDress[MAX_PLAYERS][pLastAliveBodyDress_InFo];
new BodyDressClickID[MAX_PLAYERS];
/********************************************************************************/
#define MAX_PLAYER_WEAPON_SLOT_DRAW 5
enum pLastAliveHandWeapon_InFo
{
	_Hand_Weapon_Item[MAX_PLAYER_WEAPON_SLOT_DRAW],
    PlayerText:_Hand_Name_Draw[MAX_PLAYER_WEAPON_SLOT_DRAW],
    PlayerText:_Hand_NameTag_Draw[MAX_PLAYER_WEAPON_SLOT_DRAW],
    PlayerText:_Hand_Model_Draw[MAX_PLAYER_WEAPON_SLOT_DRAW],
    PlayerText:_Hand_Ammo_Draw[MAX_PLAYER_WEAPON_SLOT_DRAW],
};
new pLastAliveHandWeapon[MAX_PLAYERS][pLastAliveHandWeapon_InFo];
new HandWeaponClickID[MAX_PLAYERS];
/********************************************************************************/
#define MAX_INVENROYBACKGROUND_DRAW 16
new Text:InventoryBackGroundDraw[MAX_INVENROYBACKGROUND_DRAW];//背包背景面板
/********************************************************************************/
#define MAX_FLAYBACKGROUND_DRAW 2
new Text:FlyMap_BackGround[MAX_FLAYBACKGROUND_DRAW];
/********************************************************************************/
#define MAX_INVENTORY_BOX_ITEMS 52//动态对话框数组最大值
#define MAX_INVENTORY_SHOW_LIST 9
new PlayerText:InventoryModelDraw[MAX_PLAYERS][MAX_INVENTORY_SHOW_LIST];
new PlayerText:InventoryBackGround[MAX_PLAYERS][MAX_INVENTORY_SHOW_LIST];
new PlayerText:InventoryNameTag[MAX_PLAYERS][MAX_INVENTORY_SHOW_LIST];
new PlayerText:InventoryItemAmout[MAX_PLAYERS][MAX_INVENTORY_SHOW_LIST];
new PlayerText:InventorySliderBarBackGround[MAX_PLAYERS];
new PlayerText:InventorySliderBar[MAX_PLAYERS];
new PlayerText:InventorySliderBarButtonBack[MAX_PLAYERS];
new PlayerText:InventorySliderBarButtonNext[MAX_PLAYERS];

new PlayerText:InventoryUseItemBotton[MAX_PLAYERS];
new PlayerText:InventoryDropItemBotton[MAX_PLAYERS];

new InventoryPrevieBox[MAX_PLAYERS][MAX_INVENTORY_BOX_ITEMS];
new InventoryPrevieBoxKey[MAX_PLAYERS][MAX_INVENTORY_BOX_ITEMS];
new InventoryPrevieCount[MAX_PLAYERS];
new InventoryPreviePage[MAX_PLAYERS];
new InventoryPrevieRate[MAX_PLAYERS];
new InventoryClickID[MAX_PLAYERS];
/********************************************************************************/
#define MAX_NEARBY_BOX_ITEMS 102//动态对话框数组最大值
#define MAX_NEARBY_SHOW_LIST 6
new PlayerText:NearByModelDraw[MAX_PLAYERS][MAX_NEARBY_SHOW_LIST];
new PlayerText:NearByBackGround[MAX_PLAYERS][MAX_NEARBY_SHOW_LIST];
new PlayerText:NearByNameTag[MAX_PLAYERS][MAX_NEARBY_SHOW_LIST];
new PlayerText:NearByItemAmout[MAX_PLAYERS][MAX_NEARBY_SHOW_LIST];
new PlayerText:NearByBackBotton[MAX_PLAYERS];
new PlayerText:NearByNextBotton[MAX_PLAYERS];
new PlayerText:NearByPage[MAX_PLAYERS];

new NearByPrevieBox[MAX_PLAYERS][MAX_NEARBY_BOX_ITEMS];
new NearByPrevieBoxKey[MAX_PLAYERS][MAX_NEARBY_BOX_ITEMS];
new NearByPrevieCount[MAX_PLAYERS];
new NearByPreviePage[MAX_PLAYERS];
new NearByPrevieRate[MAX_PLAYERS];
new NearByClickID[MAX_PLAYERS];
#define PLAYER_FIND_NEARBY_DISTANCE 5.0
/********************************************************************************/
new PlayerText:pBodyArmorModelDraw[MAX_PLAYERS];
new PlayerText:pBodyArmorTextDraw[MAX_PLAYERS];
new PlayerText:pBodyCapModelDraw[MAX_PLAYERS];
new PlayerText:pBodyCapTextDraw[MAX_PLAYERS];
new PlayerText:pHealthBar[MAX_PLAYERS];
new PlayerText:pBuffBar[MAX_PLAYERS];
new PlayerText:pCacheBar[MAX_PLAYERS];
new pBuffID[MAX_PLAYERS];
new pBuffCount[MAX_PLAYERS];
new pCacheID[MAX_PLAYERS];
new pCacheCount[MAX_PLAYERS];

new PlayerText:pWeaponModel[MAX_PLAYERS];
new PlayerText:pWeaponAmoutText[MAX_PLAYERS];
/********************************************************************************/
new LastTimeWeapon[MAX_PLAYERS];
new LastTimeAmmo[MAX_PLAYERS][12];

new LastTimeAnimIndex[MAX_PLAYERS];
new bool:HideAttach[MAX_PLAYERS];

new bool:pCBugging[MAX_PLAYERS];
new Timer:pCBugFreezeOver[MAX_PLAYERS];
new pLastFiredWeaponTick[MAX_PLAYERS];

new PauseTime[MAX_PLAYERS];
/********************************************************************************/
#define MAX_SPEEDO_BACKGROUND_DRAWS 10
new Text:SpeedoMetersBackGroundDraw[MAX_SPEEDO_BACKGROUND_DRAWS];
new PlayerText:PlayerSpeedoMetersDraw[MAX_PLAYERS];
new PlayerText:PlayerSpeedoArrowDraw[MAX_PLAYERS];
new PlayerText:PlayerSpeedoBarDraw[MAX_PLAYERS];
new PlayerText:PlayerSpeedoFuelBarDraw[MAX_PLAYERS];
new Timer:TurnOnEngineTimer[MAX_PLAYERS];
/********************************************************************************/
#define MAX_SMALLMAP_DRAW 31
new Text:SmallMapBackGround[MAX_SMALLMAP_DRAW];
/********************************************************************************/
new Float:ToxicCircleStartPos[][]=
{
	{-3000.0, 2990.0,3000.0,3000.0},//上
	{2990.0, -3000.0, 3000.0, 3000.0},//右
	{-3000.0,-3000.0,3000.0,-2990.0},//下
	{-3000.0, -3000.0, -2990.0, 3000.0}//左
};
#define MAX_GAME_CIRCLE_POS 4
new Float:ToxicCircleStartPosA[MAX_LASTALIVE_GAMES][MAX_GAME_CIRCLE_POS][MAX_GAME_CIRCLE_POS];
/********************************************************************************/
enum GameToxicCircle_Info
{
	_GangZoneID
}
new GameToxicCircle[MAX_LASTALIVE_GAMES][MAX_GAME_CIRCLE_POS][GameToxicCircle_Info];
#define MAX_GAME_CIRCLE_POS 4
enum GameSafeCircle_Info
{
	_GangZoneID
}
new GameSafeCircle[MAX_LASTALIVE_GAMES][MAX_GAME_CIRCLE_POS][GameSafeCircle_Info];
new Float:SafeCircleStaticStartPos[MAX_LASTALIVE_GAMES][MAX_GAME_CIRCLE_POS][4];
new Float:PlaneFullMapPos[][] =
{
    {-3000.0,-3000.0,3000.0,3000.0},
    {3000.0,3000.0,-3000.0,-3000.0},
    {-3000.0,3000.0,3000.0,-3000.0},
    {3000.0,-3000.0,-3000.0,3000.0}
};
/*******************************************************/
enum PlayerModeTeam_Info
{
	_Mode,
	_Team_Key[3],
}
new PlayerModeTeam[MAX_PLAYERS][PlayerModeTeam_Info];
/*******************************************************/
#define MAX_PLAYER_FACE_MODE_DRAWS 6
new PlayerText:PlayerFaceModeMenu[MAX_PLAYERS][MAX_PLAYER_FACE_MODE_DRAWS];

#define MAX_PLAYER_FACE_TEAM_DRAWS 10
new PlayerText:PlayerFaceTeamMenu[MAX_PLAYERS][MAX_PLAYER_FACE_TEAM_DRAWS];

/*******************************************************/
#define MAX_FACEMENU_DRAWS 26
new Text:FaceMenuDraw[MAX_FACEMENU_DRAWS];
new PlayerText:FaceMenuCdsDraw[MAX_PLAYERS];
new PlayerText:FaceMenuLevelDraw[MAX_PLAYERS];
new PlayerText:FaceMenuTimeDraw[MAX_PLAYERS];
new PlayerText:FaceMenuOnlineCountDraw[MAX_PLAYERS];

new PlayerText:FriendsBotton[MAX_PLAYERS];
new PlayerText:MailsBotton[MAX_PLAYERS];
new PlayerText:OthersBotton[MAX_PLAYERS];
/*******************************************************/
#define MAX_LANGMENU_DRAWS 6
new Text:LangMenuDraw[MAX_FACEMENU_DRAWS];
/*******************************************************/
#define MAX_GAMEOVER_DRAWS 5
new Text:GameOverPrive[MAX_GAMEOVER_DRAWS];

new PlayerText:pGameOverChicken[MAX_PLAYERS];
new PlayerText:pGameOverTeamRank[MAX_PLAYERS];
new PlayerText:pGameOverKills[MAX_PLAYERS];
new PlayerText:pGameOverNumber[MAX_PLAYERS];
new PlayerText:pGameOverReward[MAX_PLAYERS];
new PlayerText:pGameOverTimeLeft[MAX_PLAYERS];

/*******************************************************/
new PlayerText:PlayerDamageDraw[MAX_PLAYERS];
new Timer:PlayerDamageTimer[MAX_PLAYERS];
new PlayerDamageAmout[MAX_PLAYERS];
/*******************************************************/
enum pRotCam_InFo
{
	Float:_X,
	Float:_Y,
	Float:_Z,
	Float:_A,
	Float:_Radius,
	Float:_Speed,
	Float:_Height,
	Float:_Degree,
	bool:_Moving,
	Timer:_Timer
};
new pRotCam[MAX_PLAYERS][pRotCam_InFo];
new Timer:PlayerConnectPosChange[MAX_PLAYERS];
/*******************************************************/
#define MAX_WAITROOM_TYPES MAX_PLAYERS
enum WaitRoom_InFo
{
    bool:_Open,
    _Key,
    _Owner,
    _Countdown,
    _Weather,
    _WeatherChange,
    _WeatherCount,
    _Obj1,
    _Obj2,
    _Obj3,
    _Obj4
}
new WaitRoom[MAX_WAITROOM_TYPES][WaitRoom_InFo];
new Iterator:WaitRoom<MAX_WAITROOM_TYPES>;
/*******************************************************/
#define MAX_WAITROOM_DRAWS 7
new Text:WaitRoomPrive[MAX_WAITROOM_DRAWS];
new Text:WaitRoomAmoutPrive[MAX_WAITROOM_TYPES];
new Text:WaitRoomCountdownPrive[MAX_WAITROOM_TYPES];
/********************************************************************************/
new Text3D:PlayerNameTag[MAX_PLAYERS];
new Text3D:PlayerAfkTag[MAX_PLAYERS];
new LastPauseTime[MAX_PLAYERS];
new LastState[MAX_PLAYERS];
#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "wd"
#define MYSQL_PASS "li123856"
#define MYSQL_DB   "pubg"
#define MYSQL_DB_USER	"玩家数据"
#define MYSQL_DB_BAG	"玩家背包"
#define MYSQL_DB_ATTACH	"玩家装饰"
#define MYSQL_DB_FRIEND "玩家好友"
#define MYSQL_DB_MAIL 	"玩家邮箱"

#define MYSQL_LOG_DB   "pubglog"
#define MYSQL_ANTI_LOG	"反作弊日志"

#define MYSQL_AC_DB   "dtsac"
#define MYSQL_AC_SERCHACK "userchack"
#define MYSQL_AC_LOG    "record"

#define MYSQL_SEVRVER_DB   "pubgset"
#define MYSQL_SEVRVER_SET	"配置"
#define MYSQL_SEVRVER_MUSIC	"音乐"

#define PASSWORD_SALT   "dts001"
new User@Handle;
new Ac@Handle;
new Log@Handle;
new Set@Handle;
enum
{
	PLAYER_IN_NULL,
	PLAYER_IN_INTERFACE,
	PLAYER_IN_WAITROOM,
	PLAYER_IN_GAMEROOM,
	PLAYER_IN_WAITLEAVE,
	PLAYER_IN_SPECPLAYER
}
new PlayerInState[MAX_PLAYERS];
new PlayerInStateID[MAX_PLAYERS];
enum Account_InFo
{
	_Key,
	_Name[32],
	_Password[128],
	_Language,
	_Skin,
	_Gold,
	_SceneID,
	_SceneRot,
	_NameColor,
	_TestCode,
	_Mute,
	_Level,
	_Exp,
	_SignID,
	
	_OnlineCounts,
	bool:_Login
};
new Account[MAX_PLAYERS][Account_InFo];
#define pLang(%0) Account[%0][_Language]
#define pScene(%0) Account[%0][_SceneID]
new Languages[][]={"中文","English"};
enum SpawnScenes_Info
{
    _CnName[32],
    _EnName[32],
    Float:_X,
    Float:_Y,
    Float:_Z,
    Float:_A
}
new SpawnScenes[][SpawnScenes_Info] =
{
    {"神殿祭坛","Temple Altar",1702.2183,-2518.8552,1024.5825,268.3624},
    {"血腥地下室","Bloody Basement",2359.1719,-599.7527,85.9263,262.3093},
    {"千年山","Millennium Hill",-2376.2095,-2196.0808,33.6426,296.3342}
};
/********************************************************************************/
enum
{
	TYPE_SKIN,
	TYPE_ADORN,
	TYPE_BOX,
}
enum MallItem_Info
{
	_Type,
	_Name[32],
	_Model,
	_Price,
	_Extra1,
	_Extra2,
	bool:_Sell
}
enum MallItemDiffPos_Info
{
    _Attach_Bone,
	Float:_Attach_fOffsetX,
	Float:_Attach_fOffsetY,
	Float:_Attach_fOffsetZ,
	Float:_Attach_fRotX,
	Float:_Attach_fRotY,
	Float:_Attach_fRotZ,
	Float:_Attach_fScaleX,
	Float:_Attach_fScaleY,
	Float:_Attach_fScaleZ
}
new MallItemDiffPos[][MallItemDiffPos_Info]=
{
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
     {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},

 	{6,0.054000,0.008999,-0.010000,0.000000,178.700057,0.000000,1.000000,1.000000,1.000000},
 	{6,0.082999,0.023000,0.016000,94.199996,88.399993,0.000000,0.962999,0.876000,1.000000},
 	{5,0.081000,0.003000,-0.042000,-115.100036,86.799972,0.000000,1.000000,1.000000,1.000000},
 	{5,0.018000,0.062999,-0.004999,-31.900007,-179.999954,174.799987,1.000000,1.000000,1.000000},
 	{2,0.128999,0.048000,0.008000,0.000000,85.900062,91.400032,1.140999,1.123999,1.015000},
 	{13,0.252000,-0.213000,0.028000,-13.599996,6.099994,93.500076,1.000000,1.000000,1.000000},
 	{2,0.160999,0.000000,0.000000,0.000000,0.000000,0.000000,1.021000,1.134000,1.174000},
 	{2,0.186000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{2,0.110000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{2,0.106999,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{2,0.116000,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{2,0.124999,0.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{1,-1.162000,0.083999,-1.664000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 	{2,0.132999,0.007000,0.000000,0.000000,0.000000,0.000000,1.047000,1.120000,1.093999},

    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    {0,0.0,0.0,0.0,0.0,0.0,0.0,1.000000,1.000000,1.000000},
    
	{6,0.067999,0.017999,0.007000,-86.600067,2.200007,-6.099997,1.000000,1.000000,1.000000}
};
new MallItem[][MallItem_Info]=
{
	{TYPE_SKIN,"cj",0,120,NONE,0,false},
	{TYPE_SKIN,"truth",1,120,NONE,0,true},
	{TYPE_SKIN,"maccer",2,150,NONE,0,true},
	{TYPE_SKIN,"andre",3,160,NONE,0,true},
	{TYPE_SKIN,"bbthin",170,14,NONE,0,true},
	{TYPE_SKIN,"bb",5,180,NONE,0,true},
	{TYPE_SKIN,"emmet",6,165,NONE,0,true},
	{TYPE_SKIN,"male01",7,150,NONE,0,true},
	{TYPE_SKIN,"janitor",8,165,NONE,0,true},
	{TYPE_SKIN,"bfori",9,200,NONE,0,true},
	{TYPE_SKIN,"bfost",10,210,NONE,0,true},
	{TYPE_SKIN,"vbfycrp",11,220,NONE,0,true},
	{TYPE_SKIN,"bfyri",12,205,NONE,0,true},
	{TYPE_SKIN,"bfyst",13,199,NONE,0,true},
	{TYPE_SKIN,"bmori",14,187,NONE,0,true},
	{TYPE_SKIN,"bmost",15,206,NONE,0,true},
	{TYPE_SKIN,"bmyap",16,153,NONE,0,true},
	{TYPE_SKIN,"bmybu",17,144,NONE,0,true},
	{TYPE_SKIN,"bmybe",18,168,NONE,0,true},
	{TYPE_SKIN,"bmydj",19,139,NONE,0,true},
	{TYPE_SKIN,"bmyri",20,128,NONE,0,true},
	{TYPE_SKIN,"bmycr",21,190,NONE,0,true},
	{TYPE_SKIN,"bmyst",22,206,NONE,0,true},
	{TYPE_SKIN,"wmybmx",23,220,NONE,0,true},
	{TYPE_SKIN,"wbdyg1",24,231,NONE,0,true},
	{TYPE_SKIN,"wbdyg2",25,302,NONE,0,true},
	{TYPE_SKIN,"wmybp",26,342,NONE,0,true},
	{TYPE_SKIN,"wmycon",27,0,NONE,0,false},
	{TYPE_SKIN,"bmydrug",28,0,NONE,0,false},
	{TYPE_SKIN,"wmydrug",29,0,NONE,0,false},
	{TYPE_SKIN,"hmydrug",30,0,NONE,0,false},
	{TYPE_SKIN,"dwfolc",31,0,NONE,0,false},
	{TYPE_SKIN,"dwmolc1",32,0,NONE,0,false},
	{TYPE_SKIN,"dwmolc2",33,0,NONE,0,false},
	{TYPE_SKIN,"dwmylc1",34,0,NONE,0,false},
	{TYPE_SKIN,"hmogar",35,0,NONE,0,false},
	{TYPE_SKIN,"wmygol1",36,0,NONE,0,false},
	{TYPE_SKIN,"wmygol2",37,0,NONE,0,false},
	{TYPE_SKIN,"hfori",38,0,NONE,0,false},
	{TYPE_SKIN,"hfost",39,0,NONE,0,false},
	{TYPE_SKIN,"hfyri",40,0,NONE,0,false},
	{TYPE_SKIN,"hfyst",41,0,NONE,0,false},
	{TYPE_SKIN,"jethro",42,0,NONE,0,false},
	{TYPE_SKIN,"hmori",43,0,NONE,0,false},
	{TYPE_SKIN,"hmost",44,0,NONE,0,false},
	{TYPE_SKIN,"hmybe",45,0,NONE,0,false},
	{TYPE_SKIN,"hmyri",46,0,NONE,0,false},
	{TYPE_SKIN,"hmycr",47,0,NONE,0,false},
	{TYPE_SKIN,"hmyst",48,0,NONE,0,false},
	{TYPE_SKIN,"omokung",49,0,NONE,0,false},
	{TYPE_SKIN,"wmymech",50,0,NONE,0,false},
	{TYPE_SKIN,"bmymoun",51,0,NONE,0,false},
	{TYPE_SKIN,"wmymoun",52,0,NONE,0,false},
	{TYPE_SKIN,"ofori",53,0,NONE,0,false},
	{TYPE_SKIN,"ofost",54,0,NONE,0,false},
	{TYPE_SKIN,"ofyri",55,0,NONE,0,false},
	{TYPE_SKIN,"ofyst",56,0,NONE,0,false},
	{TYPE_SKIN,"omori",57,0,NONE,0,false},
	{TYPE_SKIN,"omost",58,0,NONE,0,false},
	{TYPE_SKIN,"wmymech",59,0,NONE,0,false},
	{TYPE_SKIN,"omyst",60,0,NONE,0,false},
	{TYPE_SKIN,"wmyplt",61,0,NONE,0,false},
	{TYPE_SKIN,"wmopj",62,0,NONE,0,false},
	{TYPE_SKIN,"bfypro",63,0,NONE,0,false},
	{TYPE_SKIN,"hfypro",64,0,NONE,0,false},
	{TYPE_SKIN,"kendl",65,0,NONE,0,false},
	{TYPE_SKIN,"bmypol1",66,0,NONE,0,false},
	{TYPE_SKIN,"bmypol2",67,0,NONE,0,false},
	{TYPE_SKIN,"wmoprea",68,0,NONE,0,false},
	{TYPE_SKIN,"sbfyst",69,0,NONE,0,false},
	{TYPE_SKIN,"wmosci",70,0,NONE,0,false},
	{TYPE_SKIN,"wmysgrd",71,0,NONE,0,false},
	{TYPE_SKIN,"swmyhp1",72,0,NONE,0,false},
	{TYPE_SKIN,"swmyhp2",73,0,NONE,0,false},
	{TYPE_SKIN,"swfopro",75,0,NONE,0,false},
	{TYPE_SKIN,"wfystew",76,0,NONE,0,false},
	{TYPE_SKIN,"swmotr1",77,0,NONE,0,false},
	{TYPE_SKIN,"wmotr1",78,0,NONE,0,false},
	{TYPE_SKIN,"bmotr1",79,0,NONE,0,false},
	{TYPE_SKIN,"vbmybox",80,0,NONE,0,false},
	{TYPE_SKIN,"vwmybox",81,0,NONE,0,false},
	{TYPE_SKIN,"vhmyelv",82,0,NONE,0,false},
	{TYPE_SKIN,"vbmyelv",83,0,NONE,0,false},
	{TYPE_SKIN,"vimyelv",84,0,NONE,0,false},
	{TYPE_SKIN,"vwfypro",85,0,NONE,0,false},
	{TYPE_SKIN,"ryder3",86,0,NONE,0,false},
	{TYPE_SKIN,"vwfyst1",87,0,NONE,0,false},
	{TYPE_SKIN,"wfori",88,0,NONE,0,false},
	{TYPE_SKIN,"wfost",89,0,NONE,0,false},
	{TYPE_SKIN,"wfyjg",90,0,NONE,0,false},
	{TYPE_SKIN,"wfyri",91,0,NONE,0,false},
	{TYPE_SKIN,"wfyro",92,0,NONE,0,false},
	{TYPE_SKIN,"wfyst",93,0,NONE,0,false},
	{TYPE_SKIN,"wmori",94,0,NONE,0,false},
	{TYPE_SKIN,"wmost",95,0,NONE,0,false},
	{TYPE_SKIN,"wmyjg",96,0,NONE,0,false},
	{TYPE_SKIN,"wmylg",97,0,NONE,0,false},
	{TYPE_SKIN,"wmyri",98,0,NONE,0,false},
	{TYPE_SKIN,"wmyro",99,0,NONE,0,false},
	{TYPE_SKIN,"wmycr",100,0,NONE,0,false},
	{TYPE_SKIN,"wmyst",101,0,NONE,0,false},
	{TYPE_SKIN,"ballas1",102,0,NONE,0,false},
	{TYPE_SKIN,"ballas2",103,0,NONE,0,false},
	{TYPE_SKIN,"ballas3",104,0,NONE,0,false},
	{TYPE_SKIN,"fam1",105,0,NONE,0,false},
	{TYPE_SKIN,"fam2",106,0,NONE,0,false},
	{TYPE_SKIN,"fam3",107,0,NONE,0,false},
	{TYPE_SKIN,"lsv1",108,0,NONE,0,false},
	{TYPE_SKIN,"lsv2",109,0,NONE,0,false},
	{TYPE_SKIN,"lsv3",110,0,NONE,0,false},
	{TYPE_SKIN,"maffa",111,0,NONE,0,false},
	{TYPE_SKIN,"maffb",112,0,NONE,0,false},
	{TYPE_SKIN,"mafboss",113,0,NONE,0,false},
	{TYPE_SKIN,"vla1",114,0,NONE,0,false},
	{TYPE_SKIN,"vla2",115,0,NONE,0,false},
	{TYPE_SKIN,"vla3",116,0,NONE,0,false},
	{TYPE_SKIN,"triada",117,0,NONE,0,false},
	{TYPE_SKIN,"triadb",118,0,NONE,0,false},
	{TYPE_SKIN,"sindaco",119,0,NONE,0,false},
	{TYPE_SKIN,"triboss",120,0,NONE,0,false},
	{TYPE_SKIN,"dnb1",121,0,NONE,0,false},
	{TYPE_SKIN,"dnb2",122,0,NONE,0,false},
	{TYPE_SKIN,"dnb3",123,0,NONE,0,false},
	{TYPE_SKIN,"vmaff1",124,0,NONE,0,false},
	{TYPE_SKIN,"vmaff2",125,0,NONE,0,false},
	{TYPE_SKIN,"vmaff3",126,0,NONE,0,false},
	{TYPE_SKIN,"vmaff4",127,0,NONE,0,false},
	{TYPE_SKIN,"dnmylc",128,0,NONE,0,false},
	{TYPE_SKIN,"dnfolc1",129,0,NONE,0,false},
	{TYPE_SKIN,"dnfolc2",130,0,NONE,0,false},
	{TYPE_SKIN,"dnfylc",131,0,NONE,0,false},
	{TYPE_SKIN,"dnmolc1",132,0,NONE,0,false},
	{TYPE_SKIN,"dnmolc2",133,0,NONE,0,false},
	{TYPE_SKIN,"sbmotr2",134,0,NONE,0,false},
	{TYPE_SKIN,"swmotr2",135,0,NONE,0,false},
	{TYPE_SKIN,"sbmytr3",136,0,NONE,0,false},
	{TYPE_SKIN,"swmotr3",137,0,NONE,0,false},
	{TYPE_SKIN,"wfybe",138,0,NONE,0,false},
	{TYPE_SKIN,"bfybe",139,0,NONE,0,false},
	{TYPE_SKIN,"hfybe",140,0,NONE,0,false},
	{TYPE_SKIN,"sofybu",141,0,NONE,0,false},
	{TYPE_SKIN,"sbmyst",142,0,NONE,0,false},
	{TYPE_SKIN,"sbmycr",143,0,NONE,0,false},
	{TYPE_SKIN,"bmycg",144,0,NONE,0,false},
	{TYPE_SKIN,"wfycrk",145,0,NONE,0,false},
	{TYPE_SKIN,"hmycm",146,0,NONE,0,false},
	{TYPE_SKIN,"wmybu",147,0,NONE,0,false},
	{TYPE_SKIN,"bfybu",148,0,NONE,0,false},
	{TYPE_SKIN,"smokev",149,0,NONE,0,false},
	{TYPE_SKIN,"wfybu",150,0,NONE,0,false},
	{TYPE_SKIN,"dwfylc1",151,0,NONE,0,false},
	{TYPE_SKIN,"wfypro",152,0,NONE,0,false},
	{TYPE_SKIN,"wmyconb",153,0,NONE,0,false},
	{TYPE_SKIN,"wmybe",154,0,NONE,0,false},
	{TYPE_SKIN,"wmypizz",155,0,NONE,0,false},
	{TYPE_SKIN,"bmobar",156,0,NONE,0,false},
	{TYPE_SKIN,"cwfyhb",157,0,NONE,0,false},
	{TYPE_SKIN,"cwmofr",158,0,NONE,0,false},
	{TYPE_SKIN,"cwmohb1",159,0,NONE,0,false},
	{TYPE_SKIN,"cwmohb2",160,0,NONE,0,false},
	{TYPE_SKIN,"cwmyfr",161,0,NONE,0,false},
	{TYPE_SKIN,"cwmyhb1",162,0,NONE,0,false},
	{TYPE_SKIN,"bmyboun",163,0,NONE,0,false},
	{TYPE_SKIN,"wmyboun",164,0,NONE,0,false},
	{TYPE_SKIN,"wmomib",165,0,NONE,0,false},
	{TYPE_SKIN,"bmymib",166,0,NONE,0,false},
	{TYPE_SKIN,"wmybell",167,0,NONE,0,false},
	{TYPE_SKIN,"bmochil",168,0,NONE,0,false},
	{TYPE_SKIN,"sofyri",169,0,NONE,0,false},
	{TYPE_SKIN,"somyst",170,0,NONE,0,false},
	{TYPE_SKIN,"vwmybjd",171,0,NONE,0,false},
	{TYPE_SKIN,"vwfycrp",172,0,NONE,0,false},
	{TYPE_SKIN,"sfr1",173,0,NONE,0,false},
	{TYPE_SKIN,"sfr2",174,0,NONE,0,false},
	{TYPE_SKIN,"sfr3",175,0,NONE,0,false},
	{TYPE_SKIN,"bmybar",176,0,NONE,0,false},
	{TYPE_SKIN,"wmybar",177,0,NONE,0,false},
	{TYPE_SKIN,"wfysex",178,0,NONE,0,false},
	{TYPE_SKIN,"wmyammo",179,0,NONE,0,false},
	{TYPE_SKIN,"bmytatt",180,0,NONE,0,false},
	{TYPE_SKIN,"vwmycr",181,0,NONE,0,false},
	{TYPE_SKIN,"vbmocd",182,0,NONE,0,false},
	{TYPE_SKIN,"vbmycr",183,0,NONE,0,false},
	{TYPE_SKIN,"vhmycr",184,0,NONE,0,false},
	{TYPE_SKIN,"sbmyri",185,0,NONE,0,false},
	{TYPE_SKIN,"somyri",186,0,NONE,0,false},
	{TYPE_SKIN,"somybu",187,0,NONE,0,false},
	{TYPE_SKIN,"swmyst",188,0,NONE,0,false},
	{TYPE_SKIN,"wmyva",189,0,NONE,0,false},
	{TYPE_SKIN,"copgrl3",190,0,NONE,0,false},
	{TYPE_SKIN,"gungrl3",191,0,NONE,0,false},
	{TYPE_SKIN,"mecgrl3",192,0,NONE,0,false},
	{TYPE_SKIN,"nurgrl3",193,0,NONE,0,false},
	{TYPE_SKIN,"crogrl3",194,0,NONE,0,false},
	{TYPE_SKIN,"gangrl3",195,0,NONE,0,false},
	{TYPE_SKIN,"cwfofr",196,0,NONE,0,false},
	{TYPE_SKIN,"cwfohb",197,0,NONE,0,false},
	{TYPE_SKIN,"cwfyfr1",198,0,NONE,0,false},
	{TYPE_SKIN,"cwfyfr2",199,0,NONE,0,false},
	{TYPE_SKIN,"cwmyhb2",200,0,NONE,0,false},
	{TYPE_SKIN,"dwfylc2",201,0,NONE,0,false},
	{TYPE_SKIN,"dwmylc2",202,0,NONE,0,false},
	{TYPE_SKIN,"omykara",203,0,NONE,0,false},
	{TYPE_SKIN,"wmykara",204,0,NONE,0,false},
	{TYPE_SKIN,"wfyburg",205,0,NONE,0,false},
	{TYPE_SKIN,"vwmycd",206,0,NONE,0,false},
	{TYPE_SKIN,"vhfypro",207,0,NONE,0,false},
	{TYPE_SKIN,"suzie",208,0,NONE,0,false},
	{TYPE_SKIN,"omonood",209,0,NONE,0,false},
	{TYPE_SKIN,"omoboat",210,0,NONE,0,false},
	{TYPE_SKIN,"wfyclot",211,0,NONE,0,false},
	{TYPE_SKIN,"vwmotr1",212,0,NONE,0,false},
	{TYPE_SKIN,"vwmotr2",213,0,NONE,0,false},
	{TYPE_SKIN,"vwfywai",214,0,NONE,0,false},
	{TYPE_SKIN,"sbfori",215,0,NONE,0,false},
	{TYPE_SKIN,"swfyri",216,0,NONE,0,false},
	{TYPE_SKIN,"wmyclot",217,0,NONE,0,false},
	{TYPE_SKIN,"sbfost",218,0,NONE,0,false},
	{TYPE_SKIN,"sbfyri",219,0,NONE,0,false},
	{TYPE_SKIN,"sbmocd",220,0,NONE,0,false},
	{TYPE_SKIN,"sbmori",221,0,NONE,0,false},
	{TYPE_SKIN,"sbmost",222,0,NONE,0,false},
	{TYPE_SKIN,"shmycr",223,0,NONE,0,false},
	{TYPE_SKIN,"sofori",224,0,NONE,0,false},
	{TYPE_SKIN,"sofost",225,0,NONE,0,false},
	{TYPE_SKIN,"sofyst",226,0,NONE,0,false},
	{TYPE_SKIN,"somobu",227,0,NONE,0,false},
	{TYPE_SKIN,"somori",228,0,NONE,0,false},
	{TYPE_SKIN,"somost",229,0,NONE,0,false},
	{TYPE_SKIN,"swmotr5",230,0,NONE,0,false},
	{TYPE_SKIN,"swfori",231,0,NONE,0,false},
	{TYPE_SKIN,"swfost",232,0,NONE,0,false},
	{TYPE_SKIN,"swfyst",233,0,NONE,0,false},
	{TYPE_SKIN,"swmocd",234,0,NONE,0,false},
	{TYPE_SKIN,"swmori",235,0,NONE,0,false},
	{TYPE_SKIN,"swmost",236,0,NONE,0,false},
	{TYPE_SKIN,"shfypro",237,0,NONE,0,false},
	{TYPE_SKIN,"sbfypro",238,0,NONE,0,false},
	{TYPE_SKIN,"swmotr4",239,0,NONE,0,false},
	{TYPE_SKIN,"swmyri",240,0,NONE,0,false},
	{TYPE_SKIN,"smyst",241,0,NONE,0,false},
	{TYPE_SKIN,"smyst2",242,0,NONE,0,false},
	{TYPE_SKIN,"sfypro",243,0,NONE,0,false},
	{TYPE_SKIN,"vbfyst2",244,0,NONE,0,false},
	{TYPE_SKIN,"vbfypro",245,0,NONE,0,false},
	{TYPE_SKIN,"vhfyst3",246,0,NONE,0,false},
	{TYPE_SKIN,"bikera",247,0,NONE,0,false},
	{TYPE_SKIN,"bikerb",248,0,NONE,0,false},
	{TYPE_SKIN,"bmypimp",249,0,NONE,0,false},
	{TYPE_SKIN,"swmycr",250,0,NONE,0,false},
	{TYPE_SKIN,"wfylg",251,0,NONE,0,false},
	{TYPE_SKIN,"wmyva2",252,0,NONE,0,false},
	{TYPE_SKIN,"bmosec",253,0,NONE,0,false},
	{TYPE_SKIN,"bikdrug",254,0,NONE,0,false},
	{TYPE_SKIN,"wmych",255,0,NONE,0,false},
	{TYPE_SKIN,"sbfystr",256,0,NONE,0,false},
	{TYPE_SKIN,"swfystr",257,0,NONE,0,false},
	{TYPE_SKIN,"heck1",258,0,NONE,0,false},
	{TYPE_SKIN,"heck2",259,0,NONE,0,false},
	{TYPE_SKIN,"bmycon",260,0,NONE,0,false},
	{TYPE_SKIN,"wmycd1",261,0,NONE,0,false},
	{TYPE_SKIN,"bmocd",262,0,NONE,0,false},
	{TYPE_SKIN,"vwfywa2",263,0,NONE,0,false},
	{TYPE_SKIN,"wmoice",264,0,NONE,0,false},
	{TYPE_SKIN,"tenpen",265,0,NONE,0,false},
	{TYPE_SKIN,"pulaski",266,0,NONE,0,false},
	{TYPE_SKIN,"hern",267,0,NONE,0,false},
	{TYPE_SKIN,"dwayne",268,0,NONE,0,false},
	{TYPE_SKIN,"smoke",269,0,NONE,0,false},
	{TYPE_SKIN,"sweet",270,0,NONE,0,false},
	{TYPE_SKIN,"ryder",271,0,NONE,0,false},
	{TYPE_SKIN,"forelli",272,0,NONE,0,false},
	{TYPE_SKIN,"tbone",273,0,NONE,0,false},
	{TYPE_SKIN,"laemt1",274,0,NONE,0,false},
	{TYPE_SKIN,"lvemt1",275,0,NONE,0,false},
	{TYPE_SKIN,"sfemt1",276,0,NONE,0,false},
	{TYPE_SKIN,"lafd1",277,0,NONE,0,false},
	{TYPE_SKIN,"lvfd1",278,0,NONE,0,false},
	{TYPE_SKIN,"sffd1",279,0,NONE,0,false},
	{TYPE_SKIN,"lapd1",280,0,NONE,0,false},
	{TYPE_SKIN,"sfpd1",281,0,NONE,0,false},
	{TYPE_SKIN,"lvpd1",282,0,NONE,0,false},
	{TYPE_SKIN,"csher",283,0,NONE,0,false},
	{TYPE_SKIN,"lapdm1",284,0,NONE,0,false},
	{TYPE_SKIN,"swat",285,0,NONE,0,false},
	{TYPE_SKIN,"fbi",286,0,NONE,0,false},
	{TYPE_SKIN,"army",287,0,NONE,0,false},
	{TYPE_SKIN,"dsher",288,0,NONE,0,false},
	{TYPE_SKIN,"zero",289,0,NONE,0,false},
	{TYPE_SKIN,"rose",290,0,NONE,0,false},
	{TYPE_SKIN,"paul",291,0,NONE,0,false},
	{TYPE_SKIN,"cesar",292,0,NONE,0,false},
	{TYPE_SKIN,"ogloc",293,0,NONE,0,false},
	{TYPE_SKIN,"wuzimu",294,0,NONE,0,false},
	{TYPE_SKIN,"torino",295,0,NONE,0,false},
	{TYPE_SKIN,"jizzy",296,0,NONE,0,false},
	{TYPE_SKIN,"maddogg",297,0,NONE,0,false},
	{TYPE_SKIN,"cat",298,0,NONE,0,false},
	{TYPE_SKIN,"claude",299,0,NONE,0,false},
	{TYPE_SKIN,"lapdna",300,0,NONE,0,false},
	{TYPE_SKIN,"sfpdna",301,0,NONE,0,false},
	{TYPE_SKIN,"lvpdna",302,0,NONE,0,false},
	{TYPE_SKIN,"lapdpc",303,0,NONE,0,false},
	{TYPE_SKIN,"lapdpd",304,0,NONE,0,false},
	{TYPE_SKIN,"lvpdpc",305,0,NONE,0,false},
	{TYPE_SKIN,"wfyclpd",306,0,NONE,0,false},
	{TYPE_SKIN,"vbfycpd",307,0,NONE,0,false},
	{TYPE_SKIN,"wfyclem",308,0,NONE,0,false},
	{TYPE_SKIN,"wfycllv",309,0,NONE,0,false},
	{TYPE_SKIN,"csherna",310,0,NONE,0,false},
	{TYPE_SKIN,"dsherna",311,0,NONE,0,false},

	{TYPE_ADORN,"FishingRod",18632,580,NONE,0,true},
	{TYPE_ADORN,"GTASAWrench1",18633,600,NONE,0,true},
	{TYPE_ADORN,"GTASACrowbar1",18634,650,NONE,0,true},
	{TYPE_ADORN,"GTASAHammer1",18635,700,NONE,0,true},
	{TYPE_ADORN,"PoliceCap1",18636,720,NONE,0,true},
	{TYPE_ADORN,"PoliceShield1",18637,730,NONE,0,true},
	{TYPE_ADORN,"HardHat1",18638,800,NONE,0,true},
	{TYPE_ADORN,"BlackHat1",18639,850,NONE,0,true},
	{TYPE_ADORN,"Hair1",18640,650,NONE,0,true},
	{TYPE_ADORN,"Hair2",18975,620,NONE,0,true},
	{TYPE_ADORN,"Hair4",19136,610,NONE,0,true},
	{TYPE_ADORN,"Hair5",19274,600,NONE,0,true},
	{TYPE_ADORN,"water_ripples",18741,1000,NONE,0,false},
	{TYPE_ADORN,"WitchesHat1",19528,800,NONE,0,true},

	{TYPE_BOX,"BOX_LV1",19572,5000,0xFF8000C8,1,true},
	{TYPE_BOX,"BOX_LV2",19572,10000,0xFFFF00C8,2,true},
	{TYPE_BOX,"BOX_LV3",19572,20000,0x0000FFC8,3,true},
	
	{TYPE_ADORN,"MarcosFryingPan1",19581,1000,NONE,0,false}
};

#define MAX_MALL_BACKGROUND 17
new Text:MallBackGround[MAX_MALL_BACKGROUND];

#define MAX_MALL_BOX_ITEMS 1002//动态对话框数组最大值
#define MAX_MALL_SHOW_LIST 12
new MallPrevieBox[MAX_PLAYERS][MAX_MALL_BOX_ITEMS];
new MallPrevieCount[MAX_PLAYERS];
new MallPreviePage[MAX_PLAYERS];
new MallPrevieRate[MAX_PLAYERS];

new MallPrevieType[MAX_PLAYERS];
new MallClickID[MAX_PLAYERS];

new PlayerText:PlayerMallModelDraw[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerMallBackGround[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerMallName[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerMallPriceIcon[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerMallPrice[MAX_PLAYERS][MAX_MALL_SHOW_LIST];

new PlayerText:PlayerMallSliderBar[MAX_PLAYERS];
new PlayerText:PlayerMallBottonUp[MAX_PLAYERS];
new PlayerText:PlayerMallBottonDown[MAX_PLAYERS];
new PlayerText:PlayerMallMyMoney[MAX_PLAYERS];
/********************************************************************************/
#define MAX_BAG_BACKGROUND 12
new Text:BagBackGround[MAX_BAG_BACKGROUND];

#define MAX_PLAYERBAG_BOX_ITEMS 102//动态对话框数组最大值
#define MAX_PLAYERBAG_SHOW_LIST 12
new PlayerBagPrevieBox[MAX_PLAYERS][MAX_PLAYERBAG_BOX_ITEMS];
new PlayerBagPrevieBoxKey[MAX_PLAYERS][MAX_PLAYERBAG_BOX_ITEMS];
new PlayerBagPrevieCount[MAX_PLAYERS];
new PlayerBagPreviePage[MAX_PLAYERS];
new PlayerBagPrevieRate[MAX_PLAYERS];

new PlayerBagPrevieType[MAX_PLAYERS];
new PlayerBagClickID[MAX_PLAYERS];

new PlayerText:PlayerBagModelDraw[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerBagBackGround[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerBagName[MAX_PLAYERS][MAX_MALL_SHOW_LIST];
new PlayerText:PlayerBagAmount[MAX_PLAYERS][MAX_MALL_SHOW_LIST];

new PlayerText:PlayerBagSliderBar[MAX_PLAYERS];
new PlayerText:PlayerBagBottonUp[MAX_PLAYERS];
new PlayerText:PlayerBagBottonDown[MAX_PLAYERS];
new PlayerText:PlayerBagCapacity[MAX_PLAYERS];
enum
{
	BAG_SUCCESS,
	BAG_ERROR,
	BAG_NOEXIST,
	BAG_FULL
}
#define MAX_PLAYER_BAG 100
enum Bag_InFo
{
	_Key,
	_Owner,
	_ItemID,
	_Amout
};
new Bag[MAX_PLAYERS][MAX_PLAYER_BAG][Bag_InFo];
new Iterator:Bag[MAX_PLAYERS]<MAX_PLAYER_BAG>;
#define PlayerBagItemID(%0,%1) Bag[%0][%1][_ItemID]
#define PlayerBagItemAmout(%0,%1) Bag[%0][%1][_Amout]
#define PlayerBagItemKey(%0,%1) Bag[%0][%1][_Key]
/********************************************************************************/
#define MAX_PLAYER_ATTACHS 3
enum pAttach_InFo
{
	_Key,
	_Owner,
	_ItemID
};
new pAttach[MAX_PLAYERS][MAX_PLAYER_ATTACHS][pAttach_InFo];
new Iterator:pAttach[MAX_PLAYERS]<MAX_PLAYER_ATTACHS>;
#define PlayerAttachItem(%0,%1) pAttach[%0][%1][_ItemID]
/********************************************************************************/
new ServerHour=0,ServerMinute=0,ServerSecond=0;
/********************************************************************************/
new PlayerText:PlayerBoxBackDraw[MAX_PLAYERS];
new PlayerText:PlayerBoxModelDraw[MAX_PLAYERS];
new PlayerText:PlayerBoxTagDraw[MAX_PLAYERS];
new PlayerText:PlayerBoxCloseDraw[MAX_PLAYERS];
#define MAX_PLAYER_GIFTS 3
new PlayerText:PlayerBoxGiftDraw[MAX_PLAYERS][MAX_PLAYER_GIFTS];
new PlayerText:PlayerBoxGiftTextDraw[MAX_PLAYERS][MAX_PLAYER_GIFTS];
new PlayerBoxGift[MAX_PLAYERS][MAX_PLAYER_GIFTS];
/********************************************************************************/
enum
{
	FRIEND_SUCCESS,
	FRIEND_ERROR,
	FRIEND_EXIST,
	FRIEND_NOT_EXIST,
	FRIEND_FULL,
	FRIEND_NOT_ONLINE
}
#define MAX_PLAYER_FRIENDS 100
enum pFriends_InFo
{
    _Key,
	_Owner_Key,
	_Friend_Key
};
new pFriends[MAX_PLAYERS][MAX_PLAYER_FRIENDS][pFriends_InFo];
new Iterator:pFriends[MAX_PLAYERS]<MAX_PLAYER_FRIENDS>;
/********************************************************************************/
enum
{
	MAIL_TYPE_NONE,
	MAIL_TYPE_PLAYER,
	MAIL_TYPE_SYSTEM,
	MAIL_TYPE_ADDFRIEND,
	MAIL_TYPE_TEAM
}
enum
{
	MAIL_SUCCESS,
	MAIL_ERROR,
	MAIL_FULL,
	MAIL_NOT_ONLINE,
	MAIL_NOT_EXIST
}
#define MAX_PLAYER_MAILS 100
enum pMails_InFo
{
    _Key,
    _Type,
    _Owner_Key,
    _Sender_Key,
    _Tag[64],
    _Content[256],
    _SendTime[32],
    _Gold,
    _Item_ID,
    _Item_Amount,
    _Extra,
    _Readed
};
new pMails[MAX_PLAYERS][MAX_PLAYER_MAILS][pMails_InFo];
new Iterator:pMails[MAX_PLAYERS]<MAX_PLAYER_MAILS>;
/********************************************************************************/
#define MAX_BOX_LIST 15//动态对话框列数
#define MAX_DIALOG_BOX_ITEMS 5000
new DialogPage[MAX_PLAYERS];
new DialogBox[MAX_PLAYERS][MAX_DIALOG_BOX_ITEMS];
new DialogBoxKey[MAX_PLAYERS][MAX_DIALOG_BOX_ITEMS];
new DialogBoxID[MAX_PLAYERS];
/********************************************************************************/
enum
{
	TEAM_SUCCESS,
	TEAM_FULL
}
#define MAX_GAME_TEAMS 500
enum Teams_InFo
{
	_Key,
	_TeamOwnerKey,
	_TeamMember[4]
};
new Teams[MAX_GAME_TEAMS][Teams_InFo];
new Iterator:Teams<MAX_GAME_TEAMS>;
new pTeam[MAX_PLAYERS];
/********************************************************************************/
enum//对话框ID
{
    _ERROR,
    _REG,
    _LOGIN,
    
    _CMDS_HELP,

    _BAG_USE,

    _MALL_BUY,

    _MENU_CONFIG,
    _MENU_SCENE,
    _MENU_SCENE_SELECT,
    _MENU_LANGUAGE,
    _MENU_COLOR,

    _ATTACH_MANAGE,
    _ATTACH_DROP,

    _CREDITS,
    _UPDATE_LOG,

    _TEST_ENTER,
    
    _MY_FRIENDS,
    _ONLINE_ADD_FRIEND,
    _ONLINE_ADDFRIENDS_TIP,
    
    _MY_MAILS,
    _MY_MAILS_CHACK,
    
    _MY_MAILS_SHOW1,
    _MY_MAILS_SHOW2,
    
    _MY_FRIENDS_LIST,
    
	_TEAM_MODE_SET,
	_TEAM_MODE_MEMBERS,
	
	_BUY_SIGNS,
	
	_MUSIC_LIST,
	
	_SPEC_ROOMS,
	_SPEC_PLAYERS,
	
	_PRESON_ROOM,
	_PRESON_ROOM_LIST,
	_PRESON_ROOM_START,
	_ROOM_SELECT
}
/********************************************************************************/
new PlayerText:pCompassDraw[MAX_PLAYERS][MAX_UICOMPASS_TD];
#define MAX_COMPASSPRIVES 2
new Text:CompassPrive[MAX_COMPASSPRIVES];
new CompassDirection[MAX_PLAYERS];
/********************************************************************************/
enum SeverState_InFo
{
	bool:_ServerRun,
	_RunTimes
}
new SeverState[SeverState_InFo];
#define SERVER_RUNTIME SeverState[_RunTimes]
/********************************************************************************/
#define MAX_TESTPOS 10
enum testpos_info
{
	Float:_testx,
	Float:_testy,
	Float:_testz
};
new testpos[MAX_TESTPOS][MAX_GAME_VEHICLE][testpos_info];
new Iterator:testpos[MAX_TESTPOS]<MAX_GAME_VEHICLE>;
/********************************************************************************/
new pSpectateID[MAX_PLAYERS];
/********************************************************************************/
new SystemBroadcastDalay=0;
new LastSystemBroadcast=0;
enum SystemBroadcast_Info
{
    _chinese[135],
	_english[135]
}
new SystemBroadcast[][SystemBroadcast_Info]=
{
	{"捡到枪但是如果没有相对应的子弹,枪支是拿不出来的.","Pick up the gun but if there is no corresponding bullet,the firearm can not get out."},//0
    {"食物、饮料、药品可以极大地提升你的幸存几率.","Food, beverages, medicines can greatly enhance your chances of survival."},//1
    {"N 键小地图可以动态看到你的位置、安全区、空投.","N key map can dynamically see your location,safe area, airdrop."},//2
    {"上车 鼠标左键 启动汽车,下车别忘了再按一下熄火,否则仍然消耗汽油.","On the car left mouse button to start the car, get off do not forget to press the turn off,or still consume gasoline."},//3
    {"一键拾取附近的物资 ALT键,单个拾取 Y键 NEARBY 栏.","A key to pick up the nearby supplies ALT key,a single pick Y key NEARBY column."},//4
	{"防弹衣可以防护全身,防弹头盔可以防护头部,当然等级不同,防护水平也不同.","Body armor can protect the body,bullet-proof helmets can protect the head,of course,different levels of protection is also different."},//5
	{"空投里拥有很多物资,到达空投附近,显示菜单后按 C 键,可以选择拾取.","Airdrop has a lot of supplies, airdrop near the arrival of the menu,press the C key,you can choose to pick up."},//6
	{"比赛结束会获得相应的金币奖励,金币可以用于购买皮肤,饰品或箱子.","The end of the game will receive the corresponding gold coins,gold coins can be used to buy the skin,jewelry or box."},//7
	{"比赛只有在3分钟后结束才能获得金币奖励.","Gold medal rewards will only be given after 3 minutes."},//8
	{"账户的等级影响账户背包的容量.","The level of the account affects the capacity of the account backpack."},//9
	{"账户的等级每次提升都会获得相应的金币奖励邮件.","Each time you upgrade your account, you will receive the corresponding Gold Reward Mail."},//10
	{"不要在比赛里长时间挂机,挂机超过3分钟自动T出游戏.","Do not afk long in the race, afk for more than 3 minutes automatically T out of the game."},//11
	{"不论在任何地方,你都可以小键盘 6 键选择收听你喜欢的音乐以及控制你的音乐播放器.","You can  use Keypad 6 to listen to your favorite music and control your music player from anywhere."},//12
	{"如果觉得卡顿或FPS低,可以 /FPS 开关特效显示","If you feel Caton or FPS low ,/ FPS switch effects display"},//13
	{"比赛中小键盘 4 键可以开启或关闭伤害显示","Keypad 4 keys in the game can be turned on or off the injury display"},//14
	{"/o 全服发言 /n 附近发言50米内玩家可看到,其他的为状态发言,只有在相同状态的玩家才能看到","/o full speak /n nearby players can see in 50 meters,the other for the state to speak,only in the same state players can see"},//15
	{"如果想与朋友们玩,点击前厅左侧黑色双人图标,创建一个房间,房主按H键可以开启游戏","If you want to play with friends,click the black double icon on lobby to create a room,host press H key Can open game"}//16
};
/***********************************************************/
enum LevelRank_Info
{
	_level,
	_bonus,
	_needexp,
	_bagslots
}
new LevelRank[][LevelRank_Info]=
{
	{0,0,0,6},
	{1,30,300,8},
	{2,60,600,10},
	{3,90,1200,12},
	{4,120,2400,14},
	{5,150,4800,16},
	{6,180,19200,18},
	{7,210,38400,20},
	{8,240,76800,22},
	{9,270,153600,24},
	{10,300,307200,26},
	{11,330,614400,28},
	{12,360,1228800,30},
	{13,390,2457600,32},
	{14,420,4915200,34},
	{15,450,9830400,36},
	{16,480,19660800,38},
	{17,510,39321600,40},
	{18,540,78643200,42},
	{19,570,157286400,44},
	{20,600,314572800,46}
};
/*********************************/
#define MAX_PLAYER_SIGN 50
new Text3D:PlayerBodySignature[MAX_PLAYERS][MAX_PLAYER_SIGN];
new Text3D:PlayerGroundSignature[MAX_PLAYERS][MAX_PLAYER_SIGN];
enum Signature_Info
{
    _CnName[32],
    _EnName[32],
	_FileName[32],
	_Price,
	_Key
}
new Signature[][Signature_Info] =
{
    {"无表情","No expression"," ",0,0},
    {"卢本伟","卢本伟","干你妈自嗨",100,1},
    {"抱着你","抱着你","抱着你",100,2},
    {"大妹子","大妹子","大妹子",100,3},
    {"得意","得意","得意",150,4},
    {"好色的龟仙人","好色的龟仙人","好色的龟仙人",150,5},
    {"金馆长","金馆长","金馆长",150,6},
    {"流汗","流汗","流汗",150,7},
    {"泷泽萝拉1","泷泽萝拉1","泷泽萝拉1",500,8},
    {"泷泽萝拉2","泷泽萝拉2","泷泽萝拉2",500,9},
    {"美女","美女","美女",300,10},
    {"你没有freestyle吗","你没有freestyle吗","你没有freestyle吗",200,11},
    {"你们都是渣渣","你们都是渣渣","你们都是渣渣",150,12},
    {"你以为我想胖吗","你以为我想胖吗","你以为我想胖吗",150,13},
    {"跑车","跑车","跑车",120,14},
    {"亲亲","亲亲","亲亲",180,15},
    {"帅表情","帅表情","帅表情",100,16},
    {"小吉宝宝发怒","小吉宝宝发怒","小吉宝宝发怒",150,17},
    {"小吉宝宝抠鼻","小吉宝宝抠鼻","小吉宝宝抠鼻",150,18},
    {"小泽玛莉亚","小泽玛莉亚","小泽玛莉亚",200,19},
    {"斜眼笑","斜眼笑","斜眼笑",150,20},
    {"姚明","姚明","姚明",150,21},
    {"有点犯困","有点犯困","有点犯困",150,22},
    {"有咩意见啊你","有咩意见啊你","有咩意见啊你",150,23},
    {"你滚粗","你滚粗","张学友版表情你滚粗",150,24},
    {"做咩啊","做咩啊","做咩啊",150,25}
};
/*********************************/
#define MAX_NORELOAD_INFRACTIONS (1)
new WeaponMagSizes[17] =
{
	017, // 22 M9 x2 WHEN DUAL
	017, // 23 M9 SD
	007, // 24 Desert Eagle

	001, // 25 Shotgun
	002, // 26 Sawnoff x2 WHEN DUAL
	007, // 27 Spas 12

	050, // 28 Mac 10 x2 WHEN DUAL
	030, // 29 MP5
	030, // 30 AK-47
	050, // 31 M16
	050, // 32 Tec 9 x2 WHEN DUAL

	001, // 33 Rifle
	001, // 34 Sniper

	001, // 35 RPG
	001, // 36 Heatseeker
	500, // 37 Flamer
	500 // 38 Minigun
};
new NoReloadInfractions[MAX_PLAYERS],
	ShotCounter[MAX_PLAYERS],
	SkillLevel[MAX_PLAYERS];

#define MAX_RAPIDFIRE_INFRACTIONS (3)
new WeaponShotIntervals[17] = {
	160, // 22 - Colt 45
	120, // 23 - Silenced
	120, // 24 - Deagle
	800, // 25 - Shotgun
	120, // 26 - Sawed-off
	120, // 27 - Spas
	50, // 28 - UZI
	90, // 29 - MP5
	90, // 30 - AK47
	90, // 31 - M4
	70, // 32 - Tec9
	800, // 33 - Cuntgun
	900, // 34 - Sniper
	0, // 35 - Rocket launcher
	0, // 36 - Heatseeker
	0, // 37 - Flamethrower
	20, // 38 - Minigun
};
new	RapidInfractions[MAX_PLAYERS],
	LastShotTick[MAX_PLAYERS],
	LastCrouchTick[MAX_PLAYERS];
/*********************************/
new PlayerText:RaderZoneDraw[MAX_PLAYERS];
/*********************************/
enum pCar_Info
{
	_Vid,
	_Model,
	_Color0,
	_Color1
}
new pCar[MAX_PLAYERS][pCar_Info];
/********************************/
#define MAX_MUSICS 100
enum MusicBox_Info
{
	_Key,
	_Times,
	_Singer[32],
	_Name[32],
	_Link[128]
}
new MusicBox[MAX_MUSICS][MusicBox_Info];
new Iterator:MusicBox<MAX_MUSICS>;
enum pMusic_Info
{
	bool:_Playing,
	_Mode,
	_SongID,
	_Times,
	Timer:_EndTimer
}
new pMusic[MAX_PLAYERS][pMusic_Info];
new Text:MusicPlayerGui[6];
new PlayerText:pSongNameDraw[MAX_PLAYERS];
new PlayerText:pSongerDraw[MAX_PLAYERS];
new PlayerText:pSongTimeDraw[MAX_PLAYERS];
new PlayerText:pSongProgressDraw[MAX_PLAYERS];
new PlayerText:pSongModeDraw[MAX_PLAYERS];
/********************************/
#define HOSTNAME_CHANGETIME 10
new HostNameChange=0;
new HostNameChangeCount=0;
/********************************/
#define MAX_CONNECTDRAW 11
new Text:ConnectDraw[MAX_CONNECTDRAW];
/*******************************/
new bool:pFPSOpen[MAX_PLAYERS];
/*******************************/
new PlayerPlayBottonCount[MAX_PLAYERS];
/*******************************/
#define MAX_HITLIST 10
enum HitList_Info
{
	bool:_Use,
	_Line[64]
}
new HitList[MAX_PLAYERS][MAX_HITLIST][HitList_Info];
new pHitCount[MAX_PLAYERS];
new bool:pHitShow[MAX_PLAYERS];
new Text:HitListDraw[3];
new PlayerText:pHitDraw[MAX_PLAYERS][MAX_HITLIST];
/*******************************/
new Text:PickTipDraw[5];
/*******************************/
enum CarSelectGui_InFo
{
	PlayerText:_SelectDraw[7],
	_SelectID[7],
	_LookID,
	bool:_Show
};
new CarSelectGui[MAX_PLAYERS][CarSelectGui_InFo];
new Text:TempCarSelectGui[6];
/*******************************/
enum AnimList_Info
{
	_Name[24],
	_Action[24],
	Float:_fDelta,
	_loop,
	_lockx,
	_locky,
	_freeze,
	_time
};
new AnimList[][AnimList_Info] =
{
	{"DANCING","bd_clap",4.0, 1, 0, 0, 1, 0},
	{"DANCING","DAN_Down_A",4.0, 1, 0, 0, 1, 0},
	{"DANCING","DAN_Left_A",4.0, 1, 0, 0, 1, 0},
	{"DANCING","DAN_Loop_A",4.0, 1, 0, 0, 1, 0},
	{"DANCING","DAN_Right_A",4.0, 1, 0, 0, 1, 0},
	{"DANCING","DAN_Up_A",4.0, 1, 0, 0, 1, 0},
	{"DANCING","dnce_M_a",4.0, 1, 0, 0, 1, 0},
 	{"DANCING","dnce_M_b",4.0, 1, 0, 0, 1, 0},
	{"DANCING","dnce_M_c",4.0, 1, 0, 0, 1, 0},
  	{"DANCING","dnce_M_d",4.0, 1, 0, 0, 1, 0},
   	{"DANCING","dnce_M_e",4.0, 1, 0, 0, 1, 0},
	{"RAPPING","RAP_A_Loop",4.0,1,1,1,1,0},
	{"RAPPING","RAP_B_Loop",4.0,1,1,1,1,0},
	{"RAPPING","RAP_C_Loop",4.0,1,1,1,1,0},
	{"RAPPING","Laugh_01",4.0,0,0,0,0,0}/*,
    {"KISSING","Grlfrd_Kiss_01",4.0,0,0,0,0,0},
    {"KISSING","Grlfrd_Kiss_02",4.0,0,0,0,0,0},
    {"KISSING","Grlfrd_Kiss_03",4.0,0,0,0,0,0},
    {"KISSING","Playa_Kiss_01",4.0,0,0,0,0,0},
    {"KISSING","Playa_Kiss_02",4.0,0,0,0,0,0},
    {"KISSING","Playa_Kiss_03",4.0,0,0,0,0,0}*/
};
new AnimRate[MAX_PLAYERS];
new AnimNextRate[MAX_PLAYERS];
/*******************************/
new AnimationLibraries[][] =
{
	"AIRPORT", "Attractors", "BAR", "BASEBALL", "BD_FIRE", "BEACH", "benchpress", "BF_injection", "BIKED", "BIKEH", "BIKELEAP",
	"BIKES", "BIKEV", "BIKE_DBZ", "BLOWJOBZ", "BMX", "BOMBER", "BOX", "BSKTBALL", "BUDDY", "BUS", "CAMERA", "CAR", "CARRY", "CAR_CHAT",
	"CASINO", "CHAINSAW", "CHOPPA", "CLOTHES", "COACH", "COLT45", "COP_AMBIENT", "COP_DVBYZ", "CRACK", "CRIB", "DAM_JUMP", "DANCING",
	"DEALER", "DILDO", "DODGE", "DOZER", "DRIVEBYS", "FAT", "FIGHT_B", "FIGHT_C", "FIGHT_D", "FIGHT_E", "FINALE", "FINALE2", "FLAME",
	"Flowers", "FOOD", "Freeweights", "GANGS", "GHANDS", "GHETTO_DB", "goggles", "GRAFFITI", "GRAVEYARD", "GRENADE", "GYMNASIUM", "HAIRCUTS",
	"HEIST9", "INT_HOUSE", "INT_OFFICE", "INT_SHOP", "JST_BUISNESS", "KART", "KISSING", "KNIFE", "LAPDAN1", "LAPDAN2", "LAPDAN3", "LOWRIDER",
	"MD_CHASE", "MD_END", "MEDIC", "MISC", "MTB", "MUSCULAR", "NEVADA", "ON_LOOKERS", "OTB", "PARACHUTE", "PARK", "PAULNMAC", "ped", "PLAYER_DVBYS",
	"PLAYIDLES", "POLICE", "POOL", "POOR", "PYTHON", "QUAD", "QUAD_DBZ", "RAPPING", "RIFLE", "RIOT", "ROB_BANK", "ROCKET", "RUSTLER", "RYDER",
	"SCRATCHING", "SHAMAL", "SHOP", "SHOTGUN", "SILENCED", "SKATE", "SMOKING", "SNIPER", "SPRAYCAN", "STRIP", "SUNBATHE", "SWAT", "SWEET", "SWIM",
	"SWORD", "TANK", "TATTOOS", "TEC", "TRAIN", "TRUCK", "UZI", "VAN", "VENDING", "VORTEX", "WAYFARER", "WEAPONS", "WUZI", "SAMP"
};
stock PreloadAnimLib(playerid)forex(i,sizeof(AnimationLibraries))ApplyAnimation(playerid,AnimationLibraries[i],"null",0.0,0,0,0,0,0);
/*******************************/
main()
{
	print("\n----------------------------------");
	print(""SERVER_MAPNAME"-"SERVER_OWNER"");
	print("----------------------------------\n");
    new body[128];
	format(body,sizeof(body),"hostname "SERVER_HOSTNAME1"");
	SendRconCommand(body);
	format(body,sizeof(body),"gamemodetext "SERVER_GAMETEXT"");
	SendRconCommand(body);
	format(body,sizeof(body),"mapname "SERVER_MAPNAME"");
	SendRconCommand(body);
	format(body,sizeof(body),"weburl "SERVER_WEBURL"");
	SendRconCommand(body);
	format(body,sizeof(body),"language "SERVER_LANGUAGE"");
	SendRconCommand(body);
}
#include Master\Object.pwn
#include Master\Language.pwn
#include Master\Function.pwn
#include Master\AC.pwn
#include Master\AntiCheat.pwn
#include Master\Easybmp.pwn
#include Master\Gui.pwn
#include InterFace\FaceMenu.pwn
#include InterFace\Team.pwn
#include InterFace\Bag.pwn
#include InterFace\Mall.pwn
#include InterFace\SpecPlayer.pwn
#include InterFace\Car.pwn
#include Master\Log.pwn
#include InterFace\Mail.pwn
#include InterFace\Friends.pwn
#include Game\Inventory.pwn
#include Game\DeathBox.pwn
#include Game\Weapon.pwn
#include Game\BodyDress.pwn
#include Game\NearBy.pwn
#include Game\PickItem.pwn
#include Game\ValuePanel.pwn
#include Game\Vehicle.pwn
#include Game\Circle.pwn
#include Game\Compass.pwn
#include Game\GameMain.pwn
#include Game\Rader.pwn
#include Game\HitList.pwn
#include Master\Timer.pwn
#include Master\ServerSet.pwn
#include Master\Accout.pwn
#include Master\Winter.pwn
#include Master\Music.pwn
/*new baseurl[] = "http://www.gtace.com/mods";
public OnPlayerRequestDownload(playerid, type, crc)
{
    
	new fullurl[256+1];
	new dlfilename[64+1];
	new foundfilename=0;

	if(!IsPlayerConnected(playerid)) return 0;

	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE) {
		foundfilename = FindTextureFileNameFromCRC(crc,dlfilename,64);
	}
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE) {
	    foundfilename = FindModelFileNameFromCRC(crc,dlfilename,64);
	}

	if(foundfilename) {
	    format(fullurl,256,"%s/%s",baseurl,dlfilename);
	    RedirectDownload(playerid,fullurl);
	    printf(fullurl);
	}

	return 0;
}*/
/*public OnPlayerFinishedDownloading(playerid, virtualworld)
{
    SCM(playerid,-1,"MOD 同步完成");
	return 1;
}*/
public OnGameModeInit()
{
	gettime(ServerHour,ServerMinute,ServerSecond);
    Iter_Init(Inventory);
    Iter_Init(PickItem);
    Iter_Init(gVehicle);
    Iter_Init(DeathBox);
    Iter_Init(pAttach);
    Iter_Init(Bag);
    Iter_Init(pFriends);
    Iter_Init(pMails);
    Iter_Init(testpos);
    GameDrawInit();
    HitListGuiInt();
    GameTipGuiInt();
    TempCarSelectGuiInt();
   	forex(i,MAX_WAITROOM_TYPES)
	{
	    WaitRoom[i][_Key]=GetTickCount();
	    WaitRoom[i][_Open]=false;
	    WaitRoom[i][_Owner]=NONE;
	    WaitRoom[i][_Weather]=random(21);
	    WaitRoom[i][_WeatherCount]=0;
	    WaitRoom[i][_WeatherChange]=Randoms(180,480);
	    
		WaitRoom[i][_Countdown]=30;
		WaitRoomAmoutPrive[i]=CreateWaitRoomAmoutDraw();
		WaitRoomCountdownPrive[i]=CreateWaitRoomCountDownDraw();
		
		WaitRoom[i][_Obj1]=INVALID_STREAMER_ID;
		WaitRoom[i][_Obj2]=INVALID_STREAMER_ID;
		WaitRoom[i][_Obj3]=INVALID_STREAMER_ID;
		WaitRoom[i][_Obj4]=INVALID_STREAMER_ID;
	}
	WaitRoom[0][_Open]=true;
	Iter_Add(WaitRoom,0);
    forex(i,MAX_LASTALIVE_GAMES)
    {
		LastAliveGame[i][_Key]=NONE;
       	forex(s,MAX_GAME_DEATHBOXS)
		{
		    DeathBox[i][s][_Type]=BOX_TYPE_NONE;
		    DeathBox[i][s][_Owner]=NONE;
			forex(j,MAX_GAME_DEATHBOX_THINGS)
			{
			    DeathBox[i][s][_Key][j]=NONE;
			    DeathBox[i][s][_ItemID][j]=NONE;
			    DeathBox[i][s][_Amout][j]=0;
			    DeathBox[i][s][_Ammo][j]=0;
			    DeathBox[i][s][_Durable][j]=0.0;
			}
			DeathBox[i][s][_x]=0.0;
			DeathBox[i][s][_y]=0.0;
			DeathBox[i][s][_z]=0.0;
			DeathBox[i][s][_rx]=0.0;
			DeathBox[i][s][_ry]=0.0;
			DeathBox[i][s][_rz]=0.0;
			DeathBox[i][s][_Interior]=0;
			DeathBox[i][s][_Obj]=INVALID_STREAMER_ID;
			DeathBox[i][s][_Area]=INVALID_STREAMER_ID;
			DeathBox[i][s][_Map]=INVALID_STREAMER_ID;
			DeathBox[i][s][_Text]=Text3D:INVALID_STREAMER_ID;
			DeathBox[i][s][_Draw]=Text:INVALID_TEXT_DRAW;
		}
       	forex(s,MAX_GAME_CIRCLE_POS)
		{
 			forex(j,MAX_GAME_CIRCLE_POS)
			{
		    	ToxicCircleStartPosA[i][s][j]=ToxicCircleStartPos[s][j];
		    }
		}
        forex(s,MAX_GAME_CIRCLE_POS)
		{
			GameToxicCircle[i][s][_GangZoneID]=INVALID_GANG_ZONE;
			GameSafeCircle[i][s][_GangZoneID]=INVALID_GANG_ZONE;
			forex(k,MAX_GAME_CIRCLE_POS)SafeCircleStaticStartPos[i][s][k]=0.0;
		}
		LastAliveGame[i][Timer:_Wait]=NONE;
		LastAliveGame[i][Timer:_Nontox]=NONE;
		LastAliveGame[i][Timer:_Safe]=NONE;
		LastAliveGame[i][_Type]=LASTALIVE_TYPE_NONE;
		LastAliveGame[i][_State]=LASTALIVE_STATE_NONE;
		LastAliveGame[i][_Round]=LASTALIVE_ROUND_NONE;
		LastAliveGame[i][_TimeLine]=0;
		LastAliveGame[i][_SafeLine]=NONE;
		
		LastAliveGame[i][_SafeAmout]=0.0;
		LastAliveGame[i][_NontoxAmout]=0;
		LastAliveGame[i][_WaitTimeLine]=0;
		LastAliveGame[i][_Rate]=0;
		LastAliveGame[i][_RoundTimes]=0;
        LastAliveGame[i][_MaxPlayers]=0;
        LastAliveGame[i][_ZoneShow]=false;
        LastAliveGame[i][_Ready]=false;
        
        LastAliveGame[i][_Weather_ID]=0;
        LastAliveGame[i][_Weather_Count]=0;
        LastAliveGame[i][_AirBox_Count]=0;
        
		LastAliveGame[i][_NontoxicZone]=INVALID_GANG_ZONE;
		LastAliveGame[i][_NontoxicMinX]=0.0;
		LastAliveGame[i][_NontoxicMinY]=0.0;
		LastAliveGame[i][_NontoxicMaxX]=0.0;
		LastAliveGame[i][_NontoxicMaxY]=0.0;
		LastAliveGame[i][_SafeZone]=INVALID_GANG_ZONE;
		LastAliveGame[i][_SafeMinX]=0.0;
		LastAliveGame[i][_SafeMinY]=0.0;
		LastAliveGame[i][_SafeMaxX]=0.0;
		LastAliveGame[i][_SafeMaxY]=0.0;
		
		forex(s,MAX_PICKITEM)
		{
			LastAliveGame[i][_PickItem_MapIcon][s]=INVALID_STREAMER_ID;
			LastAliveGame[i][_PickItem_MapAmout][s]=0;
		}
		LastAliveGame[i][_Npc_Driver_ID]=INVALID_PLAYER_ID;
		LastAliveGame[i][_Plane_ID]=INVALID_VEHICLE_ID;
		LastAliveGame[i][_Plane_Flying]=false;
	    LastAliveGame[i][_Plane_Draw]=Text:INVALID_TEXT_DRAW;
        LastAliveGame[i][_Alive_Draw]=CreateGameAliveDraw();
		LastAliveGame[i][_SmallMap_Toxic_Circle]=Text:INVALID_TEXT_DRAW;
		LastAliveGame[i][_SmallMap_Safe_Circle]=Text:INVALID_TEXT_DRAW;

        LastAliveGame[i][_Time_Line_Warn]=0;
		LastAliveGame[i][_Time_Line_Time_Draw]=CreateGameTimeLineTimeDraw();
		LastAliveGame[i][_LeftPlayer_Draw]=CreateLeftPlayerDraw();
		LastAliveGame[i][Timer:_LeftPlayer_Timer]=NONE;
		

        forex(s,MAX_GAME_VEHICLE)
        {
        	gVehicle[i][s][_VehicleID]=INVALID_VEHICLE_ID;
        	gVehicle[i][s][_VehicleKey]=0;
        	gVehicle[i][s][_VehicleEngine]=false;
        	gVehicle[i][s][_VehicleFuel]=0.0;
        }
        forex(s,MAX_PICKITEM)
        {
	        PickItem[i][s][_Obj]=INVALID_STREAMER_ID;
	        PickItem[i][s][_Text]=Text3D:INVALID_STREAMER_ID;
	        PickItem[i][s][_Area]=INVALID_STREAMER_ID;
        }
        
		forex(s,MAX_WALL)
		{
		    LastAliveGame[i][Wall0][s]=INVALID_STREAMER_ID;
		    LastAliveGame[i][Wall1][s]=INVALID_STREAMER_ID;
		    LastAliveGame[i][Wall2][s]=INVALID_STREAMER_ID;
		    LastAliveGame[i][Wall3][s]=INVALID_STREAMER_ID;
		}
    }
	forex(i,MAX_PLAYERS)
	{
	    pLastAlive[i][_Game_Id]=NONE;
	    pLastAlive[i][_Game_CountDown]=0;
	    pLastAlive[i][_Game_In]=false;
	    pLastAlive[i][_Game_Death]=false;
	    pLastAlive[i][_Game_SpectatePlane]=false;
	    pLastAlive[i][_Game_PlaneDown]=false;
	    pLastAlive[i][_Game_Kills]=0;
	    pLastAlive[i][_Game_Deaths]=0;
	    pLastAlive[i][_Game_BagVol]=20;
	    pLastAlive[i][_Game_Kill_Draw]=PlayerText:INVALID_TEXT_DRAW;
	    pLastAlive[i][_Show_SmallMap]=false;
	    pLastAlive[i][_Small_Arrow_Draw]=PlayerText:INVALID_TEXT_DRAW;
	    pLastAlive[i][_Time_Line_Person_Draw]=PlayerText:INVALID_TEXT_DRAW;
	    pLastAlive[i][Timer:LeaveTimer]=NONE;
	    
	    forex(s,MAX_PLAYER_BODY_SLOT_DRAW)
		{
		    pLastAliveBodyDress[i][_Body_Dress_Item][s]=NONE;
		    pLastAliveBodyDress[i][_Body_Dress_Durable][s]=0.0;
			pLastAliveBodyDress[i][_Body_Dress_Draw][s]=PlayerText:INVALID_TEXT_DRAW;
		}
	    forex(s,MAX_INVENTORY_SHOW_LIST)
	    {
			InventoryModelDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
			InventoryBackGround[i][s]=PlayerText:INVALID_TEXT_DRAW;
			InventoryNameTag[i][s]=PlayerText:INVALID_TEXT_DRAW;
			InventoryItemAmout[i][s]=PlayerText:INVALID_TEXT_DRAW;
	    }
	    forex(s,MAX_PLAYER_WEAPON_SLOT_DRAW)
	    {
	        pLastAliveHandWeapon[i][_Hand_Weapon_Item][s]=NONE;
		    pLastAliveHandWeapon[i][_Hand_Name_Draw][s]=PlayerText:INVALID_TEXT_DRAW;
		    pLastAliveHandWeapon[i][_Hand_NameTag_Draw][s]=PlayerText:INVALID_TEXT_DRAW;
		    pLastAliveHandWeapon[i][_Hand_Model_Draw][s]=PlayerText:INVALID_TEXT_DRAW;
		    pLastAliveHandWeapon[i][_Hand_Ammo_Draw][s]=PlayerText:INVALID_TEXT_DRAW;
	    }
		InventorySliderBarBackGround[i]=PlayerText:INVALID_TEXT_DRAW;
		InventorySliderBar[i]=PlayerText:INVALID_TEXT_DRAW;
		InventorySliderBarButtonBack[i]=PlayerText:INVALID_TEXT_DRAW;
		InventorySliderBarButtonNext[i]=PlayerText:INVALID_TEXT_DRAW;
		
		InventoryUseItemBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		InventoryDropItemBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		forex(s,MAX_INVENTORY_BOX_ITEMS)InventoryPrevieBox[i][s]=0;
		forex(s,MAX_INVENTORY_BOX_ITEMS)InventoryPrevieBoxKey[i][s]=0;
		InventoryPrevieCount[i]=0;
		InventoryPreviePage[i]=0;
		InventoryPrevieRate[i]=0;
		InventoryClickID[i]=NONE;
		PlayerInvShow[i]=false;
		
  		forex(s,MAX_NEARBY_SHOW_LIST)
	    {
			NearByModelDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
			NearByBackGround[i][s]=PlayerText:INVALID_TEXT_DRAW;
			NearByNameTag[i][s]=PlayerText:INVALID_TEXT_DRAW;
			NearByItemAmout[i][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		NearByBackBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		NearByNextBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		NearByPage[i]=PlayerText:INVALID_TEXT_DRAW;
		
		forex(s,MAX_NEARBY_BOX_ITEMS)NearByPrevieBox[i][s]=0;
		forex(s,MAX_NEARBY_BOX_ITEMS)NearByPrevieBoxKey[i][s]=0;
		NearByPrevieCount[i]=0;
		NearByPreviePage[i]=0;
		NearByPrevieRate[i]=0;
		NearByClickID[i]=NONE;

		forex(s,MAX_MALL_BOX_ITEMS)MallPrevieBox[i][s]=0;
		MallPrevieCount[i]=0;
		MallPreviePage[i]=0;
		MallPrevieRate[i]=0;
		MallPrevieType[i]=0;
		MallClickID[i]=NONE;
		forex(s,MAX_MALL_SHOW_LIST)
		{
			PlayerMallModelDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerMallBackGround[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerMallName[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerMallPriceIcon[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerMallPrice[i][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		PlayerMallSliderBar[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallBottonUp[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallBottonDown[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerMallMyMoney[i]=PlayerText:INVALID_TEXT_DRAW;

		forex(s,MAX_DEATHBOX_BOX_ITEMS)
		{
			DeathBoxPrevieBox[i][s]=0;
			DeathBoxPrevieBoxKey[i][s]=NONE;
		}
		DeathBoxPrevieCount[i]=0;
		DeathBoxPreviePage[i]=0;
		DeathBoxPrevieRate[i]=0;
		DeathBoxClickID[i]=NONE;
		forex(s,MAX_DEATHBOX_SHOW_LIST)
		{
			DeathBoxModelDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
			DeathBoxBackGround[i][s]=PlayerText:INVALID_TEXT_DRAW;
			DeathBoxInfo[i][s]=PlayerText:INVALID_TEXT_DRAW;
			DeathBoxUseIcon[i][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		DeathBoxSliderBar[i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxBottonUp[i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxBottonDown[i]=PlayerText:INVALID_TEXT_DRAW;
		DeathBoxTag[i]=PlayerText:INVALID_TEXT_DRAW;
        PlayerDeathBoxID[i]=NONE;
        
        forex(s,MAX_PLAYERBAG_BOX_ITEMS)
		{
			PlayerBagPrevieBox[i][s]=0;
			PlayerBagPrevieBoxKey[i][s]=NONE;
		}
		PlayerBagPrevieCount[i]=0;
		PlayerBagPreviePage[i]=0;
		PlayerBagPrevieRate[i]=0;
		PlayerBagPrevieType[i]=0;
		PlayerBagClickID[i]=NONE;
		forex(s,MAX_PLAYERBAG_SHOW_LIST)
		{
			PlayerBagModelDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerBagBackGround[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerBagName[i][s]=PlayerText:INVALID_TEXT_DRAW;
			PlayerBagAmount[i][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		PlayerBagSliderBar[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagBottonUp[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagBottonDown[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBagCapacity[i]=PlayerText:INVALID_TEXT_DRAW;

		

		pBodyArmorModelDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pBodyArmorTextDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pBodyCapModelDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pBodyCapTextDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pHealthBar[i]=PlayerText:INVALID_TEXT_DRAW;
		pBuffBar[i]=PlayerText:INVALID_TEXT_DRAW;
		pCacheBar[i]=PlayerText:INVALID_TEXT_DRAW;
		pWeaponModel[i]=PlayerText:INVALID_TEXT_DRAW;
		pWeaponAmoutText[i]=PlayerText:INVALID_TEXT_DRAW;
		
		PlayerSpeedoMetersDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerSpeedoArrowDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerSpeedoBarDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerSpeedoFuelBarDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		
		pGameOverChicken[i]=PlayerText:INVALID_TEXT_DRAW;
		pGameOverTeamRank[i]=PlayerText:INVALID_TEXT_DRAW;
		pGameOverKills[i]=PlayerText:INVALID_TEXT_DRAW;
		pGameOverNumber[i]=PlayerText:INVALID_TEXT_DRAW;
		pGameOverReward[i]=PlayerText:INVALID_TEXT_DRAW;
		pGameOverTimeLeft[i]=PlayerText:INVALID_TEXT_DRAW;

		PlayerBoxBackDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBoxModelDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBoxTagDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		PlayerBoxCloseDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		forex(s,MAX_PLAYER_GIFTS)
		{
		    PlayerBoxGiftDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
		    PlayerBoxGiftTextDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
		    PlayerBoxGift[i][s]=NONE;
		}

		Timer:TurnOnEngineTimer[i]=NONE;
		
  		LastTimeWeapon[i]=0;
  		forex(s,12)LastTimeAmmo[i][s]=0;
  		
  		PauseTime[i]=0;

		LastTimeAnimIndex[i]=0;
		HideAttach[i]=false;

  		pBuffID[i]=NONE;
		pBuffCount[i]=0;
		pCacheID[i]=NONE;
		pCacheCount[i]=0;
		
		pCBugging[i]=false;
		Timer:pCBugFreezeOver[i]=NONE;
		pLastFiredWeaponTick[i]=0;

		pRotCam[i][_X]= SpawnScenes[0][_X];
		pRotCam[i][_Y]= SpawnScenes[0][_Y];
		pRotCam[i][_Z]= SpawnScenes[0][_Z];
		pRotCam[i][_A]= SpawnScenes[0][_A];
		
		pRotCam[i][_Radius]= 6.0;//4.0
		pRotCam[i][_Speed]= 0.3;
		pRotCam[i][_Height]= 1.0;
		pRotCam[i][_Degree]=0.0;
		pRotCam[i][_Moving]=false;
		pRotCam[i][Timer:_Timer]=NONE;
		
		Timer:PlayerConnectPosChange[i]=NONE;
		
		PlayerInState[i]=PLAYER_IN_NULL;
		PlayerInStateID[i]=NONE;
		
		PlayerDamageDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		Timer:PlayerDamageTimer[i]=NONE;
		PlayerDamageAmout[i]=0;
		
		PlayerModeTeam[i][_Mode]=0;

		forex(s,3)PlayerModeTeam[i][_Team_Key][s]=NONE;
		forex(s,MAX_PLAYER_FACE_MODE_DRAWS)PlayerFaceModeMenu[i][s]=PlayerText:INVALID_TEXT_DRAW;
		forex(s,MAX_PLAYER_FACE_TEAM_DRAWS)PlayerFaceTeamMenu[i][s]=PlayerText:INVALID_TEXT_DRAW;
		FaceMenuCdsDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		FaceMenuLevelDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		FaceMenuTimeDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		FaceMenuOnlineCountDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		
		FriendsBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		MailsBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		OthersBotton[i]=PlayerText:INVALID_TEXT_DRAW;
		
		PlayerNameTag[i]=Text3D:INVALID_STREAMER_ID;
		PlayerAfkTag[i]=Text3D:INVALID_STREAMER_ID;
		LastPauseTime[i]=0;
		LastState[i]=PLAYER_IN_NULL;
		
		pTeam[i]=NONE;
		
		forex(s,MAX_UICOMPASS_TD)pCompassDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
		CompassDirection[i]=NONE;
		
		pSpectateID[i]=INVALID_PLAYER_ID;
		
		forex(s,MAX_PLAYER_SIGN)
		{
			PlayerBodySignature[i][s]=Text3D:INVALID_STREAMER_ID;
			PlayerGroundSignature[i][s]=Text3D:INVALID_STREAMER_ID;
		}
		
	 	NoReloadInfractions[i]=0;
		ShotCounter[i]=0;
		SkillLevel[i]=999;
		RapidInfractions[i]=0;
		LastShotTick[i]=0;
		LastCrouchTick[i]=0;
		
		RaderZoneDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		
		pCar[i][_Vid]=INVALID_VEHICLE_ID;
		pCar[i][_Model]=0;
		pCar[i][_Color0]=random(255);
		pCar[i][_Color1]=random(255);
		
		pMusic[i][_Playing]=false;
		pMusic[i][_Mode]=0;
		pMusic[i][_SongID]=0;
		pMusic[i][Timer:_EndTimer]=NONE;
		pMusic[i][_Times]=0;
		pSongNameDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pSongerDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pSongTimeDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pSongProgressDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		pSongModeDraw[i]=PlayerText:INVALID_TEXT_DRAW;
		
		pFPSOpen[i]=true;
		
		PlayerPlayBottonCount[i]=0;

		forex(s,MAX_HITLIST)
		{
		    HitList[i][s][_Use]=false;
		    format(HitList[i][s][_Use],128," ");
		    pHitDraw[i][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		pHitCount[i]=NONE;
		pHitShow[i]=false;
		
		forex(s,7)
		{
			CarSelectGui[i][_SelectID][s]=NONE;
			CarSelectGui[i][_SelectDraw][s]=PlayerText:INVALID_TEXT_DRAW;
		}
		CarSelectGui[i][_LookID]=0;
		CarSelectGui[i][_Show]=false;
		
		AnimRate[i]=0;
		AnimNextRate[i]=0;
	}
	Tryg3D::SafeMapAndreasInit(MAP_ANDREAS_MODE_FULL);
	Tryg3D::SafeColAndreasInit();
	
    UsePlayerPedAnims();
	SetDamageFeed(false);
	SetDamageSounds(0, 0);
	SetCbugAllowed(false);
	SetCustomVendingMachines(false);
	SetVehiclePassengerDamage(true);
	SetVehicleUnoccupiedDamage(true);
    SetDisableSyncBugs(true);
    EnableVehicleFriendlyFire();
    DisableInteriorEnterExits();
 	EnableStuntBonusForAll(0);
    ManualVehicleEngineAndLights();
    ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	LimitPlayerMarkerRadius(10000.0);
	Streamer_SetCellDistance(1000.0);
	ShowNameTags(0);

    FCNPC_SetUpdateRate(20);
    
    Timer:ScondUpdate=SetTimer("_ScondUpdateTimer",1000,true);
	Timer:100msUpdate=SetTimer("_200msUpdateTimer",200,true);
    Timer:500msUpdate=SetTimer("_500msUpdateTimer",500,true);
    
    FaceMenu@OnGameModeInit();
    Bag@OnGameModeInit();
    Language@OnGameModeInit();
    Account@OnGameModeInit();
    Log_OnGameModeInit();
	AC_OnGameModeInit();
	ServerSet@OnGameModeInit();
    CreateFaceMenuScenes();
    CreateWaitRoomScenes();
    MusicPlayerGuiInt();
    
	new ticktime=GetTickCount();
   	new Float:randx,Float:randy,Float:randz;
	forex(s,MAX_TESTPOS)
	{
	    Iter_Clear(testpos[s]);
	    forex(i,MAX_GAME_VEHICLE)
		{
	        randx=frandoms(2950,-2950);
			randy=frandoms(2950,-2950);
			Tryg3D::MapAndreasFindZ(randx,randy,randz);
	        while(!IsPointInGround(randx,randy,randz)||SearchInRange(s,randx,randy,200.0))
	        {
		        randx=frandoms(2950,-2950);
				randy=frandoms(2950,-2950);
	        	Tryg3D::MapAndreasFindZ(randx,randy,randz);
	        }
	        testpos[s][i][_testx]=randx;
	        testpos[s][i][_testy]=randy;
	        testpos[s][i][_testz]=randz;
	        Iter_Add(testpos[s],i);
	    }
    }
    printf("汽车坐标采集时间: %i 耗秒",GetTickCount()-ticktime);
    CreateWinterInArea(-2984.0, -2970.0, -1221.0, -908.0);
    
    SeverState[_ServerRun]=true;
    //CreateWinterInArea(-2968.0,-2970.0,42.0,-918.0);
	return 1;
}
N::SearchInRange(index,Float:xx,Float:yy,Float:range)
{
	if(Iter_Count(testpos[index])>0)
	{
	    foreach(new i:testpos[index])
	    {
	        new Float:distancez=GetDistanceBetweenPoints2D(testpos[index][i][_testx],testpos[index][i][_testy],xx,yy);
	        if(distancez<range)return 1;
	    }
    }
    else return 0;
	return 0;
}
public OnGameModeExit()
{
    SeverState[_ServerRun]=false;
	KillTimer(Timer:ScondUpdate);
	KillTimer(Timer:100msUpdate);
	KillTimer(Timer:500msUpdate);
	AC_OnGameModeExit();
	return 1;
}
public OnPlayerRequestClass(playerid,classid)
{
    //printf("OnPlayerRequestClass");
    if(Account[playerid][_Login]==false)
    {
	    TogglePlayerSpectating(playerid,true);
	    PlayerConnectPosChange(playerid);
	    Account@GetAccountInfo(playerid);
		SetPlayerTime(playerid,ServerHour,ServerMinute);
    	SetPlayerWeather(playerid,random(21));
    }
    else 
    {
        //GameMain_OnPlayerSpawn(playerid);
        if(PlayerInState[playerid]==PLAYER_IN_GAMEROOM)
	    {
		    if(pGameID(playerid)!=NONE&&pGameIn(playerid)==true)
		    {
		        DalayLeaveLastAliveGame(playerid,pGameIn(playerid));
		    }
	    }
    }
	return 1;
}
public OnPlayerRequestSpawn(playerid)
{
    printf("OnPlayerRequestSpawn");
 	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(Dialog@GetIndex(playerid)!=dialogid)
	{
      	fLine_256(ReturnMLStr(pLang(playerid),_DIALOG_ERROR));
       	SCM(playerid,-1,line);
		format(line,sizeof(line),"%s 可能使用对话框作弊[%i - %i]",Account[playerid][_Name],Dialog@GetIndex(playerid),dialogid);
        printf(line);
	    return 1;
	}
	Dialog@Rest(playerid);
    switch(dialogid)
    {
		case _TEST_ENTER:
		{
		    if(!response)return SetTimerEx("DelayKicke",100,false,"i",playerid);
		    new Query[128];
			format(Query, sizeof(Query), "SELECT * FROM `"MYSQL_DB_USER"` WHERE `名字` = '%s' LIMIT 1",Account[playerid][_Name]);
			mysql_query(User@Handle,Query,true);
			new code=cache_get_field_content_int(0,"测试码",User@Handle);
			if(strval(inputtext)==code)
			{
			    new line[128];
			    format(line,sizeof(line),ReturnMLStr(pLang(playerid),_LOGIN_BODY),Account[playerid][_Name],cache_get_field_content_int(0,"编号",User@Handle));
			    Dialog@Show(playerid,_LOGIN,DIALOG_STYLE_PASSWORD,ReturnMLStr(pLang(playerid),_LOGIN_TITLE),line,ReturnMLStr(pLang(playerid),_LOGIN_BOTTON1),ReturnMLStr(pLang(playerid),_LOGIN_BOTTON2));
				SCM(playerid,-1,ReturnMLStr(pLang(playerid),_COME_IN_MSG1));
			}
			else
			{
			    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEST_MSG2));
				SetTimerEx("DelayKicke",100,false,"i",playerid);
			}
		}
        case _LOGIN://登录对话框
        {
    		if(!response)return SetTimerEx("DelayKicke",100,false,"i",playerid);
    		FormatEx(inputtext,128);
    		SHA256_PassHash(inputtext,PASSWORD_SALT,String,128);
		    new Query[128];
			format(Query, sizeof(Query), "SELECT * FROM `"MYSQL_DB_USER"` WHERE `名字` = '%s' LIMIT 1",Account[playerid][_Name]);
			mysql_query(User@Handle,Query,true);
			new TempPassWord[128];
			cache_get_field_content(0,"密码",TempPassWord,User@Handle,128);
			
			if(!strcmp(String,TempPassWord,false))
			{
				Account[playerid][_Key]=cache_get_field_content_int(0,"编号",User@Handle);
				cache_get_field_content(0,"密码",Account[playerid][_Password],User@Handle,128);
				Account[playerid][_Language]=cache_get_field_content_int(0,"语言",User@Handle);
				Account[playerid][_Skin]=cache_get_field_content_int(0,"皮肤",User@Handle);
				Account[playerid][_Gold]=cache_get_field_content_int(0,"金币",User@Handle);
				Account[playerid][_SceneID]=cache_get_field_content_int(0,"主界面场景",User@Handle);
				Account[playerid][_SceneRot]=cache_get_field_content_int(0,"主界面旋转",User@Handle);
				Account[playerid][_NameColor]=cache_get_field_content_int(0,"名字颜色",User@Handle);
				Account[playerid][_Mute]=cache_get_field_content_int(0,"禁言期限",User@Handle);
				Account[playerid][_TestCode]=cache_get_field_content_int(0,"测试码",User@Handle);
				Account[playerid][_Level]=cache_get_field_content_int(0,"等级",User@Handle);
				Account[playerid][_Exp]=cache_get_field_content_int(0,"经验",User@Handle);
				Account[playerid][_SignID]=cache_get_field_content_int(0,"表情",User@Handle);
				if(Account[playerid][_SignID]!=0)pRotCam[playerid][_Radius]= 6.0;
				else pRotCam[playerid][_Radius]= 4.0;
				
				pRotCam[playerid][_X]= SpawnScenes[pScene(playerid)][_X];
				pRotCam[playerid][_Y]= SpawnScenes[pScene(playerid)][_Y];
				pRotCam[playerid][_Z]= SpawnScenes[pScene(playerid)][_Z];
				pRotCam[playerid][_A]= SpawnScenes[pScene(playerid)][_A];

				Hooks("OnAccountLoginGame","i",playerid);
			}
			else Dialog@Show(playerid,_LOGIN,DIALOG_STYLE_PASSWORD,ReturnMLStr(pLang(playerid),_LOGIN_ERROR_TITLE),ReturnMLStr(pLang(playerid),_LOGIN_ERROR_BODY),ReturnMLStr(pLang(playerid),_LOGIN_BOTTON1),ReturnMLStr(pLang(playerid),_LOGIN_BOTTON2));
		}
        case _REG://注册对话框
        {
		    if(!response)return SetTimerEx("DelayKicke",100,false,"i",playerid);
			if(strlen(inputtext)<6||strlen(inputtext)>15)return Dialog@Show(playerid,_REG, DIALOG_STYLE_INPUT,ReturnMLStr(pLang(playerid),_REG_ERROR_TITLE),ReturnMLStr(pLang(playerid),_REG_ERROR_BODY),ReturnMLStr(pLang(playerid),_REG_BOTTON1),ReturnMLStr(pLang(playerid),_REG_BOTTON2));
		    SHA256_PassHash(inputtext,PASSWORD_SALT,Account[playerid][_Password],128);
		    Account[playerid][_Language]=GetPVarInt(playerid,"pLang");
		    Account[playerid][_Skin]=Randoms(1,5);
		    Account[playerid][_Gold]=0;
		    Account[playerid][_SceneID]=random(sizeof(SpawnScenes));
		    Account[playerid][_SceneRot]=1;
		    Account[playerid][_NameColor]=0;
		    Account[playerid][_Mute]=0;
		    Account[playerid][_TestCode]=Randoms(1000,100000);
			Account[playerid][_Level]=0;
			Account[playerid][_Exp]=0;
			Account[playerid][_SignID]=0;
			pRotCam[playerid][_Radius]= 4.0;
			
			pRotCam[playerid][_X]= SpawnScenes[pScene(playerid)][_X];
			pRotCam[playerid][_Y]= SpawnScenes[pScene(playerid)][_Y];
			pRotCam[playerid][_Z]= SpawnScenes[pScene(playerid)][_Z];
			pRotCam[playerid][_A]= SpawnScenes[pScene(playerid)][_A];
			
			new Query[1024];
			format(Query, sizeof(Query),\
			"INSERT INTO `"MYSQL_DB_USER"` (\
			`名字`,\
			`密码`,\
			`语言`,\
			`皮肤`,\
			`主界面场景`,\
			`测试码`\
			)\
			VALUES\
			('%s','%s','%i','%i','%i','%i')",\
			Account[playerid][_Name],Account[playerid][_Password],Account[playerid][_Language],Account[playerid][_Skin],Account[playerid][_SceneID],Account[playerid][_TestCode]);
			mysql_query(User@Handle,Query,true);
			Account[playerid][_Key]=cache_insert_id();
			/*SCM(playerid,-1,ReturnMLStr(pLang(playerid),_TEST_MSG1));
			SetTimerEx("DelayKicke",100,false,"i",playerid);*/
		    Hooks("OnAccountLoginGame","i",playerid);
        }
        case _MALL_BUY:
        {
            if(response)
            {
				new index=GetPVarInt(playerid,"_ClickMallItem");
			    if(Account[playerid][_Gold]>=MallItem[MallPrevieBox[playerid][index]][_Price])
			    {
			        if(AddItemToPlayerBag(playerid,MallPrevieBox[playerid][index],1)==BAG_SUCCESS)
			        {
			        	Account[playerid][_Gold]-=MallItem[MallPrevieBox[playerid][index]][_Price];
			        	Update@AccountGold(playerid,Account[playerid][_Gold]);
			        	UpdateGoldDraw(playerid,Account[playerid][_Gold]);
			        	fLine_256(ReturnMLStr(pLang(playerid),_MALL_MSG3),MallItem[MallPrevieBox[playerid][index]][_Name]);
			        	SCM(playerid,-1,line);
			        }
			        else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MALL_MSG2));
			    }
			    else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MALL_MSG1));
            }
        }
        case _BAG_USE:
        {
            if(response)
            {
                new index=GetPVarInt(playerid,"_PlayerBagItem");
			    if(Iter_Contains(Bag[playerid],PlayerBagPrevieBox[playerid][index]))
			    {
					if(PlayerBagPrevieBoxKey[playerid][index]==Bag[playerid][PlayerBagPrevieBox[playerid][index]][_Key])
			  		{
		                switch(listitem)
		                {
		                    case 0:
		                    {
					  		    switch(MallItem[Bag[playerid][PlayerBagPrevieBox[playerid][index]][_ItemID]][_Type])
					  		    {
					  		        case TYPE_SKIN:
					  		        {
							        	fLine_128(ReturnMLStr(pLang(playerid),_BAG_MSG1),MallItem[PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])][_Name]);
							        	SCM(playerid,-1,line);
							  		    Account[playerid][_Skin]=MallItem[PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])][_Model];
							  		    SetPlayerSkin(playerid,Account[playerid][_Skin]);
							  		    Update@AccountSkin(playerid,Account[playerid][_Skin]);
							  		    DelPlayerBagByIndex(playerid,PlayerBagPrevieBox[playerid][index],1);
							  		    RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
					  		        }
					  		        case TYPE_ADORN:
					  		        {
		                                if(AddAttachForPlayer(playerid,PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])))
		                                {
							  		    	DelPlayerBagByIndex(playerid,PlayerBagPrevieBox[playerid][index],1);
							  		    	RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
							  		    }
							  		    else
							  		    {
							  		        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ATTACH_MSG1));
											Dialog@Show(playerid,_ATTACH_MANAGE,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ATTACH_DIALOG1),ReturnPlayerAttachList(playerid),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG3),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG4));
							  		    }
					  		        }
					  		        case TYPE_BOX:
					  		        {
					  		            SCM(playerid,-1,ReturnMLStr(pLang(playerid),_BOX_GIFT_MSG1));
					  		            OpenGiftBox(playerid,MallItem[PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])][_Extra2],PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index]));
					  		            DelPlayerBagByIndex(playerid,PlayerBagPrevieBox[playerid][index],1);
					  		            RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
					  		        }
					  		    }
							}
							case 1:
							{
							    new itemid=PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index]);
			  		    		DelPlayerBagByIndex(playerid,PlayerBagPrevieBox[playerid][index],1);
				  		    	RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
				  		    	fLine_128(ReturnMLStr(pLang(playerid),_BAG_MSG2),MallItem[itemid][_Name]);
                                SCM(playerid,-1,line);
							}
						}
			  		}
				}
            }
        }
        case _ATTACH_MANAGE:
        {
            if(response)
            {
            	SetPVarInt(playerid,"_RemoveAttachID",listitem);
                Dialog@Show(playerid,_ATTACH_DROP,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_ATTACH_DROP_DIALOG1),ReturnMLStr(pLang(playerid),_ATTACH_DROP_DIALOG2),ReturnMLStr(pLang(playerid),_ATTACH_DROP_DIALOG3),ReturnMLStr(pLang(playerid),_ATTACH_DROP_DIALOG4));
            }
        }
		case _ATTACH_DROP:
		{
            if(response)
            {
                new AttachID=GetPVarInt(playerid,"_RemoveAttachID");
                RemoveAttachForPlayer(playerid,AttachID);
                new index=GetPVarInt(playerid,"_PlayerBagItem");
			    if(Iter_Contains(Bag[playerid],PlayerBagPrevieBox[playerid][index]))
			    {
					if(PlayerBagPrevieBoxKey[playerid][index]==Bag[playerid][PlayerBagPrevieBox[playerid][index]][_Key])
			  		{
			  		    switch(MallItem[Bag[playerid][PlayerBagPrevieBox[playerid][index]][_ItemID]][_Type])
			  		    {
			  		        case TYPE_ADORN:
			  		        {
                                if(AddAttachForPlayer(playerid,PlayerBagItemID(playerid,PlayerBagPrevieBox[playerid][index])))
                                {
                                    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ATTACH_MSG2));
					  		    	DelPlayerBagByIndex(playerid,PlayerBagPrevieBox[playerid][index],1);
					  		    	RefreshPlayerBagPrevie(playerid,PlayerBagPreviePage[playerid],PlayerBagPrevieType[playerid]);
					  		    }
					  		    else
					  		    {
					  		        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_ATTACH_MSG1));
									Dialog@Show(playerid,_ATTACH_MANAGE,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ATTACH_DIALOG1),ReturnPlayerAttachList(playerid),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG3),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG4));
					  		    }
			  		        }
			  		    }
			  		}
				}
            }
            else Dialog@Show(playerid,_ATTACH_MANAGE,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_ATTACH_DIALOG1),ReturnPlayerAttachList(playerid),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG3),ReturnMLStr(pLang(playerid),_ATTACH_DIALOG4));
		}
        case _MENU_CONFIG:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        fLine_256(ReturnMLStr(pLang(playerid),_MENU_SCENE2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),ReturnLanguageScenesRot(Account[playerid][_SceneRot],pLang(playerid)));
			        	Dialog@Show(playerid,_MENU_SCENE,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_SCENE1),line,ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
                    }
                    case 1:
                    {
                        fLine_256(ReturnMLStr(pLang(playerid),_MENU_LANGUAGE2),Languages[0],Languages[1]);
			        	Dialog@Show(playerid,_MENU_LANGUAGE,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_LANGUAGE1),line,ReturnMLStr(pLang(playerid),_MENU_LANGUAGE3),ReturnMLStr(pLang(playerid),_MENU_LANGUAGE4));
                    }
                    case 2:
                    {
			        	Dialog@Show(playerid,_MENU_COLOR,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_MENU_COLOR_SELECT1),ReturnPlayerColorSelectShow(playerid),ReturnMLStr(pLang(playerid),_MENU_COLOR_SELECT2),ReturnMLStr(pLang(playerid),_MENU_COLOR_SELECT3));
                    }
                    case 3:
                    {
			        	Dialog@Show(playerid,_BUY_SIGNS,DIALOG_STYLE_TABLIST_HEADERS,ReturnMLStr(pLang(playerid),_SIGN_MSG1),ShowPlayerSignatures(playerid,1),ReturnMLStr(pLang(playerid),_SIGN_MSG3),ReturnMLStr(pLang(playerid),_SIGN_MSG4));
                    }
                }
            }
        }
        case _MENU_COLOR:
        {
            if(response)
            {
				if(Account[playerid][_Gold]>=Color[listitem][_price])
			    {
		        	Account[playerid][_Gold]-=Color[listitem][_price];
		        	Account[playerid][_NameColor]=listitem;
		        	Update@AccountGold(playerid,Account[playerid][_Gold]);
		        	UpdateGoldDraw(playerid,Account[playerid][_Gold]);
		        	Update@AccountNameColor(playerid,Account[playerid][_NameColor]);
		        	SetPlayerColor(playerid,Color[listitem][_hex]);
    				fLine_64("ID:%i\n%s%s",playerid,Color[Account[playerid][_NameColor]][_hex_str],Account[playerid][_Name]);
 					UpdateDynamic3DTextLabelText(PlayerNameTag[playerid],-1,line);
		        	SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_COLOR_MSG2));
				}
				else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_COLOR_MSG1));
            }
            else
            {
		        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
		        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
            }
        }
        case _MENU_SCENE:
        {
            if(response)
            {
				switch(listitem)
                {
                    case 0:
                    {
			        	Dialog@Show(playerid,_MENU_SCENE_SELECT,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_SCENE_SELECT1),ReturnLanguageScenesNameList(pLang(playerid)),ReturnMLStr(pLang(playerid),_MENU_SCENE_SELECT2),ReturnMLStr(pLang(playerid),_MENU_SCENE_SELECT3));
                    }
                    case 1:
                    {
						if(Account[playerid][_SceneRot]==1)
						{
						    Account[playerid][_SceneRot]=0;
						    StopPlayerRotCamera(playerid,true,false);
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_SCENE_MSG2));
						}
						else
						{
						    Account[playerid][_SceneRot]=1;
						    StartPlayerRotCamera(playerid);
						    SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_SCENE_MSG1));
						}
						Update@AccountSceneRot(playerid,Account[playerid][_SceneRot]);
                        fLine_256(ReturnMLStr(pLang(playerid),_MENU_SCENE2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),ReturnLanguageScenesRot(Account[playerid][_SceneRot],pLang(playerid)));
			        	Dialog@Show(playerid,_MENU_SCENE,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_SCENE1),line,ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
                    }
				}
            }
			else
			{
		        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
		        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
			}
        }
        case _MENU_SCENE_SELECT:
        {
            if(response)
            {
                if(pScene(playerid)!=listitem)
                {
                    StopPlayerRotCamera(playerid,true,false);
                    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
                    
                    pScene(playerid)=listitem;
                    Update@AccountSceneID(playerid,pScene(playerid));
                    
		 			pRotCam[playerid][_X]= SpawnScenes[pScene(playerid)][_X];
					pRotCam[playerid][_Y]= SpawnScenes[pScene(playerid)][_Y];
					pRotCam[playerid][_Z]= SpawnScenes[pScene(playerid)][_Z];
					pRotCam[playerid][_A]= SpawnScenes[pScene(playerid)][_A];
					
		 			SetPlayerPos(playerid,pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z]);
					SetPlayerFacingAngle(playerid,pRotCam[playerid][_A]);
		    		StartPlayerRotCamera(playerid);
		    		SetPlayerWorldBounds(playerid,pRotCam[playerid][_X]+2.0,pRotCam[playerid][_X]-2.0,pRotCam[playerid][_Y]+2.0,pRotCam[playerid][_Y]-2.0);

					ShowPlayerSignature(playerid);
					
					fLine_256(ReturnMLStr(pLang(playerid),_MENU_SCENE2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),ReturnLanguageScenesRot(Account[playerid][_SceneRot],pLang(playerid)));
		        	Dialog@Show(playerid,_MENU_SCENE,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_SCENE1),line,ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
					SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_SCENE_SELECT_MSG2));
                }
                else SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_SCENE_SELECT_MSG1));
            }
            else
            {
				fLine_256(ReturnMLStr(pLang(playerid),_MENU_SCENE2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),ReturnLanguageScenesRot(Account[playerid][_SceneRot],pLang(playerid)));
	        	Dialog@Show(playerid,_MENU_SCENE,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_SCENE1),line,ReturnMLStr(pLang(playerid),_MENU_SCENE3),ReturnMLStr(pLang(playerid),_MENU_SCENE4));
            }
        }
        case _MENU_LANGUAGE:
        {
            if(response)
            {
                if(pLang(playerid)==listitem)SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_LANGUAGE_MSG1));
                else
                {
	                switch(listitem)
	                {
	                    case 0:
	                    {
							pLang(playerid)=0;
							SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_LANGUAGE_MSG2));
       					}
	                    case 1:
	                    {
	                        pLang(playerid)=1;
	                        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_MENU_LANGUAGE_MSG2));
	                    }
	                }
	                Update@AccountLanguage(playerid,pLang(playerid));
                }
		        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
		        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
           }
			else
			{
		        fLine_256(ReturnMLStr(pLang(playerid),_MENU_CONFIG2),ReturnLanguageScenesName(pScene(playerid),pLang(playerid)),Languages[pLang(playerid)],ReturnPlayerColorShow(playerid),ReturnPlayerSignName(playerid));
		        Dialog@Show(playerid,_MENU_CONFIG,DIALOG_STYLE_LIST,ReturnMLStr(pLang(playerid),_MENU_CONFIG1),line,ReturnMLStr(pLang(playerid),_MENU_CONFIG3),ReturnMLStr(pLang(playerid),_MENU_CONFIG4));
			}
        }
        case _CREDITS:
        {
            if(response)
	        {
				Dialog@Show(playerid,_UPDATE_LOG,DIALOG_STYLE_MSGBOX,ReturnMLStr(pLang(playerid),_UPDATE_DIALOG1),ReturnMLStr(pLang(playerid),_UPDATE_DIALOG2),ReturnMLStr(pLang(playerid),_UPDATE_DIALOG3),"");
            }
        }
	}
	Friend@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	Mail@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	Team@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	Easybmp@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	Music@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	Spec@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	GameMain@DialogResponse(playerid, dialogid, response, listitem, inputtext);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))return 1;
    
    PreloadAnimLib(playerid);
   	new Float:xyza[4];
   	SetsLastStop(playerid,GetTickCount());
    GetPlayerPos(playerid,xyza[0],xyza[1],xyza[2]);
	GetPlayerFacingAngle(playerid,xyza[3]);
    AntiCheat@SavePlayerPos(playerid,xyza[0],xyza[1],xyza[2],xyza[3]);
    GivePlayerAttach(playerid);
     //printf("OnPlayerSpawn0:%s",Account[playerid][_Name]);
	if(GameMain_OnPlayerSpawn(playerid))return 1;
	ResetPlayerWeapons(playerid);
	if(PlayerInState[playerid]==PLAYER_IN_WAITLEAVE)
	{
	    if(pLastAlive[playerid][_Game_Death]==true)
	    {
	        //printf("OnPlayerSpawn1:%s",Account[playerid][_Name]);
	        TogglePlayerSpectating(playerid,1);
	    }
	    else
	    {
	        //printf("OnPlayerSpawn2:%s",Account[playerid][_Name]);
	        //if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_COMEIN);
            if(pMusic[playerid][_Playing]==false)PlayerRandMusicForPlayer(playerid);
			PlayerInState[playerid]=PLAYER_IN_INTERFACE;
		    PlayerInStateID[playerid]=NONE;
			SetPlayerPos(playerid,pRotCam[playerid][_X],pRotCam[playerid][_Y],pRotCam[playerid][_Z]);
			SetPlayerFacingAngle(playerid,pRotCam[playerid][_A]);
		    TogglePlayerControllable(playerid,0);
		    ShowPlayerFaceMenu(playerid,false);
		    SetPlayerInterior(playerid,0);
		    SetPlayerVirtualWorld(playerid,PersonalRoom(playerid));
	        SetPlayerTime(playerid,ServerHour,ServerMinute);
	        SetPlayerWeather(playerid,random(21));
		    StartPlayerRotCamera(playerid);
		    SetPlayerWorldBounds(playerid,pRotCam[playerid][_X]+2.0,pRotCam[playerid][_X]-2.0,pRotCam[playerid][_Y]+2.0,pRotCam[playerid][_Y]-2.0);
            SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG1));
            SCM(playerid,-1,ReturnMLStr(pLang(playerid),_LOGIN_MSG4));
	    }
	}
 	return 1;
}
public OnPlayerConnect(playerid)
{
    if(IsPlayerNPC(playerid))return 1;
	if(SeverState[_ServerRun]==false)Kick(playerid);
/*	new Version[32];
	GetPlayerVersion(playerid,Version,32);
	if(strcmp(Version, "0.3.8-RC4-4"))
	{
	    SCM(playerid,-1,ReturnMLStr(0,_ANTICHEAT_MSG5));
	    SCM(playerid,-1,ReturnMLStr(1,_ANTICHEAT_MSG5));
		SetTimerEx("DelayKicke",100,false,"i",playerid);
		return 1;
	}*/
	ShowPlayerConnectDraw(playerid);
    if(pMusic[playerid][_Playing]==false)PlayAudioStreamForPlayer(playerid,MUSIC_CONNECT);
    SetPlayerScore(playerid,0);
    RestPlayerAttach(playerid,true);
    SetPlayerColor(playerid,0x408080C8);
    
    for(new i;PlayerPos_Info:i<PlayerPos_Info;i++)PlayerPos[playerid][PlayerPos_Info:i]=0;
    for(new i;Account_InFo:i<Account_InFo;i++)Account[playerid][Account_InFo:i]=0;

    pLastAlive[playerid][_Game_Kills]=0;
    pLastAlive[playerid][_Game_Deaths]=0;
    pLastAlive[playerid][_Game_BagVol]=20;
    
    Account[playerid][_Login]=false;
    PlayerInState[playerid]=PLAYER_IN_NULL;
    PlayerInStateID[playerid]=NONE;
    
    pSpectateID[playerid]=INVALID_PLAYER_ID;

	pBuffID[playerid]=NONE;
	pBuffCount[playerid]=0;
	pCacheID[playerid]=NONE;
	pCacheCount[playerid]=0;
	

    Gui@OnPlayerConnect(playerid);
	Anti@OnPlayerConnect(playerid);
	Veh@OnPlayerConnect(playerid);
	Account@OnPlayerConnect(playerid);
	Easybmp@OnPlayerConnect(playerid);
	Music@OnPlayerConnect(playerid);

	ClearDeathList(playerid);
	PreloadAnimLib(playerid);
   	return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
    RestPlayerAttach(playerid,true);

    if(IsPlayerNPC(playerid))return 1;

	Gui@OnPlayerDisconnect(playerid,reason);
	Anti@OnPlayerDisconnect(playerid,reason);
	Veh@OnPlayerDisconnect(playerid,reason);
	Function@OnPlayerDisconnect(playerid,reason);
	Account@OnPlayerDisconnect(playerid,reason);
	Easybmp@OnPlayerDisconnect(playerid,reason);
	Music@OnPlayerDisconnect(playerid,reason);
	Car@OnPlayerDisconnect(playerid,reason);
    GameMain@OnPlayerDisconnect(playerid,reason);
    
    for(new i;PlayerPos_Info:i<PlayerPos_Info;i++)PlayerPos[playerid][PlayerPos_Info:i]=0;
    PosChange[playerid]=false;
    
    for(new i;Account_InFo:i<Account_InFo;i++)Account[playerid][Account_InFo:i]=0;

    Account[playerid][_Login]=false;
    PlayerInState[playerid]=PLAYER_IN_NULL;
    PlayerInStateID[playerid]=NONE;
    
    pSpectateID[playerid]=INVALID_PLAYER_ID;
    HidePlayerConnectDraw(playerid);
	return 1;
}
public OnPlayerDeath(playerid,killerid,reason)
{	
    if(IsPlayerNPC(playerid))return 1;
    
	if(Online(playerid))
	{
	    if(pGameID(playerid)!=NONE)
	    {
            SendLastAliveDeathMessage(pGameID(playerid),playerid,killerid,reason,false);
    		if(Online(killerid))
			{
			    if(pGameID(killerid)==pGameID(playerid))
			    {
		    		pLastAlive[killerid][_Game_Kills]++;
					UpdatePlayerGameKillDraw(killerid,pLastAlive[killerid][_Game_Kills]);
					UpdateGameRank(killerid,pGameID(killerid),pLastAlive[killerid][_Game_Kills]);
					new Float:xyz[3];
					GetPlayerPos(playerid,xyz[0],xyz[1],xyz[2]);
					Tryg3D::MapAndreasFindZ(xyz[0],xyz[1],xyz[2]);
					CreatePlayerGameDeathBox(pGameID(playerid),playerid,xyz[0],xyz[1],xyz[2]-0.5,GetPlayerInterior(playerid),100.0,2.0);
				}
			}
			DalayLeaveLastAliveGame(playerid,pGameID(playerid));
            pLastAlive[playerid][_Game_Death]=true;
		}
	}
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(IsPlayerNPC(playerid))return 1;
	
   	Weapon@OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
	return 1;
}
public OnPlayerUpdate(playerid)
{
    if(IsPlayerNPC(playerid))return 1;
    
    Function@OnPlayerUpdate(playerid);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerNPC(playerid))return 1;
	
    Anti@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    Veh@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    GameMain@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    Car@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    Music@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    HitList@OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(IsPlayerNPC(playerid))return 1;
    
   	new Float:xyza[4];
   	SetsLastStop(playerid,GetTickCount());
    GetPlayerPos(playerid,xyza[0],xyza[1],xyza[2]);
	GetPlayerFacingAngle(playerid,xyza[3]);
	PlayerPos[playerid][_LastSpeed]=floatround(GetPlayerAllStateSpeed(playerid));
    AntiCheat@SavePlayerPos(playerid,xyza[0],xyza[1],xyza[2],xyza[3]);
    
	Veh@OnPlayerStateChange(playerid, newstate, oldstate);
	Car@OnPlayerStateChange(playerid, newstate, oldstate);
	return 1;
}

public OnPlayerDamageDone(playerid, Float:amount, issuerid, weapon, bodypart)
{
    if(IsPlayerNPC(playerid))return 1;
    if(IsPlayerNPC(issuerid))return 1;
    switch(PlayerInState[playerid])
    {
		case PLAYER_IN_GAMEROOM:
        {
            new weaponname[32],line[128];
			if(weapon==-1)weaponname = "NULL";
			else WC_GetWeaponName(weapon,weaponname);
			if(issuerid!=INVALID_PLAYER_ID)
			{
				format(line,sizeof(line),"~>~~w~ID:%i(%s) ~r~HP-%.1f",issuerid,weaponname,amount);
				AddPlayerHitList(playerid,line);
				format(line,sizeof(line),"~<~~g~ID:%i(%s) ~y~HP-%.1f",playerid,weaponname,amount);
				AddPlayerHitList(issuerid,line);
			}
			else
			{
				format(line,sizeof(line),"~>~~w~OTHER(%s) ~r~HP-%.1f",weaponname,amount);
				AddPlayerHitList(playerid,line);
			}
       	}
    }
	if(issuerid!=INVALID_PLAYER_ID)
	{
	    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
	    PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
	}
    else PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
	return 1;
}
public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
    if(IsPlayerNPC(playerid))return 1;
    if(IsPlayerNPC(issuerid))return 1;
    switch(PlayerInState[playerid])
    {
		case PLAYER_IN_NULL:return 0;
		case PLAYER_IN_INTERFACE:return 0;
		case PLAYER_IN_WAITROOM:return 0;
		case PLAYER_IN_GAMEROOM:
        {
		    if(Online(playerid))
		    {
		        if(pGameIn(playerid)==false)return 1;
				if(pGameID(playerid)==NONE)return 1;
				new weaponname[32];
				if(weapon==-1)weaponname = "Multiple";
				else WC_GetWeaponName(weapon,weaponname);
		        new amout=floatround(floatmul(255,floatdiv(amount,100)),floatround_ceil);
		        if(amout>255)amout=255;
		        ShowPlayerDamagePrive(playerid,amout);
			    if(Online(issuerid))
			    {
					if(pGameID(issuerid)!=NONE&&pGameID(playerid)==pGameID(issuerid))
					{
					    ClearPlayerCache(playerid);
					    ClearPlayerBuff(playerid);
					    switch(bodypart)
					    {
					        case 9:
					        {
					            switch(weapon)
					            {
					                case 33:
					                {
                   						GameTextForPlayer(playerid, "~w~Country Rifle~r~Head Shot",3000,4);
                     					GameTextForPlayer(issuerid, "~w~Sniper Rifle~b~Head Shot!",3000,4);
					                    amount=100.0;
					                }
					                case 34:
					                {
                   						GameTextForPlayer(playerid, "~w~Sniper Rifle~r~Head Shot",3000,4);
                     					GameTextForPlayer(issuerid, "~w~Sniper Rifle~b~Head Shot!",3000,4);
					                    amount=80.0;
					                }
					            }
								if(pLastAliveBodyDress[playerid][_Body_Dress_Item][2]!=NONE)
								{
								    if(pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]>=amount)
								    {
								    	pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]-=amount;
										UpdateBodyCapDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][2],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Durable]);
										new line[128];
                                        if(pLang(issuerid)==0)format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON1),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_ChineseName],pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]);
                                        else format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON1),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Name],pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]);
       									SCM(issuerid,-1,line);
										format(line,sizeof(line),"~>~~w~ID:%i(%s) ~r~HELMET-%.1f",issuerid,weaponname,amount);
										AddPlayerHitList(playerid,line);
										format(line,sizeof(line),"~<~~g~ID:%i(%s) ~y~HELMET-%.1f",playerid,weaponname,amount);
										AddPlayerHitList(issuerid,line);
										PlayerPlaySound(playerid, 1130, 0.0, 0.0, 0.0);
	    								PlayerPlaySound(issuerid, 1135, 0.0, 0.0, 0.0);
										return 0;
									}
		                            else
									{
                                        new line[128];
                                        if(pLang(issuerid)==0)format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON2),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_ChineseName]);
                                        else format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON2),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Name]);
       									SCM(issuerid,-1,line);
										format(line,sizeof(line),"~>~~w~ID:%i(%s) ~r~HELMET-%.1f",issuerid,weaponname,pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]);
										AddPlayerHitList(playerid,line);
										format(line,sizeof(line),"~<~~g~ID:%i(%s) ~y~HELMET-%.1f",playerid,weaponname,pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]);
										AddPlayerHitList(issuerid,line);
       									amount-=pLastAliveBodyDress[playerid][_Body_Dress_Durable][2];
								    	pLastAliveBodyDress[playerid][_Body_Dress_Durable][2]=0.0;
										UpdateBodyCapDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][2],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][2]][_Durable]);
                                        return 1;
									}
							    }
					        }
					        default:
					        //case 3,4:
					        {
								if(pLastAliveBodyDress[playerid][_Body_Dress_Item][3]!=NONE)
								{
								    if(pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]>=amount)
								    {
								    	pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]-=amount;
										UpdateBodyArmorDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][3],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Durable]);
                                        new line[128];
                                        if(pLang(issuerid)==0)format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON1),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_ChineseName],pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]);
                                        else format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON1),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Name],pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]);
       									SCM(issuerid,-1,line);
										format(line,sizeof(line),"~>~~w~ID:%i(%s) ~r~ARMOUR-%.1f",issuerid,weaponname,amount);
										AddPlayerHitList(playerid,line);
										format(line,sizeof(line),"~<~~g~ID:%i(%s) ~y~ARMOUR-%.1f",playerid,weaponname,amount);
										AddPlayerHitList(issuerid,line);
										PlayerPlaySound(playerid, 1130, 0.0, 0.0, 0.0);
	    								PlayerPlaySound(issuerid, 1135, 0.0, 0.0, 0.0);
		                                return 0;
									}
		                            else
									{
                                        new line[128];
                                        if(pLang(issuerid)==0)format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON2),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_ChineseName]);
                                        else format(line,sizeof(line),ReturnMLStr(pLang(issuerid),_HIT_REASON2),Account[playerid][_Name],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Name]);
       									SCM(issuerid,-1,line);
										format(line,sizeof(line),"~>~~w~ID:%i(%s) ~r~ARMOUR-%.1f",issuerid,weaponname,pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]);
										AddPlayerHitList(playerid,line);
										format(line,sizeof(line),"~<~~g~ID:%i(%s) ~y~ARMOUR-%.1f",playerid,weaponname,pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]);
										AddPlayerHitList(issuerid,line);
										amount-=pLastAliveBodyDress[playerid][_Body_Dress_Durable][3];
								    	pLastAliveBodyDress[playerid][_Body_Dress_Durable][3]=0.0;
										UpdateBodyArmorDraw(playerid,pLastAliveBodyDress[playerid][_Body_Dress_Durable][3],Item[pLastAliveBodyDress[playerid][_Body_Dress_Item][3]][_Durable]);
										return 1;
									}
							    }
					        }
					    }
				    }
			    }
		    }
		}
		case PLAYER_IN_WAITLEAVE:return 0;
    }
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(IsPlayerAdmin(playerid))SetPlayerPosFindZ(playerid,fX,fY,fZ);
	return 1;
}
public OnPlayerStreamOut(playerid, forplayerid)
{
    switch(PlayerInState[playerid])
    {
		case PLAYER_IN_NULL:
        {
            //printf("PLAYER_IN_NULL");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_INTERFACE:
        {
            //printf("PLAYER_IN_INTERFACE");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_WAITROOM:
        {
            //printf("PLAYER_IN_WAITROOM");
			//SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			//SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_GAMEROOM:
        {
            //printf("PLAYER_IN_GAMEROOM");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_WAITLEAVE:
        {
            //printf("PLAYER_IN_WAITLEAVE");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
    }
    return 1;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
    switch(PlayerInState[playerid])
    {
		case PLAYER_IN_NULL:
        {
            //printf("PLAYER_IN_NULL");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_INTERFACE:
        {
            //printf("PLAYER_IN_INTERFACE");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_WAITROOM:
        {
            //printf("PLAYER_IN_WAITROOM");
			//SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			//SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_GAMEROOM:
        {
            //printf("PLAYER_IN_GAMEROOM");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
		case PLAYER_IN_WAITLEAVE:
        {
            //printf("PLAYER_IN_WAITLEAVE");
			SetPlayerMarkerForPlayer(forplayerid,playerid,( GetPlayerColor( playerid ) & 0xFFFFFF00 ) );
			SetPlayerMarkerForPlayer(playerid,forplayerid,( GetPlayerColor( forplayerid ) & 0xFFFFFF00 ) );
		}
    }
    return 1;
}
public OnPlayerText(playerid, text[])
{
	if(AntiCheat@ChackPlayerText(playerid, text)==false)
	{
	    switch(PlayerInState[playerid])
	    {
			case PLAYER_IN_WAITROOM:
	        {
	            new line[256];
				foreach(new i:Player)
				{
				    if(Online(i))
				    {
				        if(PlayerInState[i]==PLAYER_IN_WAITROOM&&PlayerInStateID[i]==PlayerInStateID[playerid])
						{
						    line=" ";
					    	format(line,sizeof(line),ReturnMLStr(pLang(i),_PLAYER_SAY_MSG2),Color[Account[playerid][_NameColor]][_hex_str],Account[playerid][_Name],text);
							SendClientMessage(i,0xC0C0C0C8,line);
						}
				    }
				}
	            printf("Text %s:%s",Account[playerid][_Name],text);
			}
			case PLAYER_IN_GAMEROOM:
	        {
	            new line[256];
				foreach(new i:Player)
				{
				    if(Online(i))
				    {
				        if(PlayerInState[i]==PLAYER_IN_GAMEROOM&&pGameID(i)==pGameID(playerid))
						{
						    line=" ";
					    	format(line,sizeof(line),ReturnMLStr(pLang(i),_PLAYER_SAY_MSG3),Color[Account[playerid][_NameColor]][_hex_str],Account[playerid][_Name],text);
							SendClientMessage(i,0xC0C0C0C8,line);
	                    }
				    }
				}
				printf("Text %s:%s",Account[playerid][_Name],text);
			}
			default:SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_SAY_MSG5));
	    }
	}
    return 0;
}
CMD:o(playerid, params[])
{
	new text[256];
    if(sscanf(params, "s[256]",text))return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_SAY_MSG4));
	if(AntiCheat@ChackPlayerText(playerid, text)==false)
	{
		SendPlayerMsgToAllUsLanguage(playerid,PlayerInState[playerid],-1,text);
		printf("/o %s:%s",Account[playerid][_Name],text);
    }
    return 1;
}
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(!Online(playerid))return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_CMD_MSG1));
    printf("玩家:%s  CMD:/%s  success:%i",Account[playerid][_Name],cmd,result);
	if(result!=1)
	{
	    fLine_128(ReturnMLStr(pLang(playerid),_CMD_MSG2),cmd);
       	SCM(playerid,-1,line);
	}
	return 1;
}
CMD:n(playerid, params[])
{
	new text[256];
    if(sscanf(params, "s[256]",text))return SCM(playerid,-1,ReturnMLStr(pLang(playerid),_PLAYER_SAY_MSG6));
	if(AntiCheat@ChackPlayerText(playerid, text)==false)
	{
		ProxDetectorEx(playerid,50.0,0xC2A2DAAA,_PLAYER_SAY_MSG7,text);
		SetPlayerChatBubble(playerid,text,Color[Account[playerid][_NameColor]][_hex],50.0,5000);
		printf("/n %s:%s",Account[playerid][_Name],text);
 	}
    return 1;
}
stock ProxDetectorEx(playerid,Float:max_range,color,languageid,string[],Float:max_ratio = 1.6)
{
    new Float:pos_x,
        Float:pos_y,
        Float:pos_z,
        Float:range,
        Float:range_ratio,
        Float:range_with_ratio,
        clr_r, clr_g, clr_b,
        Float:color_r, Float:color_g, Float:color_b,interiorid,worldid,line[256];
    if(!GetPlayerPos(playerid, pos_x, pos_y, pos_z))return 0;
    interiorid=GetPlayerInterior(playerid);
    worldid=GetPlayerVirtualWorld(playerid);
    color_r = float(color >> 24 & 0xFF);
    color_g = float(color >> 16 & 0xFF);
    color_b = float(color >> 8 & 0xFF);
    range_with_ratio = max_range * max_ratio;
   	foreach (new i : Player)
	{
	    if(!Online(i))continue;
	    if(i==playerid)continue;
        if (!IsPlayerStreamedIn(i, playerid))continue;
        if(GetPlayerInterior(i)!=interiorid)continue;
        if(GetPlayerVirtualWorld(i)!=worldid)continue;
        range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);
        if (range > max_range)continue;
        range_ratio = (range_with_ratio - range) / range_with_ratio;
        clr_r = floatround(range_ratio * color_r);
        clr_g = floatround(range_ratio * color_g);
        clr_b = floatround(range_ratio * color_b);
        line=" ";
		format(line,sizeof(line),ReturnMLStr(pLang(i),languageid),floatround(range),Account[playerid][_Name],string);
        SCM(i, (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24), line);
    }
    line=" ";
	format(line,sizeof(line),ReturnMLStr(pLang(playerid),languageid),0,Account[playerid][_Name],string);
 	SCM(playerid,color,line);
    return 1;
}
CMD:sendyd(playerid, params[])
{
	new gold,itemid,itemamount;
	if(sscanf(params, "iii",gold,itemid,itemamount))return 1;
    foreach(new i:Player)
    {
	    if(Online(i))
	    {
			SendMailToOnlinePlayer(i,playerid,MAIL_TYPE_PLAYER,"元旦快乐","多了不说，礼到就可以了!",gold,itemid,itemamount,NONE);
        }
	}
	return 1;
}


//-------------------------------------------------



