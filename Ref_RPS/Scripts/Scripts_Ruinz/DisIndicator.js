#pragma strict
var go:GameObject;
var go2:GameObject;
var distance:float;
function Start () {

}

function Update () {
distance = Vector3.Distance(go.transform.position,go2.transform.position);
transform.position.z = distance*-1;
}