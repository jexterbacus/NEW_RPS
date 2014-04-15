#pragma strict
var skinGui:GUISkin;
var skinGuiLeft:GUISkin;
var skinGuiRight:GUISkin;
var DialerSwtich:Texture[];
var textures:Texture[];
var dialerBG:Texture;
var LeftWall:Texture;
var walltextures:Texture[];
var entertex:Texture;
var x:int;
var y:int;
var xw:int;
var yh:int;
var moveLeft:float;
var moveRight:float;
var moveDown:float;
var openOn:boolean = false;
var t:float;

var counterInt:int = 0;
var counterInt2:int = 0;
var counterFloat:float = 0;
var counterFloat2:float = 0;
var counter10:int = 0;
var turnLeft:boolean = true;
var texCounter:int = 0;
var texCounterSwitch:int = 0;

var switchOn:boolean = false;

private var guiRatioX:float;
private var guiRatioY:float;
private var sWidth:float;
private var sHeight:float;
private var GUIsF:Vector3;
var sizegui:int = 1;

var slider:Vector2;
var pointPos:Vector2;
var initMousePos:Vector2;

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	sHeight = Screen.height;
	//calculate the rescale ratio
	guiRatioX = sWidth/1920 * sizegui;
	guiRatioY = sHeight/1080* sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatioX,guiRatioX,1);
}

function OnGUI() {

GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.x,0),Quaternion.identity,GUIsF);
GUI.skin = skinGuiLeft;
GUI.Box(Rect(0-moveLeft,-14,480,638),"");

GUI.skin = skinGuiRight;
GUI.Box(Rect(478+moveRight,-14,481,638),"");

GUI.skin = skinGui;
//GUI.Box(Rect(-1,-1 ,960,640),walltextures[0]);
GUI.Box(Rect(257,80 + moveDown,440,535),dialerBG);
GUI.Box(Rect(358,168 + moveDown,235,235),DialerSwtich[texCounterSwitch]);
GUI.Box(Rect(302,112 + moveDown,350,350),textures[texCounter]);

//GUI.Box(Rect(x,y ,960,640),walltextures[0]);

if(GUI.Button(Rect(439,229,80,80),"")){
	switchOn = true;
	if (texCounter == 0){
		Survey();
		}
	if (texCounter == 30){
		Profiles();
		}
	if (texCounter == 10){
		Scores();
		}
	if (texCounter == 20){
		Options();
		}
	}
}

function Survey (){
yield WaitForSeconds(1.5);
Application.LoadLevelAdditive("Map");
}

function Profiles (){
yield WaitForSeconds(1.5);
Application.LoadLevelAdditive("Profiles");
}

function Scores (){
yield WaitForSeconds(1.5);
Application.LoadLevelAdditive("Scores");
}

function Options (){
yield WaitForSeconds(1.5);
Application.LoadLevelAdditive("Options");
}


function Update (){
//----------------------------------------------
if(Input.GetMouseButtonDown(0)){
 	turnLeft = true;
	initMousePos = Input.mousePosition;
	}
	
if(Input.GetMouseButton(0)){
	pointPos =Input.mousePosition - initMousePos;
	}


if (turnLeft && pointPos.y >= 10){
	counterFloat += 1 * (Time.deltaTime*20);
	}
if (turnLeft && pointPos.x >= 10){
	counterFloat += 1 * (Time.deltaTime*20);
	}
if (turnLeft && pointPos.y <= -10){
	counterFloat -= 1 * (Time.deltaTime*20);
	}
if (turnLeft && pointPos.x <= -10){
	counterFloat -= 1 * (Time.deltaTime*20);
	}

if(counterInt >= 10){
	counter10 = counter10 + 10;
	counter10 = counter10 % 40;
	counterFloat = 0;
	turnLeft = false;
	}
	
if(counterInt <= -10){
	counter10 = counter10 - 10;
	counter10 = counter10 % -40;
	counterFloat = 0;
	turnLeft = false;
	}
	
counterInt =counterFloat;

texCounter = 40 + counter10 + counterInt;

texCounter =texCounter % 40;
//-------------------------------------------------

if (switchOn){
	counterFloat2 += 1 * (Time.deltaTime*20);
	counterInt2 =counterFloat2;
	texCounterSwitch = counterInt2;
	if (counterInt2 >= 39){
		openOn = true;
		switchOn = false;
		}
	}
if (openOn){
	
	t += 1 * (Time.deltaTime/2);
	moveLeft = Mathf.SmoothStep (0,500,t);
	moveRight = Mathf.SmoothStep (0,500,t);
	moveDown = Mathf.SmoothStep (0,500,t);
	if (t >= 1){
		gameObject.GetComponent(Dialer).enabled = false;
		}
	}
}