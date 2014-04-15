#pragma strict
var fade:float;
var on:boolean = false;
var off:int = 1;
var fadeMult:float = 1;
var time:float;
var fadeout:int = 2;

function Start () {

}

function FadeInOut (){
if(!on){ 
	time = 0;
	fade = 0;
	}
on = true;
}

function Update () {
if (on){
		time += 1 * Time.deltaTime;
		if(time <= fadeout && fade <= 1){
			fade += fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
		if(time >= fadeout && fade >= 0){
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
		if(time > 1 && fade <= 0){
			on = false;
  			GetComponent(MeshRenderer).enabled = false;
			GetComponent(S5_FadeText).enabled = false;
			}

	}
}