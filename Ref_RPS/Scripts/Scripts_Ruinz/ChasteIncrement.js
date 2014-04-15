#pragma strict
var go:GameObject;

function Start (){
go = GameObject.Find("PointOfChaste");
}

function OnTriggerEnter(other:Collider){

if(other.name == "Roy_Walk_plotted"){

go.GetComponent(ChaserDirection).OnCall();

	}

}

