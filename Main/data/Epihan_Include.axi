PROGRAM_NAME='Epihan_Include'


DEFINE_START
COMBINE_DEVICES(tp_Epihan_Op_1,tp_Epihan_VIP_1,tp_Epihan_Raz_1,tp_Epihan_Gref_1)
COMBINE_DEVICES(tp_Epihan_Op_2,tp_Epihan_VIP_2,tp_Epihan_Raz_2,tp_Epihan_Gref_2)


DEFINE_MODULE 'Epihan_Module' Ep_1(dv_Epifan_2,tp_Epihan_Op_1)
DEFINE_MODULE 'Epihan_Module_NEW' Ep_2(dv_Epifan_1,tp_Epihan_Op_2)