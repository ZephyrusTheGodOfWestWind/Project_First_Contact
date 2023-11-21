void ParticleSystemSetup ()
{
  ps.enabled = false;
  ps.pos = new PVector (500, 500);
  ps.initialColor = 0x00ff0000;
  ps.endColor = #00ff00;
  ps.radius = 500;
  ps.spawnTimer = 0;
}
void SceneManagerSetup()
{
  
  sm.scenes.add(new Scene("aokfjgeihu"));
  sm.scenes.add(new Scene("boop"));
  
  CreateSceneSwitch(new PVector(1000,500), new PVector(100,100), sm.scenes.get(0), sm.scenes.get(1));
  CreateSceneSwitch(new PVector(100, 500), new PVector(100,100), sm.scenes.get(1), sm.scenes.get(0));
  
  CreateSceneSwitch(new PVector(1000,500), new PVector(100,100), sm.scenes.get(1), sm.scenes.get(2));
  CreateSceneSwitch(new PVector(100, 500), new PVector(100,100), sm.scenes.get(2), sm.scenes.get(1));
  
  CreateSceneSwitch(new PVector(1000,500), new PVector(100,100), sm.scenes.get(2), sm.scenes.get(0));
  CreateSceneSwitch(new PVector(100, 500), new PVector(100,100), sm.scenes.get(0), sm.scenes.get(2));
}

ParticleSystem ps;
SceneManager sm;
float deltaTime;
float time;

void setup(){
  size(1280, 720);
  frameRate (60);
  imageMode(0);
  noStroke();
  //noCursor();
  time =0;
  
  ps = new ParticleSystem();
  sm = new SceneManager(new Scene("default"));
  ParticleSystemSetup();
  SceneManagerSetup();
}
void draw()
{
  
  deltaTime = 1/frameRate;
  time+=deltaTime;
  
  background(0);
  ps.draw();
  sm.draw();
}
void mouseReleased()
{
  sm.mouseReleased();
}
