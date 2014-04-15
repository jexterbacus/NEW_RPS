#pragma strict
private var start:int;
private var fadeout:int;
private var duration:int;
private var fadeMult:float;

var fadeinMult = 2;
var on:int = 0;
var off:int = 1;
var fade:float;

var time:float;

var tm:TextMesh;

function Start(){
renderer.material.color.a = 0;
}

function StartText (ctext:String,cstart:int,cfadeout:int,cduration:int,cfadeMult:float) {
start = cstart + 3;
fadeout = cfadeout;
duration = cduration;
fadeMult = cfadeMult;


time = 0;
fade = 0;

tm = gameObject.GetComponent(TextMesh);
tm.text = "Some string";

switch(ctext){
	case "Sphere":
		tm.text = "sphere";
		on++;
		break;
	case "Spheres":
		tm.text = "spheres";
		on++;
		break;
	case "Cylinder":
		tm.text = "cylinder";
		on++;
		break;
	case "Cylinders":
		tm.text = "cylinders";
		on++;
		break;
	case "Cone":
		tm.text = "cone";
		on++;
		break;
	case "Cones":
		tm.text = "cones";
		on++;
		break;
	case "Cube":
		tm.text = "cube";
		on++;
		break;
	case "Cubes":
		tm.text = "cubes";
		on++;
		break;
	case "Pyramid":
		tm.text = "pyramid";
		on++;
		break;
	case "Pyramids":
		tm.text = "pyramids";
		on++;
		break;			
	}
}

function Update(){
	if (on == off){
		time += 1 * Time.deltaTime;
		if(time >= start+3 && time < fadeout && fade <= 1){
			fade += fadeinMult * Time.deltaTime;
			renderer.material.color.a = fade;
		}
		if(time >= fadeout+1 && fade >= 0){
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
		if(time >= duration-1){
			off++;
			}
	}
}