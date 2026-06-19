// ============================================
// ОТЛАДОЧНЫЙ HUD (по нажатию P)
// ============================================
if (debug_visible) {
    draw_set_font(font_debug);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var x_pos = 10;
    var y_pos = 10;
    var line_height = 20;
    
    draw_text(x_pos, y_pos, "=== ОТЛАДОЧНАЯ ИНФОРМАЦИЯ ===");
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Масштаб (zoom): " + string(zoom));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Камера (центр): x=" + string(cam_x) + ", y=" + string(cam_y));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Точка игрока (пиксели): x=" + string(orbit_center_x) + ", y=" + string(orbit_center_y));
    y_pos += line_height;
    
    // Координаты точки игрока в клетках
    var cell_x = floor(orbit_center_x / cell_size);
    var cell_y = floor(orbit_center_y / cell_size);
    draw_text(x_pos, y_pos, "Точка игрока (клетки): [" + string(cell_x) + ", " + string(cell_y) + "]");
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Бабочка: x=" + string(x) + ", y=" + string(y));
    y_pos += line_height;
    
    var spd = sqrt(vx*vx + vy*vy);
    draw_text(x_pos, y_pos, "Скорость бабочки: " + string(spd));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Кружение: " + (orbiting ? "ДА" : "НЕТ"));
    y_pos += line_height;
    
    var view_w = base_cam_w / zoom;
    var view_h = base_cam_h / zoom;
    draw_text(x_pos, y_pos, "Размер камеры: " + string(view_w) + "x" + string(view_h));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Размер мира: " + string(world_width) + "x" + string(world_height));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "Размер комнаты: " + string(room_width) + "x" + string(room_height));
    y_pos += line_height;
    
    draw_text(x_pos, y_pos, "FPS: " + string(floor(1 / delta_time * 1000000)));
    y_pos += line_height;
}