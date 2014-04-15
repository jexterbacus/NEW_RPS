#pragma strict
var go:GameObject;
var cenScreen:float;

function Awake (){
cenScreen = Screen.width/2;
}

function Update (){


for (var evt : Touch in Input.touches) {
	if (evt.phase == TouchPhase.Stationary){
		if(evt.position.x > cenScreen){
			go.GetComponent(Advn_Mvmt_Cnt).Jump();
			}
		else if(evt.position.x < cenScreen){
			go.GetComponent(Advn_Mvmt_Cnt).ToRoll();;
			}
		}
	if (evt.phase == TouchPhase.Ended) {
			go.GetComponent(Advn_Mvmt_Cnt).RollOff();
		}
	}
}