MODULE_NAME='Video_com_For_Kab_Module' (dev vdv,
					dev tp)
DEFINE_VARIABLE
VOLATILE Integer in,out
VOLATILE Integer but

DEFINE_EVENT
BUTTON_EVENT[tp,0]
{
    PUSH:
    {
	but = button.input.channel
	select
	{
	    ACTIVE((but>1000)&(but<1161)):	// --- Out
	    {
		out = but - 1000
	    }
	    ACTIVE((but>0)&(but<161)):	// --- In
	    {
		In = but
		send_string vdv,"itoa(In),'IN',itoa(Out),'OUT'"
	    }
	    ACTIVE(but=1000):	// --- In
	    {
		send_string vdv,"'0IN',itoa(Out),'OUT'"
	    }
	    ACTIVE(but=2500):
	    {
		send_string vdv,"'2500IN',itoa(Out),'OUT'"
	    }
	    ACTIVE(but=3038):
	    {
		send_string vdv,"'2500IN38OUT'"
	    }
	    ACTIVE(but=3037):
	    {
		send_string vdv,"'2500IN37OUT'"
	    }
	}
    }
}