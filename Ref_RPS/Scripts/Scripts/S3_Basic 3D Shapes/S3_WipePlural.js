#pragma strict
private var start:float;
private var fadeout:int;
private var duration:int;
private var fadeMult:float;
var tags:String;

var offsetMult:float = 0.5;
var offset:float;

var fade:float = 0;
var time:float;
var on:int = 0;
var off:int = 1;
var t:float;

var go:GameObject;
var objectScript;
var gos:GameObject[];
var objectScriptArray;

var randomPlace:int;
var rotSpeed:float = 40;

var randRot1:int;
var randRot2:int;
var rotOn:boolean;
//============================================================

function Start(){
renderer.material.color.a = 0;
}

function showShape (cstart:int,cfadeout:int,cduration:int,cfadeMult:float,ctag:String) {
randomPlace = Random.Range(0,3);
fadeout = cfadeout;
duration = cduration;
fadeMult = cfadeMult;
tags = ctag;
time = 0;
offset = 0;
fade = 0;
renderer.material.color.a = fade;

rotOn = true;

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

on++;

	gos = GameObject.FindGameObjectsWithTag(tags);
	for (var i:int =0; i < gos.length; i ++){
		gos[i].GetComponent(S3_FadeRandom).Able(true,rotSpeed);
		}


}

function Update (){ 
	if (on == off){
		time += 1 * Time.deltaTime;
		
		if(time>=4){
			t += 1 * Time.deltaTime;
			rotSpeed = Mathf.SmoothStep(0, 40, t/2);
			transform.Rotate(randRot1 * rotSpeed * Time.deltaTime, randRot2 * rotSpeed * Time.deltaTime, 0, Space.World);	
			}
			
		if(time >= start + 3 && offset >= -0.5){
			for (var i:int =0; i < gos.length; i ++){
				gos[i].GetComponent(S3_FadeRandom).StartFadeIn(fade);
				gos[i].GetComponent(S3_FadeRandom).Relocate(randomPlace);
				} 
				
			fade += fadeMult * Time.deltaTime;
			renderer.material.color.a = 1;
			offset -= offsetMult * Time.deltaTime;
   			renderer.material.SetTextureOffset("_MainTex", new Vector2(0, offset));
   			}
			
			
		if(time >= fadeout + 1 && fade >= -0.10){
			for ( i =0; i < gos.length; i ++){
				var objectScriptRand2:S3_FadeRandom = gos[i].GetComponent(S3_FadeRandom);
				objectScriptRand2.StartFadeOut(fade);
				}
				
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
			
			
		if(time >= duration){
			go = GameObject.Find("Controller");
			go.GetComponent(S3_ControlerScript).Call();
			transform.rotation = Quaternion.Euler(0, 0, 0);
			off++;
			for (i =0; i < gos.length; i ++){
				gos[i].GetComponent(S3_FadeRandom).Able(false,rotSpeed);
				}
			GetComponent(MeshRenderer).enabled = false;
			GetComponent(S3_WipePlural).enabled = false;
			}

	}
}