PROGRAM_NAME='Comm_Audio'
(*
--------Присваивание суматоров--------
    ...12x1...
    
    ...4х1...

    
--------Присваивание номеров входов сумматоров---------
    ---Суматоры рабочек мест---
	1 - SS
	2 - PC 1
	3 - Альтернативный источник (на всех суматорах где есть, используется 3 вход)
    ---Операторская---
	1 - SS
	2 - Включение микрофонов (vip ...)
	3 - Альтернативный источник
    ---СЦ (VIP)---
	1 - DCN
	2 - HDX VIP
	3 - Альтернативный источник
	4 - ss
	5 - Микрофон оператора  (не постоянно)
    ---5.35 (Ражнов)---
	1 - 
	2 - HDX 5.35
	3 - Альтернативный источник
	4 - 
	5 - Микрофон оператора  (не постоянно)
    ---5.37 (Греф)---
	1 - 
	2 - HDX 5.37
	3 - Альтернативный источник
	4 - 
	5 - Микрофон оператора  (не постоянно)
    ---5.45 (ЦУП)---
	1 -
	2 - HDX 5.45
	3 - Альтернативный источник
	4 - 
	5 - Микрофон оператора  (не постоянно)	
	
    ---суматоры HDX------
	---5.35(Ражнов)
	
	---5.37(Греф)---
	
	---СЦ (VIP)---
	    1 - DCN
	---5.45(CUP)---
	    2 - Рабочие места 
	    
    ---Суматоры Epifan---
	1 - Для подключения аудио в зависимости от видео коммутации
	2 - Для записи Микрофона при режиме телефонного разговора в СЦ (VIP)
*)

DEFINE_CONSTANT
Integer Kol_vo_Konf = 10
Integer Kol_vo_WS = 32

DEFINE_TYPE
STRUCTURE Konf_str
{	
    // 1 - 24 - Микрофоны рабочих мест
    Integer Activ 			// --- Активна ли конференция И Сколько источников подключенно
    Integer Slot_in_WS[9]		// --- Что подключено на соответствующий вход (+3)
    Integer Rec				// --- Пишем ли конфу и на куда
}
STRUCTURE WS_Str
{
    Integer WS_Konf_Active		// --- Фактическое значение какая панель к какйо конференции подключена
    Integer Zapros_For_Konf		// --- фактическое значение к какой конференции панель ожидает подлкючнее
    Integer Slot			// --- Переменная, в какой слот подключенна панель
    
    Integer WS_SS_In_Konf		// --- Флаг, присутствует ли телефон SS WS в конференции
    Integer WS_PC1_In_Konf		// --- Флаг, присутствует ли PC WS в конференции
    Integer WS_PC2_In_Konf		// --- Флаг, присутствует ли PC WS в конференции
    
    Integer Else_Audio_In_to_WS		// --- Переменная, сохраняющая, какой альтернативный источник подключен к WS
    
    Integer Auto_Disable		// --- Флаг, заприщения автоматической коммутации аудио
}

DEFINE_VARIABLE
// --- SS ---
VOLATILE Buff_ss_13_For_Audio[1000]
VOLATILE Mini_ss_13_For_Audio[100]
// ----------
volatile Integer Flag_Progress
volatile Integer Flag_Progress_2
Integer Delay_Rep
Integer ssss1,ssss2			// Флаги отработки, Удалить
VOLATILE Integer Pan_online_active

VOLATILE Integer Marix_tp_online[33]

VOLATILE Konf_str konf[Kol_vo_Konf]	// --- Структурная переменная конференции (активна ли, слоты подключения)
VOLATILE WS_Str   WS[Kol_vo_WS]		// --- Структурная переменная рабочего места (к кайо конф подкл, Есть ли запрос на подкл, и какой альтерантивный ист. подк. в WS)

VOLATILE Integer NumIn			// --- Локальная переменная, номер входа (DSP)
VOLATILE integer h_bit			// --- Локлаьная переменная, верхний и нихний байт номер входа (DSP)
VOLATILE integer l_bit			// --- Локлаьная переменная, верхний и нихний байт номер входа (DSP)
VOLATILE Integer x_audio		// --- Локальная переменная для циклов
VOLATILE Char DSP_For_tp[100]		// --- Строка содержащая номера панелей для данных DSP
VOLATILE Integer DSP_For_tp_int		// --- Int содержащая номера панелей для данных DSP
VOLATILE Float Znak_Value		// --- Переменная для вычисления уровня громкости, может содержать -
VOLATILE Float Float_Value_Volume	// --- Переменная содержащая дробную часть громкости
VOLATILE Float sFloat_Value_Volume	// --- Переменная содержащая дробную часть громкости
VOLATILE Integer Flag_SC_Connect_to_Operator 	// --- Флаг, показывает подключен ли микрофон подслушки к динамикам оператора


// --- Коммутация микрофона на кодеки и ss СЦ ---
VOLATILE integer Flag_mic_ComToHDX [] = {1,0,5,6}		// 1 - vip, 2 - цуп, 3 - 5.35, 4 - 5.37; 1 - DCN, 2 - Потолочка, 3 - Микрофон оператора, 4 - радио микрофоны

dev tp_audio_micComToCodec_all [] =
{
    tp_audio_micComToCodec_main,
    tp_audio_micComToCodec_Vip
}
// ----------------------------------------------

Dev Epihfan_tp_Audio [] =
{
    tp_Epihan_Op_1,
    tp_Epihan_Op_2
}
dev tp_Audio_All [] =
{
    tp_Audio_ws_1,
    tp_Audio_ws_2,
    tp_Audio_ws_3,
    tp_Audio_ws_4,
    tp_Audio_ws_5,
    tp_Audio_ws_6,
    tp_Audio_ws_7,
    tp_Audio_ws_8,
    tp_Audio_ws_9,
    tp_Audio_ws_10,
    tp_Audio_ws_11,
    tp_Audio_ws_12,
    tp_Audio_ws_13,
    tp_Audio_ws_14,
    tp_Audio_ws_15,
    tp_Audio_ws_16,
    tp_Audio_ws_17,
    tp_Audio_ws_18,
    tp_Audio_ws_19,
    tp_Audio_ws_20,
    tp_Audio_ws_21,
    tp_Audio_ws_22,
    tp_Audio_ws_23,
    tp_Audio_Oper,	// 24
    tp_Audio_Raznov,	// 25
    tp_Audio_MAIN_5_35,	//tp_Audio_Gref,	// 26
    tp_Audio_MAIN_SC,	//tp_Audio_VIP,	// 27
    tp_Audio_CUP,	// 28
    tp_Audio_VKS_1,	// 29
    tp_Audio_VKS_2,	// 30
    tp_Audio_VKS_3,	// 31
    tp_Audio_VKS_4,	// 32
    tp_Audio_VideoWall	// 33
}

Dev tp_Audio_ws_vol [] =
{
    tp_Audio_ws_vol_1,
    tp_Audio_ws_vol_2,
    tp_Audio_ws_vol_3,
    tp_Audio_ws_vol_4,
    tp_Audio_ws_vol_5,
    tp_Audio_ws_vol_6,
    tp_Audio_ws_vol_7,
    tp_Audio_ws_vol_8,
    tp_Audio_ws_vol_9,
    tp_Audio_ws_vol_10,
    tp_Audio_ws_vol_11,
    tp_Audio_ws_vol_12,
    tp_Audio_ws_vol_13,
    tp_Audio_ws_vol_14,
    tp_Audio_ws_vol_15,
    tp_Audio_ws_vol_16,
    tp_Audio_ws_vol_17,
    tp_Audio_ws_vol_18,
    tp_Audio_ws_vol_19,
    tp_Audio_ws_vol_20,
    tp_Audio_ws_vol_21,
    tp_Audio_ws_vol_22,
    tp_Audio_ws_vol_23,
    tp_Audio_Oper_vol,
    tp_Audio_Raznov_vol,
    tp_Audio_Gref_vol,
    tp_Audio_VIP_vol,
    tp_Audio_CUP_vol,
    tp_Audio_Gref_vol_2
}

VOLATILE Integer AudioOut_For_VideoCom[160]	// --- Привязка аудио к видео

DEFINE_MUTUALLY_EXCLUSIVE
    ([tp_audio_micComToCodec_main,1]..[tp_audio_micComToCodec_main,9])
    ([tp_audio_micComToCodec_main,11]..[tp_audio_micComToCodec_main,19])
    ([tp_audio_micComToCodec_main,21]..[tp_audio_micComToCodec_main,29])
    ([tp_audio_micComToCodec_main,31]..[tp_audio_micComToCodec_main,39])
    ([tp_audio_micComToCodec_Vip,1]..[tp_audio_micComToCodec_Vip,9])
    ([tp_audio_micComToCodec_Vip,11]..[tp_audio_micComToCodec_Vip,19])
    ([tp_audio_micComToCodec_Vip,21]..[tp_audio_micComToCodec_Vip,29])
    ([tp_audio_micComToCodec_Vip,31]..[tp_audio_micComToCodec_Vip,39])

DEFINE_START
CREATE_BUFFER dv_SS_13,Buff_ss_13_For_Audio	// --- буфер SS 13 yf СЦ
    Wait(300)
	Erese_All_Konf_online ()
    Wait(370)
	Opros_all_Faiders ()
    Wait(400)
	Opros_all_Faiders ()
    Delay_Rep = 20
    CREATE_BUFFER dv_AudioMatrix,AudioBuff

DEFINE_START 		// --- Привязка аудио к видео
Wait(20)
{
    AudioOut_For_VideoCom[1]	=		0	//1	Epiphan #1
    AudioOut_For_VideoCom[2]	=		0	//2	Epiphan #2
    AudioOut_For_VideoCom[3]	=	Sumator_4[31].OutNumber	//3	Dune #1
    AudioOut_For_VideoCom[4]	=	Sumator_4[32].OutNumber	//4	Dune #2
    AudioOut_For_VideoCom[5]	=	MIC_Potolochka_VIP//InWS_Mic[27].InNumber	//5	Камера Sony BRC Z330 #1
    AudioOut_For_VideoCom[6]	=	MIC_Potolochka_VIP//InWS_Mic[27].InNumber	//6	Камера Sony BRC Z330 #2
    AudioOut_For_VideoCom[7]	=		0	//7	Камера Sony BRC Z330 #3
    AudioOut_For_VideoCom[8]	=		0	//8	Камера Sony BRC Z330 #4
    AudioOut_For_VideoCom[9]	=		0	//9	Камера Sony BRC Z330 #5
    AudioOut_For_VideoCom[10]	=		0	//10	Камера Sony BRC Z330 #6
    AudioOut_For_VideoCom[11]	=		0	//11	нет
    AudioOut_For_VideoCom[12]	=		0	//12	нет
    AudioOut_For_VideoCom[13]	=		0	//13	нет
    AudioOut_For_VideoCom[14]	=		0	//14	нет
    AudioOut_For_VideoCom[15]	=		0	//15	нет
    AudioOut_For_VideoCom[16]	=		0	//16	нет
    AudioOut_For_VideoCom[17]	=		0	//17	нет
    AudioOut_For_VideoCom[18]	=		0	//18	нет
    AudioOut_For_VideoCom[19]	=		0	//19	нет
    AudioOut_For_VideoCom[20]	=		0	//20	нет
    AudioOut_For_VideoCom[21]	=		0	//21	нет
    AudioOut_For_VideoCom[22]	=		0	//22	нет
    AudioOut_For_VideoCom[23]	=		0	//23	нет
    AudioOut_For_VideoCom[24]	=		0	//24	нет
    AudioOut_For_VideoCom[25]	=		0	//25	нет
    AudioOut_For_VideoCom[26]	=		0	//26	нет
    AudioOut_For_VideoCom[27]	=		0	//27	нет
    AudioOut_For_VideoCom[28]	=		0	//28	нет
    AudioOut_For_VideoCom[29]	=		0	//29	нет
    AudioOut_For_VideoCom[30]	=		0	//30	нет
    AudioOut_For_VideoCom[31]	=		0	//31	нет
    AudioOut_For_VideoCom[32]	=		0	//32	нет
    AudioOut_For_VideoCom[33]	=		0	//33	нет
    AudioOut_For_VideoCom[34]	=		0	//34	нет
    AudioOut_For_VideoCom[35]	=		0	//35	нет
    AudioOut_For_VideoCom[36]	=		0	//36	нет
    AudioOut_For_VideoCom[37]	=		0	//37	нет
    AudioOut_For_VideoCom[38]	=		0	//38	нет
    AudioOut_For_VideoCom[39]	=		0	//39	нет
    AudioOut_For_VideoCom[40]	=		0	//40	нет
    AudioOut_For_VideoCom[41]	=		0	//41	нет
    AudioOut_For_VideoCom[42]	=		0	//42	нет
    AudioOut_For_VideoCom[43]	=		0	//43	нет
    AudioOut_For_VideoCom[44]	=		0	//44	нет
    AudioOut_For_VideoCom[45]	=		0	//45	нет
    AudioOut_For_VideoCom[46]	=		0	//46	нет
    AudioOut_For_VideoCom[47]	=		0	//47	нет
    AudioOut_For_VideoCom[48]	=		0	//48	нет
    AudioOut_For_VideoCom[49]	=	PC[1	].InNumber		//49	PC # 1.1
    AudioOut_For_VideoCom[50]	=	PC[2	].InNumber		//50	PC # 1.2
    AudioOut_For_VideoCom[51]	=	PC[3	].InNumber		//51	PC # 2.1
    AudioOut_For_VideoCom[52]	=	PC[4	].InNumber		//52	PC # 2.2
    AudioOut_For_VideoCom[53]	=	PC[5	].InNumber		//53	PC # 3.1
    AudioOut_For_VideoCom[54]	=	PC[6	].InNumber		//54	PC # 3.2
    AudioOut_For_VideoCom[55]	=	PC[7	].InNumber		//55	PC # 4.1
    AudioOut_For_VideoCom[56]	=	PC[8	].InNumber		//56	PC # 4.2
    AudioOut_For_VideoCom[57]	=	PC[9	].InNumber		//57	PC # 5.1
    AudioOut_For_VideoCom[58]	=	PC[10	].InNumber		//58	PC # 5.2
    AudioOut_For_VideoCom[59]	=	PC[11	].InNumber		//59	PC # 6.1
    AudioOut_For_VideoCom[60]	=	PC[12	].InNumber		//60	PC # 6.2
    AudioOut_For_VideoCom[61]	=	PC[13	].InNumber		//61	PC # 7.1
    AudioOut_For_VideoCom[62]	=	PC[14	].InNumber		//62	PC # 7.2
    AudioOut_For_VideoCom[63]	=	PC[15	].InNumber		//63	PC # 8.1
    AudioOut_For_VideoCom[64]	=	PC[16	].InNumber		//64	PC # 8.2
    AudioOut_For_VideoCom[65]	=	PC[17	].InNumber		//65	PC # 9.1
    AudioOut_For_VideoCom[66]	=	PC[18	].InNumber		//66	PC # 9.2
    AudioOut_For_VideoCom[67]	=	PC[19	].InNumber		//67	PC # 10.1
    AudioOut_For_VideoCom[68]	=	PC[20	].InNumber		//68	PC # 10.2
    AudioOut_For_VideoCom[69]	=	PC[21	].InNumber		//69	PC # 11.1
    AudioOut_For_VideoCom[70]	=	PC[22	].InNumber		//70	PC # 11.2
    AudioOut_For_VideoCom[71]	=	PC[23	].InNumber		//71	PC # 12.1
    AudioOut_For_VideoCom[72]	=	PC[24	].InNumber		//72	PC # 12.2
    AudioOut_For_VideoCom[73]	=	PC[25	].InNumber		//73	PC # 13.1
    AudioOut_For_VideoCom[74]	=	PC[26	].InNumber		//74	PC # 13.2
    AudioOut_For_VideoCom[75]	=	PC[27	].InNumber		//75	PC # 14.1
    AudioOut_For_VideoCom[76]	=	PC[28	].InNumber		//76	PC # 14.2
    AudioOut_For_VideoCom[77]	=	PC[29	].InNumber		//77	PC # 15.1
    AudioOut_For_VideoCom[78]	=	PC[30	].InNumber		//78	PC # 15.2
    AudioOut_For_VideoCom[79]	=	PC[31	].InNumber		//79	PC # 16.1
    AudioOut_For_VideoCom[80]	=	PC[32	].InNumber		//80	PC # 16.2
    AudioOut_For_VideoCom[81]	=	PC[33	].InNumber		//81	PC # 17.1
    AudioOut_For_VideoCom[82]	=	PC[34	].InNumber		//82	PC # 17.2
    AudioOut_For_VideoCom[83]	=	PC[35	].InNumber		//83	PC # 18.1
    AudioOut_For_VideoCom[84]	=	PC[36	].InNumber		//84	PC # 18.2
    AudioOut_For_VideoCom[85]	=	PC[37	].InNumber		//85	PC # 19.1
    AudioOut_For_VideoCom[86]	=	PC[38	].InNumber		//86	PC # 19.2
    AudioOut_For_VideoCom[87]	=	PC[39	].InNumber		//87	PC # 20.1
    AudioOut_For_VideoCom[88]	=	PC[40	].InNumber		//88	PC # 20.2
    AudioOut_For_VideoCom[89]	=	PC[41	].InNumber		//89	PC # 21.1
    AudioOut_For_VideoCom[90]	=	PC[42	].InNumber		//90	PC # 21.2
    AudioOut_For_VideoCom[91]	=	PC[43	].InNumber		//91	PC # 22.1
    AudioOut_For_VideoCom[92]	=	PC[44	].InNumber		//92	PC # 22.2
    AudioOut_For_VideoCom[93]	=	PC[45	].InNumber		//93	PC # 23.1
    AudioOut_For_VideoCom[94]	=	PC[46	].InNumber		//94	PC # 23.2
    AudioOut_For_VideoCom[95]	=	PC[47	].InNumber		//95	PC 5.35_alfa
    AudioOut_For_VideoCom[96]	=	PC[48	].InNumber		//96	PC 5.35_sigma
    AudioOut_For_VideoCom[97]	=	PC[49	].InNumber		//97	PC 5.37_alfa
    AudioOut_For_VideoCom[98]	=	PC[50	].InNumber		//98	PC 5.37_sigma
    AudioOut_For_VideoCom[99]	=	PC[51	].InNumber		//99	PC Operator_1.1
    AudioOut_For_VideoCom[100]	=	PC[52	].InNumber		//100	PC Operator_1.2
    AudioOut_For_VideoCom[101]	=	PC[53	].InNumber		//101	PC Operator_2.1
    AudioOut_For_VideoCom[102]	=	PC[54	].InNumber		//102	PC Operator_2.2
    AudioOut_For_VideoCom[103]	=	In_VKS[2]	//103	Polycom HDX 9000 #1 video out #1
    AudioOut_For_VideoCom[104]	=	In_VKS[2]	//104	Polycom HDX 9000 #1 video out #2
    AudioOut_For_VideoCom[105]	=	In_VKS[4]	//105	Polycom HDX 9000 #2 video out #1
    AudioOut_For_VideoCom[106]	=	In_VKS[4]	//106	Polycom HDX 9000 #2 video out #2
    AudioOut_For_VideoCom[107]	=	In_VKS[6]	//107	Polycom HDX 9000 #3 video out #1
    AudioOut_For_VideoCom[108]	=	In_VKS[6]	//108	Polycom HDX 9000 #3 video out #2
    AudioOut_For_VideoCom[109]	=	In_VKS[8]	//109	Polycom HDX 9000 #4 video out #1
    AudioOut_For_VideoCom[110]	=	In_VKS[8]	//110	Polycom HDX 9000 #4 video out #2
    AudioOut_For_VideoCom[111]	=		0		//111	PC HP Z800 Video out #1
    AudioOut_For_VideoCom[112]	=	        0	        //112	PC HP Z800 Video out #2
    AudioOut_For_VideoCom[113]	=		0		//113	Контроллер видеостены Video out #1
    AudioOut_For_VideoCom[114]	=		0		//114	Контроллер видеостены Video out #2
    AudioOut_For_VideoCom[115]	=		0		//115	Контроллер видеостены Video out #3
    AudioOut_For_VideoCom[116]	=		0		//116	Контроллер видеостены Video out #4
    AudioOut_For_VideoCom[117]	=		0		//117	Контроллер видеостены Video out #5
    AudioOut_For_VideoCom[118]	=		0		//118	Контроллер видеостены Video out #6
    AudioOut_For_VideoCom[119]	=		0		//119	Контроллер видеостены Video out #7
    AudioOut_For_VideoCom[120]	=		0		//120	Контроллер видеостены Video out #8
    AudioOut_For_VideoCom[121]	=		0		//121	Контроллер видеостены Video out #9
    AudioOut_For_VideoCom[122]	=		0		//122	Контроллер видеостены Video out #10
    AudioOut_For_VideoCom[123]	=		0		//123	Контроллер видеостены Video out #11
    AudioOut_For_VideoCom[124]	=		0		//124	Контроллер видеостены Video out #12
    AudioOut_For_VideoCom[125]	=		0		//125	Контроллер видеостены Video out #13
    AudioOut_For_VideoCom[126]	=		0		//126	Контроллер видеостены Video out #14
    AudioOut_For_VideoCom[127]	=		0		//127	Контроллер видеостены Video out #15
    AudioOut_For_VideoCom[128]	=	        0              	//128	Контроллер видеостены Video out #16
    AudioOut_For_VideoCom[129]	=		0		//129	Контроллер видеостены Video out #17
    AudioOut_For_VideoCom[130]	=		0		//130	Контроллер видеостены Video out #18
    AudioOut_For_VideoCom[131]	=	Faider[1].InNumber	//131	TV-Tuner AverTV #1
    AudioOut_For_VideoCom[132]	=	Faider[2].InNumber	//132	TV-Tuner AverTV #2
    AudioOut_For_VideoCom[133]	=	Faider[3].InNumber	//133	TV-Tuner AverTV #3
    AudioOut_For_VideoCom[134]	=	Faider[4].InNumber	//134	TV-Tuner AverTV #4
    AudioOut_For_VideoCom[135]	=	Faider[5].InNumber	//135	TV-Tuner AverTV #5
    AudioOut_For_VideoCom[136]	=		0		//136	PC HP Z800 Video out #3
    AudioOut_For_VideoCom[137]	=		0		//137	PC HP Z800 Video out #4
    AudioOut_For_VideoCom[138]	=		0		//138	нет
    AudioOut_For_VideoCom[139]	=	In_Luchki[1]		//139	Лючек #1  каб 5.35 
    AudioOut_For_VideoCom[140]	=	In_Luchki[2]		//140	Лючек #1  каб 5.37 
    AudioOut_For_VideoCom[141]	=	In_Luchki[3]		//141	Лючек #2  каб 5.37 
    AudioOut_For_VideoCom[142]	=	In_Luchki[4]		//142	Лючек #1  каб 5.30
    AudioOut_For_VideoCom[143]	=	In_Luchki[5]		//143	Лючек #2  каб 5.30 
    AudioOut_For_VideoCom[144]	=	In_Luchki[6]		//144	Лючек #3  каб 5.30
    AudioOut_For_VideoCom[145]	=		0		//145	
    AudioOut_For_VideoCom[146]	=		0		//146	
    AudioOut_For_VideoCom[147]	=		0		//147	
    AudioOut_For_VideoCom[148]	=		0		//148	
    AudioOut_For_VideoCom[149]	=		0		//149	
    AudioOut_For_VideoCom[150]	=		0		//150	
    AudioOut_For_VideoCom[151]	=	InSS_HeadPhones[25].InNumber	//151	Активная камера VIP = телефонный интерфейс
    AudioOut_For_VideoCom[152]	=		0		//152	
    AudioOut_For_VideoCom[153]	=		0		//153	
    AudioOut_For_VideoCom[154]	=		0		//154	
    AudioOut_For_VideoCom[155]	=		0		//155	
    AudioOut_For_VideoCom[156]	=		0		//156	
    AudioOut_For_VideoCom[157]	=		0		//157	
    AudioOut_For_VideoCom[158]	=		0		//158	
    AudioOut_For_VideoCom[159]	=		0		//159	
    AudioOut_For_VideoCom[160]	=		0		//160	
}



DEFINE_CALL 'FB_ss_13'
{
    If (find_string(Buff_ss_13_For_Audio,"$0D",1))
    {
	Mini_ss_13_For_Audio = remove_string(Buff_ss_13_For_Audio,"$0D",1)
	SELECT
	{
	    ACTIVE(find_string(Mini_ss_13_For_Audio,"'val phone_connect "Phone 1 Out" 1'",1)):
	    {
		SEND_STRING vtp_Audio,"'0,',itoa(Sumator_12[27].InNumberFirst+1)" // DCN на личный суматор VIP 3
	    }
	    ACTIVE(find_string(Mini_ss_13_For_Audio,"'val phone_connect "Phone 1 Out" 0'",1)):
	    {
		If ((OUT_FB[41]=107)|(OUT_FB[41]=108)|
		    (OUT_FB[38]=107)|(OUT_FB[38]=108)|
		    (OUT_FB[37]=107)|(OUT_FB[37]=108))
		{
			ConnectAudio_Point (0,Sumator_12[27].InNumberFirst+1) 				// DCN на личный суматор VIP 1
			ConnectAudio_Point (Faider[8].InNumber,Sumator_12[27].InNumberFirst+2) 		// HDX на личный суматор VIP 2
		}
		Else
		{
			ConnectAudio_Point (Faider[10].InNumber,Sumator_12[27].InNumberFirst+1) 	// DCN на личный суматор VIP 3
			ConnectAudio_Point (0,Sumator_12[27].InNumberFirst+2)				// 0 вместо HDX, на личный суматор VIP
		}
	    }
	}
    }    
}
DEFINE_CALL 'Audio_FB'
{
    Flag_Progress = 1
    If (length_string(AudioBuff))
    {
	Audio_x = remove_string(AudioBuff,"$FF",1)
	if (find_string(Audio_x,"$FE,$01,$FE,$01",1)=0) // Если не пустой пакет
	{
	    AudioMiniBuff = Audio_X
	    WHILE (find_string(Audio_X,"$FE,$FE",1))
	    {REMOVE_STRING(Audio_X,"$FE,$FE",1)}
	    SELECT
	    {
		ACTIVE(left_string(Audio_X,2)="$00,$73"):// Обратка о состоянии параметров DSP
		{
		    get_buffer_string(Audio_X,4)
		    NumIn = Audio_X[1]<<8 + Audio_X[2]	// Находим номер входа
		    x_audio = 0
		    WHILE(x_audio<54)			// Проверяем, интересует ли нас вход
		    {
			x_audio++
			if (InNum[x_audio].Number=NumIn)// Да, интересует
			{
			    InNum[x_audio].Mute = mid_string(Audio_X,5,1)
			    InNum[x_audio].Vol = mid_string(Audio_X,6,1)
			    DSP_For_tp = InNum[x_audio].For_TP
			    
			    WHILE(LENGTH_STRING(DSP_For_tp))
			    {
				DSP_For_tp_int = atoi(remove_string(DSP_For_tp,"'!'",1))
				if (DSP_For_tp_int<25) 
				    [tp_Audio_ws_vol[DSP_For_tp_int],99] = InNum[x_audio].Mute
				else
				    [tp_Audio_ws_vol[DSP_For_tp_int],x_audio] = InNum[x_audio].Mute
				SEND_LEVEL tp_Audio_All[DSP_For_tp_int],x_audio,InNum[x_audio].Vol
				if (InNum[x_audio].Vol<192)
				{
				    if (InNum[x_audio].Vol<129) 
				    {
					Znak_Value = (160-InNum[x_audio].Vol)
					Float_Value_Volume = Znak_Value/2
					SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int],"'^TXT-',itoa(x_audio),',0,-',ftoa(Float_Value_Volume)"
				    }
				    Else
				    {
					Znak_Value = (192-InNum[x_audio].Vol)
					Float_Value_Volume = Znak_Value/4
					SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int],"'^TXT-',itoa(x_audio),',0,-',ftoa(Float_Value_Volume)"
				    }
				}
				Else
				    SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int],"'^TXT-',itoa(x_audio),',0,',ftoa((InNum[x_audio].Vol-192)/4)"
			    }
			    x_audio = x_audio + 100
			}
		    }
		}
		
		ACTIVE(left_string(Audio_X,2)="$00,$35"):// Информирование о изменении состояний параметров DSP
		{
		    get_buffer_string(Audio_X,4)
		    h_bit = get_buffer_char(Audio_X)
		    l_bit = get_buffer_char(Audio_X)
		    NumIn = h_bit<<8 + l_bit		// Находим номер входа
		    x_audio = 0
		    WHILE(x_audio<54)			// Проверяем, интересует ли нас вход
		    {
			x_audio++
			if (InNum[x_audio].Number=NumIn)// Да, интересует
			{
			    Opros_DSP_Param (x_audio)
			    x_audio = 100
			}
		    }
		}
	    }
	}
    }
    Flag_Progress = 0
}

DEFINE_FUNCTION Conect_to_Konf (Integer ws_n, Integer konf_n)		// --- Процедура конекта панели к конференции
{
    STACK_VAR Integer a_x
    STACK_VAR Integer Slot_n
    STACK_VAR Integer konf_x
    STACK_VAR Integer ws_x
    STACK_VAR Integer X_SlotConf
    
    konf_x = konf_n
    ws_x = ws_n
    if (konf[konf_x].Activ<9)	// Если конференция не переполнена
    {
	a_x=1
	Slot_n = 0
	WHILE (a_x<9)			// Нахождение пустого слота подключения
	{
	    if (konf[konf_x].Slot_in_WS[a_x] = 0)	// нашли пустой
	    {
		Slot_n = a_x
		a_x=99
	    }
	    a_x++
	}
	
	If (Slot_n)			// Если нашли свободный порт подключения
	{
	    konf[konf_x].Activ++			// увеличиваем колличество подключенный к конференции источников
	    konf[konf_x].Slot_in_WS[Slot_n] = ws_x	// Записываем панель в слот подключения
	    ws[ws_x].Slot = Slot_n			// Записываем в память панели слот подключения
	    WS[ws_x].WS_Konf_Active = konf_x		// К какой конференции принадлежит панель
	    
	    [tp_Audio_All[ws_x],99] = 1			// FB на красный кружек
	    send_command tp_Audio_All[ws_x],"'^TXT-99,2,',itoa(konf_x)" // FB на красный кружек, к какой конференции принадлижит панель
	    
	    for (a_x=1;a_x<Kol_vo_WS+1;a_x++)
	    {
		send_command tp_Audio_All[a_x],"'^TXT-',itoa(ws_x),',0,',itoa(konf_x)"				// Отправление номера каналов конфиренций на кнопки добавления
		SEND_COMMAND tp_Audio_All[a_x],"'^TXT-',itoa(konf_x+100),',0,',itoa(konf[konf_x].Activ)"  	// Отправление кол-во активных соединений на кнопки подключения к конференции
		If (WS[a_x].WS_Konf_Active=WS[ws_x].WS_Konf_Active)						// Проверка принадлежность других панелей к Конференции этой панели
		{
		    [tp_Audio_All[ws_x],a_x] = 1
		    [tp_Audio_All[a_x],ws_x] = 1
		    [tp_Audio_All[ws_x],100+a_x] = 0	// Обнуления FB на кнопки прямого входа в конф.
		}
		Else
		    [tp_Audio_All[ws_x],a_x] = 0
		[tp_Audio_All[ws_x],100+konf_x] = 1	// FB на кнопку прямого входа в конф.
	    }  
	    
	    // Комутация аудио
	    for (a_x=1;a_x<9;a_x++)
	    {
		X_SlotConf = konf[konf_x].Slot_in_WS[a_x]
		if ((X_SlotConf>0)&(a_x<>Slot_n))	// Если слот микшера не пуст, и не свой микшер
		{
		    ConnectAudio_Point (InWS_Mic[ws_n].InNumber,Sumator_12[X_SlotConf].InNumberFirst+4+Slot_n)	//Конект микрофона к личному микшеру чужему
		    ConnectAudio_Point (InWS_Mic[X_SlotConf].InNumber,Sumator_12[ws_n].InNumberFirst+4+a_x)	//Конект микрофона к личному микшеру своемму
		}
	    }
	    
	}
	Else				// Не нашли свободный порт подключения
	{
	    SEND_COMMAND tp_Audio_All[ws_n],"'@PPN-Alert_All_audio'"
	    SEND_COMMAND tp_Audio_All[ws_n],"'^UNI-4000,0,041D04350020043D04300448043B0438002004410432043E0431043E0434043D044B04390020043F043E044004420020043F043E0434043A043B044E04470435043D0438044F'"
	}
    }
    else 				// Конференция переполнена
    {
	SEND_COMMAND tp_Audio_All[ws_n],"'@PPN-Alert_All_audio'"
	SEND_COMMAND tp_Audio_All[ws_n],"'^UNI-4000,0,041A043E043D0444043504400435043D04460438044F0020043F043504400435043F043E043B043D0435043D0430'"
    }
    
    if (konf[konf_x].Rec)	// Если писали на епифан, то перекомутация епифана
    {
	rec_Konf (konf_x,konf[konf_x].Rec)
    }
}

DEFINE_FUNCTION Conect_to_Konf_SS_And_PC (Integer ws_n, Integer konf_n)	// --- Процедура конекта SS и PC панели к конференции
{
    STACK_VAR Integer a_x
    STACK_VAR Integer konf_x
    STACK_VAR Integer Slot_n
    STACK_VAR Integer ws_x
    STACK_VAR INTEGER X_SlotConf

    ws_x = ws_n
    konf_x = konf_n
    
    if (konf[konf_x].Activ<9)		// Если конференция не переполнена
    {
	a_x=1
	Slot_n = 0
	WHILE (a_x<9)			// Нахождение пустого слота подключения
	{
	    if (konf[konf_x].Slot_in_WS[a_x] = 0)	// нашли пустой
	    {
		Slot_n = a_x
		a_x=99
	    }
	    a_x++
	}
	
	If (Slot_n)			// Если нашли свободный порт подключения
	{
	    konf[konf_x].Activ++			// увеличиваем колличество подключенный к конференции источников
	    konf[konf_x].Slot_in_WS[Slot_n] = ws_x+40	// Записываем панель в слот подключения
	    WS[ws_x].WS_SS_In_Konf = Slot_n		// Записываем слот подключения в память активности ss рабочего места
	    
	    [tp_Audio_All[ws_x],200] = 1		// FB на кнопку добваления ss
	    [tp_Audio_All[ws_x],98] = 1			// FB на красный кружек
	    send_command tp_Audio_All[ws_x],"'^TXT-98,2,',itoa(konf_x)" // FB на красный кружек, к какой конференции принадлижит панель
	    
	    for (a_x=1;a_x<Kol_vo_WS+1;a_x++)
	    {
		SEND_COMMAND tp_Audio_All[a_x],"'^TXT-',itoa(konf_x+100),',0,',itoa(konf[konf_x].Activ)"  // Отправление кол-во активных соединений на кнопки подключения к конференции
	    }  
	    
	    // Комутация аудио
	    for (a_x=1;a_x<9;a_x++)
	    {
		X_SlotConf = konf[konf_x].Slot_in_WS[a_x]
		if ((X_SlotConf>0))	// Если слот микшера не пуст, и не свой слот микшера
		{
		    ConnectAudio_Point (InSS_HeadPhones[ws_x].InNumber,Sumator_12[X_SlotConf].InNumberFirst+4+Slot_n)	//Конект ss к личному микшеру чужему
		    ConnectAudio_Point (InWS_Mic[X_SlotConf].InNumber,Sumator_12[ws_x+40].InNumberFirst+4+a_x)		//Конект микрофона к личному микшеру своемму
		}
	    }
	    
	}
	Else				// Не нашли свободный порт подключения
	{
	    SEND_COMMAND tp_Audio_All[ws_n],"'@PPN-Alert_All_audio'"
	    SEND_COMMAND tp_Audio_All[ws_n],"'^UNI-4000,0,041D04350020043D04300448043B0438002004410432043E0431043E0434043D044B04390020043F043E044004420020043F043E0434043A043B044E04470435043D0438044F'"
	}
    }
    else 				// Конференция переполнена
    {
	SEND_COMMAND tp_Audio_All[ws_n],"'@PPN-Alert_All_audio'"
	SEND_COMMAND tp_Audio_All[ws_n],"'^UNI-4000,0,041A043E043D0444043504400435043D04460438044F0020043F043504400435043F043E043B043D0435043D0430'"
    }
    
    if (konf[konf_x].Rec)	// Если писали на епифан, то перекомутация епифана
    {
	rec_Konf (konf_x,konf[konf_x].Rec)
    }
}

DEFINE_FUNCTION Disconect_to_Konf (Integer ws_n, Integer konf_n_All)		// --- Выход из Конференции
{
    STACK_VAR Integer a_x
    STACK_VAR Integer Slot_n
    STACK_VAR Integer konf_x
    STACK_VAR Integer ws_x
    
    konf_x = konf_n_All
    ws_x = ws_n
    Slot_n = ws[ws_x].Slot
    If (Slot_n)			// Если нашли порт подключения
    {
	// Раскомутация аудио
	for (a_x=1;a_x<9;a_x++)
	{
	    if ((konf[konf_x].Slot_in_WS[a_x]>0)&(a_x<>Slot_n))	// Если слот микшера не пуст, и не свой микшер
		ConnectAudio_Point (0,Sumator_12[konf[konf_x].Slot_in_WS[a_x]].InNumberFirst+4+Slot_n)	//Конект 0 к личному микшеру на других ws
	    ConnectAudio_Point (0,Sumator_12[ws_x].InNumberFirst+4+a_x)	//Конект 0 к личному микшеру на своем ws
	}
    
	konf[konf_x].Activ--			// Уменьшаем колличество подключенный источников к конференции
	konf[konf_x].Slot_in_WS[Slot_n] = 0	// Записываем панель в слот подключения
	ws[ws_x].Slot = 0			// Записываем в память панели слот подключения
	WS[ws_x].WS_Konf_Active = 0		// К какой конференции принадлежит панель
	
	[tp_Audio_All[ws_x],99] = 0			// FB на красный кружек
	send_command tp_Audio_All[ws_x],"'^TXT-99,0,0'" // FB на красный кружек, к какой конференции принадлижит панель
	
	for (a_x=1;a_x<Kol_vo_WS+1;a_x++)
	{
	    send_command tp_Audio_All[a_x],"'^TXT-',itoa(ws_x),',0,0'"		// Отправление номера каналов конфиренций на кнопки добавления
	    SEND_COMMAND tp_Audio_All[a_x],"'^TXT-',itoa(konf_x+100),',0,',itoa(konf[konf_x].Activ)"  // Отправление кол-во активных соединений на кнопки подключения к конференции
	    {
		[tp_Audio_All[ws_x],a_x] = 0
		[tp_Audio_All[a_x],ws_x] = 0
		[tp_Audio_All[ws_x],100+a_x] = 0		// Обнуления FB на кнопки прямого входа в конф.
	    }
	    [tp_Audio_All[ws_x],100+konf_x] = 0			// FB на кнопку прямого входа в конф.
	}  
    }    

    if (konf[konf_x].Rec)	// Если писали на епифан, то перекомутация епифана
    {
	rec_Konf (konf_x,konf[konf_x].Rec)
    }
}

DEFINE_FUNCTION Disconect_to_Konf_SS_And_PS (Integer ws_n, Integer konf_n(*, Integer SS_Or_PC_n*))	// --- Отключение SS и PC из Конференции
{
    STACK_VAR Integer a_x
    STACK_VAR Integer Slot_n
    STACK_VAR Integer konf_x
    STACK_VAR Integer ws_x
    
    konf_x = konf_n
    ws_x = ws_n
    Slot_n = WS[ws_x].WS_SS_In_Konf//ws[ws_x].Slot
    If (Slot_n)			// Если нашли порт подключения
    {
	// Раскомутация аудио
	for (a_x=1;a_x<9;a_x++)
	{
	    if ((konf[konf_x].Slot_in_WS[a_x]>0)&(a_x<>Slot_n))	// Если слот микшера не пуст, и не свой микшер
		ConnectAudio_Point (0,Sumator_12[konf[konf_x].Slot_in_WS[a_x]].InNumberFirst+4+Slot_n)	//Конект 0 к личному микшеру на других ws
	    ConnectAudio_Point (0,Sumator_12[ws_x+40].InNumberFirst+4+a_x)	//Конект 0 к личному микшеру на своем ws
	}
    
	[tp_Audio_All[ws_x],200] = 0		// FB на кнопку добваления ss
	konf[konf_x].Activ--			// Уменьшаем колличество подключенный источников к конференции
	konf[konf_x].Slot_in_WS[Slot_n] = 0	// Записываем панель в слот подключения
	WS[ws_x].WS_SS_In_Konf = 0		// В какой слот подключенна SS
	
	[tp_Audio_All[ws_x],98] = 0			// FB на красный кружек
	send_command tp_Audio_All[ws_x],"'^TXT-98,0,0'" // FB на красный кружек, к какой конференции принадлижит панель
	
	for (a_x=1;a_x<Kol_vo_WS+1;a_x++)
	    SEND_COMMAND tp_Audio_All[a_x],"'^TXT-',itoa(konf_x+100),',0,',itoa(konf[konf_x].Activ)"  // Отправление кол-во активных соединений на кнопки подключения к конференции
    }    
    
    if (konf[konf_x].Rec)	// Если писали на епифан, то перекомутация епифана
    {
	rec_Konf (konf_x,konf[konf_x].Rec)
    }
}
DEFINE_FUNCTION Erese_TP_Konf (Integer tp_n)								// --- Зануление конфиренции на TP
{
    STACK_VAR a_x
    
    For(a_x=1;a_x<9;a_x++)
    {
	send_command tp_Audio_All[tp_n],"'^TXT-',itoa(100+a_x),',0,0'"  	// Зануляем кнопки прямого подключения к конференции
    }
    For (a_x=1;a_x<25;a_x++)
    {
	send_command tp_Audio_All[tp_n],"'^TXT-',itoa(a_x),',0,0'"  	// Зануляем кнопки индикации активности
    }
}

DEFINE_FUNCTION Erese_All_Konf_online ()						// --- Зануление конфиренции по онлайну
{
    STACK_VAR Integer a_x
    STACK_VAR Integer b_x

    SEND_STRING 0,"'Start:Erese_All_Konf_online'"
    For (a_x=1;a_x<25;a_x++)
    {
	For (b_x=1;b_x<9;b_x++)
	{
	    ConnectAudio_Point (0,Sumator_12[a_x].InNumberFirst+4+b_x)		//0 к личному микшеру на своем ws
	    ConnectAudio_Point (0,Sumator_12[a_x+40].InNumberFirst+4+b_x)	//0 к личному микшеру на своем SS
	}
    }
	
    For (a_x=1;a_x<10;a_x++)
    {
	if (a_x<9)			// Зануляем входа епифана
	{
	    ConnectAudio_Point(0,Sumator_12[66].InNumberFirst+4+a_x)
	    ConnectAudio_Point(0,Sumator_12[67].InNumberFirst+4+a_x)
	}
    }
    SEND_STRING 0,"'Stop:Erese_All_Konf_online'"
}
DEFINE_FUNCTION Erese_All_Konf ()								// --- Зануление конфиренции c кнопки
{
    STACK_VAR Integer a_x
    STACK_VAR Integer b_x
    
    SEND_STRING 0,"'Start:Erese_All_Konf'"
    Flag_Progress_2 = 1
    konf[1].Rec = 0
    [Epihfan_tp_Audio[1],10] = 1
    konf[2].Rec = 0
    [Epihfan_tp_Audio[2],10] = 1
    For (a_x=1;a_x<25;a_x++)
    {
	ws[a_x].Slot = 0			// Зануляем слот подключения
	WS[a_x].WS_Konf_Active = 0		// Зануляем пренадлежность к конференции
	
	[tp_Audio_All[a_x],200] = 0			// FB на кнопку добавления ss
	[tp_Audio_All[a_x],98] = 0			// FB на красный кружек
	[tp_Audio_All[a_x],99] = 0			// FB на красный кружек
	send_command tp_Audio_All[a_x],"'^TXT-98,0,0'"  // FB на красный кружек, к какой конференции принадлижит панель
	send_command tp_Audio_All[a_x],"'^TXT-99,0,0'"  // FB на красный кружек, к какой конференции принадлижит панель
	
	For (b_x=1;b_x<9;b_x++)
	{
	    ConnectAudio_Point (0,Sumator_12[a_x].InNumberFirst+4+b_x)		//0 к личному микшеру на своем ws
	    ConnectAudio_Point (0,Sumator_12[a_x+40].InNumberFirst+4+b_x)	//0 к личному микшеру на своем SS
	    
	    [tp_Audio_All[a_x],100+b_x] = 0					// Зануляем кнопки прямого подключения к конференции
	    send_command tp_Audio_All[a_x],"'^TXT-',itoa(100+b_x),',0,0'"  	// Зануляем кнопки прямого подключения к конференции
	}
	
	For (b_x=1;b_x<25;b_x++)
	{
	    [tp_Audio_All[a_x],b_x] = 0					// Зануляем кнопки индикации активности
	    send_command tp_Audio_All[a_x],"'^TXT-',itoa(b_x),',0,0'"  	// Зануляем кнопки индикации активности
	}
    }
	
    For (a_x=1;a_x<10;a_x++)
    {
	konf[a_x].Activ = 0		// Зануляем активные конференциии
	For (b_x=1;b_x<10;b_x++)
	{
	    konf[a_x].Slot_in_WS[b_x] = 0 // Зануляем слоты подключения в конференции
	}
	if (a_x<9)			// Зануляем входа епифана
	{
	    ConnectAudio_Point(0,Sumator_12[66].InNumberFirst+4+a_x)
	    ConnectAudio_Point(0,Sumator_12[67].InNumberFirst+4+a_x)
	}
    }
    Flag_Progress_2 = 0
    SEND_STRING 0,"'Stop:Erese_All_Konf'"
}

DEFINE_FUNCTION Opros_all_Faiders ()						// --- Опрашиваем все фейдеры
{
    stack_var Integer a_x
    
    SEND_STRING 0,"'Start:Opros_all_Faiders'"
    For (a_x=1;a_x<28;a_x++)
    {
	If ((InNum[a_x].Vol=0)&(InNum[a_x].Number>0))	// Если уровень 0, а вход существует
	    Opros_DSP_Param (a_x)
    }
    SEND_STRING 0,"'Stop:Opros_all_Faiders'"
}
DEFINE_FUNCTION rec_Konf (integer konf_n, Integer Epihfan)							// --- Запись конференции на Epihfan
{
    STACK_VAR Integer a_x
    STACK_VAR Integer slot
    
    for (a_x=1;a_x<9;a_x++)
    {
	Slot = konf[konf_n].Slot_in_WS[a_x]
	if (slot)
	{
	    if (Slot<40)	// Если в слоте микрофон
		ConnectAudio_Point(InWS_Mic[slot].InNumber,Sumator_12[65+Epihfan].InNumberFirst+4+a_x)
	    Else 		// Если в слоте SS
		ConnectAudio_Point(InSS_HeadPhones[slot-40].InNumber,Sumator_12[65+Epihfan].InNumberFirst+4+a_x)
	}
	Else
	    ConnectAudio_Point(0,Sumator_12[65+Epihfan].InNumberFirst+4+a_x)
    }	
    ConnectAudio_Point(0,Sumator_12[65+Epihfan].InNumberFirst+1)
    ConnectAudio_Point(0,Sumator_12[65+Epihfan].InNumberFirst+2)
}
DEFINE_FUNCTION tp_DSP_Online ()						// --- Онлайн панелей
{
    STACK_VAR Integer a_x
    STACK_VAR CHAR DSP_For_tp_n[100]
    STACK_VAR Integer DSP_For_tp_int_n
    
    SEND_STRING 0,"'Start:tp_DSP_Online'"
    If ((Marix_tp_online[24]>0)|(Marix_tp_online[25]>0)|(Marix_tp_online[26]>0)|(Marix_tp_online[27]>0)|(Marix_tp_online[28]>0))	// --- Елси была онлай панелька с DSP параметрами
    {
        ssss2++
	for (a_x=1;a_x<28;a_x++)
	{
	    If (InNum[a_x].Vol>0)		// Если громкость не 0
	    {
		DSP_For_tp_n = InNum[a_x].For_TP
		WHILE(LENGTH_STRING(DSP_For_tp_n))
		{
		    DSP_For_tp_int_n = atoi(remove_string(DSP_For_tp_n,"'!'",1))
		    SEND_LEVEL tp_Audio_All[DSP_For_tp_int_n],a_x,InNum[a_x].Vol
		    [tp_Audio_ws_vol[DSP_For_tp_int_n],x_audio] = InNum[a_x].Mute
		    
		    if (InNum[a_x].Vol<192)
		    {
			if (InNum[a_x].Vol<129) 
			{
			    Znak_Value = (160-InNum[a_x].Vol)
			    Float_Value_Volume = Znak_Value/2
			    SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int_n],"'^TXT-',itoa(a_x),',0,-',ftoa(Float_Value_Volume)"
			}
			Else
			{
			    Znak_Value = (192-InNum[a_x].Vol)
			    Float_Value_Volume = Znak_Value/4
			    SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int_n],"'^TXT-',itoa(a_x),',0,-',ftoa(Float_Value_Volume)"
			}
		    }
		    Else
			SEND_COMMAND tp_Audio_ws_vol[DSP_For_tp_int_n],"'^TXT-',itoa(a_x),',0,',ftoa((InNum[a_x].Vol-192)/4)"
		}
	    }	    
	}
    }
    
    For (a_x=1;a_x<29;a_x++)
    {
	if (Marix_tp_online[a_x]>0)
	{	
	    Marix_tp_online[a_x] = 0
	    Erese_TP_Konf (a_x)
	}
    }    
    SEND_STRING 0,"'Stop:tp_DSP_Online'"
}
DEFINE_EVENT
DATA_EVENT[tp_audio_micComToCodec_all]
{
    online:
    {	
	stack_var integer i 
	for(i=1;i<5;i++)
	{
	    [tp_audio_micComToCodec_all,Flag_mic_ComToHDX[i]] = 1
	}
    }
}

BUTTON_EVENT[tp_audio_micComToCodec_all,0]	// --- --- Коммутация микрофона на кодеки и ss ---
{
    push:
    {
	stack_var integer but 
	but = button.input.channel
	if (but<10)		// --- 1 - VIP
	    switch(but)
	    {
		// --- коммутируем на СЦ и ss СЦ
		case 1:	// --- DCN 
		{
		    [tp_audio_micComToCodec_all,1] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- фейдер DCN на Личный сумотор HDX
		    ConnectAudio_Point (Faider[10].InNumber,Sumator_12[31].InNumberFirst+1)	
			// --- фейдер DCN На личный суматор ss
			//ConnectAudio_Point (Faider[10].InNumber,Sumator_12[40].InNumberFirst+1)	
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 0',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		}
		case 2:	// --- Потолочный микрофон
		{
		    [tp_audio_micComToCodec_all,2] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- Потолочный микрофон на Личный сумотор HDX
		    ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[31].InNumberFirst+1)	
			// --- Потолочный микрофон На личный суматор ss
			//ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[40].InNumberFirst+1)
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 1',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 0',$0d,$0a"		    
		}
		case 3:	// --- Микрофон оператора
		{
		    [tp_audio_micComToCodec_all,3] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- Микрофон оператора на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[31].InNumberFirst+1)	
			// --- Микрофон оператора На личный суматор ss
			//ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[40].InNumberFirst+1)	
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 1',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		}
		Case 4:	// --- Радио микрофон
		{
		    [tp_audio_micComToCodec_all,4] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- Радио микрофон на Личный сумотор HDX
		    ConnectAudio_Point (MIC_rezerv_RF,Sumator_12[31].InNumberFirst+1)	
			// --- Микрофон оператора На личный суматор ss
			//ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[40].InNumberFirst+1)	
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 1',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		}
		Case 5:	// --- 5.35
		{
		    [tp_audio_micComToCodec_all,5] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- MIC 5.35 на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[25].InNumber,Sumator_12[31].InNumberFirst+1)	
			// --- Микрофон оператора На личный суматор ss
			//ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[40].InNumberFirst+1)	
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 1',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		}
		Case 6:	// --- 5.37
		{
		    [tp_audio_micComToCodec_all,6] = 1;
		    Flag_mic_ComToHDX[1] = but
		    // --- MIC 5.37 на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[26].InNumber,Sumator_12[31].InNumberFirst+1)	
			// --- Микрофон оператора На личный суматор ss
			//ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[40].InNumberFirst+1)	
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 1',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		}
	    }
	else{
	but = but - 10
	if (but<10)		// --- 2 - ЦУП
	    switch(but)
	    {
		case 1:	// --- DCN 
		{
		    [tp_audio_micComToCodec_all,11] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- фейдер DCN на Личный сумотор HDX
		    ConnectAudio_Point (Faider[10].InNumber,Sumator_12[32].InNumberFirst+1)
		}
		case 2:	// --- Потолочный микрофон
		{
		    [tp_audio_micComToCodec_all,12] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- Потолочный микрофон на Личный сумотор HDX
		    ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[32].InNumberFirst+1)		    
		}
		case 3:	// --- Микрофон оператора
		{
		    [tp_audio_micComToCodec_all,13] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- Микрофон оператора на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[32].InNumberFirst+1)	
		}
		Case 4:	// --- Радио микрофон
		{
		    [tp_audio_micComToCodec_all,14] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- Радио микрофон на Личный сумотор HDX
		    ConnectAudio_Point (MIC_rezerv_RF,Sumator_12[32].InNumberFirst+1)	
		}
		Case 5:	// --- 5.35
		{
		    [tp_audio_micComToCodec_all,15] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- MIC 5.35 на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[25].InNumber,Sumator_12[32].InNumberFirst+1)	
		}
		Case 6:	// --- 5.37
		{
		    [tp_audio_micComToCodec_all,16] = 1;
		    Flag_mic_ComToHDX[2] = but
		    // --- MIC 5.37 на Личный сумотор HDX
		    ConnectAudio_Point (InWS_Mic[26].InNumber,Sumator_12[32].InNumberFirst+1)	
		}
	    }
	    else{
		but = but - 10
		if (but<10)		// --- 3 - 5.35
		    switch(but)
		    {
			case 1:	// --- DCN 
			{
			    [tp_audio_micComToCodec_all,21] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- фейдер DCN на Личный сумотор HDX
			    ConnectAudio_Point (Faider[10].InNumber,Sumator_12[29].InNumberFirst+1)
			}
			case 2:	// --- Потолочный микрофон
			{
			    [tp_audio_micComToCodec_all,22] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- Потолочный микрофон на Личный сумотор HDX
			    ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[29].InNumberFirst+1)		    
			}
			case 3:	// --- Микрофон оператора
			{
			    [tp_audio_micComToCodec_all,23] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- Микрофон оператора на Личный сумотор HDX
			    ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[29].InNumberFirst+1)	
			}
			Case 4:	// --- Радио микрофон
			{
			    [tp_audio_micComToCodec_all,24] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- Радио микрофон на Личный сумотор HDX
			    ConnectAudio_Point (MIC_rezerv_RF,Sumator_12[29].InNumberFirst+1)	
			}
			Case 5:	// --- 5.35
			{
			    [tp_audio_micComToCodec_all,25] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- MIC 5.35 на Личный сумотор HDX
			    ConnectAudio_Point (InWS_Mic[25].InNumber,Sumator_12[29].InNumberFirst+1)	
			}
			Case 6:	// --- 5.37
			{
			    [tp_audio_micComToCodec_all,26] = 1;
			    Flag_mic_ComToHDX[3] = but
			    // --- MIC 5.37 на Личный сумотор HDX
			    ConnectAudio_Point (InWS_Mic[26].InNumber,Sumator_12[29].InNumberFirst+1)	
			}
		    }
		else{
		    but = but - 10
		    if (but<10)		// --- 4 - 5.37
			switch(but)
			{
			    case 1:	// --- DCN 
			    {
				[tp_audio_micComToCodec_all,31] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- фейдер DCN на Личный сумотор HDX
				ConnectAudio_Point (Faider[10].InNumber,Sumator_12[30].InNumberFirst+1)
			    }
			    case 2:	// --- Потолочный микрофон
			    {
				[tp_audio_micComToCodec_all,32] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- Потолочный микрофон на Личный сумотор HDX
				ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[30].InNumberFirst+1)		    
			    }
			    case 3:	// --- Микрофон оператора
			    {
				[tp_audio_micComToCodec_all,33] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- Микрофон оператора на Личный сумотор HDX
				ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[30].InNumberFirst+1)	
			    }
			    Case 4:	// --- Радио микрофон
			    {
				[tp_audio_micComToCodec_all,34] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- Радио микрофон на Личный сумотор HDX
				ConnectAudio_Point (MIC_rezerv_RF,Sumator_12[30].InNumberFirst+1)	
			    }
			    Case 5:	// --- 5.35
			    {
				[tp_audio_micComToCodec_all,35] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- MIC 5.35 на Личный сумотор HDX
				ConnectAudio_Point (InWS_Mic[25].InNumber,Sumator_12[30].InNumberFirst+1)	
			    }
			    Case 6:	// --- 5.37
			    {
				[tp_audio_micComToCodec_all,36] = 1;
				Flag_mic_ComToHDX[4] = but
				// --- MIC 5.37 на Личный сумотор HDX
				ConnectAudio_Point (InWS_Mic[26].InNumber,Sumator_12[30].InNumberFirst+1)	
			    }
			}
		}
	    }
	}
    }
}
DATA_EVENT[dv_AudioMatrix]		// --- Инициализация порта + Отклик на строку из матрици
{
    online:
    {
	SEND_COMMAND dv_AudioMatrix,"'SET BAUD 38400,N,8,1 485 DINABLE'" 
	Wait(100)
	{
	    // --- коммутируем DCN на СЦ и ss СЦ
		[tp_audio_micComToCodec_all,1] = 1;
		[tp_audio_micComToCodec_all,2] = 0;
		[tp_audio_micComToCodec_all,3] = 0;
		[tp_audio_micComToCodec_all,4] = 0;
		
		// --- фейдер DCN на Личный сумотор HDX
		ConnectAudio_Point (Faider[10].InNumber,Sumator_12[31].InNumberFirst+1)	
		    // --- фейдер DCN На личный суматор ss
		    //ConnectAudio_Point (Faider[10].InNumber,Sumator_12[40].InNumberFirst+1)	
		    send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 0',$0d,$0a"
		    send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
	}
    }
    string:{send_string dv_AudioMatrix,"$FE,$FE"}	// Пакет подтверждения о получении пакета информации
}
DATA_EVENT[tp_Audio_ws_vol]		// --- Онлайн панелей по звуку
{  
    online:
    {
	Pan_online_active = get_last(tp_Audio_ws_vol)
	Marix_tp_online[Pan_online_active] = 1
	cancel_wait 'tp_DSP_Online_Wait'
	ssss1++
	Wait (50) 'tp_DSP_Online_Wait'
	{
	    ssss1=0
	    tp_DSP_Online ()
	}
    }
}
DATA_EVENT[vdv_VideoForControl]		// --- Привязка аудио коммутации к видео коммутации
{
    string:
    {
	STACK_VAR Integer In_pup
	STACK_VAR Integer Out_pup
	STACK_VAR Integer y
	STACK_VAR Integer z
	
	In_pup = atoi(remove_string(data.text,'to',1))
	Out_pup = atoi(remove_string(data.text,'!',1))

	SWITCH(Out_pup)
	{
	    Case 131:	// --- Epifan 1
	    {
		if ((In_pup>6)&(In_pup<11))	// Камеры 1,2,3,6 пишем конференцию
		{}
		Else
		{
		    y=1
		    While(y<11)	// Проверка, писалил ли конфу на Epihfan
		    {
			if (konf[y].Rec=1)
			{
			    konf[y].Rec = 0
			   //[Epihfan_tp_Audio[1],10] = 1
			    for (z=1;z<13;z++)
			    {
				ConnectAudio_Point(0,Sumator_12[66].InNumberFirst+4+z)
			    }	
			    y=100
			}
			y++
		    }
		    
		    if (AudioOut_For_VideoCom[In_pup])
			[Epihfan_tp_Audio[1],10] = 1
		    ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[66].InNumberFirst+1)
		    
		    SWITCH(In_pup)
		    {
			Case 151:	// Активная камера VIP (телефонный интерфейс)
			    {ConnectAudio_Point(Faider[10].InNumber,Sumator_12[66].InNumberFirst+2)}
		    }
		}
	    }
	    Case 130:	// --- Epifan 2
	    {
		if ((In_pup>6)&(In_pup<11))	// Камеры 1,2,3,6 пишем конференцию
		{}
		Else
		{
		    y=1
		    While(y<11)	// Проверка, писалил ли конфу на Epihfan
		    {
			if (konf[y].Rec=2)
			{
			    konf[y].Rec = 0
			    //[Epihfan_tp_Audio[],10] = 1
			    for (z=1;z<9;z++)
			    {
				ConnectAudio_Point(0,Sumator_12[67].InNumberFirst+4+z)
			    }	
			    y=100
			}
			y++
		    }
		    
		    if (AudioOut_For_VideoCom[In_pup])
			[Epihfan_tp_Audio[2],10] = 1
		    ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[67].InNumberFirst+1)
		    
		    SWITCH(In_pup)
		    {
			Case 151:	// Активная камера VIP (телефонный интерфейс)
			    {ConnectAudio_Point(Faider[10].InNumber,Sumator_12[67].InNumberFirst+2)}
		    }
		}
	    }
	    Case 103:	// --- VKS 5.35 контент
	    {
		ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[33].InNumberFirst+1)
	    }
	    Case 104:	// --- VKS 5.37 контент
	    {
		ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[34].InNumberFirst+1)
	    }
	    Case 105:	// --- VKS 5.30 контент
	    {
		ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[35].InNumberFirst+1)
	    }
	    Case 106:	// --- VKS 5.45 контент
	    {
		ConnectAudio_Point(AudioOut_For_VideoCom[In_pup],Sumator_12[36].InNumberFirst+1)
	    }
	}
    }
}

BUTTON_EVENT[tp_Debug_audio_17,0]	// --- Комутация по умолчинию + Сброс микшеров ----------------------------------------------------------------
{
    PUSH:
    {
	STACK_VAR Integer Ai
	STACK_VAR Integer Ao
	STACK_VAR Integer bi
	
	
	switch(BUTTON.INPUT.CHANNEL)
	{
	    case 1000:
	    {
		SEND_STRING dv_AudioMatrix,"to_audio_dv(AudioCommand)"
	    }
	    case 1001:
	    {
		AudioCommand = "$00,$28,$37,$00,right_string("$00,AIn>>8,AIn",2),right_string("$00,AOut>>8,AOut",2)"
		AudioCommand = to_audio_dv(AudioCommand)
		SEND_STRING dv_AudioMatrix,"AudioCommand"
	    }
	    Case 1010:		// --- Коммутация по умолчанию (новая версия)
	    {
		For (ai=1;ai<24;ai++)	// Рабочие места + SS
		{   	// Рабочие места 
			ConnectAudio_Point (Sumator_12[ai].OutNumber,OutWS_HeadPhones[ai].OutNumber)		// --- Личный суматор 12-1 на гарнитуру
			ConnectAudio_Point (InSS_HeadPhones[ai].InNumber,Sumator_12[ai].InNumberFirst+1)	// --- SS На личный суматор
			ConnectAudio_Point (PC[ai*2-1].InNumber,Sumator_12[ai].InNumberFirst+2)			// --- PC1 на личный суматор
			// ss
			ConnectAudio_Point (Sumator_12[ai+40].OutNumber,OutSS_Mic[ai].OutNumber)		// --- Личный суматор 12-1 ss на ss
			ConnectAudio_Point (InWS_Mic[ai].InNumber,Sumator_12[ai+40].InNumberFirst+1)		// --- Микрофон на SS
			// pc
			ConnectAudio_Point (Sumator_4[ai].OutNumber,PC[ai*2-1].OutNumber)			// --- Личный суматор 4-1 PC 1 на PC 1
			ConnectAudio_Point (InWS_Mic[ai].InNumber,Sumator_4[ai].InNumberFirst+1)		// --- Микрофон на pc 1
		}
		    //Оператор
		    ai = 24
			ConnectAudio_Point (Sumator_12[ai].OutNumber,EQ[1].OutNumber)				// --- Личный суматор 12-1 на аквалайзер
			ConnectAudio_Point (EQ[1].InNumber,OutWS_HeadPhones[ai].OutNumber)			// --- аквалайзер на Усилитель
			ConnectAudio_Point (InSS_HeadPhones[ai].InNumber,Sumator_12[ai].InNumberFirst+1)	// --- SS На личный суматор
			ConnectAudio_Point (Sumator_12[ai+40].OutNumber,OutSS_Mic[ai].OutNumber)		// --- Личный суматор 12-1 ss на ss
			ConnectAudio_Point (InWS_Mic[ai].InNumber,Sumator_12[ai+40].InNumberFirst+1)		// --- Микрофон на SS
		    
		    
		    //Ражнов + HDX 5.35
		    ai = 25
			ConnectAudio_Point (Sumator_12[ai].OutNumber,EQ[2].OutNumber)				// --- Личный суматор 12-1 на аквалайзер
			ConnectAudio_Point (EQ[2].InNumber,OutWS_HeadPhones[ai].OutNumber)			// --- аквалайзер на Усилитель 1
			ConnectAudio_Point (EQ[2].InNumber,OutWS_HeadPhones[ai].OutNumber+1)			// --- аквалайзер на Усилитель 2
			// HDX 5.35
			ConnectAudio_Point (InWS_Mic[29].InNumber,Faider[6].OutNumber)				// --- HDX (5.35) на Фейдер HDX
			ConnectAudio_Point (Sumator_12[29].OutNumber,OutWS_HeadPhones[29].OutNumber)		// --- Личный суматор 12-1 HDX на HDX
			ConnectAudio_Point (Sumator_12[33].OutNumber,Out_VKS[2])				// --- Личный суматор контент 12-1 HDX на второй вход HDX
			ConnectAudio_Point (InWS_Mic[25].InNumber,Sumator_12[29].InNumberFirst+1)		// --- MIC 5.35 на Личный сумотор HDX
			[tp_audio_micComToCodec_all,25] = 1
			Flag_mic_ComToHDX[3] = 5
			// SS
			ConnectAudio_Point (Sumator_12[65].OutNumber,OutSS_Mic[ai].OutNumber)			// --- Личный суматор 12-1 ss на ss
			ConnectAudio_Point (InSS_HeadPhones[ai].InNumber,Sumator_12[ai].InNumberFirst+1)	// --- ss на ss на личный суматор VIP
			

		    
		    //Греф
		    ai = 26
			ConnectAudio_Point (Sumator_12[ai].OutNumber,EQ[3].OutNumber)				// --- Личный суматор 12-1 на аквалайзер
			ConnectAudio_Point (EQ[3].InNumber,OutWS_HeadPhones[ai].OutNumber)			// --- аквалайзер на Усилитель 1
			ConnectAudio_Point (EQ[3].InNumber,OutWS_HeadPhones[ai].OutNumber+1)			// --- аквалайзер на Усилитель 2
			// HDX 5.35
			ConnectAudio_Point (InWS_Mic[30].InNumber,Faider[7].OutNumber)				// --- HDX (5.35) на Фейдер HDX
			ConnectAudio_Point (Sumator_12[30].OutNumber,OutWS_HeadPhones[30].OutNumber)		// --- Личный суматор 12-1 HDX на HDX
			ConnectAudio_Point (Sumator_12[34].OutNumber,Out_VKS[4])				// --- Личный суматор контент 12-1 HDX на второй вход HDX
			ConnectAudio_Point (InWS_Mic[26].InNumber,Sumator_12[30].InNumberFirst+1)		// --- MIC 5.37 на Личный сумотор HDX
			[tp_audio_micComToCodec_all,36] = 1;
			Flag_mic_ComToHDX[4] = 6
			
		    //Vip
			[tp_audio_micComToCodec_all,1] = 1;
			[tp_audio_micComToCodec_all,2] = 0;
			[tp_audio_micComToCodec_all,3] = 0;
			[tp_audio_micComToCodec_all,4] = 0;
			send_string dv_SS_13, "'set matrix_mute "DCN Mic" "Phone 1 Out" 0',$0d,$0a"
			send_string dv_SS_13, "'set matrix_mute "Mic2" "Phone 1 Out" 1',$0d,$0a"
		    ai = 27
			ConnectAudio_Point (Sumator_12[ai].OutNumber,EQ[8].OutNumber)				// --- Личный суматор 12-1 на аквалайзер
			ConnectAudio_Point (EQ[8].InNumber,OutWS_HeadPhones[ai].OutNumber)			// --- аквалайзер на Усилитель 1
			ConnectAudio_Point (EQ[8].InNumber,OutWS_HeadPhones[ai].OutNumber+1)			// --- аквалайзер на Усилитель 2
			// DCN 
			ConnectAudio_Point (InWS_Mic[ai].InNumber,Faider[10].OutNumber)				// --- DCN на фейдер DCN
			ConnectAudio_Point (Faider[10].InNumber,Sumator_12[ai].InNumberFirst+1)			// --- фейдер DCN на Личный сумотор VIP
			// HDX 5.35
			ConnectAudio_Point (InWS_Mic[31].InNumber,Faider[8].OutNumber)				// --- HDX (5.35) на Фейдер HDX
			ConnectAudio_Point (Sumator_12[31].OutNumber,OutWS_HeadPhones[31].OutNumber)		// --- Личный суматор 12-1 HDX на HDX
			ConnectAudio_Point (Sumator_12[35].OutNumber,Out_VKS[6])				// --- Личный суматор контент 12-1 HDX на второй вход HDX
			[tp_audio_micComToCodec_all,1] = 1;
			Flag_mic_ComToHDX[1] = 1
		    
			// SS
			ConnectAudio_Point (Faider[10].InNumber,Sumator_12[40].InNumberFirst+1)			// --- фейдер DCN На личный суматор ss
			ConnectAudio_Point (Sumator_12[40].OutNumber,OutSS_Mic[26].OutNumber)			// --- Личный суматор 12-1 ss на ss
			ConnectAudio_Point (InSS_HeadPhones[26].InNumber,Sumator_12[ai].InNumberFirst+4)	// --- ss на ss на личный суматор VIP
			
		    
		    //ЦУП
		    ai = 28
			ConnectAudio_Point (Sumator_12[ai].OutNumber,EQ[4].OutNumber)				// --- Личный суматор 12-1 на аквалайзер
			ConnectAudio_Point (EQ[4].InNumber,OutWS_HeadPhones[ai].OutNumber)			// --- аквалайзер на Усилитель 1
			ConnectAudio_Point (EQ[4].InNumber,OutWS_HeadPhones[ai].OutNumber+1)			// --- аквалайзер на Усилитель 2
			// HDX 5.35
			ConnectAudio_Point (InWS_Mic[32].InNumber,Faider[9].OutNumber)				// --- HDX (5.35) на Фейдер HDX
			ConnectAudio_Point (Sumator_12[32].OutNumber,OutWS_HeadPhones[32].OutNumber)		// --- Личный суматор 12-1 HDX на HDX
			ConnectAudio_Point (Sumator_12[36].OutNumber,Out_VKS[8])				// --- Личный суматор контент 12-1 HDX на второй вход HDX
			ConnectAudio_Point (0,Sumator_12[32].InNumberFirst+1)
			[tp_audio_micComToCodec_all,2] = 9;
			Flag_mic_ComToHDX[2] = 0
		    //Epihans
			ConnectAudio_Point (Sumator_12[66].OutNumber,Out_Epifan[1])				// --- Суматор 4х1 в Епифан 1
			ConnectAudio_Point (Sumator_12[67].OutNumber,Out_Epifan[2])				// --- Суматор 4х1 в Епифан 2
			
		    //Dune
			ConnectAudio_Point (In_Duna[1],Sumator_4[31].InNumberFirst+1)				// --- Duna 1.1 на суматор 1
			ConnectAudio_Point (In_Duna[1]+1,Sumator_4[31].InNumberFirst+2)				// --- Duna 1.2 на суматор 1
			ConnectAudio_Point (In_Duna[2],Sumator_4[32].InNumberFirst+1)				// --- Duna 1.1 на суматор 1
			ConnectAudio_Point (In_Duna[2]+1,Sumator_4[32].InNumberFirst+2)				// --- Duna 1.2 на суматор 1
		    //ТВ 
			ConnectAudio_Point (In_TV[1],Faider[1].OutNumber)				// --- тв 1
			ConnectAudio_Point (In_TV[2],Faider[2].OutNumber)				// --- тв 2
			ConnectAudio_Point (In_TV[3],Faider[3].OutNumber)				// --- тв 3
			ConnectAudio_Point (In_TV[4],Faider[4].OutNumber)				// --- тв 4
			ConnectAudio_Point (In_TV[5],Faider[5].OutNumber)				// --- тв 5
	    }
	}
    }
}

BUTTON_EVENT[tp_Audio_All,0]			// --- Управление аудио Коференцией
{
    Push:
    {
	STACK_VAR Integer pan
	STACK_VAR Integer but
	STACK_VAR Integer N_Konf
	STACK_VAR Integer y
	pan = GET_LAST(tp_Audio_All)
	but = BUTTON.INPUT.CHANNEL
	
	
	If (but<26)					// --- Запрос на присоединение к конфиренции. От создателя
	{
	    if (pan<>but)	// Защита от выбора себя
		if ((pan=7)|(pan=8)|(pan=9)|(pan=18)|(pan=24)|(pan=25))	// Если присоединение происходит с мест начальников операторов
		{
		    if (WS[pan].WS_Konf_Active)	// Если главная панель в конференции
		    {
			if (WS[pan].WS_Konf_Active<8)	//Если конференция не переполнена
			{
			    if (WS[but].WS_Konf_Active)	// Если ведомая панель в конференции
			    {
				if (WS[but].WS_Konf_Active=WS[pan].WS_Konf_Active)
				{
				    Disconect_to_Konf (but,WS[but].WS_Konf_Active)
				    SEND_COMMAND tp_Audio_All[but],"'WAKE'"
				    SEND_COMMAND tp_Audio_All[but],"'@PPN-Alert_All_audio;Main'"
				    SEND_COMMAND tp_Audio_All[but],"'^UNI-4000,0,0412043004410020043E0442043A043B044E04470438043B04380020043E04420020043A043E043D0444043504400435043D044604380438002E'"
				    SEND_COMMAND tp_Audio_All[but],"'ADBEEP'"
				}
				Else
				{
				    Disconect_to_Konf (but,WS[but].WS_Konf_Active)
				    Conect_to_Konf (but,WS[pan].WS_Konf_Active)
				    
				    SEND_COMMAND tp_Audio_All[but],"'WAKE'"
				    SEND_COMMAND tp_Audio_All[but],"'@PPN-Alert_All_audio;Main'"
				    SEND_COMMAND tp_Audio_All[but],"'^UNI-4000,0,04120430044100200434043E0431043004320438043B0438002004320020043A043E043D0444043804400435043D04460438044E'"
				    SEND_COMMAND tp_Audio_All[but],"'ADBEEP'"
				}
			    }
			    Else
			    {
				Conect_to_Konf (but,WS[pan].WS_Konf_Active)
				
				SEND_COMMAND tp_Audio_All[but],"'WAKE'"
				SEND_COMMAND tp_Audio_All[but],"'@PPN-Alert_All_audio;Main'"
				SEND_COMMAND tp_Audio_All[but],"'^UNI-4000,0,04120430044100200434043E0431043004320438043B0438002004320020043A043E043D0444043804400435043D04460438044E'"
				SEND_COMMAND tp_Audio_All[but],"'ADBEEP'"
			    }
			}
			Else
			{
			    SEND_COMMAND tp_Audio_All[pan],"'@PPN-Alert_All_audio;Main'"
			    SEND_COMMAND tp_Audio_All[pan],"'^UNI-4000,0,041A043E043D0444043504400435043D04460438044F0020043F043504400435043F043E043B043D0435043D0430002E'"
			}
			
		    }
		}
		Else					// Если присоединение происходит с обычных мест (Отправляем запрос)
		{
		    if (WS[pan].WS_Konf_Active)	// Если главная панель в конференции
		    {
			ws[but].Zapros_For_Konf = WS[pan].WS_Konf_Active	// Запоминаем с какой конференции пришел запрос на добавление
			//Alert_Conferens
			SEND_COMMAND tp_Audio_All[but],"'@PPN-Alert_Conferens;Main'"
			SEND_COMMAND tp_Audio_All[but],"'^TXT-30,0,',itoa(WS[pan].WS_Konf_Active)"
			
			SEND_COMMAND tp_Audio_All[but],"'WAKE'"
			SEND_COMMAND tp_Audio_All[but],"'ADBEEP'"
		    }
		}
	}
	ELSE
	
	
	If (((149<but)&(but<190))|((200<but)&(but<255)))	// --- Подключение к рабочему метсту дополнительных источников звука
	{	// 150 = Выкл, 201-254 - pc, 151-155 - ТВ, 161-168 - ВКС, 171 - 172 - Duna, 181 - 186
	
	    WS[pan].Else_Audio_In_to_WS = but		// Запоминаем какой альтернативный ист. вкл.
		    for (y=201;y<255;y++)
			[tp_Audio_All[pan],y]=0			//  Выкл. весь FB на кнопки альт. источников
		    for (y=150;y<156;y++)
			[tp_Audio_All[pan],y]=0			//  Выкл. весь FB на кнопки альт. источников
		    for (y=161;y<165;y++)
			[tp_Audio_All[pan],y]=0			//  Выкл. весь FB на кнопки альт. источников
		    for (y=171;y<173;y++)
			[tp_Audio_All[pan],y]=0			//  Выкл. весь FB на кнопки альт. источников
		    for (y=181;y<188;y++)
			[tp_Audio_All[pan],y]=0			//  Выкл. весь FB на кнопки альт. источников

	    [tp_Audio_All[pan],but]=1		// FB на кнопки альт. ист.
	    but = but - 150
		if (But = 0)	// Выкл. альтернативный источник
		{	
		    ConnectAudio_Point (0,Sumator_12[pan].InNumberFirst+3)	// Выкл. альтернативного источника звука
		}
		Else
		if (but < 10)	// тв
		    ConnectAudio_Point (Faider[but].OutNumber,Sumator_12[pan].InNumberFirst+3)
		
		Else
		{
		    but = but - 10
		    if (but < 10)	// VKS
			ConnectAudio_Point (In_VKS[but*2-1],Sumator_12[pan].InNumberFirst+3)
		Else
		{
		    but = but - 10
		    if (but < 10)	// Duna
			ConnectAudio_Point (Sumator_4[30+but].OutNumber,Sumator_12[pan].InNumberFirst+3)
			
		Else
		{
		    but = but - 10
		    if (but < 10)	// Лючки
			ConnectAudio_Point (In_Luchki[but],Sumator_12[pan].InNumberFirst+3)
		Else
		{
		    but = but - 20
		    If (but < 55)	// PC
			ConnectAudio_Point (PC[but].InNumber,Sumator_12[pan].InNumberFirst+3)
		}}}
	    }
	}
	Else
	
	If ((100<but)&(but<128))			// --- Подключение к активной конференции без приглашения
	{
	    If (WS[pan].WS_Konf_Active=but-100){} // Если панль уже подлючена к выбранной конференции
	    Else
	    {
		If (WS[pan].WS_SS_In_Konf)		// Если SS панели подключена к конфиренции
		    Disconect_to_Konf_SS_And_PS (pan,WS[pan].WS_Konf_Active)
		If (WS[pan].WS_Konf_Active)		// Если в конференции то ...
		    Disconect_to_Konf (pan,WS[pan].WS_Konf_Active)
		Conect_to_Konf (pan,but-100)
	    }
	}
	Else
	SWITCH(but)
	{
	    Case 30:					// --- Подтверждение подключение к конференции
	    {
		If (ws[pan].Zapros_For_Konf)
		{
		    If (WS[pan].WS_Konf_Active)		// Если в конференции то ...
			Disconect_to_Konf (pan,WS[pan].WS_Konf_Active)
		    Conect_to_Konf (pan,ws[pan].Zapros_For_Konf)
		    ws[pan].Zapros_For_Konf = 0
		}
	    }
	    Case 29:					// --- Отклонение подтверждения подключения к конференции
	    {
		WS[pan].Zapros_For_Konf = 0
	    }
	    
	    Case 98:{Erese_All_Konf ()}			// --- Очистка конференции
	    
	    Case 99:					// --- Выход из Конференции (SS,PC и панель-одновременно)
	    {
		If (WS[pan].WS_SS_In_Konf)		// Если SS панели подключена к конфиренции
		    Disconect_to_Konf_SS_And_PS (pan,WS[pan].WS_Konf_Active)
		If (WS[pan].WS_Konf_Active)	// Если в конференции то ...
		    Disconect_to_Konf (pan,WS[pan].WS_Konf_Active)
	    }
	    
	    Case 200:					// --- Подключение Телефона SS к конференции
	    {
		If (WS[pan].WS_Konf_Active)	// Проверка, подключен ли панель к конфиренции
		{
		    If (WS[pan].WS_SS_In_Konf=0)	// Если SS панели не подключена к конфиренции
			Conect_to_Konf_SS_And_PC(pan,WS[pan].WS_Konf_Active)
		    Else				// Если SS панели подключена к конфиренции
			Disconect_to_Konf_SS_And_PS (pan,WS[pan].WS_Konf_Active)
		}
		Else				// Нет не подлючена, выводим предупреждение
		{
		    SEND_COMMAND tp_Audio_All[pan],"'@PPN-Alert_All_audio;Main'"
		    SEND_COMMAND tp_Audio_All[pan],"'^UNI-4000,0,0412044B0020043D043500200443044704300441044204320443043504420435002004320020043A043E043D0444043504400435043D0446043804380021'"
		}
	    }
	    
	    Case 1000:					// --- Кнопки прямого вызова Оператора
	    {
		//ConnectAudio_Point (InWS_Mic[ai].InNumber,Sumator_12[ai].InNumberFirst+1)		// --- Микрофон на личный микшер
		SWITCH(pan)
		{
		    Case 26:	// --- Vip on ipad
		    {
			ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[24].InNumberFirst+2)		// --- DCN на микшер оператора
		    }
		    Case 27:	// --- Vip on wallPanwl
		    {
			ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[24].InNumberFirst+2)		// --- DCN на микшер оператора
		    }
		    Case 24:	// --- Vip on Main
		    {
			If (Flag_SC_Connect_to_Operator)
			{
			    Flag_SC_Connect_to_Operator = 0
			    [tp_Audio_All[pan],1000] = 0
			    ConnectAudio_Point (0,Sumator_12[24].InNumberFirst+2)		// --- DCN на микшер оператора
			}
			else
			{
			    Flag_SC_Connect_to_Operator = 1
			    [tp_Audio_All[pan],1000] = 1
			    ConnectAudio_Point (MIC_Potolochka_VIP,Sumator_12[24].InNumberFirst+2)		// --- DCN на микшер оператора
			}
		    }
		}
	    }
	    
	    // --- Кнопки прямого вызова кабинетов		Sumator_12[30].InNumberFirst
	    Case 1001:			// --- 5.35 			
	    {
		ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[25].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1002:			// --- 5.37			
	    {
		ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[26].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1003:			// --- Vip 			
	    {
		ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[27].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1004:			// --- ЦУП 			
	    {
		ConnectAudio_Point (InWS_Mic[24].InNumber,Sumator_12[28].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
Case 1005:{tp_DSP_Online()}	// --- Отработка обратки в ручную
	}	
    }
    release:
    {
	STACK_VAR Integer pan
	STACK_VAR Integer but
	pan = GET_LAST(tp_Audio_All)
	but = BUTTON.INPUT.CHANNEL
	
	SWITCH(but)
	{
	    Case 1000:					// --- Кнопки прямого вызова Оператора 
	    {
		SWITCH(pan)
		{
		    Case 26:	// --- Vip off
		    {
			ConnectAudio_Point (0,Sumator_12[24].InNumberFirst+2)		// --- 0 на микшер оператора
		    }
		    Case 27:	// --- Vip off
		    {
			ConnectAudio_Point (0,Sumator_12[24].InNumberFirst+2)		// --- 0 на микшер оператора
		    }
		}
	    }
	    
	    // --- Кнопки прямого вызова кабинетов
	    Case 1001:			// --- 5.35 			
	    {
		ConnectAudio_Point (0,Sumator_12[25].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1002:			// --- 5.37			
	    {
		ConnectAudio_Point (0,Sumator_12[26].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1003:			// --- Vip 			
	    {
		ConnectAudio_Point (0,Sumator_12[27].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	    Case 1004:			// --- ЦУП 			
	    {
		ConnectAudio_Point (0,Sumator_12[28].InNumberFirst+5)		// --- Микрофон оператора на микшер
	    }
	}
    }
}

LEVEL_EVENT[tp_Audio_ws_vol,0]		// --- Приямое управление фейдорами
{
    if (Level.VALUE>0)
    {
	AudioCommand = "$00,$74,$37,$00,$19,$01,$00,level.value,$00,$00,$00,$00,$00,$00,InNum[LEVEL.INPUT.LEVEL].Number>>8,InNum[LEVEL.INPUT.LEVEL].Number"
	SEND_STRING dv_AudioMatrix,"to_audio_dv(AudioCommand)"
    }
}
BUTTON_EVENT[tp_Audio_ws_vol,0]		// --- Управлениея параметрами платы DSP
{
    PUSH:
    {	
	// 1   - 100   mute
	// 101 - 200   vol+
	// 201 - 300   vol-
	//STACK_VAR Integer pan
	STACK_VAR Integer but
	STACK_VAR Integer but1
	stack_var integer pan
	But = button.input.channel
	pan = get_last(tp_Audio_ws_vol)
	Flag_Progress = 2
	
	select
	{	
	    active(but < 100):		//Mute
	    {
		if (pan>23)
		{
		    if (InNum[but].Vol=0)		// Если у нас нет пармаетров DSP, то опрашиваем
			Opros_DSP_Param (but)	
		    Else
		    {
			If (InNum[but].Mute)	// Если Mute 1
			    InNum[but].Mute = 0
			Else			// Если Mute 0
			    InNum[but].Mute = 1
			Set_DSP_Param (but)
		    }
		}
		else
		{
		    if (InNum[pan+30].Vol=0)		// Если у нас нет пармаетров DSP, то опрашиваем
			Opros_DSP_Param (pan+30)	
		    Else
		    {
			If (InNum[pan+30].Mute)	// Если Mute 1
			    InNum[pan+30].Mute = 0
			Else			// Если Mute 0
			    InNum[pan+30].Mute = 1
			Set_DSP_Param (pan+30)
		    }
		}
	    }
	    ACTIVE((100<but)&(but<200)):// Vol+
	    {
		but1 = but-100
		if (InNum[but1].Vol=0)		// Если у нас нет пармаетров DSP, то опрашиваем
		    Opros_DSP_Param (but1)	
		Else
		{
		    If (InNum[but1].vol<249)	//
		    {
			InNum[but1].vol = InNum[but1].vol + 4
			Set_DSP_Param (but1)
		    }
		}
	    }
	    ACTIVE((200<but)&(but<300)):// Vol-
	    {
		but1 = but-200
		if (InNum[but1].Vol=0)		// Если у нас нет пармаетров DSP, то опрашиваем
		    Opros_DSP_Param (but1)	
		Else
		{
		    If (InNum[but1].vol>6)	//
		    {
			InNum[but1].vol = InNum[but1].vol - 4
			Set_DSP_Param (but1)
		    }
		}
	    }
	}
	Flag_Progress = 0
    }
}
BUTTON_EVENT[Epihfan_tp_Audio,0]	// --- Управление записью конференции на Epihfan
{
    PUSH:
    {
	STACK_VAR Integer Pan
	STACK_VAR Integer But
	STACK_VAR Integer a_x
	
	But = BUTTON.INPUT.CHANNEL
	Pan = get_last(Epihfan_tp_Audio)
	If (but>10)	// если не включаем по дефолту
	{
	    but = but - 10
	    for (a_x=1;a_x<9;a_x++)
	    {
		If (konf[a_x].Rec=pan) konf[a_x].Rec = 0
	    }
	    [Epihfan_tp_Audio[pan],but+10] = 1
	    if ((OUT_FB[38+pan]>6)&(OUT_FB[38+pan]<11)) // Если включены камеры 1,2,3,6 то
	    {}
	    Else
		send_string vdv_DGX, "'10IN',itoa(38+pan),'OUT'"	// Влкючаем камеру 6
	    konf[but].Rec = pan						// запоминаем какую конфу пишим
	    rec_Konf(but,pan)
	}
    }
}
DEFINE_PROGRAM
CALL 'Audio_FB'
Wait(1)
    call 'FB_ss_13'