/*stock AddSnowObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:d_stream = 200.0)
{
    printf("CreateDynamicObject(%i,%f,%f,%f,%f,%f,%f,-1,-1,-1,%f);",modelid,x,y,z + 0.3,rx,ry,rz,-1,-1,-1,d_stream);
	new	object=CreateDynamicObject(modelid,x,y,z + 0.3,rx,ry,rz,-1,-1,-1,d_stream);
	forex(a,16)SetDynamicObjectMaterial(object, a, 17944, "lngblok_lae2", "white64bumpy",0);
	return object;
}
N::IsPosInArea(Float:pos_x, Float:pos_y, Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{
	if(pos_x>=min_x&&pos_x<=max_x&&pos_y>=min_y&&pos_y<=max_y)return true;
	return false;
}*/
/*stock IsInSnowZone(Float:x,Float:y)
{
    return (x>-2968.0&&x<42.0&&y>-2970.0&&y<-918.0);
}
N::UpdateWinterPlayerSnow(playerid)
{
	if(pSnow[playerid]!=INVALID_STREAMER_ID)
	{
	    if(IsInSnowZone(PlayerPos[playerid][_X],PlayerPos[playerid][_Y]))
	    {
	        //18863{1,12.551998,-1.338999,-3.738998,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000},
 			Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_X,PlayerPos[playerid][_X]+12.551998);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_Y,PlayerPos[playerid][_Y]-1.338999);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_Z,PlayerPos[playerid][_Z]-3.738998);
	    }
	    else
	    {
 			Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_X,0.0);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_Y,0.0);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT,pSnow[playerid],E_STREAMER_Z,-50.0);
		}
	}
	return 1;
}
N::Winter@OnPlayerConnect(playerid)
{
	if(pSnow[playerid]!=INVALID_STREAMER_ID)
	{
	    DestroyDynamicObject(pSnow[playerid]);
	}
	pSnow[playerid]=CreateDynamicObject(18863,0.0,0.0,-50.0,0.0,0.0,0.0,-1,-1,playerid,100.0);
	return 1;
}
N::Winter@OnPlayerDisconnect(playerid,reason)
{
	if(pSnow[playerid]!=INVALID_STREAMER_ID)
	{
	    DestroyDynamicObject(pSnow[playerid]);
	}
	return 1;
}*/
N::CreateWinterInArea(Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{

/*	new	count;
	forex(a,SEARCH_DATA_SIZE)
	{
		if(SearchData[a][SearchZ] > max_z)continue;
		if(!IsPosInArea(SearchData[a][SearchX], SearchData[a][SearchY], min_x, min_y, max_x, max_y))continue;
		if(GetColSphereRadius(SearchData[a][Search_Model]) < min_obj_model_size)continue;
		switch(SearchData[a][Search_Model])
        {
            case 615..892:continue;
            case 3505..3517:continue;
            case 3898,8837,9019,9034,9035,16060,16061,18733,18734,19076:continue;
            case 325,11413,11414,14400,14402,14468,14469:continue;
        }
		//if(IsObjectRemoved(SearchData[a][Search_Model], SearchData[a][SearchX], SearchData[a][SearchY], SearchData[a][SearchZ]))continue;
		//if(!RemoveObject(SearchData[a][Search_Model],SearchData[a][SearchX],SearchData[a][SearchY],SearchData[a][SearchZ]))break;
		AddSnowObject(SearchData[a][Search_Model],SearchData[a][SearchX],SearchData[a][SearchY],SearchData[a][SearchZ],SearchData[a][SearchRX],SearchData[a][SearchRY],SearchData[a][SearchRZ],(600.0+GetColSphereRadius(SearchData[a][Search_Model])));
		count++;
	}*/
	new TempObject;
	TempObject=CreateDynamicObject(18361,-1968.630004,-2797.100097,-2.856250,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18389,-1582.800048,-2772.659912,46.745300,0.000000,0.000000,139.018997,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18355,-1554.469970,-2704.159912,6.721877,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18363,-1307.680053,-2913.090087,3.534379,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18362,-1501.369995,-2896.379882,3.323436,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18390,-1460.660034,-2871.580078,46.768798,0.000000,0.000000,-43.614200,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18391,-1317.939941,-2892.530029,54.354698,0.000000,0.000000,7.327198,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18356,-1366.459960,-2704.189941,46.518798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18354,-1757.410034,-2662.159912,3.495310,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18388,-1757.270019,-2651.729980,53.151599,0.000000,0.000000,-172.476654,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18228,-1856.689941,-2321.290039,38.448398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18387,-1843.550048,-2547.949951,46.268798,0.000000,0.000000,176.863739,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18225,-1690.410034,-2456.340087,29.839099,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18346,-1801.510009,-2447.149902,53.190597,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18227,-1790.579956,-2267.010009,62.440597,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18226,-1738.189941,-2402.209960,29.839099,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18347,-1594.339965,-2468.669921,56.604698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18340,-1537.790039,-2263.459960,46.370300,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18348,-1394.540039,-2473.389892,79.964103,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18341,-1316.390014,-2275.949951,45.846900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18349,-1266.989990,-2464.629882,31.518798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18358,-2652.770019,-2883.520019,-20.075000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18359,-2423.090087,-2867.389892,-20.075000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18350,-2642.149902,-2657.629882,28.542200,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18351,-2423.540039,-2638.909912,38.643798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18384,-2391.840087,-2644.770019,46.628097,0.000000,0.000000,155.524444,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18394,-2543.139892,-2608.120117,32.417198,0.000000,0.000000,-81.939285,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18360,-2198.449951,-2873.070068,-8.590626,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18518,-2160.699951,-2766.169921,39.659400,0.000000,0.000000,155.524444,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18385,-2200.340087,-2651.199951,44.948398,0.000000,0.000000,-106.775604,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18352,-2206.080078,-2638.909912,48.073398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18473,-1989.239990,-2677.479980,38.010898,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18386,-1989.280029,-2643.780029,47.581298,0.000000,0.000000,17.771070,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18485,-1987.880004,-2582.669921,49.042198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18393,-2229.439941,-2515.909912,30.456298,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18482,-2180.229980,-2490.909912,29.893798,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18484,-2121.110107,-2488.050048,29.839099,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18202,-2078.500000,-2505.909912,30.581298,0.000000,0.000000,-128.502059,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18353,-2057.040039,-2552.939941,41.190597,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18476,-2048.600097,-2487.270019,32.604698,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18383,-2465.899902,-2435.179931,32.940597,0.000000,0.000000,-74.688232,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18342,-2645.090087,-2426.350097,13.995300,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18343,-2499.500000,-2427.649902,38.182800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18382,-2569.229980,-2381.060058,15.120300,0.000000,0.000000,-56.869682,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18344,-2293.590087,-2421.840087,31.284399,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18483,-2208.939941,-2418.020019,29.901599,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18377,-2468.929931,-2261.979980,20.510898,0.000000,0.000000,111.302749,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18475,-2253.080078,-2291.000000,26.073398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18237,-2153.870117,-2453.379882,30.143798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18474,-2183.770019,-2422.229980,32.620300,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18480,-2152.149902,-2418.669921,29.831298,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18481,-2149.629882,-2404.590087,29.839099,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18203,-2149.659912,-2362.429931,33.534400,0.000000,0.000000,140.999954,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18477,-2166.639892,-2272.050048,29.839099,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18478,-2146.989990,-2307.729980,29.831298,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18479,-2110.110107,-2314.629882,29.839099,0.000000,0.000000,51.499217,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18200,-2100.219970,-2285.500000,33.487499,0.000000,0.000000,-128.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18345,-2016.010009,-2431.520019,34.174999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18365,-2001.030029,-2388.090087,38.753097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18324,-2871.550048,-1975.630004,35.729698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18373,-2897.810058,-1777.729980,27.909399,0.000000,0.000000,-84.393592,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18315,-2872.449951,-1765.000000,48.409400,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18372,-2930.239990,-1548.010009,10.550000,0.000000,0.000000,89.887451,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18306,-2874.280029,-1547.979980,41.424999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18374,-2833.639892,-1942.619995,39.010898,0.000000,0.000000,-39.261493,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18276,-2824.260009,-1810.349975,138.120010,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18371,-2931.469970,-1334.479980,7.831250,0.000000,0.000000,-95.667335,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18370,-2905.409912,-1145.770019,8.721877,0.000000,0.000000,-99.061454,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3330,-2901.389892,-1114.920043,-2.496880,0.000000,0.000000,171.180999,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18561,-2890.449951,-1047.040039,8.870306,0.000000,0.000000,80.939025,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18563,-2889.530029,-1042.829956,20.120298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18300,-2872.840087,-1321.280029,42.682800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18369,-2878.719970,-977.539001,8.776556,0.000000,0.000000,80.956748,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3330,-2878.209960,-971.984008,-2.496880,0.000000,0.000000,171.180999,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18296,-2870.979980,-1117.650024,24.932798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18335,-2643.419921,-2197.540039,46.143798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18280,-2630.850097,-2168.810058,68.425003,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18375,-2686.300048,-2040.699951,38.823398,0.000000,0.000000,-33.251750,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18278,-2678.570068,-1980.930053,95.612503,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18325,-2656.679931,-1992.949951,80.471900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18292,-2640.639892,-1994.359985,126.855003,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18277,-2753.050048,-1914.130004,111.878005,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18316,-2655.280029,-1781.010009,265.440979,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18308,-2724.320068,-1555.959960,223.191009,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18469,-2700.280029,-1345.800048,213.761001,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18293,-2691.179931,-939.578002,47.229698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18301,-2583.429931,-1343.449951,271.143981,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18297,-2646.350097,-1116.930053,112.058006,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18336,-2426.360107,-2217.189941,67.354705,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18376,-2563.550048,-2204.649902,25.589099,0.000000,0.000000,-66.224235,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18281,-2515.489990,-2140.770019,55.417198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18223,-2548.360107,-1867.640014,285.182983,0.000000,0.000000,4.999989,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18326,-2444.500000,-1991.670043,198.995010,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18294,-2492.429931,-943.601989,54.792198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18298,-2421.159912,-1134.089965,169.081008,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18295,-2291.780029,-993.406005,63.878097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18339,-1769.430053,-2236.709960,86.846900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18378,-2217.760009,-2191.020019,38.706298,0.000000,0.000000,30.146425,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18337,-2217.649902,-2172.449951,65.284400,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18338,-1999.170043,-2212.909912,70.268806,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18328,-2237.000000,-1951.520019,297.862976,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18329,-2233.199951,-1980.780029,153.979995,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18268,-2189.989990,-1909.640014,261.830993,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18379,-2076.169921,-2004.829956,57.979698,0.000000,0.000000,-123.631935,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18330,-2010.979980,-1981.170043,103.541999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18331,-1801.040039,-2007.520019,84.581306,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18332,-1570.859985,-2023.479980,60.924999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18333,-1358.729980,-2064.699951,39.057800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18304,-2182.229980,-1358.709960,135.542007,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18299,-2186.750000,-1147.729980,108.456001,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18318,-2181.469970,-1774.810058,217.697998,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18366,-2146.550048,-1803.800048,241.158996,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18551,-2146.550048,-1803.800048,241.158996,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18311,-2145.199951,-1576.719970,259.947998,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18270,-2089.590087,-1700.219970,202.456008,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18272,-2064.479980,-1620.489990,184.831008,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18273,-1985.380004,-1556.680053,157.152008,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18312,-1985.510009,-1562.510009,84.768806,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18305,-1980.380004,-1330.489990,75.151603,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18320,-1970.709960,-1785.979980,108.284004,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18380,-1939.550048,-1811.609985,34.167198,0.000000,0.000000,-125.173606,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18255,-1939.910034,-1731.479980,25.245298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18251,-1907.619995,-1666.680053,30.151599,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18247,-1874.339965,-1680.949951,25.737499,0.000000,0.000000,-140.000015,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18245,-1849.520019,-1701.160034,33.253097,0.000000,0.000000,-55.000083,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18381,-1799.839965,-1709.910034,29.573398,0.000000,0.000000,-148.751770,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18364,-1835.930053,-1647.680053,26.799999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18254,-1813.800048,-1615.560058,30.151599,0.000000,0.000000,-89.999992,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18313,-1776.780029,-1563.010009,10.003127,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18323,-1369.770019,-1848.339965,20.760898,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18321,-1744.540039,-1786.979980,54.885898,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18322,-1520.469970,-1835.209960,48.393798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3331,-1697.790039,-1659.459960,42.174999,0.000000,0.000000,112.750007,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18449,-1700.979980,-1651.839965,35.214099,0.000000,0.000000,-157.249938,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3330,-1664.319946,-1636.609985,20.940599,0.000000,0.000000,113.181030,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18314,-1552.969970,-1683.270019,31.542200,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(18450,-1627.209960,-1620.910034,35.214099,0.000000,0.000000,22.750051,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3331,-1623.739990,-1628.410034,42.174999,0.000000,0.000000,112.750007,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17079,-1751.829956,-941.914001,66.870300,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17226,-1750.630004,-922.742004,75.260902,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17230,-1631.949951,-911.062988,97.690605,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17086,-1226.599975,-1846.250000,41.737499,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17271,-1309.760009,-1697.959960,45.034400,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17085,-1527.229980,-1633.219970,20.542200,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17273,-1449.300048,-1627.770019,42.628097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17087,-1239.839965,-1617.060058,52.792198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17275,-1592.670043,-1530.000000,36.471900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17056,-1462.020019,-1532.530029,102.206001,-0.000003,0.000003,-0.000003,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17283,-1274.630004,-1514.880004,28.698398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17277,-1805.189941,-1432.719970,35.807800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17081,-1788.439941,-1407.380004,36.042198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17218,-1583.800048,-1415.339965,41.721900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17220,-1533.219970,-1368.489990,46.807800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17216,-1684.270019,-1279.239990,49.979698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17084,-1504.099975,-1458.699951,63.628097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17236,-1448.449951,-1337.560058,100.128105,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17238,-1367.800048,-1398.849975,108.652000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17089,-1233.800048,-1451.270019,99.065605,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17083,-1461.260009,-1223.130004,136.932998,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17234,-1526.619995,-1220.010009,101.034004,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17222,-1602.390014,-1213.199951,65.800003,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17080,-1664.660034,-1176.800048,69.323402,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17214,-1759.619995,-1129.650024,53.932800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17224,-1704.619995,-1100.420043,72.831306,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17232,-1619.150024,-1092.579956,101.948005,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(17212,-1804.930053,-982.203002,48.753097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4290,-2881.590087,-2209.909912,-26.543800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4291,-2881.590087,-2434.510009,-21.457799,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4292,-2881.590087,-2659.100097,-27.832799,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4293,-2881.590087,-2883.699951,-34.301601,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4294,-1966.300048,-2928.629882,-33.200000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4295,-1737.479980,-2883.699951,-36.004699,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4296,-2198.449951,-2873.070068,-8.590626,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4297,-2423.090087,-2867.389892,-20.075000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4298,-2652.770019,-2883.520019,-20.075000,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4299,-1501.369995,-2896.379882,3.323436,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4300,-1307.680053,-2913.090087,3.534379,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4302,-2871.550048,-1975.630004,35.729698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4303,-2872.449951,-1765.000000,48.409400,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4304,-2874.280029,-1547.979980,41.424999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4305,-2872.840087,-1321.280029,42.682800,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4306,-2870.979980,-1117.650024,24.932798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4307,-2892.250000,-962.179992,-26.098400,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4308,-2691.179931,-939.578002,47.229698,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4309,-2492.429931,-943.601989,54.792198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4310,-2291.780029,-993.406005,63.878097,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4311,-2186.750000,-1147.729980,108.456001,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4312,-1980.380004,-1330.489990,75.151603,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4313,-1776.780029,-1563.010009,10.003127,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4361,-1226.599975,-1846.250000,41.737499,0.000000,0.000000,152.537490,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(4362,-1527.229980,-1633.219970,20.542200,0.000000,0.000000,144.348770,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10601,-2208.520019,-1003.299987,18.026599,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10944,-1499.699951,-1494.520019,20.893798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10956,-1904.500000,-1210.319946,16.721899,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10957,-1759.239990,-1381.130004,16.010900,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10958,-1903.979980,-1225.800048,37.885898,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10959,-1809.800048,-1152.459960,44.456298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10960,-2011.869995,-1239.349975,25.065599,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10961,-1892.949951,-1000.849975,42.799999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10962,-2139.479980,-1022.719970,13.151597,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10965,-1956.839965,-1069.719970,43.893798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10966,-2044.339965,-1068.479980,45.089099,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11118,-1987.699951,-961.796997,31.424999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11122,-2073.080078,-1005.200012,31.370298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11123,-2156.580078,-932.953002,31.370298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11134,-1904.010009,-1093.689941,36.042198,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11135,-1968.430053,-1125.300048,34.151599,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11136,-1923.839965,-1322.880004,39.698398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11137,-1874.510009,-1169.689941,33.089099,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11337,-1963.310058,-1055.510009,22.229700,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11363,-1955.239990,-929.429992,31.424999,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(11365,-1945.229980,-930.140991,31.393798,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3873,-2081.909912,-911.179992,48.823398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(3873,-2081.909912,-962.414001,48.823398,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);TempObject=CreateDynamicObject(10493,-2159.729980,-1005.450012,39.831298,0.000000,0.000000,0.000000,-1,-1,-1,950.5);forex(a,16)SetDynamicObjectMaterial(TempObject, a, 17944, "lngblok_lae2", "white64bumpy",0);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,TempObject,E_STREAMER_EXTRA_ID,1001);
	new count=0,objex;
    new x=floatround(min_x,floatround_floor),y=floatround(min_y,floatround_floor),z=-10;
    while(z<750)
    {
        while(x<=floatround(max_x,floatround_floor))
        {
            while(y<=floatround(max_y,floatround_floor))
            {
                objex=CreateDynamicObject(18864,x,y,z,random(100),random(100),random(100),-1,-1,-1,100.0);
				Streamer_SetIntData(STREAMER_TYPE_OBJECT,objex,E_STREAMER_EXTRA_ID,1001);
                //forex(a,16)SetDynamicObjectMaterial(objex, a, 17944, "lngblok_lae2", "white64bumpy",0);
				forex(a,16)SetDynamicObjectMaterial(objex, a, 18863, "fakesnow1", "snow2",0);

                y+=100;
                count++;
            }
            y=floatround(min_y,floatround_floor);
            x+=100;
        }
        x=floatround(min_x,floatround_floor);
        z+=100;
    }
/*	new _Wide=floatround(floatdiv(floatsub(max_x,min_x),36.0736),floatround_floor);
    new _High=floatround(floatdiv(floatsub(max_y,min_y),36.0736),floatround_floor);
    new Amount=_Wide*_High;
    new BreakLine=0,NowLine=0;
    new Rate=0,Float:sX,Float:sY,Float:sZ=-10.0;
	count=0;
	forex(s,20)
	{
	    sZ=s*20.0;
		forex(i,Amount)
		{
		    if(BreakLine>=_Wide)
		    {
				NowLine++;
				BreakLine=0;
		    }
		    sX=min_x+(Rate-NowLine*_Wide)*35.28;
		    sY=min_y+NowLine*59.12;
		    CreateDynamicObject(18863,sX,sY,sZ,0.0,0.0,0.0,-1,-1,-1,136.0736);
		    //printf("Snowing objects: %f,%f",sX,sY);
		    Rate++;
		    BreakLine++;
		    count++;
		}
	}*/
	printf("Total Snowing objects: %i", count);
	return true;
}
CMD:fps(playerid, params[])
{
    if(pFPSOpen[playerid]==true)
    {
        pFPSOpen[playerid]=false;
        TogglePlayerStreamItemForFPS(playerid,pFPSOpen[playerid]);
        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FPS_MSG2));
    }
    else
    {
        pFPSOpen[playerid]=true;
        TogglePlayerStreamItemForFPS(playerid,pFPSOpen[playerid]);
        SCM(playerid,-1,ReturnMLStr(pLang(playerid),_FPS_MSG3));
    }
	return 1;
}
N::TogglePlayerStreamItemForFPS(playerid,bool:toggle)
{
    new extraid;
	if(toggle==true)
	{
		forex(i,CountDynamicObjects())
		{
			if(IsValidDynamicObject(i))
			{
			    extraid=Streamer_GetIntData(STREAMER_TYPE_OBJECT,i,E_STREAMER_EXTRA_ID);
			    if(extraid==1001)
			    {
			        Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, i, 1);
			    }
		    }
		}
  		forex(i,CountDynamic3DTextLabels())
		{
			if(IsValidDynamic3DTextLabel(Text3D:i))
			{
		    	extraid=Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL,i,E_STREAMER_EXTRA_ID);
		    	if(extraid==1001)Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, i, 1);
		    }
		}
	}
	else
	{
		forex(i,CountDynamicObjects())
		{
			if(IsValidDynamicObject(i))
			{
		     	extraid=Streamer_GetIntData(STREAMER_TYPE_OBJECT,i,E_STREAMER_EXTRA_ID);
			    if(extraid==1001)
			    {
			        Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, i, 0);
			    }
		    }
		}
		forex(i,CountDynamic3DTextLabels())
		{
			if(IsValidDynamic3DTextLabel(Text3D:i))
			{
		    	extraid=Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL,i,E_STREAMER_EXTRA_ID);
		    	if(extraid==1001)Streamer_ToggleItem(playerid, STREAMER_TYPE_3D_TEXT_LABEL, i, 0);
		    }
		}
	}
	return 1;
}

