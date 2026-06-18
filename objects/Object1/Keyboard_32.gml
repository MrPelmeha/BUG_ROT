/// @DnDAction : YoYo Games.Common.Execute_Script
/// @DnDVersion : 1.1
/// @DnDHash : 26FF7435
/// @DnDArgument : "script" "Script1"
/// @DnDSaveInfo : "script" "Script1"
script_execute(Script1);

/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 6B9068B9
temp = global.variable;

/// @DnDAction : YoYo Games.Drawing.Set_Font
/// @DnDVersion : 1
/// @DnDHash : 78704073
/// @DnDArgument : "font" "Font1"
/// @DnDSaveInfo : "font" "Font1"
draw_set_font(Font1);

/// @DnDAction : YoYo Games.Drawing.Set_Alignment
/// @DnDVersion : 1.1
/// @DnDHash : 338B386D
/// @DnDArgument : "halign" "fa_center"
/// @DnDArgument : "valign" "fa_middle"
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

/// @DnDAction : YoYo Games.Drawing.Set_Color
/// @DnDVersion : 1
/// @DnDHash : 4BD77750
draw_set_colour($FFFFFFFF & $ffffff);
var l4BD77750_0=($FFFFFFFF >> 24);
draw_set_alpha(l4BD77750_0 / $ff);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 6D36F89E
/// @DnDArgument : "x" "100"
/// @DnDArgument : "y" "20"
/// @DnDArgument : "caption" ""dis: ""
/// @DnDArgument : "var" "temp"
draw_text(100, 20, string("dis: ") + string(temp));

/// @DnDAction : YoYo Games.Drawing.Draw_Line
/// @DnDVersion : 1
/// @DnDHash : 55844790
/// @DnDArgument : "x1" "10"
/// @DnDArgument : "x2" "1000"
/// @DnDArgument : "y2" "1000"
draw_line(10, 0, 1000, 1000);