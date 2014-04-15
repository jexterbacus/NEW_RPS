#pragma strict
var press:AudioClip;
var shapes:AudioClip[];
var wait:float;


function Press(){
yield WaitForSeconds(1);
audio.PlayOneShot(press);
}


function StartDialogue(dialogue:String){
yield WaitForSeconds(1.8);
switch(dialogue){
	case "dot":
		audio.PlayOneShot(shapes[0]);
		break;
	case "dots":
		audio.PlayOneShot(shapes[1]);
		break;
	case "line":
		audio.PlayOneShot(shapes[2]);
		break;
	case "lines":
		audio.PlayOneShot(shapes[3]);
		break;
	case "square":
		audio.PlayOneShot(shapes[4]);
		break;
	case "squares":
		audio.PlayOneShot(shapes[5]);
		break;
	case "circle":
		audio.PlayOneShot(shapes[6]);
		break;
	case "circles":
		audio.PlayOneShot(shapes[7]);
		break;
	case "triangle":
		audio.PlayOneShot(shapes[8]);
		break;
	case "triangles":
		audio.PlayOneShot(shapes[9]);
		break;	
	case "cube":
		audio.PlayOneShot(shapes[10]);
		break;	
	}
	/*
	case "E":	case "e":	case "Ee":
		audio.PlayOneShot(alphabet[4]);
		break;	
	case "F":	case "f":	case "Ff":
		audio.PlayOneShot(alphabet[5]);
		break;	
	case "G":	case "g":	case "Gg":
		audio.PlayOneShot(alphabet[6]);
		break;	
	case "H":	case "h":	case "Hh":
		audio.PlayOneShot(alphabet[7]);
		break;	
	case "I":	case "i":	case "Ii":
		audio.PlayOneShot(alphabet[8]);
		break;	
	case "J":	case "j":	case "Jj":
		audio.PlayOneShot(alphabet[9]);
		break;	
	case "K":	case "k":	case "Kk":
		audio.PlayOneShot(alphabet[10]);
		break;
	case "L":	case "l":	case "Ll":
		audio.PlayOneShot(alphabet[11]);
		break;
	case "M":	case "m":	case "Mm":
		audio.PlayOneShot(alphabet[12]);
		break;
	case "N":	case "n":	case "Nn":
		audio.PlayOneShot(alphabet[13]);
		break;
	case "O":	case "o":	case "Oo":
		audio.PlayOneShot(alphabet[14]);
		break;
	case "P":	case "p":	case "Pp":
		audio.PlayOneShot(alphabet[15]);
		break;
	case "Q":	case "q":	case "Qq":
		audio.PlayOneShot(alphabet[16]);
		break;
	case "R":	case "r":	case "Rr":
		audio.PlayOneShot(alphabet[17]);
		break;
	case "S":	case "s":	case "Ss":
		audio.PlayOneShot(alphabet[18]);
		break;
	case "T":	case "t":	case "Tt":
		audio.PlayOneShot(alphabet[19]);
		break;
	case "U":	case "u":	case "Uu":
		audio.PlayOneShot(alphabet[20]);
		break;
	case "V":	case "v":	case "Vv":
		audio.PlayOneShot(alphabet[21]);
		break;
	case "W":	case "w":	case "Ww":
		audio.PlayOneShot(alphabet[22]);
		break;
	case "X":	case "x":	case "Xx":
		audio.PlayOneShot(alphabet[23]);
		break;
	case "Y":	case "y":	case "Yy":
		audio.PlayOneShot(alphabet[24]);
		break;
	case "Z":	case "z":	case "Zz":
		audio.PlayOneShot(alphabet[25]);
		break;
			*/
}



