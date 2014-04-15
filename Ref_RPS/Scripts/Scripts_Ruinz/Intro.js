#pragma strict
var go:GameObject;
function Start () {
yield WaitForSeconds(3);
go.GetComponent(Dialer).enabled = true;
guiTexture.enabled =false;
}

function Update () {

}