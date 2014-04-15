#pragma strict
//the GUI scale ratio
private var guiRatio:float;

//the screen width
private var sWidth:float;

//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;

var sizegui:float;


//==============================================================

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	//calculate the rescale ratio
	guiRatio = sWidth/1920 * sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatio,guiRatio,1);
}

//===================================================================

function Start(){

guiTexture.pixelInset = Rect (0, 0, Screen.width, Screen.height);

}