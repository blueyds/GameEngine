import Foundation
import Metal

public let metalShaderSource = """
#include <metal_stdlib>
using namespace metal;
struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float3 normals [[ attribute(2) ]];
    float2 texCoord [[ attribute(3) ]];
};
struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};
vertex RasterizerData vertex_main(const VertexIn vIn [[ stage_in ]],
        constant float4x4 &modelMatrix [[ buffer(1) ]],
        constant float4x4 &viewMatrix [[ buffer(2) ]],
        constant float4x4 &projectionMatrix [[ buffer(3) ]]) {
    RasterizerData out;
    out.position = projectionMatrix * viewMatrix * modelMatrix * float4(vIn.position, 1);
    out.color = vIn.color;
    return out;
}
fragment half4 fragment_main(RasterizerData rIn [[stage_in]]) {
    float4 color = rIn.color;
    return half4(color.r, color.g, color.b, color.a);
}
"""
