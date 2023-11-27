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
    children.add(child);
    child.localPos = child.globalPos.copy().sub(globalPos);
  }
  void Draw() 
  {
    for (UIComponent c: children)
      c.Draw();
  }
}


class UIPanel extends UIComponent
{
  color col = 0x55ffffff;
  UIPanel(PVector p, PVector s)
  {
    children = new ArrayList<UIComponent>();
    globalPos = p.copy();
    localPos = p.copy();
    size = s;
  }
  
  UIPanel(PVector p, PVector s, UIComponent par)
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
  
  UIPanel(PVector p, PVector s, UIComponent par, Scene sc)
  {
    children = new ArrayList<UIComponent>();
    scene = sc;
    active = sc.active;
    parent = par;
    par.children.add(this);
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
      fill(col);
      rect(globalPos.x, globalPos.y, size.x, size.y);
    }
    for (UIComponent c: children)
      c.Draw();
  }
  
  
}

enum Status {CLICKED, HOVER, REST}

interface Butt
{
  void OnButtonClick ();
}
class UIButton extends UIPanel
{
  Butt butt = null;
  Status status;
  boolean enabled = true;
  color colRest = 0x55ffffff;
  color colHover = 0x5599ff99;
  
  UIButton(PVector p, PVector s) {super(p, s);}
  UIButton(PVector p, PVector s, UIComponent par) {super(p, s, par);}
  UIButton(PVector p, PVector s, Scene sc) {super(p, s, sc);}
  UIButton(PVector p, PVector s, UIComponent par, Scene sc) {super(p, s, par, sc);}
  
  void checkStatus()
  {
    if (globalPos.x<mouseX && mouseX<globalPos.x+size.x && globalPos.y<mouseY && mouseY<globalPos.y+size.y)
    {
       if((mousePressed && status == Status.HOVER) || status == Status.CLICKED) status = Status.CLICKED;
       if (!mousePressed) status = Status.HOVER;
       else if (status!=Status.CLICKED) status = Status.REST;
    }
    else if (status == Status.CLICKED && mousePressed) status = Status.CLICKED;
    else status = Status.REST;
  }
  @Override
  void Draw()
  {
    checkStatus();
    if (enabled)
    {
      if (status == Status.REST) col = colRest;
      if (status == Status.HOVER) col = colHover;
      if (status == Status.CLICKED) butt.OnButtonClick();
    }
    else
        col = colRest;
      super.Draw();
  }
}

class UISlider extends UIComponent
  {
    UIPanel bar;
    UIPanel slider;
    Status status;
    
    float minValue = 0;
    float maxValue = 100;
    float value = 0;
    
    UISlider (PVector p, PVector s, PVector sliderS, float min, float max)
    {
      minValue = min;
      maxValue = max;
      
      globalPos = p.copy();
      localPos = p.copy();
      size = s;
      children = new ArrayList<UIComponent>();
      
      bar = new UIPanel (p,s,this);
      PVector sliderP = p.sub(sliderS.mult(0.5)).add(new PVector ( 0, s.y/2));
      slider = new UIPanel (sliderP,sliderS,this);
    }
    UISlider (PVector p, PVector s, PVector sliderS, float min, float max, UIComponent par)
    {
      minValue = min;
      maxValue = max;
      
      globalPos = p.copy().add(par.globalPos);
      localPos = p.copy();
      size = s;
      children = new ArrayList<UIComponent>();
      parent = par;
      par.children.add(this);
      
      bar = new UIPanel (new PVector(0,0),s,this);
      PVector sliderP = (new PVector ( 0, s.y/2).sub(sliderS.copy().mult(0.5)));
      slider = new UIPanel (sliderP,sliderS,this);
    }
    void checkStatus()
    {
      if (globalPos.x<mouseX && mouseX<globalPos.x+size.x && globalPos.y<mouseY && mouseY<globalPos.y+size.y)
      {
         if((mousePressed && status == Status.HOVER) || status == Status.CLICKED) status = Status.CLICKED;
         if (!mousePressed) status = Status.HOVER;
         else if (status!=Status.CLICKED) status = Status.REST;
      }
      else if (status == Status.CLICKED && mousePressed) status = Status.CLICKED;
      else status = Status.REST;
    }
    @Override
    void Draw()
    {
      //println(slider.globalPos);
      if (active)
      {
        checkStatus();
        PVector sliderOffset = (new PVector ( 0, bar.size.y/2).sub(slider.size.copy().mult(0.5)));
        slider.localPos = new PVector(value/(maxValue-minValue)*bar.size.x, 0).add(sliderOffset);
        
        slider.globalPos = slider.localPos.add(globalPos);
      }
      if (status == Status.CLICKED)
      {
        value = (mouseX - globalPos.x)/bar.size.x*(maxValue-minValue)+minValue;
        if (value < minValue) value = minValue;
        if (value > maxValue) value = maxValue;
      }
      for (UIComponent c: children)
        c.Draw();
    }
  }
