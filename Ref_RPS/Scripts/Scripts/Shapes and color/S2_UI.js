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

var displayMode = new Array();

var count:int = 0;
var guiOn:boolean = true;

var loopOn:boolean =false;

var i:int;

var tempArray = new Array();
var getShapes:String;
var getDisplayModes:String;


//==================== Initialize ==========================================

function Start(){
	

	if(PlayerPrefs.GetString("Basic_Shapes2_array")){
		getShapes = PlayerPrefs.GetString("Basic_Shapes2_array");
		array = getShapes.Split(","[0]);
		
		getDisplayModes = PlayerPrefs.GetString("Basic_Shapes2_displayMode" );
		displayMode = getDisplayModes.Split(","[0]);
		
		for(var i2=0;i2 <= array.length-1;i2++){
		store(array[i2],displayMode[i2]);
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

//================ Delete Data from the last ============================================

function removeShape(){

	if(array.length >=2){
		count = count -2;
		array.RemoveAt(array.length-1);
    	displayMode.RemoveAt(array.length-1);
    	
    	textdisplay =""; 
		for(i=0;i <= count;i++){
			textdisplay =  textdisplay + (i+1) + ")" + array[i] + ("  ");
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

//================ Store and Display the Data ===========================================

function store(shape:String,getDisplayMode:String){

array[count]=shape;
displayMode[count] = getDisplayMode;

textdisplay =""; 

for(i=0;i <= count;i++){
textdisplay =  textdisplay + (i+1) + ")" + array[i] + ("  ");
}


count++;
}

//================== Save Preferences =================================================

function SavePref(){
var temp:String;
var temp2:String;

for(i=0;i< array.length;i++)
{
     if(i!=array.length-1){
        temp+=array[i].ToString()+",";
        temp2+=displayMode[i].ToString()+",";
        }
        
     else{
        temp+=array[i].ToString();
        temp2+=displayMode[i].ToString();
        }
}
PlayerPrefs.SetString("Basic_Shapes2_array",temp);
PlayerPrefs.SetString("Basic_Shapes2_displayMode",temp2);
}

//================== Button Sequences =============================================

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
            var	loop:boolean = true;
        	GUI.contentColor = Color.red;  	
            if(GUI.Button(Rect(40,80,100,50),"color \n red"))
            	store("Color Red","Fade");
            if(GUI.Button(Rect(40,140,100,50),"red \n line"))
            	store("Red Line","Fade");
            if(GUI.Button(Rect(40,200,100,50),"red \n circle"))
            	store("Red Circle","Fade");
            if(GUI.Button(Rect(40,260,100,50),"red \n square"))
            	store("Red Square","Fade");
            if(GUI.Button(Rect(40,320,100,50),"red \n triangle"))
            	store("Red Triangle","Fade");
            		
          	GUI.contentColor = Color.green;  	
            if(GUI.Button(Rect(140+10,80,100,50),"color \n green"))
            	store("Color Green","Fade");
            if(GUI.Button(Rect(140+10,140,100,50),"green \n line"))
            	store("Green Line","Fade");
            if(GUI.Button(Rect(140+10,200,100,50),"green \n circle"))
            	store("Green Circle","Fade");
            if(GUI.Button(Rect(140+10,260,100,50),"green \n square"))
            	store("Green Square","Fade");
            if(GUI.Button(Rect(140+10,320,100,50),"green \n triangle"))
            	store("Green Triangle","Fade");
            	
          	GUI.contentColor = Color.blue;  	
			if(GUI.Button(Rect(240+20,80,100,50),"color \n blue"))
            	store("Color Blue","Fade");
            if(GUI.Button(Rect(240+20,140,100,50),"blue \n line"))
            	store("Blue Line","Fade");
            if(GUI.Button(Rect(240+20,200,100,50),"blue \n circle"))
            	store("Blue Circle","Fade");
            if(GUI.Button(Rect(240+20,260,100,50),"blue \n square"))
            	store("Blue Square","Fade");
            if(GUI.Button(Rect(240+20,320,100,50),"blue \n triangle"))
            	store("Blue Triangle","Fade");
            	
           	GUI.contentColor = Color.yellow;
            if(GUI.Button(Rect(340+30,80,100,50),"color \n yellow"))
            	store("Color Yellow","Fade");
            if(GUI.Button(Rect(340+30,140,100,50),"yellow \n line"))
            	store("Yellow Line","Fade");
            if(GUI.Button(Rect(340+30,200,100,50),"yellow \n circle"))
            	store("Yellow Circle","Fade");
            if(GUI.Button(Rect(340+30,260,100,50),"yellow \n square"))
            	store("Yellow Square","Fade");
            if(GUI.Button(Rect(340+30,320,100,50),"yellow \n triangle"))
            	store("Yellow Triangle","Fade");
            	
            			
            GUI.contentColor = Color.magenta;	
            if(GUI.Button(Rect(440+40,80,100,50),"color \n magenta"))
            	store("Color Magenta","Fade");
            if(GUI.Button(Rect(440+40,140,100,50),"magenta \n line"))
            	store("Magenta Line","Fade");
            if(GUI.Button(Rect(440+40,200,100,50),"magenta \n circle"))
            	store("Magenta Circle","Fade");
            if(GUI.Button(Rect(440+40,260,100,50),"magenta \n square"))
            	store("Magenta Square","Fade");
            if(GUI.Button(Rect(440+40,320,100,50),"magenta \n triangle"))
            	store("Magenta Triangle","Fade");
            		
            GUI.contentColor = Color.white;
            if(GUI.Button(Rect(540+50,80,100,50),"color \n white"))
            	store("Color White","Fade");
            if(GUI.Button(Rect(540+50,140,100,50),"white \n line"))
            	store("White Line","Fade");
            if(GUI.Button(Rect(540+50,200,100,50),"white \n circle"))
            	store("White Circle","Fade");
            if(GUI.Button(Rect(540+50,260,100,50),"white \n square"))
            	store("White Square","Fade");
            if(GUI.Button(Rect(540+50,320,100,50),"white \n triangle"))
            	store("White Triangle","Fade");
            		
            GUI.contentColor = Color.gray;	
            if(GUI.Button(Rect(640+60,80,100,50),"color \n gray"))
          	 	store("Color Gray","Fade");
          	if(GUI.Button(Rect(640+60,140,100,50),"gray \n line"))
            	store("Gray Line","Fade");
            if(GUI.Button(Rect(640+60,200,100,50),"gray \n circle"))
            	store("Gray Circle","Fade");
            if(GUI.Button(Rect(640+60,260,100,50),"gray \n square"))
            	store("Gray Square","Fade");
            if(GUI.Button(Rect(640+60,320,100,50),"gray \n triangle"))
            	store("Gray Triangle","Fade");
            	 	
          	GUI.contentColor = Color.black; 	
          	if(GUI.Button(Rect(740+75,80,100,50),"color \n black"))
          	 	store("Color Black","Fade");
          	if(GUI.Button(Rect(740+75,140,100,50),"black \n line"))
            	store("Black Line","Fade");
            if(GUI.Button(Rect(740+75,200,100,50),"black \n circle"))
            	store("Black Circle","Fade");
            if(GUI.Button(Rect(740+75,260,100,50),"black \n square"))
            	store("Black Square","Fade");
            if(GUI.Button(Rect(740+75,320,100,50),"black \n triangle"))
            	store("Black Triangle","Fade");
            	
          	GUI.contentColor = Color.white;
          	
          	if(GUI.Button(Rect(750+70,460,100,50),"Back"))
          		removeShape();
          	
          	
          	if(GUI.Button(Rect(600+70,460,100,50),"Main Menu"))
          		Application.LoadLevel ("Main Menu");
          	
          	if(GUI.Button(Rect(150+10,460,100,50),"Save \n Preferences"))
          		SavePref ();
          		
      		if(GUI.Button(Rect(350+30,460,100,50),"Start")){
      			var go:GameObject = GameObject.Find("Controller");
				var scriptCont:S2_ControlerScript = go.GetComponent(S2_ControlerScript);
  				scriptCont.StartPlaying(array,displayMode,loop);
  				
  				var go2:GameObject = GameObject.Find("DCExit");
				var scriptDoubleClick:DoubleClickToExit = go2.GetComponent(DoubleClickToExit);
  				scriptDoubleClick.Fadeout();
  				guiOn = false;
  				}
      		textdisplay = GUI.TextArea (Rect (40, 390, 875, 50), textdisplay, 500);
         
}
}

 
