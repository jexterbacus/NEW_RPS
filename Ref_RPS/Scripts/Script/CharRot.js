#pragma strict
private var newRotation:Quaternion;
var rotDirection:Vector3;
private var rotDirection2:Vector3;
private var acceleration:Vector3;

var rotSpeed:float = 4;
var frontTilt = 0.5;
var facing:int;

function Update () {
	//rotDirection = Vector3(Input.acceleration.x*3,0,1);//Accelerator Controller
	rotDirection = Vector3(Input.GetAxis("Horizontal"),0,1);//KeyBoard Controller

	newRotation = Quaternion.LookRotation(rotDirection);
	transform.rotation = Quaternion.Slerp(transform.rotation, newRotation, Time.deltaTime * rotSpeed);
}
