PROGRAM_NAME='Bosh_Congress'

DEFINE_VARIABLE
Dev All_tp_DCN [] =
{
    tp_DCN_Op,
    tp_DCN_vip,
    tp_DCN_Gref
}
DEFINE_START
COMBINE_DEVICES(tp_DCN_Op,tp_DCN_vip,tp_DCN_Gref)

DEFINE_MODULE 'DCN_Mudule_VAV' DCN(dv_DCN,
				   tp_DCN_Op,
				   vdv_Bosh_for_Cam)