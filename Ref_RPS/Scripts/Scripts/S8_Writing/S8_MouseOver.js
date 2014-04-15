#pragma strict
var letter:String;
var go:GameObject;
var gotm:GameObject;

var pixelUV:float;
var UV:float;
var UVStart1:float = 930;
var UVStart2:float = 600;
var UVEnd1:float = -0.6;
var UV2End2:float = -0.4;
var t:float;
var t2:float;
var error:boolean;
var speed:float = 3;
var on : boolean = false;
var write:boolean;
var last:boolean;
private var checking:boolean;
var startA:boolean = true;
var startB:boolean = true;
var startC:boolean = true;
var sTip:float;
var div:int;
var end : int = 0;

var count:int;
function Start () {
startA = startB = startC= true;
end = 0;
error = true;
t = 0;
write = true;
checking = true;
gotm = GameObject.Find("Praises");
}



function OnMouseOver () {
if (write){
	if (Input.GetMouseButtonDown(0)){
		yield WaitForSeconds(.1);
		on = true;
		}
	pixelUV = go.GetComponent(S8_Stroke).pixelUV.y;
	
	if (on){
		if (pixelUV >= UVStart1 && startA){
			startB = startC = false;
			div = 1050;
			sTip = 0;
			end = 1;
			}
		else if (pixelUV <= UVStart2 && startB){
			startA = startC = false;
			div = 1000;
			sTip = 0.5;
			end = 2;
			}	
		else if (startC) {
			print ("BOOO");
			gotm.GetComponent(MeshRenderer).enabled = true;
			gotm.GetComponent(S8_Praises).enabled = true;
			gotm.GetComponent(S8_Praises).Error();
			return;
			}
		UV = ((pixelUV/div) - sTip)* -1;
		renderer.material.SetTextureOffset("_MainTex", new Vector2(0, UV));
		
		}
			
	}
	
	if (Input.GetMouseButtonUp(0)){
		startA = true;
		startB = true;
		on = false;
		}
}


function Off (){

letter = transform.parent.gameObject.name;

yield WaitForSeconds (1);

for (var i:int = 1; i <= 5; i++){

	go = GameObject.Find(letter + i +"_bg");
	go.GetComponent(MeshRenderer).enabled = false;

	go = GameObject.Find(letter + i);
	go.GetComponent(MeshRenderer).enabled = false;
	go.GetComponent(MeshCollider).enabled = false;
	go.GetComponent(S8_MouseOver).enabled = false;
	if (go.name == name){
		go = GameObject.Find("Call");
		go.GetComponent(S8_Call).Call();
		break;
		}
	}
}


function Update () {

if (checking){
	if (UV >= UVEnd1 && end == 1){
		t2 += speed * Time.deltaTime;
		renderer.material.SetTextureOffset("_MainTex", new Vector2(0, Mathf.SmoothStep(UV, -0.5, t2)));
		write = false;		
		}
	
	if (UV <= UV2End2 && end == 2){

		t2 += speed * Time.deltaTime;
		renderer.material.SetTextureOffset("_MainTex", new Vector2(0, Mathf.SmoothStep(UV, -0.5, t2)));
		write = false;		
		}	

	if (t2 >=1){

		gotm.GetComponent(MeshRenderer).enabled = true;
		gotm.GetComponent(S8_Praises).enabled = true;
		gotm.GetComponent(S8_Praises).Dialogues();
		go = GameObject.Find("Call");
		go.GetComponent(S8_Call).Count();
		checking = false;
		}
	}
	
	
}
