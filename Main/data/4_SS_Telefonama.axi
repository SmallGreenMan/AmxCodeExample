PROGRAM_NAME='4_SS_Telefonama'


DEFINE_VARIABLE

dev dv_ss_all [] =
{
    dv_SS_1,
    dv_SS_2,
    dv_SS_3,
    dv_SS_4,
    dv_SS_5,
    dv_SS_6,
    dv_SS_7,
    dv_SS_8,
    dv_SS_9,
    dv_SS_10,
    dv_SS_11,
    dv_SS_12,
    dv_SS_13
}
// --------------------- 1
dev tp_SS_Spec_all_1 [] = {tp_SS_Spec_1_1,tp_SS_Spec_2_2}
dev tp_Key_Spec_all_1 [] = {tp_SS_Key_1_1,tp_SS_Key_2_2}
VOLATILE Char file_name_1 [20] = {'1_SS_Tel_Book'}
// --------------------- 2
dev tp_SS_Spec_all_2 [] = {tp_SS_Spec_3_1,tp_SS_Spec_4_2}
dev tp_Key_Spec_all_2 [] = {tp_SS_Key_3_1,tp_SS_Key_4_2}
VOLATILE Char file_name_2 [20] = {'2_SS_Tel_Book'}
// --------------------- 3
dev tp_SS_Spec_all_3 [] = {tp_SS_Spec_5_1,tp_SS_Spec_6_2}
dev tp_Key_Spec_all_3 [] = {tp_SS_Key_5_1,tp_SS_Key_6_2}
VOLATILE Char file_name_3 [20] = {'3_SS_Tel_Book'}
// --------------------- 4
dev tp_SS_Spec_all_4 [] = {tp_SS_Spec_7_1,tp_SS_Spec_8_2}
dev tp_Key_Spec_all_4 [] = {tp_SS_Key_7_1,tp_SS_Key_8_2}
VOLATILE Char file_name_4 [20] = {'4_SS_Tel_Book'}
// --------------------- 5
dev tp_SS_Spec_all_5 [] = {tp_SS_Spec_9_1,tp_SS_Spec_10_2}
dev tp_Key_Spec_all_5 [] = {tp_SS_Key_9_1,tp_SS_Key_10_2}
VOLATILE Char file_name_5 [20] = {'5_SS_Tel_Book'}
// --------------------- 6
dev tp_SS_Spec_all_6 [] = {tp_SS_Spec_11_1,tp_SS_Spec_12_2}
dev tp_Key_Spec_all_6 [] = {tp_SS_Key_11_1,tp_SS_Key_12_2}
VOLATILE Char file_name_6 [20] = {'6_SS_Tel_Book'}
// --------------------- 7
dev tp_SS_Spec_all_7 [] = {tp_SS_Spec_13_1,tp_SS_Spec_14_2}
dev tp_Key_Spec_all_7 [] = {tp_SS_Key_13_1,tp_SS_Key_14_2}
VOLATILE Char file_name_7 [20] = {'7_SS_Tel_Book'}
// --------------------- 8
dev tp_SS_Spec_all_8 [] = {tp_SS_Spec_15_1,tp_SS_Spec_16_2}
dev tp_Key_Spec_all_8 [] = {tp_SS_Key_15_1,tp_SS_Key_16_2}
VOLATILE Char file_name_8 [20] = {'8_SS_Tel_Book'}
// --------------------- 9
dev tp_SS_Spec_all_9 [] = {tp_SS_Spec_17_1,tp_SS_Spec_18_2}
dev tp_Key_Spec_all_9 [] = {tp_SS_Key_17_1,tp_SS_Key_18_2}
VOLATILE Char file_name_9 [20] = {'9_SS_Tel_Book'}
// --------------------- 10
dev tp_SS_Spec_all_10 [] = {tp_SS_Spec_19_1,tp_SS_Spec_20_2}
dev tp_Key_Spec_all_10 [] = {tp_SS_Key_19_1,tp_SS_Key_20_2}
VOLATILE Char file_name_10 [20] = {'10_SS_Tel_Book'}
// --------------------- 11
dev tp_SS_Spec_all_11 [] = {tp_SS_Spec_21_1,tp_SS_Spec_22_2}
dev tp_Key_Spec_all_11 [] = {tp_SS_Key_21_1,tp_SS_Key_22_2}
VOLATILE Char file_name_11 [20] = {'11_SS_Tel_Book'}
// --------------------- 12
dev tp_SS_Spec_all_12 [] = {tp_SS_Raznov,tp_SS_17_1}
dev tp_Key_Spec_all_12 [] = {tp_SS_Raznov_Key,tp_Key_17_1}
VOLATILE Char file_name_12 [20] = {'12_SS_Tel_Book'}
// --------------------- 13
dev tp_SS_Spec_all_13 [] = {tp_SS_Vip,tp_SS_Spec_23_1,tp_SS_Ipad}
dev tp_Key_Spec_all_13 [] = {tp_SS_Vip_Key,tp_SS_Key_23_1}
VOLATILE Char file_name_13 [20] = {'13_SS_Tel_Book'}


DEFINE_START
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// --------------------- 1

DEFINE_MODULE '4_SS_Telefonama_Module' SS_1(	dv_SS_1,
						tp_SS_Spec_all_1,
						tp_Key_Spec_all_1,
						file_name_1)
// --------------------- 2
DEFINE_MODULE '4_SS_Telefonama_Module' SS_2(	dv_SS_2,
						tp_SS_Spec_all_2,
						tp_Key_Spec_all_2,
						file_name_2)
// --------------------- 3
DEFINE_MODULE '4_SS_Telefonama_Module' SS_3(	dv_SS_3,
						tp_SS_Spec_all_3,
						tp_Key_Spec_all_3,
						file_name_3)
// --------------------- 4
DEFINE_MODULE '4_SS_Telefonama_Module' SS_4(	dv_SS_4,
						tp_SS_Spec_all_4,
						tp_Key_Spec_all_4,
						file_name_4)
// --------------------- 5
DEFINE_MODULE '4_SS_Telefonama_Module' SS_5(	dv_SS_5,
						tp_SS_Spec_all_5,
						tp_Key_Spec_all_5,
						file_name_5)
// --------------------- 6
DEFINE_MODULE '4_SS_Telefonama_Module' SS_6(	dv_SS_6,
						tp_SS_Spec_all_6,
						tp_Key_Spec_all_6,
						file_name_6)
// --------------------- 7
DEFINE_MODULE '4_SS_Telefonama_Module' SS_7(	dv_SS_7,
						tp_SS_Spec_all_7,
						tp_Key_Spec_all_7,
						file_name_7)
// --------------------- 8
DEFINE_MODULE '4_SS_Telefonama_Module' SS_8(	dv_SS_8,
						tp_SS_Spec_all_8,
						tp_Key_Spec_all_8,
						file_name_8)
// --------------------- 9
DEFINE_MODULE '4_SS_Telefonama_Module' SS_9(	dv_SS_9,
						tp_SS_Spec_all_9,
						tp_Key_Spec_all_9,
						file_name_9)
// --------------------- 10
DEFINE_MODULE '4_SS_Telefonama_Module' SS_10(	dv_SS_10,
						tp_SS_Spec_all_10,
						tp_Key_Spec_all_10,
						file_name_10)
// --------------------- 11
DEFINE_MODULE '4_SS_Telefonama_Module' SS_11(	dv_SS_11,
						tp_SS_Spec_all_11,
						tp_Key_Spec_all_11,
						file_name_11)
// --------------------- 12
DEFINE_MODULE '4_SS_Telefonama_Module' SS_12(	dv_SS_12,
						tp_SS_Spec_all_12,
						tp_Key_Spec_all_12,
						file_name_12)
// --------------------- 13
DEFINE_MODULE '4_SS_Telefonama_Module' SS_13(	dv_SS_13,
						tp_SS_Spec_all_13,
						tp_Key_Spec_all_13,
						file_name_13)
						