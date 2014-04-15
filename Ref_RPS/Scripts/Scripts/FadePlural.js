#pragma strict
private var start:float;
private var fadeout:int;
private var duration:int;
private var fadeMult:float;
var tags:String;

var offset:float;
var fade:float = 0;
var time:float;
var on:int = 0;
var off:int = 1;

var go:GameObject;
var objectScript;
var gos:GameObject[];
var objectScriptArray;

var randomPlace:int;
//============================================================

function Start(){
renderer.material.color.a = 0;
}

function StartFade (cfadeout:int,cduration:int,cfadeMult:float,ctag:String) {
randomPlace = Random.Range(0,3);
fadeout = cfadeout;
duration = cduration;
fadeMult = cfadeMult;
tags = ctag;
time = 0;
offset = 0;
fade = 0;
renderer.material.color.a = fade;
on++;

	gos = GameObject.FindGameObjectsWithTag(tags);
	for (var i:int =0; i < gos.length; i ++){
		gos[i].GetComponent(FadeRandom).Able(true);
		
		}

}

function Update (){ 
	if (on == off){
		time += 1 * Time.deltaTime;
		if(time <=fadeout && fade <= 1){
			//gos = GameObject.FindGameObjectsWithTag(tags);
			for (var i:int =0; i < gos.length; i ++){
				
				var objectScriptRand:FadeRandom = gos[i].GetComponent(FadeRandom);
				objectScriptRand.StartFadeIn(fade);
				objectScriptRand.Relocate(randomPlace);
				} 
			
			fade += fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
		if(time >= fadeout && fade >= -0.10){
			//gos = GameObject.FindGameObjectsWithTag(tags);
			for ( i =0; i < gos.length; i ++){
				var objectScriptRand2:FadeRandom = gos[i].GetComponent(FadeRandom);
				objectScriptRand2.StartFadeOut(fade);
				}
				
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
		if(time >= duration){
			go = GameObject.Find("Controller");
			var objectScriptCont:ControlerScript = go.GetComponent(ControlerScript);
  			objectScriptCont.Call();
			off++;
			for (i =0; i < gos.length; i ++){
				gos[i].GetComponent(FadeRandom).Able(false);
				}
			GetComponent(MeshRenderer).enabled = false;
			GetComponent(FadePlural).enabled = false;
			}

	}
}