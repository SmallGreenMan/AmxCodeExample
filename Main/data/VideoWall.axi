PROGRAM_NAME='VideoWall'
DEFINE_VARIABLE
buff_video_wall[500]
Mini_buff_video_wall[50]
Integer Video_cube_i
Integer PresetsCube

dev JupiterAllTP [] =
{
    tp_Jupiter_17,
    tp_Jupiter_7,
    TP_Jupiter_Stena
}

dev VideoWallAllTP [] =
{
    TP_VideoWall_17,
    TP_VideoWall_7,
    TP_VideoWall_Stena
}

DEFINE_START
CREATE_BUFFER dv_VideoWall,buff_video_wall

DEFINE_MUTUALLY_EXCLUSIVE
([JupiterAllTP[1],151],[JupiterAllTP[1],152],[JupiterAllTP[1],153],[JupiterAllTP[1],154],[JupiterAllTP[1],155],[JupiterAllTP[1],159])
([JupiterAllTP[2],151],[JupiterAllTP[2],152],[JupiterAllTP[2],153],[JupiterAllTP[2],154],[JupiterAllTP[2],155],[JupiterAllTP[2],159])
([JupiterAllTP[3],151],[JupiterAllTP[3],152],[JupiterAllTP[3],153],[JupiterAllTP[3],154],[JupiterAllTP[3],155],[JupiterAllTP[3],159])

DEFINE_CALL 'FB_Video_Cube'
{
    STACK_VAR Integer Video_cube_y
    
    If (LENGTH_STRING(buff_video_wall))
    {
	If (FIND_STRING(buff_video_wall,"$0D",1))
	{
	    Mini_buff_video_wall = remove_string(buff_video_wall,"$0D",1)
	    
	    select
	    {
		ACTIVE(FIND_STRING(Mini_buff_video_wall,"'System 0 0 '",1)):
		{
		    Video_cube_y = atoi(remove_string(Mini_buff_video_wall,'System',1))
		    remove_string(Mini_buff_video_wall,' 0 0 ',1)
		    SEND_COMMAND JupiterAllTP[1], "'^TXT-',itoa(Video_cube_y),',1&2,',Mini_buff_video_wall"
		}	
		ACTIVE(FIND_STRING(Mini_buff_video_wall,"'Calldisp'",1)):
		{
		    remove_string(Mini_buff_video_wall,'Calldisp',1)
		    PresetsCube = atoi(Mini_buff_video_wall)
		    [JupiterAllTP[1],150+PresetsCube] = 1
		    [JupiterAllTP[2],150+PresetsCube] = 1
		    [JupiterAllTP[3],150+PresetsCube] = 1
		    if (PresetsCube=9)
		    {
			[JupiterAllTP[1],161] = 0
			[JupiterAllTP[2],161] = 0
			[JupiterAllTP[3],161] = 0
		    }
		    Else
		    {
			[JupiterAllTP[1],161] = 1
			[JupiterAllTP[2],161] = 1
			[JupiterAllTP[3],161] = 1
		    }
		}
	    }
	}
    }
}

DEFINE_EVENT

DATA_EVENT[VideoWallAllTP]		// --- Отсылка команды управления
{
    String:
    {
	send_string dv_VideoWall, "data.text,$0D"
    }
    Online:
    {
	CANCEL_WAIT 'VideoWall_Presets'
	WAIT(50) 'VideoWall_Presets'
	    SEND_STRING dv_VideoWall,"'00Calldisp',$0D"
    }
}

BUTTON_EVENT[JupiterAllTP,100]	// --- Опрос время выработки ламп
{
    PUSH:
    {
	Video_cube_i = 1
	SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	Wait(1){
	    SEND_STRING dv_VideoWall, "RIGHT_STRING("'0',itoa(Video_cube_i)",2),'System 0',$0D"
	    Video_cube_i++
	}}}}}}}}}}}}}}}}}
    }
}

DEFINE_PROGRAM
wait(2)
CALL 'FB_Video_Cube'