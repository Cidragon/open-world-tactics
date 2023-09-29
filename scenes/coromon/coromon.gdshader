shader_type canvas_item;

const vec2 sprite_size = vec2(112,112);
const vec2 idle_size = vec2(84,112);
uniform bool active = false;
uniform int side = 3;

void fragment() {
	if(active == true){
		vec2 pixel = UV * sprite_size;
		float x = mod(pixel.x, 28.0);
		float y = mod(pixel.y, 28.0);
		vec4 color = texture(TEXTURE, UV);
		
		//idle_left
		if (side == -1){
			pixel = UV * idle_size;
			x = mod(pixel.x, 28.0);
			y = mod(pixel.y, 28.0);
			if (y >= 24.0 && y <= 26.0 && x >= 14.0){
				color.a = 0.0;
			}
			if (y >= 25.0){
				color.a = 0.0;
			}
			COLOR = color;
		}
		//right
		if (side == 1){
			if (y >= 24.0 && y <= 25.0 && x <= 16.0){
				color.a = 0.0;
			}
			if (y >= 25.0){
				color.a = 0.0;
			}
			COLOR = color;
		}
		//left
		if (side == 3){
			if (y >= 24.0 && y <= 25.0 && x >= 12.0 && x <= 20.0){
			color.a = 0.0;
			}
			if (y >= 25.0){
				color.a = 0.0;
			}
			COLOR = color;
		}
		
	}
}
