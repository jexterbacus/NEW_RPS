#pragma strict
private var newRotation:Quaternion;
private var rotDirection:Vector3;
private var rotDirection2:Vector3;
private var acceleration:Vector3;

var rotSpeed:float = 4;
var frontTilt = 0.5;
var facing:int;
function Start () {

}
function FaceDirection (getfacing:int) {
facing = getfacing;

}
function Update () {
acceleration.y = Input.acceleration.y + frontTilt;

switch(facing){

	case 0:
		rotDirection = Vector3(Input.acceleration.x,0,acceleration.y);//Accelerator Controller
		//rotDirection = Vector3(Input.GetAxis("Horizontal"),0,Input.GetAxis("Vertical"));//KeyBoard Controller
		break;
		
	case 90:
		rotDirection = Vector3(acceleration.y,0,Input.acceleration.x*-1);//Accelerator Controller
		//rotDirection = Vector3(Input.GetAxis("Vertical"),0,Input.GetAxis("Horizontal")*-1);//KeyBoard Controller
		break;

	case 180:
		rotDirection = Vector3(Input.acceleration.x*-1,0,acceleration.y*-1);//Accelerator Controller
		//rotDirection = Vector3(Input.GetAxis("Horizontal")*-1,0,Input.GetAxis("Vertical")*-1);//KeyBoard Controller
		break;

	case 270:
		rotDirection = Vector3(acceleration.y*-1,0,Input.acceleration.x);//Accelerator Controller
		//rotDirection = Vector3(Input.GetAxis("Vertical")*-1,0,Input.GetAxis("Horizontal"));//KeyBoard Controller
		break;
		
	}
	
if(Mathf.Abs(Input.acceleration.x) >= 0.05 || Mathf.Abs(acceleration.y) >= 0.05){
	newRotation = Quaternion.LookRotation(rotDirection);
	transform.rotation = Quaternion.Slerp(transform.rotation, newRotation, Time.deltaTime * rotSpeed);
}
/*
if(Input.GetAxis("Horizontal")||Input.GetAxis("Vertical")){
rotDirection = Vector3(Input.GetAxis("Horizontal"),0,Input.GetAxis("Vertical"));
newRotation = Quaternion.LookRotation(rotDirection);
transform.rotation = Quaternion.Slerp(transform.rotation, newRotation, Time.deltaTime * rotSpeed);
}
*/


}