#pragma strict
var colorName:String;
var color:Color;
var loadShapes = new Array();
var loadColors = new Array();
var placement:Transform[];
var random:int;
var i2:int;
var tm:TextMesh;


function Start () {
tm = gameObject.GetComponent(TextMesh);
Load();
}

function OnGUI() { 
	if (Input.GetKeyDown(KeyCode.Escape)) 
   	Application.LoadLevel ("Main Menu"); 
}

function Load (){
var colors = new Array("red","green","blue","yellow","purple","white","grey","black");
var shapes = new Array("Line","Square","SolidCircle","SolidSquare","SolidTriangle");// "Circle","Triangle"
i2 = 0;

for (var i:int = 0; i <= 4; i++){
	random = Random.Range(0,colors.length);
	loadColors[i] = colors[random];
	colors.RemoveAt(random);
	
	random = Random.Range(0,shapes.length);
	loadShapes[i] = shapes[random];
	shapes.RemoveAt(random);
	}
	
for (object in loadShapes){

	var go:GameObject = GameObject.Find(object+"Text");
	go.GetComponent(TextMesh).text = (loadColors[i2]);
	
	go = GameObject.Find(object);
	go.GetComponent(BoxCollider).enabled = true;
	//go.GetComponent(S6_OnMouse).enabled = true;
	go.GetComponent(Transform).transform.position = placement[i2].transform.position;
	
	if(object == "Cube" || object == "Cylinder" || object == "Sphere"  || object == "Cone" || object == "Pyramid"){
	print(object+"Rot");
	go = GameObject.Find(object+"Rot");

	go.GetComponent(MeshRenderer).enabled = true;
	go.GetComponent(S6_Rotation).enabled = true;
	}
	else{
	go.GetComponent(MeshRenderer).enabled = true;
	}
	
	i2++;
	}
}

function StoreColor (getcolor:Color,getname:String) {
color = getcolor;
colorName = getname;
}

function Update () {

}