#pragma strict
var shapes:AudioClip[];

var wait:float;

function StartDialogue(dialogue:String){
switch(dialogue){
	case "Dot":
		audio.PlayOneShot(shapes[0]);
		break;
	case "Circle":
		audio.PlayOneShot(shapes[1]);
		break;
	case "Line":
		audio.PlayOneShot(shapes[2]);
		break;
	case "Square":
		audio.PlayOneShot(shapes[3]);
		break;

	}


}
