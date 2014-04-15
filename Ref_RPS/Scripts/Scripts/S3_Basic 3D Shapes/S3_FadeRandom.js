#pragma strict
//private var fadeMult:float;
private var random:float;
var go:GameObject[];
private var randomRange1:float = 2.5;
private var randomRange2:float = 3.5;

var rotOn:boolean = false;
var fade:float = 0;
var t:float;
var randRot1:int;
var randRot2:int;
var rotSpeed:int;

function Start(){

renderer.material.color.a = 0;
random = Random.Range(randomRange1,randomRange2);
}

function Relocate (randomPlace:int){
	transform.position = go[randomPlace].transform.position;
	transform.localScale = go[randomPlace].transform.localScale;
	}

function StartFadeIn (fade:float) {
	yield WaitForSeconds(random);
	renderer.material.color.a = fade;
}

function StartFadeOut(fade:float){
	renderer.material.color.a = fade;
}

function Able(onoff:boolean,getrotSpeed:int){
GetComponent(MeshRenderer).enabled = onoff;
GetComponent(S3_FadeRandom).enabled = onoff;

randRot1 = Random.Range(0,2);
randRot2 = Random.Range(0,2);

if (randRot1 == 0)
randRot1 = -1;
else
randRot1 = 1;

if (randRot2 == 0)
randRot2 = -1;
else
randRot2 = 1;

rotSpeed = getrotSpeed;
yield WaitForSeconds(4);
rotOn = onoff;
}

function Update(){
if(rotOn){
	t += 1 * Time.deltaTime;
	rotSpeed = Mathf.SmoothStep(0, 40, t/2);
	transform.Rotate(randRot1 * rotSpeed * Time.deltaTime, randRot2 * rotSpeed * Time.deltaTime, 0, Space.World);

}
else
transform.rotation = Quaternion.Euler(0, 0, 0);

}