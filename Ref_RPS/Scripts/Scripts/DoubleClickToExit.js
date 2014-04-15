#pragma strict

function Start () {
renderer.material.color.a = 0;
}
function Fadeout(){
	renderer.material.color.a = 1;
	yield WaitForSeconds(.5);
	while (renderer.material.color.a > 0){
    	renderer.material.color.a -= 1 * Time.deltaTime;
    	yield;
    }
}
