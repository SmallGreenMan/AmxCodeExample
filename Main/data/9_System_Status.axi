PROGRAM_NAME='9_System_Status'

DEFINE_START

DEFINE_VARIABLE
VOLATILE Integer Sys_Stat_dv[50],Sys_Stat_tp[50]
VOLATILE INTEGER Sys_sat_i
dev dv_Sys_Stat [] =
{
    dv_Main_1,
    dv_COM_in_main_1,
    dv_COM_in_main_2,
    dv_COM_in_main_3,
    dv_COM_in_main_4,
    
    dv_COM_in_K1_1,
    dv_COM_in_K1_2, 
    dv_COM_in_K1_3,
    dv_COM_in_K1_4,
    dv_COM_in_K1_5,
    dv_COM_in_K1_6,
    dv_COM_in_K1_7,
    dv_IO_in_K1_1,
    dv_REL_in_K1_1,    
// --- System_2
    dv_Main_2,
    dv_COM_in_K2_1,
    dv_COM_in_K2_2,
    dv_COM_in_K2_3,
    dv_COM_in_K2_4,  
    dv_COM_in_K2_5,  
    dv_IO_in_K2_1,
    dv_REL_in_K2_1,
// --- System_3
    dv_Main_3
}
dev tp_Sys_Stat [] =
{
    tp_SystemStatus_17,
    tp_SystemStatus_7_Debug,
    tp_SystemStatus_7_1,
    tp_SystemStatus_7_2,
    tp_SystemStatus_7_3,
    tp_SystemStatus_7_4,
    tp_SystemStatus_7_5,
    tp_SystemStatus_7_6,
    tp_SystemStatus_7_7,
    tp_SystemStatus_7_8,
    tp_SystemStatus_7_9,
    tp_SystemStatus_7_10,
    tp_SystemStatus_7_11,
    tp_SystemStatus_7_12,
    tp_SystemStatus_7_13,
    tp_SystemStatus_7_14,
    tp_SystemStatus_7_15,
    tp_SystemStatus_7_16,
    tp_SystemStatus_7_17,
    tp_SystemStatus_7_18,
    tp_SystemStatus_7_19,
    tp_SystemStatus_7_20,
    tp_SystemStatus_7_21,
    tp_SystemStatus_7_22,
    tp_SystemStatus_7_23,
    
    tp_SystemStatus_Raznov,
    tp_SystemStatus_Gref,
    tp_SystemStatus_VIP_Zona,
    tp_SystemStatus_VideoWall
}

// --- Вкючение\Выключение панелей ---
VOLATILE Integer Flags_Panel_Logo[23]

DEFINE_CALL 'dv_tp_Online'
{
    STACK_VAR Integer tp_i
    for(tp_i = 1;tp_i < 51;tp_i++)
    {
	[tp_SystemStatus_17,tp_i] = Sys_Stat_dv[tp_i]
	[tp_SystemStatus_17,tp_i+100] = Sys_Stat_tp[tp_i]
    }
}

DEFINE_EVENT
DATA_EVENT[tp_SystemStatus_17]
{
    ONLINE:
    {
	STACK_VAR Integer i_s
	for(i_s=1;i_s<24;i_s++)
	    [tp_SystemStatus_17,i_s+500] = Flags_Panel_Logo[i_s]
    }
}
BUTTON_EVENT[tp_SystemStatus_17,0]	
{
    PUSH:
    {
	STACK_VAR Integer but 
	STACK_VAR Integer i_s
	but = button.input.channel
	
	if ((but>102)&(but<127))	// --- Прямое управление Logo паенелей аналитиков
	{
	    If (Flags_Panel_Logo[but-102]=1)
	    {
		Flags_Panel_Logo[but-102] = 0
		[tp_SystemStatus_17,but-102+500] = 0
		send_command tp_Sys_Stat[but-102+2],"'PAGE-Main'"
	    }
	    Else
	    {
		Flags_Panel_Logo[but-102] = 1
		[tp_SystemStatus_17,but-102+500] = 1
		send_command tp_Sys_Stat[but-102+2],"'PAGE-Logo'"
	    }
	}
	Else
	SWITCH(but)
	{
	    case 1:{reboot (0:1:0)}
	    case 15:{reboot (0:1:2)}
	    case 23:{reboot (0:1:3)}
	    
	    
	    Case 1000:			// --- Update
	    {	
		CALL 'dv_tp_Online'
	    }
	    
	    Case 499:			// --- Управление OFF
	    {
		for(i_s=1;i_s<24;i_s++)
		{
		    Flags_Panel_Logo[i_s] = 1
		    [tp_SystemStatus_17,i_s+500] = 1
		    send_command tp_Sys_Stat[i_s+2],"'PAGE-Logo'"
		}
	    }
	    Case 500:			// --- Управление ON
	    {
		for(i_s=1;i_s<24;i_s++)
		{
		    Flags_Panel_Logo[i_s] = 0
		    [tp_SystemStatus_17,i_s+500] = 0
		    send_command tp_Sys_Stat[i_s+2],"'PAGE-Main'"
		}
	    }
	}
    }
}
DATA_EVENT[dv_Sys_Stat]		// --- Status Девайсов
{
    online:
    {
	Sys_sat_i = get_last(dv_Sys_Stat)
	Sys_Stat_dv[Sys_sat_i] = 1
	[tp_SystemStatus_17,Sys_sat_i] = 1
	if ((Sys_Stat_dv[2]=0)|(Sys_Stat_dv[3]=0)|(Sys_Stat_dv[4]=0)|(Sys_Stat_dv[5]=0)|(Sys_Stat_dv[6]=0)|
	    (Sys_Stat_dv[7]=0)|(Sys_Stat_dv[8]=0)|(Sys_Stat_dv[9]=0)|(Sys_Stat_dv[10]=0)|(Sys_Stat_dv[11]=0)|
	    (Sys_Stat_dv[12]=0)|(Sys_Stat_dv[13]=0)|(Sys_Stat_dv[14]=0)|(Sys_Stat_dv[15]=0))
	    [ tp_SystemStatus_17,4000] = 1
	Else
	    [ tp_SystemStatus_17,4000] = 0
    }
    offline:
    {
	Sys_sat_i = get_last(dv_Sys_Stat)
	Sys_Stat_dv[Sys_sat_i] = 0
	[tp_SystemStatus_17,Sys_sat_i] = 0
	if ((Sys_Stat_dv[2]=0)|(Sys_Stat_dv[3]=0)|(Sys_Stat_dv[4]=0)|(Sys_Stat_dv[5]=0)|(Sys_Stat_dv[6]=0)|
	    (Sys_Stat_dv[7]=0)|(Sys_Stat_dv[8]=0)|(Sys_Stat_dv[9]=0)|(Sys_Stat_dv[10]=0)|(Sys_Stat_dv[11]=0)|
	    (Sys_Stat_dv[12]=0)|(Sys_Stat_dv[13]=0)|(Sys_Stat_dv[14]=0)|(Sys_Stat_dv[15]=0))
	    [ tp_SystemStatus_17,4000] = 1
	Else
	    [ tp_SystemStatus_17,4000] = 0
    }
}
DATA_EVENT[tp_Sys_Stat]		// --- Status Панелей
{
    online:
    {
	Sys_sat_i = get_last(tp_Sys_Stat)
	Sys_Stat_tp[Sys_sat_i] = 1
	[tp_SystemStatus_17,Sys_sat_i+100] = 1
    }
    offline:
    {
	Sys_sat_i = get_last(tp_Sys_Stat)
	Sys_Stat_tp[Sys_sat_i] = 0
	[tp_SystemStatus_17,Sys_sat_i+100] = 0
    }
}





DATA_EVENT[tp_SystemStatus_17]
{
    online:
    {
	CALL 'dv_tp_Online'
    }
}
