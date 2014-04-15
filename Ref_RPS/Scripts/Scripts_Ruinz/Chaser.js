#pragma strict
var incre:int = 0;
var numPoints:int;
var target:Transform;
var go:GameObject;
var go2:GameObject;
var speed:float = 1;

function NumPoints(getNumPoints:int){
numPoints = getNumPoints;

if (incre <= numPoints && incre >=1){

go = GameObject.Find("PointOfChaste" + incre);
target = go.transform;
}
}


function NextTarget (){
incre++;
if (incre <= numPoints){
go = GameObject.Find("PointOfChaste" + incre);
target = go.transform;
}

else{
target = go2.transform;
}
}

/*

if (!go){
	print ("STOP");
	target = go2.transform;
	}
else{
	print (go.name);
	target = go.transform;
	}
}
*/

function Update (){
speed += (Time.deltaTime/40);
transform.LookAt(target);
transform.Translate(Vector3.forward * speed * Time.deltaTime);

}