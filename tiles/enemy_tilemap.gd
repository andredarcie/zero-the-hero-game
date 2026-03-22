extends TileMapLayer

func _ready() -> void:
	if tile_set == null:
		return

	var size := tile_set.tile_size
	var offset := Vector2(size) / 2.0

	for cell in get_used_cells():
		var scene := _load_enemy_scene(cell)
		if scene == null:
			continue

		var node := scene.instantiate()
		node.global_position = Vector2(cell * size) + offset
		get_parent().call_deferred("add_child", node)

	queue_free()


func _load_enemy_scene(cell: Vector2i) -> PackedScene:
	var source_id := get_cell_source_id(cell)
	if source_id == -1:
		return null

	var source := tile_set.get_source(source_id)
	if source == null:
		return null

	var source_name := source.resource_name.strip_edges()
	if source_name.is_empty():
		return null

	var scene_paths := [
		"res://enemies/%s/%s.tscn" % [source_name, source_name],
		"res://enemies/%s.tscn" % source_name,
	]

	for scene_path in scene_paths:
		if ResourceLoader.exists(scene_path, "PackedScene"):
			return load(scene_path) as PackedScene

	return null
