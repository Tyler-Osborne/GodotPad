extends Control

const APP_NAME: String = "GodotPad"
var current_file = "Untitled"

func _ready():
	update_window_title()

	$MenuButtonFile.get_popup().add_item("New")
	$MenuButtonFile.get_popup().add_item("Open")
	$MenuButtonFile.get_popup().add_item("Save")
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

func save_file():
	var path = current_file
	if path == "Untitled":
		$SaveFileDialog.popup()
	else:
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
		"Open":
			$OpenFileDialog.popup()
		"Save":
			save_file()
		"Save as":
			$SaveFileDialog.popup()
		"Exit":
			_on_ExitButton_Pressed()

func _on_MenuButtonHelp_pressed(id):
	var item_name : String = $MenuButtonHelp.get_popup().get_item_text(id)
	match item_name:
		"Help":
			$HelpWindow.popup()
		"Made with Godot Engine":
			OS.shell_open("https://godotengine.org/")
		"Github Repo":
			OS.shell_open("https://github.com/Tyler-Osborne/GodotPad")
		"About":
			$AboutWindow.popup()		

func _on_AboutButton_pressed():
	$AboutWindow.hide()


func _on_HelpButton_pressed():
	$HelpWindow.hide()
