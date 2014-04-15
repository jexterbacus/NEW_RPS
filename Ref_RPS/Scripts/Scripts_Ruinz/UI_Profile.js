#pragma strict
var skinGui:GUISkin;
var arrowbut:Texture[];
var textButton:Texture;
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

var slider:Vector2;
var initSliderPos:Vector2;
var sliderMem:Vector2;
var initMousePos:Vector2;

//temp possition
var posx:float;
var posy:float;
var scalex:float;
var scaley:float;

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
//GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
GUI.matrix = Matrix4x4.TRS(new Vector3(slider.x - GUIsF.x,GUIsF.y - slider.y,0),Quaternion.identity,GUIsF);


	


if(GUI.Button(Rect(713.7,321.01,200,100),"")){
	Application.LoadLevel("Map");
	}
//Charaters-------------------------------------
if(GUI.Button(Rect(593,425,83,95.2),arrowbut[a])){
	ButtonRight();
	}
if(GUI.Button(Rect(321,425,83,95.2),arrowbut[b])){
	ButtonLeft();
	}

GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
if(GUI.Button(Rect(900,730,200,200),textButton)){
	Application.LoadLevel("Stage_01");
	}
	
GUI.Label(Rect(830,920,500,200),"Play Endless");
}
function Update () {
if (Input.GetKeyDown(KeyCode.Escape)) 
   Application.LoadLevel("MainMenu"); 
}
