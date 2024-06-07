PROGRAM_NAME='2_3_Audio_Data'

DEFINE_CONSTANT
Integer Kol_vo_M2 = 50

DEFINE_TYPE
STRUCTURE Sum_Struct_12
{
    Integer InNumberFirst
    Integer OutNumber
    Integer InConnectFB[12]
}
STRUCTURE Sum_Struct_4
{
    Integer InNumberFirst
    Integer OutNumber
    
    Integer Konf_Used 
    Integer InConnectFB[4]		// FB 1..24 - Мик.WS; 101..151 - Микшеры конф
}
STRUCTURE Out_Struct
{
    Integer OutNumber
    Integer InConnectFB
}
STRUCTURE In_Struct
{
    Integer InNumber
}
STRUCTURE In_Struct_PC
{
    Integer InNumber
    Integer OutNumber
    Integer InConnectFB
}
STRUCTURE Level_DSP
{
    Integer Number
    Integer Mute
    Integer Vol
    char For_TP[100]	// Для какой панели предназначенны данные
}

DEFINE_VARIABLE
// --- переменные матрици ---
VOLATILE Sum_Struct_12 Sumator_12[67]
VOLATILE Sum_Struct_4 Sumator_4[34]
VOLATILE Integer Sum_2_Used		// --- колличество использованных суматоров


VOLATILE In_Struct  InWS_Mic[32]
VOLATILE Out_Struct OutWS_HeadPhones[32]

VOLATILE In_Struct  InSS_HeadPhones[28]
VOLATILE Out_Struct OutSS_Mic[28]
For_TP
VOLATILE In_Struct_PC PC[54]

VOLATILE Integer In_TV[5]

VOLATILE Integer In_VKS[8]
VOLATILE Integer Out_VKS[8]

VOLATILE Integer In_Duna[2]

VOLATILE Integer In_Epifan[2]
VOLATILE Integer Out_Epifan[2]

VOLATILE Integer In_Luchki[7]

VOLATILE In_Struct_PC EQ[8]

VOLATILE In_Struct_PC Faider[10]

VOLATILE Level_DSP InNum[53]

VOLATILE Integer MIC_Potolochka_VIP
VOLATILE integer MIC_rezerv_RF

// --- Для инициализации переменных
VOLATILE Integer AStart, Delta_Sum

// --- Чексумма и аудио переменные
VOLATILE AudioBuff[3000]
VOLATILE AudioMiniBuff[100]
VOLATILE AudioCommand[100]
VOLATILE Audio_X[100]
VOLATILE Integer Audio_CRC
VOLATILE Integer Audio_Length
VOLATILE Integer Audio_I,AIn,AOut,		Audio_Pusc_CRC
VOLATILE Integer Flag_Raboti


VOLATILE puchMsg[100]

VOLATILE Integer  crctable[256] = {
$0000, $1021, $2042, $3063, $4084, $50A5, $60C6, $70E7,
$8108, $9129, $A14A, $B16B, $C18C, $D1AD, $E1CE, $F1EF,
$1231, $0210, $3273, $2252, $52B5, $4294, $72F7, $62D6,
$9339, $8318, $B37B, $A35A, $D3BD, $C39C, $F3FF, $E3DE,
$2462, $3443, $0420, $1401, $64E6, $74C7, $44A4, $5485,
$A56A, $B54B, $8528, $9509, $E5EE, $F5CF, $C5AC, $D58D,
$3653, $2672, $1611, $0630, $76D7, $66F6, $5695, $46B4,
$B75B, $A77A, $9719, $8738, $F7DF, $E7FE, $D79D, $C7BC,
$48C4, $58E5, $6886, $78A7, $0840, $1861, $2802, $3823,
$C9CC, $D9ED, $E98E, $F9AF, $8948, $9969, $A90A, $B92B,
$5AF5, $4AD4, $7AB7, $6A96, $1A71, $0A50, $3A33, $2A12,
$DBFD, $CBDC, $FBBF, $EB9E, $9B79, $8B58, $BB3B, $AB1A,
$6CA6, $7C87, $4CE4, $5CC5, $2C22, $3C03, $0C60, $1C41,
$EDAE, $FD8F, $CDEC, $DDCD, $AD2A, $BD0B, $8D68, $9D49,
$7E97, $6EB6, $5ED5, $4EF4, $3E13, $2E32, $1E51, $0E70,
$FF9F, $EFBE, $DFDD, $CFFC, $BF1B, $AF3A, $9F59, $8F78,
$9188, $81A9, $B1CA, $A1EB, $D10C, $C12D, $F14E, $E16F,
$1080, $00A1, $30C2, $20E3, $5004, $4025, $7046, $6067,
$83B9, $9398, $A3FB, $B3DA, $C33D, $D31C, $E37F, $F35E,
$02B1, $1290, $22F3, $32D2, $4235, $5214, $6277, $7256,
$B5EA, $A5CB, $95A8, $8589, $F56E, $E54F, $D52C, $C50D,
$34E2, $24C3, $14A0, $0481, $7466, $6447, $5424, $4405,
$A7DB, $B7FA, $8799, $97B8, $E75F, $F77E, $C71D, $D73C,
$26D3, $36F2, $0691, $16B0, $6657, $7676, $4615, $5634,
$D94C, $C96D, $F90E, $E92F, $99C8, $89E9, $B98A, $A9AB,
$5844, $4865, $7806, $6827, $18C0, $08E1, $3882, $28A3,
$CB7D, $DB5C, $EB3F, $FB1E, $8BF9, $9BD8, $ABBB, $BB9A,
$4A75, $5A54, $6A37, $7A16, $0AF1, $1AD0, $2AB3, $3A92,
$FD2E, $ED0F, $DD6C, $CD4D, $BDAA, $AD8B, $9DE8, $8DC9,
$7C26, $6C07, $5C64, $4C45, $3CA2, $2C83, $1CE0, $0CC1,
$EF1F, $FF3E, $CF5D, $DF7C, $AF9B, $BFBA, $8FD9, $9FF8,
$6E17, $7E36, $4E55, $5E74, $2E93, $3EB2, $0ED1, $1EF0
}

DEFINE_START// ------------- Sumators 12-1 OUT ---------------
// ------------- Sumators ---------------
// --- Выходные суматоры --- Первый воход = InNumberFirst + 1
Sumator_12[	1	].OutNumber =	1706	// 1 - го рабочего места
Sumator_12[	2	].OutNumber =	1707	// ...
Sumator_12[	3	].OutNumber =	1708	// ...
Sumator_12[	4	].OutNumber =	1709	// ...
Sumator_12[	5	].OutNumber =	1710	// ...
Sumator_12[	6	].OutNumber =	1711	// ...
Sumator_12[	7	].OutNumber =	1712	// ...
Sumator_12[	8	].OutNumber =	1713	// ...
Sumator_12[	9	].OutNumber =	1714	// ...
Sumator_12[	10	].OutNumber =	1715	// ...
Sumator_12[	11	].OutNumber =	1906	// ...
Sumator_12[	12	].OutNumber =	1907	// ...
Sumator_12[	13	].OutNumber =	1908	// ...
Sumator_12[	14	].OutNumber =	1909	// ...
Sumator_12[	15	].OutNumber =	1910	// ...
Sumator_12[	16	].OutNumber =	1911	// ...
Sumator_12[	17	].OutNumber =	1912	// ...
Sumator_12[	18	].OutNumber =	1913	// ...
Sumator_12[	19	].OutNumber =	1914	// ...
Sumator_12[	20	].OutNumber =	1915	// ...
Sumator_12[	21	].OutNumber =	2123	// ...
Sumator_12[	22	].OutNumber =	2124	// ...
Sumator_12[	23	].OutNumber =	2125	// 23 - го рабочего места
Sumator_12[	24	].OutNumber =	2126	// Оператор
Sumator_12[	25	].OutNumber =	2127	// Ражнов 	5.35
Sumator_12[	26	].OutNumber =	2128	// Греф 	5.37
Sumator_12[	27	].OutNumber =	2129	// VIP		5.30
Sumator_12[	28	].OutNumber =	2306	// ЦУП		5.45
Sumator_12[	29	].OutNumber =	2307	// VKS 	    5.35
Sumator_12[	30	].OutNumber =	2308	// VKS 	    5.37
Sumator_12[	31	].OutNumber =	2309	// VKS	VIP 5.30
Sumator_12[	32	].OutNumber =	2310	// VKS	CUP 5.45
Sumator_12[	33	].OutNumber =	2311	// Контент VKS	5.35
Sumator_12[	34	].OutNumber =	2312	// Контент VKS	5.37
Sumator_12[	35	].OutNumber =	2313	// Контент VKS	5.30 VIP
Sumator_12[	36	].OutNumber =	2314	// Контент VKS	5.45 CUP
Sumator_12[	37	].OutNumber =	2315
Sumator_12[	38	].OutNumber =	2506
Sumator_12[	39	].OutNumber =	2507
Sumator_12[	40	].OutNumber =	2508	// SS СЦ 5.30 (VIP)// SS Raznov
Sumator_12[	41	].OutNumber =	2509	// SS 1
Sumator_12[	42	].OutNumber =	2510	// ...
Sumator_12[	43	].OutNumber =	2511	// ...
Sumator_12[	44	].OutNumber =	2512	// ...
Sumator_12[	45	].OutNumber =	2513	// ...
Sumator_12[	46	].OutNumber =	2514	// ...
Sumator_12[	47	].OutNumber =	2515	// ...
Sumator_12[	48	].OutNumber =	2706	// ...
Sumator_12[	49	].OutNumber =	2707	// ...
Sumator_12[	50	].OutNumber =	2708	// ...
Sumator_12[	51	].OutNumber =	2709	// ...
Sumator_12[	52	].OutNumber =	2710	// ...
Sumator_12[	53	].OutNumber =	2711	// ...
Sumator_12[	54	].OutNumber =	2712	// ...
Sumator_12[	55	].OutNumber =	2713	// ...
Sumator_12[	56	].OutNumber =	2714	// ...
Sumator_12[	57	].OutNumber =	2715	// ...
Sumator_12[	58	].OutNumber =	2906	// ...
Sumator_12[	59	].OutNumber =	2907	// ...
Sumator_12[	60	].OutNumber =	2908	// ...
Sumator_12[	61	].OutNumber =	2909	// ...
Sumator_12[	62	].OutNumber =	2910	// ...
Sumator_12[	63	].OutNumber =	2911	// SS 23
Sumator_12[	64	].OutNumber =	2912	// SS Оператор
Sumator_12[	65	].OutNumber =	2913	// SS Raznov// SS СЦ 5.30 (VIP)
Sumator_12[	66	].OutNumber =	2914	// Epihfan 1
Sumator_12[	67	].OutNumber =	2915	// Epihfan 2

DEFINE_START// ------------- Sumators 12-1 in ---------------
Sumator_12[	1	].InNumberFirst =	1720
Sumator_12[	2	].InNumberFirst =	1732
Sumator_12[	3	].InNumberFirst =	1744
Sumator_12[	4	].InNumberFirst =	1756
Sumator_12[	5	].InNumberFirst =	1768
Sumator_12[	6	].InNumberFirst =	1780
Sumator_12[	7	].InNumberFirst =	1792
Sumator_12[	8	].InNumberFirst =	1804
Sumator_12[	9	].InNumberFirst =	1816
Sumator_12[	10	].InNumberFirst =	1828
Sumator_12[	11	].InNumberFirst =	1920
Sumator_12[	12	].InNumberFirst =	1932
Sumator_12[	13	].InNumberFirst =	1944
Sumator_12[	14	].InNumberFirst =	1956
Sumator_12[	15	].InNumberFirst =	1968
Sumator_12[	16	].InNumberFirst =	1980
Sumator_12[	17	].InNumberFirst =	1992
Sumator_12[	18	].InNumberFirst =	2004
Sumator_12[	19	].InNumberFirst =	2016
Sumator_12[	20	].InNumberFirst =	2028
Sumator_12[	21	].InNumberFirst =	2134
Sumator_12[	22	].InNumberFirst =	2146
Sumator_12[	23	].InNumberFirst =	2158
Sumator_12[	24	].InNumberFirst =	2170
Sumator_12[	25	].InNumberFirst =	2182
Sumator_12[	26	].InNumberFirst =	2194
Sumator_12[	27	].InNumberFirst =	2206
Sumator_12[	28	].InNumberFirst =	2320
Sumator_12[	29	].InNumberFirst =	2332
Sumator_12[	30	].InNumberFirst =	2344
Sumator_12[	31	].InNumberFirst =	2356
Sumator_12[	32	].InNumberFirst =	2368
Sumator_12[	33	].InNumberFirst =	2380
Sumator_12[	34	].InNumberFirst =	2392
Sumator_12[	35	].InNumberFirst =	2404
Sumator_12[	36	].InNumberFirst =	2416
Sumator_12[	37	].InNumberFirst =	2428
Sumator_12[	38	].InNumberFirst =	2520
Sumator_12[	39	].InNumberFirst =	2532
Sumator_12[	40	].InNumberFirst =	2544
Sumator_12[	41	].InNumberFirst =	2556
Sumator_12[	42	].InNumberFirst =	2568
Sumator_12[	43	].InNumberFirst =	2580
Sumator_12[	44	].InNumberFirst =	2592
Sumator_12[	45	].InNumberFirst =	2604
Sumator_12[	46	].InNumberFirst =	2616
Sumator_12[	47	].InNumberFirst =	2628
Sumator_12[	48	].InNumberFirst =	2720
Sumator_12[	49	].InNumberFirst =	2732
Sumator_12[	50	].InNumberFirst =	2744
Sumator_12[	51	].InNumberFirst =	2756
Sumator_12[	52	].InNumberFirst =	2768
Sumator_12[	53	].InNumberFirst =	2780
Sumator_12[	54	].InNumberFirst =	2792
Sumator_12[	55	].InNumberFirst =	2804
Sumator_12[	56	].InNumberFirst =	2816
Sumator_12[	57	].InNumberFirst =	2828
Sumator_12[	58	].InNumberFirst =	2920
Sumator_12[	59	].InNumberFirst =	2932
Sumator_12[	60	].InNumberFirst =	2944
Sumator_12[	61	].InNumberFirst =	2956
Sumator_12[	62	].InNumberFirst =	2968
Sumator_12[	63	].InNumberFirst =	2980
Sumator_12[	64	].InNumberFirst =	2992
Sumator_12[	65	].InNumberFirst =	3004
Sumator_12[	66	].InNumberFirst =	3016
Sumator_12[	67	].InNumberFirst =	3028


DEFINE_START// ------------- Sumators 4-1 OUT ---------------
// --- Суматоры 4->1 ---
Sumator_4[	1	].OutNumber =	1701	// PC 1
Sumator_4[	2	].OutNumber =	1702	// ...
Sumator_4[	3	].OutNumber =	1703	// ...
Sumator_4[	4	].OutNumber =	1704	// ...
Sumator_4[	5	].OutNumber =	1705	// ...
Sumator_4[	6	].OutNumber =	1901	// ...
Sumator_4[	7	].OutNumber =	1902	// ...
Sumator_4[	8	].OutNumber =	1903	// ...
Sumator_4[	9	].OutNumber =	1904	// ...
Sumator_4[	10	].OutNumber =	1905	// ...
Sumator_4[	11	].OutNumber =	2119	// ...
Sumator_4[	12	].OutNumber =	2120	// ...
Sumator_4[	13	].OutNumber =	2121	// ...
Sumator_4[	14	].OutNumber =	2122	// ...
Sumator_4[	15	].OutNumber =	2301	// ...
Sumator_4[	16	].OutNumber =	2302	// ...
Sumator_4[	17	].OutNumber =	2303	// ...
Sumator_4[	18	].OutNumber =	2304	// ...
Sumator_4[	19	].OutNumber =	2305	// ...
Sumator_4[	20	].OutNumber =	2501	// ...
Sumator_4[	21	].OutNumber =	2502	// ...
Sumator_4[	22	].OutNumber =	2503	// ...
Sumator_4[	23	].OutNumber =	2504	// PC 23
Sumator_4[	24	].OutNumber =	2505
Sumator_4[	25	].OutNumber =	2701
Sumator_4[	26	].OutNumber =	2702
Sumator_4[	27	].OutNumber =	2703
Sumator_4[	28	].OutNumber =	2704
Sumator_4[	29	].OutNumber =	2705
Sumator_4[	30	].OutNumber =	2901
Sumator_4[	31	].OutNumber =	2902	// Dune 1
Sumator_4[	32	].OutNumber =	2903	// Dune 2
Sumator_4[	33	].OutNumber =	2904
Sumator_4[	34	].OutNumber =	2905

DEFINE_START// ------------- Sumators 4-1 in ---------------
Sumator_4[	1	].InNumberFirst =	1700
Sumator_4[	2	].InNumberFirst =	1704
Sumator_4[	3	].InNumberFirst =	1708
Sumator_4[	4	].InNumberFirst =	1712
Sumator_4[	5	].InNumberFirst =	1716
Sumator_4[	6	].InNumberFirst =	1900
Sumator_4[	7	].InNumberFirst =	1904
Sumator_4[	8	].InNumberFirst =	1908
Sumator_4[	9	].InNumberFirst =	1912
Sumator_4[	10	].InNumberFirst =	1916
Sumator_4[	11	].InNumberFirst =	2118
Sumator_4[	12	].InNumberFirst =	2122
Sumator_4[	13	].InNumberFirst =	2126
Sumator_4[	14	].InNumberFirst =	2130
Sumator_4[	15	].InNumberFirst =	2300
Sumator_4[	16	].InNumberFirst =	2304
Sumator_4[	17	].InNumberFirst =	2308
Sumator_4[	18	].InNumberFirst =	2312
Sumator_4[	19	].InNumberFirst =	2316
Sumator_4[	20	].InNumberFirst =	2500
Sumator_4[	21	].InNumberFirst =	2504
Sumator_4[	22	].InNumberFirst =	2508
Sumator_4[	23	].InNumberFirst =	2512
Sumator_4[	24	].InNumberFirst =	2516
Sumator_4[	25	].InNumberFirst =	2700
Sumator_4[	26	].InNumberFirst =	2704
Sumator_4[	27	].InNumberFirst =	2708
Sumator_4[	28	].InNumberFirst =	2712
Sumator_4[	29	].InNumberFirst =	2716
Sumator_4[	30	].InNumberFirst =	2900
Sumator_4[	31	].InNumberFirst =	2904
Sumator_4[	32	].InNumberFirst =	2908
Sumator_4[	33	].InNumberFirst =	2912
Sumator_4[	34	].InNumberFirst =	2916



DEFINE_START// ------------- WS Микрофоны и наушники ---------------------------------
// --- IN ---
InWS_Mic[1].InNumber = 201
InWS_Mic[2].InNumber = 202
InWS_Mic[3].InNumber = 203
InWS_Mic[4].InNumber = 204
InWS_Mic[5].InNumber = 205
InWS_Mic[6].InNumber = 206
InWS_Mic[7].InNumber = 207
InWS_Mic[8].InNumber = 208
InWS_Mic[9].InNumber = 233
InWS_Mic[10].InNumber = 234
InWS_Mic[11].InNumber = 235
InWS_Mic[12].InNumber = 236
InWS_Mic[13].InNumber = 237
InWS_Mic[14].InNumber = 238
InWS_Mic[15].InNumber = 239
InWS_Mic[16].InNumber = 240
InWS_Mic[17].InNumber = 265
InWS_Mic[18].InNumber = 266
InWS_Mic[19].InNumber = 267
InWS_Mic[20].InNumber = 268
InWS_Mic[21].InNumber = 269
InWS_Mic[22].InNumber = 270
InWS_Mic[23].InNumber = 271
InWS_Mic[24].InNumber = 901	// Оператор
InWS_Mic[25].InNumber = 902	// Ражнов 	?????
InWS_Mic[26].InNumber = 907	// Греф		?????
InWS_Mic[27].InNumber = 550	// VIP	1121 (EQ1) 550(Чистая DCN)
InWS_Mic[28].InNumber = 0	// CUP
InWS_Mic[29].InNumber = 849	// VKS 35
InWS_Mic[30].InNumber = 851	// VKS 37
InWS_Mic[31].InNumber = 552	// VKS VIP!!!! Берём с SS Для удаления Обратной связи 
InWS_Mic[32].InNumber = 855	// VKS CUP

// --- Out ---
For (AStart=1;AStart<24;AStart++)
    OutWS_HeadPhones[AStart].OutNumber = 100 + AStart
    
OutWS_HeadPhones[24].OutNumber = 543	// Оператор
OutWS_HeadPhones[25].OutNumber = 509	// Ражнов 
OutWS_HeadPhones[26].OutNumber = 541	// Греф		
OutWS_HeadPhones[27].OutNumber = 545	// VIP
OutWS_HeadPhones[28].OutNumber = 547	// CUP
OutWS_HeadPhones[29].OutNumber = 525	// VKS 35
OutWS_HeadPhones[30].OutNumber = 527	// VKS 37
OutWS_HeadPhones[31].OutNumber = 529	// VKS VIP
OutWS_HeadPhones[32].OutNumber = 531	// VKS CUP
    
DEFINE_START// ------------- SS --------------
// --- IN ---
InSS_HeadPhones[1].InNumber = 501
InSS_HeadPhones[2].InNumber = 502
InSS_HeadPhones[3].InNumber = 503
InSS_HeadPhones[4].InNumber = 504
InSS_HeadPhones[5].InNumber = 505
InSS_HeadPhones[6].InNumber = 506
InSS_HeadPhones[7].InNumber = 507
InSS_HeadPhones[8].InNumber = 508
InSS_HeadPhones[9].InNumber = 517
InSS_HeadPhones[10].InNumber = 518
InSS_HeadPhones[11].InNumber = 519
InSS_HeadPhones[12].InNumber = 520
InSS_HeadPhones[13].InNumber = 521
InSS_HeadPhones[14].InNumber = 522
InSS_HeadPhones[15].InNumber = 523
InSS_HeadPhones[16].InNumber = 524
InSS_HeadPhones[17].InNumber = 533
InSS_HeadPhones[18].InNumber = 534
InSS_HeadPhones[19].InNumber = 535
InSS_HeadPhones[20].InNumber = 536
InSS_HeadPhones[21].InNumber = 537
InSS_HeadPhones[22].InNumber = 538
InSS_HeadPhones[23].InNumber = 903 //539		// Ражнов
InSS_HeadPhones[24].InNumber = 540			// Оператор
InSS_HeadPhones[25].InNumber = 539//551			// 23
InSS_HeadPhones[26].InNumber = 551//539//0		// VIP

// --- Out ---
OutSS_Mic[1].OutNumber = 501
OutSS_Mic[2].OutNumber = 502
OutSS_Mic[3].OutNumber = 503
OutSS_Mic[4].OutNumber = 504
OutSS_Mic[5].OutNumber = 505
OutSS_Mic[6].OutNumber = 506
OutSS_Mic[7].OutNumber = 507
OutSS_Mic[8].OutNumber = 508
OutSS_Mic[9].OutNumber = 517
OutSS_Mic[10].OutNumber = 518
OutSS_Mic[11].OutNumber = 519
OutSS_Mic[12].OutNumber = 520
OutSS_Mic[13].OutNumber = 521
OutSS_Mic[14].OutNumber = 522
OutSS_Mic[15].OutNumber = 523
OutSS_Mic[16].OutNumber = 524
OutSS_Mic[17].OutNumber = 533
OutSS_Mic[18].OutNumber = 534
OutSS_Mic[19].OutNumber = 535
OutSS_Mic[20].OutNumber = 536
OutSS_Mic[21].OutNumber = 537
OutSS_Mic[22].OutNumber = 538
OutSS_Mic[23].OutNumber = 539
OutSS_Mic[24].OutNumber = 540
OutSS_Mic[25].OutNumber = 549
	OutSS_Mic[26].OutNumber = 0		// VIP ??? 550??


DEFINE_START// ------------- PC ---------------
// --- IN ---
PC[	1	 ].InNumber =	801
PC[	2	 ].InNumber =	802
PC[	3	 ].InNumber =	803
PC[	4	 ].InNumber =	804
PC[	5	 ].InNumber =	805
PC[	6	 ].InNumber =	806
PC[	7	 ].InNumber =	807
PC[	8	 ].InNumber =	808
PC[	9	 ].InNumber =	817
PC[	10	 ].InNumber =	818
PC[	11	 ].InNumber =	819
PC[	12	 ].InNumber =	820
PC[	13	 ].InNumber =	821
PC[	14	 ].InNumber =	822
PC[	15	 ].InNumber =	823
PC[	16	 ].InNumber =	824
PC[	17	 ].InNumber =	833
PC[	18	 ].InNumber =	834
PC[	19	 ].InNumber =	835
PC[	20	 ].InNumber =	836
PC[	21	 ].InNumber =	837
PC[	22	 ].InNumber =	838
PC[	23	 ].InNumber =	839
PC[	24	 ].InNumber =	840
PC[	25	 ].InNumber =	809
PC[	26	 ].InNumber =	810
PC[	27	 ].InNumber =	811
PC[	28	 ].InNumber =	812
PC[	29	 ].InNumber =	813
PC[	30	 ].InNumber =	814
PC[	31	 ].InNumber =	815
PC[	32	 ].InNumber =	816
PC[	33	 ].InNumber =	825
PC[	34	 ].InNumber =	826
PC[	35	 ].InNumber =	827
PC[	36	 ].InNumber =	828
PC[	37	 ].InNumber =	829
PC[	38	 ].InNumber =	830
PC[	39	 ].InNumber =	831
PC[	40	 ].InNumber =	832
PC[	41	 ].InNumber =	841
PC[	42	 ].InNumber =	842
PC[	43	 ].InNumber =	843
PC[	44	 ].InNumber =	844
PC[	45	 ].InNumber =	845
PC[	46	 ].InNumber =	846
PC[	47	 ].InNumber =	847
PC[	48	 ].InNumber =	848
PC[	49	 ].InNumber =	857
PC[	50	 ].InNumber =	858
PC[	51	 ].InNumber =	859
PC[	52	 ].InNumber =	860
PC[	53	 ].InNumber =	861
PC[	54	 ].InNumber =	862


// --- Out ---
PC[	1	].OutNumber =	817
PC[	2	].OutNumber =	818
PC[	3	].OutNumber =	819
PC[	4	].OutNumber =	820
PC[	5	].OutNumber =	821
PC[	6	].OutNumber =	822
PC[	7	].OutNumber =	823
PC[	8	].OutNumber =	824
PC[	9	].OutNumber =	833
PC[	10	].OutNumber =	834
PC[	11	].OutNumber =	835
PC[	12	].OutNumber =	836
PC[	13	].OutNumber =	837
PC[	14	].OutNumber =	838
PC[	15	].OutNumber =	839
PC[	16	].OutNumber =	840
PC[	17	].OutNumber =	801
PC[	18	].OutNumber =	802
PC[	19	].OutNumber =	803
PC[	20	].OutNumber =	804
PC[	21	].OutNumber =	805
PC[	22	].OutNumber =	806
PC[	23	].OutNumber =	807
PC[	24	].OutNumber =	808
PC[	25	].OutNumber =	816
PC[	26	].OutNumber =	815
PC[	27	].OutNumber =	814
PC[	28	].OutNumber =	813
PC[	29	].OutNumber =	812
PC[	30	].OutNumber =	811
PC[	31	].OutNumber =	810
PC[	32	].OutNumber =	809
PC[	33	].OutNumber =	832
PC[	34	].OutNumber =	831
PC[	35	].OutNumber =	830
PC[	36	].OutNumber =	829
PC[	37	].OutNumber =	828
PC[	38	].OutNumber =	827
PC[	39	].OutNumber =	826
PC[	40	].OutNumber =	825
PC[	41	].OutNumber =	841
PC[	42	].OutNumber =	842
PC[	43	].OutNumber =	843
PC[	44	].OutNumber =	844
PC[	45	].OutNumber =	845
PC[	46	].OutNumber =	846
PC[	47	].OutNumber =	847
PC[	48	].OutNumber =	848
PC[	49	].OutNumber =	857
PC[	50	].OutNumber =	858
PC[	51	].OutNumber =	859
PC[	52	].OutNumber =	860
PC[	53	].OutNumber =	861
PC[	54	].OutNumber =	862

DEFINE_START// ------------- Лючки ---------------
// ------------- Лючки ---------------
In_Luchki[1] = 525	// Ражнов
In_Luchki[2] = 527	// Греф
In_Luchki[3] = 529	// Греф
In_Luchki[4] = 531	// VIP
In_Luchki[5] = 541	// VIP
In_Luchki[6] = 543	// VIP

In_Luchki[7] = 904	// MIC_rezerv_RF = 904		радио микрофоны, (для простой коммутации как альтернативного источника)
DEFINE_START// ------------- EQ & Faiders ---------------
// --- EO ---
EQ[1].InNumber = 2111	// --- Усилитель Оператор
EQ[2].InNumber = 2112	// --- Усилитель 5.35
EQ[3].InNumber = 2113	// --- Усилитель 5.37
EQ[4].InNumber = 2114	// --- Усилитель 5.45
EQ[5].InNumber = 2115
EQ[6].InNumber = 2116
EQ[7].InNumber = 2117
EQ[8].InNumber = 2118	// --- Усилитель 5.30 VIP


EQ[1].OutNumber = 2111
EQ[2].OutNumber = 2112
EQ[3].OutNumber = 2113
EQ[4].OutNumber = 2114
EQ[5].OutNumber = 2115
EQ[6].OutNumber = 2116
EQ[7].OutNumber = 2117
EQ[8].OutNumber = 2118

// --- Faiders ---
Faider[1].InNumber  = 2101	// TV 1
Faider[2].InNumber  = 2102	// TV 2
Faider[3].InNumber  = 2103	// TV 3
Faider[4].InNumber  = 2104	// TV 4
Faider[5].InNumber  = 2105	// TV 5
Faider[6].InNumber  = 2106 	// --- VKS 5.35 по входному сигналу
Faider[7].InNumber  = 2107	// --- VKS 5.37 по входному сигналу
Faider[8].InNumber  = 2108	// --- VKS 5.30 по входному сигналу
Faider[9].InNumber  = 2109	// --- VKS 5.45 по входному сигналу
Faider[10].InNumber = 2110	// --- По выходу DCN На вход VIP

Faider[1].OutNumber  = 2101
Faider[2].OutNumber  = 2102
Faider[3].OutNumber  = 2103
Faider[4].OutNumber  = 2104
Faider[5].OutNumber  = 2105
Faider[6].OutNumber  = 2106
Faider[7].OutNumber  = 2107
Faider[8].OutNumber  = 2108
Faider[9].OutNumber  = 2109
Faider[10].OutNumber = 2110

DEFINE_START// ------------- Другое ---------------
MIC_Potolochka_VIP = 549
MIC_rezerv_RF = 904
// --- TV IN ---
In_TV[1] = 565
In_TV[2] = 566
In_TV[3] = 567
In_TV[4] = 568
In_TV[5] = 569
// --- VKS IN ---
In_VKS[1] = 849		// VKS 35
In_VKS[2] = 850
In_VKS[3] = 851		// VKS 37
In_VKS[4] = 852
In_VKS[5] = 552	// !!!! Берём с SS№13 Для удаления Обратной связи
In_VKS[6] = 854
In_VKS[7] = 855		// VKS CUP
In_VKS[8] = 856

Out_VKS[1] = 525	// VKS 35
Out_VKS[2] = 526		// Для контента
Out_VKS[3] = 527	// VKS 37
Out_VKS[4] = 528		// Для контента
Out_VKS[5] = 529	// VKS VIP
Out_VKS[6] = 530		// Для контента
Out_VKS[7] = 531	// VKS CUP
Out_VKS[8] = 532		// Для контента
// --- Duna ---	2X
In_Duna[1] = 513
In_Duna[2] = 515
// --- Ephifan ---
In_Epifan[1] = 509
In_Epifan[2] = 511

Out_Epifan[1] = 553
Out_Epifan[2] = 555

// --- Номера левелов для управления звуком ---
InNum[1].Number = 2101 ; InNum[1].For_TP = '24!'	// tv
InNum[2].Number = 2102 ; InNum[2].For_TP = '24!'	// tv
InNum[3].Number = 2103 ; InNum[3].For_TP = '24!'	// tv
InNum[4].Number = 2104 ; InNum[4].For_TP = '24!'	// tv
InNum[5].Number = 2105 ; InNum[5].For_TP = '24!'	// tv

InNum[6].Number = 2106 ; InNum[6].For_TP = '24!'	// --- VKS 5.35 по входному сигналу
InNum[7].Number = 2107 ; InNum[7].For_TP = '24!'	// --- VKS 5.37 по входному сигналу
InNum[8].Number = 2108 ; InNum[8].For_TP = '24!'	// --- VKS 5.30 по входному сигналу
InNum[9].Number = 2109 ; InNum[9].For_TP = '24!'	// --- VKS 5.45 по входному сигналу

InNum[10].Number = 2110 ; InNum[10].For_TP = '24!'	// --- По выходу DCN На вход VIP

InNum[11].Number = 2902 ; InNum[11].For_TP = '24!'	// --- Dune 1
InNum[12].Number = 2903 ; InNum[12].For_TP = '24!'	// --- Dune 2

InNum[13].Number = 2307 ; InNum[13].For_TP = '24!'	// --- по выходу VKS 5.35
InNum[14].Number = 2308 ; InNum[14].For_TP = '24!'	// --- по выходу VKS 5.37
InNum[15].Number = 2309 ; InNum[15].For_TP = '24!'	// --- по выходу VKS 5.30
InNum[16].Number = 2310 ; InNum[16].For_TP = '24!'	// --- по выходу VKS 5.45

InNum[17].Number = 2914 ; InNum[17].For_TP = '24!'	// --- по входу Epihfan 1
InNum[18].Number = 2915 ; InNum[18].For_TP = '24!'	// --- по входу Epihfan 2


InNum[24].Number = 2111 ; InNum[24].For_TP = '24!'	// Оператор	OUT
InNum[25].Number = 2113	; InNum[25].For_TP = '24!26!29!'// Греф		OUT
InNum[26].Number = 2118	; InNum[26].For_TP = '24!26!27!'// VIP		OUT
InNum[27].Number = 2112 ; InNum[27].For_TP = '24!25!'	// Ражнов 	OUT
InNum[23].Number = 2114 ; InNum[23].For_TP = '24!33!28!'// ЦУП  	OUT

InNum[28].Number = 10000 ; InNum[28].For_TP = ''
InNum[29].Number = 10000 ; InNum[29].For_TP = ''
InNum[30].Number = 10000 ; InNum[30].For_TP = ''

InNum[31].Number = 2509; InNum[31].For_TP = '1!'	// SS 1
InNum[32].Number = 2510; InNum[32].For_TP = '2!'	// ...
InNum[33].Number = 2511; InNum[33].For_TP = '3!'	// ...
InNum[34].Number = 2512; InNum[34].For_TP = '4!'	// ...
InNum[35].Number = 2513; InNum[35].For_TP = '5!'	// ...
InNum[36].Number = 2514; InNum[36].For_TP = '6!'	// ...
InNum[37].Number = 2515; InNum[37].For_TP = '7!'	// ...
InNum[38].Number = 2706; InNum[38].For_TP = '8!'	// ...
InNum[39].Number = 2707; InNum[39].For_TP = '9!'	// ...
InNum[40].Number = 2708; InNum[40].For_TP = '10!'	// ...
InNum[41].Number = 2709; InNum[41].For_TP = '11!'	// ...
InNum[42].Number = 2710; InNum[42].For_TP = '12!'	// ...
InNum[43].Number = 2711; InNum[43].For_TP = '13!'	// ...
InNum[44].Number = 2712; InNum[44].For_TP = '14!'	// ...
InNum[45].Number = 2713; InNum[45].For_TP = '15!'	// ...
InNum[46].Number = 2714; InNum[46].For_TP = '16!'	// ...
InNum[47].Number = 2715; InNum[47].For_TP = '17!'	// ...
InNum[48].Number = 2906; InNum[48].For_TP = '18!'	// ...
InNum[49].Number = 2907; InNum[49].For_TP = '19!'	// ...
InNum[50].Number = 2908; InNum[50].For_TP = '20!'	// ...
InNum[51].Number = 2909; InNum[51].For_TP = '21!'	// ...
InNum[52].Number = 2910; InNum[52].For_TP = '22!'	// ...
InNum[53].Number = 2911; InNum[53].For_TP = '23!'	// SS 23


DEFINE_CALL 'Audio_CRC'
{
    STACK_VAR Char Ch
    Audio_CRC = $FFFF;
    For(Audio_Length=1;Audio_Length<LENGTH_STRING(AudioCommand)+1;Audio_Length++)
    {
	Ch = AudioCommand[Audio_Length]
	Audio_CRC = (Audio_CRC << 8) ^ crctable[(Audio_CRC >> 8) ^ Ch]
    }
}

DEFINE_FUNCTION Integer Audio_CRC_long (char AudioCommand_f[100])
{
    STACK_VAR integer A_p, A_i, crc
    STACK_VAR Char Ch

    crc = $FFFF;
    for(A_p=1;A_p<LENGTH_STRING(AudioCommand_f)+1;A_p++)
    {
	Ch = AudioCommand_f[A_p]
	crc = crc ^ (Ch << 8);
	for(A_i=1;A_i<9;A_i++)
	{
	    if(crc & $8000) crc = (crc << 1) ^ $1021;
		else crc = crc << 1;
	}
    }
    //Audio_CRC = crc
    return crc
}
DEFINE_FUNCTION Char[254] to_audio_dv(char audio_str_in[100])		// --- Расчет CRC + фильтр FF,FE
{
    STACK_VAR integer A_y
    STACK_VAR char audio_str_out [100]
    STACK_VAR char In_DataText[100]
    
    Audio_CRC = Audio_CRC_long(audio_str_in)
    In_DataText = "audio_str_in,Audio_CRC>>8,Audio_CRC"
    audio_str_out = ''
    for(A_y=1;A_y<LENGTH_STRING(In_DataText)+1;A_y++)
    {
	if (In_DataText[A_y]="$FE")		audio_str_out = "audio_str_out,$FE,$00"
	Else if (In_DataText[A_y]="$FF")	audio_str_out = "audio_str_out,$FE,$01"
	Else					audio_str_out = "audio_str_out,In_DataText[A_y]"
    } 
    audio_str_out = "audio_str_out,$FF"
    AudioMiniBuff = audio_str_out
    //SEND_STRING dv_AudioMatrix,"audio_str_out"
    return audio_str_out
}
DEFINE_FUNCTION ConnectAudio_Point (Integer ainF, Integer aoutF)	// --- Комутация поинтов
{
    AudioCommand = to_audio_dv("$00,$28,$37,$00,right_string("$00,AInF>>8,AInF",2),right_string("$00,AOutF>>8,AOutF",2)")
    SEND_STRING dv_AudioMatrix,"AudioCommand"
}
DEFINE_FUNCTION Opros_DSP_Param (Integer num)				// --- Опрос DSP параметров
{
    AudioCommand = "$00,$72,$37,$00,InNum[num].Number>>8,InNum[num].Number,$19,$01"
    SEND_STRING dv_AudioMatrix,"to_audio_dv(AudioCommand)"
}

DEFINE_FUNCTION Set_DSP_Param (Integer num)				// --- Задатка DSP параметров... Mute,Vol
{
    AudioCommand = "$00,$74,$37,$00,$19,$01,InNum[num].Mute,InNum[num].Vol,$00,$00,$00,$00,$00,$00,InNum[num].Number>>8,InNum[num].Number"
    SEND_STRING dv_AudioMatrix,"to_audio_dv(AudioCommand)"
}
DEFINE_EVENT
DATA_EVENT[vtp_Audio]
{
    STRING:
    ConnectAudio_Point (atoi(remove_string(Data.TEXT,"','",1)),atoi(Data.TEXT))
}
DEFINE_PROGRAM
If (Audio_Pusc_CRC=1)
{
    CALL 'Audio_CRC'
    Audio_Pusc_CRC=0
}
