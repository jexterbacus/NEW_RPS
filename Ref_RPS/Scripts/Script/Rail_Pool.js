#pragma strict

var rails : GameObject[];
var clone:GameObject;
var counterClone:int = 0;
var timepath:float;
var path:int;

function Start () {
FirstCloneObject();
CloneObject();
CloneObject();
CloneObject();
}

function FirstCloneObject (){
	clone = Instantiate(rails[counterClone], Vector3 (2,0,-10), Quaternion.identity) as GameObject;
    clone.name = ("Rails_" + counterClone);
}

function CloneObject (){
	var go:GameObject = GameObject.Find("Rails_" + counterClone);
	var setPos:Transform = go.transform.Find("Locator");
    clone = Instantiate(rails[path], setPos.transform.position, setPos.transform.rotation) as GameObject;
   	
   	counterClone++;  
    clone.name = ("Rails_" + counterClone);
    if (counterClone <= 30)
    path = counterClone/2;
  	else
  	path = 15;

}

function DestroyClone(){
var goDes:GameObject = GameObject.Find("Rails_" + (counterClone -4));
Destroy (goDes);
}

function Update () {

}