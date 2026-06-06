/**
 * Screen-Space Reflection (SSR) functions
 */

#ifndef REFLECTION_GLSL
#define REFLECTION_GLSL

#include "common.glsl"

// Screen-space reflection
vec3 screenSpaceReflection(
    vec3 viewPos,
    vec3 normal,
    vec3 viewDir,
    sampler2D colorTex,
    sampler2D depthTex,
    mat4 projMatrix,
    float stepSize,
    int maxSteps
) {
    // Calculate reflection ray
    vec3 reflection = reflect(viewDir, normal);
    
    // Project to screen space
    vec3 reflectionPos = viewPos + reflection * stepSize;
    vec4 reflectionScreen = projMatrix * vec4(reflectionPos, 1.0);
    reflectionScreen.xyz /= reflectionScreen.w;
    reflectionScreen.xy = reflectionScreen.xy * 0.5 + 0.5;
    
    vec3 rayStep = reflection * stepSize;
    vec3 currentPos = viewPos;
    vec2 currentScreen = (projMatrix * vec4(viewPos, 1.0)).xy / (projMatrix * vec4(viewPos, 1.0)).w * 0.5 + 0.5;
    
    float foundReflection = 0.0;
    vec3 reflectionColor = vec3(0.0);
    
    for(int i = 0; i < maxSteps; i++) {
        currentPos += rayStep;
        vec4 screenPos = projMatrix * vec4(currentPos, 1.0);
        screenPos.xyz /= screenPos.w;
        vec2 screenUV = screenPos.xy * 0.5 + 0.5;
        
        // Boundary check
        if(screenUV.x < 0.0 || screenUV.x > 1.0 || screenUV.y < 0.0 || screenUV.y > 1.0) break;
        
        // Depth check
        float sampledDepth = texture(depthTex, screenUV).r;
        if(currentPos.z > sampledDepth) {
            reflectionColor = texture(colorTex, screenUV).rgb;
            foundReflection = 1.0;
            break;
        }
    }
    
    return reflectionColor * foundReflection;
}

// Planar reflections for water
vec3 waterReflection(
    vec3 worldPos,
    vec3 normal,
    sampler2D colorTex,
    float waterLevel,
    mat4 viewMatrix,
    mat4 projMatrix
) {
    // Mirror across water plane
    vec3 mirrorPos = worldPos;
    mirrorPos.y = 2.0 * waterLevel - mirrorPos.y;
    
    // Project to screen
    vec4 mirrorScreen = projMatrix * viewMatrix * vec4(mirrorPos, 1.0);
    mirrorScreen.xy /= mirrorScreen.w;
    vec2 mirrorUV = mirrorScreen.xy * 0.5 + 0.5;
    
    // Distort UVs based on normal
    mirrorUV += normal.xz * 0.05;
    
    // Clamp to valid range
    mirrorUV = clamp(mirrorUV, 0.0, 1.0);
    
    return texture(colorTex, mirrorUV).rgb;
}

// Environment map reflection
vec3 environmentReflection(
    vec3 normal,
    vec3 viewDir,
    samplerCube environmentMap,
    float metallic,
    float roughness
) {
    vec3 reflection = reflect(viewDir, normal);
    float lod = roughness * 8.0; // 8 mipmap levels
    return textureLod(environmentMap, reflection, lod).rgb * metallic;
}

#endif
