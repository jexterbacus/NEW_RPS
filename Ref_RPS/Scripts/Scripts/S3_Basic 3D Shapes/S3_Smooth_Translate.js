#pragma strict
// Minimum and maximum values for the transition.
	var target : Transform; 
	
	
    var minimumx:float;
    var maximumx:float;
    var minimumy:float;
    var maximumy:float;
    var minimumz:float;
    var maximumz:float;
    public var go:GameObject;
    var on:int = 0;
    var t:float;
    // Time taken for the transition.
    var duration = 5.0;
    
    
    var startTime: float;
    
    
function Start() {
    transform.LookAt(target);
 go = GameObject.Find("CamPosFront");
        // Make a note of the time the script started.
        startTime = Time.time;
        minimumx = transform.position.x;
    	maximumx = go.transform.position.x;
    	minimumy = transform.position.y;
    	maximumy = go.transform.position.y;
    	minimumz = transform.position.z;
    	maximumz = go.transform.position.z;
    }
    
    
function Pos(pos:int){
t = 0;
startTime = Time.time;
on = pos;
}
  
function Update() {
	
transform.LookAt(target);
	
	if(on==1){
  
        // Calculate the fraction of the total duration that has passed.
       // t = (Time.time - startTime) / duration;
        t += 1 * Time.deltaTime / duration;
        transform.position = Vector3(Mathf.SmoothStep(minimumx, maximumx, t), Mathf.SmoothStep(minimumy, maximumy, t), Mathf.SmoothStep(minimumz, maximumz, t));
        //transform.LookAt(target);
    	}
    else{
    	//t = (Time.time - startTime) / duration;
        //transform.position = Vector3(Mathf.SmoothStep(maximumx, minimumx, t), Mathf.SmoothStep(maximumy, minimumy, t), Mathf.SmoothStep(maximumz, minimumz, t));
        
        transform.position = Vector3(minimumx, minimumy, minimumz);
        transform.rotation = Quaternion.Euler(90, 180, 0);
    }
    	transform.LookAt(target);
}