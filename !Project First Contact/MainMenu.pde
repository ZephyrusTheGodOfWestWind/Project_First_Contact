class MainMenu
{
  UIPanel panel;
  UIButton playButton;
  UIButton settingsButton;
  UIButton exitButton;
  
  boolean active;
  boolean shown;
  
  void setup ()
  { 
    active = true;
    shown = true;
    panel = new UIPanel(new PVector (width/2-500, height/2-300), new PVector (1000, 600), sm.scenes.get(0));
    playButton = new UIButton (new PVector (width/2-100, 400), new PVector (200, 50), sm.scenes.get(0));
    settingsButton = new UIButton (new PVector (width/2-100, 500), new PVector (200, 50), sm.scenes.get(0));
    exitButton = new UIButton (new PVector (width/2-100, 600), new PVector (200, 50), sm.scenes.get(0));
    
    panel.AddChild(playButton);
    panel.AddChild(settingsButton);
    panel.AddChild(exitButton);
  }
  void Enable ()
  {
    active = true;
    playButton.enabled = true;
    settingsButton.enabled = true;
    exitButton.enabled = true;
  }
  
  void Disable ()
  {
    active = false;
    playButton.enabled = false;
    settingsButton.enabled = false;
    exitButton.enabled = false;
  }
  void draw()
  {
    if (shown)
    {
      if (active)
      {
        playButton.butt = () -> thread("load");
        settingsButton.butt = () -> { Disable(); settings.active = true; };
        exitButton.butt = () -> exit();
      }
      panel.Draw();
      fill(#ff0000);
      textSize(80);
      textAlign(CENTER, CENTER);
      text("bogos binted?", width/2, 200);
      textSize(40);
      text("play", width/2, 415);
      text("settings", width/2, 515);
      text("exit", width/2, 615);
      textAlign(CORNER);
      
    }
  }
}
