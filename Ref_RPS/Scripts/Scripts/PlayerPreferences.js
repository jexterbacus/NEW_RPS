#pragma strict

function Start () {
var numberArray = new int[10];
for (n in numberArray) n = Random.Range(-10, 11);
PlayerPrefsX.SetIntArray ("Numbers", numberArray);

numberArray = PlayerPrefsX.GetIntArray ("Numbers");
print(numberArray);
}

function Update () {

}