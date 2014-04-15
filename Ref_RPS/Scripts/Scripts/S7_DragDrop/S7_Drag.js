#pragma strict
var initMousePos:Vector3;
var initObjectPos:Vector3;
var buttonUp:boolean = false;
var pair:boolean = false;
var moveValue:Vector3;
var go:GameObject;
var cam:GameObject;
var moveDiv:float = 30;
var moveOn:boolean = true;
var startPos:Vector3;
var screenWorld:Vector3;
var movePress:boolean = false;
private var screenPoint: Vector3;
private var offset:Vector3;



function Start () {
go = GameObject.Find("Box");
startPos = transform.position;
cam = GameObject.Find("Main Camera");
GetComponent(Rigidbody).useGravity = false;
GetComponent(Rigidbody).isKinematic = true;
}

function OnGUI() { 

	if (Input.GetKeyDown(KeyCode.Escape)) 
   	Application.LoadLevel ("Main Menu"); 
}

function OnMouseOver () {
if(Input.GetMouseButtonDown(0)){
	go.GetComponent(S7_Rotate).rotEnable = false;
	buttonUp = true;
	screenPoint = Camera.main.WorldToScreenPoint(gameObject.transform.position);
    offset = gameObject.transform.position - Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, screenPoint.z));
	movePress = true;
	}
	
if(Input.GetMouseButton(0) && moveOn && movePress){
	
	var curScreenPoint:Vector3 = new Vector3(Input.mousePosition.x, Input.mousePosition.y, screenPoint.z);
 	var curPosition:Vector3 = Camera.main.ScreenToWorldPoint(curScreenPoint) + offset;
	transform.position = curPosition;
	}
	
}

function Update () {


if(Input.GetMouseButtonUp(0) && buttonUp && pair){
	
	GetComponent(Rigidbody).isKinematic = false;
	GetComponent(Rigidbody).useGravity = true;
	GetComponent(SphereCollider).enabled = false;
	}
	
else if (Input.GetMouseButtonUp(0)){
	movePress = false;
	}
}