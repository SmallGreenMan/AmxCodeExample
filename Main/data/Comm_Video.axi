PROGRAM_NAME='Comm_Video'
// "'^BMP-37,0,Andere000_44x44'" Изменеине иконки
DEFINE_TYPE
STRUCTURE vitr_Chenal 
{
    Integer In
    Text_OUT[300]
}


DEFINE_VARIABLE
	    integer o1
	    integer o2
	    
vitr_Chenal vChenal[10]		// --- Виртуальные каналы 1(151) - Камера,


VOLATILE VideoBuffer[30000]
VOLATILE Mini_VideoBuff[500]
VOLATILE Mini_1_VideoBuff[500]
VOLATILE Mini_2_VideoBuff[10]	
VOLATILE Integer  In, Out, In_b, Out_b, tp_Online
INTEGER OUT_FB[Kol_voIO]; 		VOLATILE Integer Flag_Colva_Figni,Flag_opros_Matrix
VOLATILE Integer Video_FB_Delay
			    


VOLATILE Integer Online_tp_Main[7]
dev tp_VideoComm_Online [] =
{
    tp_VideoCom_17,
    tp_VideoCom_7,
    tp_Vid_Com_Kab_Raz,
    tp_VideoCom_VideoWall,
    tp_Vid_Com_Kab_Gef,
    tp_Vid_Com_Vip_1,
    tp_Vid_Com_Vip_2,
    tp_Vid_Com_Kab_Gef_2
}


// 49-94
VOLATILE Integer Online_tp_Spec[23]
Dev tp_VideoComm_Spec [] =
{
    tp_VideoComm_Spec_1,
    tp_VideoComm_Spec_2,
    tp_VideoComm_Spec_3,
    tp_VideoComm_Spec_4,
    tp_VideoComm_Spec_5,
    tp_VideoComm_Spec_6,
    tp_VideoComm_Spec_7,
    tp_VideoComm_Spec_8,
    tp_VideoComm_Spec_9,
    tp_VideoComm_Spec_10,
    tp_VideoComm_Spec_11,
    tp_VideoComm_Spec_12,
    tp_VideoComm_Spec_13,
    tp_VideoComm_Spec_14,
    tp_VideoComm_Spec_15,
    tp_VideoComm_Spec_16,
    tp_VideoComm_Spec_17,
    tp_VideoComm_Spec_18,
    tp_VideoComm_Spec_19,
    tp_VideoComm_Spec_20,
    tp_VideoComm_Spec_21,
    tp_VideoComm_Spec_22,
    tp_VideoComm_Spec_23
}

DEFINE_START
CREATE_BUFFER dv_DGX,VideoBuffer
COMBINE_DEVICES(vtp_Debug,tp_Debug_7,tp_Debug_17)
COMBINE_DEVICES(
    vtp_VideoFB,
    tp_VideoFB_7,
    tp_VideoFB_17,
    tp_VideoFB_VideoWall,
    tp_Vid_FB_Kab_Raz,
    tp_Vid_FB_Kab_Gef,
    tp_Vid_FB_Vip_1,
    tp_Vid_FB_Vip_2,
    tp_Vid_FB_Kab_Gef_2
)

DEFINE_CALL 'Opros'
{
    STACK_VAR integer vid_i
    Flag_opros_Matrix++
    For(vid_i=1;vid_i<145;vid_i++)
    {
	SEND_STRING dv_DGX,"'SL0O',itoa(vid_i),'T'"
    }
}
Define_call 'nol_in'
{
    STACK_VAR integer vid_i
    
    For(vid_i=1;vid_i<Kol_voIO;vid_i++)
    {
	[vtp_Debug,vid_i] = 0
	[vtp_Debug,vid_i+1000] = 0
    }
}
DEFINE_FUNCTION SendVideoFB_to_Panel (Integer i,Integer o)
{
    stack_var integer s
    SEND_COMMAND vtp_Debug,"'^TXT-',itoa(o+1000),',0,',itoa(o),$0D,$0A,itoa(i)"
    
SEND_STRING vdv_VideoForControl,"itoa(i),'to',itoa(o),'!'"		// --- FB Для панелей, какой вид управления нужен для данного источника
    
    if ((o>112)&(o<131))
    {
	for(s=1;s<24;s++)
	{
	    if (i)
	    {
		SEND_COMMAND tp_VideoComm_Spec[s],"'^BMP-',itoa(o+1000),',0,',Icons[i]"//BMP
		if (Names[i]='')
		    SEND_COMMAND tp_VideoComm_Spec[s],"'^UNI-',itoa(o+1000),',0,',Names_uni[i]"
		Else
		    SEND_COMMAND tp_VideoComm_Spec[s],"'^TXT-',itoa(o+1000),',0,',Names[i]"
		SEND_COMMAND tp_VideoComm_Spec[s],"'^BCF-',itoa(o+1000),',0,#0252E96A'"
	    }
	    else
	    {
		SEND_COMMAND tp_VideoComm_Spec[s],"'^BMP-',itoa(o+1000),',0,'"//BMP
		SEND_COMMAND tp_VideoComm_Spec[s],"'^TXT-',itoa(o+1000),',0,Off'"
		SEND_COMMAND tp_VideoComm_Spec[s],"'^BCF-',itoa(o+1000),',0,#333333A7'"	// --- Серая 10
	    }
	}
    }

    if (i)
    {
	SEND_COMMAND vtp_VideoFB,"'^BMP-',itoa(o+1000),',0,',Icons[i]"//BMP
	if (Names[i]='')
	    SEND_COMMAND vtp_VideoFB,"'^UNI-',itoa(o+1000),',0,',Names_uni[i]"
	Else
	    SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(o+1000),',0,',Names[i]"
	SEND_COMMAND vtp_VideoFB,"'^BCF-',itoa(o+1000),',0,#0252E96A'"
    }
    else
    {
	SEND_COMMAND vtp_VideoFB,"'^BMP-',itoa(o+1000),',0,'"//BMP
	SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(o+1000),',0,Off'"
	SEND_COMMAND vtp_VideoFB,"'^BCF-',itoa(o+1000),',0,#333333A7'"	// --- Серая 10
    }
    
    if ((o>48)&(o<95))
    {
	o1 = (o-49)/2 
	o2 = (o-49)%2
	if (i)
	{
	    SEND_COMMAND tp_VideoComm_Spec[o1+1],"'^BMP-',itoa(1201+o2),',0,',Icons[i]"//BMP
	    if (Names[i]='')
		SEND_COMMAND tp_VideoComm_Spec[o1+1],"'^UNI-',itoa(1201+o2),',0,',Names_uni[i]"
	    Else
		SEND_COMMAND tp_VideoComm_Spec[o1+1],"'^TXT-',itoa(1201+o2),',0,',Names[i]"
	}
	Else
	{
	   SEND_COMMAND tp_VideoComm_Spec[o1+1],"'^BMP-',itoa(1201+o2),',0,'"//BMP
	   SEND_COMMAND tp_VideoComm_Spec[o1+1],"'^TXT-',itoa(1201+o2),',0,'"
	}
    }
    
    
    If ((o>150)&(o<161))	// --- Виртуальные каналы на места начальников специалистов
    {
	if (i)
	{
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BMP-',itoa(o+1000),',0,',Icons[i]"//BMP
	    if (Names[i]='')
		SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^UNI-',itoa(o+1000),',0,',Names_uni[i]"
	    Else
		SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^TXT-',itoa(o+1000),',0,',Names[i]"
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BCF-',itoa(o+1000),',0,#0252E96A'"
	}
	else
	{
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BMP-',itoa(o+1000),',0,'"//BMP
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^TXT-',itoa(o+1000),',0,Off'"
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BCF-',itoa(o+1000),',0,#333333A7'"	// --- Серая 10
	}
    }
}
DEFINE_FUNCTION VirtChannelConnect (Integer i_ch)
{
    STACK_VAR Integer in_f
    STACK_VAR Integer out_f
    STACK_VAR Out_Text_f[300]
    
    In_f = vChenal[i_ch].In
    Out_Text_f = vChenal[i_ch].Text_Out
    WHILE(LENGTH_STRING(Out_Text_f))
    {
	Out_f = atoi(remove_string(Out_Text_f,"';'",1))
	if ((Out_f<145)&(In_f<145))
	{
	    if (in_f)
		SEND_STRING dv_DGX,"'CL0O',itoa(Out_f),'I',itoa(In_f),'T'"	//Комутация	
	    Else
		SEND_STRING dv_DGX,"'DL0O',itoa(Out_f),'T'"			//Выкл
	}
    }
}
DEFINE_FUNCTION Delete_Out_From_vCenal (Integer i, Integer Out_f)
{
    STACK_VAR Integer st
    STACK_VAR Integer len
    st = find_string(vChenal[i-150].Text_OUT,itoa(Out_f),1)
    len = length_string(itoa(Out_f))
    vChenal[i-150].Text_OUT = "mid_string(vChenal[i-150].Text_OUT,1,st-1),mid_string(vChenal[i-150].Text_OUT,st+len+1,300)"
}
DEFINE_CALL 'Video_FB'
{
    If (LENGTH_STRING(VideoBuffer))
    {
	if (LEFT_STRING(VideoBuffer,2)="'SL'")
	{
	    Mini_VideoBuff = remove_string(VideoBuffer,"')'",1)
	    Mini_1_VideoBuff = REMOVE_STRING(Mini_VideoBuff,"'('",1)
	    remove_string(Mini_1_VideoBuff,"'SL0'",1)
	    If (LEFT_STRING(Mini_1_VideoBuff,1) = "'O'")
	    {
		Out_b = atoi(Mini_1_VideoBuff)
		In_b = atoi(Mini_VideoBuff)
		if (OUT_FB[Out_b]<145 )
		{
		    OUT_FB[Out_b] = In_b;
		    SendVideoFB_to_Panel(In_b,Out_b)
		}
	    }
	    If (LEFT_STRING(Mini_1_VideoBuff,1) = "'I'")
	    {
		In_b = atoi(Mini_1_VideoBuff)
		remove_string(Mini_VideoBuff,"' '",1)
		WHILE(LENGTH_STRING(Mini_VideoBuff) > 2)
		{
		    Mini_2_VideoBuff = remove_string(Mini_VideoBuff,"' '",1)
		    Out_b = atoi(Mini_2_VideoBuff)
		    if (OUT_FB[Out_b]<145)
		    {OUT_FB[Out_b] = In_b;SendVideoFB_to_Panel(In_b,Out_b)}
		    [vtp_Debug,Out_b+1000] = 1
		}
	    }
	}
	Else IF (LEFT_STRING(VideoBuffer,2)="'CL'")
	{
	    Mini_VideoBuff = remove_string(VideoBuffer,"'T'",1)
	    REMOVE_STRING(Mini_VideoBuff,"'O'",1)
	    Out_b = atoi(remove_string(Mini_VideoBuff,"'I'",1))
	    In_b = atoi(Mini_VideoBuff)
	    if (OUT_FB[Out_b]<145)
	    {OUT_FB[Out_b] = In_b;SendVideoFB_to_Panel(In_b,Out_b)}
	    [vtp_Debug,Out_b+1000] = 1
	}
	Else IF (LEFT_STRING(VideoBuffer,2)="'DL'")
	{
	    Mini_VideoBuff = remove_string(VideoBuffer,"'T'",1)
	    REMOVE_STRING(Mini_VideoBuff,"'O'",1)
	    Out_b = atoi(Mini_VideoBuff)
	    In_b = 0
	    if (OUT_FB[Out_b]<145)
	    {OUT_FB[Out_b] = In_b;SendVideoFB_to_Panel(In_b,Out_b)}
	    [vtp_Debug,Out_b+1000] = 0
	}
	
	// --- Защита от ошибок ---
	Else If (left_string(VideoBuffer,1)="'('")
	    remove_string (VideoBuffer,"')'",1)
	Else If (FIND_STRING(VideoBuffer,"'X'",1))
	    remove_string (VideoBuffer,"'X'",1)
	Else If (left_string(VideoBuffer,1)="')'")
	    remove_string (VideoBuffer,"')'",1)
	Else If (FIND_STRING(VideoBuffer,"$0D,$0A",1))
	    remove_string (VideoBuffer,"$0D,$0A",1)
	Else 
	{
	    VideoBuffer = ''
	    Wait (20)
		CALL 'Opros'
	    Flag_Colva_Figni++
	}
    }
    else
	Video_FB_Delay = 20
}


DEFINE_CALL 'Online_main_tp'
{
	stack_var integer Vid_i
	
	tp_Online = 1
	
	for (Vid_i = 1;Vid_i < Kol_voIO+1;Vid_i++)
	{
	    SEND_STRING vdv_VideoForControl,"itoa(OUT_FB[Vid_i]),'to',itoa(Vid_i),'!'"		// --- FB Для панелей, какой вид управления нужен для данного источника
	    SEND_COMMAND vtp_Debug,"'^TXT-',itoa(Vid_i+1000),',1&2,',itoa(Vid_i),$0D,$0A,itoa(OUT_FB[Vid_i])"
	    SEND_COMMAND vtp_VideoFB,"'^BMP-',itoa(Vid_i+1000),',0,',Icons[OUT_FB[Vid_i]]"
	    if (Names[Vid_i]='')
		SEND_COMMAND vtp_VideoFB,"'^UNI-',itoa(Vid_i),',0,',Names_uni[Vid_i]"	// --- Назнавение источников
	    Else
		SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(Vid_i),',0,',Names[Vid_i]"	// --- Назнавение источников
	    
	    if (OUT_FB[Vid_i])
	    {
		if (Names[OUT_FB[Vid_i]]='')
		    SEND_COMMAND vtp_VideoFB,"'^UNI-',itoa(Vid_i+1000),',0,',Names_uni[OUT_FB[Vid_i]]"
		Else
		    SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(Vid_i+1000),',0,',Names[OUT_FB[Vid_i]]"
		SEND_COMMAND vtp_VideoFB,"'^BCF-',itoa(Vid_i+1000),',0,#0252E96A'"
	    }
	    else
	    {
		SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(Vid_i+1000),',0,Off'"
		SEND_COMMAND vtp_VideoFB,"'^BCF-',itoa(Vid_i+1000),',0,#333333A7'"	// --- Серая 10
	    }
	}
}
DEFINE_CALL 'Online_Spec_tp'
{
    STACK_VAR Integer Spec_i
    STACK_VAR Integer y_Spec
    stack_var integer s
    stack_var integer Vid_i
    STACK_VAR Integer o
    
    For (Spec_i=1;Spec_i<24;Spec_i++)
    {
	If (Online_tp_Spec[Spec_i]=2)
	{
	    Online_tp_Spec[Spec_i] = 1
	    
	    y_Spec = 49+(Spec_i-1)*2
	 
	    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^BMP-1201,0,',Icons[OUT_FB[y_Spec]]"
	    if (Names[OUT_FB[y_Spec]]='')
		SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^Uni-1201,0,',Names_uni[OUT_FB[y_Spec]]"
	    Else
		SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^TXT-1201,0,',Names[OUT_FB[y_Spec]]"
	    
	    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^BMP-1202,0,',Icons[OUT_FB[y_Spec+1]]"
	    if (Names[OUT_FB[y_Spec+1]]='')
		SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^Uni-1202,0,',Names_uni[OUT_FB[y_Spec+1]]"
	    Else
		SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^TXT-1202,0,',Names[OUT_FB[y_Spec+1]]"
	    
	    for(s=113;s<131;s++)
	    {
		SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^BMP-',itoa(s+1000),',0,',Icons[OUT_FB[s]]"
		if (OUT_FB[s])
		{
		    if (Names[OUT_FB[s]]='')
			SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^Uni-',itoa(s+1000),',0,',Names_uni[OUT_FB[s]]"
		    Else
			SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^TXT-',itoa(s+1000),',0,',Names[OUT_FB[s]]"
		    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^BCF-',itoa(s+1000),',0,#0252E96A'"
		}
		else
		{
		    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^TXT-',itoa(s+1000),',0,Off'"
		    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^BCF-',itoa(s+1000),',0,#333333A7'"	// --- Серая 10
		}
	    }
	    
	    for (Vid_i = 1;Vid_i < Kol_voIO+1;Vid_i++)
		if (Names[Vid_i]='')
		    if (Names_uni[Vid_i]<>'')
			SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^Uni-',itoa(Vid_i),',0,',Names_uni[Vid_i]"	// --- Назнавение источников
		    Else {}
		Else
		    SEND_COMMAND tp_VideoComm_Spec[Spec_i],"'^TXT-',itoa(Vid_i),',0,',Names[Vid_i]"	// --- Назнавение источников
	}
    }
    
    For (o=150;o<161;o++)	// --- Виртуальные каналы на места начальников специалистов
    {
	SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BMP-',itoa(o+1000),',0,',Icons[OUT_FB[o]]"//BMP
	if (OUT_FB[o])
	{
	    if (Names[OUT_FB[o]]='')
		SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^Uni-',itoa(o+1000),',0,',Names_uni[OUT_FB[o]]"
	    Else
		SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^TXT-',itoa(o+1000),',0,',Names[OUT_FB[o]]"
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BCF-',itoa(o+1000),',0,#0252E96A'"
	}
	else
	{
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^TXT-',itoa(o+1000),',0,Off'"
	    SEND_COMMAND tp_VideoComm_Spec[o-157+6],"'^BCF-',itoa(o+1000),',0,#333333A7'"	// --- Серая 10
	}
    }
}
DEFINE_EVENT
data_event[vdv_DGX]		// --- Комутация по средством вирутального девайса (xxxINxxxOUT)
{
    String:
    {
	STACK_VAR Integer In_v
	STACK_VAR Integer Out_v
	
	In_v = atoi(remove_string(data.text,"'IN'",1))
	Out_v = atoi(remove_string(data.text,"'OUT'",1))

	If (In_v = 2500)	// включаем ТВ телевизоров
	{
	    If (Out_v<>41)
	    {
		OUT_FB[Out_v] = 145
		SEND_STRING vdv_VideoForControl,"'145to',itoa(Out_v),'!'"		// --- FB Для панелей, какой вид управления нужен для данного источника
		SEND_COMMAND vtp_VideoFB,"'^BMP-',itoa(Out_v+1000),',0,',Icons[145]"
		SEND_COMMAND vtp_VideoFB,"'^TXT-',itoa(Out_v+1000),',0,',Names[145]"
	    }
	}
	Else
	if (Out_v)
	    if ((Out_v<145)&(in_v<145))		// Основная Видео ком
	    {
		if (OUT_FB[Out_v]>150)			// Если выход участвует в виртуальном канале
		{
		    Delete_Out_From_vCenal (OUT_FB[Out_v],Out_v)
		}
		OUT_FB[Out_v] = In_v	// Запоминаем FB
		if (in_v)
		    SEND_STRING dv_DGX,"'CL0O',itoa(Out_v),'I',itoa(In_v),'T'"	//Комутация	
		Else
		    SEND_STRING dv_DGX,"'DL0O',itoa(Out_v),'T'"		//Выкл
	    }
	    Else
	    {
		If ((Out_v<150)|(in_v<150))	// Проверка на вероятность коммутации вирт на вирт
		{
		    if (OUT_FB[Out_v]>150)			// Если выход участвует в виртуальном канале
		    {
			Delete_Out_From_vCenal (OUT_FB[Out_v],Out_v)
		    }
		    OUT_FB[Out_v] = In_v	// Запоминаем FB
		    If (in_v>150)	//Комутация виртуального канала		    
		    {
			If (find_string(vChenal[in_v-150].Text_Out,"itoa(Out_v)",1)=0)	// Если в виртуальном канале его нет
			    vChenal[in_v-150].Text_Out = "vChenal[in_v-150].Text_Out,itoa(Out_v),';'"
			VirtChannelConnect (in_v-150)
			SendVideoFB_to_Panel (In_v,Out_v)
		    }
		    Else
		    If (Out_v>150)	//Комутация на виртуальный канал
		    {
			vChenal[Out_v-150].in = In_v
			VirtChannelConnect (Out_v-150)
			SendVideoFB_to_Panel (In_v,Out_v)
		    }			
		}
	    }
    }
}	
data_event[tp_VideoComm_Online]	// --- Онланй панелей
{	
    online:
    {
	CANCEL_WAIT 'Online_tp_Main'
	Wait(50)'Online_tp_Main'
	    CALL 'Online_main_tp'
    }
}

data_event[tp_VideoComm_Spec]	// --- Онлайн панелей специалистов
{
    online:
    {
	Online_tp_Spec[GET_LAST(tp_VideoComm_Spec)] = 2
	
	CANCEL_WAIT 'Onlne_Spec_tp'
	Wait (52) 'Onlne_Spec_tp'
	    CALL 'Online_Spec_tp'
    }
}

DATA_EVENT[dv_DGX]		// --- Онлайн
{
    ONLINE:
    {
	//SEND_COMMAND dv_DGX,"'SET BAUD 9600,N,8,1 485 DINABLE'"
	Wait(50) 'Opros_DGX'
	{
	    // --- Видео коммутация по умолчанию ---
	    send_string vdv_DGX, "'151IN107OUT'"	// --- VIP VKS
	    send_string vdv_DGX, "'152IN109OUT'"	// --- CUP VKS
		send_string vdv_DGX, "'10IN152OUT'"	// --- камера 6 на виртуальный канал 2
	    Wait(10)
	    {
		CALL 'Opros'
		Wait(3600) 'Opros_DGX'
		    CALL 'Opros'
	    }
	}
    }
    STRING:
    {
	SEND_COMMAND vtp_Debug,"'^TXT-1000,1&2,',data.text"
	Video_FB_Delay = 0
	cancel_wait 'Wait_fb'
    }
}

BUTTON_EVENT[vtp_Debug,0]	// --- IN - OUT
{
    Push:
    {
	stack_var Integer VideoButton
	
	VideoButton = BUTTON.INPUT.CHANNEL
	
	if (VideoButton < 145)
	{
	    in = VideoButton
	    call 'nol_in'
	    [vtp_Debug,in] = 1
	    SEND_COMMAND vtp_Debug,"'^TXT-999,1&2,',itoa(in)"
	    SEND_STRING dv_DGX,"'SL0I',itoa(in),'T'"
	}
	else
	If ((VideoButton > 1000)&(VideoButton < 1145))
	{
	    if (In > 0)
	    {
		Out = VideoButton - 1000
		if (OUT_FB[Out] = in)
		    SEND_STRING dv_DGX,"'DL0O',itoa(Out),'T'"
		else
		    SEND_STRING dv_DGX,"'CL0O',itoa(Out),'I',itoa(In),'T'"
	    }
	}
	Else 
	switch(VideoButton)
	{
	    case 500:{CALL 'Opros'}
	    case 501:{VideoBuffer = ''}
	    Case 502: 		// Переключение на дубликат видеостены выходов юпитера
	    {
		send_string vdv_DGX, "'113IN19OUT'";send_string vdv_DGX, "'122IN20OUT'"
		send_string vdv_DGX, "'114IN21OUT'";send_string vdv_DGX, "'123IN22OUT'"
		send_string vdv_DGX, "'115IN23OUT'";send_string vdv_DGX, "'124IN24OUT'"
		send_string vdv_DGX, "'116IN25OUT'";send_string vdv_DGX, "'125IN26OUT'"
		send_string vdv_DGX, "'117IN27OUT'";send_string vdv_DGX, "'126IN28OUT'"
		send_string vdv_DGX, "'118IN29OUT'";send_string vdv_DGX, "'127IN30OUT'"
		send_string vdv_DGX, "'119IN31OUT'";send_string vdv_DGX, "'128IN32OUT'"
		send_string vdv_DGX, "'120IN33OUT'";send_string vdv_DGX, "'129IN34OUT'"
		send_string vdv_DGX, "'121IN35OUT'";send_string vdv_DGX, "'130IN36OUT'"
	    }
	    Case 503:		// Переключени выходов Юпитера на Главную видеостену
	    {
		send_string vdv_DGX, "'113IN1OUT'";send_string vdv_DGX, "'122IN2OUT'"
		send_string vdv_DGX, "'114IN3OUT'";send_string vdv_DGX, "'123IN4OUT'"
		send_string vdv_DGX, "'115IN5OUT'";send_string vdv_DGX, "'124IN6OUT'"
		send_string vdv_DGX, "'116IN7OUT'";send_string vdv_DGX, "'125IN8OUT'"
		send_string vdv_DGX, "'117IN9OUT'";send_string vdv_DGX, "'126IN10OUT'"
		send_string vdv_DGX, "'118IN11OUT'";send_string vdv_DGX, "'127IN12OUT'"
		send_string vdv_DGX, "'119IN13OUT'";send_string vdv_DGX, "'128IN14OUT'"
		send_string vdv_DGX, "'120IN15OUT'";send_string vdv_DGX, "'129IN16OUT'"
		send_string vdv_DGX, "'121IN17OUT'";send_string vdv_DGX, "'130IN18OUT'"
	    }
	}
    }
}

BUTTON_EVENT[tp_VKS_VIP_Zona,13]// --- Раскамутаця видео с кодека при выключении кодека VIP
BUTTON_EVENT[tp_VKS_VIP_Zona_Ipad,13]
BUTTON_EVENT[tp_VKS_VIP_Zona_Wall,13]
{
    Push:
    {	//37 38 41
	if ((OUT_FB[37]=107)|(OUT_FB[37]=108))
	    send_string vdv_DGX, "'0IN37OUT'"	// 
	if ((OUT_FB[38]=107)|(OUT_FB[38]=108))
	    send_string vdv_DGX, "'0IN38OUT'"	// 
	if ((OUT_FB[41]=107)|(OUT_FB[41]=108))
	    send_string vdv_DGX, "'0IN41OUT'"	// 
    }
}
DEFINE_PROGRAM
Wait(Video_FB_Delay) 'Wait_fb'
CALL 'Video_FB'
Wait(36000)
	CALL 'Opros'
	
	



