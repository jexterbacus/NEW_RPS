#pragma strict
var tm:String;

function Start () {

}

function OnMouseOver () {
	print("collide");
	if(tm == "correct"){
	GetComponent(MeshRenderer).enabled = true; 
}
}
function Update () {

	var go:GameObject = GameObject.Find("PressText");
	tm = go.GetComponent(S6_PressText).tm.text;
print ("TM " + tm);
}