#pragma strict
var actionButton : GUITexture;
private var test : GUILayer;
var go:GameObject;
//var comScript:String;
test = Camera.main.GetComponent(GUILayer);

//the GUI scale ratio

private var guiRatioX:float;
private var guiRatioY:float;
private var guiPRatioX:float;
private var guiPRatioY:float;

//the screen width
private var sWidth:float;
private var sHeight:float;
//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;
var sizeguiX:int;
var sizeguiY:int;
var placementX:int;
var placementY:int;

function Start(){
//fireButton = guiTexture;

}

function OnGUI(){
	
    guiTexture.pixelInset = Rect (guiPRatioX, guiPRatioY, guiRatioX, guiRatioY);

}    
 
function Awake(){ 
	//get the screen's width
	sWidth = Screen.width;
	sHeight = Screen.height;
	//calculate the rescale ratio
	guiRatioX = sWidth/1920 * sizeguiX;
	guiRatioY = sHeight/1080* sizeguiY;
	guiPRatioX = sWidth/1920 * placementX;
	guiPRatioY = sHeight/1080* placementY;
	//create a rescale Vector3 with the above ratio
	//GUIsF = new Vector3(guiRatioX,guiRatioY,1);
}


function Update (){


for (var evt : Touch in Input.touches) {
	var HitTest1 = actionButton.HitTest(evt.position);
	if (evt.phase == TouchPhase.Stationary) {
		if(HitTest1){
			go.GetComponent(Advn_Mvmt_Cnt).Jump();
			}
	} 

}
// Tests if the mouse is touching a GUIElement.
	// Add a GUITexture and put the mouse over it and
	// it will print the GUITexture name.
	
/*
//		if(test.HitTest(Input.mousePosition) != null) {
			if (test.HitTest(Input.mousePosition).name == "RollButton"){
			go.GetComponent(Advn_Mvmt_Cnt).ToRoll();
			print ("WEEEEE");
			}
			if (test.HitTest(Input.mousePosition).name == "JumpButton"){
			go.GetComponent(Advn_Mvmt_Cnt).Jump();
			print ("WAAAA");
			}
			Debug.Log(test.HitTest(Input.mousePosition).name);
		}
		if(test.HitTest(Input.mousePosition) == null){
			go.GetComponent(Advn_Mvmt_Cnt).rollOff = true;
			}	
*/
}

