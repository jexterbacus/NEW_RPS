using UnityEngine;
using System.Collections;

public class AssignMat : Photon.MonoBehaviour {
	public GameObject goMaterials;
	public GameObject prevSlot;
	public Material material;
	public bool selected = false; 

	[RPC]
	public void AssignPlayer ()
	{
		goMaterials.GetComponent<StoreMat>().assignMat();
		goMaterials.GetComponent<StoreMat>().slot = this.gameObject;
		renderer.material = goMaterials.GetComponent<StoreMat>().playerMat[1];
		selected = true;
		//print ("hello");
	}

	void OnMouseOver () 
	{
		//material = goMaterials.GetComponent<StoreMat>().playerMat[1];
		if (!selected)
		{
			if(Input.GetMouseButtonUp(0))
			{
				photonView.RPC("AssignPlayer",PhotonTargets.All);
			}
		}	
		else
			print ("Exist");
	}
}
