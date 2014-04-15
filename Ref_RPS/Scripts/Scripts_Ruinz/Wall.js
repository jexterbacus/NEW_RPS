#pragma strict
var speed:float;

function Update () {

//transform.Translate(Vector3.forward * speed * Time.deltaTime);
}

function FixedUpdate () {
        rigidbody.AddForce (Vector3.forward * speed);
    }