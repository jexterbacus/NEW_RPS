#pragma strict
var go:GameObject;

function Start () {
go = GameObject.Find("Box");
}

function OnGUI (){
if (Input.GetKeyDown(KeyCode.Escape)) 
   	Application.LoadLevel ("Main Menu"); 

if(GUI.Button(Rect(650,20,100,50),"Reset"))
	Application.LoadLevel ("DragDrop2D");
	
if(GUI.Button(Rect(750,20,100,50),"Reset \n cube")){
	go.GetComponent(Transform).transform.rotation.eulerAngles = Vector3.zero;
	}
	
if(Input.GetMouseButtonUp(0))
go.GetComponent(S7_Rotate).rotEnable = true;

}
