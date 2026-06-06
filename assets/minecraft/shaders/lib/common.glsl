/**
 * Common utility functions for shader pack
 */

#ifndef COMMON_GLSL
#define COMMON_GLSL

// Constants
const float PI = 3.14159265359;
const float TAU = 6.28318530718;
const float INV_PI = 0.31830988618;

// Math utilities
float luminance(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

float linearToGamma(float value) {
    return value <= 0.0031308 ? 12.92 * value : 1.055 * pow(value, 1.0 / 2.4) - 0.055;
}

float gammaToLinear(float value) {
    return value <= 0.04045 ? value / 12.92 : pow((value + 0.055) / 1.055, 2.4);
}

vec3 linearToGamma(vec3 color) {
    return vec3(linearToGamma(color.r), linearToGamma(color.g), linearToGamma(color.b));
}

vec3 gammaToLinear(vec3 color) {
    return vec3(gammaToLinear(color.r), gammaToLinear(color.g), gammaToLinear(color.b));
}

// Fresnel calculation
float fresnel(float cosTheta, float f0) {
    return f0 + (1.0 - f0) * pow(1.0 - cosTheta, 5.0);
}

// Shadow calculation
float calculateShadow(vec3 pos, sampler2D shadowMap, mat4 shadowMatrix) {
    vec4 shadowCoord = shadowMatrix * vec4(pos, 1.0);
    shadowCoord.xyz /= shadowCoord.w;
    shadowCoord.xy = shadowCoord.xy * 0.5 + 0.5;
    
    if (shadowCoord.z > 1.0 || shadowCoord.x < 0.0 || shadowCoord.x > 1.0 || 
        shadowCoord.y < 0.0 || shadowCoord.y > 1.0) {
        return 1.0;
    }
    
    float depth = texture(shadowMap, shadowCoord.xy).r;
    return shadowCoord.z - 0.005 > depth ? 0.3 : 1.0;
}

// PCF Shadow
float calculateShadowPCF(vec3 pos, sampler2D shadowMap, mat4 shadowMatrix, float texelSize) {
    vec4 shadowCoord = shadowMatrix * vec4(pos, 1.0);
    shadowCoord.xyz /= shadowCoord.w;
    shadowCoord.xy = shadowCoord.xy * 0.5 + 0.5;
    
    float shadow = 0.0;
    for(int x = -1; x <= 1; ++x) {
        for(int y = -1; y <= 1; ++y) {
            float pcfDepth = texture(shadowMap, shadowCoord.xy + vec2(x, y) * texelSize).r;
            shadow += shadowCoord.z - 0.005 > pcfDepth ? 0.0 : 1.0;
        }
    }
    return shadow / 9.0;
}

#endif
