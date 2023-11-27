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
  ps.maxParticles = 100;
  ps.lifespan = 10;
  ps.pos = new PVector (width/2, height/2);
  ps.size = new PVector (width-100, height-100);
  //ps.radius = 100;
  ps.spawnTimer = 0;
  
  ps.initialSpeed = 20;
  ps.endSpeed = 10;
  
  ps.initialColor = 0x44ffff66;
  ps.endColor = 0xaaffffff;
}
void SceneManagerSetup()
{
  sm.scenes.add(new Scene("hallway"));
  sm.scenes.add(new Scene("red_room"));
  sm.scenes.add(new Scene("green_room"));
  sm.scenes.add(new Scene("yellow_room"));
  sm.scenes.add(new Scene("blue_room"));
  sm.scenes.add(new Scene("hall"));
  
  sm.scenes.get(1).background = loadImage("data/hallway.png");
  sm.scenes.get(6).background = loadImage("data/hall.png");
  sm.scenes.get(2).background = loadImage("data/red_room.png");
  
  CreateSceneSwitch(new PVector(1000,150), new PVector(200,500), sm.scenes.get(1), sm.scenes.get(2));
  CreateSceneSwitch(new PVector(70, 150), new PVector(200,500), sm.scenes.get(1), sm.scenes.get(3));
  CreateSceneSwitch(new PVector(380, 300), new PVector(100,230), sm.scenes.get(1), sm.scenes.get(4));
  CreateSceneSwitch(new PVector(800, 300), new PVector(100,230), sm.scenes.get(1), sm.scenes.get(5));
  CreateSceneSwitch(new PVector(515, 290), new PVector(250,190), sm.scenes.get(1), sm.scenes.get(6));
  
  CreateSceneSwitch(new PVector(100, 500), new PVector(100,100), sm.scenes.get(2), sm.scenes.get(1));
  
  CreateSceneSwitch(new PVector(1000,500), new PVector(100,100), sm.scenes.get(3), sm.scenes.get(1));
  
  CreateSceneSwitch(new PVector(1000, 500), new PVector(100,100), sm.scenes.get(4), sm.scenes.get(1));
  
  CreateSceneSwitch(new PVector(100, 500), new PVector(100,100), sm.scenes.get(5), sm.scenes.get(1));
  
  CreateSceneSwitch(new PVector(700, 500), new PVector(100,100), sm.scenes.get(6), sm.scenes.get(1));
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
  Item i;
  i = new Item("amogus", loadImage("data/amogus.png"), new PVector(800,300), new PVector(100,100), sm.scenes.get(2));
  i = new Item("mogus", loadImage("data/mogus.png"), new PVector(200,300), new PVector(100,100), sm.scenes.get(1));
}

void TriggersSetup()
{
  Trigger t;
  t = new Trigger(new PVector (550, 250), new PVector (200, 200), sm.scenes.get(2), Type.CLICK);
  t.trig = () -> puzzle2.Activate();
  puzzle2.trigger = t;
}
void AnimationSetup ()
{
}

Puzzle1 puzzle1;
Puzzle2 puzzle2;

PostProcessing pp;
MainMenu mm;
AnimationPlayer ap;
SceneManager sm;
ParticleSystem ps;
Inventory inv;
Settings settings;
Cursor curs;

UIPanel inventory;
float deltaTime;
float time;

PFont FarOut;

enum GameStatus {
  MENU,
  GAME,
  LOADING,
  PUZZLE1,
  PUZZLE2
}

GameStatus gameStatus = GameStatus.MENU;

void load()
{
  gameStatus = GameStatus.LOADING;
  
  delay(100);
  puzzle2= new Puzzle2();
  puzzle2.setup();
  
  pp = new PostProcessing();
  ps = new ParticleSystem();
  ap = new AnimationPlayer();
  inv = new Inventory();
  inventory = new UIPanel (new PVector (90, 620),new PVector (1100, 100));
  
  pp.SetupShaders();
  ParticleSystemSetup();
  InventorySetup();
  ItemsSetup();
  TriggersSetup();
  //AudioSetup();
  
  sm.SwitchScenes(sm.scenes.get(1));
  
  gameStatus = GameStatus.GAME;
}
void setup(){
  size(1280, 720, P2D);
  frameRate (165);
  imageMode(0);
  noStroke();
  
  //noCursor();
  curs = new Cursor();
  curs.setup();
  
  FarOut = createFont("data/FarOut.otf", 128);
  textFont(FarOut);
  time =0;
  
  settings = new Settings();
  settings.setup();
  sm = new SceneManager(new Scene("main menu"));
  mm = new MainMenu();
  mm.setup();
  SceneManagerSetup();
  
  //thread("load");
}
void draw()
{
  
  deltaTime = 1/frameRate;
  time+=deltaTime;
  background(0);
  textSize(40);
  
  if (gameStatus == GameStatus.MENU)
  {
    sm.draw();
    mm.draw();
    settings.draw();
  }
  if (gameStatus == GameStatus.GAME)
  {
    sm.draw();
    ps.draw();
    pp.ApplyDistortion(get());
    inventory.Draw();
    ap.draw();
    inv.draw();
    sm.drawOverlay();
    settings.draw();
  }
  if (gameStatus == GameStatus.PUZZLE2)
  {
    sm.draw();
    ps.draw();
    ap.draw();
    puzzle2.draw();
    
    pp.ApplyDistortion(get());
  }
  if (gameStatus == GameStatus.LOADING)
  {
    textAlign(CENTER, CENTER);
    text("laoding...", width/2, height/2);
    textAlign(CORNER);
  }
  textSize(20);
  fill(#00ff77);
  text(frameRate, 0, 20);
  text(mouseX, 0, 40);
  text(mouseY, 0, 60);
  
  curs.draw();
}
void mouseReleased()
{
  if (gameStatus == GameStatus.PUZZLE2)
  {
    puzzle2.mouseReleased();
  }
  if (gameStatus == GameStatus.GAME)
  {
    sm.mouseReleased();
    inv.mouseReleased();
  }
}

void keyReleased()
{
  if (gameStatus == GameStatus.PUZZLE2)
  {
    if (key == 'e')
    {
      puzzle2.Deactivate();
    }
  }
  if (gameStatus == GameStatus.MENU)
  {
    settings.keyReleased();
  }
  if (gameStatus == GameStatus.GAME)
  {
    inv.keyReleased();
    if (keyCode == TAB)
      settings.keyReleased();
  }
}
