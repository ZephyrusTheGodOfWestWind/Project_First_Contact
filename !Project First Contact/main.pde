import processing.sound.*;
SoundFile sf;


void AudioSetup()
{
  sf = new SoundFile(this, "data/audio.mp3");
  sf.amp(settings.musicVolumeSlider.value/100 * settings.masterVolumeSlider.value/100);
  sf.loop();
}

void ParticleSystemSetup ()
{
  ps.enabled = true;
  ps.mode = Mode.RECT;
  ps.maxParticles = 500;
  ps.lifespan = 10;
  ps.pos = new PVector (width/2, height/2);
  ps.size = new PVector (width-100, height-100);
  //ps.radius = 100;
  ps.spawnTimer = 0;
  
  ps.initialSpeed = 20;
  ps.endSpeed = 10;
  
  ps.initialColor = 0x440044ff;
  ps.endColor = #00ffaa;
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

void ItemsSetup()
{
  new Item("amogus", loadImage("data/amogus.png"), new PVector(800,300), new PVector(100,100), sm.scenes.get(2));
  new Item("mogus", loadImage("data/mogus.png"), new PVector(200,300), new PVector(100,100), sm.scenes.get(1));
}

void AnimationSetup ()
{
}

AnimationPlayer ap;
SceneManager sm;
ParticleSystem ps;
Inventory inv;
Trigger t;
Settings settings;

UIPanel inventory;
float deltaTime;
float time;
boolean loaded = false;

void load()
{
  
  settings = new Settings();
  settings.setup();
  
  ps = new ParticleSystem();
  sm = new SceneManager(new Scene("default"));
  ap = new AnimationPlayer();
  inv = new Inventory();
  
  ParticleSystemSetup();
  SceneManagerSetup();
  InventorySetup();
  ItemsSetup();
  AudioSetup();
  
  t = new Trigger(new PVector (200, 200), new PVector (100, 100), sm.scenes.get(0), Type.ITEM);
  t.itemName = "amogus";
  
  loaded = true;
}
void setup(){
  size(1280, 720, P2D);
  frameRate (60);
  imageMode(0);
  noStroke();
  //noCursor();
  time =0;
  inventory = new UIPanel (new PVector (90, 620),new PVector (1100, 100));
  
  thread("load");
}
void draw()
{
  deltaTime = 1/frameRate;
  time+=deltaTime;
  background(0);
  textSize(40);
  
  if (loaded)
  {
    ps.draw();
    sm.draw();
    t.DrawLayout();
    inventory.Draw();
    ap.draw();
    inv.draw();
    settings.draw();
  }
  else
  {
    textAlign(CENTER, CENTER);
    text("laoding...", width/2, height/2);
    textAlign(CORNER);
  }
  textSize(20);
  fill(#00ff77);
  text(frameRate, 0, 20);
}
void mouseReleased()
{
  sm.mouseReleased();
  inv.mouseReleased();
  t.mouseReleased();
}

void keyReleased()
{
  inv.keyReleased();
  settings.keyReleased();
}
