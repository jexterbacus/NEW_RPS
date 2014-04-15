#pragma strict
var dot:AudioClip;
var dots:AudioClip;
var line:AudioClip;
var lines:AudioClip;
var square:AudioClip;
var squares:AudioClip;
var circle:AudioClip;
var circles:AudioClip;
var triangle:AudioClip;
var triangles:AudioClip;
var wait:float = 2;


function StartDialogue(dialogue:String){
yield WaitForSeconds(wait);
switch(dialogue){
	case "Dot":
		audio.PlayOneShot(dot);
		break;
	case "Dots":
		audio.PlayOneShot(dots);
		break;
	case "Line":
		audio.PlayOneShot(line);
		break;
	case "Lines":
		audio.PlayOneShot(lines);
		break;
	case "Square":
	case "SolidSquare":
	case "SmallSquare":
	case "SolidSmallSquare":
		audio.PlayOneShot(square);
		break;
	case "Squares":
	case "SolidSquares":
	case "SmallSquares":
	case "SolidSmallSquares":
		audio.PlayOneShot(squares);
		break;
	case "Circle":
	case "SolidCircle":
		audio.PlayOneShot(circle);
		break;
	case "Circles":
	case "SolidCircles":
	case "SmallCircles":
		audio.PlayOneShot(circles);
		break;
	case "Triangle":
		audio.PlayOneShot(triangle);
		break;
	case "Triangles":
		audio.PlayOneShot(triangles);
		break;	
	}
	
}



