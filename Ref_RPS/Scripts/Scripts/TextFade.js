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

on++;
time = 0;
fade = 0;

tm = gameObject.GetComponent(TextMesh);
tm.text = "Some string";

switch(ctext){
	case "Dot":
		tm.text = "dot";
		break;
	case "Dots":
		tm.text = "dots";
		break;
	case "Line":
		tm.text = "line";
		break;
	case "Lines":
		tm.text = "lines";
		break;
	case "Square":
	case "SolidSquare":
	case "SmallSquare":
	case "SolidSmallSquare":
		tm.text = "square";
		break;
	case "Squares":
	case "SolidSquares":
	case "SmallSquares":
	case "SolidSmallSquares":
		tm.text = "squares";
		break;
	case "Circle":
	case "SolidCircle":
		tm.text = "circle";
		break;
	case "Circles":
	case "SolidCircles":
	case "SmallCircles":
		tm.text = "circles";
		break;
	case "Triangle":
		tm.text = "triangle";
		break;
	case "Triangles":
		tm.text = "triangles";
		
	}
}

function Update(){
	if (on == off){
		time += 1 * Time.deltaTime;
		if(time >= start-1 && time < fadeout && fade <= 1){
			fade += fadeinMult * Time.deltaTime;
			renderer.material.color.a = fade;
		}
		if(time >= fadeout && fade >= 0){
			fade -= fadeMult * Time.deltaTime;
			renderer.material.color.a = fade;
			}
		if(time >= duration-1){
			off++;
			GetComponent(MeshRenderer).enabled = false;
			GetComponent(TextFade).enabled = false;
			}
	}
}