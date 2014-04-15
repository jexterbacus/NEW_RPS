#pragma strict
var roll:float;
var height:float;
var width:float;

function Awake (){
//guiTexture.pixelInset = Rect (0, 0, Screen.width*width, Screen.height*height);

}

function Update () {
guiTexture.pixelInset = Rect (0, 0, Screen.width*width, Screen.height*height);
transform.Translate(Vector3.up * roll *-1, Space.World);
}