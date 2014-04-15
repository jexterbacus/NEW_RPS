#pragma strict
var MenuSkin : GUISkin;
var toggleTxt : boolean;

var go:GameObject;
var go2:GameObject;
//the GUI scale ratio
private var guiRatio:float;

//the screen width
private var sWidth:float;

//A vector3 that will be created using the scale ratio
private var GUIsF:Vector3;

var sizegui:float;

var array = new Array();
var textdisplay:String;
var camTrans = new Array();
var store3D = new Array();

var displayMode = new Array();

var count:int = 0;
var guiOn:boolean = true;

var loopOn:boolean =false;

var i:int;

var tempArray = new Array();
var getShapes:String;
var getDisplayModes:String;
var getCamTrans:String;
var getstore3Ds:String;
//==============================================================

function Start(){
	

	if(PlayerPrefs.GetString("Basic_3D_Shapes1_array")){
		getShapes = PlayerPrefs.GetString("Basic_3D_Shapes1_array");
		array = getShapes.Split(","[0]);
		
		getDisplayModes = PlayerPrefs.GetString("Basic_3D_Shapes1_displayMode" );
		displayMode = getDisplayModes.Split(","[0]);
		
		getCamTrans = PlayerPrefs.GetString("Basic_3D_Shapes1_camTrans" );
		camTrans = getCamTrans.Split(","[0]);
		
		getstore3Ds = PlayerPrefs.GetString("Basic_3D_Shapes1_store3D" );
		store3D = getstore3Ds.Split(","[0]);		
		
		for(var i2=0;i2 <= array.length-1;i2++){
		store(array[i2],displayMode[i2],camTrans[i2],store3D[i2]);
		}
	
	}
}
//===============================================================

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	//calculate the rescale ratio
	guiRatio = sWidth/1920 * sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatio,guiRatio,1);
}

//==============================================================

function removeShape(){
var counter:int = 0;

		if(array.length >=2){
			count = count -2;
			array.RemoveAt(array.length-1);
    		displayMode.RemoveAt(array.length-1);
    	
    		textdisplay =""; 
			for(i=0;i <= count;i++){
				if(store3D[i]=="1"){
					counter++;
					textdisplay =  textdisplay + (counter) + ")" + array[i] + ("  ");
				}
			}
			count++;
		}
		
    	
    else if (array.length == 1){
    	array.Clear();
    	displayMode.Clear();
    	textdisplay ="";
    	count = 0;
    	}

}

//===================================================================

function store(shape:String,getDisplayMode:String,getCamTrans:String,getstore3D:String){
var counter:int = 0;
array[count]=shape;
displayMode[count] = getDisplayMode;
camTrans[count]=getCamTrans;
store3D[count] = getstore3D;

textdisplay =""; 

for(i=0;i <= count;i++){
	if(store3D[i]=="1"){
		counter++;
		textdisplay =  textdisplay + (counter) + ")" + array[i] + ("  ");
		}
}


count++;
}

//===================================================================
function SavePref(){
var temp:String;
var temp2:String;
var temp3:String;
var temp4:String;
for(i=0;i< array.length;i++)
{
     if(i!=array.length-1){
        temp+=array[i].ToString()+",";
        temp2+=displayMode[i].ToString()+",";
        temp3+=camTrans[i].ToString()+",";
        temp4+=store3D[i].ToString()+",";
        }
        
     else{
        temp+=array[i].ToString();
        temp2+=displayMode[i].ToString();
        temp3+=camTrans[i].ToString();
        temp4+=store3D[i].ToString();
        }
}
PlayerPrefs.SetString("Basic_3D_Shapes1_array",temp);
PlayerPrefs.SetString("Basic_3D_Shapes1_displayMode",temp2);
PlayerPrefs.SetString("Basic_3D_Shapes1_camTrans",temp3);
PlayerPrefs.SetString("Basic_3D_Shapes1_store3D",temp4);
}
//==================================================================

function OnGUI() {
if(guiOn){
GUI.skin = MenuSkin;
		//GUI.Box(Rect(0,0,Screen.width,Screen.height),"Select a sequence");
		GUI.contentColor = Color.blue;
		GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
		GUI.Box(Rect(0,0,958,538),"Select a sequence");
        //GUI.BeginGroup(new Rect(Screen.width/2,Screen.height/2,300,300));
        	toggleTxt = GUI.Toggle(Rect(50, 460, 50, 50), toggleTxt, "Loop");
        	if(toggleTxt)
            	var loop:boolean = true;
        //GUI.contentColor = Color.red;  	
            if(GUI.Button(Rect(50,80,100,50),"sphere")){
            	store("SphereDot","Fade","Top","0");
            	store("SphereCircle","WipeA","Top","0");
            	store("Sphere","WipeB","Front","1");
            	}
            if(GUI.Button(Rect(50,140,100,50),"spheres")){
            	store("SpheresDot","Fade","Top","0");
            	store("SpheresCircle","WipeA","Top","0");
            	store("Spheres","WipePlural","Front","1");
            	}
           	
            if(GUI.Button(Rect(150+10,80,100,50),"cylinder")){
            	store("CylinderDot","Fade","Top","0");
            	store("CylinderCircle","WipeA","Top","0");
            	store("Cylinder","WipeB","Front","1");
            	}
            	
            if(GUI.Button(Rect(150+10,140,100,50),"cylinders")){
            	store("CylindersDot","Fade","Top","0");
            	store("CylindersCircle","WipeA","Top","0");
            	store("Cylinders","WipePlural","Front","1");
            	}
           
			if(GUI.Button(Rect(250+20,80,100,50),"cone")){
            	store("ConeDot","Fade","Top","0");
            	store("ConeCircle","WipeA","Top","0");
            	store("Cone","WipeB","Front","1");
            	}
            
            if(GUI.Button(Rect(250+20,140,100,50),"cones")){
            	store("ConesDot","Fade","Top","0");
            	store("ConesCircle","WipeA","Top","0");
            	store("Cones","WipePlural","Front","1");
            	}
            	
            if(GUI.Button(Rect(350+30,80,100,50),"cube")){
            	store("CubeDot","Fade","Top","0");
            	store("CubeSquare","WipeA","Top","0");
            	store("Cube","WipeB","Front","1");
            	}
            
            if(GUI.Button(Rect(350+30,140,100,50),"cubes")){
            	store("CubesDot","Fade","Top","0");
            	store("CubesSquare","WipeA","Top","0");
            	store("Cubes","WipePlural","Front","1");
            	}
            	
            if(GUI.Button(Rect(450+40,80,100,50),"pyramid")){
            	store("PyramidDot","Fade","Top","0");
            	store("PyramidSquare","WipeA","Top","0");
            	store("Pyramid","WipeB","Front","1");
            	}
            	
            if(GUI.Button(Rect(450+40,140,100,50),"pyramids")){
            	store("PyramidsDot","Fade","Top","0");
            	store("PyramidsSquare","WipeA","Top","0");
            	store("Pyramids","WipePlural","Front","1");
            	}
            
          	
          	if(GUI.Button(Rect(750+70,460,100,50),"Back")){
          		removeShape();
          		removeShape();
          		removeShape();
          	}
          	
          	if(GUI.Button(Rect(600+70,460,100,50),"Main Menu"))
          		Application.LoadLevel ("Main Menu");
          	
          	if(GUI.Button(Rect(150+10,460,100,50),"Save \n Preferences"))
          		SavePref ();
          		
      		if(GUI.Button(Rect(350+30,460,100,50),"Start")){
      			go = GameObject.Find("Controller");
				var objectScriptCont:S3_ControlerScript = go.GetComponent(S3_ControlerScript);
  				objectScriptCont.StartPlaying(array,displayMode,loop,camTrans);
  				
  				go2 = GameObject.Find("DCExit");
				var scriptDoubleClick:DoubleClickToExit = go2.GetComponent(DoubleClickToExit);
  				scriptDoubleClick.Fadeout();
  				guiOn = false;
  				}
      		textdisplay = GUI.TextArea (Rect (50, 390, 875, 50), textdisplay, 500);
         
}
}

 
