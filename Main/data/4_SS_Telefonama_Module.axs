MODULE_NAME='4_SS_Telefonama_Module' (	dev dv,
					dev tp[],
					dev tp_key[],
					char File_name[50])
DEFINE_CONSTANT
Integer Kolvo_Addres_In_Panel = 8
Integer Kolvo_Addres = 56

DEFINE_TYPE
STRUCTURE Telefon_book
{
    CHAR Name[50]
    CHAR Number[20]
}

DEFINE_VARIABLE
// --- Телефон ---
VOLATILE buf[1000]
VOLATILE mini[100]
VOLATILE buf_key[2][100]
VOLATILE Last_Num_Call[2][20]
VOLATILE Last_Num_Call_mem[2][20]
VOLATILE Integer tel
VOLATILE Integer opros[2]
VOLATILE Integer pan_int		// --- Постоянная панели 

// --- Телефонная книга ---
Telefon_book book[2][Kolvo_Addres]
VOLATILE Integer Active_adress[2]	// --- Для обработки обратки текста с панелей
VOLATILE Integer Addres_Active[2]	// --- Активный адрес (для вызова и редактирования)
Integer Book_Addres_Active[2]		// --- Начальный адрес записной книжки на странице
VOLATILE Char text[5000]		// --- Буфер для записи в файл
VOLATILE Integer Phone_on_off_Flag[2]	// --- Поднята ли трубка

    VOLATILE CHAR delete_text[5000]



DEFINE_MUTUALLY_EXCLUSIVE


DEFINE_START
CREATE_BUFFER dv, buf
CREATE_BUFFER tp_key[1], buf_key[1]
CREATE_BUFFER tp_key[2], buf_key[2]
Book_Addres_Active[1] = 1;Book_Addres_Active[2] = 1

DEFINE_FUNCTION appendToFile (CHAR cFileName[],CHAR cLogString[])	// --- Запись в файл
{

   STACK_VAR SLONG slFileHandle                       // stores the tag that represents the file (or and error code)
   LOCAL_VAR SLONG slResult                           // stores the number of bytes written (or an error code)
   LOCAL_VAR SLONG Result                           // stores the number of bytes written (or an error code)

   slFileHandle = FILE_OPEN(cFileName,FILE_RW_NEW) // OPEN OLD FILE (OR CREATE NEW ONE)    

   IF(slFileHandle>0)                                 // A POSITIVE NUMBER IS RETURNED IF SUCCESSFUL
   {
         slResult = FILE_WRITE(slFileHandle,cLogString,LENGTH_STRING(cLogString)) // WRITE THE NEW INFO
         FILE_CLOSE(slFileHandle)                                                      // CLOSE THE LOG FILE
   }           
   ELSE
   {
         SEND_STRING 0,"'FILE OPEN ERROR:',ITOA(slFileHandle)"   // IF THE LOG FILE COULD NOT BE CREATED
   }
}


DEFINE_FUNCTION readStuffFromFile(CHAR cFileName[],CHAR oneline_new[])	// --- Чтение из файла
{
   STACK_VAR SLONG slFileHandle     
   STACK_VAR INTEGER INC 
   STACK_VAR SLONG slResult1
   STACK_VAR char oneline[5000]

   slFileHandle = FILE_OPEN(cFileName,FILE_READ_ONLY) // OPEN FILE FROM THE BEGINNING

   IF(slFileHandle>0)                                 // A POSITIVE NUMBER IS RETURNED IF SUCCESSFUL
   {
         slResult1 = 1                                 // seed with a good number so the loop runs at least once
         WHILE(slResult1>0)
	 {
            slResult1 = FILE_READ(slFileHandle,oneline,MAX_LENGTH_STRING(oneline)) // grab one line from the file
	    if (slResult1 > 0) oneline_new = oneline
         }
        FILE_CLOSE(slFileHandle)                    // CLOSE THE LOG FILE
   }           
   ELSE
   {
        SEND_STRING 0,"'FILE OPEN ERROR:',ITOA(slFileHandle)"  // IF THE LOG FILE COULD NOT BE CREATED
   }
}

DEFINE_FUNCTION otrisovka_address_book (Integer pan, Integer book_start)	// --- Отрисовка видимой части адрес бука
{
    local_var FLOAT Max_Vks_PP
    local_var FLOAT Int_Vks_PP
    local_var Integer vks_i
    
    Max_Vks_PP = (Kolvo_Addres - 1)/Kolvo_Addres_In_Panel
    If ((Kolvo_Addres - 1)%Kolvo_Addres_In_Panel <> 0) Max_Vks_PP++
    Int_Vks_PP = book_start/Kolvo_Addres_In_Panel
    If (book_start%Kolvo_Addres_In_Panel <> 0) Int_Vks_PP++
    send_level tp[pan], 1, (65535/Max_Vks_PP)*Int_Vks_PP
    send_level tp[pan], 2, (65535/Max_Vks_PP)*(Int_Vks_PP-1)

    For(vks_i = 1 ; vks_i < (Kolvo_Addres_In_Panel+1) ; vks_i++)
    {
	if ((book_start+vks_i-1) <= Kolvo_Addres)
	{
	    SEND_COMMAND tp[pan],"'^TXT-',itoa(vks_i+100),',0,',itoa(book_start+vks_i-1),'-',book[pan][book_start+vks_i-1].Name"
	    SEND_COMMAND tp[pan],"'^TXT-',itoa(vks_i+200),',0,',book[pan][book_start+vks_i-1].Number"
	}
	Else
	{
	    SEND_COMMAND tp[pan],"'^TXT-',itoa(vks_i+100),',0, '"
	    SEND_COMMAND tp[pan],"'^TXT-',itoa(vks_i+200),',0, '"
	}
    }
}

DEFINE_call 'Kill_Alert_Pupop_1'
{
    Wait (60) 'Incoming_Call_1'
	SEND_COMMAND tp[1],"'@PPK-SS_Telefon_Alert_Incoming_Call'" 
}
DEFINE_call 'Kill_Alert_Pupop_2'
{
    Wait (60) 'Incoming_Call_2'
	SEND_COMMAND tp[2],"'@PPK-SS_Telefon_Alert_Incoming_Call'" 
}

DEFINE_CALL 'FB'							// --- FB SS
{
    if (find_string(buf,"$0D",1))
    {
	mini = remove_string(buf,"$0D",1)
	select
	{
	    ACTIVE (find_string(mini,"'val phone_connect "Phone '",1)):		// --- Обратка поднятой трубки
	    { 
		remove_string(mini,"'val phone_connect "Phone '",1)//1 Out"'",1)
		tel = atoi(remove_string(mini,"'Out'",1))
		[tp[tel],23] = atoi(mini)
		Phone_on_off_Flag[tel] = atoi(mini)
	    }
	    ACTIVE (find_string(mini,"'val phone_ring "Phone '",1)):		// --- Входящий вызов
	    { 
		remove_string(mini,"'val phone_ring "Phone '",1)//1 Out"'",1)
		tel = atoi(remove_string(mini,"'In'",1))
		if (atoi(mini))
		{
		    if (tel=1){CANCEL_WAIT 'Incoming_Call_1';call 'Kill_Alert_Pupop_1'} else {CANCEL_WAIT 'Incoming_Call_2';call 'Kill_Alert_Pupop_2'}
		    SEND_COMMAND tp[tel],"'WAKE'"
		    SEND_COMMAND tp[tel],"'@PPN-SS_Telefon_Alert_Incoming_Call;Main'" 
		    
		    [tp[tel],24] = 1
		    SEND_COMMAND tp[tel],"'ADBEEP'"
		}
		else
		    wait(10)
			[tp[tel],24] = 0
	    }
	}
    }
}

DEFINE_FUNCTION Opros_SS (integer x)					// --- Опрос SS
{
    send_string dv,"'get phone_connect "Phone ',itoa(x),' Out"',$0D"
    send_string dv,"'get phone_connect "Phone ',itoa(x),' Out"',$0D"
    opros[x] = 0
}
DEFINE_FUNCTION Call_last_num (Integer y, char tel[30])			// --- Вызов по адресу
{
    send_string dv, "'set phone_connect "Phone ',itoa(y),' Out" 1',$0D"
    wait(10)
    {
	send_string dv, "'set phone_dial "Phone ',itoa(y),' Out" "',tel,'"',$0D"
	Last_Num_Call[y] = tel
    }
    send_command tp[y],"'^TXT-1,0,',tel"
}

Define_Call 'Memory_to_File' (Integer pan)				// --- Запись телефонной книги в файл
{
    STACK_VAR Integer a
    text = ''
    For (a=1;a<Kolvo_Addres+1;a++)
	text = "text,book[pan][a].Name,'$~',book[pan][a].Number,'~~'"
    appendToFile("File_name,'-Chenal-',itoa(pan),'.txt'",text)
}
Define_Call 'File_to_Memory' (Integer pan)				// --- Чтение телефонной книги из файла
{
    STACK_VAR Integer a
    STACK_VAR char mem[30]
    STACK_VAR Integer len
    text = ''
    readStuffFromFile("File_name,'-Chenal-',itoa(pan),'.txt'",text)
    delete_text = text
    if (length_string(text))
    {
	for (a=1;a<Kolvo_Addres+1;a++)
	{
	    mem = remove_string(text,"'$~'",1)
	    len = length_string(mem) - 2
	    if (len)
		book[pan][a].Name = left_string(mem,len)
	    mem = remove_string(text,"'~~'",1)
	    len = length_string(mem) - 2
	    if (len)
		book[pan][a].Number = left_string(mem,len)
	}
    }
}

DEFINE_EVENT
DATA_EVENT[dv]			// --- Инициализация порта SS
{
    online:
    {
	send_command dv,"'SET BAUD 9600,N,8,1 485 DINABLE'"
	opros[1]=1
	opros[2]=1
	WAIT(10)
	    Call 'File_to_Memory' (1)
	Wait (30)
	    Call 'File_to_Memory' (2)
    }
}
DATA_EVENT[tp]			// --- Инициализация панелей
{
    online:
    {
	pan_int = get_last(tp)
	opros[pan_int]=1
	    otrisovka_address_book (pan_int,Book_Addres_Active[pan_int])
    }
}
DATA_EVENT[tp_key]		// --- FB  Клавиатуры
{
    string:
    {
	stack_var integer pan
	pan = get_last(tp_key)
	IF(FIND_STRING(DATA.TEXT,'KEYB-',1))
	{
	    REMOVE_STRING(DATA.TEXT,'KEYB-',1)
	    {
		IF(FIND_STRING(DATA.TEXT,'ABORT',1)){}
		ELSE
		{
		    if (Active_adress[pan])
		    {
			book[pan][Active_adress[pan]].Name = DATA.TEXT
			send_command tp[pan],"'^TXT-',itoa(Active_adress[pan]+101-Book_Addres_Active[pan]),',0,',itoa(Active_adress[pan]),'-',DATA.TEXT"
			send_command tp[pan],"'^TXT-100,0,',itoa(Active_adress[pan]),'-',DATA.TEXT"
			Active_adress[pan]=0
			Call 'Memory_to_File' (pan)
		    }
		}
	    }
	}
	else 	IF(FIND_STRING(DATA.TEXT,'KEYP-',1))
	{
	    REMOVE_STRING(DATA.TEXT,'KEYP-',1)
	    {
		IF(FIND_STRING(DATA.TEXT,'ABORT',1)){}
		ELSE
		{
		    if (Active_adress[pan])
		    {
			book[pan][Active_adress[pan]].Number = DATA.TEXT
			send_command tp[pan],"'^TXT-',itoa(Active_adress[pan]+201-Book_Addres_Active[pan]),',0,',DATA.TEXT"
			send_command tp[pan],"'^TXT-200,0,',DATA.TEXT"
			Active_adress[pan]=0
			Call 'Memory_to_File' (pan)
		    }
		}
	    }
	}
    }
}

BUTTON_EVENT[tp,0]		// --- Баттоны управления Телефоном
{
    push:
    {
	STACK_VAR integer pan
	STACK_VAR integer bat
	
	pan = get_last(tp)
	bat = button.input.channel
	if (pan < 3)
	{
	if (bat < 11)			// --- Старый кейпад
	{
	    if (bat = 10) bat = 0
	    send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "',itoa(bat),'"',$0D"
	    Last_Num_Call[pan] = "Last_Num_Call[pan],itoa(bat)"
	}
	Else
	    If ((bat>49)&(bat<60)) 	// --- Новый кейпад
	    {
		Last_Num_Call[pan] = "Last_Num_Call[pan],itoa(bat-50)"
		send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
		If (Phone_on_off_Flag[pan])
		    send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "',itoa(bat-50),'"',$0D"
	    }
	    Else
	SWITCH(bat)
	{
	    case 11:
	    {
		send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "#"',$0D"
		Last_Num_Call[pan] = "Last_Num_Call[pan],'#'"
	    }
	    case 12:
	    {
		send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "*"',$0D"
		Last_Num_Call[pan] = "Last_Num_Call[pan],'*'"
	    }
	    
	    case 22:		// --- Положить трубку
	    {	
		send_string dv, "'set phone_connect "Phone ',itoa(pan),' Out" 1',$0D"
		send_string dv, "'set phone_connect "Phone ',itoa(pan),' Out" 0',$0D"
		Last_Num_Call[pan] = "''"
		send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
	    }
	    case 24:		// --- Вызов выбранного адреса
	    {	
		if (book[pan][Addres_Active[pan]].Number<>'')
		    Call_last_num (pan, book[pan][Addres_Active[pan]].Number)
	    }
	    case 21:		// --- Вызов последнего номера
	    {	
		Call_last_num (pan,Last_Num_Call_mem[pan])
	    }
 
	    case 60:
	    {
		Last_Num_Call[pan] = "Last_Num_Call[pan],'#'"
		send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
		If (Phone_on_off_Flag[pan])
		    send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "*"',$0D"
	    }
	    case 61:
	    {
		Last_Num_Call[pan] = "Last_Num_Call[pan],'*'"
		send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
		If (Phone_on_off_Flag[pan])
		    send_string dv, "'set phone_dial "Phone ',itoa(pan),' Out" "#"',$0D"
	    }

	    case 70:
	    {
		if (Phone_on_off_Flag[pan]=0)
		{
		    Last_Num_Call[pan] = "left_string(Last_Num_Call[pan],length_string(Last_Num_Call[pan])-1)"
		    send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
		}
	    }
	    case 71:
	    {
		send_string dv, "'set phone_connect "Phone ',itoa(pan),' Out" 0',$0D"
		Last_Num_Call[pan] = "''"
		send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
	    }
	    case 72:		// --- Вызов последнего набранного номера
	    {
		Call_last_num (pan,Last_Num_Call_mem[pan])
	    }
	    case 23:		// --- Взять и положить трубку
	    {	
		if (Phone_on_off_Flag[pan]=0)	// --- Если трубка лежит
		{
		    if (Last_Num_Call[pan]<>'')
		    {
			Call_last_num (pan,Last_Num_Call[pan])
			Last_Num_Call_mem[pan] = Last_Num_Call[pan]
		    }
		    Else
			send_string dv, "'set phone_connect "Phone ',itoa(pan),' Out" 1',$0D"
		}
		else				// --- Если трубка поднята
		{
		    send_string dv, "'set phone_connect "Phone ',itoa(pan),' Out" 0',$0D"
		    Last_Num_Call[pan] = "''"
		    send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
		}
	    }
	}
	
	if (Last_Num_Call[pan] <> '')
	    send_command tp[pan],"'^TXT-1,0,',Last_Num_Call[pan]"
	}
    }
}
BUTTON_EVENT[tp,0]		// --- Телефонная книга		
{
    PUSH:
    {
	STACK_VAR integer pan
	STACK_VAR integer bat
	
	pan = get_last(tp)
	bat = button.input.channel
	
	SELECT
	{
	    
	    ACTIVE ((bat>100)&(bat<Kolvo_Addres_In_Panel+101)):	// --- Вызов адреса
	    {
		Addres_Active[pan] = bat - 101 + Book_Addres_Active[pan]
		If (length_string(book[pan][Addres_Active[pan]].Number))
		    Call_last_num (pan, book[pan][Addres_Active[pan]].Number)
	    }
	    ACTIVE ((bat>200)&(bat<Kolvo_Addres_In_Panel+201)):	// --- Редактирование адреса
	    {
		if ((bat - 201 + Book_Addres_Active[pan])<=Kolvo_Addres)
		{
		    Addres_Active[pan] = bat - 201 + Book_Addres_Active[pan]
		    SEND_COMMAND tp[pan],"'^TXT-100,0,',itoa(Addres_Active[pan]),'-',book[pan][Addres_Active[pan]].Name"
		    SEND_COMMAND tp[pan],"'^TXT-200,0,',book[pan][Addres_Active[pan]].Number"
		}
		else
		{
		    Addres_Active[pan] = 0
		    SEND_COMMAND tp[pan],"'^TXT-100,0, '"
		    SEND_COMMAND tp[pan],"'^TXT-200,0, '"
		}
	    }
	}
	
	SWITCH(button.input.channel)
	{
	    Case 100:	// --- Редакция имени
	    {
		Active_adress[pan] = Addres_Active[pan]
		send_command tp[pan], "'@AKB-',book[pan][Addres_Active[pan]].Name,';Name'"
	    }
	    Case 200:	// --- Редакция телефона
	    {
		Active_adress[pan] = Addres_Active[pan]
		send_command tp[pan], "'@EKP-',book[pan][Addres_Active[pan]].Number,';Telefon'"
	    }
	    case 1101:	// +
	    {
		If (Book_Addres_Active[pan] < (Kolvo_Addres-Kolvo_Addres_In_Panel+1))
		{
		    Book_Addres_Active[pan] = Kolvo_Addres_In_Panel + Book_Addres_Active[pan]
		    otrisovka_address_book (pan,Book_Addres_Active[pan])
		}
	    }
	    case 1102:	// -
	    {
		If (Book_Addres_Active[pan] > (Kolvo_Addres_In_Panel+1))
		{
		    Book_Addres_Active[pan] = Book_Addres_Active[pan] - Kolvo_Addres_In_Panel
		    otrisovka_address_book (pan,Book_Addres_Active[pan])
		}
		else
		{
		    Book_Addres_Active[pan] = 1
		    otrisovka_address_book (pan,Book_Addres_Active[pan])
		}
	    }
	}
    }
}
DEFINE_PROGRAM
wait(2) CALL 'FB'
WAIT(200)
{
    If (opros[1]) Opros_SS (1)
    wait(20)	
	If (opros[2]) Opros_SS (2)
}