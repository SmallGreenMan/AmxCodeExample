PROGRAM_NAME='2_2_Amplifair'

DEFINE_VARIABLE
VOLATILE Float Vol[3][8]
dev tp_Amp_For_1 [] =
{
    tp_Amp_1,
    tp_Amp_2,
    tp_Amp_3,
    tp_Amp_4,
    tp_Amp_5,
    tp_Amp_6,
    tp_Amp_7,
    tp_Amp_8
}
dev tp_Amp_For_2 [] =
{
    tp_Amp_9,
    tp_Amp_10,
    tp_Amp_11,
    tp_Amp_12,
    tp_Amp_13,
    tp_Amp_14,
    tp_Amp_15,
    tp_Amp_16
}
dev tp_Amp_For_3 [] =
{
    tp_Amp_17,
    tp_Amp_18,
    tp_Amp_19,
    tp_Amp_20,
    tp_Amp_21,
    tp_Amp_22,
    tp_Amp_23,
    tp_Amp_24
}

DEFINE_MODULE 'Amplifair_Kramer_Module' dv_amp_Com_1(dv_Amplifair_1,tp_Amp_For_1,Vol[1])
DEFINE_MODULE 'Amplifair_Kramer_Module' dv_amp_Com_2(dv_Amplifair_2,tp_Amp_For_2,Vol[2])
DEFINE_MODULE 'Amplifair_Kramer_Module' dv_amp_Com_3(dv_Amplifair_3,tp_Amp_For_3,Vol[3])

