#pragma strict
var walkSpeed:float = 1;
var runSpeed:float = .5;
private var controller:CharacterController;
private var overallSpeed : float;
private var jump:boolean = false;
var toRoll:int = 0;
var t:float = 0;


function Start () {

controller = GetComponent(CharacterController);
animation["Jump2"].speed = .5;
}


function Jump (getJump:boolean){
jump = getJump;
animation.Play("Jump2");
}

function ToRoll(){
t += 1 * Time.deltaTime;
if (toRoll == 1){
	Roll ();
	}
else{
	animation["ToRoll"].speed = 1.5;
	animation.Play("ToRoll");
	if(t >= animation["ToRoll"].length/1.5)
	toRoll = 1;
	}
}

function Roll () {
animation["Roll"].speed = overallSpeed * walkSpeed;
animation.Play("Roll");
}

function Update () {

        // The overall speed
overallSpeed  = controller.velocity.magnitude;
        
	if(controller.isGrounded){
		jump =false;
		}
		
	if(overallSpeed >= 0.1 && overallSpeed <= 2.5 && jump == false){
		animation["Walk"].speed = overallSpeed * walkSpeed;
		animation.CrossFade("Walk");
		}	
	else if (overallSpeed >= 2.5 && jump == false){
		animation["Run"].speed = (overallSpeed * runSpeed);
		animation.CrossFade("Run");
		}
	else if (overallSpeed <= 0.1 && jump == false){
		animation.CrossFade("Idle");
		}
	

}
