#version 150

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;
uniform float GameTime;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;

void main() {
    vec3 position = Position + ChunkOffset;
    float animation = GameTime * 1000.0;
    vec2 Pos = UV0*1024;

    float xs = 0.0;
    float zs = 0.0;
    float ys = 0.0;
    bool flag = false;

    if (Pos.x >= 288.0 && Pos.x < 304.0) {
        if (Pos.y >= 64.0 && Pos.y < 80.0) {
            flag = true;
        }
    }
    if (Pos.x >= 144.0 && Pos.x < 160.0) {
        if (Pos.y >= 272.0 && Pos.y < 288.0) {
            flag = true;
        }
    }
    if (Pos.x >= 16.0 && Pos.x < 32.0) {
        if (Pos.y >= 368.0 && Pos.y < 384.0) {
            flag = true;
        }
    }
    if (Pos.x >= 160.0 && Pos.x < 172.0) {
        if (Pos.y >= 96.0 && Pos.y < 112.0) {
            flag = true;
        }
    }
    if (Pos.x >= 256.0 && Pos.x < 272.0) {
        if (Pos.y >= 48.0 && Pos.y < 64.0) {
            flag = true;
        }
    }
    if (Pos.x >= 192.0 && Pos.x < 208.0) {
        if (Pos.y >= 0.0 && Pos.y < 32.0) {
            flag = true;
        }
    }
    if (Pos.x >= 448.0 && Pos.x < 464.0) {
        if (Pos.y >= 0.0 && Pos.y < 16.0) {
            flag = true;
        }
    }

    if (flag) {
        xs = sin(position.x + animation);
        zs = cos(position.z + animation);
        ys = sin(position.x + animation) * cos(position.z + animation);
    }

    gl_Position = ProjMat * ModelViewMat * (vec4(position, 1.0) + vec4(xs / 32.0, ys / 32.0, zs / 32.0, 0.0));

    vertexDistance = length((ModelViewMat * vec4(Position + ChunkOffset, 1.0)).xyz);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
}
