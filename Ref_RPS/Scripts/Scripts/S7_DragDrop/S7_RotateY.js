#pragma strict
var initMousePos:Vector2;
var direction:Vector2;
var go:GameObject;
var up:boolean;
var down:boolean;

function Start () {

}

function OnMouseOver () {

if(Input.GetMouseButtonDown(0)){
	up = true;
	down = true;
	initMousePos = Input.mousePosition;
	}

if(Input.GetMouseButton(0)){
	direction = Input.mousePosition - initMousePos;
	
	 if (direction.y > 7 && up == true){
	 	go.GetComponent(S7_Rotate).RotateYUp();
	 	up = false;
		}
	
	if (direction.y < -7 && down == true){
		go.GetComponent(S7_Rotate).RotateYDown();
		down = false;
		}
	}
}


function Update () {

}