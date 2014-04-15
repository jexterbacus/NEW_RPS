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
	case "Color Red":
		tm.text = "red";
		break;
	case "Red Line":
		tm.text = "red line";
		break;
	case "Red Circle":
		tm.text = "red circle";
		break;
	case "Red Square":
		tm.text = "red square";
		break;
	case "Red Triangle":
		tm.text = "red triangle";
		break;
	
	case "Color Green":
		tm.text = "green";
		break;
	case "Green Line":
		tm.text = "green line";
		break;
	case "Green Circle":
		tm.text = "green circle";
		break;
	case "Green Square":
		tm.text = "green square";
		break;
	case "Green Triangle":
		tm.text = "green triangle";
		break;
	
	case "Color Blue":
		tm.text = "blue";
		break;
	case "Blue Line":
		tm.text = "blue line";
		break;
	case "Blue Circle":
		tm.text = "blue circle";
		break;
	case "Blue Square":
		tm.text = "blue square";
		break;
	case "Blue Triangle":
		tm.text = "blue triangle";
		break;
	
	case "Color Yellow":
		tm.text = "yellow";
		break;
	case "Yellow Line":
		tm.text = "yellow line";
		break;
	case "Yellow Circle":
		tm.text = "yellow circle";
		break;
	case "Yellow Square":
		tm.text = "yellow square";
		break;
	case "Yellow Triangle":
		tm.text = "yellow triangle";
		break;
	
	case "Color Magenta":
		tm.text = "magenta";
		break;	
	case "Magenta Line":
		tm.text = "magenta line";
		break;
	case "Magenta Circle":
		tm.text = "magenta circle";
		break;
	case "Magenta Square":
		tm.text = "magenta square";
		break;
	case "Magenta Triangle":
		tm.text = "magenta triangle";
		break;
		
	case "Color White":
		tm.text = "white";
		break;
	case "White Line":
		tm.text = "white line";
		break;
	case "White Circle":
		tm.text = "white circle";
		break;
	case "White Square":
		tm.text = "white square";
		break;
	case "White Triangle":
		tm.text = "white triangle";
		break;
			
	case "Color Gray":
		tm.text = "gray";
		break;	
	case "Gray Line":
		tm.text = "gray line";
		break;
	case "Gray Circle":
		tm.text = "gray circle";
		break;
	case "Gray Square":
		tm.text = "gray square";
		break;
	case "Gray Triangle":
		tm.text = "gray triangle";
		break;
		
	case "Color Black":
		tm.text = "black";
		break;
	case "Black Line":
		tm.text = "black line";
		break;
	case "Black Circle":
		tm.text = "black circle";
		break;
	case "Black Square":
		tm.text = "black square";
		break;
	case "Black Triangle":
		tm.text = "black triangle";
		break;
			
	}
}

function Update(){
	if (on == off){
	print("IM ON");
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
			GetComponent(S2_TextFade).enabled = false;
			}
	}
}