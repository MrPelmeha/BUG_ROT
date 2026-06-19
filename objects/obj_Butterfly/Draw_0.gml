draw_self();

if (orbiting) draw_set_colour(c_gray);
else draw_set_colour(c_red);
draw_circle(orbit_center_x, orbit_center_y, 8, false);
draw_set_colour(c_white);
draw_circle(orbit_center_x, orbit_center_y, 8, true);
if (orbiting) draw_set_colour(c_gray);
else draw_set_colour(c_red);
draw_circle(orbit_center_x, orbit_center_y, 6, false);

if (orbiting) {
    draw_set_colour(c_white);
    draw_set_alpha(0.2);
    draw_circle(orbit_center_x, orbit_center_y, orbit_radius, false);
    draw_set_alpha(1);
}

// ============================================
// ОТЛАДКА: тайл под мышкой (с font_debug)
// ============================================
if (debug_visible) {
    var mx = mouse_x;
    var my = mouse_y;
    var tx = floor(mx / tile_size);
    var ty = floor(my / tile_size);
    var tile = -1;
    var grid_exists = variable_global_exists("grid") && global.grid != -1;
    if (grid_exists && tx >= 0 && tx < ds_grid_width(global.grid) && ty >= 0 && ty < ds_grid_height(global.grid)) {
        tile = global.grid[# tx, ty];
    }
    draw_set_font(font_debug);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(mx + 16, my - 16, "Клетка (" + string(tx) + "," + string(ty) + ") Тайл=" + string(tile) + " Grid=" + string(grid_exists ? "есть" : "нет"));
}