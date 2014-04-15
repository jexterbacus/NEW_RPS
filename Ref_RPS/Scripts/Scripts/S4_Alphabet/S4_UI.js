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
//==============================================================

function Start(){
	

	if(PlayerPrefs.GetString("Alphabet_array")){
		getShapes = PlayerPrefs.GetString("Alphabet_array");
		array = getShapes.Split(","[0]);
		
		getDisplayModes = PlayerPrefs.GetString("Alphabet_displayMode" );
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

//==============================================================

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

//===================================================================

function store(shape:String,getDisplayMode:String){

array[count]=shape;
displayMode[count] = getDisplayMode;

textdisplay =""; 

for(i=0;i <= count;i++){
textdisplay =  textdisplay + (i+1) + ")" + array[i] + ("  ");
}


count++;
}

//===================================================================
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
PlayerPrefs.SetString("Alphabet_array",temp);
PlayerPrefs.SetString("Alphabet_displayMode",temp2);
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
            if(GUI.Button(Rect(50,80,100,50),"ALPHABET")){
            	store("A","Wipe");
            	store("B","Wipe");
            	store("C","Wipe");
            	store("D","Wipe");
            	store("E","Wipe");
            	store("F","Wipe");
            	store("G","Wipe");
            	store("H","Wipe");
            	store("I","Wipe");
            	store("J","Wipe");
            	store("K","Wipe");
            	store("L","Wipe");
            	store("M","Wipe");
            	store("N","Wipe");
            	store("O","Wipe");
            	store("P","Wipe");
            	store("Q","Wipe");
            	store("R","Wipe");
            	store("S","Wipe");
            	store("T","Wipe");
            	store("U","Wipe");
            	store("V","Wipe");
            	store("W","Wipe");
            	store("X","Wipe");
            	store("Y","Wipe");
            	store("Z","Wipe");
            	
            	
            	}
             if(GUI.Button(Rect(150,80,100,50),"alphabet")){
            	store("a","Wipe");
            	store("b","Wipe");
            	store("c","Wipe");
            	store("d","Wipe");
            	store("e","Wipe");
            	store("f","Wipe");
            	store("g","Wipe");
            	store("h","Wipe");
            	store("i","Wipe");
            	store("j","Wipe");
            	store("k","Wipe");
            	store("l","Wipe");
            	store("m","Wipe");
            	store("n","Wipe");
            	store("o","Wipe");
            	store("p","Wipe");
            	store("q","Wipe");
            	store("r","Wipe");
            	store("s","Wipe");
            	store("t","Wipe");
            	store("u","Wipe");
            	store("v","Wipe");
            	store("w","Wipe");
            	store("x","Wipe");
            	store("y","Wipe");
            	store("z","Wipe");
            	
            	
            	}
            	
             if(GUI.Button(Rect(250,80,100,50),"ALPHABET \n alphabet")){
            	store("Aa","Wipes");
            	store("Bb","Wipes");
            	store("Cc","Wipes");
            	store("Dd","Wipes");
            	store("Ee","Wipes");
            	store("Ff","Wipes");
            	store("Gg","Wipes");
            	store("Hh","Wipes");
            	store("Ii","Wipes");
            	store("Jj","Wipes");
            	store("Kk","Wipes");
            	store("Ll","Wipes");
            	store("Mm","Wipes");
            	store("Nn","Wipes");
            	store("Oo","Wipes");
            	store("Pp","Wipes");
            	store("Qq","Wipes");
            	store("Rr","Wipes");
            	store("Ss","Wipes");
            	store("Tt","Wipes");
            	store("Uu","Wipes");
            	store("Vv","Wipes");
            	store("Ww","Wipes");
            	store("Xx","Wipes");
            	store("Yy","Wipes");
            	store("Zz","Wipes");
            	
            	
            	}
            /*
            if(GUI.Button(Rect(150+10,80,100,50),"dots"))
            	store("Dots","FadePlural");
            	
			if(GUI.Button(Rect(250+20,80,100,50),"line"))
            	store("Line","MeshMorpher");
            	
            if(GUI.Button(Rect(350+30,80,100,50),"lines"))
            	store("Lines","FadePlural");
            	
            if(GUI.Button(Rect(450+40,80,100,50),"square"))
            	store("Square","Wipe");
            	
            if(GUI.Button(Rect(550+50,80,100,50),"squares"))
            	store("Squares","FadePlural");
            	
            if(GUI.Button(Rect(550+50,140,100,50),"solid small \n square"))
            	store("SolidSmallSquare","MeshMorpher");
            
            if(GUI.Button(Rect(550+50,200,100,50),"solid small \n squares"))
            	store("SolidSmallSquares","FadePlural");
            	
            if(GUI.Button(Rect(450+40,140,100,50),"solid \n square"))
          	 	store("SolidSquare","MeshMorpher");
          	 	
          	if(GUI.Button(Rect(450+40,200,100,50),"solid \n squares"))
          	 	store("SolidSquares","FadePlural");
            	
            if(GUI.Button(Rect(450+40,260,100,50),"small \n square"))
          	 	store("SmallSquare","Wipe");
          	 	
          	if(GUI.Button(Rect(450+40,320,100,50),"small \n squares"))
          	 	store("SmallSquares","FadePlural"); 	
          	 	
            if(GUI.Button(Rect(650+60,80,100,50),"circle"))
          	 	store("Circle","Wipe");
          	 	
            if(GUI.Button(Rect(650+60,140,100,50),"circles"))
          	 	store("Circles","FadePlural"); 
          	 
         	if(GUI.Button(Rect(650+60,200,100,50),"solid \n circle"))
          	 	store("SolidCircle","Fade");
          	 
          	if(GUI.Button(Rect(650+60,260,100,50),"solid \n circles"))
          	 	store("SolidCircles","FadePlural");
          	 
          	if(GUI.Button(Rect(650+60,320,100,50),"small \n circles"))
          	 	store("SmallCircles","FadePlural");	
          	 
          	if(GUI.Button(Rect(750+80,80,100,50),"triangle"))
          	 	store("Triangle","Wipe");	
          	 
            if(GUI.Button(Rect(750+80,140,100,50),"triangles"))
          	 	store("Triangles","FadePlural");
          	*/
          	 	
          	
          	if(GUI.Button(Rect(750+70,460,100,50),"Back")){
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();
          		removeShape();    		
          		}
          	
          	
          	if(GUI.Button(Rect(600+70,460,100,50),"Main Menu"))
          		Application.LoadLevel ("Main Menu");
          	
          	if(GUI.Button(Rect(150+10,460,100,50),"Save \n Preferences"))
          		SavePref ();
          		
      		if(GUI.Button(Rect(350+30,460,100,50),"Start")){
      			var go:GameObject = GameObject.Find("Controller");
				var objectScriptCont:S4_ControlerScript = go.GetComponent(S4_ControlerScript);
  				objectScriptCont.StartPlaying(array,displayMode,loop);
  				
  				var go2:GameObject = GameObject.Find("DCExit");
				var ScriptDouble:DoubleClickToExit = go2.GetComponent(DoubleClickToExit);
  				ScriptDouble.Fadeout();
  				guiOn = false;
  				}
      		textdisplay = GUI.TextArea (Rect (50, 390, 875, 50), textdisplay, 500);
         
}
}

 
