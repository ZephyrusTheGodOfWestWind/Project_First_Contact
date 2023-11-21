
public enum Mode {RAD, RECT}
class Particle
{
  //PImage sprite;
  color col;
  float lifetime;
  PVector pos;
  PVector speed;
  
  Particle(color c, PVector Pos, PVector Speed, float time)
  {
    col = c;
    lifetime = time;
    pos = Pos;
    speed = Speed;
  }
  void Draw()
  {
    fill(col);
    square(pos.x, pos.y, 3);
  }
}

class ParticleSystem
{
  boolean enabled = true;
  PImage sprite;
  PVector pos;
  float spawnPeriod;
  float spawnTimer;
  float lifespan = 2;
  int maxParticles = 100;
  ArrayList<Particle> p;
  Mode mode = Mode.RAD;
  
  float initialSpeed = 20;
  float endSpeed = 50;
  
  float radius = 200;
  
  float initialSize;
  float endSize;
  
  color initialColor;
  color endColor;
  
  ParticleSystem()
  {
    p = new ArrayList<Particle>();
  }
  
  void draw(){
    
    ps.spawnPeriod = ps.lifespan/ps.maxParticles;
    ps.spawnTimer+=deltaTime;
    if (ps.spawnTimer>ps.spawnPeriod && enabled)
    {
      ps.p.add(new Particle(ps.initialColor, PVector.random2D().mult(random(0,ps.radius)).add(ps.pos), PVector.random2D().mult(ps.initialSpeed), ps.lifespan));
    }
    
    int toDestroy = -1;
    for (int i=0; i<ps.p.size(); i++)
    {
      Particle p = ps.p.get(i);
      
      if (p.lifetime<0) toDestroy = i;
      p.lifetime -= deltaTime;
      p.col = lerpColor(ps.initialColor, ps.endColor, p.lifetime/ps.lifespan);
      
      p.speed = p.speed.normalize().mult(lerp(ps.initialSpeed, ps.initialSpeed, p.lifetime/ps.lifespan));
      p.pos = p.pos.add(p.speed.mult(deltaTime));
      p.Draw();
    }
    if (toDestroy > -1)
      ps.p.remove(toDestroy);
    
  }
}
