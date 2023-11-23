
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
  final int s = slot;
  inv.busy[s] = true;
  
  item.collectAnimation = new Animation(2);
  item.collectAnimation.function = new Function ()
  {
    @Override
    void play(float timer)
      {item.CollectAnimation(item.collectAnimation.timer, item.collectAnimation.animationTime, s);}
    @Override
    void finish()
    {
      item.pos = inv.slots.get(s).globalPos;
      item.size = inv.slots.get(s).size;
    }
  };
  item.collectAnimation.Play();
}

class Inventory
{
  boolean[] busy;
  ArrayList<UIComponent> slots;
  ArrayList<Item> items;
  Item grabbedItem = null;
  int grabbedIndex = -1;
  
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
    if (grabbedItem !=null)
      grabbedItem.pos = new PVector(mouseX - grabbedItem.size.x/2, mouseY -grabbedItem.size.y/2);
    for (Item i : items)
    {
      i.Draw();
    }
    for (UIComponent s : slots)
    {
      if (mouseX > s.globalPos.x && mouseX < s.globalPos.x+s.size.x && mouseY > s.globalPos.y && mouseY < s.globalPos.y+s.size.y)
      {
        fill(0x44ffffff);
        rect(s.globalPos.x, s.globalPos.y, s.size.x, s.size.y);
      }
    }
  }
  
  void mouseReleased()
  {
    for (int i=0; i<items.size(); i++)
    {
      Item it = items.get(i);
      println(it.collectAnimation.inProgress);
      if(mouseX > it.pos.x && mouseX < it.pos.x+it.size.x && mouseY > it.pos.y && mouseY < it.pos.y+it.size.y && !it.collectAnimation.inProgress)
      {
        if (grabbedItem != null && grabbedItem != it)
        {
          grabbedItem.pos = slots.get(grabbedIndex).globalPos;
          grabbedItem = null;
          grabbedIndex = -1;
        }
        grabbedItem = it;
        grabbedIndex = i;
        it.grabbed = true;
      }
    }
  }
  
  void keyReleased()
  {
    if (keyCode == ' ' && grabbedItem!=null)
    {
      grabbedItem.pos = slots.get(grabbedIndex).globalPos;
      grabbedItem = null;
      grabbedIndex = -1;
    }
  }
}
