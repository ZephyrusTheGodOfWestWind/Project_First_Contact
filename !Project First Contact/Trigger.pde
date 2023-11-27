enum Type {ITEM, CLICK}

interface Trig 
{
  void OnTrigger ();
}
class Trigger
{
  Trig trig;
  Scene scene;
  PVector pos, size;
  Type type;
  String itemName;
  boolean enabled = true;
  boolean activated = false;
  
  Trigger(PVector p, PVector s, Scene sc, Type t)
  {
    pos = p;
    size = s;
    scene = sc;
    sc.triggers.add(this);
    type = t;
  }
  
  void DrawLayout ()
  {
    if (scene.active)
    {
      if (enabled)
      {
        if (activated)
          fill(0x8800ff00);
        else
          fill(0x88ffff00);
      }
      else
        fill(0xffff0000);
      rect(pos.x, pos.y, size.x, size.y);
    }
  }
  void Activate ()
  {
    activated = true;
    trig.OnTrigger();
  }
  
  void mouseReleased()
  {
    if (mouseX > pos.x && mouseX < pos.x+size.x && mouseY > pos.y && mouseY < pos.y+size.y && !activated && enabled && scene.active)
    {
      println("try");
      if (type == Type.CLICK && inv.grabbedItem == null)
        Activate();
      if (type == Type.ITEM && inv.grabbedItem != null)
      {
        if (inv.grabbedItem.name == itemName)
          Activate();
      }
    }
  }
}
