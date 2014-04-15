using UnityEngine;
using System.Collections;

public class FadeOut : MonoBehaviour {
	GUITexture myGUItexture;
	Color colorT;
	public float speed = 3.0f;
	bool on = false;
	float t = 0.0f;

	// Use this for initialization
	IEnumerator Start () {
		colorT = guiTexture.color;
		print ("start");
		yield return new WaitForSeconds(1);
		on = true;

	}
	
	// Update is called once per fram
	void Update(){
		if(on){
			t += Time.deltaTime * speed; 
			colorT.a = Mathf.Lerp(1.0f,0.0f, t);
			guiTexture.color = colorT;
			Debug.Log(colorT.a);
		}
		if (colorT.a <= 0)
			Application.LoadLevel ("Login");
	}
}
