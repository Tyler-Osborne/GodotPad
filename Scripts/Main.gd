extends Control

func _on_OpenButton_pressed() -> void:
	$OpenFileDialog.popup()

func _on_OpenFileDialog_file_selected(path):
	# print(path)
	var file : File = File.new()
	file.open(path, File.READ)
	$TextEdit.text = file.get_as_text()

func _on_SaveButton_pressed() -> void:
	$SaveFileDialog.popup()

func _on_SaveFileDialog_file_selected(path):
	var file : File = File.new()
	file.open(path, File.WRITE_READ)
	file.store_string($TextEdit.text)
