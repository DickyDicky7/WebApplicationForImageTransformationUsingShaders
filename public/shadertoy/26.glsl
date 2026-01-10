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

    void main(  )
    {
    vec2 uv    = vTexCoord;
//  vec2 uv    = vTexCoord;
    uv   -= .5;
//  uv   -= .5;
    uv.x *=   canvasSize.x
//  uv.x *=   canvasSize.x
    /    canvasSize.y ;
//  /    canvasSize.y ;
    
    float timeee = time * 0.5;
//  float timeee = time * 0.5;
    
    vec3 rd    = normalize(vec3(uv.x + sin(timeee - 90.) * 0.5, uv.y - 0.2, 1.));
//  vec3 rd    = normalize(vec3(uv.x + sin(timeee - 90.) * 0.5, uv.y - 0.2, 1.));
    vec3 focus = normalize(vec3( 0.  + sin(timeee - 90.) * 0.5,      - 0.2, 1.));
//  vec3 focus = normalize(vec3( 0.  + sin(timeee - 90.) * 0.5,      - 0.2, 1.));
    
    vec3 sundir = normalize(vec3(-0., 0., 1.));
//  vec3 sundir = normalize(vec3(-0., 0., 1.));
    vec3    col =           vec3( 0.         );
//  vec3    col =           vec3( 0.         );
    
    //sun
//  //sun
    //sun
//  //sun
    col += 0.05 / length(rd - sundir     ) *       vec3(1.)          ;
//  col += 0.05 / length(rd - sundir     ) *       vec3(1.)          ;
    //sun halo
//  //sun halo
    //sun halo
//  //sun halo
    col += 0.06 / length(     sundir - rd) * 0.1 * vec3(1., 0.5, 0.) ;
//  col += 0.06 / length(     sundir - rd) * 0.1 * vec3(1., 0.5, 0.) ;
    
    //focus/sundir vector
//  //focus/sundir vector
    //focus/sundir vector
//  //focus/sundir vector
    vec3   dir = sundir - focus;
//  vec3   dir = sundir - focus;
    float size = length   (dir);
//  float size = length   (dir);
    
    //define Lens size and step length
//  //define Lens size and step length
    //define Lens size and step length
//  //define Lens size and step length
    float lenses =        3.         ;
//  float lenses =        3.         ;
    float stepL  = size * 3. / lenses;
//  float stepL  = size * 3. / lenses;
    
    //firts Lens
//  //firts Lens
    //firts Lens
//  //firts Lens
    vec3 pos = sundir  + dir * stepL * 0.5;
//  vec3 pos = sundir  + dir * stepL * 0.5;
    vec3 roP = normalize(pos)             ;
//  vec3 roP = normalize(pos)             ;
    
    float halo  = smoothstep(0.5, 0.49, length(rd - roP) / 0.50);
//  float halo  = smoothstep(0.5, 0.49, length(rd - roP) / 0.50);
    halo -= smoothstep(0.5, 0.40, length(rd - roP) / 0.49);
//  halo -= smoothstep(0.5, 0.40, length(rd - roP) / 0.49);
    col += max(halo, 0.) * 0.2 * vec3(0.4, 0.8, 1.);
//  col += max(halo, 0.) * 0.2 * vec3(0.4, 0.8, 1.);
    
    pos += dir * stepL;
//  pos += dir * stepL;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.999, 1., dot(rd, roP)) * vec3(1., 0.6, 0.) * 0.6;
//  col += smoothstep(0.999, 1., dot(rd, roP)) * vec3(1., 0.6, 0.) * 0.6;
    
    pos += dir * stepL * 2.;
//  pos += dir * stepL * 2.;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.5, 0.4, length(rd - roP) / 0.3) * vec3(0.6, 1., 0.4) * 0.2;
//  col += smoothstep(0.5, 0.4, length(rd - roP) / 0.3) * vec3(0.6, 1., 0.4) * 0.2;
    col -= smoothstep(0.9, 0.0, length(rd - roP) / 0.2) * vec3(0.6, 1., 0.4) * 0.1;
//  col -= smoothstep(0.9, 0.0, length(rd - roP) / 0.2) * vec3(0.6, 1., 0.4) * 0.1;
    
    //go to other side of the sun
//  //go to other side of the sun
    //go to other side of the sun
//  //go to other side of the sun
    pos  =  sundir     ;
//  pos  =  sundir     ;
    pos += -dir * stepL;
//  pos += -dir * stepL;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.6, 0.4, length(rd - roP) / 0.07) * vec3(1., 0.6, 0.0) * 0.6;
//  col += smoothstep(0.6, 0.4, length(rd - roP) / 0.07) * vec3(1., 0.6, 0.0) * 0.6;
    
    pos += -dir * stepL * 0.25;
//  pos += -dir * stepL * 0.25;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += 0.020 / length(rd - roP) * vec3(0.2, 0.6, 1.0) * 0.6;
//  col += 0.020 / length(rd - roP) * vec3(0.2, 0.6, 1.0) * 0.6;
    
    pos += -dir * stepL * 0.50;
//  pos += -dir * stepL * 0.50;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += 0.015 / length(rd - roP) * vec3(0.4, 0.8, 1.0) * 0.6;
//  col += 0.015 / length(rd - roP) * vec3(0.4, 0.8, 1.0) * 0.6;
    
    pos += -dir * stepL * 0.25;
//  pos += -dir * stepL * 0.25;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.6, 0.4, length(rd - roP) / 0.1) * vec3(1., 0.6, 0.0) * 0.4;
//  col += smoothstep(0.6, 0.4, length(rd - roP) / 0.1) * vec3(1., 0.6, 0.0) * 0.4;
    
    pos += -dir * stepL * 0.25;
//  pos += -dir * stepL * 0.25;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += 0.007 / length(rd - roP) * vec3(0.4, 1.0, 0.8) * 0.6;
//  col += 0.007 / length(rd - roP) * vec3(0.4, 1.0, 0.8) * 0.6;
    
    pos += -dir * stepL * 0.25;
//  pos += -dir * stepL * 0.25;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.5, 0.4, length(rd - roP) / 0.3) * vec3(0.6, 1.0, 0.4) * 0.2;
//  col += smoothstep(0.5, 0.4, length(rd - roP) / 0.3) * vec3(0.6, 1.0, 0.4) * 0.2;
    col -= smoothstep(0.9, 0.0, length(rd - roP) / 0.2) * vec3(0.6, 1.0, 0.4) * 0.1;
//  col -= smoothstep(0.9, 0.0, length(rd - roP) / 0.2) * vec3(0.6, 1.0, 0.4) * 0.1;
    
    pos += -dir * stepL;
//  pos += -dir * stepL;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += smoothstep(0.6, 0.4, length(rd - roP) / 0.2) * vec3(1.0, 0.6, 0.0) * 0.6;
//  col += smoothstep(0.6, 0.4, length(rd - roP) / 0.2) * vec3(1.0, 0.6, 0.0) * 0.6;
    
    pos += -dir * stepL * 0.50;
//  pos += -dir * stepL * 0.50;

    roP  = normalize(pos);
//  roP  = normalize(pos);
    col += 0.003 / length(rd - roP) * vec3(0.4, 1.0, 0.8) * 0.6;
//  col += 0.003 / length(rd - roP) * vec3(0.4, 1.0, 0.8) * 0.6;
    
    pos += -dir * stepL * 1.50;
//  pos += -dir * stepL * 1.50;
    roP  = normalize(pos);
//  roP  = normalize(pos);
    float haloF  = smoothstep(0.5, 0.49, length(rd - roP) / 0.70);
//  float haloF  = smoothstep(0.5, 0.49, length(rd - roP) / 0.70);
    haloF -= smoothstep(0.5, 0.40, length(rd - roP) / 0.69);
//  haloF -= smoothstep(0.5, 0.40, length(rd - roP) / 0.69);
    col += max(haloF, 0.) * 0.2 * vec3(0.4, 0.8, 1.);
//  col += max(haloF, 0.) * 0.2 * vec3(0.4, 0.8, 1.);
    
    //post processing
//  //post processing
    //post processing
//  //post processing
    col = clamp(col, 0.0, 1.0 );
//  col = clamp(col, 0.0, 1.0 );
    col =   pow(col, vec3(0.8)); //gamma correction
//  col =   pow(col, vec3(0.8)); //gamma correction
    
    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    fragColor = max (fragColor, (1.0 - fragColor) * texture(tex0, vTexCoord));
//  fragColor = max (fragColor, (1.0 - fragColor) * texture(tex0, vTexCoord));
    }


    // https://www.shadertoy.com/view/Ds2BRc
//  // https://www.shadertoy.com/view/Ds2BRc

    //TODO : add chromatic abberation and dirty lens
//  //TODO : add chromatic abberation and dirty lens
    //TODO : add chromatic abberation and dirty lens
//  //TODO : add chromatic abberation and dirty lens
    /*
//  /*
    Feel free to use this code for your own shader.
//  Feel free to use this code for your own shader.
    Feel free to use this code for your own shader.
//  Feel free to use this code for your own shader.
    */
//  */




