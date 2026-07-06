---
name: add-warp-theme
description: Generate a new Warp terminal theme YAML in the warp-themes/ directory following Warp's theme schema. Use when the user wants to create or add a custom Warp theme.
---

# Add Warp Theme

## When to use
When the user wants a new custom Warp terminal theme added to this repo's `warp-themes/` collection (symlinked to `~/.warp/themes` by `setup.sh`).

## Instructions
1. Ask for the theme name and colors if not provided (background, foreground, accent, and the 16 ANSI colors — or a base palette to derive them from).
2. Create `warp-themes/<theme-name>.yaml` using Warp's schema:
   ```yaml
   name: <theme-name>
   accent: "#RRGGBB"
   background: "#RRGGBB"
   foreground: "#RRGGBB"
   details: darker # "darker" for light backgrounds, "lighter" for dark backgrounds
   terminal_colors:
     normal:
       black: "#RRGGBB"
       red: "#RRGGBB"
       green: "#RRGGBB"
       yellow: "#RRGGBB"
       blue: "#RRGGBB"
       magenta: "#RRGGBB"
       cyan: "#RRGGBB"
       white: "#RRGGBB"
     bright:
       black: "#RRGGBB"
       red: "#RRGGBB"
       green: "#RRGGBB"
       yellow: "#RRGGBB"
       blue: "#RRGGBB"
       magenta: "#RRGGBB"
       cyan: "#RRGGBB"
       white: "#RRGGBB"
   ```
3. Use valid 6-digit hex colors. Include exactly these fields — do not add a `background_image` or any extra/missing fields.
4. `warp-themes/` is a git submodule; commit and push the new theme from inside that directory.
5. The theme then appears in Warp under Settings > Appearance > Themes.

## Notes
- Set `details` based on background luminance: `darker` for light themes, `lighter` for dark themes.
