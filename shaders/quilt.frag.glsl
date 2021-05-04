precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.y + vec2(time);
    vec2 loc = fract(squareCoord);
    color = vec3(smoothstep(-0.05, 0.05, loc.y - loc.x));

    // 2. Uncomment these lines to invert some of the triangles
    vec2 cell = squareCoord - loc;
    if (mod(2.0 * cell.x + cell.y, 4.0) == floor(seed * 4.0)) {
        color = 1.0 - color;
    }else if (mod(cell.x + 2.0 * cell.y, 4.0) == floor(seed * 4.0)){
        color = 1.0 - color;
    }else if (mod(3.0 * cell.x + 7.0 * cell.y, 11.0) == floor(seed * 11.0)){
        color = seed - color;
    }

    // 3. Uncomment these lines to produce interesting colors
    // float c = mod(3.0 * cell.x + 2.0 * cell.y, 7.0) / 7.0;
    // color = 1.0 - (1.0 - color) * vec3(c, c, c);

    float r = mod(2.0 * cell.x + 3.0 * cell.y, 10.0) / 10.0;
    float g = mod(3.0 * cell.x + 2.0 * cell.y, 10.0) / 10.0;
    float b = mod(4.0 * cell.x + 5.0 * cell.y, 10.0) / 10.0;

    color = 1.0 - (1.0 - color) * vec3(r, g, b);

    // 4. Uncomment to lighten the colors
    color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
