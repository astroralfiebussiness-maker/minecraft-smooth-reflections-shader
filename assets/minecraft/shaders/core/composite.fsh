#version 150

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

in vec2 texCoord;
in vec4 glColor;

out vec4 FragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord);
    vec4 reflection = texture(Sampler1, texCoord);
    
    // Blend original with reflections
    vec3 final = mix(color.rgb, reflection.rgb, reflection.a * 0.5);
    
    FragColor = vec4(final, color.a);
}
