MODULE_NAME='TV_AverMedia_Module' (dev dv,
				   dev tp)

DEFINE_CONSTANT
Dalay = 2

DEFINE_VARIABLE
volatile in_chanel[5]
volatile x[1]

DEFINE_EVENT

BUTTON_EVENT[tp,0]
{
    push:
    {
	PULSE[dv,button.input.channel]
    }
}

DATA_EVENT[tp]
{
    string:
    {
	in_chanel = data.text
	
	pulse[dv,10+atoi(left_string(in_chanel,1))]
	wait(Dalay)
	pulse[dv,10+atoi(right_string(in_chanel,1))] 
    }
}