void CreateSceneSwitch (PVector p, PVector s, Scene from, Scene to)
{
  from.switches.add(new SceneSwitch(p, s, from, to));
}
class Scene
{
  boolean active;
  String name = "new scene";
  ArrayList<SceneSwitch> switches;
  ArrayList<Item> items;
  
  Scene(String n)
  {
    name = n;
    switches = new ArrayList<SceneSwitch>();
    items = new ArrayList<Item>();
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
        fill(#5588ff);
      else
        fill(#ff2200);
      rect(pos.x, pos.y, size.x, size.y);
    }
  }
}
class SceneManager
{
  ArrayList<Scene> scenes;
  Scene currentScene;
  
  void switchScenes (Scene from, Scene to)
  {
    from.active = false;
    to.active = true;
    currentScene = to;
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
    textSize(48);
    text(currentScene.name, 500, 500);
    for (SceneSwitch sw: currentScene.switches)
    {
      sw.shown = true;
      sw.DrawLayout();
    }
    for (Item i : currentScene.items)
     i.Draw();
  }
  void mouseReleased() {
    for (SceneSwitch sw: currentScene.switches)
    {
      if (mouseX > sw.pos.x && mouseX < sw.pos.x+sw.size.x && mouseY > sw.pos.y && mouseY < sw.pos.y+sw.size.y && sw.active && sw.shown)
      {
        switchScenes (sw.fromScene, sw.toScene);
      }
    }
  }
}
