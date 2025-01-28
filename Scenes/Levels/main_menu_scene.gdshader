shader_type canvas_item;

uniform float dist = 0.7;

void fragment() {
	vec3 curColor = texture(TEXTURE, UV).rgb;
	vec3 rightColor = texture(TEXTURE, UV + vec2(1,0)).rgb;
	vec3 bottomColor = texture(TEXTURE, UV - vec2(0,1)).rgb;
	float rDist = length(curColor - rightColor);
	float bDist = length(curColor - bottomColor);
	
	COLOR.rgb = (rDist > dist || bDist > dist) ? vec3(1.0) : vec3(0.0);
}
