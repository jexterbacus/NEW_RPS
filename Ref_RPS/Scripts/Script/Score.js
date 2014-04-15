#pragma strict
var skinGui:GUISkin;
var style:GUIStyle;
var score:int;
var fscore:float;
var hscore:int;
private var highscore:String;
var player:String;
//var playerHS:String;

private var guiRatioX:float;
private var guiRatioY:float;
//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizegui:int = 2;

var posx:float;
var posy:float;

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
//PlayerPrefs.SetInt("HighScore",0);
hscore = PlayerPrefs.GetInt("HighScore");
player = PlayerPrefs.GetString("Player");
//playerHS = PlayerPrefs.GetString("PlayerSH");

if (hscore < 9)
highscore = ("0000" + hscore);
else if (hscore < 99)
highscore = ("000" + hscore);
else if (hscore < 999)
highscore = ("00" + hscore);
else if (hscore < 9999)
highscore = ("0" + hscore);
}


function OnGUI (){
GUI.skin = skinGui;
fscore += 1 * (Time.deltaTime*4);
score = fscore;
GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);

if (score < 9)
GUI.Label (Rect (27, 17, 200, 100),"0000" + score);
else if (score < 99)
GUI.Label (Rect (27, 17, 200, 100),"000" + score);
else if (score < 999)
GUI.Label (Rect (27, 17, 200, 100),"00" + score);
else if (score < 9999)
GUI.Label (Rect (27, 17, 200, 100),"0" + score);

//--------------------------------
GUI.Label (Rect (805, 17, 200, 100),highscore);
GUI.Label (Rect (-15, 52.5, 200, 75),player,style);
//GUI.Label (Rect (765, 52.5, 200, 75),playerHS,style);
}