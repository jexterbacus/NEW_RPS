#pragma strict
var goName:String;

function OnTriggerEnter(other:Collider){
if (other.name == goName){
Destroy(gameObject);
	}
}
