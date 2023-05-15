shader_type canvas_item;

uniform float outline_width = 1.0;
uniform vec4 outline_color : source_color;

const vec4 referenceColor = vec4(0.243, 0.208, 0.275, 1.0); // The reference color (3e3546)
const float threshold = 0.001; // Adjust the threshold value as needed

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;
	float a;
	float maxa = col.a;
	float mina = col.a;

	a = texture(TEXTURE, UV + vec2(0.0, -outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(0.0, outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(-outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	vec4 currentColor = texture(TEXTURE, UV);
	vec4 colorDifference = abs(currentColor - referenceColor);
	
    // Check if the current pixel color is equal to the reference color
    if (colorDifference.x <= threshold && colorDifference.y <= threshold && colorDifference.z <= threshold && colorDifference.w <= threshold) {
        COLOR = vec4(0.314, 0.725, 0.392, 1.0);
    }
}