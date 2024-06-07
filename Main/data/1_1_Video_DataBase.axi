PROGRAM_NAME='1_1_Video_DataBase'

DEFINE_CONSTANT
Integer Kol_voIO = 160

DEFINE_VARIABLE
VOLATILE integer Matrix_AdderLink_Pressets [][][] =	//23,2,5
{
    {{13001,13101,13701,13601,13501},{13201,13301,13901,13401,13801}},	// 1
    {{14001,14101,14601,14401,14501},{14201,14301,14901,14701,14801}},	// 2
    {{15001,15101,15601,15401,15501},{15201,15301,15901,15701,15801}},	// 3
    {{16001,16101,16601,16401,16501},{16201,16301,16901,16701,16801}},	// 4
    {{17001,17101,17601,17401,17501},{17201,17301,17901,17801,17701}},	// 5
    {{18001,18101,18601,18401,18501},{18201,18301,18901,18701,18801}},	// 6
    {{19001,19101,19601,19401,19501},{19201,19301,19901,19401,19801}},	// 7
    {{20001,20101,20601,20401,20501},{20201,20301,20901,20701,20801}},	// 8
    {{21001,21101,21601,21401,21501},{21201,21301,21901,21701,21801}},	// 9
    {{22001,22101,22601,22401,22501},{22201,22301,22901,22701,22801}},	// 10
    {{3001,5201,3101,3201,3301},{5301,1,3401,101,201}},	// 11
    {{3501,5401,3601,3701,3801},{5501,301,3901,401,501}},	// 12
    {{4001,5601,4301,4101,4201},{5701,601,4401,701,801}},	// 13
    {{901,5801,4501,1101,1201},{5901,1001,4601,1301,1401}},	// 14
    {{4701,6001,4801,4901,5001},{6101,1501,5101,1601,1701}},	// 15
    {{6201,6301,6501,6601,6701},{6401,1801,6801,1901,2001}},	// 16
    {{2101,6901,7101,2301,2401},{7001,2201,7201,2501,2601}},	// 17
    {{7301,7401,7601,7701,7801},{7501,2701,7901,2801,2901}},	// 18
    {{8001,8101,8601,8401,8501},{8201,8301,8701,8801,8901}},	// 19
    {{9001,9101,9601,9401,9501},{9201,9301,9901,9701,9801}},	// 20
    {{10001,10101,10801,10401,10501},{10201,10301,10901,10601,10701}},	// 21
    {{11001,11101,11801,11401,11501},{11201,11301,11901,11601,11701}},	// 22
    {{12001,12101,12801,12401,12501},{12201,12301,12901,12601,12701}}	// 23
}

VOLATILE Integer Matrix_PC_Spec [23][2]
VOLATILE Integer Flag_tp_Spec [] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}
VOLATILE Integer s
VOLATILE Icons [Kol_voIO][30]
VOLATILE Names [Kol_voIO][15]
VOLATILE Names_uni [Kol_voIO][100]
(*
    49 - 102 Компы		pc_oper_50_2.png
    103 - 110 Кодеки		aero_video_conferencing_50x50.png
    111 - Комп HP		pc_oper_50_2.png
    113 - 130 Юпитер		Jpiter_70.png
    139 - 144 Камеры сони	aero_video_camera_50x50.png
*)

DEFINE_START
// --- Привязка компьютеров специалистов к местам
Matrix_PC_Spec [1][1] = 49; Matrix_PC_Spec [1][2] = 50;
Matrix_PC_Spec [2][1] = 51; Matrix_PC_Spec [2][2] = 52;
Matrix_PC_Spec [3][1] = 53; Matrix_PC_Spec [3][2] = 54;
Matrix_PC_Spec [4][1] = 55; Matrix_PC_Spec [4][2] = 56;
Matrix_PC_Spec [5][1] = 57; Matrix_PC_Spec [5][2] = 58;
Matrix_PC_Spec [6][1] = 59; Matrix_PC_Spec [6][2] = 60;
Matrix_PC_Spec [7][1] = 61; Matrix_PC_Spec [7][2] = 62;
Matrix_PC_Spec [8][1] = 63; Matrix_PC_Spec [8][2] = 64;
Matrix_PC_Spec [9][1] = 65; Matrix_PC_Spec [9][2] = 66;
Matrix_PC_Spec [10][1] = 67; Matrix_PC_Spec [10][2] = 68;
Matrix_PC_Spec [11][1] = 69; Matrix_PC_Spec [11][2] = 70;
Matrix_PC_Spec [12][1] = 71; Matrix_PC_Spec [12][2] = 72;
Matrix_PC_Spec [13][1] = 73; Matrix_PC_Spec [13][2] = 74;
Matrix_PC_Spec [14][1] = 75; Matrix_PC_Spec [14][2] = 76;
Matrix_PC_Spec [15][1] = 77; Matrix_PC_Spec [15][2] = 78;
Matrix_PC_Spec [16][1] = 79; Matrix_PC_Spec [16][2] = 80;
Matrix_PC_Spec [17][1] = 81; Matrix_PC_Spec [17][2] = 82;
Matrix_PC_Spec [18][1] = 83; Matrix_PC_Spec [18][2] = 84;
Matrix_PC_Spec [19][1] = 85; Matrix_PC_Spec [19][2] = 86;
Matrix_PC_Spec [20][1] = 87; Matrix_PC_Spec [20][2] = 88;
Matrix_PC_Spec [21][1] = 89; Matrix_PC_Spec [21][2] = 90;
Matrix_PC_Spec [22][1] = 91; Matrix_PC_Spec [22][2] = 92;
Matrix_PC_Spec [23][1] = 93; Matrix_PC_Spec [23][2] = 94;
  
// --- Зануление обратки видие выходов
For (s=1;s<145;s++)//Выкл
{
    Icons [s] = 'None'
    //Names [s] = "'OFF'"
}


// --- Задатка обратки видео выходов
Icons [145] = 'aero_tv_tube_aqua_50x50.png'
Names_uni [145] = '04220412'//Names [145] = 'Local TV'

Icons [1] = 'Epifan_50.png' 
Names [1] = 'REC 2'
Icons [2] = 'Epifan_50.png'
Names [2] = 'REC 1'

Icons [3] = 'aero_movie_reel_50x50.png'
Names [3] = 'Player 1'
Icons [4] = 'aero_movie_reel_50x50.png'
Names [4] = 'Player 2'
 
For (s=5;s<11;s++)// 139 - 144 Камеры сони	aero_video_camera_50x50.png
    Icons [s] = 'aero_video_camera_50x50'
    
   // Names [5] = "'Camera 4'"
   // Names [6] = "'Camera 5'"
   // Names [7] = "'Camera 3'"
   // Names [8] = "'Camera 2'"
   // Names [9] = "'Camera 1'"
   // Names [10] = "'Camera 6'"
    Names_uni [5] = "'041A0430043C04350440043000200034'"
    Names_uni [6] = "'041A0430043C04350440043000200035'"
    Names_uni [7] = "'041A0430043C04350440043000200033'"
    Names_uni [8] = "'041A0430043C04350440043000200032'"
    Names_uni [9] = "'041A0430043C04350440043000200031'"
    Names_uni [10] = "'041A0430043C04350440043000200036'"
    
Icons [11] = 'pc_oper_50_2'
Names_uni [11] = "'004300430054005600200033002E0033'"

Icons [12] = 'pc_oper_50_2'
//Names_uni [12] = "'CCTV 3.1'"
Names_uni [12] = "'004300430054005600200033002E0031'"

Icons [13] = 'pc_oper_50_2'
Names_uni [13] = "'004300430054005600200033002E0032'"

Icons [17] = 'aero_surveillance_camera_50x50.png'
Names_uni [17] = "'041A0430043C04350440043000200035002E00330035'"

Icons [18] = 'aero_surveillance_camera_50x50.png'
Names_uni [18] = "'041A0430043C04350440043000200035002E00330037'"

For (s=49;s<103;s++)//49 -  94 95 - 102 Компы		pc_oper_50_2.png   WS
{
    Icons [s] = 'pc_oper_50_2'
}
For (s=1;s<24;s++)//49 -  94 95 - 102 Компы		pc_oper_50_2.png   WS
{
    Names [49+(s-1)*2] = "'WS ',itoa(s),$0D,$0A,' pc 1'"
    Names [50+(s-1)*2] = "'WS ',itoa(s),$0D,$0A,' pc 2'"
}
    Names [95] = "'WS 5.35',$0D,$0A,' pc 1'"
    Names [96] = "'WS 5.35',$0D,$0A,' pc 2'"
    //Names [97] = "'FTP',$0D,$0A,'Server'"
	    Icons [97] = 'pc_oper_50_2'
	    Names [97] = "'CCTV 2.1'"
    Names [98] = "'CCTV',$0D,$0A,'1.1'"
    Names [99] = "'Oper. 1',$0D,$0A,' pc 1'"
    Names [100] = "'Oper. 1',$0D,$0A,' pc 2'"
    Names [101] = "'Oper. 2',$0D,$0A,' pc 1'"
    Names [102] = "'Oper. 2',$0D,$0A,' pc 2'"


For (s=103;s<111;s++)//103 - 110 Кодеки		aero_video_conferencing_50x50.png
    Icons [s] = 'aero_video_conferencing_50x50'
    
   // Names [103] = "'VKS 5.35 codec'"
   // Names [104] = "'VKS 5.35 content'"
   // Names [105] = "'VKS 5.37 codec'"
   // Names [106] = "'VKS 5.37 content'"
   // Names [107] = "'VKS VIP codec'"
   // Names [108] = "'VKS VIP content'"
   // Names [109] = "'VKS CUP codec'"
   // Names [110] = "'VKS CUP content'"
    Names_uni [103] = "'0412041A042100200035002E003300350020043A043E04340435043A'"
    Names_uni [104] = "'0412041A042100200035002E003300350020043A043E043D04420435043D0442'"
    Names_uni [105] = "'0412041A042100200035002E003300370020043A043E04340435043A'"
    Names_uni [106] = "'0412041A042100200035002E003300370020043A043E043D04420435043D0442'"
    Names_uni [107] = "'0412041A04210020042104260020043A043E04340435043A'"
    Names_uni [108] = "'0412041A04210020042104260020043A043E043D04420435043D0442'"
    Names_uni [109] = "'0412041A0421002004260423041F0020043A043E04340435043A'"
    Names_uni [110] = "'0412041A0421002004260423041F0020043A043E043D04420435043D0442'"

// 111 - Комп HP		pc_oper_50_2.png
    Icons [s] = 'pc_oper_50_2'
    Names [s] = "'CCTV 1.1'"
    //Names_uni [111] = "'003100200412043804340435043E0020043C043E043D04380442043E04400438043D0433'"
	Icons [112] = 'pc_oper_50_2'
	Names [112] = "'CCTV 1.2'"
	//Names_uni [112] = "'003200200412043804340435043E0020043C043E043D04380442043E04400438043D0433'"
    
// 113 - 130 Юпитер		Jpiter_70.png
For (s=113;s<131;s++)// 113 - 130 Юпитер		Jpiter_70.png
{
    Icons [s] = 'Jpiter_70'
    Names [s] = "'Jupiter ',itoa(s-112)"
}
// 131 - 135 AverTV 		aero_tv_tube_aqua_50x50.png
For (s=131;s<136;s++)// 113 - 130 Юпитер		Jpiter_70.png
{
    Icons [s] = 'aero_tv_tube_aqua_50x50.png'
    Names [s] = "'TB ',itoa(s-130)"
}

    Icons [136] = 'pc_oper_50_2'
    Names [136] = "'CCTV 1.3'"
    //Names_uni [136] = "'003300200412043804340435043E0020043C043E043D04380442043E04400438043D0433'"
        Icons [137] = 'pc_oper_50_2'
	Names [137] = "'CCTV 2.3'"
	//Names_uni [137] = "'003400200412043804340435043E0020043C043E043D04380442043E04400438043D0433'"
    Icons [138] = 'pc_oper_50_2'
    Names [138] = "'CCTV 2.2'"

// 139 - 144 Лючки	'Luchek_45.png'
For (s=139;s<145;s++)// 139 - 144 Лючки	'Luchek_45.png'
    Icons [s] = 'Luchek_45.png'
    
    //Names [139] = 'Notebook 5.35'
    //Names [140] = 'Notebook 5.37'
    //Names [141] = 'Notebook 5.37'
    //Names [142] = 'Notebook 1 VIP'
    //Names [143] = 'Notebook 2 VIP'
    //Names [144] = 'Notebook 3 VIP'
    Names_uni [139] = '041D043E0443044204310443043A00200035002E00330035'
    Names_uni [140] = '041D043E0443044204310443043A00200035002E0033003700200031'
    Names_uni [141] = '041D043E0443044204310443043A00200035002E0033003700200032'
    Names_uni [142] = '041D043E0443044204310443043A00200031002004210426'
    Names_uni [143] = '041D043E0443044204310443043A00200032002004210426'
    Names_uni [144] = '041D043E0443044204310443043A00200033002004210426'
    
// 151 - 155 Виртуалные каналы	aero_surveillance_camera_50x50.png
    Icons [151] = 'aero_surveillance_camera_50x50.png'
    Icons [152] = 'aero_surveillance_camera_50x50.png'
For (s=153;s<161;s++)// 
    Icons [s] = 'Help_50.png'   
    
    //Names [151] = "'Active',$0D,$0A,'Cam SC'"
    Names_uni [151] = "'0410043A044204380432043D0430044F0020043A0430043C043504400430002004210426'"
    //Names [152] = "'Active',$0D,$0A,'Cam CC'"
    Names_uni [152] = "'0410043A044204380432043D0430044F0020043A0430043C043504400430002004260423041F'"
    Names [153] = "'Virt',$0D,$0A,'channel 1'"
    Names [154] = "'Virt',$0D,$0A,'channel 2'"
    Names [155] = "'Virt',$0D,$0A,'channel 3'"
    Names [156] = "'Virt',$0D,$0A,'channel 4'"
    Names [157] = "'Virt',$0D,$0A,'channel 5'"
    Names [158] = "'Virt',$0D,$0A,'channel 6'"
    Names [159] = "'Virt',$0D,$0A,'channel 7'"
    Names [160] = "'Virt',$0D,$0A,'channel 8'"

    
DEFINE_MODULE 'Video_com_For_Kab_Module' Main_Pan_Com(vdv_DGX,tp_VideoCom_17)	// --- Видео Комутация для панели оператора
DEFINE_MODULE 'Video_com_For_Kab_Module' Main_Pan_Com(vdv_DGX,tp_VideoCom_VideoWall)	// --- Видео Комутация для панели оператора
DEFINE_MODULE 'Video_com_For_Kab_Module' Main_Pan_Com(vdv_DGX,tp_VideoCom_7 )	// --- Видео Комутация для панели оператора
   
  
DEFINE_MODULE 'VideoComm_For_Spec'zz1(vdv_DGX,tp_VideoComm_Spec_1,Flag_tp_Spec[1],Matrix_PC_Spec [1],id_all_presset,Matrix_AdderLink_Pressets[1])
DEFINE_MODULE 'VideoComm_For_Spec'zz2(vdv_DGX,tp_VideoComm_Spec_2,Flag_tp_Spec[2],Matrix_PC_Spec [2],id_all_presset,Matrix_AdderLink_Pressets[2])
DEFINE_MODULE 'VideoComm_For_Spec'zz3(vdv_DGX,tp_VideoComm_Spec_3,Flag_tp_Spec[3],Matrix_PC_Spec [3],id_all_presset,Matrix_AdderLink_Pressets[3])
DEFINE_MODULE 'VideoComm_For_Spec'zz4(vdv_DGX,tp_VideoComm_Spec_4,Flag_tp_Spec[4],Matrix_PC_Spec [4],id_all_presset,Matrix_AdderLink_Pressets[4])
DEFINE_MODULE 'VideoComm_For_Spec'zz5(vdv_DGX,tp_VideoComm_Spec_5,Flag_tp_Spec[5],Matrix_PC_Spec [5],id_all_presset,Matrix_AdderLink_Pressets[5])
DEFINE_MODULE 'VideoComm_For_Spec'zz6(vdv_DGX,tp_VideoComm_Spec_6,Flag_tp_Spec[6],Matrix_PC_Spec [6],id_all_presset,Matrix_AdderLink_Pressets[6])
DEFINE_MODULE 'VideoComm_For_Spec'zz7(vdv_DGX,tp_VideoComm_Spec_7,Flag_tp_Spec[7],Matrix_PC_Spec [7],id_all_presset,Matrix_AdderLink_Pressets[7])
DEFINE_MODULE 'VideoComm_For_Spec'zz8(vdv_DGX,tp_VideoComm_Spec_8,Flag_tp_Spec[8],Matrix_PC_Spec [8],id_all_presset,Matrix_AdderLink_Pressets[8])
DEFINE_MODULE 'VideoComm_For_Spec'zz9(vdv_DGX,tp_VideoComm_Spec_9,Flag_tp_Spec[9],Matrix_PC_Spec [9],id_all_presset,Matrix_AdderLink_Pressets[9])
DEFINE_MODULE 'VideoComm_For_Spec'zz10(vdv_DGX,tp_VideoComm_Spec_10,Flag_tp_Spec[10],Matrix_PC_Spec [10],id_all_presset,Matrix_AdderLink_Pressets[10])
DEFINE_MODULE 'VideoComm_For_Spec'zz11(vdv_DGX,tp_VideoComm_Spec_11,Flag_tp_Spec[11],Matrix_PC_Spec [11],id_all_presset,Matrix_AdderLink_Pressets[11])
DEFINE_MODULE 'VideoComm_For_Spec'zz12(vdv_DGX,tp_VideoComm_Spec_12,Flag_tp_Spec[12],Matrix_PC_Spec [12],id_all_presset,Matrix_AdderLink_Pressets[12])
DEFINE_MODULE 'VideoComm_For_Spec'zz13(vdv_DGX,tp_VideoComm_Spec_13,Flag_tp_Spec[13],Matrix_PC_Spec [13],id_all_presset,Matrix_AdderLink_Pressets[13])
DEFINE_MODULE 'VideoComm_For_Spec'zz14(vdv_DGX,tp_VideoComm_Spec_14,Flag_tp_Spec[14],Matrix_PC_Spec [14],id_all_presset,Matrix_AdderLink_Pressets[14])
DEFINE_MODULE 'VideoComm_For_Spec'zz15(vdv_DGX,tp_VideoComm_Spec_15,Flag_tp_Spec[15],Matrix_PC_Spec [15],id_all_presset,Matrix_AdderLink_Pressets[15])
DEFINE_MODULE 'VideoComm_For_Spec'zz16(vdv_DGX,tp_VideoComm_Spec_16,Flag_tp_Spec[16],Matrix_PC_Spec [16],id_all_presset,Matrix_AdderLink_Pressets[16])
DEFINE_MODULE 'VideoComm_For_Spec'zz17(vdv_DGX,tp_VideoComm_Spec_17,Flag_tp_Spec[17],Matrix_PC_Spec [17],id_all_presset,Matrix_AdderLink_Pressets[17])
DEFINE_MODULE 'VideoComm_For_Spec'zz18(vdv_DGX,tp_VideoComm_Spec_18,Flag_tp_Spec[18],Matrix_PC_Spec [18],id_all_presset,Matrix_AdderLink_Pressets[18])
DEFINE_MODULE 'VideoComm_For_Spec'zz19(vdv_DGX,tp_VideoComm_Spec_19,Flag_tp_Spec[19],Matrix_PC_Spec [19],id_all_presset,Matrix_AdderLink_Pressets[19])
DEFINE_MODULE 'VideoComm_For_Spec'zz20(vdv_DGX,tp_VideoComm_Spec_20,Flag_tp_Spec[20],Matrix_PC_Spec [20],id_all_presset,Matrix_AdderLink_Pressets[20])
DEFINE_MODULE 'VideoComm_For_Spec'zz21(vdv_DGX,tp_VideoComm_Spec_21,Flag_tp_Spec[21],Matrix_PC_Spec [21],id_all_presset,Matrix_AdderLink_Pressets[21])
DEFINE_MODULE 'VideoComm_For_Spec'zz22(vdv_DGX,tp_VideoComm_Spec_22,Flag_tp_Spec[22],Matrix_PC_Spec [22],id_all_presset,Matrix_AdderLink_Pressets[22])
DEFINE_MODULE 'VideoComm_For_Spec'zz23(vdv_DGX,tp_VideoComm_Spec_23,Flag_tp_Spec[23],Matrix_PC_Spec [23],id_all_presset,Matrix_AdderLink_Pressets[23])
