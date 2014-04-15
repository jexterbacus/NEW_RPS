#pragma strict
var BGTexture : GUITexture;
var toggleTxt : boolean;


//the GUI scale ratio
private var guiRatio:float;

//the screen width
private var sWidth:float;

//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;

var sizegui:float;

var array = new Array();
var textdisplay:String;

var displayMode = new Array();

var count:int = 0;
var guiOn:boolean = true;

var loopOn:boolean =false;

var i:int;

var tempArray = new Array();
var getShapes:String;
var getDisplayModes:String;
//==============================================================

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	//calculate the rescale ratio
	guiRatio = sWidth/1920 * sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatio,guiRatio,1);
}

//===================================================================


