#pragma strict
var randRot1:int;
var randRot2:int;
var rotSpeed:float= .3;

function Start () {
randRot1 = Random.Range(0,2);
randRot2 = Random.Range(0,2);

if (randRot1 == 0)
randRot1 = -1;
else
randRot1 = 1;

if (randRot2 == 0)
randRot2 = -1;
else
randRot2 = 1;
}

function Update () {
transform.Rotate(randRot1 * rotSpeed * Time.deltaTime, randRot2 * rotSpeed * Time.deltaTime, 0, Space.World);
}