// ============================================================
// ВКЛЮЧАЕМ ВЬЮПОРТЫ И СОЗДАЁМ КАМЕРУ
// ============================================================
view_enabled = true;
view_visible[0] = true;

if (view_camera[0] != -1) {
    camera_destroy(view_camera[0]);
}

var _cam = camera_create_view(0, 0, global.base_width, global.base_height);
view_camera[0] = _cam;
show_debug_message("✅ Камера создана в GameManager.");

// ============================================================
// СОЗДАНИЕ ТАЙЛОВОЙ КАРТЫ ЧЕРЕЗ КОД
// ============================================================
show_debug_message("🔍 Создаём Tilemap через код...");

// 1. Проверяем, есть ли уже слой "tile_walls". Если нет — создаём.
var _layer = layer_get_id("tile_walls");
if (_layer == -1) {
    _layer = layer_create("tile_walls");
    show_debug_message("✅ Создан новый слой 'tile_walls'.");
} else {
    show_debug_message("✅ Слой 'tile_walls' уже существует.");
}

// 2. Удаляем старый Tilemap, если он есть (чтобы не было дубликатов)
var _old_tilemap = layer_tilemap_get_id(_layer);
if (_old_tilemap != -1) {
    layer_tilemap_destroy(_old_tilemap);
    show_debug_message("🗑️ Старый Tilemap удалён.");
}

// 3. СОЗДАЁМ НОВЫЙ TILEMAP!
//    tile_set: ваш TileSet (скорее всего, называется TileSet1)
//    x, y: позиция в комнате (0, 0)
//    width, height: размер в тайлах (берём из размеров комнаты)
var _tile_set = TileSet1; // <- ЕСЛИ ВАШ TILESET НАЗЫВАЕТСЯ ИНАЧЕ — ИЗМЕНИТЕ ЭТО ИМЯ!
var _w = ceil(room_width / 64);  // ширина в тайлах (64 — размер тайла)
var _h = ceil(room_height / 64); // высота в тайлах
global.tilemap = layer_tilemap_create(_layer, 0, 0, _tile_set, _w, _h);

if (global.tilemap != -1) {
    show_debug_message("✅ Tilemap создан! ID: " + string(global.tilemap));
} else {
    show_debug_message("❌ ОШИБКА: Не удалось создать Tilemap. Проверьте имя TileSet.");
    global.tilemap = -1;
}

// ============================================================
// ЗАПОЛНЯЕМ СЕТКУ ДАННЫМИ ИЗ TILEMAP
// ============================================================
if (global.tilemap != -1) {
    var w = room_width div 64;
    var h = room_height div 64;
    global.grid = ds_grid_create(w, h);
    for (var _x = 0; _x < w; _x++) {
        for (var _y = 0; _y < h; _y++) {
            global.grid[# _x, _y] = tilemap_get(global.tilemap, _x, _y);
        }
    }
    show_debug_message("✅ Сетка создана, размер: " + string(w) + "x" + string(h));
    // Проверка первых клеток
    if (w > 0 && h > 0) {
        show_debug_message("Пример: клетка (0,0) = " + string(global.grid[# 0, 0]));
        show_debug_message("Пример: клетка (1,1) = " + string(global.grid[# 1, 1]));
    }
} else {
    global.grid = -1;
    show_debug_message("❌ Сетка НЕ создана.");
}

// ============================================================
// СОЗДАЁМ БАБОЧКУ, ЕСЛИ ЕЁ НЕТ
// ============================================================
if (!instance_exists(obj_Butterfly)) {
    instance_create_layer(room_width/2, room_height/2, "Instances", obj_Butterfly);
}