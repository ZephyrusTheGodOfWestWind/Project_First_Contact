
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
  PVector pos, size;
  float spawnPeriod;
  float spawnTimer;
  float lifespan = 2;
  int maxParticles = 100;
  ArrayList<Particle> p;
  Mode mode = Mode.RAD;
  
  float initialSpeed = 20;
  float endSpeed = 500  ;
  
  float radius = 200;
  
  float initialSize;
  float endSize;
  
  color initialColor;
  color endColor;
  
  ParticleSystem()
  {
    p = new ArrayList<Particle>();
  }
  
  PVector RandomPos ()
  {
    if (mode == Mode.RAD)
      return PVector.random2D().mult(random(0,radius));
    if (mode == Mode.RECT)
      return new PVector(random(-size.x/2, size.x/2), random(-size.y/2, size.y/2));
    return new PVector (0,0);
  }
  void draw(){
    
    spawnPeriod = lifespan/maxParticles;
    spawnTimer+=deltaTime;
    if (spawnTimer>spawnPeriod && enabled)
    {
      int count = int(spawnTimer/spawnPeriod);
      for (int i=0; i<count; i++)
        p.add(new Particle(initialColor, pos.copy().add(RandomPos()), PVector.random2D().mult(initialSpeed), lifespan));
      spawnTimer = spawnTimer%spawnPeriod;
    }
    
    IntList toDestroy = new IntList();
    for (int i=p.size()-1; i>=0; i--)
    {
      Particle par = p.get(i);
      
      if (par.lifetime<0) toDestroy.append(i);
      par.lifetime -= deltaTime;
      par.col = lerpColor(endColor, initialColor, par.lifetime/lifespan);
      
      
      par.speed = par.speed.normalize().mult(lerp(endSpeed, initialSpeed, par.lifetime/lifespan));
      par.pos = par.pos.add(par.speed.mult(deltaTime));
      par.Draw();
    }
    for (int i: toDestroy)
      p.remove(i);
  }
}
