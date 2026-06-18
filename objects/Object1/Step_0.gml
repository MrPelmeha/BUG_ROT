
var angle_to_mouse = point_direction(x, y, mouse_x, mouse_y);
image_angle = angle_to_mouse - 90; 
direction = angle_to_mouse + vector;

length = distance_to_point(mouse_x, mouse_y)
res = zor(s_x, s_y);
vector_sp = res[0];
vector = res[1];
s_x = res[2];
s_y = res[3];


if (distance_to_point(mouse_x, mouse_y) < 10) {
	delta = 0;
} else {
	delta = 0.1;
}
speed = clamp((1 * (sqrt(length*0.1)) + delta), 0, 4) ;