void ParticleSystemSetup ()
{
  ps.enabled = true;
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

void InventorySetup ()
{
  for (int i=0; i<11; i++)
  {
    inv.slots.add( new UIPanel( new PVector(10+100*i, 10), new PVector(80, 80), inventory));
  }
}
ParticleSystem ps;
SceneManager sm;
Inventory inv;

PImage amogus;
Item test;

UIPanel inventory;
float deltaTime;
float time;

void setup(){
  size(1280, 720);
  frameRate (60);
  imageMode(0);
  noStroke();
  amogus = loadImage("data/amogus.png");
  //noCursor();
  time =0;
  
  ps = new ParticleSystem();
  sm = new SceneManager(new Scene("default"));
  inv = new Inventory();
  ParticleSystemSetup();
  SceneManagerSetup();
  inventory = new UIPanel (new PVector (50, 600),new PVector (1100, 100));
  InventorySetup();
  
  test = new Item(amogus, new PVector(800,300), new PVector(100,100), sm.scenes.get(2));
  test.inventory = inv;
}
void draw()
{
  
  deltaTime = 1/frameRate;
  time+=deltaTime;
  
  background(0);
  ps.draw();
  sm.draw();
  inventory.Draw();
  test.Draw();
}
void mouseReleased()
{
  sm.mouseReleased();
  test.mouseReleased();
}
