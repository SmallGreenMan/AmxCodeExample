PROGRAM_NAME='Dune_Include'

DEFINE_VARIABLE
CONSTANT CHAR Dune_1_ip[] = {'25.100.4.146'}
CONSTANT CHAR Dune_2_ip[] = {'25.100.4.147'}

DEFINE_START
COMBINE_DEVICES(vtp_Duna_1,tp_Duna_1_Oper,tp_Duna_1_Vip,tp_Duna_1_Raz,tp_Duna_1_Gref)
COMBINE_DEVICES(vtp_Duna_2,tp_Duna_2_Oper,tp_Duna_2_Vip,tp_Duna_2_Raz,tp_Duna_2_Gref)

DEFINE_MODULE 'Dune_Ip_Module' Dune_ip_1 (dv_Duna_1,vtp_Duna_1,Dune_1_ip)
DEFINE_MODULE 'Dune_Ip_Module' Dune_ip_2 (dv_Duna_2,vtp_Duna_2,Dune_2_ip)