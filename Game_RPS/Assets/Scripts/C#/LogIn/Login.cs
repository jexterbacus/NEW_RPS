using UnityEngine;
using System.Collections;

public class Login : MonoBehaviour {
	static int guiDepth = 0;
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

	public string playerName;
	public string playerPassword;
	public bool connectOn = false;
	void Awake ()
	{
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
	
	}

	void OnGUI ()
	{
		//GUI.depth = guiDepth;
		GUI.skin = skinGui;
		GUI.matrix = Matrix4x4.TRS (new Vector3 (GUIsF.x, GUIsF.y, 0), Quaternion.identity, GUIsF);

		GUI.Box (new Rect (230, 40, 500, 350),"LogIn");
		GUI.Label(new Rect(215, 185, 200, 20), "User Name:");
		playerName = GUI.TextField(new Rect(405, 175, 300, 40), playerName, 25);
		GUI.Label(new Rect(215, 240, 200, 20), "Password:");
		playerPassword = GUI.PasswordField(new Rect(405, 230, 300, 40), playerPassword,"*"[0], 25);
		if (GUI.Button(new Rect (410, 315, 150, 60),"LogIn"))
		{
			NetConnect ();
			connectOn = true;
		}

		// Photon__________
		if (!PhotonNetwork.connected && connectOn)
		{
			GUI.Label(new Rect(60, 403, 600,100 ), "Connecting to server...");
			return;   //Wait for a connection
		}
		else if (PhotonNetwork.connected && connectOn)
		{
			GUI.Label(new Rect(60, 403, 600,100 ), "Connected...");
		}
		
	}

	void ShowConnectGUI()
	{

	}


	void NetConnect () 
	{
		//PhotonNetwork.logLevel = NetworkLogLevel.Full;
		//Connect to the main photon server. This is the only IP and port we ever need to set(!)
		if (!PhotonNetwork.connected)
			PhotonNetwork.ConnectUsingSettings("v1.0"); // version of the game/demo. used to separate older clients from newer ones (e.g. if incompatible)
		
		//Load name from PlayerPrefs
		PhotonNetwork.playerName = playerName; //PlayerPrefs.GetString("playerName", "Guest" + Random.Range(1, 9999));
	}

	public void OnApplicationQuit ()
	{
			PhotonNetwork.Disconnect ();
	}

	void OnJoinedLobby () 
	{

		PlayerPrefs.SetString ("playerName", playerName);
		Application.LoadLevel ("MainMenu");
	}

	// Update is called once per frame
	void Update () {
	
	}
}
