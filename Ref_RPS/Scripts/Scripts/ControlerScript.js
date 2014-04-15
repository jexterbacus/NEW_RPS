#pragma strict
var array = new Array();
var plural = new Array();
var displayMode = new Array();					
						
private var arraySize:int; 
						
var start:int = 2;
var fadeout:int = 6;
var duration:int = 10;
var fadeMult:float = 2;					

var countIncr:int = 0;						
var count:int;
var time:float;

var go : GameObject;

public var vtext : GameObject;
public var vtextScript;
var goSound: GameObject;
var goSoundScript;
var goSound2: GameObject;
var goSoundScript2;

var loop:boolean = false;
var doubleClick:boolean = false;

function OnGUI() { 
	
	//GUI.matrix = Matrix4x4.TRS(new Vector3(GUIsF.x,GUIsF.y,0),Quaternion.identity,GUIsF);

	if(doubleClick){
	var e : Event = Event.current; 
	if (e.isMouse && e.type == EventType.MouseDown && e.clickCount == 2) 
		Application.LoadLevel ("Main Menu");
	}
}

//===========================================
					
function StartPlaying(arraySource:Array, queDisplayMode:Array, cloop:boolean){
array = arraySource;
arraySize = array.length;
displayMode = queDisplayMode;
loop = cloop;
doubleClick = true;
yield WaitForSeconds(3);
Call();
}

//------------funtion Call--------------------

function Call () {

	//-------looping------
	if(loop)
		count = countIncr %arraySize;
	else
		count = countIncr;
		
	//--------------------
	
	if(count == array.length)
		Application.LoadLevel ("Main Menu");
	else{
	
		//--------diplayMode-------- calling the display type of the shapes
		switch(displayMode[count]){
		case "Fade":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(Fade).enabled = true;
			var objectScript1:Fade = go.GetComponent(Fade);
			objectScript1.StartFade(fadeout,duration,fadeMult);
		break;
		
		case "FadePlural":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(FadePlural).enabled = true;
			var objectScript2:FadePlural = go.GetComponent(FadePlural);
			objectScript2.StartFade(fadeout,duration,fadeMult,array[count]);
		break;

		case "MeshMorpher":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(MeshMorpher).enabled = true;
			var objectScript3:MeshMorpher = go.GetComponent(MeshMorpher);
			objectScript3.mMorph(fadeout, duration,fadeMult);
		break;
	
		case "Wipe":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(Wipe).enabled = true;
			var objectScript4:Wipe = go.GetComponent(Wipe);
			objectScript4.showShape(start,fadeout,duration,fadeMult);
		break;
		}
	//------------------------
	
	//--------displayText------------- calling the display text of the shapes
		vtext = GameObject.Find("TextMesh");
		vtext.GetComponent(MeshRenderer).enabled = true;
		vtext.GetComponent(TextFade).enabled = true;
		var vtextScript:TextFade = vtext.GetComponent(TextFade);
		vtextScript.StartText(array[count],start,fadeout,duration,fadeMult);
	//------------------------------------
	
	//---------callDialogue------------------
		goSound = GameObject.Find("Main Camera");
		var goSoundScript:Dialogue = goSound.GetComponent(Dialogue);
		goSoundScript.StartDialogue(array[count]);

		goSound2 = GameObject.Find("Main Camera");
		var goSoundScript2:Dialogue2 = goSound.GetComponent(Dialogue2);
		goSoundScript2.StartDialogue(array[count]);
	//----------------------------------------
	
		countIncr++;
	}
	
}

