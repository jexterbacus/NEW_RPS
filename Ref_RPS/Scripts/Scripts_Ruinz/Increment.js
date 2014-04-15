#pragma strict
var skinGui:GUISkin;
var sets:GameObject[];
var timeString:String;
var timeInt:int;
var storeClone = new Array();
var increment:float;
var crack0:GameObject[];
var crack1:GameObject[];
var count:int=0;
var countClone:int = 0;
var randSet:int = 0;
var time:float = 0;
var tiles = new Array();
private var i:int = 0;
private var go2:GameObject;
private var trans:Transform;
private var random:int;
var ranCrack:boolean;
//var random:int = 0;

function Start () {


increment = -15;
CloneObject();
CloneObject();
CloneObject();
CloneObject();
CloneObject();
CloneObject();
CloneObject();
CloneObject();
}

function OnGUI(){
	
if (Input.GetKeyDown(KeyCode.Escape)) 
	Application.Quit();

}

function DestroyClone(){
Destroy (storeClone[countClone-7]);
}
//-------------------------------------------------------------------
function CloneObject (){
countClone++;
var ranLocator:int = Random.Range(0,2);
if (countClone <= 10)
	randSet = Random.Range(0,2);
else
	randSet = Random.Range(0,sets.Length);

if (countClone <= 1){
	var clone:GameObject = Instantiate (sets[randSet], Vector3(0,0,increment), Quaternion.identity);
	}
else{
	var go:GameObject = storeClone[countClone-1];

		if (go.name == "SC_S0_C"){
			var setPos:Transform = go.transform.Find("Locator"+ranLocator); //"+ranLocator);
			}
		else{ 
			setPos = go.transform.Find("Locator");
			}
	
	clone = Instantiate (sets[randSet], setPos.transform.position, setPos.transform.rotation);
	}

	clone.SetActive (true);
	clone.name = (sets[randSet].name + "_C");
	storeClone[countClone] = clone;

increment += 5.00149;
}

//---------------------------------------------------------------------
function RandomCrack (){
i = 0;

if(randSet >= 3){
return;
}
tiles = new Array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36);

go2 = storeClone[countClone];
ranCrack = true;
if(count <= 14)
	count ++;
else
	count = 14;
}

function Update(){
if(ranCrack){
	if (i <= count){
		random = Random.Range(01,tiles.length);
		trans = go2.transform.Find("Tile_" + random);
		trans.GetComponent(SphereCollider).enabled = true;
		tiles.RemoveAt(random);
	i++;
	}
	else
		ranCrack = false;
}
}