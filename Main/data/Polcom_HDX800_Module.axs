MODULE_NAME='Polcom_HDX800_Module' (dev dv_VKS,
				    dev tp_VKS,
				    dev tp_VKS_keibord,
				    Integer Baude)

DEFINE_TYPE
STRUCTURE Polycom_Address_Book 
{
    Integer Number_in_book
    char Name[50]
    char Name_rus[200]
    char address[100]
    char type_addres[20]
    char Speed[20]
    char dob_Number[20]
}

STRUCTURE Control_Address_Book 
{
    Integer number
    Integer Kolvo_adress
    Char name[50]
    char Name_rus[200]
    Char nambers_in_book[20]
}

DEFINE_CONSTANT
Integer Max_Addres_in_panel = 10
Integer VKS_Kolvo_Zapisei_in_book = 100

DEFINE_MUTUALLY_EXCLUSIVE
([tp_VKS,1001],[tp_VKS,1002],[tp_VKS,1003],[tp_VKS,1004],[tp_VKS,1005],[tp_VKS,1006],[tp_VKS,1007],[tp_VKS,1008],[tp_VKS,1009],[tp_VKS,1010],
[tp_VKS,1011],[tp_VKS,1012],[tp_VKS,1013],[tp_VKS,1014],[tp_VKS,1015],[tp_VKS,1016],[tp_VKS,1017],[tp_VKS,1018],[tp_VKS,1019],[tp_VKS,1020],[tp_VKS,1021])

DEFINE_VARIABLE
VOLATILE Integer Volume
VOLATILE Integer i		// --- Флаг скорости обработки обратки, 0 - без задержки 

VOLATILE VKS_Buff[60000]
VOLATILE VKS_Buff_xml[60000]; Mini_buf_xml[6000]
VOLATILE VKS_mini[200]
VOLATILE VKS_Litle[200]

VOLATILE Polycom_Address_Book address_book[VKS_Kolvo_Zapisei_in_book]
VOLATILE Control_Address_Book main_address_book[VKS_Kolvo_Zapisei_in_book]
VOLATILE Polycom_Address_Book gaddress_book[VKS_Kolvo_Zapisei_in_book]
VOLATILE Control_Address_Book main_gaddress_book[VKS_Kolvo_Zapisei_in_book]
// --- матрица скоростей соединения
VOLATILE Call_Speed_array[100][10];VOLATILE Integer Max_Call_Speed; vks_speed[10];VOLATILE Diall_Speed[10];VOLATILE Integer Diall_Speed_Flag

VOLATILE Integer max_address, max_gaddress, max_top_address, max_top_gaddress, Max_Vks_PP, Int_Vks_PP, vks_addres_pp_pozotion, vks_string_aktive
VOLATILE Integer addres_read, gaddres_read, vks_n, vks_length, vks_i, vks_y, vks_flag, address_gaddess
VOLATILE Integer Button_vks, Presset_number, Flag_presset
VOLATILE uni_str_in[200]; VOLATILE uni_str_out[200]; VOLATILE uni_buff[20]; VOLATILE uni_str_out_111[200]				// --- имена в юникоде

VOLATILE Integer Flag_KeyPads			// --- Флаг обработки текста с клавиатуры

VOLATILE Integer addres_book_in_panel[20], line_address_book_active

Define_call 'Call_Speed_Opros'
{
    SEND_STRING dv_VKS,	"'exportprofile',$0D"
}
Define_call 'Call_Speed_FB'			// --- Обработка обратки скорости соединения
{
    STACK_VAR Char Call_Speed_Buff[10]
    Max_Call_Speed = 0
    REMOVE_STRING(VKS_mini,'speedstranslated,',1)
    WHILE(FIND_STRING(VKS_mini,"'~'",1))
    {
	Max_Call_Speed++
	Call_Speed_Buff = remove_string(VKS_mini,"'~'",1)
	Call_Speed_array[Max_Call_Speed] = LEFT_STRING(Call_Speed_Buff,(length_string(Call_Speed_Buff)) - 1)
    }
	Max_Call_Speed++
	Call_Speed_Buff = remove_string(VKS_mini,"$0D",1)
	Call_Speed_array[Max_Call_Speed] = LEFT_STRING(Call_Speed_Buff,(length_string(Call_Speed_Buff)) - 1)
    
    For (VKS_i  = 1 ; Vks_i <  21 ; Vks_i++)
    {
	If (Vks_i > Max_Call_Speed)
	{
	    SEND_COMMAND tp_VKS, "'^BMF-',itoa(vks_i + 2100),',0,%SW0'"
	}
	else
	{
	    SEND_COMMAND tp_VKS, "'^BMF-',itoa(vks_i + 2100),',0,%SW1'"
	    SEND_COMMAND tp_VKS,"'^TXT-',itoa(vks_i + 2100),',1&2,',Call_Speed_array[VKS_i]"
	}
    }
}
define_call 'otrisovka_address_book' (Integer book_start, Integer Book_kolvo)
{
    Max_Vks_PP = (max_top_address - 1)/Book_kolvo
    If ((max_top_address - 1)%Book_kolvo <> 0) Max_Vks_PP++
    Int_Vks_PP = book_start/Book_kolvo
    If (book_start%Book_kolvo <> 0) Int_Vks_PP++
    send_level tp_VKS, 1, (65535/Max_Vks_PP)*Int_Vks_PP
    send_level tp_VKS, 2, (65535/Max_Vks_PP)*(Int_Vks_PP-1)

    SEND_COMMAND tp_VKS,"'^TXT-1100,1&2,',itoa(Int_Vks_PP),' to ',itoa(Max_Vks_PP)"
    
    For(vks_i = 1 ; vks_i < (Book_kolvo + 1) ; vks_i++)
    {
	addres_book_in_panel[vks_i] =  vks_i + book_start - 1
	If (main_address_book[vks_i + book_start - 1].Name_rus = '')
	    SEND_COMMAND tp_VKS,"'^TXT-',itoa(vks_i + 1000),',1&2,',main_address_book[vks_i + book_start - 1].name"
	Else
	    SEND_COMMAND tp_VKS,"'^UNI-',itoa(vks_i + 1000),',1&2,',main_address_book[vks_i + book_start - 1].Name_rus"
    }
}
define_call 'otrisovka_gaddress_book' (Integer book_start, Integer Book_kolvo)
{
    Max_Vks_PP = (max_top_gaddress - 1)/Book_kolvo
    If ((max_top_gaddress - 1)%Book_kolvo <> 0) Max_Vks_PP++
    Int_Vks_PP = book_start/Book_kolvo
    If (book_start%Book_kolvo <> 0) Int_Vks_PP++
    send_level tp_VKS, 1, (65535/Max_Vks_PP)*Int_Vks_PP
    send_level tp_VKS, 2, (65535/Max_Vks_PP)*(Int_Vks_PP-1)

    SEND_COMMAND tp_VKS,"'^TXT-1100,1&2,',itoa(Int_Vks_PP),' to ',itoa(Max_Vks_PP)"
    
    For(vks_i = 1 ; vks_i < (Book_kolvo + 1) ; vks_i++)
    {
	addres_book_in_panel[vks_i] =  vks_i + book_start - 1
	SEND_COMMAND tp_VKS,"'^TXT-',itoa(vks_i + 1000),',1&2,',main_gaddress_book[vks_i + book_start - 1].name"
    }
}
DEFINE_CALL 'addres_read_p'
{
	remove_string(VKS_mini,"'addrbook '",1)
    vks_n = atoi(remove_string(VKS_mini,"' '",1)) + 1
    address_book[vks_n].Number_in_book = vks_n
    max_address = vks_n
	remove_string(VKS_mini,"'"'",1); VKS_Litle = remove_string(VKS_mini,"'"'",1); vks_length = length_string(VKS_Litle)
    address_book[vks_n].Name = 			left_string(VKS_Litle,vks_length - 1)
    address_book[vks_n].type_addres = 		remove_string(VKS_mini,"':'",1)
    address_book[vks_n].speed = MID_STRING(VKS_mini,1,(FIND_STRING(VKS_mini,"' '",1)) - 1); remove_string(VKS_mini,"' '",1)
	remove_string(VKS_mini,"':'",1)
	VKS_Litle = remove_string(VKS_mini,"' '",1); vks_length = length_string(VKS_Litle)
    address_book[vks_n].address = 		left_string(VKS_Litle,vks_length - 1)
    address_book[vks_n].dob_Number = VKS_mini    
}
DEFINE_CALL 'gaddres_read_p'
{
	remove_string(VKS_mini,"'gaddrbook '",1)
    vks_n = atoi(remove_string(VKS_mini,"' '",1)) + 1
    gaddress_book[vks_n].Number_in_book = vks_n
    max_gaddress = vks_n
	remove_string(VKS_mini,"'"'",1); VKS_Litle = remove_string(VKS_mini,"'"'",1); vks_length = length_string(VKS_Litle)
    gaddress_book[vks_n].Name = 			left_string(VKS_Litle,vks_length - 1)
    gaddress_book[vks_n].type_addres = 		remove_string(VKS_mini,"':'",1)
    gaddress_book[vks_n].speed = MID_STRING(VKS_mini,1,(FIND_STRING(VKS_mini,"' '",1)) - 1); remove_string(VKS_mini,"' '",1)
	remove_string(VKS_mini,"':'",1)
	VKS_Litle = remove_string(VKS_mini,"' '",1); vks_length = length_string(VKS_Litle)
    gaddress_book[vks_n].address = 		left_string(VKS_Litle,vks_length - 1)
    gaddress_book[vks_n].dob_Number = VKS_mini   
}
DEFINE_CALL 'addres_Read_xml'	// --- Начало обработки XML
{
    SEND_COMMAND tp_VKS,"'@PPF-Alert'"
   // "'0020 0031 0032 0033 0034 0035 0036 0037 0038 0039 0030'"
    WHILE(FIND_STRING(VKS_Buff_xml,'entrytype type="entry"',1))		
    {
	Mini_buf_xml = REMOVE_STRING(VKS_Buff_xml,'</entrytype>',1)
	max_address++
	address_book[max_address].Number_in_book = max_address - 0
	// --- Имя
	REMOVE_STRING(Mini_buf_xml,'name="',1)
	address_book[max_address].Name = mid_string(Mini_buf_xml,1,(FIND_STRING(Mini_buf_xml,"'"'",1)) - 1)
	// --- Русское имя
	If (FIND_STRING(Mini_buf_xml,'angid="Russia',1))
	{
	    REMOVE_STRING(Mini_buf_xml,'displayname="',1)
	    uni_str_out = asci_in_uni(mid_string(Mini_buf_xml,1,(FIND_STRING(Mini_buf_xml,"$0D",1)) - 1))
	    address_book[max_address].Name_rus = uni_str_out
	}
	// --- Тип соединения
	remove_string(Mini_buf_xml,'" name="',1);remove_string(Mini_buf_xml,'<',1)
	address_book[max_address].type_addres = mid_string(Mini_buf_xml,1,(FIND_STRING(Mini_buf_xml,"' '",1)) - 1)
	// --- Адресс
	remove_string(Mini_buf_xml,'"',1)
	address_book[max_address].address = mid_string(Mini_buf_xml,1,(FIND_STRING(Mini_buf_xml,"'"'",1)) - 1)
	// --- Скорость
	remove_string(Mini_buf_xml,'speed="',1)
	address_book[max_address].speed = mid_string(Mini_buf_xml,1,(FIND_STRING(Mini_buf_xml,"'"'",1)) - 1)
    }
    
    VKS_Buff_xml = ''
    CALL 'addres_comporeite'
}

DEFINE_FUNCTION char asci_in_uni(Char uni_asci_str[200])		// --- Перевод строки в UNI код
{
    uni_str_out = ''    
    WHILE(length_string(uni_asci_str))
    {
	If ((LEFT_STRING(uni_asci_str,1 = "$0D"))|(LEFT_STRING(uni_asci_str,1 = "$0A")))
	{
	    uni_asci_str = ''
	}
	Else 
	
	If (LEFT_STRING(uni_asci_str,1) = "'\'")
	{
	    uni_buff = ''
	    REMOVE_STRING(uni_asci_str,'\u',1)
	    uni_buff = left_string(uni_asci_str,4)
	    remove_string(uni_asci_str,uni_buff,1)
	    
	    uni_str_out = "uni_str_out,uni_buff"
	}
	else
	{
	    uni_buff = left_string(uni_asci_str,1)
	    remove_string(uni_asci_str,uni_buff,1)
	    
	    uni_str_out = "uni_str_out,RIGHT_STRING("'00',itohex(uni_buff)",4)"
	}
    }
    
    RETURN uni_str_out
}
DEFINE_CALL 'addres_comporeite'
{
    max_top_address = 0
    For (vks_i = 1 ; vks_i < max_address + 1 ; vks_i++)
    {
	vks_y = 1; vks_flag = 0
	while (vks_y < vks_i)
	{
	    if (main_address_book[vks_y].name = address_book[vks_i].Name)
	    {
		main_address_book[vks_y].Kolvo_adress++
		main_address_book[vks_y].nambers_in_book = "main_address_book[vks_y].nambers_in_book,itoa(address_book[vks_i].Number_in_book),':'"
		vks_flag++
	    }
	    
	    vks_y++
	}
	
	if (vks_flag = 0)
	{
	    if (max_top_address = 0) max_top_address = 1
	    main_address_book[max_top_address].number = max_top_address
	    main_address_book[max_top_address].Kolvo_adress++
	    main_address_book[max_top_address].name = address_book[vks_i].Name
	    main_address_book[max_top_address].Name_rus = address_book[vks_i].Name_rus
	    main_address_book[max_top_address].nambers_in_book = "itoa(address_book[vks_i].Number_in_book),':'"
	    max_top_address++
	}
    }
    
    SEND_COMMAND tp_VKS,"'@PPF-Alert'"
    call 'otrisovka_address_book' (1,Max_Addres_in_panel)
    vks_addres_pp_pozotion = 1
    vks_string_aktive = 0
}
DEFINE_CALL 'gaddres_comporeite'
{
    max_top_gaddress = 0
    For (vks_i = 1 ; vks_i < max_gaddress + 1 ; vks_i++)
    {
	vks_y = 1; vks_flag = 0
	while (vks_y < vks_i)
	{
	    if (main_gaddress_book[vks_y].name = gaddress_book[vks_i].Name)
	    {
		main_gaddress_book[vks_y].Kolvo_adress++
		main_gaddress_book[vks_y].nambers_in_book = "main_gaddress_book[vks_y].nambers_in_book,itoa(gaddress_book[vks_i].Number_in_book),':'"
		vks_flag++
	    }
	    
	    vks_y++
	}
	
	if (vks_flag = 0)
	{
	    if (max_top_gaddress = 0) max_top_gaddress = 1
	    main_gaddress_book[max_top_gaddress].number = max_top_gaddress
	    main_gaddress_book[max_top_gaddress].Kolvo_adress++
	    main_gaddress_book[max_top_gaddress].name = gaddress_book[vks_i].Name
	    main_gaddress_book[max_top_gaddress].nambers_in_book = "itoa(gaddress_book[vks_i].Number_in_book),':'"
	    max_top_gaddress++
	}
    }
    SEND_COMMAND tp_VKS,"'@PPF-Alert'"
    call 'otrisovka_gaddress_book' (1,Max_Addres_in_panel)
    vks_addres_pp_pozotion = 1
    vks_string_aktive = 0
}
DEFINE_CALL 'clear_addres'
{
    max_address = 0
    max_top_address = 1
    For (vks_i = 1 ; vks_i < VKS_Kolvo_Zapisei_in_book ; vks_i++)
    {
	address_book[vks_i].Name = ''
	address_book[vks_i].Number_in_book = 0
	address_book[vks_i].Speed = ''
	address_book[vks_i].address = ''
	address_book[vks_i].dob_Number = ''
	address_book[vks_i].type_addres = ''
	address_book[vks_i].Name_rus = ''
	
	main_address_book[vks_i].Kolvo_adress = 0
	main_address_book[vks_i].nambers_in_book = ''
	main_address_book[vks_i].name = ''
	main_address_book[vks_i].number = 0
	main_address_book[vks_i].Name_rus = ''
    }
}
DEFINE_CALL 'clear_gaddres'
{
    max_gaddress = 0
    max_top_gaddress = 1
    For (vks_i = 1 ; vks_i < VKS_Kolvo_Zapisei_in_book ; vks_i++)
    {
	gaddress_book[vks_i].Name = ''
	gaddress_book[vks_i].Number_in_book = 0
	gaddress_book[vks_i].Speed = ''
	gaddress_book[vks_i].address = ''
	gaddress_book[vks_i].dob_Number = ''
	gaddress_book[vks_i].type_addres = ''
	gaddress_book[vks_i].Name_rus = ''
	
	main_gaddress_book[vks_i].Kolvo_adress = 0
	main_gaddress_book[vks_i].nambers_in_book = ''
	main_gaddress_book[vks_i].name = ''
	main_gaddress_book[vks_i].number = 0
    }
}

DEFINE_CALL 'VKS_FB'				// --- Фидбек от девайса ---
{
    If (FIND_STRING(VKS_Buff,"$0D",1))
    {
	VKS_mini = remove_string(VKS_Buff,"$0D",1)
	
	If (LEFT_STRING(VKS_mini,1) = "$0A")	{REMOVE_STRING(VKS_mini,"$0A",1)}
	
	If ((addres_read = 2)&((LEFT_STRING(VKS_mini,1) = "' '")|(LEFT_STRING(VKS_mini,1) = "'<'")|(LEFT_STRING(VKS_mini,1) = "'"'")))
	    {VKS_Buff_xml = "VKS_Buff_xml,VKS_mini"}
	
	Else If (VKS_mini = "'addrbook all',$0A,$0D")		{addres_read = 1; CALL 'clear_addres'; max_address = 0}
	else If (VKS_mini = "'gaddrbook all',$0A,$0D")		{gaddres_read = 1; CALL 'clear_gaddres'; max_gaddress = 0}
	else If (VKS_mini = "'addrbook all done',$0D")		{addres_read = 0; CALL 'addres_comporeite'; address_gaddess = 1}
	else If (VKS_mini = "'gaddrbook all done',$0D")		{gaddres_read = 0; CALL 'gaddres_comporeite'; address_gaddess = 2}
	
	// --- XML ---
	Else If (VKS_mini = "'exportdirectory started',$0D")	{addres_read = 2; CALL 'clear_addres'; max_address = 0; VKS_BUFF_XML = ''}
	Else If (VKS_mini = "'exportdirectory done',$0D")	{addres_read = 0; CALL 'addres_Read_xml'; address_gaddess = 1}
	
	else If ((addres_read = 1)&(LEFT_STRING(VKS_mini,9) = "'addrbook '"))		{call 'addres_read_p'}
	else If ((gaddres_read = 1)&(LEFT_STRING(VKS_mini,10) = "'gaddrbook '"))	{call 'gaddres_read_p'}
	
	else If (FIND_STRING(VKS_mini,"'speedstranslated,'",1))		{Call 'Call_Speed_FB'}
	
	Else If (VKS_mini = "'mute near on',$0D")	{[tp_VKS,7] = 1}
	Else If (VKS_mini = "'mute near off',$0D")	{[tp_VKS,7] = 0}
	
	    // --- Обратка запуска контента, все возможные реакции
	    Else If (VKS_mini = "'vcbutton play',$0D")	{[tp_VKS,16] = 1;[tp_VKS,17] = 0;}//send_command vdv_VKS,"'Content_on',$0D"}
	    Else If (VKS_mini = "'vcbutton stop',$0D")	{[tp_VKS,17] = 1;[tp_VKS,16] = 0;}//send_command vdv_VKS,"'Content_off',$0D"}
    
	    Else If (VKS_mini = "'Control event: vcbutton play ',$0D")	{[tp_VKS,16] = 1;[tp_VKS,17] = 0;}//send_command vdv_VKS,"'Content_on',$0D"}
	    Else If (VKS_mini = "'Control event: vcbutton stop ',$0D")	{[tp_VKS,17] = 1;[tp_VKS,16] = 0;}//send_command vdv_VKS,"'Content_off',$0D"}
    
	    Else If (VKS_mini = "'info:already active',$0D")	{[tp_VKS,16] = 1;[tp_VKS,17] = 0;}//send_command vdv_VKS,"'Content_on',$0D"}
	    Else If (VKS_mini = "'info:already stopped',$0D")	{[tp_VKS,17] = 1;[tp_VKS,16] = 0;}//send_command vdv_VKS,"'Content_off',$0D"}
	
	Else If (LEFT_STRING(VKS_mini,7) = "'volume '")	
	{
	    if (VKS_mini = "'volume 0',$0D")
		{
		    Volume = 0
		    send_level tp_vks, 101, Volume
		    send_command tp_vks,"'^TXT-101,1&2,',itoa(Volume)"
		} 
	    Else 
		{
		    Volume = atoi(VKS_mini)
		    if (Volume)
		    {
			send_level tp_vks, 101, Volume
			send_command tp_vks,"'^TXT-101,1&2,',itoa(Volume)"
		    }
		}
	}
	
	VKS_mini = ''
    }
    ELSE
	if (length_string(VKS_Buff)=0)
	    i = 100
}
DEFINE_CALL 'address_Propetise'			// --- Отрисовка Всех адресов контакта
{
    STACK_VAR integer vks_i1
    STACK_VAR integer vks_num_1
    STACK_VAR char vks_str_1[20]
    
    Vks_str_1 = main_address_book[addres_book_in_panel[vks_string_aktive]].nambers_in_book	
    SEND_COMMAND tp_VKS,"'^TXT-2000,1&2,',main_address_book[addres_book_in_panel[vks_string_aktive]].Name"
    For (vks_i = 1 ; vks_i < 4 ; vks_i++)
    {
	vks_i1 = main_address_book[addres_book_in_panel[vks_string_aktive]].Kolvo_adress	// --- кол-во записей
	If (vks_i > vks_i1)	// --- Выключаем батонны
	{
	    SEND_COMMAND tp_VKS, "'^BMF-200',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-201',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-202',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-203',itoa(vks_i),',0,%SW0'"
	}
	Else			// --- Включаем батоны + отрисовка
	{
	    SEND_COMMAND tp_VKS, "'^BMF-200',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-201',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-202',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-203',itoa(vks_i),',0,%SW1'"
	    
	    vks_num_1 = atoi(remove_string(vks_str_1,':',1))
	    SEND_COMMAND tp_VKS,"'^TXT-203',itoa(vks_i),',1&2,',address_book[vks_num_1].address"
	    SEND_COMMAND tp_VKS,"'^TXT-202',itoa(vks_i),',1&2,',address_book[vks_num_1].Speed"
	    SEND_COMMAND tp_VKS,"'^TXT-201',itoa(vks_i),',1&2,',address_book[vks_num_1].type_addres"
	    
	}
    }
}
DEFINE_CALL 'gaddress_Propetise'		// --- Отрисовка Всех адресов контакта
{
    STACK_VAR integer vks_i1
    STACK_VAR integer vks_num_1
    STACK_VAR char vks_str_1[20]
    
    Vks_str_1 = main_gaddress_book[addres_book_in_panel[vks_string_aktive]].nambers_in_book	
    SEND_COMMAND tp_VKS,"'^TXT-2000,1&2,',main_gaddress_book[addres_book_in_panel[vks_string_aktive]].Name"
    For (vks_i = 1 ; vks_i < 4 ; vks_i++)
    {
	vks_i1 = main_gaddress_book[addres_book_in_panel[vks_string_aktive]].Kolvo_adress	// --- кол-во записей
	If (vks_i > vks_i1)	// --- Выключаем батонны
	{
	    SEND_COMMAND tp_VKS, "'^BMF-200',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-201',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-202',itoa(vks_i),',0,%SW0'"
	    SEND_COMMAND tp_VKS, "'^BMF-203',itoa(vks_i),',0,%SW0'"
	}
	Else			// --- Включаем батоны + отрисовка
	{
	    SEND_COMMAND tp_VKS, "'^BMF-200',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-201',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-202',itoa(vks_i),',0,%SW1'"
	    SEND_COMMAND tp_VKS, "'^BMF-203',itoa(vks_i),',0,%SW1'"
	    
	    vks_num_1 = atoi(remove_string(vks_str_1,':',1))
	    SEND_COMMAND tp_VKS,"'^TXT-203',itoa(vks_i),',1&2,',gaddress_book[vks_num_1].address"
	    SEND_COMMAND tp_VKS,"'^TXT-202',itoa(vks_i),',1&2,',gaddress_book[vks_num_1].Speed"
	    SEND_COMMAND tp_VKS,"'^TXT-201',itoa(vks_i),',1&2,',gaddress_book[vks_num_1].type_addres"
	    
	}
    }
}
DEFINE_CALL 'Call_address'  (integer number_call)
{
    STACK_VAR integer vks_num_1
    STACK_VAR char vks_str_1[20]
    STACK_VAR char vks_str_2[20]
    
    Vks_str_1 = main_address_book[addres_book_in_panel[vks_string_aktive]].nambers_in_book		// --- строка с адресами
    
    For(Vks_i = 1 ; vks_i < number_call+1 ; Vks_i++)
    {
	vks_str_2 = remove_string(Vks_str_1,':',1)
    }
    
    If (Diall_Speed_Flag = number_call)	// --- Вызов с изменённой скоростью
	SEND_STRING dv_VKS, "'dial auto ',Diall_Speed,' ',address_book[atoi(vks_str_2)].address,$0D"
    ELSE				// --- Вызов со стондартной скоростью
	SEND_STRING dv_VKS, "'dial auto ',address_book[atoi(vks_str_2)].Speed,' ',address_book[atoi(vks_str_2)].address,$0D"
}
DEFINE_CALL 'Call_gaddress' (integer number_call)
{
    STACK_VAR integer vks_num_1
    STACK_VAR char vks_str_1[20]
    STACK_VAR char vks_str_2[20]
    
    Vks_str_1 = main_gaddress_book[addres_book_in_panel[vks_string_aktive]].nambers_in_book		// --- строка с адресами
    
    For(Vks_i = 1 ; vks_i < number_call+1 ; Vks_i++)
    {
	vks_str_2 = remove_string(Vks_str_1,':',1)
    }

    If (Diall_Speed_Flag = number_call)	// --- Вызов с изменённой скоростью
	SEND_STRING dv_VKS, "'dial auto ',Diall_Speed,' ',gaddress_book[atoi(vks_str_2)].address,$0D"
    ELSE				// --- Вызов со стондартной скоростью
	SEND_STRING dv_VKS, "'dial auto ',gaddress_book[atoi(vks_str_2)].Speed,' ',gaddress_book[atoi(vks_str_2)].address,$0D"
}

DEFINE_START

CREATE_BUFFER dv_VKS, VKS_Buff
if (vks_speed='')
    vks_speed = 'Auto'
SEND_COMMAND tp_VKS,"'^TXT-1000,1&2,',vks_speed"


DEFINE_EVENT
DATA_EVENT[dv_VKS]			// --- онлайн девайса
{
    ONLINE:
    {
	SWITCH(Baude)
	{
	    Case 1:{SEND_COMMAND dv_VKS,"'SET BAUD 9600,N,8,1 485 DINABLE'"}	// --- default ---
	    Case 2:{SEND_COMMAND dv_VKS,"'SET BAUD 115200,N,8,1 485 DINABLE'"}
	}
	
	call 'Call_Speed_Opros'
	Wait (20)
	{
	    SEND_STRING dv_VKS, "'all register',$0D"
	    SEND_STRING dv_VKS, "'mute registr',$0D"
	    
	    SEND_STRING dv_VKS, "'mute near get',$0D"
	    
	    SEND_STRING dv_VKS, "'vcbutton get',$0D"
	}
    }
    String:
    {
	CANCEL_WAIT 'Wait_FB'
	i = 0
    }
}
DATA_EVENT[tp_VKS_keibord]		// --- ручной вызов с клавиатуры
{
    ONLINE:
    {
	Wait(10)
	{
	    SEND_STRING dv_VKS, "'mute near get',$0D"
	    SEND_STRING dv_Vks, "'volume get',$0D"
	}
	//call 'Call_Speed_Opros'
    }
    STRING:
    {
	If (Flag_KeyPads)
	{
	    if(find_string(DATA.TEXT,'KEYB-',1))
	    {
		remove_string(DATA.TEXT,'KEYB-',1)
		if(length_string(DATA.TEXT)) 
		{
		    if(find_string(DATA.TEXT,'ABORT',1)){}
		    Else
		    {
			send_string dv_VKS,"'dial auto ',vks_speed,' ',data.text,$0D"	//dial auto “speed” “dialstr”
		    }
		}
	    }
	    Flag_KeyPads = 0
	}
    }
}
DATA_EVENT[tp_VKS]			// --- строковое управление девайса + задатка скорости соединения ручного вызова
{
    string:
    {
	if (find_string(data.text,'set_speed',1))
	{
	    remove_string(data.text,'set_speed ',1)
	    vks_speed = data.text
	    SEND_COMMAND tp_VKS,"'^TXT-1000,1&2,',vks_speed"
	}	
	Else
	    send_string dv_VKS, "data.text,$0D"
    }
}
BUTTON_EVENT[tp_VKS,0]	// --- джойстик и пресеты // ++++ все остальное 
{
    PUSH:
    {
	Button_vks = button.input.channel
	
	SWITCH(Button_vks)
	{
	    Case 1:{send_string dv_VKS, "'camera near move up',$0D"}
	    Case 2:{send_string dv_VKS, "'camera near move down',$0D"}
	    Case 3:{send_string dv_VKS, "'camera near move right',$0D"}
	    Case 4:{send_string dv_VKS, "'camera near move left',$0D"}
	    
	    Case 5:{send_string dv_VKS, "'camera near move zoom+',$0D"}
	    Case 6:{send_string dv_VKS, "'camera near move zoom-',$0D"}
	    
	    Case 11:{send_string dv_VKS, "'camera near 1',$0D"}	
	    Case 12:{send_string dv_VKS, "'camera near 2',$0D"}	
	    
	    Case 13:{send_string dv_VKS, "'sleep',$0D"}
	    Case 14:{send_string dv_VKS, "'wake',$0D"}
	    
	    Case 50:{Flag_KeyPads = 1;SEND_COMMAND tp_VKS,"'^TXT-1000,1&2,',vks_speed"}
	}
	
	IF ((Button_vks > 100)&(Button_vks < 200))
	{
	    Presset_number = Button_vks - 100
	    Flag_presset = 1
	}
	
	Else IF (Button_vks = 1000)					// --- Опрос скорости соединения
	    Call 'Call_Speed_Opros'
	
	
	// --- Выбор строки в аресной книге
	Else IF ((Button_vks > 1000)&(Button_vks < 1022))		// --- Выбор строки в аресной книге
	{
	    Diall_Speed_Flag = 0	// --- Зануление выбора скорости
	    if (Button_vks = 1021)
		vks_string_aktive = 0
	    Else
		vks_string_aktive = Button_vks - 1000
		
	    If (address_gaddess = 1)
		Call 'address_Propetise'
	    Else If (address_gaddess = 2)
		CALL 'gaddress_Propetise'
	}
	
	// --- Листание списка адресов
	Else if (Button_vks = 1101)					// --- Листание списка адресов
	{
	    If (vks_addres_pp_pozotion < Max_Vks_PP) {vks_addres_pp_pozotion++}
	    
	    if (address_gaddess = 1){call 'otrisovka_address_book' ((vks_addres_pp_pozotion-1)*Max_Addres_in_panel+1,Max_Addres_in_panel)}
	    else if (address_gaddess = 2){call 'otrisovka_gaddress_book' ((vks_addres_pp_pozotion-1)*Max_Addres_in_panel+1,Max_Addres_in_panel)}
	    
	    Wait (2) DO_PUSH_TIMED(tp_VKS,1021,1)
	}
	Else if (Button_vks = 1102)					
	{
	    If (vks_addres_pp_pozotion > 1) {vks_addres_pp_pozotion--}
	    
	    if (address_gaddess = 1){call 'otrisovka_address_book' ((vks_addres_pp_pozotion-1)*Max_Addres_in_panel+1,Max_Addres_in_panel)}
	    else if (address_gaddess = 2){call 'otrisovka_gaddress_book' ((vks_addres_pp_pozotion-1)*Max_Addres_in_panel+1,Max_Addres_in_panel)}
	    
	    Wait (2) DO_PUSH_TIMED(tp_VKS,1021,1)
	}
	
	Else IF ((Button_vks > 2000)&(Button_vks < 2004))		// --- Вызов по адресу контакта
	{
	    If (address_gaddess = 1)
		Call 'Call_address'  (Button_vks - 2000)
	    Else If (address_gaddess = 2)
		CALL 'Call_gaddress' (Button_vks - 2000)	
	}
	
	Else IF ((Button_vks > 2020)&(Button_vks < 2024))		// --- Выбор скорости соединения в адресной книге
	{
	    Call 'Call_Speed_Opros'
	    Diall_Speed_Flag = Button_vks - 2020
	}
	
	Else IF ((Button_vks > 2100)&(Button_vks < 2200))		// --- Выбор скорости соединения
	{
	    vks_speed = Call_Speed_array[Button_vks - 2100]
	    SEND_COMMAND tp_VKS,"'^TXT-1000,1&2,',vks_speed"
	    If (Diall_Speed_Flag > 0)
	    {
		Diall_Speed = vks_speed
		SEND_COMMAND tp_VKS,"'^TXT-202',itoa(Diall_Speed_Flag),',1&2,',vks_speed"
	    }
	}	
	
	
Else IF (Button_vks = 3999)
{
    uni_str_out_111 = asci_in_uni(uni_str_in)
}
    }
    Hold[20]:
    {
	IF ((Button_vks > 100)&(Button_vks < 200))
	{
	    Flag_presset = 0 
	    send_string dv_VKS, "'preset near set ',itoa(Presset_number),$0D"
	}
    }
    release:
    {
	SWITCH(Button_vks)
	{
	    Case 1:{send_string dv_VKS, "'camera near move stop',$0D"}
	    Case 2:{send_string dv_VKS, "'camera near move stop',$0D"}
	    Case 3:{send_string dv_VKS, "'camera near move stop',$0D"}
	    Case 4:{send_string dv_VKS, "'camera near move stop',$0D"}
	    
	    Case 5:{send_string dv_VKS, "'camera near move stop',$0D"}
	    Case 6:{send_string dv_VKS, "'camera near move stop',$0D"}	    
	}
	IF ((Button_vks > 100)&(Button_vks < 200))
	{
	    Flag_presset = 0 
	    send_string dv_VKS, "'preset near go ',itoa(Presset_number),$0D"
	}
    }
}
LEVEL_EVENT[tp_vks,102]		// --- Громкость кодека
{
    if (level.value>0)
	SEND_STRING dv_Vks, "'volume set ',itoa(level.value),$0D"
}
DEFINE_PROGRAM
WAIT(i) 'Wait_FB'
CALL 'VKS_FB'