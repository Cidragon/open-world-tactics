shader_type canvas_item;

const vec2 sprite_size = vec2(112,112);
uniform bool active = false;

void fragment() {
	if(active == true){
		vec2 pixel = UV * sprite_size;
		float x = mod(pixel.x, 28.0);
		float y = mod(pixel.y, 28.0);
		vec4 color = texture(TEXTURE, UV);
		if (y >= 24.0 && y <= 25.0 && x >= 12.0 && x <= 20.0){
			color.a = 0.0;
		}
		if (y >= 25.0){
			color.a = 0.0;
		}
		COLOR = color;
		}
}
