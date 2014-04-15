#pragma strict
var score:int;
var hscore:int = 0;
var player:String;
function OnTriggerEnter (other : Collider) {
	
	if(other.name != "NextRail"){
		hscore = PlayerPrefs.GetInt("HighScore");
		
		var go:GameObject = GameObject.Find("Score");
		score = go.GetComponent(Score).score;
		PlayerPrefs.SetInt("Score",score);
	
	if (score > hscore){
		PlayerPrefs.SetInt("HighScore",score);
		//player = PlayerPrefs.GetString("Player");
		//PlayerPrefs.SetString("PlayerSH",player);
		}

	Application.LoadLevel("GameOver");
	}
}