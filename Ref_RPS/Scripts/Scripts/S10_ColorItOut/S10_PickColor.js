#pragma strict
var maxScale:float;
var minScale:float;
var on:boolean = false;
var duration:float = .3;
var t:float;
var t2:float;

function Start () {
minScale = transform.localScale.x;
}


function OnMouseOver () {
	

if(Input.GetMouseButtonDown(0)){

	var go:GameObject = GameObject.Find("Message");
	go.GetComponent(S10_Caller).StoreColor(renderer.material.color,name);
	
	go = GameObject.Find(name + "Line");
	go.GetComponent(S10_Line).enabled = true;
	go.GetComponent(S10_Line).startLine = transform.position;
	
	go.GetComponent(S10_Line).enabled = true;
	print(transform.position + "PL");
	t=0;
	t2=0;
	on = true;
		}

}

function Update() {

  if (on){
  	if(t <= 1){
  	print ("Hello");
  		t += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t), Mathf.SmoothStep(minScale, maxScale, t));
  		}
  		
  	else{
  		t2 += 1 * Time.deltaTime / duration;
  		transform.localScale = Vector3(Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2), Mathf.SmoothStep(maxScale, minScale, t2));
  		}
  	
  	if(t2 >=1){
  		on = false;
  	}
  		
  	}
}