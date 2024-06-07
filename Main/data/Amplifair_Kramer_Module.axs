MODULE_NAME='Amplifair_Kramer_Module' (dev dv,
				       dev tp[],
				       Float Vol[8])

DEFINE_VARIABLE
CONSTANT LONG TL1 = 1
LONG TimeArray[8] =
{
500, //
500, //
500, //
500, //
500, //
500, //
500, //
500  //
}


VOLATILE fb_delay
VOLATILE Buf_amp[1000]
VOLATILE mini_amp[4]
VOLATILE data_send[6]
VOLATILE a
VOLATILE b
VOLATILE c
VOLATILE d

Integer Mute[8]

DEFINE_START
CREATE_BUFFER	dv,buf_amp
fb_delay = 50

DEFINE_FUNCTION Amp_to_Panel (Integer n)
{
    SEND_LEVEL tp[n],1,Vol[n]
    data_send = ftoa((Vol[n]-192)/2)
    if (find_string(data_send,"'.'",1)){}
    Else {data_send = "data_send,'.0'"}
    SEND_COMMAND tp[n],"'^TXT-1,0,',data_send"
}

DEFINE_CALL 'fb'	// --- Фидбек
{
    If (length_string(buf_amp))
    {
	fb_delay = 0 
	mini_amp = left_string(buf_amp,4)
	remove_string(buf_amp,mini_amp,1)
	a = mini_amp[1]&$3F
	if ((a = "$19")|(a = "$16"))
	{
	    b = mini_amp[2]&$0F
	    c = mini_amp[3]
	    d = mini_amp[4]&$20
	    if (d = "$20")
		Vol[b] = c
	    else
	    {
		if ((c - 128)>2)
		    Vol[b] = c - 128
	    }
	    Amp_to_Panel (b)
	}
    }
    else
    {
	fb_delay = 100
    }
}

DEFINE_EVENT
TIMELINE_EVENT[TL1] 	// --- Опрос усилителей
{
    switch(Timeline.Sequence)
    {
	case 1: {send_string dv,"$19,$81,$81,$81"}
	case 2: {send_string dv,"$19,$82,$81,$81"}
	case 3: {send_string dv,"$19,$83,$81,$81"}
	case 4: {send_string dv,"$19,$84,$81,$81"}
	case 5: {send_string dv,"$19,$85,$81,$81"}
	case 6: {send_string dv,"$19,$86,$81,$81"}
	case 7: {send_string dv,"$19,$87,$81,$81"}
	case 8: {send_string dv,"$19,$88,$81,$81"}
    }
}


DATA_EVENT[dv]		// --- Онлайн девайса
{
    online:
    {
	send_command dv,"'SET BAUD 9600,N,8,1 485 DINABLE'"
	Wait(30)
	    TIMELINE_CREATE (TL1,TimeArray,8,TIMELINE_RELATIVE,TIMELINE_ONCE)
    }
    String:
    {
	fb_delay = 0
	CANCEL_WAIT 'fb_wait'
    }
}
data_event[tp]		// --- Оналайн панели
{
    ONLINE:
    {
	STACK_VAR Integer y
	y = get_last(tp)
	
	Amp_to_Panel (y)
    }
}

BUTTON_EVENT[tp,0]
{
    push:
    {
	stack_var Integer pan
	stack_var Integer btn
	pan = get_last(tp)
	btn = button.input.channel
	
	switch(btn)
	{
	    Case 1:					// +
	    {
		SEND_STRING dv,"$18,$80+pan,$80,$81"
	    }
	    
	    
	    Case 2:					// -
	    {
		SEND_STRING dv,"$18,$80+pan,$81,$81"
	    }
	    Case 1000:{TIMELINE_CREATE (TL1,TimeArray,8,TIMELINE_RELATIVE,TIMELINE_ONCE)}
	}
    }
    HOLD[1,repeat]:
    {
	stack_var Integer pan
	stack_var Integer btn
	pan = get_last(tp)
	btn = button.input.channel
	
	switch(btn)
	{
	    Case 1:{SEND_STRING dv,"$18,$80+pan,$80,$81"}	// +
	    Case 2:{SEND_STRING dv,"$18,$80+pan,$81,$81"}	// -
	}
    }
}

DEFINE_PROGRAM
wait (fb_delay) 'fb_wait'
    call 'fb'