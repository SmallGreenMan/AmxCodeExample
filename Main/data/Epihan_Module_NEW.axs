MODULE_NAME='Epihan_Module_NEW'    (dev dv,
				     dev tp)

DEFINE_VARIABLE
VOLATILE Buf_Ep[1000]
VOLATILE Buf_Min[100]
VOLATILE Status[10]		// rec / stop
VOLATILE Integer RecTime
VOLATILE Integer WaitTime
VOLATILE Integer Req_Time


DEFINE_MUTUALLY_EXCLUSIVE
([tp,1],[tp,2])
([tp,10],[tp,11],[tp,12],[tp,13],[tp,14],[tp,15],[tp,16],[tp,17],[tp,18])

DEFINE_START
CREATE_BUFFER dv,Buf_Ep
WaitTime = 10
Req_Time = 1000

DEFINE_CALL 'FB'
{
    if (Status='') SEND_STRING dv,"'STATUS.2',$0D"
    if (find_string(Buf_Ep,"$0A",1))
    {
	Buf_Min = REMOVE_STRING(Buf_Ep,"$0A",1)
	WaitTime = 0
	IF  (FIND_STRING(Buf_Min,"'Rectime.2 '",1))
	{
	    remove_string(Buf_Min,"'Rectime.2 '",1)
	    RecTime = atoi(Buf_Min)
	    send_command tp,"'^TXT-2,0,',itoa(RecTime/60),'.',itoa(RecTime%60)"
	}
	Else
	if (FIND_STRING(Buf_Min,"'Status.2 '",1))
	{
	    remove_string(Buf_Min,"'Status.2 '",1)
	    Status = left_string(Buf_Min,(length_string(Buf_Min)-1))
	    send_command tp,"'^TXT-1,0,',Status"
	    If (FIND_STRING(Status,"'Stopped'",1))
	    {
		[tp,2] = 1
		Req_Time = 1000
	    }
	    Else
	    {
		[tp,1] = 1
		Req_Time = 10
		CANCEL_WAIT 'Req'
	    }
	}
    }
    Else    
	WaitTime = 100
}

DEFINE_EVENT
DATA_EVENT[dv]
{
    online:
    {
	send_command dv, "'SET BAUD 19200,N,8,1 485 DINABLE'"
	Wait(50)
	SEND_STRING dv,"'STATUS.2',$0D"
	Wait(51)
	SEND_STRING dv,"'rectime',$0D"
    }
    STRING:
    {
	WaitTime = 0
	CANCEL_WAIT 'FB_Wait'
    }
}

DATA_EVENT[tp]
{
    STRING:
    {
	SEND_STRING dv,"DATA.TEXT,$0D"
    }
}


DEFINE_PROGRAM
Wait (WaitTime) 'FB_Wait'
    Call 'FB'

Wait(Req_Time) 'REQ'
    SEND_STRING dv,"'rectime',$0D"

