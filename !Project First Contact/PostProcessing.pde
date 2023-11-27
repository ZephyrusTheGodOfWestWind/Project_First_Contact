
class PostProcessing
{
  PShader distortion;
  
  String[] vertSrc = { """
  #version 330
  //uniform mat4 projmodelviewMatrix;
  attribute vec4 inVertex;
  attribute vec4 inColor;
  attribute vec2 inTexcoord;
  
  out vec2 uv;
  
  uniform mat4 transformMatrix;
  attribute vec4 position;
  void main() {
    uv = inTexcoord;
    gl_Position = transformMatrix * position;
  }
  """ };
  
  String[] fragSrc = { """
  #version 330
  
  uniform float time;
  uniform sampler2D tex;
  uniform vec2 resolution;
  
  in vec2 uv;
  
  #define TAU 6.2831853
  void main() {
    
    
    vec2 pos = (gl_FragCoord.xy - vec2(10*sin(gl_FragCoord.x/100+time/4.1),10*sin(gl_FragCoord.y/100+time/4.3))) / resolution.xy;
    //pos*=resolution;
    //pos = vec2(int(pos.x) - int(pos.x)%5, int(pos.y) - int(pos.y)%5);
    //pos/=resolution;
    gl_FragColor = texture2D(tex, vec2(pos.x, 1-pos.y));
  }
  """ };
  
  void SetupShaders()
  { 
    distortion = new PShader( g.parent, vertSrc, fragSrc );
  }
  
  void ApplyDistortion(PImage im)
  {
    distortion.set("tex", im);
    distortion.set("resolution", width, height);
    distortion.set("time", time);
    shader(distortion);
    rect(0,0,width, height);
    resetShader();
  }
  void ApplyDistortion()
  {
    PImage im = new PImage(width, height);
    loadPixels();
    im.loadPixels();
    for (int i=0; i<width*height; i++)
    {
      im.pixels[i] = pixels[i];
    }
    im.updatePixels();
    ApplyDistortion(im);
  }
}
