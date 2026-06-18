// ============================================
// 1. ЗУМ КОЛЁСИКОМ МЫШИ
// ============================================
if (mouse_wheel_up()) {
    zoom += zoom_step;
    if (zoom > max_zoom) zoom = max_zoom;
}
if (mouse_wheel_down()) {
    zoom -= zoom_step;
    if (zoom < min_zoom) zoom = min_zoom;
}

// ============================================
// 2. ОБРАБОТКА ВВОДА С АВТОПОВТОРОМ
// ============================================
var _step = cell_size;
var _moved = false;

for (var i = 0; i < 4; i++) {
    var key = key_names[i];
    var pressed = false;
    switch (key) {
        case "W": pressed = keyboard_check(ord("W")); break;
        case "A": pressed = keyboard_check(ord("A")); break;
        case "S": pressed = keyboard_check(ord("S")); break;
        case "D": pressed = keyboard_check(ord("D")); break;
    }
    
    if (pressed) {
        key_timers[i] += delta_time / 1000000;
        if (key_timers[i] >= key_repeat_delay) {
            key_timers[i] -= key_repeat_interval;
            var dx = 0, dy = 0;
            switch (key) {
                case "W": dy = -_step; break;
                case "S": dy = _step; break;
                case "A": dx = -_step; break;
                case "D": dx = _step; break;
            }
            var new_tx = orbit_center_x + dx;
            var new_ty = orbit_center_y + dy;
            // Ограничиваем движением внутри мира (world_width/world_height)
            if (new_tx >= cell_size/2 && new_tx < world_width - cell_size/2 &&
                new_ty >= cell_size/2 && new_ty < world_height - cell_size/2) {
                orbit_center_x = new_tx;
                orbit_center_y = new_ty;
                orbiting = false;
                target_x = orbit_center_x;
                target_y = orbit_center_y;
                wobble_angle = 0;
                wobble_target = 0;
                _moved = true;
            }
        }
    } else {
        key_timers[i] = 0;
    }
}

// Первое нажатие
if (!_moved) {
    var _first_dx = 0, _first_dy = 0;
    if (keyboard_check_pressed(ord("W"))) _first_dy = -_step;
    else if (keyboard_check_pressed(ord("S"))) _first_dy = _step;
    else if (keyboard_check_pressed(ord("A"))) _first_dx = -_step;
    else if (keyboard_check_pressed(ord("D"))) _first_dx = _step;
    
    if (_first_dx != 0 || _first_dy != 0) {
        var new_tx = orbit_center_x + _first_dx;
        var new_ty = orbit_center_y + _first_dy;
        if (new_tx >= cell_size/2 && new_tx < world_width - cell_size/2 &&
            new_ty >= cell_size/2 && new_ty < world_height - cell_size/2) {
            orbit_center_x = new_tx;
            orbit_center_y = new_ty;
            orbiting = false;
            target_x = orbit_center_x;
            target_y = orbit_center_y;
            wobble_angle = 0;
            wobble_target = 0;
            for (var i = 0; i < 4; i++) key_timers[i] = 0;
        }
    }
}

// ============================================
// 3. КРУЖЕНИЕ
// ============================================
var dist_to_center = point_distance(x, y, orbit_center_x, orbit_center_y);
var spd = sqrt(vx*vx + vy*vy);

if (!orbiting && dist_to_center < 64 && spd < 40) {
    orbiting = true;
    orbit_angle = point_direction(orbit_center_x, orbit_center_y, x, y);
    wobble_angle = 0;
    wobble_target = 0;
    wobble_timer = 0;
    target_x = orbit_center_x + lengthdir_x(orbit_radius, orbit_angle);
    target_y = orbit_center_y + lengthdir_y(orbit_radius, orbit_angle);
} else if (orbiting) {
    if (dist_to_center > orbit_radius * 1.8) {
        orbiting = false;
        target_x = orbit_center_x;
        target_y = orbit_center_y;
        wobble_angle = 0;
        wobble_target = 0;
    }
}

if (orbiting) {
    orbit_angle += orbit_speed * (delta_time / 1000000);
    if (orbit_angle >= 360) orbit_angle -= 360;
    wobble_timer += delta_time / 1000000;
    if (wobble_timer >= wobble_interval) {
        wobble_timer = 0;
        wobble_target = random_range(-wobble_range, wobble_range);
    }
    wobble_angle = lerp(wobble_angle, wobble_target, wobble_lerp);
    var final_angle = orbit_angle + wobble_angle;
    target_x = orbit_center_x + lengthdir_x(orbit_radius, final_angle);
    target_y = orbit_center_y + lengthdir_y(orbit_radius, final_angle);
}

// ============================================
// 4. PD-РЕГУЛЯТОР (скорость и позиция)
// ============================================
var dt = delta_time / 1000000;
if (dt > 0.05) dt = 0.05;

var err_x = target_x - x;
var err_y = target_y - y;
var ax = kp * err_x - kd * vx;
var ay = kp * err_y - kd * vy;
vx += ax * dt;
vy += ay * dt;

spd = sqrt(vx*vx + vy*vy);
if (spd > max_speed) {
    vx = vx / spd * max_speed;
    vy = vy / spd * max_speed;
    spd = max_speed;
}

var dist_to_target = sqrt(err_x*err_x + err_y*err_y);
if (dist_to_target < 0.5 && spd < 0.5) {
    x = target_x;
    y = target_y;
    vx = 0;
    vy = 0;
} else {
    x += vx * dt;
    y += vy * dt;
}

// ============================================
// 5. ПОВОРОТ БАБОЧКИ
// ============================================
if (spd > 0.5) {
    var target_angle = point_direction(0, 0, vx, vy)-90;
    var angle_diff = angle_difference(target_angle, image_angle);
    var rot_speed = 720;
    var rot_step = rot_speed * dt;
    if (abs(angle_diff) < rot_step) {
        image_angle = target_angle;
    } else {
        image_angle += sign(angle_diff) * rot_step;
    }
}

// ============================================
// 6. КАМЕРА СЛЕДИТ ЗА ТОЧКОЙ ИГРОКА (orbit_center)
// ============================================
if (view_camera[0] == -1) {
    var _cam = camera_create_view(0, 0, base_cam_w, base_cam_h);
    view_camera[0] = _cam;
}

var view_w = base_cam_w / zoom;
var view_h = base_cam_h / zoom;
var half_w = view_w / 2;
var half_h = view_h / 2;

// Цель камеры — центр клетки, выбранной игроком
var desired_cam_x = orbit_center_x;
var desired_cam_y = orbit_center_y;

// Плавное следование (можно сделать резким, установив cam_smooth = 1.0)
var dt = delta_time / 1000000;
if (dt > 0.05) dt = 0.05;
var lerp_factor = 1 - power(1 - cam_smooth, dt * 60);
cam_x = lerp(cam_x, desired_cam_x, lerp_factor);
cam_y = lerp(cam_y, desired_cam_y, lerp_factor);

// Ограничение границами мира
var min_x = half_w;
var max_x = world_width - half_w;
var min_y = half_h;
var max_y = world_height - half_h;

if (min_x > max_x) {
    cam_x = world_width / 2;
} else {
    cam_x = clamp(cam_x, min_x, max_x);
}
if (min_y > max_y) {
    cam_y = world_height / 2;
} else {
    cam_y = clamp(cam_y, min_y, max_y);
}

camera_set_view_pos(view_camera[0], cam_x - half_w, cam_y - half_h);
camera_set_view_size(view_camera[0], view_w, view_h);

// ============================================
// 7. ОТЛАДОЧНЫЙ ВЫВОД В КОНСОЛЬ
// ============================================
if (keyboard_check_pressed(ord("P"))) {
    debug_visible = !debug_visible;
}


debug_timer += dt;
if (debug_timer > 0.5) {
    debug_timer = 0;
    show_debug_message("cam: (" + string(cam_x) + ", " + string(cam_y) + "), zoom: " + string(zoom) + 
                       ", view_w: " + string(view_w) + ", view_h: " + string(view_h));
}