using UnityEngine;
using System.Collections;

public class DashBoardScript : MonoBehaviour {
	static int guiDepth = 1;
	public GUISkin skinGui;
	public GUIStyle listStyle;
	public float boardSpeed;
	public float t;
	public float groupmovex;
	public int selGridInt = 0;
	public string[] selNames = new string[] {"Room", "Chat"};
	
	bool on = true;
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
	private Rect windowRect;
	private Rect windowRect2;
	private Rect windowRect3;
	
	// for Photon_________
	//private string roomName = "myRoom";
	private Vector2 scrollPos = Vector2.zero;
	public bool imageOn = false;
	public Texture texture1;
	public int playerMoney;
	
	void Awake (){
		sWidth = Screen.width;
		sHeight = Screen.height;
		// calculate the rescale ratio
		guiRatioX = sWidth / 1920 * sizegui;
		guiRatioY = sHeight / 1080 * sizegui;
		//create a rescale Vector3 with the above ratio
		GUIsF = new Vector3 (guiRatioX, guiRatioY, 1);
		
		
		windowRect = new Rect(910, 65, 765, 537);
		windowRect2 = new Rect(910, 65, 765, 537);
		windowRect3 = new Rect(-200, -1, 201, 537);
		groupmovex = 910;
	}
	
	void Start (){
		playerMoney = PlayerPrefs.GetInt ("PlayerMoney");
	}
	
	void OnGUI() {
		GUI.depth = guiDepth;
		GUI.skin = skinGui;
		GUI.matrix = Matrix4x4.TRS (new Vector3 (GUIsF.x, GUIsF.y, 0), Quaternion.identity, GUIsF);
		//________Group__________
		GUI.BeginGroup(new Rect(groupmovex, 0, 800, 600));
		selGridInt = GUI.SelectionGrid (new Rect (48, 0, 345, 65),selGridInt, selNames, 2);
		GUI.Label (new Rect (350, 15, 345, 65), "" + playerMoney);

		if (GUI.changed) {
			GUI.BringWindowToFront (selGridInt);
		}
		
		if (on) {
			if (GUI.Button (new Rect (0, 65, 50, 475), "<<")){
				StartCoroutine (ExpondBoard ());
				on = false;
			}
		}
		else if (!on) {
			if (GUI.Button (new Rect (0, 65, 50, 475), ">>")){
				StartCoroutine (ClosedBoard ());
				on = true;
			}
		}
		GUI.EndGroup();
		//_________Group End_______
		windowRect = GUI.Window(0, windowRect, RoomWindow, "Room");
		windowRect2 = GUI.Window(1, windowRect2, ChatWindow, "Chat");
		windowRect3 = GUI.Window(2, windowRect3, ServerWindow, "Server");		
	}	
	
	void RoomWindow(int windowID) {
		if (GUI.Button (new Rect (150, 405, 170, 60), "Create")) {
			StartCoroutine (GetComponent<CreateRoom>().ExpondBoard());
		}
		if (GUI.Button (new Rect (400, 405, 170, 60), "Jion")) {
			print ("Joined");
		}
		//if (PhotonNetwork.room != null)

		GUILayout.BeginArea(new Rect(0, 10, 700, 500));
		if (PhotonNetwork.GetRoomList().Length == 0)
		{
			GUILayout.Label("..no games available..");
		}
		else 
		{
			//Room listing: simply call GetRoomList: no need to fetch/poll whatever!
			scrollPos = GUILayout.BeginScrollView(scrollPos);
			foreach (RoomInfo game in PhotonNetwork.GetRoomList())
			{

				//string wager = game.customProperties.GetObjectData("wage");
				//GUILayout.BeginHorizontal();
				int wage = (int)game.customProperties["wage"];
				int pot = (int)game.customProperties["pot"];
				if (GUILayout.Button (game.name + "  " + game.playerCount + " / " + game.maxPlayers + " / " + pot + " / " + wage, listStyle))
				{
					PhotonNetwork.JoinRoom(game.name);
					playerMoney = playerMoney - wage;
					PlayerPrefs.SetInt ("PlayerMoney", playerMoney);

				}
				//GUILayout.EndHorizontal();
			}
			GUILayout.EndScrollView();
		}
		
		GUILayout.EndArea(); 
	}
	
	void ChatWindow(int windowID) {
		
		if (GUI.Button (new Rect (150, 405, 170, 60), "Chat")) {
			print ("Create");
		}
		if (GUI.Button (new Rect (400, 405, 170, 60), "CTC")) {
			print ("Joined");
		}
	}
	
	void ServerWindow (int windowID){
		
		
		
	}
	
	IEnumerator ExpondBoard (){
		for (t = 0.0f; t < 1.0f; t += Time.deltaTime * boardSpeed) {
			float dashx = Mathf.SmoothStep (915, 200, t);
			float servx = Mathf.SmoothStep (-200, -1, t);
			groupmovex = dashx;
			windowRect = new Rect(dashx+50, 65, 765, 537);
			windowRect2 = new Rect(dashx+50, 65, 765, 537);
			windowRect3 = new Rect(servx, -1, 201, 537);
			yield return null;
		}
	}
	IEnumerator ClosedBoard (){
		for (t = 0.0f; t < 1.0f; t += Time.deltaTime * boardSpeed) {
			float dashx = Mathf.SmoothStep (200, 915, t);
			float servx = Mathf.SmoothStep (0, -200, t);
			groupmovex = dashx;
			windowRect = new Rect(dashx+50, 65, 765, 537);
			windowRect2 = new Rect(dashx+50, 65, 765, 537);
			windowRect3 = new Rect(servx, 0, 200, 537);
			yield return null;
		}
	}
}