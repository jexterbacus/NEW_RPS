#pragma strict
var shapeName:String;
private var storeLoc:Vector3;
var storeOn:boolean;
private var go:GameObject;
var t:float;
var duration:float = 1;
var move:boolean = false;
var returnBack:boolean = false;
var obCollider:Collider;
var colRot:Vector3;
var detectRot:Vector3;

function Start () {
detectRot = transform.rotation.eulerAngles;
t = 0;
storeOn = true;
}

function OnTriggerEnter (col : Collider){
obCollider = col;
if(shapeName == col.name){
	
	move = true;
	go = GameObject.Find(col.name);
	go.GetComponent(S7_Drag).pair = true;
	
	if(storeOn){
		storeLoc = go.GetComponent(Transform).transform.position;
		colRot = go.GetComponent(Transform).transform.rotation.eulerAngles;
		storeOn = false;
		}
	
	
	print ("horray");
	}
	
else{
	returnBack = true;
	//if(Input.GetMouseButtonUp(0)){
		
		print ("wrong");
	//	}

	}
}

function Update () {

	detectRot = transform.rotation.eulerAngles;

if (move && t <= 1){
	t += 1 * Time.deltaTime / duration;
	go.GetComponent(Transform).transform.position.x = Mathf.SmoothStep(storeLoc.x, transform.position.x, t);
	go.GetComponent(Transform).transform.position.z = Mathf.SmoothStep(storeLoc.z, transform.position.z, t);
	go.GetComponent(Transform).transform.rotation.eulerAngles.y = detectRot.y; //Mathf.SmoothStep(colRot.y, detectRot.y, t);// Vector3 (Mathf.SmoothStep(colRot.x, detectRot.x, t), Mathf.SmoothStep(colRot.y, detectRot.y, t),Mathf.SmoothStep(colRot.z, detectRot.z, t)) ;
	go.GetComponent(S7_Drag).moveOn = false;
	}

if (returnBack && Input.GetMouseButtonUp(0)){
	obCollider.GetComponent(Transform).transform.position = obCollider.GetComponent(S7_Drag).startPos;
	returnBack = false;
	}
}