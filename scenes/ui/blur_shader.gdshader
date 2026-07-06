shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float blur = 2.0;

void fragment() {
    vec2 texel = SCREEN_PIXEL_SIZE * blur;

    vec4 c = textureLod(screen_texture, SCREEN_UV, 0.0);
    c += textureLod(screen_texture, SCREEN_UV + vec2(texel.x, 0.0), 0.0);
    c += textureLod(screen_texture, SCREEN_UV - vec2(texel.x, 0.0), 0.0);
    c += textureLod(screen_texture, SCREEN_UV + vec2(0.0, texel.y), 0.0);
    c += textureLod(screen_texture, SCREEN_UV - vec2(0.0, texel.y), 0.0);

    COLOR = c / 5.0;
}