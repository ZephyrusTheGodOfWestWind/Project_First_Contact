void CreateSceneSwitch (PVector p, PVector s, Scene from, Scene to)
{
  from.switches.add(new SceneSwitch(p, s, from, to));
}
class Scene
{
  boolean active;
  boolean enabled = true;
  String name = "new scene";
  
  ArrayList<SceneSwitch> switches = new ArrayList<SceneSwitch>();
  ArrayList<Item> items = new ArrayList<Item>();
  ArrayList<Trigger> triggers = new ArrayList<Trigger>();
  
  ArrayList<Item> itemsToRemove = new ArrayList<Item>();
  
  PImage background;
  
  Scene(String n)
  {
    name = n;
  }
  void Draw()
  {
    if (background == null)
    {
      textSize(48);
      text(name, 500, 500);
    }
    else
    {
      //pp.ApplyDistortion(background);
      image(background, 0, 0, width, height);
    }
  }
}
class SceneSwitch
{
  boolean active = true;
  boolean shown = true;
  PVector pos, size;
  Scene fromScene, toScene;
  
  SceneSwitch(PVector p, PVector s, Scene from, Scene to)
  {
    pos = p;
    size = s;
    fromScene = from;
    toScene = to;
  }
  void DrawLayout()
  {
    if (shown)
    {
      if (active)
        fill(0x775588ff);
      else
        fill(0x44aa2200);
      rect(pos.x, pos.y, size.x, size.y);
    }
  }
}

class SceneManager
{
  ArrayList<Scene> scenes;
  Scene currentScene;
  Scene toScene = null;
  color overlay = color(1,0);
  Animation transition = new Animation(1);
  
  void SwitchScenes (Scene to)
  {
    currentScene.active = false;
    to.active = true;
    currentScene = to;
  }
  void Transition(float timer, float time, Scene to)
  {
    sm.overlay = color(1, (1-abs(timer*2-time)/time)*255);
    if (timer < time/2)
      SwitchScenes (to);
  }
  SceneManager(Scene defaultScene)
  {
    scenes = new ArrayList<Scene>();
    scenes.add(defaultScene);
    currentScene = defaultScene;
    defaultScene.active = true;
  }
  void draw()
  {
    println(currentScene.name);
    currentScene.Draw();
    for (SceneSwitch sw: currentScene.switches)
    {
      sw.shown = true;
      sw.DrawLayout();
    }
    for (Item i : currentScene.items)
      i.Draw();
    for (Trigger t : currentScene.triggers)
      t.DrawLayout();
  }
  void drawOverlay()
  {
    fill(overlay);
    rect(0,0,width,height);
  }
  void mouseReleased() {
    if (currentScene.enabled)
    {
      for (SceneSwitch sw: currentScene.switches)
      {
        if (mouseX > sw.pos.x && mouseX < sw.pos.x+sw.size.x && mouseY > sw.pos.y && mouseY < sw.pos.y+sw.size.y && sw.active && sw.shown)
        {
          transition = new Animation(0.25);
          currentScene.enabled = false;
          sw.toScene.enabled = false;
          transition.function = new Function()
          {
            @Override
            void play(float timer)
            {
              Transition(timer, transition.animationTime, sw.toScene);
            }
            @Override
            void finish()
            {
              currentScene.enabled = true;
              sw.toScene.enabled = true;
              overlay = 0x000010101;
            }
          };
          transition.Play();
        }
      }
      currentScene.itemsToRemove.clear();
      for (Item i : currentScene.items)
      {
        i.mouseReleased();
      }
      for (Item i : currentScene.itemsToRemove)
      {
        currentScene.items.remove(i);
      }
      for (Trigger t : currentScene.triggers)
      {
        t.mouseReleased();
      }
    }
  }
}
