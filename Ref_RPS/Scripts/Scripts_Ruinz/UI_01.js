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
var timeInt:int;
var timeString:String;
var highScore:int;
private var getScore:int;

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

function Start (){
highScore = PlayerPrefs.GetInt("HighScore");

}


function OnGUI() {
GUI.skin = skinGui;

GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);

time += 5 * Time.deltaTime;
timeInt = time;


if (time < 9)
GUI.Label (Rect (0, 0, 200, 100),"Time  0000" + timeInt);

else if (time < 99)
GUI.Label (Rect (0, 0, 200, 100),"Time  000" + timeInt);

else if (time < 999)
GUI.Label (Rect (0, 0, 200, 100),"Time  00" + timeInt);

else if (time < 9999)
GUI.Label (Rect (0, 0, 200, 100),"Time  0" + timeInt);

GUI.Label (Rect (150, 0, 200, 100),"HS " + highScore);

//if(GUI.Button(Rect(0,250,105,100),"Restart")){
	//Application.LoadLevel("Stage_01B");
	//}


}

function Update () {

}