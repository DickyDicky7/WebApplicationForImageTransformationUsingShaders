#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/daltonize"

uniform bool onProtanopees; // false
uniform bool onProtanopias; // false
uniform bool onProtanomaly; // false
uniform bool onDeuteranopees; // false
uniform bool onDeuteranopias; // false
uniform bool onDeuteranomaly; // false
uniform bool onTritanopees; // false
uniform bool onTritanopias; // false
uniform bool onTritanomaly; // false
uniform bool onAchromatopsia; // false
uniform bool onAchromatomaly; // false
uniform bool onCorrections; // false

void main()
{
    if (onProtanopees)
    fragColor = daltonizeProtanope                                       (texture(tex0, vTexCoord));
    else
    if (onProtanopias)
    fragColor =                   daltonizeProtanopia                    (texture(tex0, vTexCoord));
    else
    if (onProtanomaly)
    fragColor =                                      daltonizeProtanomaly(texture(tex0, vTexCoord));
    else
    if (onDeuteranopees)
    fragColor = daltonizeDeuteranope                                           (texture(tex0, vTexCoord));
    else
    if (onDeuteranopias)
    fragColor =                     daltonizeDeuteranopia                      (texture(tex0, vTexCoord));
    else
    if (onDeuteranomaly)
    fragColor =                                          daltonizeDeuteranomaly(texture(tex0, vTexCoord));
    else
    if (onTritanopees)
    fragColor = daltonizeTritanope                                       (texture(tex0, vTexCoord));
    else
    if (onTritanopias)
    fragColor =                   daltonizeTritanopia                    (texture(tex0, vTexCoord));
    else
    if (onTritanomaly)
    fragColor =                                      daltonizeTritanomaly(texture(tex0, vTexCoord));
    else
    if (onAchromatopsia)
    fragColor = daltonizeAchromatopsia(texture(tex0, vTexCoord));
    else
    if (onAchromatomaly)
    fragColor = daltonizeAchromatomaly(texture(tex0, vTexCoord));
    else
    if (onCorrections)    
    fragColor = daltonizeCorrection   (texture(tex0, vTexCoord));
    else
    fragColor = daltonize             (texture(tex0, vTexCoord));
}

// https://lygia.xyz/color/daltonize
// https://lygia.xyz/color/daltonize
// https://lygia.xyz/color/daltonize
