#pragma strict
var skinGui:GUISkin;
var textures:Texture[];
var boxTexture:Texture[];
//the GUI scale ratio
private var guiRatioX:float;
private var guiRatioY:float;
//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizegui:int;

private var time:float;
private var timeInt:int;
var timeString:String;

private var go:GameObject;

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	sHeight = Screen.height;
	//calculate the rescale ratio
	guiRatioX = sWidth/1920 * sizegui;
	guiRatioY = sHeight/1080* sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatioX,guiRatioY,1);
}

function OnGUI() {
GUI.skin = skinGui;
GUI.depth = 1;
GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);

GUI.Box(Rect(0,0,960,540),"TEST");
}