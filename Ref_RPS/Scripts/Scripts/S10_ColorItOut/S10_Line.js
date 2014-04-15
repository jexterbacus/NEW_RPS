#pragma strict
var go:GameObject;
var startLine:Vector3;
var lineRenderer:LineRenderer;
var lineLight:Light;

function Start () {

lineRenderer = gameObject.GetComponent(LineRenderer);
//lineRenderer.light.range = 10;

}
function Return (){
lineRenderer.SetPosition(1, Vector3(startLine.x,0.5,startLine.z-.5));

}
function Update () {

if(Input.GetMouseButton(0)){
	lineRenderer.SetPosition(0, Vector3(startLine.x,0.5,startLine.z-.5));

	var curScreenPoint:Vector3 = new Vector3(Input.mousePosition.x, Input.mousePosition.y, 0);
 	var curPosition:Vector3 = Camera.main.ScreenToWorldPoint(curScreenPoint);

	lineRenderer.SetPosition(1, Vector3(curPosition.x, 0.5, curPosition.z));
	}
if(Input.GetMouseButtonUp(0))
	GetComponent(S10_Line).enabled = false;
}