interface Function
{
  void play(float time);
  void finish();
}

class AnimationPlayer
{
  ArrayList<Animation> animations;
  
  AnimationPlayer()
  {
    animations = new ArrayList<Animation>();
  }
  
  void draw()
  {
    IntList toRemove = new IntList();
    for (int i=0; i<animations.size(); i++)
    {
      Animation a = animations.get(i);
      a.timer -= deltaTime;
      if (a.timer<=0)
      {
        a.function.finish();
        a.inProgress = false;
        toRemove.append(i);
      }
      a.function.play(a.timer);
    }
    for (int i: toRemove)
    {
      animations.remove(i);
    }
  }
}
class Animation
{
    Function function;
    boolean inProgress = false;
    float timer;
    float animationTime = 1;
    AnimationPlayer player;
    
    Animation(float at)
    {
      animationTime = at;
      player = ap;
      timer = 0;
    }
    void Play()
    {
      inProgress = true;
      timer = animationTime;
      player.animations.add(this);
    }
}
