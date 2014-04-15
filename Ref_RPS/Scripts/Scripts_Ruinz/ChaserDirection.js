#pragma strict
var count:int = 0;
var fugitive:GameObject;
var fugLoc:Vector3;
var chaser:GameObject;

function Start (){
//fugitive = GameObject.Find("Roy_Walk_plotted");
}

function OnCall (){
	count++;
	var clone:GameObject;
	clone = Instantiate (gameObject, fugitive.transform.position, Quaternion.identity);
	clone.name = ("PointOfChaste" + count);
	chaser.GetComponent(Chaser).NumPoints(count);
}

function OnTriggerEnter(other:Collider){
if(other.name == "Chaser"){
	chaser.GetComponent(Chaser).NextTarget();
	}

}