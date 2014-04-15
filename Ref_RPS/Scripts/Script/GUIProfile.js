#pragma strict
var skinGui:GUISkin;
var customGuiStyle : GUIStyle;
var arrowbut:Texture[];
var startButton:Texture;
var quitButton:Texture;
var registerButton:Texture;
var deleteButton:Texture;
var regButton:Texture;
var selNames : String[] = ["", "", "", "",""];
var scores:int[];
var selGridInt : int = 0;
var warningBox:boolean = false;

var a:int = 0;
var b:int = 1;

//the GUI scale ratio
private var guiRatioX:float;
private var guiRatioY:float;
//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizegui:int;
var playerName:String;

//temp possition
var posx:float;
var posy:float;
var scalex:float;
var scaley:float;

function Awake(){
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
for(var i:int = 0; i <= 4; i++)
selNames[i] = PlayerPrefs.GetString("PlayerName"+i);
for(i = 0; i <= 4; i++)
scores[i]= PlayerPrefs.GetInt("PlayerHighScore"+i);

selGridInt = PlayerPrefs.GetInt("PlayerSelection");
scores[selGridInt]= PlayerPrefs.GetInt("HighScore");
}

function ButtonRight(){
a=2;
yield WaitForSeconds (.5);
a=0;
}

function ButtonLeft(){
b=3;
yield WaitForSeconds (.5);
b=1;
}



function OnGUI() {

GUI.skin = skinGui;
GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);

GUI.Box(Rect(0,0,310,310),"Names and Scores");
GUI.Box(Rect(0,75,310,30),"");
GUI.Box(Rect(0,112,310,30),"");
GUI.Box(Rect(0,149,310,30),"");
GUI.Box(Rect(0,186,310,30),"");
GUI.Box(Rect(0,223,310,30),"");

if(GUI.Button(Rect(257,32,45,45),registerButton)){
	selNames[selGridInt] = playerName;
	PlayerPrefs.SetString("PlayerName"+selGridInt, playerName);
	}
if(GUI.Button(Rect(257,260,45,45),deleteButton)){
	warningBox = true;
	}

//WARNING BOX======================================
if (warningBox){
	GUI.Box(Rect (0,320, 310, 100), "Delete " + selNames[selGridInt] + "?");
	GUI.Box(Rect (0,320, 310, 100), "Delete " + selNames[selGridInt] + "?");
	
	if(GUI.Button(Rect(85,365,50,50),"Yes")){
		PlayerPrefs.DeleteKey("PlayerName"+selGridInt);
		PlayerPrefs.DeleteKey("PlayerHighScore"+selGridInt);
		scores[selGridInt] = 0;
		selNames[selGridInt] = "";
		warningBox = false;
		}
	if(GUI.Button(Rect(180,365,50,50),"No")){
		warningBox = false;
		}
}

playerName = GUI.TextField (Rect (0, 40, 200, 30), playerName, 10);
selGridInt = GUI.SelectionGrid (Rect (0, 75, 200, 180),selGridInt, selNames, 1);

GUI.Label(Rect (385, 130, 200, 70), selNames[selGridInt],customGuiStyle);

//Scores ==================================================

if(selNames[0] == "")
GUI.Label(Rect (102, 61, 200, 70), "");
else
GUI.Label(Rect (102, 61, 200, 70), ""+scores[0]);

if(selNames[1] == "")
GUI.Label(Rect (102, 98, 200, 70), "");
else
GUI.Label(Rect (102, 98, 200, 70), ""+scores[1]);

if(selNames[2] == "")
GUI.Label(Rect (102, 135, 200, 70), "");
else
GUI.Label(Rect (102, 135, 200, 70), ""+scores[2]);

if(selNames[3] == "")
GUI.Label(Rect (102, 172, 200, 70), "");
else
GUI.Label(Rect (102, 172, 200, 70), ""+scores[3]);

if(selNames[4] == "")
GUI.Label(Rect (102, 209, 200, 70), "");
else
GUI.Label(Rect (102, 209, 200, 70), ""+scores[4]);

//Charaters-------------------------------------
if(GUI.Button(Rect(593,430,83,95.2),arrowbut[a])){
	ButtonRight();
	}
if(GUI.Button(Rect(295,430,83,95.2),arrowbut[b])){
	ButtonLeft();
	}

if(GUI.Button(Rect(775,381,145,145),startButton)){
	PlayerPrefs.SetString("Player", selNames[selGridInt]);
	PlayerPrefs.SetInt("PlayerSelection", selGridInt);
	PlayerPrefs.SetInt("HighScore",scores[selGridInt]);
	for(var i:int = 0;i <=4; i++)
	PlayerPrefs.SetInt("PlayerHighScore"+i,scores[i]);
	
	Application.LoadLevel("Heaven");
	}


if(GUI.Button(Rect(875,-3,75,75),quitButton)){
	Application.Quit();
	}
}



function Update () {
if (Input.GetKeyDown(KeyCode.Escape)) 
  Application.Quit(); 
}
