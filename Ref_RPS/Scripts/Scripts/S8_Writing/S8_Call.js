#pragma strict
var alphabet = new Array("A","B","C","D","E");
var counter : int = 0;
var go:GameObject;
var goChild:GameObject;
var childcount:int;
var count:int;
function Start () {
count = 0;
Call();
}

function Off () {

go = GameObject.Find(alphabet[counter-1]);
childcount = go.transform.childCount;
for (var i:int = 1; i<= childcount; i++){
	var iString = i.ToString();
	
	
	goChild = GameObject.Find((alphabet[counter-1]) + iString + "_bg");
	goChild.GetComponent(MeshRenderer).enabled = false;
	
	goChild = GameObject.Find((alphabet[counter-1]) + iString);
	goChild.GetComponent(MeshRenderer).enabled = false;
	goChild.GetComponent(MeshCollider).enabled = false;
	goChild.GetComponent(S8_MouseOver).enabled = false;
	}
}

function Call () {
if (counter <= 3){
go = GameObject.Find(alphabet[counter]);
childcount = go.transform.childCount;
for (var i:int = 1; i<= childcount; i++){
	var iString = i.ToString();
	
	
	goChild = GameObject.Find((alphabet[counter]) + iString + "_bg");
	goChild.GetComponent(MeshRenderer).enabled = true;
	
	goChild = GameObject.Find((alphabet[counter]) + iString);
	goChild.GetComponent(MeshRenderer).enabled = true;
	goChild.GetComponent(MeshCollider).enabled = true;
	goChild.GetComponent(S8_MouseOver).enabled = true;
	}
	
counter++;
}
else
Application.LoadLevel ("Main Menu");
}


function Count (){
count++;
if (count == childcount){
count = 0;
yield WaitForSeconds (2);
Off();
Call();
}
}

function Update () {
if (Input.GetKeyDown(KeyCode.Escape)) 
   	Application.LoadLevel ("Main Menu"); 
}