#pragma strict
private var guiRatioX:float;
private var guiRatioY:float;
private var guiPRatioX:float;
private var guiPRatioY:float;

//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizeguiX:int;
var sizeguiY:int;
var placementX:int;
var placementY:int;
   
 
 

function Update (){

	//get the screen's width
	sWidth = Screen.width;
	sHeight = Screen.height;
	//calculate the rescale ratio
	guiRatioX = sWidth/1920 * sizeguiX;
	guiRatioY = sHeight/1080* sizeguiY;
	guiPRatioX = sWidth/1920 * placementX;
	guiPRatioY = sHeight/1080* placementY;
	//create a rescale Vector3 with the above ratio
	//GUIsF = new Vector3(guiRatioX,guiRatioY,1);
	guiTexture.pixelInset = Rect (guiPRatioX, guiPRatioY, guiRatioX, guiRatioY);
}



