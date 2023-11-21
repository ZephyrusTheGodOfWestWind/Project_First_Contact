
void CollectItem (Item item, Inventory inv) 
{
  inv.items.add(item);
  item.inventory = inv;
  item.collected = true;
  item.scene = null;
  int slot;
  for (slot=0; slot<inv.slots.size(); slot++)
  {
    if (!inv.busy[slot])
      break;
  }
  item.pos = inv.slots.get(slot).globalPos;
  item.size = inv.slots.get(slot).size;
}

class Inventory
{
  boolean[] busy;
  ArrayList<UIComponent> slots;
  ArrayList<Item> items;
  Inventory ()
  {
    slots = new ArrayList<UIComponent>();
    items = new ArrayList<Item>();
    busy = new boolean[1000];
    for (int i=0; i<1000; i++)
    {
      busy[i] = false;
    }
  }
  Inventory (ArrayList<UIComponent> s)
  {
    slots = new ArrayList<UIComponent>();
    items = new ArrayList<Item>();
    slots = s;
    busy = new boolean[1000];
    for (int i=0; i<1000; i++)
    {
      busy[i] = false;
    }
  }
  
  
  
  void draw()
  {
    for (Item i : items)
    {
      i.Draw();
    }
  }
}
class Item {
  boolean shown = true, active = true, collected;
  PImage sprite;
  PVector pos, size;
  Scene scene;
  Inventory inventory;
  
  void Draw ()
  {
    if (shown)
    {
      println(1);
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
  
  Item (PImage spr, PVector p)
  {
    sprite = spr.copy();
    size = new PVector (sprite.width, sprite.height);
    pos = p;
    
  }
  Item (PImage spr, PVector p, PVector s)
  {
    sprite = spr.copy();
    size = s;
    pos = p;
    
  }
  Item (PImage spr, PVector p, Scene sc)
  {
    sprite = spr.copy();
    pos = p;
    size = new PVector (sprite.width, sprite.height);
    scene = sc;
  }
  Item (PImage spr, PVector p, PVector s, Scene sc)
  {
    sprite = spr.copy();
    size = s;
    pos = p;
    scene = sc;
  }
  
  void mouseReleased()
  {
    if (mouseX > pos.x && mouseX < pos.x+size.x && mouseY > pos.y && mouseY < pos.y+size.y && active && shown)
    {
      if (scene != null)
      {
        if (scene.active)
        {
          CollectItem(this, inventory);
        }
      }
    }
  }
}
