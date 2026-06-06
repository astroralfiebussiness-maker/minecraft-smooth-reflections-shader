/**
 * Noise functions for procedural effects
 */

#ifndef NOISE_GLSL
#define NOISE_GLSL

// Pseudo-random function
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec3 random3(vec3 c) {
    float j = 4.0 * dot(c, vec3(17.0, 59.4, 15.5));
    vec3 r;
    r.z = fract(sin(j) * 43758.5453);
    r.x = fract(sin(j + 1.0) * 43758.5453);
    r.y = fract(sin(j + 2.0) * 43758.5453);
    return r - 0.5;
}

// Perlin noise
float perlinNoise(vec3 p) {
    vec3 pi = floor(p);
    vec3 pf = p - pi;
    vec3 w = pf * pf * (3.0 - 2.0 * pf);
    
    float n000 = dot(random3(pi + vec3(0, 0, 0)), pf - vec3(0, 0, 0));
    float n100 = dot(random3(pi + vec3(1, 0, 0)), pf - vec3(1, 0, 0));
    float n010 = dot(random3(pi + vec3(0, 1, 0)), pf - vec3(0, 1, 0));
    float n110 = dot(random3(pi + vec3(1, 1, 0)), pf - vec3(1, 1, 0));
    float n001 = dot(random3(pi + vec3(0, 0, 1)), pf - vec3(0, 0, 1));
    float n101 = dot(random3(pi + vec3(1, 0, 1)), pf - vec3(1, 0, 1));
    float n011 = dot(random3(pi + vec3(0, 1, 1)), pf - vec3(0, 1, 1));
    float n111 = dot(random3(pi + vec3(1, 1, 1)), pf - vec3(1, 1, 1));
    
    float nx00 = mix(n000, n100, w.x);
    float nx10 = mix(n010, n110, w.x);
    float nx0z = mix(n001, n101, w.x);
    float nx1z = mix(n011, n111, w.x);
    float nxy0 = mix(nx00, nx10, w.y);
    float nxy1 = mix(nx0z, nx1z, w.y);
    float nxyz = mix(nxy0, nxy1, w.z);
    
    return nxyz + 0.5;
}

// Fractional Brownian Motion
float fbm(vec3 p, int octaves) {
    float value = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;
    float maxValue = 0.0;
    
    for(int i = 0; i < octaves; i++) {
        value += amplitude * perlinNoise(p * frequency);
        maxValue += amplitude;
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    
    return value / maxValue;
}

#endif
