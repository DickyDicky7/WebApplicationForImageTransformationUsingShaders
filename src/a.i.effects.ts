import      {                          createOpenRouter } from "@openrouter/ai-sdk-provider";
import type { OpenRouterProvider                        } from "@openrouter/ai-sdk-provider";
import      {     streamText                            } from "ai";
import type {
LanguageModel                                           } from "ai";
const openRouter: OpenRouterProvider = createOpenRouter({ apiKey: import.meta.env.VITE_KEY001 });



const promptShader = async (keywords: string[] = ["Pixelated Like Pixel Games With Pixel Size = 4"]) => {
    const   result = await streamText({
    model          : openRouter("meta-llama/llama-3.1-70b-instruct:free") as LanguageModel
                   ,
            prompt : `
create a glsl shader that has ${keywords.join(", ")} effect(s); please return only the .glsl code (Further explanations are not necessary), knowing that p5.js only supports GLSL ES 3.0/WebGL2.0 ("#version 300 es"); and the glsl format is: 

#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// If this shader needs any noise     textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D     noise<could be number or name>; // null"
// If this shader needs any bayer     textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D     bayer<could be number or name>; // null"
// If this shader needs any palette   textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D   palette<could be number or name>; // null"
// If this shader needs any pencil    textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D    pencil<could be number or name>; // null"
// If this shader needs any ascii     textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D     ascii<could be number or name>; // null"
// If this shader needs any tiled     textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D     tiled<could be number or name>; // null"
// If this shader needs any shaderToy textures then the syntax for declaring a uniform for one of those textures looks like this: "uniform sampler2D shaderToy<could be number or name>; // null"
// If this shader needs any "float" or  "int"  or "uint" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00"
// If this shader needs any                       "bool" uniforms then the syntax for declaring is: "uniform <type> <name>; // true"
// If this shader needs any "ivec2" or "uvec2" or "vec2" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00"
// If this shader needs any "ivec3" or "uvec3" or "vec3" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00, 0.00"
// If this shader needs any "ivec4" or "uvec4" or "vec4" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00, 0.00, 0.00"
// If this shader needs any                       "mat2" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00, 0.00, 0.00"
// If this shader needs any                       "mat3" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00"
// If this shader needs any                       "mat4" uniforms then the syntax for declaring is: "uniform <type> <name>; // 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00"

void main() {
// ...
}
      `
      ,
    });
    return result.toTextStreamResponse(

     );
};

export { 
    promptShader
};












