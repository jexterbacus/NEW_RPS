#pragma strict

var increment:float = 0;
var incrementGo:GameObject;
var script:boolean;
var trigger = true;


function OnTriggerEnter (other : Collider) {
if(other.name == "Roy_Walk_plotted" && trigger == true){
	//count++;
	//var gos:GameObject[] = GameObject.FindGameObjectsWithTag("Set1");
	//Destroy (gos[1]);
	incrementGo.GetComponent(Increment).CloneObject();
	incrementGo.GetComponent(Increment).DestroyClone();
	
	
	incrementGo.GetComponent(Increment).RandomCrack();
	

	trigger = false;
	}

}
