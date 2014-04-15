#pragma strict
var rotEnable:boolean;
function Start () {

}

function OnMouseOver () {
GetComponent(S7_Rotate).enabled = true;
GetComponent(S7_Rotate).rotEnable = rotEnable;
}

function OnMouseExit () {
}


function Update () {
if(Input.GetMouseButtonUp(0))
rotEnable = true;

}