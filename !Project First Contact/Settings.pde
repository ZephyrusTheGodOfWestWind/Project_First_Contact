class Settings
{
  float masterVolume;
  float sfxVolume;
  float musicVolume;
  
  UIComponent mainWindow;
  UISlider masterVolumeSlider;
  UISlider sfxVolumeSlider;
  UISlider musicVolumeSlider;
  
  boolean active = false;
  
  void setup()
  {
    mainWindow = new UIPanel(new PVector(width/6, height/6), new PVector (width*2/3, height*2/3));
    masterVolumeSlider = new UISlider (new PVector(200, 100), new PVector(width/3, 20), new PVector (30,30), 0, 100, mainWindow);
    sfxVolumeSlider = new UISlider (new PVector(200, 200), new PVector(width/3, 20), new PVector (30,30), 0, 100, mainWindow);
    musicVolumeSlider = new UISlider (new PVector(200, 300), new PVector(width/3, 20), new PVector (30,30), 0, 100, mainWindow);
    
    masterVolumeSlider.value = 100;
    sfxVolumeSlider.value = 100;
    musicVolumeSlider.value = 100;
    
    println(masterVolumeSlider.slider.globalPos);
  }
  void draw()
  {
    if (active)
    {
      mainWindow.Draw();
      
      if (masterVolumeSlider.status == Status.CLICKED) 
        sf.amp(settings.musicVolumeSlider.value/100 * settings.masterVolumeSlider.value/100);
      if (musicVolumeSlider.status == Status.CLICKED) 
        sf.amp(settings.musicVolumeSlider.value/100 * settings.masterVolumeSlider.value/100);
      if (sfxVolumeSlider.status == Status.CLICKED) 
        sf.amp(settings.musicVolumeSlider.value/100 * settings.masterVolumeSlider.value/100);
      
      translate(mainWindow.globalPos.x,mainWindow.globalPos.y);
      fill(#1fee62);
      textAlign(CENTER, CENTER);
      text("Settings", mainWindow.size.x/2, 50);
      
      textSize(24);
      text("Master Volume", 100, 100+masterVolumeSlider.size.y/2);
      text((int)masterVolumeSlider.value + "%", 750, 100+masterVolumeSlider.size.y/2);
      
      text("SFX Volume", 100, 200+sfxVolumeSlider.size.y/2);
      text((int)sfxVolumeSlider.value + "%", 750, 200+sfxVolumeSlider.size.y/2);
      
      text("Music Volume", 100, 300+musicVolumeSlider.size.y/2);
      text((int)musicVolumeSlider.value + "%", 750, 300+musicVolumeSlider.size.y/2);
      resetMatrix();
      textAlign(CORNER);
    }
  }
  void keyReleased()
  {
    if (keyCode == TAB)
      active = !active;
  }
}
