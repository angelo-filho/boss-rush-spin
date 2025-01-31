class_name CardSprite
extends Sprite2D

var tween: Tween

var base_alpha: float 
var base_scale: Vector2

func _ready() -> void:
	hide()
	
	base_alpha = modulate.a
	base_scale = scale

func slide_in_down():
	show()
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	
	$"../../SFXs/CardFlip".play()
	
	tween.tween_property(self, "modulate:a", base_alpha, 0.3).from(0.0)
	tween.parallel()
	tween.tween_property(self, "position", position, 0.3).from(position - Vector2(0, 400.0))


func exit_anim():
	if tween:
		tween.kill()
	
	tween = create_tween()
	
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.parallel()
	tween.tween_property(self, "scale", scale * 1.3, 0.3)
	tween.tween_callback(_on_exit_anim_finished)


func _on_exit_anim_finished():
	hide()
	
	scale = base_scale
