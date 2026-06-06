#version 150

uniform sampler2D Sampler0;

in vec2 texCoord;
in vec4 vertexColor;
in vec3 normal;
in vec3 viewPos;
in float wave;

out vec4 FragColor;

void main() {
    vec3 normalizedNormal = normalize(normal);
    vec3 viewDir = normalize(-viewPos);
    
    // Fresnel effect
    float fresnel = pow(1.0 - max(dot(normalizedNormal, viewDir), 0.0), 2.0);
    
    // Water color
    vec4 waterColor = vec4(0.0, 0.3, 0.8, 0.7);
    vec3 color = mix(waterColor.rgb, vec3(1.0), fresnel * 0.5);
    
    // Add some reflection quality indicator
    color = mix(color, vec3(0.5, 0.7, 1.0), wave * 0.2);
    
    FragColor = vec4(color, waterColor.a);
}
