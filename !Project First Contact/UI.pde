class UIComponent
{
  PVector globalPos, localPos;
  PVector size;
  boolean active = true;
  Scene scene = null;
  UIComponent parent = null;
  ArrayList<UIComponent> children;
  
  void AddChild(UIComponent child)
  {
    child.parent = this;
    children.add(this);
    child.localPos = child.globalPos.sub(globalPos);
  }
  void Draw() 
  {
    for (UIComponent c: children)
      c.Draw();
  }
}


class UIPanel extends UIComponent
{
  UIPanel(PVector p, PVector s)
  {
    children = new ArrayList<UIComponent>();
    globalPos = p.copy();
    localPos = p.copy();
    size = s;
  }
  
  UIPanel(PVector p, PVector s, UIPanel par)
  {
    children = new ArrayList<UIComponent>();
    parent = par;
    par.children.add(this);
    localPos = p.copy();
    globalPos = localPos.add(par.globalPos);
    size = s;
  }
  
  UIPanel(PVector p, PVector s, Scene sc)
  {
    children = new ArrayList<UIComponent>();
    scene = sc;
    active = sc.active;
    globalPos = p.copy();
    localPos = p.copy();
    size = s;
  }
  
  UIPanel(PVector p, PVector s, UIPanel par, Scene sc)
  {
    children = new ArrayList<UIComponent>();
    scene = sc;
    active = sc.active;
    parent = par;
    localPos = p.copy();
    globalPos = localPos.add(par.globalPos);
    size = s;
  }
  @Override
  void Draw()
  {
    if (scene != null)
      active = scene.active;
    if (active)
    {
      fill(0x55ffffff);
      rect(globalPos.x, globalPos.y, size.x, size.y);
    }
    for (UIComponent c: children)
      c.Draw();
  }
}
