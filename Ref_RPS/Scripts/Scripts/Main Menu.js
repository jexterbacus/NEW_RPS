#pragma strict
var MenuSkin : GUISkin;

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

var plural = new Array();
var displayMode = new Array();

var count:int = 0;

var guiOn:boolean = true;
var loopOn:boolean =false;
var style : GUIStyle;
var i:int;

var slider:Vector2;
var slider2:float;
var getValue: int;
var scroll:Vector2;

var sliderMem:float;

function Start(){
Screen.sleepTimeout = SleepTimeout.NeverSleep;
}

function Awake()
{
	//get the screen's width
	sWidth = Screen.width;
	//calculate the rescale ratio
	guiRatio = sWidth/1920 * sizegui;
	//create a rescale Vector3 with the above ratio
	GUIsF = new Vector3(guiRatio,guiRatio,1);
}



function OnGUI() {
   
if(guiOn){

	GUI.contentColor = Color.blue;
	GUI.skin = MenuSkin;
		
		GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
		GUI.Box(Rect(0,0,958,538),"Int Learning");
        //GUI.BeginGroup(new Rect(Screen.width,Screen.height,0,0));
            GUI.Label (Rect (250, 320, 500, 200), "Select a training");
            
		GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x-slider2,GUIsF.y,0),Quaternion.identity,GUIsF);
            if(GUI.Button(Rect(50+10,150,200,200),"Basic Shape 1"))
            	 Application.LoadLevel ("Basic Shapes");
            	
            if(GUI.Button(Rect(250+30,150,200,200),"Basic Shapes \n and \n Colors"))
            	Application.LoadLevel ("Basic Shapes and Colors");
            	
			if(GUI.Button(Rect(450+50,150,200,200),"Basic 3D Shape 1")){
				Application.LoadLevel ("Basic 3D Shapes");
            }
            	
            if(GUI.Button(Rect(650+70,150,200,200),"Alphabet")){
            	Application.LoadLevel ("Alphabet");
           	}
           	
           	  if(GUI.Button(Rect(850+90,150,200,200),"Basic Shapes \n Press")){
            	Application.LoadLevel ("Basic Shapes Press");
           	}
           	
           	if(GUI.Button(Rect(1050+110,150,200,200),"Basic Shapes \n Test")){
            	Application.LoadLevel ("Basic Shapes Test");
           	}
           	
           	if(GUI.Button(Rect(1250+130,150,200,200),"Drag \n and \n Drop")){
            	Application.LoadLevel ("DragDrop");
           	}
           	
           	if(GUI.Button(Rect(1450+150,150,200,200),"Alphabet \n Strokes")){
            	Application.LoadLevel ("Writing");
           	}
           
           	if(GUI.Button(Rect(1650+170,150,200,200),"Color \n it \n Out")){
            	Application.LoadLevel ("ColorItOut");
           	}
           	
           	if(GUI.Button(Rect(1850+190,150,200,200),"Draw")){
            	Application.LoadLevel ("Painter");
           	}
         
         GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);
           
           //if(GUI.RepeatButton(Rect(50+10,350,200,100),"-->"))
            //	Scroll ();
            	 
          	if(GUI.Button(Rect(650+95,450,150,50),"Quit"))
            	Application.Quit();
            }          	
}

function Update (){


if(Input.GetMouseButtonDown(0)){
 	sliderMem = slider2;
	scroll = Input.mousePosition;
	}
	
	if(Input.GetMouseButton(0) && slider2 >= -1 && slider2 <= 2500){
	slider =Input.mousePosition - scroll;
	
		
	slider2 = sliderMem + slider.x *-1;
	print ("sliderMem"+sliderMem);
	print ("slider2_"+slider2);
	
	}
	
	if(slider2 <=-1){
		slider2 = 0;
		}
	if(slider2 >= 2500){
		slider2 = 2499;
		}
		
if (Input.GetKeyDown(KeyCode.Escape)) 
   Application.Quit(); 
}