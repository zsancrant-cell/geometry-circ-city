extends DirectionalLight2D

@export var transition_duration: float = 5.0
@export var target_color: Color = Color("#bdc5ff")

func _ready() -> void:
	# Start the light color at black
	color = Color.BLACK
	
	# Create a new Tween to handle the animation
	var tween = create_tween()
	
	# Animate the "color" property from its current value (black)
	# to the target_color over the specified duration.
	tween.tween_property(self, "color", target_color, transition_duration)
