PROGRAM_NAME='Jupiter'

DEFINE_VARIABLE
VOLATILE Integer Hold_But_P
Integer DataForVideoPresset[10][18]
Integer DataForVideoPresset_Cube[10][18]
VOLATILE Integer l_f

Integer matrix_Jupiter_to_VIdeoWal[][] = // --- Константы для комутации копии Юпитера на видео стену
   {{1,1,1,1,2,3,4,4,4,4,4,4,5,5,6,7,8,9},
    {1,1,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4},
    {1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5},
    {1,1,1,1,2,2,2,2,5,5,5,5,6,6,6,6,3,4},	// ---
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18}}


DEFINE_START
VideoWall_Pressert_ON = 1
Wait (90)
    Call 'File_to_Memory'
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


Define_Call 'Memory_to_File' 							// --- Запись в файл
{
    STACK_VAR Integer a
    STACK_VAR Integer b
    STACK_VAR char text[5000]
    text = ''
    For(b=1;b<11;b++)
    {
	For (a=1;a<19;a++)
	    text = "text,DataForVideoPresset[b][a],';'"
	text = "text,'!'"
    }
    For(b=1;b<11;b++)
    {
	For (a=1;a<19;a++)
	    text = "text,DataForVideoPresset_Cube[b][a],';'"
	text = "text,'!'"
    }
    appendToFile("'Video_Pressets_0.txt'",text)
}

Define_Call 'File_to_Memory' 							// --- Чтение из файла
{
    STACK_VAR Integer a
    STACK_VAR Integer b
    STACK_VAR char text[5000]
    STACK_VAR char mini[1000]
    text = ''
    readStuffFromFile("'Video_Pressets_0.txt'",text)
    if (length_string(text))
    {
	For(b=1;b<11;b++)
	{
	    mini = remove_string(text,"'!'",1)
	    a = 1
	    WHILE(length_string(mini)>2)
	    {
		DataForVideoPresset[b][a] = remove_string(mini,"';'",1)
		a++
	    }
	}
	For(b=1;b<11;b++)
	{
	    mini = remove_string(text,"'!'",1)
	    a = 1
	    WHILE(length_string(mini)>2)
	    {
		DataForVideoPresset_Cube[b][a] = remove_string(mini,"';'",1)
		a++
	    }
	}
    }
}
DEFINE_EVENT

DATA_EVENT[JupiterAllTP]
{
    string:
    {
	//"'00Pmute 0',$0D,'00UP',$0D"
	if ([tp_Jupiter_17,159]<>0) send_string dv_VideoWall,"'00Pmute 1',$0D,'00UP',$0D"
	SEND_STRING dv_Jupiter, "'+WinServer SetLayout "',data.text,'"',$0D,$0A"	//  ---  
	Wait(60)
	    if ([tp_Jupiter_17,159]<>0) send_string dv_VideoWall,"'00Pmute 0',$0D,'00UP',$0D"
    }
}

BUTTON_EVENT[JupiterAllTP,0]
{
    Push:
    {
	STACK_VAR Integer For_Cikl
	Hold_But_P = BUTTON.INPUT.CHANNEL
	
	If ((Hold_But_P>100)&(Hold_But_P<201))
	{
	    Hold_But_P = Hold_But_P - 100
	}
	Else
	If (Hold_But_P = 1000)		// --- Делаем копию видое юпитера на видео стену
	{
	    If ((VideoWall_Pressert_ON>0)&(VideoWall_Pressert_ON<6))	// --- Если в памаяти пресет не 0
	    {
		SEND_STRING dv_VideoWall,"'00Calldisp ',itoa(VideoWall_Pressert_ON),$0D,'00UP',$0D"	// --- Вызываем текущий соответствующий пресет на видео стенне
		For(For_Cikl=1;For_Cikl<19;For_Cikl++)
		{
		    send_string vdv_DGX, "itoa(OUT_FB[matrix_Jupiter_to_VIdeoWal[VideoWall_Pressert_ON][For_Cikl]+112]),'IN',itoa(For_Cikl),'OUT'"
		}
	    }
	}
	Else
	    Hold_But_P = 0
	    

    }
    hold[20]:	// --- Сохранине 
    {
	if ((Hold_But_P>0)&(Hold_But_P<11))
	{
	    for (L_F=1;l_f<19;l_f++)
	    {
		DataForVideoPresset[Hold_But_P][l_f] = OUT_FB[l_f+18]
	    }
	    Call 'Memory_to_File' 
	    [JupiterAllTP[1],Hold_But_P+100] = 1
	    [JupiterAllTP[2],Hold_But_P+100] = 1
	    [JupiterAllTP[3],Hold_But_P+100] = 1
	    Hold_But_P = Hold_But_P + 100
	}
	Else
	if ((Hold_But_P>20)&(Hold_But_P<31))
	{
	    for (L_F=1;l_f<19;l_f++)
	    {
		DataForVideoPresset[Hold_But_P+5-20][l_f] = OUT_FB[l_f+112]
	    }
	    Call 'Memory_to_File' 
	    [JupiterAllTP[1],Hold_But_P+100] = 1
	    [JupiterAllTP[2],Hold_But_P+100] = 1
	    [JupiterAllTP[3],Hold_But_P+100] = 1
	    Hold_But_P = Hold_But_P + 100
	}
	Else
	if ((Hold_But_P>50)&(Hold_But_P<60))
	{
	    for (L_F=1;l_f<19;l_f++)
	    {
		DataForVideoPresset_Cube[Hold_But_P-50][l_f] = OUT_FB[l_f]
	    }
	    Call 'Memory_to_File' 
	    Hold_But_P = Hold_But_P + 100
	}
    }
    RELEASE:	// --- Вызов
    {
	if (Hold_But_P > 100)
	{
	    if (Hold_But_P<150)
	    {
		[JupiterAllTP[1],Hold_But_P] = 0
		[JupiterAllTP[2],Hold_But_P] = 0
		[JupiterAllTP[3],Hold_But_P] = 0
	    }
	    Hold_But_P = 0
	}
	if ((Hold_But_P>0)&(Hold_But_P<11))
	{
	    for (L_F=1;l_f<19;l_f++)
	    {
		SEND_STRING vdv_DGX, "itoa(DataForVideoPresset[Hold_But_P][l_f]),'IN',itoa(l_f+18),'OUT'"
	    }
	}
	Else
	if ((Hold_But_P>20)&(Hold_But_P<31))
	{
	    for (L_F=1;l_f<19;l_f++)
	    {
		SEND_STRING vdv_DGX, "itoa(DataForVideoPresset[Hold_But_P+5-20][l_f]),'IN',itoa(l_f+112),'OUT'"
	    }
	}
	if ((Hold_But_P>50)&(Hold_But_P<60))
	{
	    SEND_STRING dv_VideoWall,"'00Calldisp ',itoa(Hold_But_P-50),$0D,'00UP',$0D"
	    for (L_F=1;l_f<19;l_f++)
	    {
		SEND_STRING vdv_DGX, "itoa(DataForVideoPresset_Cube[Hold_But_P-50][l_f]),'IN',itoa(l_f),'OUT'"
	    }
	}
	
	Hold_But_P = 0
    }
}