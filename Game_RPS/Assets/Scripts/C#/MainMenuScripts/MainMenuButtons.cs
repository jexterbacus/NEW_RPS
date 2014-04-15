using UnityEngine;
using System.Collections;

public class MainMenuButtons : MonoBehaviour {
	static int guiDepth = 3;
	public Texture[] bgs;
	public Texture[] profilePics;
	//public string playerName;
	public GUISkin skinGui;
	// the GUI scale ratio
	public float guiRatioX;
	public float guiRatioY;
	// the screen width
	public float sWidth;
	public float sHeight;
	//A vector3 that will be created using the scale ratio
	public Vector3 GUIsF;
	// GUI multiplier
	public int sizegui = 2;

	// temp possition/scale
	public float posx;
	public float posy;
	public float scalex;
	public float scaley;

	void Awake(){
		//get the screen's width
		sWidth = Screen.width;
		sHeight = Screen.height;
		// calculate the rescale ratio
		guiRatioX = sWidth / 1920 * sizegui;
		guiRatioY = sHeight / 1080 * sizegui;
		//create a rescale Vector3 with the above ratio
		GUIsF = new Vector3 (guiRatioX, guiRatioY, 1);
		}
	// Use this for initialization
	void Start () {
		PhotonNetwork.playerName = PlayerPrefs.GetString ("playerName");
	}

	void OnGUI () {
		GUI.depth = guiDepth;
		GUI.skin = skinGui;
		GUI.matrix = Matrix4x4.TRS (new Vector3 (GUIsF.x, GUIsF.y, 0), Quaternion.identity, GUIsF);
		GUI.Box (new Rect (0, 0, 958, 540),bgs[0]);
		GUI.Box (new Rect (0, 0, 200, 540),"");
		GUI.Label (new Rect (10, 195, 180, 180),PhotonNetwork.playerName);

		if(GUI.Button(new Rect (10, 5, 180, 180),profilePics[0])){
			print ("single");
		}
		if(GUI.Button(new Rect(10,240,180,70),"Single Player")){
			print ("single");
			}
		if(GUI.Button(new Rect(10,313,180,70),"Multi Player")){
			print ("single");
			}
		if(GUI.Button(new Rect(10,386,180,70),"Tutorials")){
			print ("single");
			}
		if(GUI.Button(new Rect(10,460,180,70),"Quit")){
			print ("single");
			}
		}
	// Update is called once per frame
	void Update () {
	
	}
}
