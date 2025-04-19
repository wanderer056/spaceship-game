extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists("user://utils/rocket_selected.cfg"):
			return
		
	if not FileAccess.file_exists("res://utils/rocket_selected.cfg"):
		printerr("err")
		return

	var m_file_handle: FileAccess = FileAccess.open("res://utils/rocket_selected.cfg", FileAccess.READ)
	
	if m_file_handle == null:
		printerr("err")
		return
	
	if not DirAccess.dir_exists_absolute("user://utils"):
		DirAccess.make_dir_absolute("user://utils")
	
	var m_user_file = FileAccess.open("user://utils/rocket_selected.cfg", FileAccess.WRITE)
	m_user_file.store_string(m_file_handle.get_as_text())
	
	m_user_file.close()
	m_file_handle.close()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
