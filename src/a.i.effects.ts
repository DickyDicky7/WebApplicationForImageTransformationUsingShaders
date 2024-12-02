import {createOpenRouter} from "@openrouter/ai-sdk-provider";
import type {OpenRouterProvider} from "@openrouter/ai-sdk-provider";
import { streamText} from             "ai"             ;
import type {LanguageModel} from "ai";
const openRouter: OpenRouterProvider = createOpenRouter({ apiKey: import.meta.env.VITE_KEY001 });

const newPrompt: string = `
create a .glsl fragment shader that has Pixelated effect, return only the .glsl code, knowing the .glsl format is: 

#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

uniform sampler2D   noise0;
uniform sampler2D   noise1;
uniform sampler2D   noise2;
uniform sampler2D   bayer0;
uniform sampler2D   bayer1;
uniform sampler2D   bayer2;
uniform sampler2D pallete0;
uniform sampler2D pallete1;
uniform sampler2D pallete2;
uniform vec2        noise0Size;
uniform vec2        noise1Size;
uniform vec2        noise2Size;
uniform vec2        bayer0Size;
uniform vec2        bayer1Size;
uniform vec2        bayer2Size;
uniform vec2      pallete0Size;
uniform vec2      pallete1Size;
uniform vec2      pallete2Size;

void main() {
  //...
}
`;

const f = async () => {
    const result = await streamText({
        model: openRouter("meta-llama/llama-3.1-70b-instruct:free") as LanguageModel,
        prompt: `
create a glsl shader that has Pixelated Like Pixel Games With Pixel Size = 4 effect, return only the .glsl code, knowing that p5.js only supports GLSL ES 1.0 and WebGL1; and the glsl format is: 

#version 100
precision highp float;
    
uniform sampler2D tex0;
varying vec2 vTexCoord;
uniform float time;
uniform vec2 canvasSize;
uniform vec2 texelSize;
uniform sampler2D noiseTexture01;
uniform sampler2D noiseTexture02;
uniform sampler2D noiseTexture03;

//If any "uniform sampler2D noiseTexture<Number>" above is neccessary for this shader, comment at the end of this shader (after the closing bracket of the main function) which type of noise it is following this format "<uniform name>:<type of noise>" (There are these types of noise: Perlin, Cracks, Gabor, Craters, Grainy, Manifold, Marble, Melt, Milky, Spokes, Streak, Super Noise, Super Perlin, Swirl, Techno, Turbulence, Vein, Voronoi). If it is not neccessary, comment this line "<uniform name>:no noise is needed"

//For any other neccessary variables if exists, they should have a good default value, dont use "varying" or "uniform" keywords

void main(){
//For any other neccessary variables if exists, they should have a good default value, dont use "varying" or "uniform" keywords
//...
}
//"noiseTexture01:<type of noise>" or "noiseTexture01:no noise is needed"
//"noiseTexture02:<type of noise>" or "noiseTexture02:no noise is needed"
//"noiseTexture03:<type of noise>" or "noiseTexture03:no noise is needed"

        `
    });
    return result.toTextStreamResponse();
};

export { f };
// array, noise texture, const, uniform
// p5.js only supports GLSL ES 1.0 and WebGL1
// themes/effects in keywords

const a = `
#version 100
precision highp float;

uniform sampler2D tex0;
varying vec2 vTexCoord;
uniform float time;
uniform vec2 canvasSize;
uniform vec2 texelSize;
uniform sampler2D noiseTexture01;

float rand(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 fp = fract(p);
    fp = fp * fp * (3.0 - 2.0 * fp);
    float res = mix(mix(rand(ip),rand(ip+vec2(1.0,0.0)),fp.x),mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),fp.x),fp.y);
    return res;
}

float heartShape(vec2 st) {
    st -= 0.5;
    float x = st.x;
    float y = st.y;
    float r = sqrt(x * x + y * y);
    float a = atan(y, x);
    float h = r * (1.0 - sin(a * 3.0));
    return step(h, 0.3 + 0.1 * sin(time * 5.0));
}

void main() {
    vec2 uv = vTexCoord;
    vec2 pos = uv * canvasSize;
    vec2 center = canvasSize / 2.0;
    pos -= center;
    float d = length(pos);
    float t = time * 0.1;
    pos += center;
    pos += noise(pos * 0.01 + t) * 10.0;
    uv = pos / canvasSize;
    float heart = heartShape(uv);
    vec4 col = texture2D(tex0, uv);
    col.rgb *= heart;
    gl_FragColor = col;
}

// noiseTexture01: Grainy
`;

const b = `
#version 100
precision highp float;

uniform sampler2D tex0;
varying vec2 vTexCoord;
uniform float time;
uniform vec2 canvasSize;
uniform vec2 texelSize;
uniform sampler2D noiseTexture01;
uniform sampler2D noiseTexture02;
uniform sampler2D noiseTexture03;

float rand(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 fp = fract(p);
    fp = fp * fp * (3.0 - 2.0 * fp);
    float res = mix(mix(rand(ip),rand(ip+vec2(1.0,0.0)),fp.x),mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),fp.x),fp.y);
    return res;
}

void main(){
    vec2 uv = vTexCoord;
    vec2 snowPos = vec2(uv.x + time * 0.1, uv.y + time * 0.1);
    float snowNoise = noise(snowPos * 10.0);
    float snow = step(snowNoise, 0.5);
    snow *= step(0.4, snowNoise);
    vec4 snowColor = vec4(1.0, 1.0, 1.0, 1.0);
    vec4 texColor = texture2D(tex0, uv);
    gl_FragColor = mix(texColor, snowColor, snow * 0.5);
}
"noiseTexture01:no noise is needed"
"noiseTexture02:no noise is needed"
"noiseTexture03:no noise is needed"
`;

const g = async () => {
    const result = await streamText({
        model: openRouter("meta-llama/llama-3.1-70b-instruct:free") as LanguageModel,
        prompt: `
create a p5.js code that has Heart Particles effect, return only the js code and the content of the draw() function, knowing that everything related to p5.js must be called from "canvasInstance" variable like this "canvasInstance.background(0)" and special functions like "draw" or "setup" must look like this "canvasInstance.draw = () => { /*...*/ };"

        `
    });
    return result.toTextStreamResponse();
};

export { g };

const c = `
// HeartParticle.js
class HeartParticle {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.vx = random(-2, 2);
    this.vy = random(-5, -1);
    this.size = random(10, 20);
    this.alpha = 255;
  }

  update() {
    this.x += this.vx;
    this.y += this.vy;
    this.alpha -= 2;
  }

  display() {
    noStroke();
    fill(255, this.alpha);
    push();
    translate(this.x, this.y);
    beginShape();
    vertex(0, -this.size / 2);
    bezierVertex(-this.size / 2, -this.size / 2, -this.size, 0, 0, this.size / 2);
    bezierVertex(this.size, 0, this.size / 2, -this.size / 2, 0, -this.size / 2);
    endShape(CLOSE);
    pop();
  }

  isDead() {
    return this.alpha < 0;
  }
}

let particles = [];

function draw() {
  background(0);
  for (let i = particles.length - 1; i >= 0; i--) {
    particles[i].update();
    particles[i].display();
    if (particles[i].isDead()) {
      particles.splice(i, 1);
    }
  }
  if (random(1) < 0.1) {
    particles.push(new HeartParticle(width / 2, height / 2));
  }
}
`;