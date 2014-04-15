#pragma strict
var skinGui:GUISkin;
var getScore:int;

private var guiRatioX:float;
private var guiRatioY:float;
//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizegui:int = 2;

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

function Start () {
getScore = PlayerPrefs.GetInt("Score");

}
function OnGUI (){
GUI.skin = skinGui;

GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
GUI.Label (Rect (250, 10, 400, 400),"Your Score \n " + getScore );

if(GUI.Button(Rect(450,400,100,50),"Play Again")){
	Application.LoadLevel ("MainMenu");
	}
}