shader_type canvas_item;

uniform bool active = true;
const vec2 sprite_size = vec2(16.0,32.0);

void fragment() {
	if (active == true){
		vec2 pixel = UV * 256.0;
		if (mod(pixel.y, 32.0) >= 22.0){
			vec4 color = texture(TEXTURE, UV);
			color.r = 1.0;
			color.a = 0.0;
			COLOR = color;
		}
	}
	
}
