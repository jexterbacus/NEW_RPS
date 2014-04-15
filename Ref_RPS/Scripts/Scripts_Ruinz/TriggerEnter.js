#pragma strict
var go:GameObject;
var slow:float = 1;
private var speed:float;
function OnTriggerStay (other : Collider){
if(other.name == "Roy_Walk_plotted"){
	speed = go.GetComponent(PlaySpeed).speed;
	other.GetComponent(Advn_Mvmt_Cnt).Force(Vector2((speed/slow),0));
}
}