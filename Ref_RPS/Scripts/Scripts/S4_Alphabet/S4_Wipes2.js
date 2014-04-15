#pragma strict
private var start:int;
var fadeout:int;
var duration:int;
private var fadeMult:float;

var fade:float = 1;
var offsetMult:float = 0.5;
var offset:float;
private var time:float;
private var on:int = 0;
private var off:int = 1;

var go:GameObject;
var objectScript;

function Start(){

renderer.material.color.a = 0;
}

function showShape (cstart:int,cfadeout:int,cduration:int,cfadeMult:float) {

start = cstart;
fadeout = cfadeout + 1;
duration = cduration + 1; 
fadeMult = cfadeMult;
time = 0;
offset = 0;
fade = 1;
on++;
}

function Update (){ 
	if(on == off){
		time += 1 * Time.deltaTime;
		if(time >= start + 2 && offset >= -0.5){
			renderer.material.color.a = fade;
			offset -= offsetMult * Time.deltaTime;
   			renderer.material.SetTextureOffset("_MainTex", new Vector2(0, offset));
   			}
   		if(time >= fadeout){
   			fade -= fadeMult * Time.deltaTime;
   			renderer.material.color.a = fade;
			}
				
   		if(time >= duration){
   			go = GameObject.Find("Controller");
			var objectScriptCont:S4_ControlerScript = go.GetComponent(S4_ControlerScript);
  			objectScriptCont.Call();
   			off++;
   			GetComponent(MeshRenderer).enabled = false;
			GetComponent(S4_Wipes2).enabled = false;
   			}
   		}

}