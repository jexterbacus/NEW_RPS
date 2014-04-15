#pragma strict
var skinGui:GUISkin;
var speed : float = 6.0;
var gravity : float = 20.0;
var jumpSpeed :float = 8.0;
var frontTilt:float = 0.5;

private var controller : CharacterController; 
var jumpOn:boolean;
private var inputX:float;
private var inputY:float;
private var acceleration:Vector3;
private var initMousePos:Vector2;
var moveDirection : Vector3 = Vector3.zero;
var switchJump:boolean;

var force:Vector2 = Vector2.zero;
var rollSpeed:float = 1;
var rollOff:boolean;

function Start (){
controller = GetComponent(CharacterController);
}


function Jump (){
if (jumpOn){
	moveDirection *= 1.2;
	jumpOn = false;
	GetComponent(CharAnimation).Jump(true);
	yield WaitForSeconds (.07);
	moveDirection.y = jumpSpeed;
	}
}


function ToRoll (){
rollSpeed = 2;
jumpOn = false;
switchJump = false;
GetComponent(CharAnimation).ToRoll();

}


function RollOff (){
	GetComponent(CharAnimation).t = 0;
	GetComponent(CharAnimation).toRoll = 0;
	switchJump = true;
	rollSpeed = 1;
}


function Force(getforce:Vector2){
force = getforce;
}



function Update(){		
acceleration.y = Input.acceleration.y + frontTilt;

if(Mathf.Abs(Input.acceleration.x) <= .05)
	inputX = 0;
	
else{
	inputX = Mathf.Clamp(Input.acceleration.x,-0.3,0.3);
	}
	
if(Mathf.Abs(acceleration.y) <= .05)
	inputY = 0;
	
else{
	inputY = Mathf.Clamp(acceleration.y,-0.3,0.3);
	}

	
	

if (Input.GetKey ("e")){
	ToRoll();
	}
if (Input.GetKeyUp ("e")){
	RollOff();
	}
		
	if(controller.isGrounded){
		if(switchJump){
			jumpOn = true;
			}
		moveDirection = Vector3(inputX+(force.x/5),0,inputY+(force.y/5));//Accelerator Controller
 		//moveDirection = Vector3(Input.GetAxis("Horizontal")+force.x,0,Input.GetAxis("Vertical")+force.y); //KeyBoard Controller
 		force = Vector2.zero;
 		moveDirection = transform.TransformDirection(moveDirection);
 		speed += (Time.deltaTime/20);
 		moveDirection *= speed/rollSpeed;
 		}
  	
  	if(!jumpOn){
  		
  		moveDirection.x = (inputX+(force.x/5))*speed;//Accelerator Controller
  		moveDirection.z = (inputY+(force.y/5))*speed;//Accelerator Controller
  		//////moveDirection.y -= gravity * Time.deltaTime;//
  		
  		//moveDirection.x = (Input.GetAxis("Horizontal")+(force.x/5))*speed;//KeyBoadr Controller
  		//moveDirection.z = (Input.GetAxis("Vertical")+(force.y/5))*speed;//KeyBoard Controller
  		moveDirection = transform.TransformDirection(moveDirection); 		
  		}
  		
 	if(Input.GetButton("Jump") && jumpOn){
		Jump();
		}

////moveDirection = transform.TransformDirection(moveDirection);

controller.Move(moveDirection * Time.deltaTime); 

moveDirection.y -= gravity * Time.deltaTime;
	
}

