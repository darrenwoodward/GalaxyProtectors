extends ParallaxBackground

@onready var space_layer = %SpaceLayer
@onready var far_stars_layer = %FarStarsLayer
@onready var close_stars_layer = %CloseStarsLayer

const CLOSE_STAR_SPEED = 20
const FAR_STAR_SPEED = 5
const BG_SPEED = 2

func _process(delta):
	space_layer.motion_offset.y += BG_SPEED * delta
	close_stars_layer.motion_offset.y += CLOSE_STAR_SPEED * delta
	far_stars_layer.motion_offset.y += FAR_STAR_SPEED * delta
