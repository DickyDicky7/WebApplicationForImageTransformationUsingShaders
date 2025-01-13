#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/lfGBRt


struct color0 {
 
   vec3 color;
   float bw;
  
};

color0 color;

vec3 goldFilter(vec3 Color , float amout, bool goldMap) {
  
      float bw = (Color.r+Color.g+Color.b)/(3.0f); 
     
     float b1 = 1.0f - bw;
        
        const float coeffDegree = 1.2123456789f;
        
         b1 = pow(b1,coeffDegree);
         float b2 = bw;
         b2 = pow(b2,1.0/coeffDegree);
         
         vec3 loColor = vec3(1,(2.0f*coeffDegree)/10.0f,0); 
         vec3 hiColor = vec3(1.0,1.0,0);
      
        vec3 product = (b1*loColor)+(b2*hiColor);
          
        Color = mix(Color,Color * product,amout); 
  
  if(goldMap) {
  return product;
}
  
  
  return vec3(Color);
    
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    vec3 col = texture(iChannel0,uv).rgb;
            
      col = goldFilter(col , 0.3f, false);
      
        
        
    // Output to screen
    fragColor = vec4(vec3(col),1.0);
}