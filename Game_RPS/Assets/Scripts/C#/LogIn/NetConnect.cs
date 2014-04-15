using UnityEngine;
using System.Collections;

public class NetConnect : MonoBehaviour {

	void Awake () {
		
		//PhotonNetwork.logLevel = NetworkLogLevel.Full;
		//Connect to the main photon server. This is the only IP and port we ever need to set(!)
		if (!PhotonNetwork.connected)
			PhotonNetwork.ConnectUsingSettings("v1.0"); // version of the game/demo. used to separate older clients from newer ones (e.g. if incompatible)
		
		//Load name from PlayerPrefs
		PhotonNetwork.playerName = PlayerPrefs.GetString("playerName", "Guest" + Random.Range(1, 9999));
		
		//Set camera clipping for nicer "main menu" background
		//Camera.main.farClipPlane = Camera.main.nearClipPlane + 0.1f;

	}
	// Use this for initialization
	void Start () {
	
	}

	void OnGUI (){
		// Photon__________
		if (!PhotonNetwork.connected)
		{
			ShowConnectingGUI();
			return;   //Wait for a connection
		}


	}

	void ShowConnectingGUI()
	{
		GUILayout.BeginArea(new Rect((Screen.width - 400) / 2, (Screen.height - 300) / 2, 400, 300));
		
		GUILayout.Label("Connecting to Photon server.");
		GUILayout.Label("Hint: This demo uses a settings file and logs the server address to the console.");
		
		GUILayout.EndArea();
	}

	// Update is called once per frame
	void Update () {
	
	}
}
