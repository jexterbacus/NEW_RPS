#pragma strict
var rotEnable:boolean;
var go:GameObject;
function Start () {

}

function OnMouseOver () {

go.GetComponent(S7_Rotate).enabled = true;
go.GetComponent(S7_Rotate).rotEnable = rotEnable;
}

function OnMouseExit () {
go.GetComponent(S7_Rotate).enabled = false;
}


function Update () {
if(Input.GetMouseButtonUp(0))
rotEnable = true;

}