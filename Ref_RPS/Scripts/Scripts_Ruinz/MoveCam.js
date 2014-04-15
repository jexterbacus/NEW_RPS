#pragma strict
var camTransform:Vector3;
var cylinderPos:Vector3;
var go:GameObject;
var swichtFwd:boolean = false;
var swichtLtf:boolean = false;
var swichtRth:boolean = false;
var cylinderLeft:Vector3;

function Start () {

	
	go = GameObject.Find("Cylinder");
	camTransform = transform.position;
	}

function forward(){
	
	swichtFwd = true;
	
}

function right(){
	
	swichtRth = true;
	cylinderLeft = go.GetComponent(Transform).position;
	
}

function left(){
	
	swichtLtf = true;
	
    
}

function Update (){ 

 	if(swichtFwd == true){
 		cylinderPos = go.GetComponent(Transform).position;
		transform.position.z = transform.position.z * -1;
		swichtFwd = false;
 	}

    if(swichtLtf == true){
        cylinderPos = go.GetComponent(Transform).position;
 		transform.position.x = cylinderLeft.x + cylinderPos.x;
		swichtLtf = false;
 	}

	if(swichtRth == true){
 		
		transform.position.x = cylinderLeft.x - cylinderPos.x;
		transform.position.x = transform.position.x * -1;
		swichtRth= false;
 	}





}

