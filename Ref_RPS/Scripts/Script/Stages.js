#pragma strict
var roll:float;
var height:float;

function Awake (){
guiTexture.pixelInset = Rect (0, 0, Screen.width, Screen.height*height);

}
function Start () {

}

function Update () {
if (Input.GetKeyDown(KeyCode.Escape)) 
  Application.LoadLevel("MainMenu"); 
transform.Translate(Vector3.up * roll *-1, Space.World);
}