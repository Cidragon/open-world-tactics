shader_type canvas_item;

uniform bool active = true;
uniform int frame = 0;
const vec2 sprite_size = vec2(140.0,112.0);

void fragment() {
	if (active == true){
		vec2 pixel = UV * sprite_size;
		float x = mod(pixel.x, 28.0);
		float y = mod(pixel.y, 28.0);
		vec4 color = texture(TEXTURE, UV);
		
		if (frame == 0 || frame == 2){
			if (y >= 23.0){
				color.a = 0.0;
			}
		}
		COLOR = color;
	}
}
