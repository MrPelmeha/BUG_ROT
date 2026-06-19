// ============================================
// 1. БАЗОВЫЕ НАСТРОЙКИ
// ============================================
cell_size = 64;

x = 0;
y = 0;
target_x = 0;
target_y = 0;

// ============================================
// 2. ПАРАМЕТРЫ ПОЛЁТА (PD-регулятор)
// ============================================
vx = 0;
vy = 0;
kp = 1.5;
kd = 1.5;
max_speed = 350;

// ============================================
// 3. КРУЖЕНИЕ ВОКРУГ ЦЕЛИ
// ============================================
orbiting = false;
orbit_center_x = 0;
orbit_center_y = 0;
orbit_radius = 70;
orbit_angle = 0;
orbit_speed = 80;

// ============================================
// 4. "ЖИВОЕ" КРУЖЕНИЕ
// ============================================
wobble_angle = 0;
wobble_target = 0;
wobble_timer = 0;
wobble_interval = 0.4;
wobble_range = 15;
wobble_lerp = 0.08;

// ============================================
// 5. АВТОПОВТОР
// ============================================
key_repeat_delay = 0.25;
key_repeat_interval = 0.08;
key_names = ["W", "A", "S", "D"];
key_timers = [0, 0, 0, 0];

// ============================================
// 6. КАМЕРА И ЗУМ
// ============================================
cam_x = 0;
cam_y = 0;
cam_target_x = 0;
cam_target_y = 0;
cam_smooth = 0.08;

zoom = 1.0;
min_zoom = 0.3;
max_zoom = 3.0;
zoom_step = 0.1;

if (variable_global_exists("base_width") && variable_global_exists("base_height")) {
    base_cam_w = global.base_width;
    base_cam_h = global.base_height;
} else {
    base_cam_w = 1920;
    base_cam_h = 1080;
}

// ============================================
// 7. ВЫРАВНИВАНИЕ ПО СЕТКЕ (уже не нужно, но оставляем)
// ============================================
x = floor(x / cell_size) * cell_size + cell_size/2;
y = floor(y / cell_size) * cell_size + cell_size/2;
target_x = x;
target_y = y;
orbit_center_x = target_x;
orbit_center_y = target_y;

cam_x = x;
cam_y = y;
cam_target_x = x;
cam_target_y = y;

// ============================================
// 8. НАСТРОЙКА VIEWPORT (фиксированный размер)
// ============================================
view_enabled = true;
view_visible[0] = true;
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = base_cam_w;
view_hport[0] = base_cam_h;

if (view_camera[0] == -1) {
    var _cam = camera_create_view(0, 0, base_cam_w, base_cam_h);
    view_camera[0] = _cam;
}

// Применяем начальную позицию камеры
var view_w = base_cam_w / zoom;
var view_h = base_cam_h / zoom;
camera_set_view_size(view_camera[0], view_w, view_h);
camera_set_view_pos(view_camera[0], x - view_w/2, y - view_h/2);

// ============================================
// 9. ОТЛАДКА
// ============================================
debug_visible = false;
debug_timer = 0;

// ============================================
// 10. ЗАГРУЗКА КАРТЫ ТАЙЛОВ ИЗ РЕДАКТОРА
// ============================================
show_debug_message("🔍 Загружаем карту тайлов из слоя 'tile_walls'...");

tile_size = 64;
wall_tile = 2;
global.grid = -1;

var _tilemap_id = layer_tilemap_get_id("tile_walls");

if (_tilemap_id != -1) {
    show_debug_message("✅ Карта тайлов найдена! ID: " + string(_tilemap_id));

    var w = tilemap_get_width(_tilemap_id);
    var h = tilemap_get_height(_tilemap_id);
    show_debug_message("Размер карты: " + string(w) + "x" + string(h));

    global.grid = ds_grid_create(w, h);

    for (var _x = 0; _x < w; _x++) {
        for (var _y = 0; _y < h; _y++) {
            var _tile_data = tilemap_get(_tilemap_id, _x, _y);
            var _tile_index = tile_get_index(_tile_data);
            global.grid[# _x, _y] = _tile_index;
        }
    }

    show_debug_message("✅ Сетка успешно загружена из карты тайлов!");
    show_debug_message("Пример: клетка (0,0) = " + string(global.grid[# 0, 0]));
    show_debug_message("Пример: клетка (1,1) = " + string(global.grid[# 1, 1]));

    // ============================================
    // НОВАЯ ПОЗИЦИЯ БАБОЧКИ – ВЕРХНИЙ ЛЕВЫЙ УГОЛ (клетка 1,1)
    // ============================================
    var start_x = 1 * tile_size + tile_size/2;   // центр клетки (1,1)
    var start_y = 1 * tile_size + tile_size/2;
    x = start_x;
    y = start_y;
    target_x = x;
    target_y = y;
    orbit_center_x = x;
    orbit_center_y = y;
    cam_x = x;
    cam_y = y;
    cam_target_x = x;
    cam_target_y = y;

} else {
    show_debug_message("❌ ОШИБКА: Карта тайлов на слое 'tile_walls' не найдена!");
    show_debug_message("   Проверь имя слоя и наличие Tilemap на нём.");
    // Запасной вариант – тестовая сетка
    show_debug_message("🔄 Создаём тестовую сетку 10x10 как запасной вариант...");
    var w = 10;
    var h = 10;
    global.grid = ds_grid_create(w, h);
    ds_grid_set_region(global.grid, 0, 0, w-1, h-1, 2);
    for (var _x = 2; _x <= 7; _x++) {
        for (var _y = 2; _y <= 7; _y++) {
            global.grid[# _x, _y] = 1;
        }
    }
    var start_x = 1 * tile_size + tile_size/2;
    var start_y = 1 * tile_size + tile_size/2;
    x = start_x;
    y = start_y;
    target_x = x;
    target_y = y;
    orbit_center_x = x;
    orbit_center_y = y;
    cam_x = x;
    cam_y = y;
    cam_target_x = x;
    cam_target_y = y;
}

show_debug_message("🦋 Бабочка создана в позиции: (" + string(x) + ", " + string(y) + ")");	