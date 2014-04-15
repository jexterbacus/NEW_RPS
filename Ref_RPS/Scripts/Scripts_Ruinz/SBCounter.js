#pragma strict
var go:GameObject;
private var count:int = 0;
private var gcount:int = 0;
var mult:int = 1;
var multCount:int=0;
var skinGui:GUISkin;
//the GUI scale ratio
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

function Start (){
	count = PlayerPrefs.GetInt("SE");
 	gcount = PlayerPrefs.GetInt("Gold");
  } 

function OnGUI (){
GUI.skin = skinGui;
GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);


GUI.Label (Rect (-20, 100, 200, 100),"  000" + gcount );


GUI.Label (Rect (0, 180, 200, 100),"       "+ mult +"x   \n" + "000" + count );


}



function OnTriggerEnter(other:Collider){
if(other.name == "SpiritBall"){
	multCount = multCount %10;
	multCount++;
	
	go.GetComponent(TextureAnim2).Increment(multCount);
	if (multCount == 10){
		mult++;
		}
	count += 1 * mult;
	PlayerPrefs.SetInt("SE",count);
	}

if(other.name == "Gold"){

	gcount ++;
	PlayerPrefs.SetInt("Gold",gcount);
	}
}



function Update () {

}