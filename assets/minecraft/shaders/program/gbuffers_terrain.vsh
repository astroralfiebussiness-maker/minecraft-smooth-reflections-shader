#version 150

in vec3 Position;
in vec2 UV;
in vec3 Normal;
in vec4 Color;

uniform mat4 ModelViewMatrix;
uniform mat4 ProjectionMatrix;

out vec2 texCoord;
out vec4 vertexColor;
out vec3 normal;
out vec3 viewPos;

void main() {
    gl_Position = ProjectionMatrix * ModelViewMatrix * vec4(Position, 1.0);
    
    viewPos = (ModelViewMatrix * vec4(Position, 1.0)).xyz;
    normal = normalize(mat3(ModelViewMatrix) * Normal);
    
    texCoord = UV;
    vertexColor = Color;
}
