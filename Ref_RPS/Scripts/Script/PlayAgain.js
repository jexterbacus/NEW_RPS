#pragma strict
var skinGui:GUISkin;
var getScore:int;
var playerName:String;

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

if (getScore < 9)
GUI.Label (Rect (50, 30, 200, 100),"Your Score \n " + "0000" + getScore);

else if (getScore < 99)
GUI.Label (Rect (50, 30, 200, 100),"Your Score \n " + "000" + getScore);

else if (getScore < 999)
GUI.Label (Rect (50, 30, 200, 100),"Your Score \n " + "00" + getScore);

else if (getScore < 9999)
GUI.Label (Rect (50, 30, 200, 100),"Your Score \n " + "0" + getScore);

if(GUI.Button(Rect(380,420,200,70),"Play Again")){
	//PlayerPrefs.SetString("PlayerName",playerName);
	//PlayerPrefs.SetInt("PlayerScore",playerName);
	Application.LoadLevel ("Heaven");
	}
}

function Update (){
if (Input.GetKeyDown(KeyCode.Escape))
 
  Application.LoadLevel("MainMenu"); 
}