MODULE_NAME='Sony_Camera_Module'(dev dv[],
				 dev tp,
				 dev vdv)

DEFINE_VARIABLE
VOLATILE Integer max_dv
VOLATILE Integer Cam_x_speed,Cam_x,Cam_y_speed,Cam_y 
Integer Active_Cam
VOLATILE Integer Push_and_Hold


DEFINE_START
max_dv = max_length_array(dv)
If (Active_Cam=0) Active_Cam = 1
Cam_x = 3
Cam_y = 3
Cam_x_speed = 1
Cam_y_speed = 1


DEFINE_MUTUALLY_EXCLUSIVE
([tp,11],[tp,12],[tp,13],[tp,14],[tp,15],[tp,16],[tp,17],[tp,18],[tp,19],[tp,20])

DEFINE_CALL 'cam_PTZ'
{
    send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,Cam_x_speed,Cam_y_speed,Cam_x,Cam_y,$ff"
}


DEFINE_EVENT
DATA_EVENT[tp]		// --- Онлайн панели
{
    ONLINE:{send_level tp,1,10;send_level tp,2,10;send_level tp,3,7;[tp,Active_Cam+10] = 1}
}
DATA_EVENT[vdv]		// --- Управление пресетами при помощи виртуланого девайса //1cam2get - or 1cam2set
{
    string:
    {
	STACK_VAR Integer cam_push
	STACK_VAR Integer Preset
	cam_push = atoi(remove_string(data.text,"'cam'",1))
	if (find_string(data.text,"'set'",1))
	{
	    Preset = atoi(data.text)
	    send_string dv[cam_push],"128+cam_push,$01,$04,$3F,$01,Preset-1,$ff"
	}
	else
	if (find_string(data.text,"'get'",1))
	{
	    Preset = atoi(data.text)
	    send_string dv[cam_push],"128+cam_push,$01,$04,$3F,$02,Preset-1,$ff"
	}
    }
}

BUTTON_EVENT[tp,0]
{
    PUSH:
    {
	Push_and_Hold = 1
	SWITCH(BUTTON.INPUT.CHANNEL)
	{
	    Case 1:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,$08,$08,$03,$01,$ff"}	// --- up
	    Case 2:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,$08,$08,$03,$02,$ff"}	// --- down
	    Case 3:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,$08,$08,$01,$03,$ff"}	// --- left
	    Case 4:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,$08,$08,$02,$03,$ff"}	// --- right
	    
	    Case 5:{send_string dv[Active_Cam],"128+Active_Cam,$01,$7E,$01,$02,$00,$01,$ff"}	// --- Ok
	    Case 6:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$06,$10,$ff"}		// --- Menu
	    
	    Case 10:{send_string dv[Active_Cam],"128+Active_Cam,$01,$06,$01,$05,$05,$03,$03,$FF"}	// --- Stop
	    
	    case 21:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$00,$02,$FF"}		// --- ON
	    case 22:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$00,$03,$FF"}		// --- OFF
	    
	}
	if ((BUTTON.INPUT.CHANNEL>10)&(BUTTON.INPUT.CHANNEL<20))
	{
	    Active_Cam = button.input.channel-10;[tp,Active_Cam+10] = 1
	}
    }
    Hold[15]:	// Сохраниние пресета
    {
	Push_and_Hold = 0
	If (BUTTON.INPUT.CHANNEL>100)
	    send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$3F,$01,BUTTON.INPUT.CHANNEL-101,$ff"
    }
    RELEASE:	// Вызов пресета
    {
	If (BUTTON.INPUT.CHANNEL>100)
	    If (Push_and_Hold)
		send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$3F,$02,BUTTON.INPUT.CHANNEL-101,$ff"
	Push_and_Hold = 0
    }
}
LEVEL_EVENT[tp,1]		// --- X
{
    SWITCH(LEVEL.VALUE)
    {
	Case 1:{Cam_x_speed = 18;Cam_x = 1}
	Case 2:{Cam_x_speed = 16;Cam_x = 1}
	Case 3:{Cam_x_speed = 14;Cam_x = 1}
	Case 4:{Cam_x_speed = 12;Cam_x = 1}
	Case 5:{Cam_x_speed = 10;Cam_x = 1}
	Case 6:{Cam_x_speed = 8;Cam_x = 1}
	Case 7:{Cam_x_speed = 4;Cam_x = 1}
	Case 8:{Cam_x_speed = 2;Cam_x = 1}
	Case 9:{Cam_x_speed = 1;Cam_x = 1}
	Case 10:{Cam_x_speed = 1;Cam_x = 3}
	Case 11:{Cam_x_speed = 1;Cam_x = 2}
	Case 12:{Cam_x_speed = 2;Cam_x = 2}
	Case 13:{Cam_x_speed = 4;Cam_x = 2}
	Case 14:{Cam_x_speed = 8;Cam_x = 2}
	Case 15:{Cam_x_speed = 10;Cam_x = 2}
	Case 16:{Cam_x_speed = 12;Cam_x = 2}
	Case 17:{Cam_x_speed = 14;Cam_x = 2}
	Case 18:{Cam_x_speed = 16;Cam_x = 2}
	Case 19:{Cam_x_speed = 18;Cam_x = 2}
    }
    cancel_wait 'Start_cam'
    Wait(1)'Start_cam'
	CALL 'cam_PTZ'
}
LEVEL_EVENT[tp,2]		// --- Y
{
    SWITCH(LEVEL.VALUE)
    {
	Case 1:{Cam_y_speed = 18;Cam_y = 1}
	Case 2:{Cam_y_speed = 16;Cam_y = 1}
	Case 3:{Cam_y_speed = 14;Cam_y = 1}
	Case 4:{Cam_y_speed = 12;Cam_y = 1}
	Case 5:{Cam_y_speed = 10;Cam_y = 1}
	Case 6:{Cam_y_speed = 8;Cam_y = 1}
	Case 7:{Cam_y_speed = 4;Cam_y = 1}
	Case 8:{Cam_y_speed = 2;Cam_y = 1}
	Case 9:{Cam_y_speed = 1;Cam_y = 1}
	Case 10:{Cam_y_speed = 1;Cam_y = 3}
	Case 11:{Cam_y_speed = 1;Cam_y = 2}
	Case 12:{Cam_y_speed = 2;Cam_y = 2}
	Case 13:{Cam_y_speed = 4;Cam_y = 2}
	Case 14:{Cam_y_speed = 8;Cam_y = 2}
	Case 15:{Cam_y_speed = 10;Cam_y = 2}
	Case 16:{Cam_y_speed = 12;Cam_y = 2}
	Case 17:{Cam_y_speed = 14;Cam_y = 2}
	Case 18:{Cam_y_speed = 16;Cam_y = 2}
	Case 19:{Cam_y_speed = 18;Cam_y = 2}
    }
    cancel_wait 'Start_cam'
    Wait(1)'Start_cam'
	CALL 'cam_PTZ'
}
LEVEL_EVENT[tp,3]		// --- Zoom
{
    SWITCH(Level.VALUE)
    {
	//8x 01 04 07 2Z FF
	Case 1:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$27,$ff"}
	Case 2:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$26,$ff"}
	Case 3:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$25,$ff"}
	Case 4:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$24,$ff"}
	Case 5:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$23,$ff"}
	Case 6:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$22,$ff"}
	Case 7:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$00,$ff"}
	Case 8:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$32,$ff"}
	Case 9:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$33,$ff"}
	Case 10:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$34,$ff"}
	Case 11:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$35,$ff"}
	Case 12:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$36,$ff"}
	Case 13:{send_string dv[Active_Cam],"128+Active_Cam,$01,$04,$07,$37,$ff"}
	
    }
}