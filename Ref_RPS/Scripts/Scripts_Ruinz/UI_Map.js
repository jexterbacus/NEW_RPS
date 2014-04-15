#pragma strict
var skinGui:GUISkin;
var textures:Texture[];
var textstage:Texture;
var textButton:Texture;

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


function OnGUI() {
GUI.skin = skinGui;
//GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
GUI.matrix = Matrix4x4.TRS(new Vector3(slider.x - GUIsF.x,GUIsF.y - slider.y,0),Quaternion.identity,GUIsF);


	
GUI.Box(Rect(0,0,960,540),textures[0]);
GUI.Box(Rect(959,0,960,540),textures[1]);
GUI.Box(Rect(1919,0,960,540),textures[2]);
GUI.Box(Rect(2879,0,960,540),textures[3]);

GUI.Box(Rect(0,539,960,540),textures[4]);
GUI.Box(Rect(959,539,960,540),textures[5]);
GUI.Box(Rect(1919,539,960,540),textures[6]);
GUI.Box(Rect(2879,539,960,540),textures[7]);

GUI.Box(Rect(0,1079,960,540),textures[8]);
GUI.Box(Rect(959,1079,960,540),textures[9]);
GUI.Box(Rect(1919,1079,960,540),textures[10]);
GUI.Box(Rect(2879,1079,960,540),textures[11]);

GUI.Box(Rect(1,1619,960,540),textures[12]);
GUI.Box(Rect(959,1619,960,540),textures[13]);
GUI.Box(Rect(1919,1619,960,540),textures[14]);
GUI.Box(Rect(2879,1619,960,540),textures[15]);

if(GUI.Button(Rect(90,8,200,200),"Ruinz 1")){
	Application.LoadLevel("Ruinz_01");
	}
if(GUI.Button(Rect(721.41,159.1,200,200),"Ruinz 2")){
	Application.LoadLevel("Ruinz_01");
	}
if(GUI.Button(Rect(117.23,304.63,200,200),"Ruinz 3")){
	Application.LoadLevel("Ruinz_01");
	}
if(GUI.Button(Rect(310.72,537.25,200,200),"Ruinz 4")){
	Application.LoadLevel("Ruinz_01");
	}
if(GUI.Button(Rect(991.3,276,200,200),"Ruinz 5")){
	Application.LoadLevel("Ruinz_01");
	}

GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
if(GUI.Button(Rect(900,730,200,200),textButton)){
	Application.LoadLevel("Stage_01");
	}
GUI.Label(Rect(830,920,500,200),"Play Endless");
}
function Update () {
if(Input.GetMouseButtonDown(0)){
 	sliderMem = slider;
	initMousePos = Input.mousePosition;
	}
	
	if(Input.GetMouseButton(0)){// && slider.x >= 0 && slider.x <= 2500){
	initSliderPos =Input.mousePosition - initMousePos;
	
	slider = sliderMem + initSliderPos;// *-1;
	print ("sliderMem"+sliderMem);
	print ("slider2_"+slider);
	
	}
slider.x = Mathf.Clamp(slider.x,-1400,0);
slider.y = Mathf.Clamp(slider.y,0,880);		
if (Input.GetKeyDown(KeyCode.Escape)) 
   Application.Quit(); 
}
