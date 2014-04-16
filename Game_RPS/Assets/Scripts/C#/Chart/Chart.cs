using UnityEngine;
using System.Collections;

public class Chart : Photon.MonoBehaviour {
	public GameObject[] playerSlot = new GameObject[4];
	public GameObject player;
	public int playerMoney;
	// Use this for initialization
	void Start () {
	
		playerMoney = PlayerPrefs.GetInt ("PlayerMoney");

	}
	public void AssignSlot (GameObject _player)
	{
		player = _player;
		photonView.RPC("AssigningSlot",PhotonTargets.All);
	}

	[RPC]
	public void AssigningSlot ()
	{
		for (int i=0;i<=3;i++)
		{
			if(playerSlot[i] == null)
			{
				playerSlot[i] = player;
				break;
			}
			else
				return;
		}
	}

	void OnGUI ()
	{
		GUI.Label (new Rect (0, 0, 100, 100), "" + playerMoney);
	}
	// Update is called once per frame
	void Update () {
	
	}
}
