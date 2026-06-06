#version 150

in vec3 Position;
in vec2 UV;
in vec3 Normal;
in vec4 Color;

uniform mat4 ModelViewMatrix;
uniform mat4 ProjectionMatrix;
uniform float GameTime;

out vec2 texCoord;
out vec4 vertexColor;
out vec3 normal;
out vec3 viewPos;
out float wave;

void main() {
    vec3 pos = Position;
    
    // Water wave animation
    pos.y += sin(Position.x * 0.05 + GameTime * 0.5) * 0.1;
    pos.y += cos(Position.z * 0.05 + GameTime * 0.3) * 0.08;
    
    gl_Position = ProjectionMatrix * ModelViewMatrix * vec4(pos, 1.0);
    
    viewPos = (ModelViewMatrix * vec4(pos, 1.0)).xyz;
    normal = normalize(mat3(ModelViewMatrix) * Normal);
    
    texCoord = UV;
    vertexColor = Color;
    wave = sin(Position.x * 0.1 + GameTime) * 0.5 + 0.5;
}
