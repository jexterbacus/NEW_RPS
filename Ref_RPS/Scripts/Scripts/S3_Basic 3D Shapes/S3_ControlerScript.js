#pragma strict
var array = new Array();
var plural = new Array();
var displayMode = new Array();
var camTrans = new Array();				
						
private var arraySize:int; 
						
var start:int = 2;
var fadeout:int = 7;
var duration:int = 10;
var fadeMult:float = 2;					

var countIncr:int = 0;						
var count:int;
var time:float;

public var go : GameObject;
public var objectScript;

public var vtext : GameObject;
public var vtextScript;

public var mainCam: GameObject;
public var mainCamScript;

public var BG3D : GameObject;
public var BG3DScript;

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
					
function StartPlaying(arraySource:Array, queDisplayMode:Array, cloop:boolean, camTransSource:Array){
array = arraySource;
arraySize = array.length;
displayMode = queDisplayMode;
loop = cloop;
camTrans = camTransSource;
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
			go.GetComponent(S3_Fade).enabled = true;
			go.GetComponent(S3_Fade).StartFade(fadeout,duration,fadeMult);
		break;
		
		case "FadePlural":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(S3_FadePlural).enabled = true;
			go.GetComponent(S3_FadePlural).StartFade(fadeout,duration,fadeMult,array[count]);
			
			BG3D = GameObject.Find("BGButtom");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
			
			BG3D = GameObject.Find("BGBack");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
		break;

		case "WipeA":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(S3_WipeA).enabled = true;
			go.GetComponent(S3_WipeA).showShape(start,fadeout,duration,fadeMult);
		break;
		
		case "WipeB":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(S3_WipeB).enabled = true;
			var scriptWipeB:S3_WipeB = go.GetComponent(S3_WipeB);
			scriptWipeB.showShape(start,fadeout,duration,fadeMult);
			
			BG3D = GameObject.Find("BGButtom");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
			
			BG3D = GameObject.Find("BGBack");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
		break;
		
		case "WipePlural":
			go = GameObject.Find(array[count]);
			go.GetComponent(MeshRenderer).enabled = true;
			go.GetComponent(S3_WipePlural).enabled = true;
			var scriptWipePlural:S3_WipePlural = go.GetComponent(S3_WipePlural);
			scriptWipePlural.showShape(start,fadeout,duration,fadeMult,array[count]);
			
			BG3D = GameObject.Find("BGButtom");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
			
			BG3D = GameObject.Find("BGBack");
			BG3D.GetComponent(MeshRenderer).enabled = true;
			BG3D.GetComponent(S3_BG3D).enabled = true;
			BG3D.GetComponent(S3_BG3D).Startfade(fadeout);
		break;
		}
	//-------------------------
	var pos0:int = 0;
	var pos1:int = 1;
		switch(camTrans[count]){
		
		case "Front":
			mainCam = GameObject.Find("Main_Camera");
			var mainCamScript:S3_Smooth_Translate = mainCam.GetComponent(S3_Smooth_Translate);
			mainCamScript.Pos(pos1);
		break;
		
		case "Top":
			mainCam = GameObject.Find("Main_Camera");
			mainCamScript = mainCam.GetComponent(S3_Smooth_Translate);
			mainCamScript.Pos(pos0);
		break;		
		}
	//--------displayText------------- calling the display text of the shapes
		vtext = GameObject.Find("TextMesh");
		if (displayMode[count] == "WipePlural")
		vtext.GetComponent(S3_TextFade).StartText(array[count],start+1,fadeout,duration,fadeMult);
		else
		vtext.GetComponent(S3_TextFade).StartText(array[count],start,fadeout,duration,fadeMult);
	//------------------------------------
	
	//---------callDialogue-----------------
		goSound = GameObject.Find("Main_Camera");
		if (displayMode[count] == "WipePlural")
		goSound.GetComponent(S3_Dialogue).StartDialogue(array[count],1);
		
		else
		goSound.GetComponent(S3_Dialogue).StartDialogue(array[count],0);

		
		goSound2 = GameObject.Find("Main_Camera");
		if (displayMode[count] == "WipePlural")
		goSound2.GetComponent(S3_Dialogue2).StartDialogue(array[count],1);
		
		else{
		goSound2.GetComponent(S3_Dialogue2).StartDialogue(array[count],0);
		print("dialogues");
		}
	//----------------------------------------
	
		countIncr++;
	}
	
}



