#pragma strict
var colName:String;
var objectName:String;
var on:boolean = false;

var minScale:float; 
var maxScale:float = 0.9;
var duration:float = 0.3;
var t:float;
var t2:float;

function Start () {
minScale = transform.localScale.x;

}


function OnGUI() { 

	if (Input.GetKeyDown(KeyCode.Escape)) 
   	Application.LoadLevel ("Main Menu"); 
}

function Cannotclick () {
	var go:GameObject = GameObject.Find("collider");
	go.GetComponent(MeshCollider).enabled = true;
	//yield WaitForSeconds(1.5);
	//go.GetComponent(MeshCollider).enabled = false;
}
function Canclick () {
	yield WaitForSeconds(2.5);
	var go:GameObject = GameObject.Find("collider");
	go.GetComponent(MeshCollider).enabled = false;
}




function OnMouseOver () {

	 if(Input.GetMouseButtonUp(0)){
	 
	 	
	 	objectName = name;
		var go:GameObject = GameObject.Find("PressText");
		go.GetComponent(S6_PressText).Match(colName,objectName);
		
		
		if(!on){
			print("Im not On");
			t=0;
			t2=0;
			}
			
		on = true;
		Cannotclick ();
		}
}




function Update() {

  if (on){
  print("Im on"+on);
  	if(t <= 1){
  		t += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t));
  		
  		}
  	else{
  		t2 += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2));
  		}
  		
  	if(t2 >=1){
  		on = false;
  		Canclick();
  		}
  }
  
}