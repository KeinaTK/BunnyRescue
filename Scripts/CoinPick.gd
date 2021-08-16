extends Area2D

const DELTAS = [
	Vector2.ZERO,
	Vector2.UP, Vector2.DOWN
]

const INTERVAL = 5
var CURRENT = 0

signal pickCoin(value)

func _process(delta):
	CURRENT = (CURRENT + 1) % INTERVAL
	
	if CURRENT == 0:
		var bodies = get_overlapping_bodies()
		
		for body in bodies:
			if body is TileMap:
				
				var x = global_position.x / body.cell_size.x
				var y = global_position.y / body.cell_size.y
				var pos = Vector2(x, y)
				
				for d in DELTAS:
					
					var coinval = body.get_cellv(pos+d)
					if coinval != -1:
						body.set_cellv(pos+d, -1)
						
						#emit_signal("pickCoin", pow(10, coinval))
						var r = coinval % 2 + 1 * sign(coinval)
						emit_signal("pickCoin", pow(10, r))
						break
						
				body.update_dirty_quadrants()
