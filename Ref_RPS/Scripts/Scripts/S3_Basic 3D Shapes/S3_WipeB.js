#pragma strict
 var start:int;
 var fadeout:int;
 var duration:int;
 var fadeMult:float;

var fade:float = 1;
var offsetMult:float = 0.5;
var offset:float;
 var time:float;
 var on:int = 0;
 var off:int = 1;
 var t:float;
var go:GameObject;
var objectScript;
var rotSpeed:float = 0;
function Start(){

renderer.material.color.a = 0;
}

function showShape (cstart:int,cfadeout:int,cduration:int,cfadeMult:float) {
start = cstart;
fadeout = cfadeout;
duration = cduration; 
fadeMult = cfadeMult;
time = 0;
offset = 0;
fade = 1;
transform.rotation = Quaternion.Euler(0, 0, 0);
on++;
}

function Update (){ 
	if(on == off){
		time += 1 * Time.deltaTime;
		if(time>=4.5){
			t += 1 * Time.deltaTime;
			rotSpeed = Mathf.SmoothStep(0, 40, t/2);
			transform.Rotate(rotSpeed * Time.deltaTime, rotSpeed * Time.deltaTime, 0, Space.World);
			}
		if(time >= start +2 && offset >= -0.5){
			renderer.material.color.a = fade;
			offset -= offsetMult * Time.deltaTime;
   			renderer.material.SetTextureOffset("_MainTex", new Vector2(0, offset));
   			}
   			
		if(time >= fadeout+1){
   			fade -= fadeMult * Time.deltaTime;
   			renderer.material.color.a = fade;
			}

   		if(time >= duration){
   			go = GameObject.Find("Controller");
			var objectScriptCont:S3_ControlerScript = go.GetComponent(S3_ControlerScript);
  			objectScriptCont.Call();
  			transform.rotation = Quaternion.Euler(0, 0, 0);
   			off++;
   			GetComponent(MeshRenderer).enabled = false;
   			GetComponent(S3_WipeB).enabled = false;
   			}
   		}
 
}