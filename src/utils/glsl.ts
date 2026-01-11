    import * as types from "../types";
//  import * as types from "../types";

    export function parseGLSL(glslCode: string): types.GLSLUniforms {
//  export function parseGLSL(glslCode: string): types.GLSLUniforms {
        const uniformRegex: RegExp = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
//      const uniformRegex: RegExp = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
        const uniforms: types.GLSLUniforms = [];
//      const uniforms: types.GLSLUniforms = [];
        let match: RegExpExecArray | null;
//      let match: RegExpExecArray | null;
        while ((match = uniformRegex.exec(glslCode)) !== null) {
//      while ((match = uniformRegex.exec(glslCode)) !== null) {
            const [
//          const [
                , type
//              , type
                , name
//              , name
                ,
//              ,
                , defaultValueRaw
//              , defaultValueRaw
            ] = match;
//          ] = match;
            // guard - filter
//          // guard - filter
            // not editable - auto set internal
//          // not editable - auto set internal
            if (name === "tex0"
//          if (name === "tex0"
            ||  name === "vTexCoord"
//          ||  name === "vTexCoord"
            ||  name === "fragColor"
//          ||  name === "fragColor"
            ||  name === "time"
//          ||  name === "time"
            ||  name === "canvasSize"
//          ||  name === "canvasSize"
            ||  name === "texelSize"
//          ||  name === "texelSize"
            ||  name === "mousePosition"
//          ||  name === "mousePosition"
            ||  name === "frameCount"
//          ||  name === "frameCount"
            ) {
//          ) {
                continue;
//              continue;
            }
//          }
            // Parse the default value based on type
//          // Parse the default value based on type
            let parsedValue: types.GLSLUniformValue | null = null;
//          let parsedValue: types.GLSLUniformValue | null = null;
            if (defaultValueRaw) {
//          if (defaultValueRaw) {
                const cleanedValue = defaultValueRaw.replace(/\s+/g, ""); // Remove spaces
//              const cleanedValue = defaultValueRaw.replace(/\s+/g, ""); // Remove spaces
                switch (type) {
//              switch (type) {
                    case "float":
//                  case "float":
                    case "int":
//                  case "int":
                    case "uint":
//                  case "uint":
                        parsedValue = parseFloat(cleanedValue);
//                      parsedValue = parseFloat(cleanedValue);
                        break;
//                      break;
                    case "bool":
//                  case "bool":
                        parsedValue = cleanedValue === "true" || cleanedValue === "!false";
//                      parsedValue = cleanedValue === "true" || cleanedValue === "!false";
                        break;
//                      break;
                    case "vec2":
//                  case "vec2":
                    case "vec3":
//                  case "vec3":
                    case "vec4":
//                  case "vec4":
                    case "ivec2":
//                  case "ivec2":
                    case "ivec3":
//                  case "ivec3":
                    case "ivec4":
//                  case "ivec4":
                    case "uvec2":
//                  case "uvec2":
                    case "uvec3":
//                  case "uvec3":
                    case "uvec4":
//                  case "uvec4":
                    case "mat2":
//                  case "mat2":
                    case "mat3":
//                  case "mat3":
                    case "mat4":
//                  case "mat4":
                        parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
//                      parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
                        break;
//                      break;
                    case "sampler2D":
//                  case "sampler2D":
                    case "sampler3D":
//                  case "sampler3D":
                    case "samplerCube":
//                  case "samplerCube":
                        parsedValue = cleanedValue; // Use the raw string for sampler types
//                      parsedValue = cleanedValue; // Use the raw string for sampler types
                        break;
//                      break;
                    default:
//                  default:
                        parsedValue = null!; // Unsupported type
//                      parsedValue = null!; // Unsupported type
                }
//              }
            }
//          }
            uniforms.push({
//          uniforms.push({
                thisUniformName: name,
//              thisUniformName: name,
                thisUniformNameJustForDisplay: null,
//              thisUniformNameJustForDisplay: null,
                thisUniformType: type,
//              thisUniformType: type,
                thisUniformDefaultValue: parsedValue,
//              thisUniformDefaultValue: parsedValue,
                thisUniformSampler2DImg: null,
//              thisUniformSampler2DImg: null,
                thisUniformSampler2DEle: null,
//              thisUniformSampler2DEle: null,
            });
//          });
        }
//      }
        return uniforms;
//      return uniforms;
    }
//  }
