#pragma strict
var colname:String;
var go:GameObject;
var shape:String;

function Start () {
go = GameObject.Find("ShapeName");
}

function OnTriggerEnter (other : Collider){
colname = other.name;

switch (colname){

	case "ConeSide":
		go.GetComponent(TextMesh).text = "cone";
		break;
		
	case "CubeSide":
		go.GetComponent(TextMesh).text = "cube";
		break;
		
	case "CylinderSide":
		go.GetComponent(TextMesh).text = "cylinder";
		break;
		
	case "PyramidSide":
		go.GetComponent(TextMesh).text = "pyramid";
		break;
		
	case "SphereSide":
		go.GetComponent(TextMesh).text = "sphere";
		break;
		
	case "DotSide":
		go.GetComponent(TextMesh).text = "dot";
		break;
		
	case "SquareSide":
		go.GetComponent(TextMesh).text = "square";
		break;
		
	case "LineSide":
		go.GetComponent(TextMesh).text = "line";
		break;
		
	case "TriangleSide":
		go.GetComponent(TextMesh).text = "triangle";
		break;
		
	case "CircleSide":
		go.GetComponent(TextMesh).text = "circle";
		break;
	}


}
function Update () {

}