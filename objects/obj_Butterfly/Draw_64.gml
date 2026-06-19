if (debug_visible) {
    draw_set_font(font_debug);
    draw_set_colour(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var x_pos = 10;
    var y_pos = 10;
    var line_height = 20;

    draw_text(x_pos, y_pos, "=== ОТЛАДКА ===");
    y_pos += line_height;
    draw_text(x_pos, y_pos, "Zoom: " + string(zoom));
    y_pos += line_height;
    draw_text(x_pos, y_pos, "Камера: (" + string(cam_x) + ", " + string(cam_y) + ")");
    y_pos += line_height;
    draw_text(x_pos, y_pos, "Точка: (" + string(orbit_center_x) + ", " + string(orbit_center_y) + ")");
    y_pos += line_height;
    draw_text(x_pos, y_pos, "Бабочка: (" + string(x) + ", " + string(y) + ")");
    y_pos += line_height;
    draw_text(x_pos, y_pos, "Кружение: " + (orbiting ? "ДА" : "НЕТ"));
}