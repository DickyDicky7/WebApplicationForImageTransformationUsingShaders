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
create a glsl shader that has ${keywords.join(", ")} effect(s); please return only the .glsl code, knowing that p5.js only supports GLSL ES 3.0/WebGL2.0 ("#version 300 es"); and the glsl format is: 

#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// If this shader needs a noise     texture then the syntax for declaring a uniform looks like this: "uniform sampler2D     noise<could be number or name>; // null"
// If this shader needs a bayer     texture then the syntax for declaring a uniform looks like this: "uniform sampler2D     bayer<could be number or name>; // null"
// If this shader needs a palette   texture then the syntax for declaring a uniform looks like this: "uniform sampler2D   palette<could be number or name>; // null"
// If this shader needs a pencil    texture then the syntax for declaring a uniform looks like this: "uniform sampler2D    pencil<could be number or name>; // null"
// If this shader needs a ascii     texture then the syntax for declaring a uniform looks like this: "uniform sampler2D     ascii<could be number or name>; // null"
// If this shader needs a tiled     texture then the syntax for declaring a uniform looks like this: "uniform sampler2D     tiled<could be number or name>; // null"
// If this shader needs a shaderToy texture then the syntax for declaring a uniform looks like this: "uniform sampler2D shaderToy<could be number or name>; // null"

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












