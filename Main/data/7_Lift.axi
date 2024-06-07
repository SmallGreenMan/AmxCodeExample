PROGRAM_NAME='7_Lift'


DEFINE_MUTUALLY_EXCLUSIVE
([dv_Lift,1],[dv_lift,2])

DEFINE_START
COMBINE_DEVICES (vtp_lift,tp_Lift_Main,tp_Lift_Vip)


DEFINE_EVENT
BUTTON_EVENT[vtp_lift,0]
{
    push:
    {
	cancel_wait 'Stop_Lift'
	[dv_lift,BUTTON.INPUT.CHANNEL] = 1
	Wait (50) 'Stop_Lift' 
	{
	    [dv_lift,1] = 0
	    [dv_lift,2] = 0
	}
    }
    release:
	[dv_lift,BUTTON.INPUT.CHANNEL] = 0
}
