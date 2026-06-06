#version 150

uniform sampler2D Sampler0;

in vec2 texCoord;
in vec4 vertexColor;
in vec3 normal;
in vec3 viewPos;

out vec4 FragColor;

void main() {
    vec4 tex = texture(Sampler0, texCoord);
    vec3 color = tex.rgb * vertexColor.rgb;
    
    // Basic lighting
    vec3 normalizedNormal = normalize(normal);
    float light = dot(normalizedNormal, normalize(vec3(1.0, 1.0, 0.5))) * 0.5 + 0.5;
    
    color *= light;
    
    // Store normal in alpha for later use
    FragColor = vec4(color, 1.0);
    
    // You can encode normal data here for deferred shading
}
