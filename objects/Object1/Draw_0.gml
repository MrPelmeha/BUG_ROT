/// @DnDAction : YoYo Games.Drawing.Draw_Self
/// @DnDVersion : 1
/// @DnDHash : 4F1E0700
draw_self();

/// @DnDAction : YoYo Games.Drawing.Set_Color
/// @DnDVersion : 1
/// @DnDHash : 472BD0C7
draw_set_colour($FFFFFFFF & $ffffff);
var l472BD0C7_0=($FFFFFFFF >> 24);
draw_set_alpha(l472BD0C7_0 / $ff);

/// @DnDAction : YoYo Games.Drawing.Set_Font
/// @DnDVersion : 1
/// @DnDHash : 3D24F3D0
/// @DnDArgument : "font" "Font1"
/// @DnDSaveInfo : "font" "Font1"
draw_set_font(Font1);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 64492B9A
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "150"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "var" "speed"
draw_text(x + 0, y + 150, string("Caption: ") + string(speed));