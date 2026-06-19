// ============================================
// 1. БАЗОВЫЕ НАСТРОЙКИ
// ============================================
cell_size = 64;
world_width = 256 * cell_size;   // 16384
world_height = 256 * cell_size;  // 16384

x = 0;
y = 0;
target_x = 0;
target_y = 0;

// ============================================
// 2. ПАРАМЕТРЫ ПОЛЁТА (PD-регулятор)
// ============================================
vx = 0;
vy = 0;
kp = 1.8;      // было 1.5 – увеличили для более быстрой реакции
kd = 1.5;      // оставляем без изменений (можно поэкспериментировать)
max_speed = 400; // было 350 – теперь максимальная скорость выше

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
cam_smooth = 0.14;

zoom = 1.0;
min_zoom = 0.3;
max_zoom = 3.0;
zoom_step = 0.1;

// Базовый размер камеры (размер окна)
if (variable_global_exists("base_width") && variable_global_exists("base_height")) {
    base_cam_w = global.base_width;
    base_cam_h = global.base_height;
} else {
    base_cam_w = 1920;
    base_cam_h = 1080;
}

// ============================================
// 7. ВЫРАВНИВАНИЕ ПО СЕТКЕ
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

// Если камеры нет — создаём
if (view_camera[0] == -1) {
    var _cam = camera_create_view(0, 0, base_cam_w, base_cam_h);
    view_camera[0] = _cam;
}

// Сразу применяем камеру к позиции бабочки
var view_w = base_cam_w / zoom;
var view_h = base_cam_h / zoom;
camera_set_view_size(view_camera[0], view_w, view_h);
camera_set_view_pos(view_camera[0], x - view_w/2, y - view_h/2);

// ============================================
// ОТЛАДОЧНОЕ ОКНО (HUD)
// ============================================
debug_visible = false;   // по умолчанию скрыто

// Отладка
debug_timer = 0;
show_debug_message("Мир: " + string(world_width) + "x" + string(world_height));
show_debug_message("Камера инициализирована. base_cam_w=" + string(base_cam_w) + ", base_cam_h=" + string(base_cam_h));