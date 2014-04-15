using UnityEngine;
using System.Collections;

public class GUI_Texture : MonoBehaviour {
	public int pixelx = 0;
	public int pixely = 0;
	// Use this for initialization
	void Awake() {
		guiTexture.pixelInset = new Rect(0, 0, Screen.width + pixelx, Screen.height+pixely);
	}

}
