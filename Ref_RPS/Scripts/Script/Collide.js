#pragma strict

function OnTriggerEnter (other : Collider) {
	if(other.name == "NextRail"){
	var go:GameObject = GameObject.Find("Increment");
	go.GetComponent(Rail_Pool).DestroyClone();
	
	yield WaitForSeconds (1);
	go.GetComponent(Rail_Pool).CloneObject();
	}
}