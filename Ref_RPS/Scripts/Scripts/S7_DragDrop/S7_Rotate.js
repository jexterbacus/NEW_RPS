#pragma strict
var initMousePos:Vector2;
var direction:Vector2;

var speed:float = 70;
var rotTime:float;
var rotLeft:boolean = false;
var rotRight:boolean = false;
var rotUp:boolean = false;
var rotDown:boolean = false;
var rotYUp:boolean = false;
var rotYDown:boolean = false;

var right:boolean = true;
var left:boolean = true;
var up:boolean = true;
var down:boolean = true;
var rotEnable:boolean = true;
var rotAgain:boolean = true;
function Start () {

}


function OnMouseOver () {
if (rotEnable){

	if(Input.GetMouseButtonDown(0) && rotAgain == true){
		rotTime = 0;
		right = left = up = down = true;
		initMousePos = Input.mousePosition;
		}

	if(Input.GetMouseButton(0)){
		direction = Input.mousePosition - initMousePos;
	
		if (direction.x > 7 && right == true){
			up = down = false; 
			rotRight = true;
			right = false;
			rotAgain = false;
			
			}
		
		if (direction.x < -7 && left == true){
			up = down = false; 
			rotLeft = true;
			left = false;
			rotAgain = false;
			}
	
		if (direction.y > 7 && up == true){
			right = left = false;
			rotUp = true;
			up = false;
			rotAgain = false;
			}
	
		if (direction.y < -7 && down == true){
			right = left = false;
			rotDown = true;
			down = false;
			rotAgain = false;
			}
		}
	}
}

function RotateYUp (){
rotTime = 0;
rotYUp = true;
 
} 

function RotateYDown (){
rotTime = 0;
rotYDown = true;
}


function Update () {
//Input.mousePosition;
	if (rotRight){
		transform.Rotate(Vector3.forward * speed *-1 * Time.deltaTime,Space.World);
		rotTime += speed *-1 * Time.deltaTime;
		if (rotTime <= -89.7){
			rotRight = false;
			rotAgain = true;
			}
	}
	if (rotLeft){
		transform.Rotate(Vector3.forward * speed * Time.deltaTime,Space.World);
		rotTime += speed * Time.deltaTime;
		if (rotTime >= 89.7){
			rotLeft = false;
			rotAgain = true;
			}
	}
	
	if (rotUp){
		transform.Rotate(Vector3.right * speed * Time.deltaTime,Space.World);
		rotTime += speed * Time.deltaTime;
		if (rotTime >= 89.7){
			rotUp = false;
			rotAgain = true;
			}
	}
	
	if (rotDown){
		transform.Rotate(Vector3.right * speed * -1 * Time.deltaTime,Space.World);
		rotTime += speed * -1 * Time.deltaTime;
		if (rotTime <= -89.7){
			rotDown = false;
			rotAgain = true;
			}
	}
	
	if (rotYUp){
		transform.Rotate(Vector3.up * speed * -1 * Time.deltaTime,Space.World);
		rotTime += speed * -1 * Time.deltaTime;
		if (rotTime <= -89.7){
			rotYUp = false;
			rotAgain = true;
			}
	}
	
	if (rotYDown){
		transform.Rotate(Vector3.up * speed * Time.deltaTime,Space.World);
		rotTime += speed * Time.deltaTime;
		if (rotTime >= 89.7){
			rotYDown = false;
			rotAgain = true;
			}
	}
}
