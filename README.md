# Smooth Reflections Shader Pack

A high-performance Minecraft shader pack focused on smooth, realistic reflections.

## Features

- **Screen-Space Reflections (SSR)** - Real-time reflections without the need for environment maps
- **Water Reflections** - Planar reflections on water surfaces with wave distortion
- **Fresnel Effects** - Realistic angle-dependent reflections
- **Normal Mapping Support** - Enhanced surface detail
- **Shadow Mapping** - PCF shadows for realistic lighting
- **Procedural Wave Animation** - Dynamic water surfaces

## Installation

1. Download the latest release from the [Releases](../../releases) page
2. Extract the shader pack folder to: `%AppData%\.minecraft\shaderpacks\`
3. Select the shader in Minecraft's Options > Video Settings > Shaders
4. Adjust settings in the shader options menu

## Performance Tips

- Reduce `reflection_quality` for better FPS on lower-end systems
- Disable `enable_ssr` if you're getting frame drops
- Adjust `ssr_distance` to balance quality vs performance
- Use `shadow_distance` of 128-256 for best performance

## Customization

Edit `shaders.properties` to customize:
- Reflection quality levels
- Shadow distances
- SSR parameters
- Feature toggles

## System Requirements

- Java Edition 1.20.1+
- GPU with GLSL 1.50+ support
- Recommended: 2GB+ dedicated graphics memory

## File Structure

```
Minecraft-Smooth-Reflections-Shader/
├── assets/
│   ├── minecraft/
│   │   ├── shaders/
│   │   │   ├── core/
│   │   │   ├── post/
│   │   │   ├── program/
│   │   │   └── lib/
├── pack.mcmeta
├── shaders.properties
└── README.md
```

## License

Use and modify freely for personal use.

## Contributing

Feel free to fork and submit pull requests for improvements!
