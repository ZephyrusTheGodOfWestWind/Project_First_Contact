class Item {
  boolean shown = true;
  boolean active = true;
  boolean collected = false;
  boolean grabbed = false;
  
  PImage sprite;
  String name;
  PVector pos, size;
  Scene scene;
  Inventory inventory;
  
  void Draw ()
  {
    if (shown)
    {
      if (scene != null)
      {
        if (scene.active)
        {
          image(sprite, pos.x, pos.y, size.x, size.y);
        }
      }
      else
        image(sprite, pos.x, pos.y, size.x, size.y);
    }
  }
  
  Item (String n, PImage spr, PVector p)
  {
    name = n;
    sprite = spr.copy();
    size = new PVector (sprite.width, sprite.height);
    pos = p;
    
  }
  Item (String n, PImage spr, PVector p, PVector s)
  {
    name = n;
    sprite = spr.copy();
    size = s;
    pos = p;
  }
  Item (String n, PImage spr, PVector p, Scene sc)
  {
    name = n;
    sprite = spr.copy();
    pos = p;
    size = new PVector (sprite.width, sprite.height);
    scene = sc;
    sc.items.add(this);
  }
  Item (String n, PImage spr, PVector p, PVector s, Scene sc)
  {
    name = n;
    sprite = spr.copy();
    size = s;
    pos = p;
    scene = sc;
    sc.items.add(this);
  }
  
  void mouseReleased()
  {
    if (mouseX > pos.x && mouseX < pos.x+size.x && mouseY > pos.y && mouseY < pos.y+size.y && active && shown)
    {
      if (!collected)
      {
        if (scene != null)
        {
          if (scene.active)
          {
            CollectItem(this, inv);
          }
        }
      }
    }
  }
}
