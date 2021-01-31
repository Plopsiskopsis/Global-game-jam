shader_type canvas_item;

void fragment() 
{
	COLOR = texture(TEXTURE, UV);
		if (COLOR.r > 0.79)
	{
		COLOR = vec4(0.7);
	}
}