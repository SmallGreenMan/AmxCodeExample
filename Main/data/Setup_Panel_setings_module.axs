MODULE_NAME='Setup_Panel_setings_module' (  Dev tp[],
					    Integer realni_BG[],
					    Integer realni_Overlay[],
					    Integer Max_kol_vo_BG[],
					    Integer Button_com[])

DEFINE_DEVICE

DEFINE_CONSTANT


DEFINE_TYPE


DEFINE_VARIABLE
VOLATILE integer i_setup_pan_BG,I,x

DEFINE_START    
for (i_setup_pan_BG = 1 ; i_setup_pan_BG < (LENGTH_ARRAY(tp)) + 1 ; i_setup_pan_BG++)
{
    if (realni_BG[i_setup_pan_BG] < 1) {realni_BG[i_setup_pan_BG] = 4}
    if (realni_Overlay[i_setup_pan_BG] < 1) {realni_Overlay[i_setup_pan_BG] = 55}
}



DEFINE_CALL 'TP_Online' (Integer i_setup_pan_BG_d)
{
	send_level tp[i_setup_pan_BG_d], 1, realni_BG[i_setup_pan_BG_d]
	send_command tp[i_setup_pan_BG_d],"'^TXT-102,0,',itoa(realni_BG[i_setup_pan_BG_d])"
	SEND_COMMAND tp[i_setup_pan_BG_d],"'^BMF-100,0,%OP',itoa(realni_Overlay[i_setup_pan_BG_d])"
	send_command tp[i_setup_pan_BG_d],"'^TXT-101,0,',itoa(realni_Overlay[i_setup_pan_BG_d])"
	send_level tp[i_setup_pan_BG_d], 100, realni_Overlay[i_setup_pan_BG_d]
	if (realni_Overlay[i_setup_pan_BG_d] < 100)
	{
	    if (realni_Overlay[i_setup_pan_BG_d] < 10)
	    {
		send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,29,',itoa(252 - realni_Overlay[i_setup_pan_BG_d])"
	    }
	    else
	    {
		send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,19,',itoa(253 - realni_Overlay[i_setup_pan_BG_d])"
	    }	    
	}
	else
	{
	    send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,9,',itoa(255 - realni_Overlay[i_setup_pan_BG_d])"
	}
	
	SEND_COMMAND tp[i_setup_pan_BG_d],"'^TXT-400,0,',itoa(i_setup_pan_BG_d-1)"
}

DEFINE_EVENT

DATA_EVENT [tp]
{
    ONLINE:
    {
    	stack_var integer i_setup_pan_BG_d_1
	
	i_setup_pan_BG_d_1 = get_last(tp)	
	
	CALL 'TP_Online'(i_setup_pan_BG_d_1)
    }
}

BUTTON_EVENT [tp,Button_com]
{
    Push:
    {
    	stack_var integer i_setup_pan_BG_d
	STACK_VAR integer i_setup_pan_BG_G
	
	i_setup_pan_BG_G = get_last(Button_com)
	i_setup_pan_BG_d = get_last(tp)
	
	switch (i_setup_pan_BG_G)
	{
	    Case 1:
	    {
		If (realni_BG[i_setup_pan_BG_d] = Max_kol_vo_BG[i_setup_pan_BG_d])
		{
		    realni_BG[i_setup_pan_BG_d] = 1
		}
		else
		{
		    realni_BG[i_setup_pan_BG_d] = realni_BG[i_setup_pan_BG_d]+1
		}
	    }
	    Case 2:
	    {
		If (realni_BG[i_setup_pan_BG_d] = 1)
		{
		    realni_BG[i_setup_pan_BG_d] =  Max_kol_vo_BG[i_setup_pan_BG_d]
		}
		else
		{
		    realni_BG[i_setup_pan_BG_d] = realni_BG[i_setup_pan_BG_d]-1
		}	    
	    }
	    Case 3:
	    {
		REBOOT(5003:1:3)
		WAIT(1)
		REBOOT(5002:1:2)
		WAIT(5)
		REBOOT(0)
	    }
	}
	send_level tp[i_setup_pan_BG_d], 1, realni_BG[i_setup_pan_BG_d]
	send_command tp[i_setup_pan_BG_d],"'^TXT-102,0,',itoa(realni_BG[i_setup_pan_BG_d])"
    }
}

level_event [tp, 100]
{
    stack_var integer i_setup_pan_BG_d
	
    i_setup_pan_BG_d = get_last(tp)
    if (LEVEL.VALUE > 0)
    {
	realni_Overlay[i_setup_pan_BG_d] = LEVEL.VALUE
	
	SEND_COMMAND tp[i_setup_pan_BG_d],"'^BMF-100,0,%OP',itoa(realni_Overlay[i_setup_pan_BG_d])"
	send_command tp[i_setup_pan_BG_d],"'^TXT-101,0,',itoa(realni_Overlay[i_setup_pan_BG_d]),' -'"
	if (realni_Overlay[i_setup_pan_BG_d] < 100)
	{
	    if (realni_Overlay[i_setup_pan_BG_d] < 10)
	    {
		send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,29,',itoa(252 - realni_Overlay[i_setup_pan_BG_d])"
	    }
	    else
	    {
		send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,19,',itoa(253 - realni_Overlay[i_setup_pan_BG_d])"
	    }	    
	}
	else
	{
	    send_command tp[i_setup_pan_BG_d],"'^JST-101,0,0,9,',itoa(255 - realni_Overlay[i_setup_pan_BG_d])"
	}
    }
}

DEFINE_PROGRAM
