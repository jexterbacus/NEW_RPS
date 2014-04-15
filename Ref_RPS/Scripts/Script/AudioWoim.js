#pragma strict
var audioWoim:AudioClip[];
var leanX:float;
var speachRan:int;
var speachRight:boolean=true;
var speachLeft:boolean=true;

function Update(){
leanX = Mathf.Clamp(Input.acceleration.x,-0.7,0.7);
//leanX =	Input.GetAxis("Horizontal");
if (leanX > .1 && speachRight){
	speachRan = Random.Range(0,2);
	audio.PlayOneShot(audioWoim[speachRan]);
	speachRight = false;
	speachLeft = true;
	}
	
if (leanX < -.1 && speachLeft){
	speachRan = Random.Range(0,2);
	audio.PlayOneShot(audioWoim[speachRan]);
	speachLeft = false;
	speachRight = true;
	}

if (leanX == 0){
	speachLeft = true;
	speachRight = true;
	}
}