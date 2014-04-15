//#pragma strict
var go:GameObject;
function Start () {
	//GetComponent(S3_WipeB).enabled = false;
	go = GameObject.Find("Sphere");
	go.GetComponent(MeshRenderer).enabled = true;
	var scriptWipeB = go.GetComponent(S3_WipeB);
	scriptWipeB.enabled = true;
	//var scriptWipeA:S3_WipeA = go.GetComponent(S3_WipeA);
	//scriptWipeA.showShape(start,fadeout,duration,fadeMult);
}

function Update () {

}