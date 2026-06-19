// ============================================================
// ВКЛЮЧАЕМ ВЬЮПОРТЫ И СОЗДАЁМ КАМЕРУ
// ============================================================
view_enabled = true;
view_visible[0] = true;

// Если камера уже существует, удаляем её (чтобы не плодить копии)
if (view_camera[0] != -1) {
    camera_destroy(view_camera[0]);
}

// Создаём камеру с базовым разрешением
var _cam = camera_create_view(0, 0, global.base_width, global.base_height);
view_camera[0] = _cam;

// Дополнительно: можно задать начальную позицию камеры (центр комнаты)
// camera_set_view_pos(_cam, room_width/2 - global.base_width/2, room_height/2 - global.base_height/2);