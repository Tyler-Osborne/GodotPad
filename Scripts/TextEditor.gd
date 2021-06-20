extends Control

func _ready():
	$MenuButtonFile.get_popup().add_item("Open File")
	$MenuButtonFile.get_popup().add_item("Save as")
	$MenuButtonFile.get_popup().add_item("Exit")
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_MenuButtonFile_pressed")

	$MenuButtonHelp.get_popup().add_item("Help")
	$MenuButtonHelp.get_popup().add_item("About")
	$MenuButtonFile.get_popup().connect("id_pressed", self, "_on_MenuButtonHelp_pressed")

func _on_OpenFileDialog_file_selected(path):
	# print(path)
	var file : File = File.new()
	file.open(path, File.READ)
	$TextEdit.text = file.get_as_text()
	file.close()

func _on_SaveFileDialog_file_selected(path):
	var file : File = File.new()
	file.open(path, File.WRITE_READ)
	file.store_string($TextEdit.text)
	file.close()

func _on_ExitButton_Pressed():
	get_tree().quit()

func _on_MenuButtonFile_pressed(id):
	var item_name : String = $MenuButtonFile.get_popup().get_item_text(id)
	match item_name:
		"Open File":
			$OpenFileDialog.popup()
		"Save as":
			$SaveFileDialog.popup()
		"Exit":
			_on_ExitButton_Pressed()
		_:
			# print(item_name)
			pass

func _on_Help_pressed():
	pass

func _on_About_pressed():
	pass

func _on_MenuButtonHelp_pressed(id):
	var item_name : String = $MenuButtonFile.get_popup().get_item_text(id)
	match item_name:
		"Help":
			_on_Help_pressed()
		"About":
			_on_About_pressed()
		_:
			# print(item_name)
			pass			
