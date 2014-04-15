#pragma strict
var colName:String;
var on:boolean = false;

var minScale:float; 
var maxScale:float = .9;
var duration:float = 3;
var t:float;
var t2:float;
var doubleClick:boolean = false;

function Start () {
minScale = transform.localScale.x;
doubleClick = true;
}


function OnGUI() { 
	
	if (Input.GetKeyDown(KeyCode.Escape)) 
   Application.LoadLevel ("Main Menu"); 
}

function OnMouseOver () {
	 if(Input.GetMouseButtonUp(0)){
	 
		var go:GameObject = GameObject.Find(colName);
		go.GetComponent(MeshRenderer).enabled = true;
		go.GetComponent(S5_FadeText).enabled = true;		
		go.GetComponent(S5_FadeText).FadeInOut();
		
		go = GameObject.Find("MainCamera");
		go.GetComponent(S5_Dialogue).StartDialogue(name);
		
		if(!on){
			t=0;
			t2=0;
			}
		on = true;
		}
}


function Update() {
  if (on){
  	if(t <= 1){
  		t += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t));
  		}
  	else{
  		t2 += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2));
  		}
  	if(t2 >=1)
  		on = false;
  }
  
}


