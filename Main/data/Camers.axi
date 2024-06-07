PROGRAM_NAME='Camers'

DEFINE_TYPE
structure presets
{
    integer cam
    Integer presset
}

DEFINE_VARIABLE
Dev all_Congress_Cam [] =
{
    tp_Congress_Cam_op,
    tp_Congress_Cam_VIP,
    tp_Congress_Cam_Raz,
    tp_Congress_Cam_Gref
}

dev tp_cam_control [] = 
{
    tp_Cam_1,
    tp_Cam_3,
    tp_Cam_2,
    tp_Cam_4
}
// --- Камеры ---
Integer Cam_XXX
Integer All_Presset_active

dev dv_cams [] =
{
    dv_cam_1,
    dv_cam_2,
    dv_cam_3,
    dv_cam_4,
    dv_cam_5,
    dv_cam_6
}

// --- Конгреска ---
volatile presets pr[234]
volatile integer Flag_hlod

DEFINE_START
// --- Камеры ---
If (All_Presset_active=0)
    All_Presset_active = 101
Cam_XXX  = 1		// Если 1 то вкл управление с пульта

// --- Конгреска ---
pr[1].cam = 4; pr[1].presset = 1
pr[2].cam = 4; pr[2].presset = 2
pr[3].cam = 4; pr[3].presset = 3
pr[4].cam = 4; pr[4].presset = 4
pr[5].cam = 4; pr[5].presset = 5
pr[6].cam = 4; pr[6].presset = 6
pr[7].cam = 4; pr[7].presset = 7
pr[8].cam = 4; pr[8].presset = 9
pr[9].cam = 5; pr[9].presset = 2
pr[10].cam = 5; pr[10].presset = 3
pr[11].cam = 5; pr[11].presset = 4
pr[12].cam = 5; pr[12].presset = 5
pr[13].cam = 5; pr[13].presset = 6
pr[14].cam = 5; pr[14].presset = 7

pr[101].cam = 4; pr[101].presset = 8
pr[102].cam = 5; pr[102].presset = 8


// --- камеры 1236
pr[201].cam = 1; pr[201].presset = 1
pr[202].cam = 1; pr[202].presset = 2
pr[203].cam = 2; pr[203].presset = 1
pr[204].cam = 2; pr[204].presset = 2
pr[205].cam = 3; pr[205].presset = 1
pr[206].cam = 1; pr[206].presset = 3
pr[207].cam = 2; pr[207].presset = 3
pr[208].cam = 2; pr[208].presset = 4
pr[209].cam = 3; pr[209].presset = 2
pr[210].cam = 3; pr[210].presset = 3
pr[211].cam = 1; pr[211].presset = 4
pr[212].cam = 2; pr[212].presset = 5
pr[213].cam = 2; pr[213].presset = 6
pr[214].cam = 2; pr[214].presset = 7
pr[215].cam = 3; pr[215].presset = 4
pr[216].cam = 3; pr[216].presset = 5
pr[217].cam = 3; pr[217].presset = 6
pr[218].cam = 1; pr[218].presset = 5
pr[219].cam = 3; pr[219].presset = 7
pr[220].cam = 3; pr[220].presset = 8
pr[221].cam = 1; pr[221].presset = 6
pr[222].cam = 3; pr[222].presset = 9
pr[223].cam = 3; pr[223].presset = 10

pr[231].cam = 1; pr[231].presset = 11
pr[232].cam = 2; pr[232].presset = 11
pr[233].cam = 3; pr[233].presset = 11
pr[234].cam = 6; pr[234].presset = 11



DEFINE_MUTUALLY_EXCLUSIVE
// --- оператор
([tp_Congress_Cam_op,1],[tp_Congress_Cam_op,2],[tp_Congress_Cam_op,3],[tp_Congress_Cam_op,4],
[tp_Congress_Cam_op,5],[tp_Congress_Cam_op,6],[tp_Congress_Cam_op,7],[tp_Congress_Cam_op,8],
[tp_Congress_Cam_op,9],[tp_Congress_Cam_op,10],[tp_Congress_Cam_op,11],[tp_Congress_Cam_op,12],
[tp_Congress_Cam_op,13],[tp_Congress_Cam_op,14],[tp_Congress_Cam_op,101],[tp_Congress_Cam_op,102])

([tp_Congress_Cam_op,1001],[tp_Congress_Cam_op,1002])

([tp_Congress_Cam_op,201],[tp_Congress_Cam_op,202],[tp_Congress_Cam_op,203],[tp_Congress_Cam_op,204],[tp_Congress_Cam_op,205],
[tp_Congress_Cam_op,206],[tp_Congress_Cam_op,207],[tp_Congress_Cam_op,208],[tp_Congress_Cam_op,209],[tp_Congress_Cam_op,210],
[tp_Congress_Cam_op,211],[tp_Congress_Cam_op,212],[tp_Congress_Cam_op,213],[tp_Congress_Cam_op,214],[tp_Congress_Cam_op,215],
[tp_Congress_Cam_op,216],[tp_Congress_Cam_op,217],[tp_Congress_Cam_op,218],[tp_Congress_Cam_op,219],[tp_Congress_Cam_op,220],
[tp_Congress_Cam_op,221],[tp_Congress_Cam_op,222],[tp_Congress_Cam_op,223],
[tp_Congress_Cam_op,231],[tp_Congress_Cam_op,232],[tp_Congress_Cam_op,233],[tp_Congress_Cam_op,234])

// --- vip
([tp_Congress_Cam_VIP,1],[tp_Congress_Cam_VIP,2],[tp_Congress_Cam_VIP,3],[tp_Congress_Cam_VIP,4],
[tp_Congress_Cam_VIP,5],[tp_Congress_Cam_VIP,6],[tp_Congress_Cam_VIP,7],[tp_Congress_Cam_VIP,8],
[tp_Congress_Cam_VIP,9],[tp_Congress_Cam_VIP,10],[tp_Congress_Cam_VIP,11],[tp_Congress_Cam_VIP,12],
[tp_Congress_Cam_VIP,13],[tp_Congress_Cam_VIP,14],[tp_Congress_Cam_VIP,101],[tp_Congress_Cam_VIP,102])

([tp_Congress_Cam_VIP,1001],[tp_Congress_Cam_VIP,1002])

([tp_Congress_Cam_VIP,201],[tp_Congress_Cam_VIP,202],[tp_Congress_Cam_VIP,203],[tp_Congress_Cam_VIP,204],[tp_Congress_Cam_VIP,205],
[tp_Congress_Cam_VIP,206],[tp_Congress_Cam_VIP,207],[tp_Congress_Cam_VIP,208],[tp_Congress_Cam_VIP,209],[tp_Congress_Cam_VIP,210],
[tp_Congress_Cam_VIP,211],[tp_Congress_Cam_VIP,212],[tp_Congress_Cam_VIP,213],[tp_Congress_Cam_VIP,214],[tp_Congress_Cam_VIP,215],
[tp_Congress_Cam_VIP,216],[tp_Congress_Cam_VIP,217],[tp_Congress_Cam_VIP,218],[tp_Congress_Cam_VIP,219],[tp_Congress_Cam_VIP,220],
[tp_Congress_Cam_VIP,221],[tp_Congress_Cam_VIP,222],[tp_Congress_Cam_VIP,223],
[tp_Congress_Cam_VIP,231],[tp_Congress_Cam_VIP,232],[tp_Congress_Cam_VIP,233],[tp_Congress_Cam_VIP,234])


// --- Ражнов
([tp_Congress_Cam_Raz,201],[tp_Congress_Cam_Raz,202],[tp_Congress_Cam_Raz,203],[tp_Congress_Cam_Raz,204],[tp_Congress_Cam_Raz,205],
[tp_Congress_Cam_Raz,206],[tp_Congress_Cam_Raz,207],[tp_Congress_Cam_Raz,208],[tp_Congress_Cam_Raz,209],[tp_Congress_Cam_Raz,210],
[tp_Congress_Cam_Raz,211],[tp_Congress_Cam_Raz,212],[tp_Congress_Cam_Raz,213],[tp_Congress_Cam_Raz,214],[tp_Congress_Cam_Raz,215],
[tp_Congress_Cam_Raz,216],[tp_Congress_Cam_Raz,217],[tp_Congress_Cam_Raz,218],[tp_Congress_Cam_Raz,219],[tp_Congress_Cam_Raz,220],
[tp_Congress_Cam_Raz,221],[tp_Congress_Cam_Raz,222],[tp_Congress_Cam_Raz,223],
[tp_Congress_Cam_Raz,231],[tp_Congress_Cam_Raz,232],[tp_Congress_Cam_Raz,233],[tp_Congress_Cam_Raz,234])


// --- Греф
([ tp_Congress_Cam_Gref,1],[ tp_Congress_Cam_Gref,2],[ tp_Congress_Cam_Gref,3],[ tp_Congress_Cam_Gref,4],
[ tp_Congress_Cam_Gref,5],[ tp_Congress_Cam_Gref,6],[ tp_Congress_Cam_Gref,7],[ tp_Congress_Cam_Gref,8],
[ tp_Congress_Cam_Gref,9],[ tp_Congress_Cam_Gref,10],[ tp_Congress_Cam_Gref,11],[ tp_Congress_Cam_Gref,12],
[ tp_Congress_Cam_Gref,13],[ tp_Congress_Cam_Gref,14],[ tp_Congress_Cam_Gref,101],[ tp_Congress_Cam_Gref,102])

([ tp_Congress_Cam_Gref,1001],[ tp_Congress_Cam_Gref,1002])

([ tp_Congress_Cam_Gref,201],[ tp_Congress_Cam_Gref,202],[ tp_Congress_Cam_Gref,203],[ tp_Congress_Cam_Gref,204],[ tp_Congress_Cam_Gref,205],
[ tp_Congress_Cam_Gref,206],[ tp_Congress_Cam_Gref,207],[ tp_Congress_Cam_Gref,208],[ tp_Congress_Cam_Gref,209],[ tp_Congress_Cam_Gref,210],
[ tp_Congress_Cam_Gref,211],[ tp_Congress_Cam_Gref,212],[ tp_Congress_Cam_Gref,213],[ tp_Congress_Cam_Gref,214],[ tp_Congress_Cam_Gref,215],
[ tp_Congress_Cam_Gref,216],[ tp_Congress_Cam_Gref,217],[ tp_Congress_Cam_Gref,218],[ tp_Congress_Cam_Gref,219],[ tp_Congress_Cam_Gref,220],
[ tp_Congress_Cam_Gref,221],[ tp_Congress_Cam_Gref,222],[ tp_Congress_Cam_Gref,223],
[ tp_Congress_Cam_Gref,231],[ tp_Congress_Cam_Gref,232],[ tp_Congress_Cam_Gref,233],[ tp_Congress_Cam_Gref,234])

DEFINE_MODULE 'Sony_Camera_Module' TP_Sony_1(dv_cams,tp_Cam_1,vdv_Pult_For_Cam)			// --- Управление камерами для панели оператора
DEFINE_MODULE 'Sony_Camera_Module' TP_Sony_2(dv_cams,tp_Cam_2,vdv_Pult_not_For_Cam)		// --- Управление камерами для панели Ражнова
DEFINE_MODULE 'Sony_Camera_Module' TP_Sony_3(dv_cams,tp_Cam_3,vdv_Pult_not_For_Cam)		// --- Управление камерами для панели VIP
DEFINE_MODULE 'Sony_Camera_Module' TP_Sony_4(dv_cams,tp_Cam_4,vdv_Pult_not_For_Cam)		// --- Управление камерами для панели Gref
DEFINE_MODULE 'Sony_Camera_Module' TP_Sony_5(dv_cams,tp_Cam_5,vdv_Pult_not_For_Cam)		// --- Управление камерами для панели Gref

DEFINE_EVENT
DATA_EVENT[dv_cams]		// --- Онлайн камеры
{
    ONLINE:
    {
	SEND_COMMAND dv_cams[get_last(dv_cams)],"'SET BAUD 38400,N,8,1 485 DINABLE'" 
    }
    string:
    {
	if (Cam_XXX) send_string dv_PultCam,"data.text"
    }
}
DATA_EVENT[dv_PultCam]		// --- Онлайн девайсов и мост пульта и камер
{
    ONLINE:
    {
	SEND_COMMAND dv_PultCam,"'SET BAUD 38400,N,8,1 485 DINABLE'" 
    }
    STRING:
    {
	WHILE(LEFT_STRING(data.text,1) = "$FF")
	    REMOVE_STRING(data.text,"$FF",1)
	SWITCH(LEFT_STRING(data.text,1))
	{
	    case $81:send_string dv_cams[1],"data.text"
	    case $82:send_string dv_cams[2],"data.text"
	    case $83:send_string dv_cams[3],"data.text"
	    case $84:send_string dv_cams[4],"data.text"
	    case $85:send_string dv_cams[5],"data.text"
	    case $86:send_string dv_cams[6],"data.text"	     
	}
    }
}

DATA_EVENT[vdv_Bosh_for_Cam]	// --- Реакция камер на нажатия микрофонов на столе
{
    STRING:
    {
	STACK_VAR INTEGER cam_mic
	cam_mic = atoi(data.text)
	if ( cam_mic>0 )
	    do_push_timed(tp_Congress_Cam_VIP,cam_mic,1)
	Else
	    do_push_timed(tp_Congress_Cam_VIP,All_Presset_active,1)
    }
}
DATA_EVENT[all_Congress_Cam]	// --- Онлайн панелей камер
{
    ONLINE:
    {
	
	[all_Congress_Cam[1],(All_Presset_active-100+1000)] = 1
	[all_Congress_Cam[2],(All_Presset_active-100+1000)] = 1
	[all_Congress_Cam[3],(All_Presset_active-100+1000)] = 1
	[all_Congress_Cam[4],(All_Presset_active-100+1000)] = 1
    }
}

BUTTON_EVENT[all_Congress_Cam,0]		// --- реакция камера на нажатие кнопок на тачпанели (пресеты камер)
{
    push:
    {
	STACK_VAR INTEGER but 
	STACK_VAR Integer pan
	pan = get_last(all_Congress_Cam)
	but = button.input.channel
	
	Flag_hlod = 1
	if (but < 103)
	{
	    [all_Congress_Cam[1],but] = 1
	    [all_Congress_Cam[2],but] = 1
	    [all_Congress_Cam[3],but] = 1
	    [all_Congress_Cam[4],but] = 1
	    do_push_timed(tp_cam_control[pan],(pr[but].cam+10),1)
	    send_string vdv_DGX,"itoa(pr[but].cam+1),'IN151OUT'"
	}
	Else
	if (but < 235)
	{
	    [all_Congress_Cam[1],but] = 1
	    [all_Congress_Cam[2],but] = 1
	    [all_Congress_Cam[3],but] = 1
	    [all_Congress_Cam[4],but] = 1
	    do_push_timed(tp_cam_control[pan],(pr[but].cam+10),1)
	    if (pr[but].cam=6)
		send_string vdv_DGX,"itoa(10),'IN152OUT'"
	    Else
		send_string vdv_DGX,"itoa(10-pr[but].cam),'IN152OUT'"
	}
	Else
	IF ((but>1000)&(But<1011))	// Выбор, какой из общих пресетов показывать
	{
	    All_Presset_active = but - 1000 + 100
	    [all_Congress_Cam[1],but] = 1
	    [all_Congress_Cam[2],but] = 1
	    [all_Congress_Cam[3],but] = 1
	    [all_Congress_Cam[4],but] = 1
	}
    }
    hold[15]:
    {
	STACK_VAR INTEGER but 
	but = button.input.channel
	Flag_hlod = 0
	if (button.input.channel < 235)
	{
	    send_string vdv_Pult_For_Cam,"itoa(pr[but].cam),'cam',itoa(pr[but].presset),'set'"
	}
    }
    RELEASE:
    {
	STACK_VAR INTEGER but 
	but = button.input.channel
	If (Flag_hlod)
	{
	    if (button.input.channel < 235)
	    {
		send_string vdv_Pult_For_Cam,"itoa(pr[but].cam),'cam',itoa(pr[but].presset),'get'"
		
		if (button.input.channel > 200)
		    if (button.input.channel < 224)	// --- Комутация микрофона на кодек ЦУП
			ConnectAudio_Point (InWS_Mic[button.input.channel-200].InNumber,Sumator_12[32].InNumberFirst+2)		// --- Микрофон на HDX CUP 2 вход
		    else
		    if (button.input.channel < 235)	// --- Комутация микрофона на кодек ЦУП
			ConnectAudio_Point (0,Sumator_12[32].InNumberFirst+2)							// --- 0 на HDX CUP 2 вход
	    }
	}
	Flag_hlod = 0
    }
}