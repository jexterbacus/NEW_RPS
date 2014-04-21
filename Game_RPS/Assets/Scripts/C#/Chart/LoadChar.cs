using UnityEngine;
using System.Collections;

public class LoadChar : Photon.MonoBehaviour {
	GameObject player;
	// Use this for initialization
	void Start () 
	{
		player = PhotonNetwork.Instantiate("PlayerChar", Vector3.zero, Quaternion.identity,0);
		//player.name = PlayerPrefs.GetString("playerName");
		//GetComponent<Chart>().AssignSlot(player);
		//photonView.RPC("AssignSlot",PhotonTargets.All);
	}

	// Update is called once per frame
	void Update () {
	
	}
}
