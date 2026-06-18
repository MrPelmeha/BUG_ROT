draw_self();

// Целевая точка
if (orbiting) draw_set_colour(c_gray);
else draw_set_colour(c_red);
draw_circle(orbit_center_x, orbit_center_y, 8, false);
draw_set_colour(c_white);
draw_circle(orbit_center_x, orbit_center_y, 8, true);
if (orbiting) draw_set_colour(c_gray);
else draw_set_colour(c_red);
draw_circle(orbit_center_x, orbit_center_y, 6, false);

// Орбита (опционально)
if (orbiting) {
    draw_set_colour(c_white);
    draw_set_alpha(0.2);
    draw_circle(orbit_center_x, orbit_center_y, orbit_radius, false);
    draw_set_alpha(1);
}