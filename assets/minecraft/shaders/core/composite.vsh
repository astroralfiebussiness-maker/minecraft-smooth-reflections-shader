#version 150

in vec4 Position;
in vec2 UV;

uniform sampler2D Sampler0;

out vec2 texCoord;
out vec4 glColor;

void main() {
    gl_Position = Position;
    texCoord = UV;
    glColor = vec4(1.0);
}
