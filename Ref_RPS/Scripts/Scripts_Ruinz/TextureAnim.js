#pragma strict
var textSeq:Texture[];
var framesPerSecond:int = 10;
 
function Update () {
 
	// Calculate index
	var index : int = Time.time * framesPerSecond;

	index = index % textSeq.Length;

	 guiTexture.texture = textSeq[index];
}