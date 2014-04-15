#pragma strict
var go:GameObject;
var charFacing:GameObject;

var duration:float = 2;
var t:float;
var turn:boolean;
var rotSpeed:float;
var rotDirection:Vector3;
var newRotation:Quaternion;
var colliderRot:int;
function Start () {


turn = false;
}
function OnTriggerEnter (other : Collider){

if(other.name == "Roy_Walk_plotted"){
t = 0;
colliderRot = Mathf.RoundToInt(transform.rotation.eulerAngles.y);
charFacing.GetComponent(CharRotation).FaceDirection(colliderRot);

turn = true;
switch(colliderRot){

	case 0:
		rotDirection = Vector3(0,0,1);
		break;
		
	case 90:
		rotDirection = Vector3(1,0,0);
		break;
	case -90:
		rotDirection = Vector3(-1,0,0);
		break;

	case 180:
		rotDirection = Vector3(0,0,-1);
		break;
	case -180:
		rotDirection = Vector3(0,0,1);
		break;

	case 270:
		rotDirection = Vector3(-1,0,0);
		break;
	case -270:
		rotDirection = Vector3(1,0,0);
		break;
		
	}
	}
}
function Update () {
  
	if(turn){
		t += 1 * Time.deltaTime;
		newRotation = Quaternion.LookRotation(rotDirection);
		go.transform.rotation = Quaternion.Slerp(go.transform.rotation, newRotation, t * rotSpeed);
		}
	if(t>=1)
		turn = false;
}