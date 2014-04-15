#pragma strict
var speed : float = 6.0;
var speedhor:float = 3;
var gravity : float = 20.0;

private var controller : CharacterController; 
private var inputX:float;
private var acceleration:Vector3;
var moveDirection : Vector3 = Vector3.zero;


function Start (){
controller = GetComponent(CharacterController);
}


function Update(){
inputX = Mathf.Clamp(Input.acceleration.x,-0.7,0.7);



	if(controller.isGrounded){
		//moveDirection = Vector3(inputX,0,.3);//Accelerator Controller 25
 		moveDirection = Vector3(Input.GetAxis("Horizontal")*speedhor,0,speed); //KeyBoard Controller 3
 		moveDirection = transform.TransformDirection(moveDirection);
 		moveDirection *= speed;
 		}

//moveDirection = transform.TransformDirection(moveDirection);

controller.Move(moveDirection * Time.deltaTime); 

moveDirection.y -= gravity * Time.deltaTime;
	
}

