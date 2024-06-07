PROGRAM_NAME='Setup_Panel_setings_include'

DEFINE_TYPE
STRUCTURE pupop_str
{
    Integer MainPupop			// Главная подстаница
    Integer SecondPupop[10]		// Подстраница девайсов
    MainName[10][50]			// Имя главной подстраници
    SecondName[10][10][50]		// Имя подстраници девайсов 
    DefinePupup[5][50]			// Попабы по умолчанию
}


DEFINE_VARIABLE
pupop_str pup[26]
dev tp_setup_TP[] = 
{
    tp_Setup_1,
    tp_Setup_2,
    tp_Setup_3,
    tp_Setup_4,
    tp_Setup_5,
    tp_Setup_6,
    tp_Setup_7,
    tp_Setup_8,
    tp_Setup_9,
    tp_Setup_10,
    tp_Setup_11,
    tp_Setup_12,
    tp_Setup_13,
    tp_Setup_14,
    tp_Setup_15,
    tp_Setup_16,
    tp_Setup_17,
    tp_Setup_18,
    tp_Setup_19,
    tp_Setup_20,
    tp_Setup_21,
    tp_Setup_22,
    tp_Setup_23,
    tp_Setup_Oper,
    tp_Setup_Servernaia,
    tp_Setup_VideoWall
}
VOLATILE txt12[2]
VOLATILE txt1[1]
VOLATILE txt2[1]
VOLATILE Integer Pup_Start

VOLATILE Integer VideoWall_Pressert_ON

VOLATILE Integer WS_VideoWall_Com[23]

DEFINE_START
WS_VideoWall_Com[7]=1
WS_VideoWall_Com[8]=1
// --- Панели Spec ----------------------------------
Pup_Start = 1
pup[Pup_Start].DefinePupup[1] = ''

pup[Pup_Start].MainName[1] = 'Monitor'
pup[Pup_Start].MainName[2] = 'Telefon'
pup[Pup_Start].MainName[3] = 'Conferense_Konf'
pup[Pup_Start].MainName[4] = 'Conferense_WS'

pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
// -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 7
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor_Head_1'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf_Fool'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 8
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor_Head_2'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf_Fool'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 9
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor_Head_3'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf_Fool'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 14
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor'//'Monitor_14'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 15
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor'//'Monitor_15'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 16
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor'//'Monitor_16'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
    // --- Панели Spec ----------------------------------
    Pup_Start = 18
    pup[Pup_Start].DefinePupup[1] = ''
    
    pup[Pup_Start].MainName[1] = 'Monitor'
    pup[Pup_Start].MainName[2] = 'Telefon'
    pup[Pup_Start].MainName[3] = 'Conferense_Konf_Fool'
    pup[Pup_Start].MainName[4] = 'Conferense_WS'
    
    pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
    pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
    pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
    pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
    pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
    pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
    pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
    pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
    pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
    // -------------------------------------------------
// --- Панель Op ----------------------------------
Pup_Start = 24
pup[Pup_Start].DefinePupup[1] = '1_up_Panel'
pup[Pup_Start].DefinePupup[2] = '2_Faid_Panel'
pup[Pup_Start].DefinePupup[3] = ''

pup[Pup_Start].MainName[1] = '1_Main'
pup[Pup_Start].MainName[2] = '2_Video_Com'
pup[Pup_Start].MainName[3] = '3_Volume_1'
pup[Pup_Start].MainName[4] = '4_WS_Conferense'
pup[Pup_Start].MainName[5] = '5_Telefon'
pup[Pup_Start].MainName[6] = '3_Dw_Panel'
pup[Pup_Start].MainName[7] = '7_Light_CUP'
pup[Pup_Start].MainName[8] = '9_1_Setup'
pup[Pup_Start].MainName[9] = '4_WS_Konf_all'

pup[Pup_Start].SecondName[1][1] = '9_Cam_VIP_For_Main'

pup[Pup_Start].SecondName[2][1] = 'VideoWall_Preset_1'
pup[Pup_Start].SecondName[2][2] = 'VideoWall_Preset_2'
pup[Pup_Start].SecondName[2][3] = 'VideoWall_Preset_3'
pup[Pup_Start].SecondName[2][4] = 'VideoWall_Preset_4'
pup[Pup_Start].SecondName[2][5] = 'VideoWall_Preset_5'
pup[Pup_Start].SecondName[2][6] = 'VideoWall_Preset_6'
pup[Pup_Start].SecondName[2][7] = 'VideoWall_Preset_7'
pup[Pup_Start].SecondName[2][8] = 'VideoWall_Preset_8'
pup[Pup_Start].SecondName[2][9] = 'VideoWall_Preset_9'

pup[Pup_Start].SecondName[6][1] = '7-1_Camers'
pup[Pup_Start].SecondName[6][2] = '6-1_1_Polycom'
pup[Pup_Start].SecondName[6][3] = '8-1_TV_AverMedia'
pup[Pup_Start].SecondName[6][4] = '8-6_Duna_1'
pup[Pup_Start].SecondName[6][5] = '8-8_Epihan_1_2'
// -------------------------------------------------
// --- Панель VideoWall ----------------------------------
Pup_Start = 26
pup[Pup_Start].DefinePupup[1] = ''

pup[Pup_Start].MainName[1] = 'VideoWall'
pup[Pup_Start].MainName[2] = ''
pup[Pup_Start].MainName[3] = ''
pup[Pup_Start].MainName[4] = ''

pup[Pup_Start].SecondName[1][1] = 'VideoWall_1'
pup[Pup_Start].SecondName[1][2] = 'VideoWall_2'
pup[Pup_Start].SecondName[1][3] = 'VideoWall_3'
pup[Pup_Start].SecondName[1][4] = 'VideoWall_4'
pup[Pup_Start].SecondName[1][5] = 'VideoWall_5'
pup[Pup_Start].SecondName[1][6] = 'VideoWall_6'
pup[Pup_Start].SecondName[1][7] = 'VideoWall_7'
pup[Pup_Start].SecondName[1][8] = 'VideoWall_8'
pup[Pup_Start].SecondName[1][9] = 'VideoWall_9'
// -------------------------------------------------


DEFINE_MUTUALLY_EXCLUSIVE
([tp_setup_TP[24],21],[tp_setup_TP[24],22],[tp_setup_TP[24],23],[tp_setup_TP[24],24],[tp_setup_TP[24],25],[tp_setup_TP[24],26],[tp_setup_TP[24],27],[tp_setup_TP[24],28],[tp_setup_TP[24],28],[tp_setup_TP[24],29])
([tp_setup_TP[26],11],[tp_setup_TP[26],12],[tp_setup_TP[26],13],[tp_setup_TP[26],14],[tp_setup_TP[26],15],[tp_setup_TP[26],16],[tp_setup_TP[26],17],[tp_setup_TP[64],18],[tp_setup_TP[26],18],[tp_setup_TP[26],19])


Define_Call 'Swich_Off_Button' (dev pan, Integer but_off)
{
    STACK_VAR Integer f 
    
    For (f=1;f<10;f++)
    {
	[pan,f+but_off] = 0
    }
}

Define_Call 'VideoWall_Swich' (Integer Sw)
{
    STACK_VAR Integer j
    For (j=1;j<24;j++)		// Панели специалистов
    {
	pup[j].SecondPupop[1] = Sw
	If (pup[j].MainPupop = 1)
	{
	    SEND_COMMAND tp_setup_TP[j],"'@PPX'"
	    DO_PUSH_TIMED(tp_setup_TP[j],1,1)
	}
    }
    j=24			// Панель Op
	pup[j].SecondPupop[2] = Sw
	    SEND_COMMAND tp_setup_TP[j],"'@PPX'"
	    SEND_COMMAND tp_setup_TP[j],"'@PPN-1_up_Panel;Main'"
	    SEND_COMMAND tp_setup_TP[j],"'@PPN-2_Faid_Panel;Main'"
	    SEND_COMMAND tp_setup_TP[j],"'@PPN-2_Video_Com;Main'"
	    DO_PUSH_TIMED(tp_setup_TP[j],2,1)

    j=26			// Панель возле видео-стены
	pup[j].SecondPupop[1] = Sw
	    SEND_COMMAND tp_setup_TP[j],"'@PPX'"
	    DO_PUSH_TIMED(tp_setup_TP[j],1,1)
}

DEFINE_EVENT
DATA_EVENT[tp_setup_TP]			// --- Онлайн панелей
{
    ONLINE:
    {
	STACK_VAR Integer tp
	STACK_VAR Integer p1
	STACK_VAR Integer p2
	
	tp = get_last(tp_setup_TP)
	
	SEND_COMMAND tp_setup_TP[tp],"'^TXT-400,0,',itoa(tp)"
	
	if ((tp <> 24)&(tp <> 26))	// --- Если не главная панель
	{
	    if (pup[tp].MainPupop=0) pup[tp].MainPupop=1
	    
	    if (pup[tp].SecondPupop[pup[tp].MainPupop]=0) pup[tp].SecondPupop[pup[tp].MainPupop]=1
    
	    SEND_COMMAND tp_setup_TP[tp],"'PAGE-Main'"
	    SEND_COMMAND tp_setup_TP[tp],"'@PPX'"//SEND_COMMAND tp_setup_TP[tp],"'@PPA-Main'"
	    
	    p1 = 1
	    WHILE(pup[tp].DefinePupup[p1]<>'')
	    {
		SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].DefinePupup[p1],';Main'"
		p1++	    
	    }
	    
	    p1 = pup[tp].MainPupop
	    p2 = pup[tp].SecondPupop[p1] 
	    
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],0)
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],p1*10)
	    
	    [tp_setup_TP[tp],p1] = 1
	    [tp_setup_TP[tp],p2+p1*10] = 1
	    
	    if (tp<24)	
	    {
		if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].MainName[pup[tp].MainPupop],';Main' " 
		else
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].MainName[pup[tp].MainPupop],';Main' " 
	    }
	    Else
		SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].MainName[pup[tp].MainPupop],';Main' " 
		
	    If (pup[tp].SecondPupop[pup[tp].MainPupop] > 0)
	    {
		p1 = pup[tp].MainPupop
		p2 = pup[tp].SecondPupop[p1]
		if (tp<24)	
		{
		    if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[p1][p2],';Main'" 
		    else
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].SecondName[p1][p2],';Main'" 
		}
		Else
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[p1][p2],';Main'" 
	    }
	}
	ELSE
	{
	    SEND_COMMAND tp_setup_TP[tp],"'PAGE-Logo'"
	}
    }
}


BUTTON_EVENT[tp_setup_TP,0]
{
    push:
    {
	STACK_VAR Integer tp
	STACK_VAR Integer but
	STACK_VAR Integer p1
	STACK_VAR Integer p2
	
	tp = get_last(tp_setup_TP)
	but = BUTTON.INPUT.CHANNEL
	
	if (but<10)			// Основной попаб
	{
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],0)
	    
	    pup[tp].MainPupop = but
	    [tp_setup_TP[tp],but] = 1
	    
	    If (pup[tp].SecondPupop[but] = 0) pup[tp].SecondPupop[but] = 1
	    [tp_setup_TP[tp],but*10+pup[tp].SecondPupop[but]] = 1
	    if (tp<24)
	    {
		if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
		{
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].MainName[pup[tp].MainPupop],';Main' "
		    if (pup[tp].SecondName[but][pup[tp].SecondPupop[but]] <> '')
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[but][pup[tp].SecondPupop[but]],';Main' " 
		}
		Else
		{
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].MainName[pup[tp].MainPupop],';Main' "
		    if (pup[1].SecondName[but][pup[tp].SecondPupop[but]] <> '')
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].SecondName[but][pup[tp].SecondPupop[but]],';Main' " 
		}
	    }
	    Else
		if (pup[tp].SecondName[but][pup[tp].SecondPupop[but]] <> '')
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[but][pup[tp].SecondPupop[but]],';Main' " 
	}
	Else				// Попаб девайсов
	if (but<100)	
	{
	    txt12 = itoa(but)
	    p1 = atoi(left_string(txt12,1))
	    p2 = atoi(right_string(txt12,1))
	
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],p1*10)
	    
	    pup[tp].SecondPupop[p1] = p2
	    [tp_setup_TP[tp],but] = 1
	    if (tp<24)
	    {
		if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].SecondName[p1][p2],';Main' " 
		Else
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].SecondName[p1][p2],';Main' " 
	    }
	    Else
		SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[p1][p2],';Main' " 
	    
	    if ((tp = 24)|(tp = 25)|(tp = 26))	// Переключение видеостены
	    {
		if ((but>20)&(30>but))
		{
		    VideoWall_Pressert_ON = but-20
		    Call 'VideoWall_Swich' (but-20)
		}
		Else
		if ((but>10)&(20>but))
		{
		    VideoWall_Pressert_ON = but-10
		    Call 'VideoWall_Swich' (but-10)
		}
	    }	    
	}
	
	Else
	if (but=3999)	// --- парольный доустп к главной панели
	{
	    if (pup[tp].MainPupop=0) pup[tp].MainPupop=1
	    
	    if (pup[tp].SecondPupop[pup[tp].MainPupop]=0) pup[tp].SecondPupop[pup[tp].MainPupop]=1
    
	    SEND_COMMAND tp_setup_TP[tp],"'PAGE-Main'"
	    SEND_COMMAND tp_setup_TP[tp],"'@PPX'"//SEND_COMMAND tp_setup_TP[tp],"'@PPA-Main'"
	    
	    p1 = 1
	    WHILE(pup[tp].DefinePupup[p1]<>'')
	    {
		SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].DefinePupup[p1],';Main'"
		p1++	    
	    }
	    
	    p1 = pup[tp].MainPupop
	    p2 = pup[tp].SecondPupop[p1] 
	    
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],0)
	    Call 'Swich_Off_Button' (tp_setup_TP[tp],p1*10)
	    
	    [tp_setup_TP[tp],p1] = 1
	    [tp_setup_TP[tp],p2+p1*10] = 1
	    
	    if (tp<24)	
	    {
		if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].MainName[pup[tp].MainPupop],';Main' " 
		else
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].MainName[pup[tp].MainPupop],';Main' " 
	    }
	    Else
		SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].MainName[pup[tp].MainPupop],';Main' " 
		
	    If (pup[tp].SecondPupop[pup[tp].MainPupop] > 0)
	    {
		p1 = pup[tp].MainPupop
		p2 = pup[tp].SecondPupop[p1]
		if (tp<24)	
		{
		    if (((tp>6)&(tp<10))|(tp=18)|(tp=14)|(tp=15)|(tp=16))
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[p1][p2],';Main'" 
		    else
			SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[1].SecondName[p1][p2],';Main'" 
		}
		Else
		    SEND_COMMAND tp_setup_TP[tp],"'@PPN-',pup[tp].SecondName[p1][p2],';Main'" 
	    }    
	}
    }
}
BUTTON_EVENT[tp_VideoComm_Spec,0]				// --- Коммутация на видео стену специалистов (открываем панель коммутации, если это разрешено)
{
    push:
    {
	STACK_VAR Integer But
	stack_var Integer pan
	Pan = GET_LAST(tp_VideoComm_Spec)
	but = button.input.channel
	If ((but>1112)&(but<1131))
	{
	    If (WS_VideoWall_Com[pan]>0)
		send_command tp_VideoComm_Spec[pan],"'@PPN-Video_in;Main' "
	}
	
    }
}