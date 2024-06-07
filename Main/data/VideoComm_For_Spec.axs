MODULE_NAME='VideoComm_For_Spec' (  dev vdv,
				    dev tp,
				    integer i,
				    Integer PC[],
				    char VDV_AdderLink[],
				    Integer Matrix_AdderLink_Pressets[][])
DEFINE_VARIABLE
VOLATILE Integer in,out,monitor_1_2,o
VOLATILE Integer but

DEFINE_EVENT
data_event[tp]
{
    online:
    {
	cancel_wait 'start_wait'
	Wait(140) 'start_wait'
	{
	    for(o=3;o<6;o++)
		if (Matrix_AdderLink_Pressets[1][o])
		    send_command tp, "'^SHO-',itoa(200+o),',1'"
		else
		    send_command tp, "'^SHO-',itoa(200+o),',0'"
	}
    }
}
BUTTON_EVENT[tp,0]
{
    PUSH:
    {
	but = button.input.channel
	select
	{
	    ACTIVE((but>1200)&(but<1203)):	// --- Out Мониторы
	    {
		monitor_1_2 = but - 1200
		out = but - 1201 + i*2 + 47
	    }
	    ACTIVE((but>1000)&(but<1161)):	// --- Out Мониторы
	    {
		out = but - 1000
	    }
	    ACTIVE((but>200)&(but<206)):	// --- In Компы, привязка к местам
	    {
		In = but - 200
		send_string vdv,"itoa(Out),'IN',itoa(Out),'OUT'"
		if (Matrix_AdderLink_Pressets[monitor_1_2][In])
		    VDV_AdderLink = "VDV_AdderLink,itoa(Matrix_AdderLink_Pressets[monitor_1_2][In]),'!'"
	    }
	    ACTIVE((but>0)&(but<161)):	// --- In
	    {
		    In = But
		send_string vdv,"itoa(In),'IN',itoa(Out),'OUT'"
		if (Matrix_AdderLink_Pressets[monitor_1_2][1])
		    VDV_AdderLink = "VDV_AdderLink,itoa(Matrix_AdderLink_Pressets[monitor_1_2][monitor_1_2]),'!'"
	    }
	    ACTIVE(but=1000):	// --- In
	    {
		send_string vdv,"'0IN',itoa(Out),'OUT'"
		if (Matrix_AdderLink_Pressets[monitor_1_2][1])
		    VDV_AdderLink = "VDV_AdderLink,itoa(Matrix_AdderLink_Pressets[monitor_1_2][monitor_1_2]),'!'"
	    }
	}
    }
}