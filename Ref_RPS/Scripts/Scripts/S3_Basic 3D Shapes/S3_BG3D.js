#pragma strict


var go : GameObject;
var objectScript;
var fadeout:float;
var fade:float;
var startfading:int=0;
var time:float;

function Start () {
fade = 0;
renderer.material.color.a = 0;
}

function Startfade(getfadeout){
fadeout = getfadeout;
startfading++;

}
function Update () {
	
	go = GameObject.Find("Main_Camera");
	var scriptSmoothTranslate:S3_Smooth_Translate = go.GetComponent(S3_Smooth_Translate);
	
	if(scriptSmoothTranslate.on == 1){
		if(time <= fadeout+1 && fade <= 1){
			fade += 1 * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			}
	else{
		startfading = 0;
		time = 0;
	}
		
	if(startfading == 1){
		time += 1 * Time.deltaTime;
		if(time >= fadeout+1 && fade >= 0){
			fade -= 1 * Time.deltaTime;
			renderer.material.color.a = fade;
			}
		}
			
}