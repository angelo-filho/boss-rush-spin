extends Node2D

func do_shake(intensity := 1.0, duration := 1.0):
	Camera.shake(intensity, duration)
