extends Node


func min_max_range(val1, val2):
	var min_val = min(val1, val2)
	var max_val = max(val1, val2)

	return range(min_val, max_val)

