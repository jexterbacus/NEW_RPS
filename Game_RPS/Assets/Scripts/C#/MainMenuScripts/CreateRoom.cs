using UnityEngine;
using System.Collections;

//using System.Text.RegularExpressions;

public class CreateRoom : MonoBehaviour {
	static int guiDepth = 1;
	public GUIStyle mystyle;
	public GUISkin skinGui;
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

	public float boardSpeed = 2;
	public float t;
	private Rect windowRect4;
	public Texture roomtexture;
	private int selGridInt;
	public Texture[] selGridTexture;
	public Texture chart;
	public Texture[] arrow;
	public string roomName;
	public string wager;
	private int wagerInt;
	public int pot;
	public int player = 2;
	void Awake () 
	{

		//get the screen's width
		sWidth = Screen.width;
		sHeight = Screen.height;
		// calculate the rescale ratio
		guiRatioX = sWidth / 1920 * sizegui;
		guiRatioY = sHeight / 1080 * sizegui;
		//create a rescale Vector3 with the above ratio
		GUIsF = new Vector3 (guiRatioX, guiRatioY, 1);

		windowRect4 = new Rect(200, -535, 765, 537);
	}

	// Use this for initialization
	void Start () {
	
	}

	void OnGUI () 
	{
		GUI.depth = guiDepth;
		GUI.skin = skinGui;
		GUI.matrix = Matrix4x4.TRS (new Vector3 (GUIsF.x, GUIsF.y, 0), Quaternion.identity, GUIsF);

		windowRect4 = GUI.Window(3, windowRect4, CreateRoomWindow, roomtexture);
		GUI.BringWindowToFront (3);
	}

	void CreateRoomWindow(int windowID)
	{
		if (GUI.Button (new Rect (150, 455, 170, 60), "Back")) 
		{
			StartCoroutine (CloseBoard());
		}
		if (GUI.Button (new Rect (400, 455, 170, 60), "Launch")) 
		{
			RoomOptions options = new RoomOptions();
			options.maxPlayers = player * 2;
			options.customRoomProperties = new ExitGames.Client.Photon.Hashtable();
			string[] ss = new string[2];
			ss[0] = "pot";
			ss[1] = "wage";
			options.customRoomPropertiesForLobby = ss;
			options.customRoomProperties.Add("pot" ,pot);
			options.customRoomProperties.Add("wage" ,wagerInt);

			PhotonNetwork.CreateRoom(roomName, options, TypedLobby.Default);
			StartCoroutine(CloseBoard ());
		}

		selGridInt = GUI.SelectionGrid (new Rect (posx, 8, 1100, 160),selGridInt, selGridTexture, 4);

		GUI.Box (new Rect (240, 175, 270, 155), chart); 

		if (GUI.Button (new Rect (514, 210, 95, 90), arrow[0])) 
		{
			NumChart (true);
		}
		if (GUI.Button (new Rect (140, 210, 95, 90), arrow[1])) 
		{
			NumChart (false);
		}

		GUI.Label(new Rect (275, 180, 200, 50), "" + player + " x " + player, mystyle);

		GUI.Label(new Rect (50, 342, 200, 50), "Room Name:");
		roomName = GUI.TextField(new Rect(237, 335, 275, 35), roomName, 25);

		GUI.Label(new Rect (88, 380, 200, 50), "Wager:");

		string text = GUI.TextField(new Rect(237, 375, 275, 35), wagerInt.ToString(), 9);
		int temp;
		int max = 999999999;
		if (int.TryParse(text, out temp))
		{
			wagerInt = Mathf.Clamp(temp, 0, max);
		}
		pot = wagerInt * (player * 2);
		//else if (text == "") wagerInt = 0;
		GUI.Label(new Rect (225, 420, 300, 50), "Pot: " + pot);
	}

	
	void NumChart (bool multdiv)
	{
		if (!multdiv && player >= 4)
		player = player / 2;
		else
		player = player * 2;
	}
	public IEnumerator ExpondBoard ()
	{
		for (t = 0.0f; t < 1.0f; t += Time.deltaTime * boardSpeed) 
		{
			float dropy = Mathf.SmoothStep (-535, 0, t);
			windowRect4 = new Rect(200, dropy, 765, 537);
			yield return null;
		}
	}

	IEnumerator CloseBoard ()
	{
		for (t = 0.0f; t < 1.0f; t += Time.deltaTime * boardSpeed) 
		{
			float dropy = Mathf.SmoothStep (0, -535, t);
			windowRect4 = new Rect(200, dropy, 765, 537);
			yield return null;
		}
	}
	void OnJoinedRoom ()
	{
		Application.LoadLevel ("Chart");
	}

}
