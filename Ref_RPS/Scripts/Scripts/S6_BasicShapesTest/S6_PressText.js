#pragma strict

var loadShapes = new Array();
var placement:Transform[];
var tm:TextMesh;
var random:int;
var i2:int;



var shapeName:String;

function Start () {

tm = gameObject.GetComponent(TextMesh);
Load();
}

function Load (){
var shapes = new Array("Circle","Square","Line","Triangle","Cube","SmallCube");//"Dot","Line","Triangle","SmallSquare","SolidCircle","SolidSmallSquare","SolidSquare","SolidTriangle",,"SmallCube"
i2 = 0;
for (var i:int = 0; i <= 3; i++){
	random = Random.Range(0,shapes.length);
	loadShapes[i] = shapes[random];
	shapes.RemoveAt(random);
	}

for (object in loadShapes){
	var go:GameObject = GameObject.Find(object);
	
	go.GetComponent(BoxCollider).enabled = true;
	go.GetComponent(S6_OnMouse).enabled = true;
	go.GetComponent(Transform).transform.position = placement[i2].transform.position;
	
	if(object == "Cube" || object == "SmallCube"){
	print(object+"Rot");
	go = GameObject.Find(object+"Rot");

	go.GetComponent(MeshRenderer).enabled = true;
	}
	else{
	go.GetComponent(MeshRenderer).enabled = true;
	}
	
	i2++;
	}


Test ();
}

function Test () {

random = Random.Range(0,loadShapes.length);
var go:GameObject = GameObject.Find(loadShapes[random]);

shapeName = go.GetComponent(S6_OnMouse).colName;

go = GameObject.Find("MainCamera");
go.GetComponent(S6_Dialogue).Press();
go.GetComponent(S6_Dialogue).StartDialogue(shapeName);
tm.text = "press the " + shapeName;
}


function Match (match:String,objectName:String){

if (match == shapeName){
	tm.text = "correct";

	var go:GameObject = GameObject.Find(objectName + "Correct");
	go.GetComponent(MeshRenderer).enabled = true;
	
	if(loadShapes.length >= 2){
	loadShapes.RemoveAt(random);
	yield WaitForSeconds(1);
	go.GetComponent(MeshRenderer).enabled = false;
	go = GameObject.Find(objectName);
	go.GetComponent(BoxCollider).enabled = false;
	go.GetComponent(S6_OnMouse).enabled = false;
	
	if(objectName == "Cube" || objectName == "SmallCube"){
	go = GameObject.Find(objectName+"Rot");
	go.GetComponent(MeshRenderer).enabled = false;
	}
	
	else{
	go.GetComponent(MeshRenderer).enabled = false;
	}
	
	Test();
			}
			
	else{
		yield WaitForSeconds(1);
		go.GetComponent(MeshRenderer).enabled = false;
		go = GameObject.Find(objectName);
		go.GetComponent(BoxCollider).enabled = false;
		go.GetComponent(S6_OnMouse).enabled = false;
		
		if(objectName == "Cube" || objectName == "SmallCube"){
		go = GameObject.Find(objectName+"Rot");
		go.GetComponent(MeshRenderer).enabled = false;
		}
	
	else{
		go.GetComponent(MeshRenderer).enabled = false;
		}
		Load ();
			}
	
	
	
	
	}

else {
	tm.text = "wrong";
	go = GameObject.Find(objectName + "Wrong");
	go.GetComponent(MeshRenderer).enabled = true;
	
	yield WaitForSeconds(1);
	go.GetComponent(MeshRenderer).enabled = false;
	go = GameObject.Find("MainCamera");
	go.GetComponent(S6_Dialogue).Press();
	go.GetComponent(S6_Dialogue).StartDialogue(shapeName);
	tm.text = "press the " + shapeName;
}
}

function Update () {

}
