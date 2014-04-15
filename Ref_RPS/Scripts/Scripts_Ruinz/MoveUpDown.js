#pragma strict
var upDown:float;
var speed:int = 2;
var hightDiv:int = 150;
var t:float;
function Start () {

}

function Update () {

transform.Translate(Vector3.up * upDown);
t += speed *(Time.deltaTime);
upDown = (Mathf.Sin(t))/hightDiv;

}