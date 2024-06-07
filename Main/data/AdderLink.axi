PROGRAM_NAME='AdderLink'

DEFINE_VARIABLE
volatile INTEGER LocalPort_adder
volatile LONG Port_adder
volatile SLONG Return_Code_adder
volatile Integer onlineP1_adder
VOLATILE ip_adder[50]
VOLATILE token[100]
VOLATILE id_Preset
VOLATILE id_all_presset[1000]
volatile buf_adder[1000]
VOLATILE mini_adder[900]
VOLATILE text_ip_send[500]
VOLATILE INTEGER Start_conect
VOLATILE Integer length_adder

VOLATILE Integer Token_aktive
VOLATILE Integer Svich_Adder

DEV     tp_Adder_all [] =
{
    tp_Adder,
    tp_adder_14,
    tp_adder_15,
    tp_adder_16,
    tp_adder_Raz
}
//
DEFINE_START
CREATE_BUFFER dv_ip_Adder,buf_adder
ip_adder = '25.100.4.193'
Port_adder = 80

IF (Return_Code_adder == 0)
    {
	SEND_STRING 0,'Zero'
    }
    ELSE
    {
	SEND_STRING 0,'Not Zero'
    }
   

DEFINE_FUNCTION fb_adder ()
{
    if (buf_adder<>'')
    {
	if (find_string(buf_adder,"'</api_response>'",1))
	{
	    mini_adder = remove_string(buf_adder,"'</api_response>'",1)
	    select
	    {
		active(find_string(mini_adder,"'<success>1</success><token>'",1)):
		{
		    remove_string (mini_adder,"'<success>1</success><token>'",1)
		    length_adder = find_string(mini_adder,"'<'",1)
		    token = mid_string(mini_adder,1,length_adder-1)
		    Token_aktive = 1
		}
		active(find_string(mini_adder,"'<success>0</success><errors><error><code>10</code><msg>Login required</msg></error></errors>'",1)):
		{
		    Token_aktive = 0
		}
		active(find_string(mini_adder,"'<msg>Invalid token</msg>'",1)):
		{
		    Token_aktive = 0
		}
		active(find_string(mini_adder,"'<msg>Invalid username or password</msg>'",1)):
		{
		    Token_aktive = 0
		}
	    }
	}
    }
}   
define_function reToken ()
{
    cancel_wait 'ret'
    wait(500) 'ret'
    {
	Token_aktive=0
    }
    
}
DEFINE_EVENT

DATA_EVENT[dv_ip_Adder]
{
    ONLINE:
    {
	onlineP1_adder = 1
	SEND_STRING 0,'SPX ONLINE'
	CANCEL_WAIT 'WAITERROR'
	Start_conect = 0
	send_string dv_ip_Adder, text_ip_send
	text_ip_send = 0
	Wait(10)
	ip_client_close (dv_ip_Adder.port)
    }
    OFFLINE:
    {
	onlineP1_adder = 0
	if (Start_conect)
	Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
    }
    ONERROR: 
    {
	onlineP1_adder = 2
	if (Start_conect)
	WAIT 50 'WAITERROR'
	{
	    Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	}
    }
}

BUTTON_EVENT[tp_Adder_all,0]
{
    PUSH:
    {
	SWITCH(button.input.channel)
	{
	    Case 1:
	    {
		text_ip_send = "'GET /api/?v=1&method=login&username=admin&password=6819',13,10"
		Start_conect = 1
		Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	    }
	    Case 2:
	    {
		text_ip_send ="'GET /api/?v=1&method=connect_preset&token=',token,'&id=',itoa(id_Preset),'&force=1',13,10,13,10"
		Start_conect = 1
		Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	    }
	    Case 3:
	    {
		Start_conect = 1
		Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	    }
	    // 15 место
	    Case 11:{id_all_presset = "id_all_presset,'26!'"; send_string vdv_DGX, "'77IN77OUT'";[tp_Adder,10]=1}
	    Case 12:{id_all_presset = "id_all_presset,'27!'"; send_string vdv_DGX, "'86IN77OUT'";[tp_Adder,10]=1}
	    // 16 место
	    Case 13:{id_all_presset = "id_all_presset,'28!'"; send_string vdv_DGX, "'79IN79OUT'";[tp_Adder,10]=1}
	    Case 14:{id_all_presset = "id_all_presset,'29!'"; send_string vdv_DGX, "'60IN79OUT'";[tp_Adder,10]=1} 
	    // 14 место
	    Case 15:{id_all_presset = "id_all_presset,'24!'"; send_string vdv_DGX, "'75IN75OUT'";[tp_Adder,10]=1}
	    Case 16:{id_all_presset = "id_all_presset,'25!'"; send_string vdv_DGX, "'67IN75OUT'";[tp_Adder,10]=1} 
	    Case 21:{send_string vdv_DGX, "'111IN95OUT'"; send_string vdv_DGX, "'112IN111OUT'";[tp_Adder,10]=1}
	}
	if (id_Preset = 0)
	    id_Preset = atoi(remove_string(id_all_presset,"'!'",1))
    }
}
DATA_EVENT[vdv_VideoForControl]		// --- Кабинет Ражнова
{
    STRING:
    {
	STACK_VAR Integer In_pup
	STACK_VAR Integer Out_pup
	
	In_pup = atoi(remove_string(data.text,'to',1))
	Out_pup = atoi(remove_string(data.text,'!',1))
	
	if (Out_pup=95)
	{
	    switch(In_pup)
	    {
		Case 95:{id_all_presset = "id_all_presset,'17!'"}
		Case 96:{id_all_presset = "id_all_presset,'19!'"}
	    }
	}
	if (Out_pup=96)
	{
	    switch(In_pup)
	    {
		Case 95:{id_all_presset = "id_all_presset,'18!'"}
		Case 96:{id_all_presset = "id_all_presset,'20!'"}
	    }
	}
	
	if (id_Preset = 0)
	    id_Preset = atoi(remove_string(id_all_presset,"'!'",1))
    }
}

DEFINE_PROGRAM
Wait(20)
{
    select
    {
	active(Token_aktive=0):		// --- Если токен не годный опращиваем  username=admin&password=6819
	{
	    text_ip_send = "'GET /api/?v=1&method=login&username=admin&password=6819',13,10"
	    Start_conect = 1
	    Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	    reToken ()
	}
	active(id_Preset):			// --- Если не 0 то комутим
	{
	    text_ip_send ="'GET /api/?v=1&method=connect_preset&token=',token,'&id=',itoa(id_Preset),'&force=1',13,10,13,10"
	    Start_conect = 1
	    Return_Code_adder = IP_CLIENT_OPEN(dv_ip_Adder.port, ip_adder ,Port_adder,IP_TCP)
	    reToken ()
	    
	    // Защита от сбоев
	    if (length_string(id_all_presset)>90) {id_all_presset = '';id_Preset=0}
	    
		    id_Preset = 0
		    [tp_Adder,10]=0
		    id_Preset = atoi(remove_string(id_all_presset,"'!'",1))
	}
    }
}
Wait(6)
    fb_Adder();