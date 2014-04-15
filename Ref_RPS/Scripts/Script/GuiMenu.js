#pragma strict
var pixelx:int = 0;
var pixely:int = 0;

function Awake (){
guiTexture.pixelInset = Rect (0, 0, Screen.width+pixelx, Screen.height+pixely);
}
