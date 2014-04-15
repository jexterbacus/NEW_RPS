#pragma strict
var sphere:AudioClip;
var spheres:AudioClip;
var cylinder:AudioClip;
var cylinders:AudioClip;
var cone:AudioClip;
var cones:AudioClip;
var cube:AudioClip;
var cubes:AudioClip;
var pyramid:AudioClip;
var pyramids:AudioClip;
var wait:float = 2;


function StartDialogue(dialogue:String,cdelay:int){

yield WaitForSeconds(wait+cdelay);
switch(dialogue){
	case "Sphere":
		audio.PlayOneShot(sphere);
		break;
	case "Spheres":
		audio.PlayOneShot(spheres);
		break;
	case "Cylinder":
		audio.PlayOneShot(cylinder);
		break;
	case "Cylinders":
		audio.PlayOneShot(cylinders);
		break;
	case "Cone":
		audio.PlayOneShot(cone);
		break;
	case "Cones":
		audio.PlayOneShot(cones);
		break;
	case "Cube":
		audio.PlayOneShot(cube);
		break;
	case "Cubes":
		audio.PlayOneShot(cubes);
		break;
	case "Pyramid":
		audio.PlayOneShot(pyramid);
		break;
	case "Pyramids":
		audio.PlayOneShot(pyramids);
		break;	
	}
	
}



