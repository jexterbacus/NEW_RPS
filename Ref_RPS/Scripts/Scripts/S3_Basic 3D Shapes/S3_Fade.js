#pragma strict
private var start:float;
private var fadeout:int;
private var duration:int;
private var fadeMult:float;

var offset:float;
var fade:float = 0;
var time:float;
var on:int = 0;
var off:int = 1;

var go:GameObject;
var objectScript;
var gos:GameObject[];
var objectScriptArray;


function Start(){
renderer.material.color.a = 0;
}

function StartFade (cfadeout:int,cduration:int,cfadeMult:float) {
fadeout = cfadeout;
duration = cduration; 
fadeMult = cfadeMult;

time = 0;
offset = 0;
fade = 0;
renderer.material.color.a = fade;
on++;
}

function Update (){ 
	if (on == off){
		time += 1 * Time.deltaTime;
		if(time >= start && fade <= 1){
			fade += fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
		if(fade>=1){
			go = GameObject.Find("Controller");
			var objectScriptCont:S3_ControlerScript = go.GetComponent(S3_ControlerScript);
  			objectScriptCont.Call();
			off++;
			}
	}
	if(off>on){
		time += 1 * Time.deltaTime;
		if(time >= fadeout-10){
   			fade -= fadeMult * Time.deltaTime;
   			renderer.material.color.a = fade;
			}
		}
	if(fade <= 0){
		GetComponent(MeshRenderer).enabled = false;
   		GetComponent(S3_Fade).enabled = false;
		}
	
}