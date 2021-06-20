extends Control

const APP_NAME: String = "GodotPad"
var current_file = "Untitled"

func _ready():
	update_window_title()

	$MenuButtonFile.get_popup().add_item("New")
	$MenuButtonFile.get_popup().add_item("Open File")
	$MenuButtonFile.get_popup().add_item("Save as")
	$MenuButtonFile.get_popup().add_item("Exit")
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_MenuButtonFile_pressed")

	$MenuButtonHelp.get_popup().add_item("Help")
	$MenuButtonHelp.get_popup().add_item("Made with Godot Engine")
	$MenuButtonHelp.get_popup().add_item("Github Repo")
	$MenuButtonHelp.get_popup().add_item("About")
	$MenuButtonHelp.get_popup().connect("id_pressed", self, "_on_MenuButtonHelp_pressed")

func update_window_title():
	OS.set_window_title(APP_NAME + " - " + current_file)

func new_file():
	current_file = "Untitled"
	$TextEdit.text = ""
	update_window_title()

func _on_OpenFileDialog_file_selected(path):
	# print(path)
	var file : File = File.new()
	file.open(path, File.READ)
	$TextEdit.text = file.get_as_text()
	file.close()
	current_file = path
	update_window_title()

func _on_SaveFileDialog_file_selected(path):
	var file : File = File.new()
	file.open(path, File.WRITE_READ)
	file.store_string($TextEdit.text)
	file.close()
	current_file = path
	update_window_title()

func _on_ExitButton_Pressed():
	get_tree().quit()

func _on_MenuButtonFile_pressed(id):
	var item_name : String = $MenuButtonFile.get_popup().get_item_text(id)
	match item_name:
		"New":
			new_file()
		"Open File":
			$OpenFileDialog.popup()
		"Save as":
			$SaveFileDialog.popup()
		"Exit":
			_on_ExitButton_Pressed()
		_:
			# print(item_name)
			pass

func _on_MenuButtonHelp_pressed(id):
	var item_name : String = $MenuButtonHelp.get_popup().get_item_text(id)
	match item_name:
		"Help":
			$HelpWindow.popup()
		"Made with Godot Engine":
			OS.shell_open("https://godotengine.org/")
		"Github Repo":
			pass
		"About":
			$AboutWindow.popup()
		_:
			# print(item_name)
			pass			

func _on_AboutButton_pressed():
	$AboutWindow.hide()


func _on_HelpButton_pressed():
	$HelpWindow.hide()
