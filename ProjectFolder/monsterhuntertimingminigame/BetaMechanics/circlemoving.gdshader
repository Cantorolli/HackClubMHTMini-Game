shader_type canvas_item;

uniform vec4 coloradditive: source_color;

void fragment() {
	vec4 colors = texture(TEXTURE, UV);
	float quickref = ((colors.r + colors.g + colors.b)/3.0);
	vec4 values = vec4(quickref,quickref,quickref,colors.a);
	COLOR = values*coloradditive;
}
