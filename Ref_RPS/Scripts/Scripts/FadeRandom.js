#pragma strict
//private var fadeMult:float;
private var random:float;
var go:GameObject[];
var randomRange1:float = 0.5;
var randomRange2:float = 2.5;

var fade:float = 0;

function Start(){

renderer.material.color.a = 0;
random = Random.Range(randomRange1,randomRange2);
}

function Relocate (randomPlace:int){
	transform.position = go[randomPlace].transform.position;
	}


function StartFadeIn (fade:float) {
	yield WaitForSeconds(random);
	renderer.material.color.a = fade;
}

function StartFadeOut(fade:float){
	renderer.material.color.a = fade;
}

function Able(onoff:boolean){
GetComponent(MeshRenderer).enabled = onoff;
GetComponent(FadeRandom).enabled = onoff;
}
