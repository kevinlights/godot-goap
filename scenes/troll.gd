# This NPC does not use GOAP.
# This is just a simple script which chooses
# a random position in the scene to move to.
extends CharacterBody2D

var _target


func _ready():
	_pick_random_position()
	$body.play("run")


func _process(delta):
	if self.position.distance_to(_target) > 1 : # 移动逻辑
		var direction = self.position.direction_to(_target)
		if direction.x > 0: # 根据水平方向来改变图片方向
			turn_right()
		else:
			turn_left()

	# warning-ignore:return_value_discarded
		move_and_collide(direction * delta * 100)
	else: # 休息，同时停止 process，等待计时器停止逻辑
		$body.play("idle")
		$rest_timer.start()
		set_process(false)


func _pick_random_position():
	#randomize()
	#_target = Vector2(randi() % 445 + 5, randi() % 245 + 5) # [5,5] -> [450,250]
	_target = WorldState.get_rand_pos()

# 计时停止时，重新随机选取位置并处理逻辑
func _on_rest_timer_timeout():
	_pick_random_position()
	$body.play("run")
	set_process(true)

# 转向右边时，将图像和射线都取反
func turn_right():
	if not $body.flip_h:
		return

	$body.flip_h = false
	$RayCast2D.target_position *= -1


func turn_left():
	if $body.flip_h:
		return

	$body.flip_h = true
	$RayCast2D.target_position *= -1
