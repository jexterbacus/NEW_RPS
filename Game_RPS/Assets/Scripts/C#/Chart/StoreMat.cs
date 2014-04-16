using UnityEngine;
using System.Collections;

public class StoreMat : MonoBehaviour {
	public GameObject slot;// = new GameObject("DefaultSlot");
	public Material[] playerMat;

	[RPC]
public void assignMat ()
	{
		slot.renderer.material = playerMat[0];
		slot.GetComponent<AssignMat>().selected = false;
	}
void Update () {

	//print (slot.name);
}

}