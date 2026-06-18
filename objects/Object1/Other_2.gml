function zor (speed_x, speed_y){
	
	
	
	if speed_y < 0 {
		speed_y += (abs(speed_y) * 0.01 + 0.01);
	} else if speed_y > 0  {
		speed_y -= (abs(speed_y) * 0.01 + 0.01);
	}
	if speed_x < 0 {
		speed_x += (abs(speed_x) * 0.01 + 0.01);
	} else if speed_x > 0  {
		speed_x -= (abs(speed_x) * 0.01 + 0.01);
	}
	
	var vector = point_direction(0, 0, speed_x, speed_y);
	return [sqr(speed_y*speed_y+speed_x*speed_x), vector, speed_x, speed_y]
}
