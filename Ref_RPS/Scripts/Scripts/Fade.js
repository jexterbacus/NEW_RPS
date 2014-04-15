#pragma strict
private var start:float;
private var fadeout:int;
private var duration:int;
private var fadeMult:float;


var fade:float = 0;
var time:float;
var on:int = 0;
var off:int = 1;

var go:GameObject;

var offset:float;


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
print("switchOn");
}

function Update (){ 
	if (on == off){
		time += 1 * Time.deltaTime;
		if(time <=fadeout && fade <= 1){
			fade += fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
		if(time >= fadeout && fade >= 0){
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
		if(time >= duration){
			go = GameObject.Find("Controller");
			var objectScript1:ControlerScript = go.GetComponent(ControlerScript);
  			objectScript1.Call();
  			off++;
  			GetComponent(MeshRenderer).enabled = false;
			GetComponent(Fade).enabled = false;
			}

	}
}