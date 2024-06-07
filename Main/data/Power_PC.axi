PROGRAM_NAME='Power_PC'

// --- Формат команды 1:1 Какйо девайс,что сделать
//dvPortPC = 0:2:0;    	 // 0:2:0 is the first available IP port, 0:3:0 is the next, etc.
//TP_PowerPC = 10050:93:1;  	 // The touch panel
DEFINE_VARIABLE
CommandOnPC[500]
dev tp_PowerPC [] = 
{
    TP_PowerPC_17,
    TP_PowerPC_Ipad
}

CHAR PC_MAC_Address[6]
PC_IP_Address[15]
LONG PC_Port

Integer On_Off_Line_Flag
LONG error
slong snResult    = 99
integer nSTART[6] = {$FF,$FF,$FF,$FF,$FF,$FF}
strMAC[6] = {$d0,$27,$88,$77,$6f,$6d} 

Integer Button_Power_Control [] =
{
    1001,1002,1003		// выклюечение , перезагрузка , включение
}

DEFINE_CALL 'MassageOnPC'
{
    WAIT(15)
    {
	IP_CLIENT_CLOSE(dvPortPC.port);
	IP_CLIENT_OPEN (dvPortPC.port,PC_IP_Address,PC_Port,IP_TCP);
    }
}
DEFINE_CALL 'Broadcast_Send'
{
    snResult =IP_CLIENT_OPEN (dvIP.port,'255.255.255.255', 2304, 2)
    SEND_STRING dvIP,"nSTART,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC,strMAC"
    IP_CLIENT_CLOSE (dvIP.port)
}
    
DEFINE_START
[5001:8:1,5] = 1
On_Off_Line_Flag = 2

PC_Port = 943

PC_IP_Address = "'25.100.4.148'"

PC_MAC_Address = "$d0,$27,$88,$77,$6f,$6d"


DEFINE_EVENT

DATA_EVENT[dvPortPC]
{
   ONLINE:
   {      
	WAIT(10)
	{
	 On_Off_Line_Flag = 1
	 SEND_STRING dvPortPC,"CommandOnPC,$0D,$0A"
	 IP_CLIENT_CLOSE(dvPortPC.port);
	 CommandOnPC = ''
	}
   }
   OFFLINE:
   {
	On_Off_Line_Flag = 0
   }
   ONERROR:{error=Data.NUMBER}
}

BUTTON_EVENT[TP_PowerPC,0]
{
    push:
    {
	CommandOnPC = ''
	SWITCH(BUTTON.INPUT.CHANNEL)
	{
	   
	    Case 1:{CommandOnPC = '111'}
	    Case 2:{CommandOnPC = '222'}
	    Case 3:{CALL 'Broadcast_Send'}
	}
	If (CommandOnPC<>'')	CALL 'MassageOnPC'
    }
}
BUTTON_EVENT[TP_PowerPC,3999]		// --- Физический размыкаме питание (релле)
{
    Push:
    {
	[5001:8:1,5] = 0
	Wait(50) 'PC_Power_Wait' 
	    [5001:8:1,5] = 1
    }
}