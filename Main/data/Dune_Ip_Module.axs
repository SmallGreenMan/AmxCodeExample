MODULE_NAME='Dune_Ip_Module'(dev dv,
			     dev tp,
			     char cServerAddress[])


DEFINE_VARIABLE
CONSTANT LONG lServerPort = 80
VOLATILE Integer IP_Open
VOLATILE Integer Open_status

VOLATILE sCmd [52][8]
VOLATILE Cmd[200]

	VOLATILE cmdcmd[100]

VOLATILE Buff[1000]

    volatile Integer tConect = 1 
    volatile Integer tDConect = 0
    
    VOLATILE end1[10]

DEFINE_START	
    end1 = "$0d,$0A,$0d,$0A"
    create_buffer dv,Buff

    // --- Определение команд управления
    sCmd[1] =   'F40BBF00'; 		// 1
    sCmd[2] =   'F30CBF00'; 		// 2
    sCmd[3] =   'F20DBF00'; 		// 3
    sCmd[4] =   'F10EBF00'; 		// 4
    sCmd[5] =   'F00FBF00'; 		// 5
    sCmd[6] =   'FE01BF00'; 		// 6
    sCmd[7] =   'EE11BF00'; 		// 7
    sCmd[8] =   'ED12BF00'; 		// 8
    sCmd[9] =   'EC13BF00'; 		// 9
    sCmd[10] =  'F50ABF00'; 		// 0
	
    sCmd[11] =  'EA15BF00'; 		// UP
    sCmd[12] =  'E916BF00'; 		// DOWN
    sCmd[13] =  'E817BF00'; 		// LEFT
    sCmd[14] =  'E718BF00'; 		// RIGHT
    sCmd[15] =  'EB14BF00'; 		// ENTER
    sCmd[16] =  'FB04BF00'; 		// RETURN
    sCmd[17] =  'AF50BF00'; 		// INFO
    sCmd[18] =  'F807BF00'; 		// POP UP MENU
    sCmd[19] =  'AE51BF00'; 		// TOP MENU
	
    sCmd[20] =  'B748BF00'; 		// PLAY
    sCmd[21] =  'E11EBF00'; 		// PAUSE
    sCmd[22] =  'B649BF00'; 		// PREV
    sCmd[23] =  'E21DBF00'; 		// NEXT
    sCmd[24] =  'E619BF00'; 		// STOP
    sCmd[25] =  'E51ABF00'; 		// SLOW
    sCmd[26] =  'E31CBF00'; 		// REW
    sCmd[27] =  'E41BBF00'; 		// FWD
	
    sCmd[28] =  'A05FBF00'; 		// DISCRETE-POWER-ON
    sCmd[29] =  'A15EBF00'; 		// DISCRETE-POWER-OFF
	
    sCmd[30] =  'EF10BF00';		// EJECT
    sCmd[31] =  'B946BF00';		// MUTE
    sCmd[32] =  'BA45BF00';       	// MODE
    sCmd[33] =  'BC43BF00';		// POWER
	
    sCmd[34] =  'BF40BF00';		// A
    sCmd[35] =  'E01FBF00';		// B
    sCmd[36] =  'FF00BF00';		// C
    sCmd[37] =  'BE41BF00'; 		// D

    sCmd[38] =  'FA05BF00'; 		// CLEAR
    sCmd[39] =  'BD42BF00'; 		// SELECT
                             
    sCmd[40] =  'AD52BF00'; 		// V+
    sCmd[41] =  'AC53BF00'; 		// V-
    sCmd[42] =  'B44BBF00'; 		// P+
    sCmd[43] =  'B34CBF00'; 		// P-
    sCmd[44] =  'F906BF00'; 		// SEARCH
    sCmd[45] =  'FD02BF00'; 		// ZOOM
    sCmd[46] =  'B14EBF00'; 		// SETUP 
	
    sCmd[47] =  'AB54BF00'; 		// SUBTITLE
    sCmd[48] =  'B24DBF00'; 		// ANGLE/ROTARE
    sCmd[49] =  'BB44BF00'; 		// AUDIO
    sCmd[50] =  'B04FBF00'; 		// REPEAT
    sCmd[51] =  'B847BF00'; 		// SHUFFLE/PIP
    sCmd[52] =  'FC03BF00'; 		// URL/2nd audio

DEFINE_EVENT
DATA_EVENT[dv]	// --- обработка конекта к девайсу
{
   ONLINE:
   {    
	Open_status = 1
	if (length_string(Cmd))
	{
	    send_string dv, Cmd
	    cmd = ''
	}
	IP_Open = 0
	IP_CLIENT_CLOSE(dv.port)
   }

   OFFLINE:
   {
	Open_status = 0
	wait(2)
	IF (IP_Open = 1)
            IP_CLIENT_OPEN(dv.port,cServerAddress,lServerPort,IP_TCP);
   }
   
   STRING:
   {
   }	
   
   ONERROR:
   {
	SWITCH(DATA.NUMBER)
	{
	    CASE 9:     // Socket closed in response to IP_CLIENT_CLOSE
	    CASE 17:    // String was sent to a closed socket 
	    {
	    }
	    DEFAULT:   // All other errors.  May want to re-try connection
	    {   
		IF (IP_Open = 1)
		    WAIT(1)
		       IP_CLIENT_OPEN(dv.port,cServerAddress,lServerPort,IP_TCP);
	    }
	}
   }
} 

BUTTON_EVENT[tp,0]
{
    push:
    {
	Cmd =  "'GET /cgi-bin/do?cmd=ir_code&ir_code=',sCmd[BUTTON.INPUT.CHANNEL],end1"
	IP_Open = 1
	IP_CLIENT_OPEN(dv.port,cServerAddress,lServerPort,IP_TCP);
    }
    Hold[4,repeat]:
    {
	if ((BUTTON.INPUT.CHANNEL>10)&(BUTTON.INPUT.CHANNEL<15))
	{
		Cmd =  "'GET /cgi-bin/do?cmd=ir_code&ir_code=',sCmd[BUTTON.INPUT.CHANNEL],end1"
		IP_Open = 1
		IP_CLIENT_OPEN(dv.port,cServerAddress,lServerPort,IP_TCP);
	}
    }
}
 