    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    #include "lygia/color/daltonize.glsl"
//  #include "lygia/color/daltonize.glsl"

    uniform bool onProtanopees; // false
//  uniform bool onProtanopees; // false
    uniform bool onProtanopias; // false
//  uniform bool onProtanopias; // false
    uniform bool onProtanomaly; // false
//  uniform bool onProtanomaly; // false
    uniform bool onDeuteranopees; // false
//  uniform bool onDeuteranopees; // false
    uniform bool onDeuteranopias; // false
//  uniform bool onDeuteranopias; // false
    uniform bool onDeuteranomaly; // false
//  uniform bool onDeuteranomaly; // false
    uniform bool onTritanopees; // false
//  uniform bool onTritanopees; // false
    uniform bool onTritanopias; // false
//  uniform bool onTritanopias; // false
    uniform bool onTritanomaly; // false
//  uniform bool onTritanomaly; // false
    uniform bool onAchromatopsia; // false
//  uniform bool onAchromatopsia; // false
    uniform bool onAchromatomaly; // false
//  uniform bool onAchromatomaly; // false
    uniform bool onCorrections; // false
//  uniform bool onCorrections; // false

    void main()
    {
    if (onProtanopees)
//  if (onProtanopees)
    fragColor = daltonizeProtanope                                       (texture(tex0, vTexCoord));
//  fragColor = daltonizeProtanope                                       (texture(tex0, vTexCoord));
    else
//  else
    if (onProtanopias)
//  if (onProtanopias)
    fragColor =                   daltonizeProtanopia                    (texture(tex0, vTexCoord));
//  fragColor =                   daltonizeProtanopia                    (texture(tex0, vTexCoord));
    else
//  else
    if (onProtanomaly)
//  if (onProtanomaly)
    fragColor =                                      daltonizeProtanomaly(texture(tex0, vTexCoord));
//  fragColor =                                      daltonizeProtanomaly(texture(tex0, vTexCoord));
    else
//  else
    if (onDeuteranopees)
//  if (onDeuteranopees)
    fragColor = daltonizeDeuteranope                                           (texture(tex0, vTexCoord));
//  fragColor = daltonizeDeuteranope                                           (texture(tex0, vTexCoord));
    else
//  else
    if (onDeuteranopias)
//  if (onDeuteranopias)
    fragColor =                     daltonizeDeuteranopia                      (texture(tex0, vTexCoord));
//  fragColor =                     daltonizeDeuteranopia                      (texture(tex0, vTexCoord));
    else
//  else
    if (onDeuteranomaly)
//  if (onDeuteranomaly)
    fragColor =                                          daltonizeDeuteranomaly(texture(tex0, vTexCoord));
//  fragColor =                                          daltonizeDeuteranomaly(texture(tex0, vTexCoord));
    else
//  else
    if (onTritanopees)
//  if (onTritanopees)
    fragColor = daltonizeTritanope                                       (texture(tex0, vTexCoord));
//  fragColor = daltonizeTritanope                                       (texture(tex0, vTexCoord));
    else
//  else
    if (onTritanopias)
//  if (onTritanopias)
    fragColor =                   daltonizeTritanopia                    (texture(tex0, vTexCoord));
//  fragColor =                   daltonizeTritanopia                    (texture(tex0, vTexCoord));
    else
//  else
    if (onTritanomaly)
//  if (onTritanomaly)
    fragColor =                                      daltonizeTritanomaly(texture(tex0, vTexCoord));
//  fragColor =                                      daltonizeTritanomaly(texture(tex0, vTexCoord));
    else
//  else
    if (onAchromatopsia)
//  if (onAchromatopsia)
    fragColor = daltonizeAchromatopsia(texture(tex0, vTexCoord));
//  fragColor = daltonizeAchromatopsia(texture(tex0, vTexCoord));
    else
//  else
    if (onAchromatomaly)
//  if (onAchromatomaly)
    fragColor = daltonizeAchromatomaly(texture(tex0, vTexCoord));
//  fragColor = daltonizeAchromatomaly(texture(tex0, vTexCoord));
    else
//  else
    if (onCorrections)
//  if (onCorrections)
    fragColor = daltonizeCorrection   (texture(tex0, vTexCoord));
//  fragColor = daltonizeCorrection   (texture(tex0, vTexCoord));
    else
//  else
    fragColor = daltonize             (texture(tex0, vTexCoord));
//  fragColor = daltonize             (texture(tex0, vTexCoord));
    }

    // https://lygia.xyz/color/daltonize
//  // https://lygia.xyz/color/daltonize
    // https://lygia.xyz/color/daltonize
//  // https://lygia.xyz/color/daltonize
    // https://lygia.xyz/color/daltonize
//  // https://lygia.xyz/color/daltonize
