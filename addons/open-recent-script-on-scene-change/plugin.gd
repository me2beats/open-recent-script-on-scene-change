tool
extends EditorPlugin

"""
note:
	===================================================================================
	the plugin sets EditorSettings "open_dominant_script_on_scene_change" to false.
	When the plugin disabled, it sets it back, but it may not always work,
	so sometimes you need setting it back to true manualy (if you want it to be enabled).
	==================================================================================="""


var scenes_scripts: = {}
var ed_interface: = get_editor_interface()
var script_editor: = ed_interface.get_script_editor()
var ed_settings: = ed_interface.get_editor_settings()
var setting_path: = "text_editor/files/open_dominant_script_on_scene_change"
var recent_setting:bool= ed_settings.get_setting(setting_path)

func _enter_tree():
	ed_settings.set_setting(setting_path, false)
	connect("scene_changed", self, "on_scene_changed")
	script_editor.connect("editor_script_changed", self, "on_script_changed")

func on_scene_changed(root:Node):
	var scr:Script = scenes_scripts.get(root)
	if not scr: return
	ed_interface.edit_resource(scr)
	
func on_script_changed(scr:Script):
	var scene: = ed_interface.get_edited_scene_root()
	scenes_scripts[scene] = scr

func _exit_tree():
	ed_settings.set_setting(setting_path, recent_setting)

