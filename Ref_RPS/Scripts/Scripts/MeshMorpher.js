#pragma strict

var m_Meshes : Mesh[]; 
var m_OneLoopLength : float = 1.0;   /// The time it takes for one loop to complete 
var m_WrapMode = WrapMode.Loop; 
var m_AutomaticTime : float = 0; 
 
var m_SrcMesh : int = -1; 
var m_DstMesh : int = -1; 
var m_Weight : float = -1; 
var m_Mesh: Mesh; 

private var go:GameObject;
private var objectScript;

var duration:int = 1;
var fadeout:int =1;
var ctime:float = 0;
var fade:float;
var fademult:float;

var on:int = 0;
var off:int = 1;
var time:float;
function Start(){
	renderer.material.color.a = 0;
}
 
/// Set the current morph in 
function SetComplexMorph (srcIndex : int, dstIndex : int, t : float) { 
   if (m_SrcMesh == srcIndex && m_DstMesh == dstIndex && Mathf.Approximately(m_Weight, t)) 
      return; 
   var v0 = m_Meshes[srcIndex].vertices; 
   var v1 = m_Meshes[dstIndex].vertices; 
   var vdst = new Vector3[m_Mesh.vertexCount]; 
   for (var i:int =0; i<vdst.Length; i++) 
      vdst[i] = Vector3.Lerp(v0[i], v1[i], t); 
 
   m_Mesh.vertices = vdst; 
   m_Mesh.RecalculateBounds(); 
} 
 
/// t is between 0 and m_Meshes.Length - 1. 
/// 0 means the first mesh, m_Meshes.Length - 1 means the last mesh. 
/// 0.5 means half of the first mesh and half of the second mesh.
function SetMorph (t : float) { 
   var floor : int = t; 
   floor = Mathf.Clamp(floor, 0, m_Meshes.Length - 2); 
   var fraction : float = t - floor; 
   fraction = Mathf.Clamp(t - floor, 0.0, 1.0); 
   SetComplexMorph (floor, floor + 1, fraction); 
} 
 
function Awake () { 
   enabled = true; 
   var filter : MeshFilter = GetComponent(MeshFilter); 
   // Make sure all meshes are assigned! 
   for (var i:int=0; i<m_Meshes.Length; i++) { 
      if (m_Meshes[i] == null) {    
         Debug.Log("MeshMorpher mesh  " + i + " has not been setup correctly"); 
         var m_AnimateAutomatically:boolean = false; 
         return; 
      } 
   } 
 
   // At least two meshes 
   if (m_Meshes.Length < 2) { 
      Debug.Log ("The mesh morpher needs at least 2 source meshes"); 
      m_AnimateAutomatically = false; 
      return; 
   } 
 
   filter.sharedMesh = m_Meshes[0]; 
   m_Mesh = filter.mesh; 
   var vertexCount = m_Mesh.vertexCount; 
   for (i=0; i<m_Meshes.Length; i++) { 
      if (m_Meshes[i].vertexCount != vertexCount) {    
         Debug.Log("Mesh " + i + " doesn't have the same number of vertices as the first mesh"); 
         m_AnimateAutomatically = false; 
         return; 
      } 
   } 
} 
 
function mMorph(cfadeout:int, cduration:int, cfademult:int){

fadeout = cfadeout;
fademult = cfademult;
duration = cduration;

ctime = 0;
m_AutomaticTime = 0;
time = 0;

fade = 0;
renderer.material.color.a = 0;
on++;
}


function Update () { 
	
   	if(on == off) {
   		ctime += 1 * Time.deltaTime;
   		var deltaTime = Time.deltaTime * (m_Meshes.Length - 1) / m_OneLoopLength; 
      	m_AutomaticTime += deltaTime; 
      	var time : float; 
      	if (m_WrapMode == WrapMode.Loop) 
        	time = Mathf.Repeat(m_AutomaticTime, m_Meshes.Length - 1); 
      	else if (m_WrapMode == WrapMode.PingPong) 
        	time = Mathf.PingPong(m_AutomaticTime, m_Meshes.Length - 1); 
      	else 
        	time = Mathf.Clamp(m_AutomaticTime, 0, m_Meshes.Length - 1); 
 	
 	SetMorph (time);
 		if(ctime <= fadeout && fade <= 1){
 			fade += fademult * Time.deltaTime;
 			renderer.material.color.a = fade;
 			}
 		if(ctime >= fadeout){
 			fade -= fademult * Time.deltaTime;
   			renderer.material.color.a = fade;
   			}
  		if(ctime >= duration){
   			go = GameObject.Find("Controller");
			var objectScriptCont:ControlerScript = go.GetComponent(ControlerScript);
  			objectScriptCont.Call();
  			off++;
  			GetComponent(MeshRenderer).enabled = false;
			GetComponent(MeshMorpher).enabled = false;
  			}
     }
} 
 