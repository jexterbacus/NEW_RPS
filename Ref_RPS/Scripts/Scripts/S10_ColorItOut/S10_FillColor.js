#pragma strict
var tm:TextMesh;
var color:Color;
var shapeColor:String;
var pickColor:String;
var goMessage:GameObject;
function Start () {
tm = gameObject.GetComponent(TextMesh);
}

function OnMouseOver () {
if(Input.GetMouseButtonUp(0)){
	var go:GameObject = GameObject.Find("Message");
	color =	go.GetComponent(S10_Caller).color;
	pickColor =	go.GetComponent(S10_Caller).colorName;
	
	var goColorName = GameObject.Find(name + "Text");
	shapeColor = goColorName.GetComponent(TextMesh).text;
	
	if(shapeColor == pickColor){
	renderer.material.color = color;
	Correct();
	}
	else{
		Error();
		print("error");
		}
	}
}

function Error(){
goMessage = GameObject.Find("Message");
goMessage.GetComponent(TextMesh).text = "Sorry";
var go:GameObject = GameObject.Find(pickColor + "Line");
go.GetComponent(S10_Line).Return();

yield WaitForSeconds(2);
goMessage.GetComponent(TextMesh).text = "Color the shapes by their name";

}

function Correct(){
goMessage = GameObject.Find("Message");
goMessage.GetComponent(TextMesh).text = "Great";
yield WaitForSeconds(2);
goMessage.GetComponent(TextMesh).text = "Color the shapes by their name";

}

