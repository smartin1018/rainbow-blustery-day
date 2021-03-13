#version 150

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;
uniform float GameTime;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    vec3 position = Position + ChunkOffset;
    float animation = GameTime * 2000.0;

    float modifiedRed = 0.0;
    float modifiedGreen = 0.0;
    float modifiedBlue = 0.0;

    modifiedRed = sin((position.x + animation) / 8);
    modifiedGreen = sin((position.y + animation) / 8);
    modifiedBlue = sin((position.z + animation) / 8);

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
//    vertexColor = (Color + vec4(modifiedRed * modifiedRed, modifiedGreen * modifiedGreen, modifiedBlue * modifiedBlue, 0.0)) * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
}
