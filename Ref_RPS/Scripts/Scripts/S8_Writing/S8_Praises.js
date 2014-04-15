#pragma strict
var tm:TextMesh;


function Start () {
tm = gameObject.GetComponent(TextMesh);
}

function Dialogues (){
tm.characterSize = 0.2;
var random: int = Random.Range(0,7);

switch (random){
case 0:
	tm.text = "great";
	break;
case 1:
	tm.text = "nicely done";
	break;
case 2:
	tm.text = "wonderfull";
	break;
case 3:
	tm.text = "perfect";
	break;
case 4:
	tm.text = "nice job";
	break;
case 5:
	tm.text = "amazing";
	break;
case 6:
	tm.text = "perfect";
	break;
}
}

function Error (){
tm.characterSize = 0.12;
tm.text = "Error! \n Start the stroke from the tip";

}

function Update () {

}