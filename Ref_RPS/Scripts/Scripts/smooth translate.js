#pragma strict
// Minimum and maximum values for the transition.
	
    var minimum:float;
    var maximum:float;
    public var go:GameObject;
    
    // Time taken for the transition.
    var duration = 5.0;
    
    
    var startTime: float;
    
    
    function Start() {
 go = GameObject.Find("Sphere1");
        // Make a note of the time the script started.
        startTime = Time.time;
    }
    
    
    function Update() {
    minimum = transform.position.x;
    maximum = go.transform.position.x;
        // Calculate the fraction of the total duration that has passed.
        var t = (Time.time - startTime) / duration;
        transform.position = Vector3(Mathf.SmoothStep(minimum, maximum, t), 0, 0);
    }