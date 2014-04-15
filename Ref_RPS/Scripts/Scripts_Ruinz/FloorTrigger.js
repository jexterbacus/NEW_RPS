#pragma strict
var playOnce:boolean;
var triggerFloor:boolean = false;

function Start () {
playOnce = true;
}

function Update () {

}

function OnTriggerEnter (other : Collider) {
if(other.name=="Roy_Walk_plotted"){
	if(playOnce == true){
		animation.Play();
		playOnce = false;
		yield WaitForSeconds(.7);
		GetComponent(BoxCollider).enabled = false;

		}
 	else
 		return;
 	}
}