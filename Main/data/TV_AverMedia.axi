PROGRAM_NAME='TV_AverMedia'
    
DEFINE_VARIABLE
dev dv_tv [] =
{
    dv_tv_1,
    dv_tv_2,
    dv_tv_3,
    dv_tv_4,
    dv_tv_5
}

dev tp_tv [] =
{
    vtv_tv_1,
    vtv_tv_2,
    vtv_tv_3,
    vtv_tv_4,
    vtv_tv_5
}
VOLATILE Integer tv_CM [] =
{
    3,
    4,
    1,
    2,
    5
}
   
    
DEFINE_START    
COMBINE_DEVICES(vtv_tv_1,tp_tv_1,tp_tv_1_vip,tp_tv_1_Gref)
COMBINE_DEVICES(vtv_tv_2,tp_tv_2,tp_tv_2_Gref)
COMBINE_DEVICES(vtv_tv_3,tp_tv_3)
COMBINE_DEVICES(vtv_tv_4,tp_tv_4)
COMBINE_DEVICES(vtv_tv_5,tp_tv_5)

DEFINE_MODULE 'TV_AverMedia_Module' tv1(dv_tv_3,vtv_tv_1)
DEFINE_MODULE 'TV_AverMedia_Module' tv2(dv_tv_4,vtv_tv_2)
DEFINE_MODULE 'TV_AverMedia_Module' tv3(dv_tv_1,vtv_tv_3)
DEFINE_MODULE 'TV_AverMedia_Module' tv4(dv_tv_2,vtv_tv_4)
DEFINE_MODULE 'TV_AverMedia_Module' tv5(dv_tv_5,vtv_tv_5)

