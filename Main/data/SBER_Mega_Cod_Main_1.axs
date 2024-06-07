PROGRAM_NAME='SBER_Mega_Cod_Main_1'

DEFINE_DEVICE	// --- AdderLink ---
dv_ip_Adder = 0:6:0

    tp_Adder = 10050:85:1
    tp_adder_14 = 10014:85:1
    tp_adder_15 = 10015:85:1
    tp_adder_16 = 10016:85:1
    tp_adder_Raz = 10001:85:2
    
DEFINE_DEVICE	// --- VideoComm (DGX) ---
// --- VideoComm (DGX) ---
dv_DGX = 5001:1:1
vdv_DGX = 33079:1:1	// --- Комутация по средством вирутального девайса (xxxINxxxOUT)

    vdv_VideoForControl = 33081:1:1	// --- Виртуальынй девайс для выбора закладки управления\управления аудио комутацией в зависимости от видео коммутации
    
    vtp_Debug 	= 33077:1:1
    tp_Debug_17	= 10050:77:1
    tp_Debug_7 	= 10051:77:1
    tp_Debug_VideoWall 	= 10052:77:1
    
    // Для упаравления
    tp_VideoCom_17	= 10050:79:1
    tp_VideoCom_7 	= 10051:79:1
    tp_VideoCom_VideoWall= 10052:79:1
    tp_Vid_Com_Kab_Raz 	= 10001:79:2
    tp_Vid_Com_Kab_Gef 	= 10002:79:2
    tp_Vid_Com_Vip_1 	= 10003:79:2
    tp_Vid_Com_Vip_2 	= 10004:79:2
    tp_Vid_Com_Kab_Gef_2 = 10004:79:2
    
    // Для обратка
    vtp_VideoFB 	= 33078:1:1
    tp_VideoFB_17	= 10050:78:1
    tp_VideoFB_7 	= 10051:78:1
    tp_VideoFB_VideoWall= 10052:78:1
    tp_Vid_FB_Kab_Raz 	= 10001:78:2
    tp_Vid_FB_Kab_Gef 	= 10002:78:2
    tp_Vid_FB_Vip_1 	= 10003:78:2
    tp_Vid_FB_Vip_2 	= 10004:78:2
    tp_Vid_FB_Kab_Gef_2	= 10004:78:2
    
    // Обратка и управлнеие
    tp_VideoComm_Spec_1 = 10001:78:1
    tp_VideoComm_Spec_2 = 10002:78:1
    tp_VideoComm_Spec_3 = 10003:78:1
    tp_VideoComm_Spec_4 = 10004:78:1
    tp_VideoComm_Spec_5 = 10005:78:1
    tp_VideoComm_Spec_6 = 10006:78:1
    tp_VideoComm_Spec_7 = 10007:78:1
    tp_VideoComm_Spec_8 = 10008:78:1
    tp_VideoComm_Spec_9 = 10009:78:1
    tp_VideoComm_Spec_10 = 10010:78:1
    tp_VideoComm_Spec_11 = 10011:78:1
    tp_VideoComm_Spec_12 = 10012:78:1
    tp_VideoComm_Spec_13 = 10013:78:1
    tp_VideoComm_Spec_14 = 10014:78:1
    tp_VideoComm_Spec_15 = 10015:78:1
    tp_VideoComm_Spec_16 = 10016:78:1
    tp_VideoComm_Spec_17 = 10017:78:1
    tp_VideoComm_Spec_18 = 10018:78:1
    tp_VideoComm_Spec_19 = 10019:78:1
    tp_VideoComm_Spec_20 = 10020:78:1
    tp_VideoComm_Spec_21 = 10021:78:1
    tp_VideoComm_Spec_22 = 10022:78:1
    tp_VideoComm_Spec_23 = 10023:78:1


DEFINE_DEVICE	// --- VideoWall ---
// --- VideoWall ---
dv_VideoWall = 5001:3:1

    vtp_VideoWall 	= 33014:1:1
    TP_VideoWall_17   	= 10050:14:1
    TP_VideoWall_7 	= 10051:14:1
    TP_VideoWall_Stena  = 10052:14:1
    
DEFINE_DEVICE	// --- Jupiter ---
// --- Jupiter ---
dv_Jupiter = 5001:2:1

   // vtp_Jupiter 	= 33015:1:1
    tp_Jupiter_17	= 10050:15:1
    tp_Jupiter_7 	= 10051:15:1
    TP_Jupiter_Stena    = 10052:15:1

DEFINE_DEVICE	// --- AudioMatrix ---
    tp_audio_micComToCodec_main	= 10050:83:1
    tp_audio_micComToCodec_Vip	= 10003:83:2
// --- AudioMatrix ---
dv_AudioMatrix = 5001:4:1
//dv_AudioMatrix_2 = 5001:6:1

    vtp_Debug_audio 	= 33067:1:1
    tp_Debug_audio_17	= 10050:66:1
    tp_Debug_audio_7 	= 10051:66:1
    
    vtp_Audio		= 33068:1:1		// Для коммутации через виртуальный девайс
    tp_Audio_ws_1	= 10001:67:1
    tp_Audio_ws_2	= 10002:67:1
    tp_Audio_ws_3	= 10003:67:1
    tp_Audio_ws_4	= 10004:67:1
    tp_Audio_ws_5	= 10005:67:1
    tp_Audio_ws_6	= 10006:67:1
    tp_Audio_ws_7	= 10007:67:1
    tp_Audio_ws_8	= 10008:67:1
    tp_Audio_ws_9	= 10009:67:1
    tp_Audio_ws_10	= 10010:67:1
    tp_Audio_ws_11	= 10011:67:1
    tp_Audio_ws_12	= 10012:67:1
    tp_Audio_ws_13	= 10013:67:1
    tp_Audio_ws_14	= 10014:67:1
    tp_Audio_ws_15	= 10015:67:1
    tp_Audio_ws_16	= 10016:67:1
    tp_Audio_ws_17	= 10017:67:1
    tp_Audio_ws_18	= 10018:67:1
    tp_Audio_ws_19	= 10019:67:1
    tp_Audio_ws_20	= 10020:67:1
    tp_Audio_ws_21	= 10021:67:1
    tp_Audio_ws_22	= 10022:67:1
    tp_Audio_ws_23	= 10023:67:1
    tp_Audio_Oper	= 10050:67:1	// --- Оператор
    tp_Audio_Raznov	= 10001:82:2	//10050:82:1	//10001:67:2	// --- Ражнов
    tp_Audio_Gref	= 10002:67:2	// --- Греф
    tp_Audio_VIP	= 10003:67:2	// --- VIP
    tp_Audio_CUP_COD	= 10052:67:1	// --- COD
    tp_Audio_CUP	= 10050:73:1	// --- MainTP CUP
    tp_Audio_MAIN_SC	= 10050:74:1	// --- MainTP SC
    tp_Audio_MAIN_5_35	= 10050:75:1	// --- MainTP 5.37
    tp_Audio_VKS_1	= 10050:69:1	// --- VKS 1	5.35
    tp_Audio_VKS_2	= 10050:70:1	// --- VKS 2	5.37
    tp_Audio_VKS_3	= 10050:71:1	// --- VKS 3	СЦ
    tp_Audio_VKS_4	= 10050:72:1	// --- VKS 4	ЦУП
    tp_Audio_VideoWall	= 10052:67:1	// --- VideoWall Panel
    

    tp_Audio_ws_vol_1	= 10001:68:1
    tp_Audio_ws_vol_2	= 10002:68:1
    tp_Audio_ws_vol_3	= 10003:68:1
    tp_Audio_ws_vol_4	= 10004:68:1
    tp_Audio_ws_vol_5	= 10005:68:1
    tp_Audio_ws_vol_6	= 10006:68:1
    tp_Audio_ws_vol_7	= 10007:68:1
    tp_Audio_ws_vol_8	= 10008:68:1
    tp_Audio_ws_vol_9	= 10009:68:1
    tp_Audio_ws_vol_10	= 10010:68:1
    tp_Audio_ws_vol_11	= 10011:68:1
    tp_Audio_ws_vol_12	= 10012:68:1
    tp_Audio_ws_vol_13	= 10013:68:1
    tp_Audio_ws_vol_14	= 10014:68:1
    tp_Audio_ws_vol_15	= 10015:68:1
    tp_Audio_ws_vol_16	= 10016:68:1
    tp_Audio_ws_vol_17	= 10017:68:1
    tp_Audio_ws_vol_18	= 10018:68:1
    tp_Audio_ws_vol_19	= 10019:68:1
    tp_Audio_ws_vol_20	= 10020:68:1
    tp_Audio_ws_vol_21	= 10021:68:1
    tp_Audio_ws_vol_22	= 10022:68:1
    tp_Audio_ws_vol_23	= 10023:68:1
    tp_Audio_Oper_vol	= 10050:68:1	// --- Оператор  
    tp_Audio_Raznov_vol	= 10001:68:2	// --- Ражнов
    tp_Audio_Gref_vol	= 10002:68:2	// --- Греф
    tp_Audio_VIP_vol	= 10003:68:2	// --- VIP   
    tp_Audio_CUP_vol	= 10052:68:1	// --- CUP  
    tp_Audio_Gref_vol_2	= 10004:68:2	// --- Греф
    
DEFINE_DEVICE	// --- Усилители ---
// --- Усилители ---
dv_Amplifair_1 = 44:1:1
dv_Amplifair_2 = 44:2:1
dv_Amplifair_3 = 45:1:1

    tp_Amp_1 = 10001:63:1
    tp_Amp_2 = 10002:63:1
    tp_Amp_3 = 10003:63:1
    tp_Amp_4 = 10004:63:1
    tp_Amp_5 = 10005:63:1
    tp_Amp_6 = 10006:63:1
    tp_Amp_7 = 10007:63:1
    tp_Amp_8 = 10008:63:1
    tp_Amp_9 = 10009:63:1
    tp_Amp_10 = 10010:63:1
    tp_Amp_11 = 10011:63:1
    tp_Amp_12 = 10012:63:1
    tp_Amp_13 = 10013:63:1
    tp_Amp_14 = 10014:63:1
    tp_Amp_15 = 10015:63:1
    tp_Amp_16 = 10016:63:1
    tp_Amp_17 = 10017:63:1
    tp_Amp_18 = 10018:63:1
    tp_Amp_19 = 10019:63:1
    tp_Amp_20 = 10020:63:1
    tp_Amp_21 = 10021:63:1
    tp_Amp_22 = 10022:63:1
    tp_Amp_23 = 10023:63:1
    tp_Amp_24 = 10024:63:1	// --- Пустая заглушка
    
DEFINE_DEVICE   // --- Polycom HDX---
// --- Polycom --- 3.35
dv_VKS_Kab_Raz = 37:1:2			// --- Кабинет Ражнова +
    
    tp_VKS_Kab_Raz = 10050:22:1
    
// --- Polycom --- 3.37
dv_VKS_Kab_Gref = 37:2:2			
    
    tp_VKS_Kab_Gref = 10050:23:1
    
// --- Polycom --- VIP
dv_VKS_VIP_Zona = 38:1:2		// --- Vip Зона
    
    tp_VKS_VIP_Zona 	 = 10050:24:1
    tp_VKS_VIP_Zona_Ipad = 10002:25:2
    tp_VKS_VIP_Zona_Wall = 10003:25:2

// --- Polycom --- ЦУП
dv_VKS = 5001:7:1
    
    tp_VKS = 10050:25:1
    tp_VKS_keibord = 10050:1:1
    

DEFINE_DEVICE   // --- Proector and lift
// --- Proector and lift
dv_lift = 5001:8:1
    
    vtp_lift		= 33028:1:1
    tp_Lift_Main 	= 10050:28:1
    tp_Lift_Vip		= 10003:28:2

    
DEFINE_DEVICE   // --- Видеокамеры Sony --- 
// --- Видеокамеры Sony ---
dv_cam_4 	= 00013:1:1 // -
dv_cam_5 	= 00013:2:1 // + 2 видео
dv_cam_2 	= 00014:1:1 // + 4 видео
dv_cam_3 	= 00014:2:1 // + 3 видео
dv_cam_6	= 00015:1:1 // -
dv_cam_1	= 00015:2:1 // + 5 Видео

dv_PultCam 	= 5001:5:1
vdv_Pult_For_Cam    = 33005:1:1	// Для управления пресетами камер // 1cam2get-set
vdv_Pult_not_For_Cam= 33005:2:1

    vtp_cam	= 33018:1:1
    tp_Cam_1	= 10050:18:1	// Operator
    tp_Cam_2	= 10001:18:2	// Ражнов
    tp_Cam_3	= 10003:18:2	// VIP
    tp_Cam_4	= 10002:18:2	// Gref
    tp_Cam_5	= 10051:18:1	// серверная
    
DEFINE_DEVICE	// --- Bosh конгресс система ---
// --- Bosh конгресс система ---
vdv_Bosh_for_Cam = 33051:1:1

    tp_Congress_Cam_op 	= 10050:51:1
    tp_Congress_Cam_VIP	= 10003:51:2
    tp_Congress_Cam_Raz	= 10001:51:2
    tp_Congress_Cam_Gref= 10002:51:2
    
DEFINE_DEVICE   // --- Bosch DCN ---
// --- Bosch DCN ---
dv_DCN = 5001:6:1

    vtp_DCN	= 33052:1:1
    tp_DCN_Op 	= 10050:52:1
    tp_DCN_vip	= 10003:52:2
    tp_DCN_Gref	= 10002:52:2
    
DEFINE_DEVICE	// --- Epihan ---
// --- Epihan --- 41-42
dv_Epifan_1 = 16:1:1

    tp_Epihan_Op_1 = 10050:41:1
    tp_Epihan_VIP_1= 10003:41:2
    tp_Epihan_Raz_1= 10001:41:2
    tp_Epihan_Gref_1= 10002:41:2
    
dv_Epifan_2 = 16:2:1

    tp_Epihan_Op_2 = 10050:42:1
    tp_Epihan_VIP_2= 10003:42:2
    tp_Epihan_Raz_2= 10001:42:2
    tp_Epihan_Gref_2= 10002:42:2
    
 
DEFINE_DEVICE	// --- Duna ---
// --- Duna ---
dv_Duna_1 	= 0:4:0
dv_Duna_2 	= 0:5:0

    vtp_Duna_1 		= 33038:1:1
    tp_Duna_1_Oper  	= 10050:38:1
    tp_Duna_2_Vip	= 10003:38:2
    tp_Duna_1_Raz	= 10001:38:2
    tp_Duna_1_Gref	= 10002:38:2
    
    vtp_Duna_2 		= 33039:1:1
    tp_Duna_2_Oper  	= 10050:39:1
    tp_Duna_1_Vip	= 10003:39:2
    tp_Duna_2_Raz	= 10001:39:2
    tp_Duna_2_Gref	= 10002:39:2
    
DEFINE_DEVICE   // --- SS Telefon --- 	
// --- Polycom SS Telefon ---
dv_SS_1 	= 37:1:1
dv_SS_2 	= 37:2:1
dv_SS_3 	= 38:1:1
dv_SS_4 	= 38:2:1
dv_SS_5 	= 39:1:1
dv_SS_6 	= 39:2:1
dv_SS_7 	= 40:1:1
dv_SS_8 	= 40:2:1
dv_SS_9 	= 41:1:1
dv_SS_10 	= 41:2:1
dv_SS_11 	= 42:1:1
dv_SS_12 	= 42:2:1
dv_SS_13 	= 43:1:1

    vtp_SS		= 33065:1:1
    tp_SS_17_1		= 10050:64:1
    tp_SS_17_2		= 10050:65:1
    
    tp_SS_Spec_1_1	= 10001:64:1
    tp_SS_Spec_2_2	= 10002:64:1
    tp_SS_Spec_3_1	= 10003:64:1
    tp_SS_Spec_4_2	= 10004:64:1
    tp_SS_Spec_5_1	= 10005:64:1
    tp_SS_Spec_6_2	= 10006:64:1
    tp_SS_Spec_7_1	= 10007:64:1
    tp_SS_Spec_8_2	= 10008:64:1
    tp_SS_Spec_9_1	= 10009:64:1
    tp_SS_Spec_10_2	= 10010:64:1
    tp_SS_Spec_11_1	= 10011:64:1
    tp_SS_Spec_12_2	= 10012:64:1
    tp_SS_Spec_13_1	= 10013:64:1
    tp_SS_Spec_14_2	= 10014:64:1
    tp_SS_Spec_15_1	= 10015:64:1
    tp_SS_Spec_16_2	= 10016:64:1
    tp_SS_Spec_17_1	= 10017:64:1
    tp_SS_Spec_18_2	= 10018:64:1
    tp_SS_Spec_19_1	= 10019:64:1
    tp_SS_Spec_20_2	= 10020:64:1
    tp_SS_Spec_21_1	= 10021:64:1
    tp_SS_Spec_22_2	= 10022:64:1
    tp_SS_Spec_23_1	= 10023:64:1
    tp_SS_Vip		= 10003:64:2
    tp_SS_Ipad		= 10002:64:2
    tp_SS_Raznov	= 10001:64:2
    
    tp_NOL_ss		= 10053:64:1
    
    
// --- KeyBoard All ---
    
    tp_Key_17_1		= 10050:1:1
    tp_Key_17_2		= 10051:1:1
    
    tp_SS_Key_1_1	= 10001:1:1
    tp_SS_Key_2_2	= 10002:1:1
    tp_SS_Key_3_1	= 10003:1:1
    tp_SS_Key_4_2	= 10004:1:1
    tp_SS_Key_5_1	= 10005:1:1
    tp_SS_Key_6_2	= 10006:1:1
    tp_SS_Key_7_1	= 10007:1:1
    tp_SS_Key_8_2	= 10008:1:1
    tp_SS_Key_9_1	= 10009:1:1
    tp_SS_Key_10_2	= 10010:1:1
    tp_SS_Key_11_1	= 10011:1:1
    tp_SS_Key_12_2	= 10012:1:1
    tp_SS_Key_13_1	= 10013:1:1
    tp_SS_Key_14_2	= 10014:1:1
    tp_SS_Key_15_1	= 10015:1:1
    tp_SS_Key_16_2	= 10016:1:1
    tp_SS_Key_17_1	= 10017:1:1
    tp_SS_Key_18_2	= 10018:1:1
    tp_SS_Key_19_1	= 10019:1:1
    tp_SS_Key_20_2	= 10020:1:1
    tp_SS_Key_21_1	= 10021:1:1
    tp_SS_Key_22_2	= 10022:1:1
    tp_SS_Key_23_1	= 10023:1:1
    tp_SS_Vip_Key	= 10003:1:2
    tp_SS_Ipad_Key	= 10002:1:2
    tp_SS_Raznov_Key	= 10001:1:2
    
    tp_NOL_Key_ss	= 10053:1:1
    
    
DEFINE_DEVICE   // --- TV AverTV --- 	
// --- TV AverTV ---
dv_tv_1	= 5001:12:2
dv_tv_2	= 5001:13:2
dv_tv_3	= 5001:14:2
dv_tv_4	= 5001:15:2
dv_tv_5	= 5001:16:2

    vtv_tv_1 = 33031:1:1
    tp_tv_1 = 10050:31:1
    tp_tv_1_vip = 10003:31:2
    tp_tv_1_Gref = 10002:31:2
    
    vtv_tv_2 = 33032:1:1
    tp_tv_2 = 10050:32:1
    tp_tv_2_Gref = 10002:32:2
    
    vtv_tv_3 = 33033:1:1
    tp_tv_3 = 10050:33:1
    
    vtv_tv_4 = 33034:1:1
    tp_tv_4 = 10050:34:1
    
    vtv_tv_5 = 33035:1:1
    tp_tv_5 = 10050:35:1
    
DEFINE_DEVICE	// --- PC Power ---
// --- 
dvPortPC = 0:2:0;    	 // 0:2:0 is the first available IP port, 0:3:0 is the next, etc.
dvIP = 0:3:0;
    TP_PowerPC_17 = 10050:93:1;  	 // The touch panel
    TP_PowerPC_Ipad = 10002:93:2


DEFINE_DEVICE   // --- System_status ---  // --- Setup_panel ---
//-----------------------------------------------------------------------------
// --- System_status ---
    // --- System_1
dv_Main_1	= 5001:1:1
dv_COM_in_main_1= 13:1:1
dv_COM_in_main_2= 14:1:1
dv_COM_in_main_3= 15:1:1
dv_COM_in_main_4= 16:1:1  

dv_COM_in_K1_1	= 37:1:1  
dv_COM_in_K1_2	= 38:1:1 
dv_COM_in_K1_3	= 39:1:1 
dv_COM_in_K1_4	= 40:1:1 
dv_COM_in_K1_5	= 41:1:1 
dv_COM_in_K1_6	= 42:1:1 
dv_COM_in_K1_7	= 43:1:1
dv_IO_in_K1_1	= 44:1:1
dv_REL_in_K1_1	= 45:1:1

    vtp_SystemStatus 		= 33077:1:1
    tp_SystemStatus_17		= 10050:97:1
    tp_SystemStatus_7_Debug	= 10051:97:1
    tp_SystemStatus_7_1		= 10001:97:1
    tp_SystemStatus_7_2		= 10002:97:1
    tp_SystemStatus_7_3		= 10003:97:1
    tp_SystemStatus_7_4		= 10004:97:1
    tp_SystemStatus_7_5		= 10005:97:1
    tp_SystemStatus_7_6		= 10006:97:1
    tp_SystemStatus_7_7		= 10007:97:1
    tp_SystemStatus_7_8		= 10008:97:1
    tp_SystemStatus_7_9		= 10009:97:1
    tp_SystemStatus_7_10	= 10010:97:1
    tp_SystemStatus_7_11	= 10011:97:1
    tp_SystemStatus_7_12	= 10012:97:1
    tp_SystemStatus_7_13	= 10013:97:1
    tp_SystemStatus_7_14	= 10014:97:1
    tp_SystemStatus_7_15	= 10015:97:1
    tp_SystemStatus_7_16	= 10016:97:1
    tp_SystemStatus_7_17	= 10017:97:1
    tp_SystemStatus_7_18	= 10018:97:1
    tp_SystemStatus_7_19	= 10019:97:1
    tp_SystemStatus_7_20	= 10020:97:1
    tp_SystemStatus_7_21	= 10021:97:1
    tp_SystemStatus_7_22	= 10022:97:1
    tp_SystemStatus_7_23	= 10023:97:1
    
    tp_SystemStatus_Raznov	= 10001:97:2
    tp_SystemStatus_Gref	= 10002:97:2
    tp_SystemStatus_VIP_Zona	= 10003:97:2
    tp_SystemStatus_VideoWall	= 10052:97:1
    
    // --- System_2
dv_Main_2	= 5001:1:2   
dv_COM_in_K2_1	= 13:1:2
dv_COM_in_K2_2	= 37:1:2
dv_COM_in_K2_3	= 38:1:2
dv_COM_in_K2_4	= 39:1:2   
dv_COM_in_K2_5	= 40:1:2   
dv_IO_in_K2_1	= 41:1:2
dv_REL_in_K2_1	= 42:1:2


    // --- System_3
dv_Main_3	= 5001:1:3  
    
    
// --- Setup_panel ---
    tp_Setup_1		= 10001:99:1
    tp_Setup_2		= 10002:99:1
    tp_Setup_3		= 10003:99:1
    tp_Setup_4		= 10004:99:1
    tp_Setup_5		= 10005:99:1
    tp_Setup_6		= 10006:99:1
    tp_Setup_7		= 10007:99:1
    tp_Setup_8		= 10008:99:1
    tp_Setup_9		= 10009:99:1
    tp_Setup_10		= 10010:99:1
    tp_Setup_11		= 10011:99:1
    tp_Setup_12		= 10012:99:1
    tp_Setup_13		= 10013:99:1
    tp_Setup_14		= 10014:99:1
    tp_Setup_15		= 10015:99:1
    tp_Setup_16		= 10016:99:1
    tp_Setup_17		= 10017:99:1
    tp_Setup_18		= 10018:99:1
    tp_Setup_19		= 10019:99:1
    tp_Setup_20		= 10020:99:1
    tp_Setup_21		= 10021:99:1
    tp_Setup_22		= 10022:99:1
    tp_Setup_23		= 10023:99:1
    tp_Setup_Oper	= 10050:99:1
    tp_Setup_Servernaia	= 10051:99:1
    tp_Setup_VideoWall	= 10052:99:1




DEFINE_VARIABLE
VOLATILE Integer HDX_Baud = 1	// 1 - 9600, 2 - 115200
VOLATILE Integer timer_online

DEFINE_START
COMBINE_DEVICES(tp_SS_Vip,tp_SS_Ipad)
set_pulse_time(1)

INCLUDE 'Power_PC'
INCLUDE 'AdderLink'

INCLUDE '2_3_Audio_Data'

INCLUDE '2_2_Amplifair'
INCLUDE 'VideoWall'
INCLUDE 'Camers'
INCLUDE '4_SS_Telefonama'
INCLUDE '7_Lift'
INCLUDE 'TV_AverMedia'
INCLUDE 'Dune_Include'
INCLUDE 'Epihan_Include'

INCLUDE '1_1_Video_DataBase'
INCLUDE 'Comm_Video'
INCLUDE 'Comm_Audio'

INCLUDE 'Bosh_Congress'
INCLUDE 'Setup_Panel_setings_include'
INCLUDE 'Jupiter'
INCLUDE '9_System_Status'

// ------------------------- Модули -------------------------
// --- Polycom ---
DEFINE_MODULE 'Polcom_HDX800_Module' Poly4(dv_VKS_Kab_Raz,		// --- Polycom --- 3.35
					  tp_VKS_Kab_Raz,
					  tp_VKS_keibord,
					  HDX_Baud)
// --- Polycom ---
DEFINE_MODULE 'Polcom_HDX800_Module' Poly3(dv_VKS_Kab_Gref,		// --- Polycom --- 3.37
					  tp_VKS_Kab_Gref,
					  tp_VKS_keibord,
					  HDX_Baud)
// --- Polycom ---
DEFINE_MODULE 'Polcom_HDX800_Module' Poly2(dv_VKS_VIP_Zona,		// --- Polycom --- VIP
					  tp_VKS_VIP_Zona,
					  tp_VKS_keibord,
					  HDX_Baud)
// --- Polycom ---
DEFINE_MODULE 'Polcom_HDX800_Module' Poly1(dv_VKS,			// --- Polycom --- ЦУП
					  tp_VKS,
					  tp_VKS_keibord,
					  HDX_Baud)

DEFINE_PROGRAM
Wait(100)
    timer_online++
    
WAIT(36000)
{
  send_string dv_SS_12, "'set mute "Operator Mic_in" 0',$0d,$0a"  // Всегда снимаем MUTE с микрофона оператора каждый час
}