MODULE_NAME='DCN_Mudule_VAV' (dev dv,
			      dev tp,
			      dev vdv_Cam)

DEFINE_CONSTANT			// --- ��������� ���������� DCN
Kol_vo_MIC = 14
Main_MIC = 1			// �������� ������������
Delay_Opros_Mic = 2		// �������� ������ ����������

csHEADER[]			        = {$1B,$24,$0D}
csMDSC_REMOTEPROCEDURE_REQ[]	        = {$03}
csMDSC_REMOTEPROCEDURE_RSP[]		= {$04}
csMDSC_NOTIFY[]				= {$05}

//Application Headers
csDCNC_APP_AT[]				= {$09}
csDCNC_APP_SI[]				= {$11}
csDCNC_APP_SC[]				= {$10}
csDCNC_APP_MM[]				= {$00}

// --- Master Volume
SI_C_SET_MASTER_VOL[]			= {$0A}

    DCNC_DEFAULT_MASTERVOLUME[]		= {$0C}


// --- Wirelienss 
SI_C_SET_WIRELESS_MODE[]		= {$17}	//#define SI_C_SET_WIRELESS_MODE ( MKWORD (23 , DCNC_APP_SI) )
SI_C_GET_WIRELESS_MODE[]		= {$16} //#define SI_C_GET_WIRELESS_MODE ( MKWORD (22 , DCNC_APP_SI) )
    //	typedef BYTE SI_T_WIRELESS_MODE;
    SI_C_WIRELESS_MODE_ON[] 		= {$00}
    SI_C_WIRELESS_MODE_SLEEP[] 		= {$01}
    SI_C_WIRELESS_MODE_OFF[] 		= {$02}
    SI_C_WIRELESS_MODE_SUBSCRIPTION[] 	= {$03}	// �������� ���������� � ������
    
SI_C_UNSUBSCRIBE_REQ[]			= {$1D}	// ��������� �������� ���������� � ������

//Microphone Management Application Commands
csMM_C_START_MM[]			= {$1E}
csMM_C_STOP_MM[]			= {$1F}
csMM_C_GET_SETTINGS[]			= {$20}
csMM_C_SET_SETTINGS[]			= {$21}
csMM_C_SET_MIC_OPER_MODE[]		= {$34}
csMM_C_SET_ACTIVE_MICS[]		= {$35}

//Speaker List Function Commands
csMM_C_SET_MICRO_ON_OFF[]		= {$22}
csMM_C_SPK_APPEND[]			= {$30}
csMM_C_SPK_REMOVE[]			= {$31}
csMM_C_SPK_CLEAR[]			= {$2F}
csMM_C_SPK_GET[]			= {$2E}

//Request to Speak List Function Commands
csMM_C_SHIFT[]				= {$23}
csMM_C_RTS_APPEND[]			= {$3E}
csMM_C_RTS_REMOVE[]			= {$27}
csMM_C_RTS_CLEAR[]			= {$26}
csMM_C_RTS_GET[]			= {$25}

//������� ��������
csMM_C_NBK_GET[]			= {$2B}

//Operation Modes
csMM_C_OPERATOR_WITH_REQ_LIST[]		= {$00,$00}
csMM_C_DELEGATE_WITH_REQ_LIST[]		= {$01,$00}
csMM_C_DELEGATE_WITH_OVERRIDE[]		= {$02,$00}
csMM_C_DELEGATE_WITH_VOICE[]		= {$03,$00}
csMM_C_OPERATOR_WITH_COMMENT_LIST[]	= {$04,$00}

//Notify Events
csMM_C_SET_MIC_OPER_MODE_ON_PC[]	= {$12}
csMM_C_SET_ACTIVE_MICS_ON_PC[]		= {$13}
csMM_C_SET_SETTINGS_ON_PC[]		= {$15}
csMM_C_MICRO_ON_OFF[]			= {$01}
csMM_C_SPK_SET_ON_PC[]			= {$0C}
csMM_C_SPK_CLEAR_ON_PC[]		= {$0D}
csMM_C_SPK_APPEND_ON_PC[]		= {$0E}
csMM_C_SPK_REMOVE_ON_PC[]		= {$0F}
csMM_C_SPK_INSERT_ON_PC[]		= {$10}
csMM_C_SPK_REPLACE_ON_PC[]		= {$11}
csMM_C_RTS_SET_ON_PC[]			= {$04}
csMM_C_RTS_CLEAR_ON_PC[]		= {$05}
csMM_C_RTS_REMOVE_ON_PC[]		= {$06}
csMM_C_RTS_FIRST_ON_PC[]		= {$14}
csMM_C_RTS_INSERT_ON_PC[]		= {$07}
csMM_C_RTS_REPLACE_ON_PC[]		= {$08}
//Other constants
ciNUMSTATIONS				= 200
ciSPEAKERSIZE				= 4
ciREQUESTSIZE				= 10
ciDELEGATE				= 2
ciMUTE					= 2
ciUNIT					= 1

DEFINE_VARIABLE
// --- 
// --- ��������� FB DCN ---
VOLATILE buf[1000]		// ����� DCN
VOLATILE Integer Type_MS	// ��� ���������
VOLATILE Integer Type_Com_MS	// ��� �������
VOLATILE Integer Comans_MS	// �������
VOLATILE long Length_MS		// ������ ���������
VOLATILE Data_MS[1000]		// ���������

    VOLATILE Data_MS_Duble_With[1000]
    VOLATILE Data_MS_Duble_Without[1000]

Integer Delay_FB		// �������� ��������� �������


// --- �������� DCN ---
VOLATILE Integer Wireles_Power
VOLATILE Integer Mic[Kol_vo_MIC]// 0-����,1-���,2-�������
VOLATILE Integer Mic_in_SPK	// ����������� ���������� ���. � ������ ������ SPK
VOLATILE Integer Mic_in_RTS	// ����������� ���������� � ������ � ������ ������ RTS
VOLATILE Integer Rezim_DCN	// ����� �������� �������
VOLATILE Integer Kol_vo_Active_Mic //����������� �������� ����������
VOLATILE Integer Mic_For_cam	// ������� �������� ��������� ��� ������� ������
VOLATILE Integer First_mic_in_List // ������ � ������� ��������

Integer VOL			// �������� ������ ����� (0-25)

// --- ��������, ��� �������� ������� � ������
VOLATILE First[10]
VOLATILE Second[10]
VOLATILE Thrith[10]

// --- ������� ���������� ���������� ---
VOLATILE Integer Mic_Real [] =
{1,2,3,4,5,6,7,8,9,10,11,12,13,14}

// --- ������� ���������� ---
VOLATILE Integer H,L		//  ������� � ������ �������� 
VOLATILE Integer mic_kol	//  ����������� ���������� � ������
VOLATILE Integer mic_n		//  ����� ���������
VOLATILE Integer Real_but//  ��������� � ������ ���� ���

DEFINE_START
vol = DCNC_DEFAULT_MASTERVOLUME
CREATE_BUFFER dv,buf
Delay_FB = 50
WAIT(120)
{
    SEND_STRING dv, DCN_Send(csMM_C_START_MM,csDCNC_APP_MM,"")	 // ���������� Microphone Management application
    Wait(2)
    Call 'Opros_mic'
    Wait(6)
    SEND_STRING dv, DCN_Send(SI_C_GET_WIRELESS_MODE,csDCNC_APP_SI,"")// ����� ��������� �����������
    Wait(8)
    SEND_STRING dv, DCN_Send(csMM_C_GET_SETTINGS,csDCNC_APP_MM,"")  // ����� �������� DCN (����� � ���-�� �������� ����������)
}

DEFINE_MUTUALLY_EXCLUSIVE
([tp,1010],[tp,1011],[tp,1012],[tp,1013])
([tp,1101],[tp,1102],[tp,1103],[tp,1104])
([tp,1007],[tp,1008])

DEFINE_FUNCTION EraseMic (Integer Flag_Pover_FB)	// ��������� ������ ���������� 1-���, 2-�������
{//1-���,2-�������
    STACK_VAR Integer i
    for(i=1;i<Kol_vo_MIC+1;i++)
    {
	if ((Flag_Pover_FB=1)&(i<>Main_MIC))
	    if (mic[i]=1) mic[i]=0
	Else
	    if (mic[i]=2) mic[i]=0
    }
}
Define_Call 'Opros_mic'
{
    SEND_STRING dv, DCN_Send(csMM_C_NBK_GET,csDCNC_APP_MM,"")	//������ ��������� ��� NBK
    SEND_STRING dv, DCN_Send(csMM_C_SPK_GET,csDCNC_APP_MM,"")	//������ ��������� ��� SPK
    Wait(1)
    SEND_STRING dv, DCN_Send(csMM_C_RTS_GET,csDCNC_APP_MM,"")	//������ ��������� ��� RTS
}

Define_Call 'Fifo_with_List'
{
    If (REZIM_DCN=1)				// ����� � ��������
    If (MIC_IN_SPK<KOL_VO_ACTIVE_MIC)		// ���� ���� ��������� ����� ����������
    If (First_mic_in_List>0)			// ���� ������� �� �����
    {
	SEND_STRING dv, DCN_Send(csMM_C_RTS_REMOVE,csDCNC_APP_MM,"First_mic_in_List%256,First_mic_in_List/256,$FF,$FF")//��� �� �������
	SEND_STRING dv, DCN_Send(csMM_C_SPK_APPEND,csDCNC_APP_MM,"First_mic_in_List%256,First_mic_in_List/256")
	First_mic_in_List = 0
    }
}

DEFINE_FUNCTION Mic_to_Panel ()				// ��������� ���������� �� ������
{
    STACK_VAR Integer i
    for(i=1;i<Kol_vo_MIC+1;i++)
    {
	SWITCH(mic[i])
	{
	    Case 0:	// ����
	    {
		[tp,Mic_Real[i]] = 0
	    }
	    Case 1:	// ���
	    {
		[tp,Mic_Real[i]] = 1
		SEND_COMMAND tp,"'^BCF-',itoa(Mic_Real[i]),',2,#F3481E92'"	// ---
	    }
	    Case 2:	// � �������
	    {
		[tp,Mic_Real[i]] = 1
		SEND_COMMAND tp,"'^BCF-',itoa(Mic_Real[i]),',2,#0EE51892'"	// ---
	    }
	}
    }
    if (Mic_For_cam>0)
	SEND_STRING vdv_Cam,"itoa(Mic_Real[Mic_For_cam])"
    Else
	SEND_STRING vdv_Cam,"'0'"
}

DEFINE_CALL 'FB'
 //		      H L	       Type_Com_MS
{//1B,24,D, 4, 	      5,0, 	   16, 11, 	0,0,2	����������� ����.
 //HEAD     Type_MS   Length_MS    Comans_MS
    If (length_string(buf))
    {
	If (FIND_STRING(buf,csHEADER,1))
	{   // ������ �������
	    remove_string(buf,csHEADER,1)	// ���������
	    Type_MS = get_buffer_char(buf)	// ��� ���������
	    H = get_buffer_char(buf)	// ������ ���������
	    L = get_buffer_char(buf)
	    Length_MS = H + L<<16
	    
	    // ���� �������
	    Data_MS   = GET_BUFFER_STRING(buf,Length_MS)// ������ ������� �� ������
	    Data_MS_Duble_With = Data_MS 
	    Comans_MS = get_buffer_char(Data_MS)	// �������
	    Type_Com_MS = get_buffer_char(Data_MS)	// ��� �������
	    Data_MS_Duble_Without = Data_MS 
	    
	    
	    
	    SWITCH(Type_Com_MS)
	    {
		Case csDCNC_APP_SI:
		{
		    SWITCH(Comans_MS)
		    {
			Case SI_C_SET_WIRELESS_MODE:	// ���� ��������� ��������� ���������� ������ �������, �� ���������� ���������
			{SEND_STRING dv, DCN_Send(SI_C_GET_WIRELESS_MODE,csDCNC_APP_SI,"")}
			Case SI_C_GET_WIRELESS_MODE:	// ������� ��������� �����������
			{
			    get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    Wireles_Power = get_buffer_char(Data_MS)
			    Wireles_Power = Wireles_Power + 1010
				
			    [tp,Wireles_Power] = 1 // Data �� ������
			}
		    }
		}
		
		
		Case csDCNC_APP_MM:
		{
		    SWITCH(Comans_MS)
		    {
			Case csMM_C_GET_SETTINGS:	// ��������� DCN(����� � ���-�� �������� ����������)
			{
			    get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    Rezim_DCN = get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    Kol_vo_Active_Mic = get_buffer_char(Data_MS)
			    [tp,(Rezim_DCN+1006)] = 1
			    [tp,(Kol_vo_Active_Mic+1100)] = 1
			}
			Case csMM_C_SET_MIC_OPER_MODE:	// FB �� ��������� ������
			{SEND_STRING dv, DCN_Send(csMM_C_GET_SETTINGS,csDCNC_APP_MM,"")}  // ����� �������� DCN (����� � ���-�� �������� ����������)
			Case csMM_C_SET_ACTIVE_MICS:	// FB �� ��������� ����������� �������� ����������
			{SEND_STRING dv, DCN_Send(csMM_C_GET_SETTINGS,csDCNC_APP_MM,"")}  // ����� �������� DCN (����� � ���-�� �������� ����������)
			
			// ������� ����������
			// ������� ������� �������� ���������
			Case csMM_C_MICRO_ON_OFF:	// ������� ������� �������� ���������
			{
			    mic_n = get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    mic_kol = get_buffer_char(Data_MS)
			    if (mic_n = Main_MIC)
			    if (mic_kol = 1){ mic[Main_MIC] = 1;Mic_For_cam = Main_MIC }
			    Else	    { mic[Main_MIC] = 0;Mic_For_cam = 0 }
			    
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}
			    Mic_to_Panel ()	// ��������� ���������� �� ������
			}			
			// ����� ����� NBK
			Case csMM_C_NBK_GET:		// ����� ����� NBK
			{
			    get_buffer_string(Data_MS,8)
			    mic[Main_MIC] = get_buffer_char(Data_MS)
			    if (mic[Main_MIC] = 0) Mic_For_cam = 0
			    Else		   Mic_For_cam = Main_MIC
			}
			// ����� ����� SPK
			Case csMM_C_SPK_GET:		// ����� ����� SPK
			{
			    EraseMic (1)
			    if (mic[Main_MIC] = 0) Mic_For_cam = 0
			    get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    mic_kol = get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    Mic_in_SPK = mic_kol
			    WHILE(mic_kol>0)
			    {
				mic_n = get_buffer_char(Data_MS);
				get_buffer_char(Data_MS)
				get_buffer_char(Data_MS)				
				Mic[mic_n] = 1
				if (mic[Main_MIC] = 0) Mic_For_cam = mic_n
				mic_kol--
			    }
			}
			// ����� ����� RTS
			Case csMM_C_RTS_GET:		// ����� ����� RTS
			{
			    EraseMic (2)
			    First_mic_in_List = 0
			    get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    mic_kol = get_buffer_char(Data_MS);get_buffer_char(Data_MS)
			    Mic_in_RTS = mic_kol
			    WHILE(mic_kol>0)
			    {
				mic_n = get_buffer_char(Data_MS);
				get_buffer_char(Data_MS)
				get_buffer_char(Data_MS)
				get_buffer_char(Data_MS)	
				if (First_mic_in_List=0)
				    First_mic_in_List = mic_n
				Mic[mic_n] = 2
				mic_kol--
			    }
			    Call 'Fifo_with_List'	// ��������, ���� �� �������� ��������, � ��� ���������
			    Mic_to_Panel ()		// ��������� ���������� �� ������
			}
			
			
			// ����� ��������� ������ �������� ����������
			Case csMM_C_SPK_APPEND_ON_PC:	// ���������� ���. � ������
			{
			    (*mic_n = get_buffer_char(Data_MS);
			    Mic[Mic_Real[mic_n]] = 2*)
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}
			}
			Case csMM_C_SPK_REMOVE_ON_PC:	// �������� ���. �� ������
			{
			    (*mic_n = get_buffer_char(Data_MS);
			    Mic[Mic_Real[mic_n]] = 0*)
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}
			}
			Case csMM_C_SPK_CLEAR:		//
			{
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}			
			}
			Case csMM_C_RTS_CLEAR_ON_PC:	// 
			{
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}			
			}
			Case csMM_C_RTS_REMOVE_ON_PC:	// 
			{
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}			
			}
			Case csMM_C_RTS_INSERT_ON_PC:	// 
			{
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}			
			}
			Case csMM_C_RTS_REPLACE_ON_PC:	// 
			{
			    CANCEL_WAIT 'Opros_All_mic';Wait(Delay_Opros_Mic)'Opros_All_mic'{Call 'Opros_mic'}			
			}
		    }
		}
		Case csDCNC_APP_SC:
		{
		
		}
		Case csDCNC_APP_AT:
		{
		
		}
		DEFAULT:{}
	    }
	}
    }
    else
	Delay_FB = 50
}

DEFINE_FUNCTION char[500]DCN_Send(CHAR Send_Cmd[],CHAR Send_HiByte[],CHAR Send_Parms[])	// --- ���������� ������� ��� DCN
{
        stack_var char s_field[255]
        stack_var char Send_Cmd_Temp[255]
        stack_var char Send_HiByte_Temp[255]
        stack_var char Send_Parms_Temp[255]
	stack_var long  s_chk
	stack_var integer  s_idx
	stack_var integer  s_len
	Send_Cmd_Temp = Send_Cmd
	Send_HiByte_Temp = Send_HiByte
        Send_Parms_Temp = Send_Parms
	s_len = length_string(Send_Parms) + 2
	s_field = "csHeader,csMDSC_REMOTEPROCEDURE_REQ, s_len,0, Send_Cmd,Send_HiByte"
	s_chk = $4F+ GET_BUFFER_CHAR(Send_Cmd_Temp) + GET_BUFFER_CHAR(Send_HiByte_Temp) + s_len
	 for(s_idx = 1; s_idx <=length_string(Send_Parms);s_idx++)
	    {
  	     s_chk = s_chk + GET_BUFFER_CHAR(Send_Parms_Temp);
	    }
	s_field = "s_field, Send_Parms ,(bnot(s_chk))band $FF"
	return(s_field)
}


DEFINE_EVENT
DATA_EVENT[dv]		// --- ������ ������� � ��������� �����
{
    ONLINE:
    {
	SEND_COMMAND dv,"'SET BAUD 19200,N,8,1 485 DINABLE'"
	
	SEND_STRING dv, DCN_Send(csMM_C_START_MM,csDCNC_APP_MM,"")	 // ���������� Microphone Management application
	SEND_STRING dv, DCN_Send(SI_C_GET_WIRELESS_MODE,csDCNC_APP_SI,"")// ����� ��������� �����������
	SEND_STRING dv, DCN_Send(csMM_C_GET_SETTINGS,csDCNC_APP_MM,"")  // ����� �������� DCN (����� � ���-�� �������� ����������)
    }
    STRING:
    {
	Delay_FB = 0
	CANCEL_WAIT 'Wait_FB'
    }
}

DATA_EVENT[tp]	// --- ������ �������, � ��������� ��������� ��������� ����������
{
    ONLINE:
    {
	[tp,Wireles_Power] = 1
	[tp,(Rezim_DCN+1006)] = 1
	[tp,(Kol_vo_Active_Mic+1100)] = 1
	
	send_command tp, "'^TXT-1031,0,',itoa(vol)"
	
	CANCEL_WAIT 'Mic_to_Panel_Wait'
	Wait(50) 'Mic_to_Panel_Wait'
	    Mic_to_Panel ()
    }	
}


BUTTON_EVENT [tp,0]
{
    PUSH:
    {
	STACK_VAR Integer but

	But = BUTTON.INPUT.CHANNEL
	if (But<90)	// ��������� ����������� ����������
	{
	    Real_but = 0
	    WHILE(Real_but<Kol_vo_MIC)
	    {
		Real_but++
		if (Mic_Real[Real_but] = but)
		    Real_but = Real_but + 100
	    }
	    
	    if (Real_but>100)
	    {
		Real_but = Real_but - 100
		if (Real_but=Main_MIC)			// ���� ��������� ������������
		{
		    SWITCH(mic[Real_but])
		    {
			Case 0:{SEND_STRING dv, DCN_Send(csMM_C_SET_MICRO_ON_OFF,csDCNC_APP_MM,"Real_but%256,Real_but/256,$FF,$FF")}//���
			Case 1:{SEND_STRING dv, DCN_Send(csMM_C_SET_MICRO_ON_OFF,csDCNC_APP_MM,"Real_but%256,Real_but/256,$00,$FF")}//���
		    }
		}
		else
		If (Rezim_DCN=1)
		    SWITCH(mic[Real_but])
		    {
			Case 0:
			{
			    If (Mic_in_SPK<Kol_vo_Active_Mic) // ���� ���� ��������� ���������
				SEND_STRING dv, DCN_Send(csMM_C_SPK_APPEND,csDCNC_APP_MM,"Real_but%256,Real_but/256")//���
			    Else
				SEND_STRING dv, DCN_Send(csMM_C_RTS_APPEND,csDCNC_APP_MM,"Real_but%256,Real_but/256,$FF,$FF")//� ������
			}
			Case 1:{SEND_STRING dv, DCN_Send(csMM_C_SPK_REMOVE,csDCNC_APP_MM,"Real_but%256,Real_but/256")}//���
			Case 2:{SEND_STRING dv, DCN_Send(csMM_C_RTS_REMOVE,csDCNC_APP_MM,"Real_but%256,Real_but/256,$FF,$FF")}//��� �� �������
		    }
		Else
		    SWITCH(mic[Real_but])
		    {
			Case 0:{SEND_STRING dv, DCN_Send(csMM_C_SHIFT,csDCNC_APP_MM,"Real_but%256,Real_but/256")}//���
			Case 1:{SEND_STRING dv, DCN_Send(csMM_C_SPK_REMOVE,csDCNC_APP_MM,"Real_but%256,Real_but/256")}//���
			Case 2:{SEND_STRING dv, DCN_Send(csMM_C_RTS_REMOVE,csDCNC_APP_MM,"Real_but%256,Real_but/256,$FF,$FF")}//��� �� �������
		    }
	    }
	}
	Else
	If ((but>1100)&(But<1105))		// ����������� �������� ����������
	{
	    SEND_STRING dv, DCN_Send(csMM_C_SET_ACTIVE_MICS,csDCNC_APP_MM,"but-1100")
	}
	switch(but)
	{
	    // --- ��������� ---
	    Case  900:{SEND_STRING dv, DCN_Send(csMM_C_SPK_GET,csDCNC_APP_MM,"")}  	// ����� �������� ����������
		
	    Case  999:{SEND_STRING dv, DCN_Send(csMM_C_STOP_MM,csDCNC_APP_MM,"")}  	// ������������ Microphone Management application
	    Case 1000:{SEND_STRING dv, DCN_Send(csMM_C_START_MM,csDCNC_APP_MM,"")} 	// ���������� Microphone Management application
	    Case 1003:{SEND_STRING dv, DCN_Send(csMM_C_SPK_CLEAR,csDCNC_APP_MM,"")}	// ��������� ��� �������� ���������
	    Case 1004:{SEND_STRING dv, DCN_Send(csMM_C_RTS_CLEAR,csDCNC_APP_MM,"")}	// �������� ������� ����������
	    Case 1005:{SEND_STRING dv, DCN_Send(csMM_C_SPK_CLEAR,csDCNC_APP_MM,"")	// ��������� ��� �������� ���������
		       SEND_STRING dv, DCN_Send(csMM_C_RTS_CLEAR,csDCNC_APP_MM,"")}	// �������� ������� ����������
	    
	    Case 1006:{SEND_STRING dv, DCN_Send(csMM_C_GET_SETTINGS,csDCNC_APP_MM,"")}  // ����� �������� DCN (����� � ���-�� �������� ����������)
	    Case 1007:{SEND_STRING dv, DCN_Send(csMM_C_SET_MIC_OPER_MODE,csDCNC_APP_MM,csMM_C_DELEGATE_WITH_REQ_LIST)}// ���������� ����� 2 (��� ��������� �� ������ ���������� 4 ���������, 5-�� ����� � �������)		
	    Case 1008:{SEND_STRING dv, DCN_Send(csMM_C_SET_MIC_OPER_MODE,csDCNC_APP_MM,csMM_C_DELEGATE_WITH_OVERRIDE)}// ���������� ����� 3 (��� �������. ��� ��������� �� ������ ���������� 4 ���������, 5-�� ��������� 1-��)		
	    Case 1009:{SEND_STRING dv, DCN_Send(csMM_C_SET_MIC_OPER_MODE,csDCNC_APP_MM,csMM_C_DELEGATE_WITH_VOICE)}   // ���������� ����� 4 (�������� ��� ���������)
	    // --- ����� ������ ---
	    Case 1010:{SEND_STRING dv, DCN_Send(SI_C_SET_WIRELESS_MODE,csDCNC_APP_SI,SI_C_WIRELESS_MODE_ON)}	// �������� ����������� 
	    Case 1011:{SEND_STRING dv, DCN_Send(SI_C_SET_WIRELESS_MODE,csDCNC_APP_SI,SI_C_WIRELESS_MODE_SLEEP)}	// �������� ����������� 
	    Case 1012:{SEND_STRING dv, DCN_Send(SI_C_SET_WIRELESS_MODE,csDCNC_APP_SI,SI_C_WIRELESS_MODE_OFF)}	// ��������� �����������
	    Case 1013:{SEND_STRING dv, DCN_Send(SI_C_SET_WIRELESS_MODE,csDCNC_APP_SI,SI_C_WIRELESS_MODE_SUBSCRIPTION)}// �������� ��� � ������
	    Case 1014:{SEND_STRING dv, DCN_Send(SI_C_UNSUBSCRIBE_REQ,csDCNC_APP_SI,"")}				// ����� �������� ��� � ������
	    Case 1015:{SEND_STRING dv, DCN_Send(SI_C_GET_WIRELESS_MODE,csDCNC_APP_SI,"")}			// ����� ��������� �����������
	    
	    
	    // --- master Volume --- 
	    Case 1031:
	    {
		if (vol > 0)
		{
		    vol--
		    SEND_STRING dv, DCN_Send(SI_C_SET_MASTER_VOL,csDCNC_APP_SI,"vol")			// - Volume
		    send_command tp, "'^TXT-1031,0,',itoa(vol)"
		}
	    }
	    Case 1032:
	    {
		if (vol < 25)
		{
		    vol++
		    SEND_STRING dv, DCN_Send(SI_C_SET_MASTER_VOL,csDCNC_APP_SI,"vol")			// - Volume
		    send_command tp, "'^TXT-1031,0,',itoa(vol)"
		}
	    }
	    Case 3999:{SEND_STRING dv, DCN_Send(First,Second,Thrith)}		// ������ �������� �������
	}
    }
}

DEFINE_PROGRAM

Wait(Delay_FB) 'Wait_FB'
    Call 'FB'
    
WAIT(36000)
{
  if([tp,1010]) SEND_STRING dv, DCN_Send(SI_C_SET_WIRELESS_MODE,csDCNC_APP_SI,SI_C_WIRELESS_MODE_ON)// �������� �����������
}