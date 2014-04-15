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

public var go : GameObject;
public var objectScript;
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
	
	if (Input.GetKeyDown(KeyCode.Escape)) 
   Application.LoadLevel ("Main Menu"); 
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
			go.GetComponent(S2_Fade).enabled = true;
			var scriptFade:S2_Fade = go.GetComponent(S2_Fade);
			scriptFade.StartFade(fadeout,duration,fadeMult);
		break;
	
		case "FadePlural":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(FadePlural).enabled = true;
			var scriptPlural:FadePlural = go.GetComponent(FadePlural);
			scriptPlural.StartFade(fadeout,duration,fadeMult,array[count]);
		break;
	
		case "MeshMorpher":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(MeshMorpher).enabled = true;
			var scriptMorpher:MeshMorpher = go.GetComponent(MeshMorpher);
			scriptMorpher.mMorph(fadeout, duration,fadeMult);
		break;
	
		case "Wipe":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(Wipe).enabled = true;
			var scriptWipe:Wipe = go.GetComponent(Wipe);
			scriptWipe.showShape(start,fadeout,duration,fadeMult);
		break;
		}
	//-------------------------
	
	//--------displayText------------- calling the display text of the shapes
		vtext = GameObject.Find("TextMesh");
		vtext.GetComponent(MeshRenderer).enabled = true;
		vtext.GetComponent(S2_TextFade).enabled = true;
		var vtextScript:S2_TextFade = vtext.GetComponent(S2_TextFade);
		vtextScript.StartText(array[count],start,fadeout,duration,fadeMult);
	//------------------------------------
	
	//---------callDialogue------------------
		goSound = GameObject.Find("Main Camera");
		var dialogueScript1:Dialogue = goSound.GetComponent(Dialogue);
		dialogueScript1.StartDialogue(array[count]);

		goSound2 = GameObject.Find("Main Camera");
		var dialogueScript2:Dialogue2 = goSound.GetComponent(Dialogue2);
		dialogueScript2.StartDialogue(array[count]);
	//----------------------------------------
	
		countIncr++;
	}
	
}



