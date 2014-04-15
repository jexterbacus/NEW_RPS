#pragma strict
var gskin:GUISkin;
    var toolbarInt : int = 0;
    var toolbarStrings : String[] = ["Toolbar1", "Toolbar2", "Toolbar3"];
    function OnGUI () {
      GUI.skin = gskin;
        toolbarInt = GUILayout.Toolbar (toolbarInt, toolbarStrings);
    }