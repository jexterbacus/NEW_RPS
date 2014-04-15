#pragma strict
var score:int;
var highScore:int = 0;
function OnTriggerEnter (other : Collider) {

if(other.name == "Roy_Walk_plotted"){
	highScore = PlayerPrefs.GetInt("HighScore");
	
	var go:GameObject = GameObject.Find("GUICam");
	score = go.GetComponent(UI_01).timeInt;
	PlayerPrefs.SetInt("Score",score);
	
	if (score > highScore){
		PlayerPrefs.SetInt("HighScore",score);
		}
	Application.LoadLevel ("GameOver");
	}
}