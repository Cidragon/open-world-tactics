shader_type canvas_item;

uniform bool active = true;
const vec2 sprite_size = vec2(140.0,112.0);

void fragment() {
	if (active == true){
		vec2 pixel = UV * sprite_size;
		float y = mod(pixel.y, 28.0);
		if (y >= 22.0){
			float x = mod(pixel.x, 28.0);
			if (x >= 12.0 && x <= 16.0){
				vec4 color = texture(TEXTURE, UV);
				color.r = 1.0;
				color.a = 0.0;
				COLOR = color;
			}
		if (y >= 23.0){
			vec4 color = texture(TEXTURE, UV);
			color.r = 1.0;
			color.a = 0.0;
			COLOR = color;
		}
		}
	}
	
}
