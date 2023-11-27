enum State {IDLE}
class Cursor
{
  State state = State.IDLE;
  PImage idleSprite;
  void setup()
  {
    idleSprite = loadImage("data/cursor_idle.png");
    //cursor(idleSprite);
  }
  void draw() 
  {
  }
}
