#pragma strict

function Start () {

}

function OnMouseOver () {
GetComponent(S7_Drag).enabled = true;
}

function OnMouseExit () {
//if(Input.GetMouseButtonUp(0)){
GetComponent(S7_Drag).enabled = false;
//}
}