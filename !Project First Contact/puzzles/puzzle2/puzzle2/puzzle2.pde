class Board
{
  PVector pos, size;
  int sizeX;
  int sizeY;
  ArrayList<Light> lights;
  int[][] cells;
  Board(int x, int y, PVector p, PVector s)
  {
    lights = new ArrayList<Light>();
    pos = p;
    size = s;
    sizeX = x;
    sizeY = y;
    cells = new int[x][y];
    for (int i=0; i<x; i++)
    {
      for (int j = 0; j<y; j++)
        cells[i][j] = 0;
    }
  }
  void Draw()
  {
    for (int i=0; i<sizeX; i++)
    {
      for (int j = 0; j<sizeY; j++)
        cells[i][j] = 0;
    }
    for (Light l : lights)
    {
      if (l.active)
      {
        for (int i=0; i<sizeX; i++)
          cells[i][l.posY] = 1;
        for (int i=0; i<sizeY; i++)
          cells[l.posX][i] = 1;
        for (int d = 0; d < sizeX; d++)
        {
          if (l.posX + d<sizeX && l.posY + d<sizeY)
            cells[l.posX + d][l.posY + d] = 1;
            
          if (l.posX + d<sizeX && l.posY - d>=0)
            cells[l.posX + d][l.posY - d] = 1;
            
          if (l.posX - d>=0 && l.posY + d<sizeY)
            cells[l.posX - d][l.posY + d] = 1;
            
          if (l.posX - d>=0 && l.posY - d>=0)
            cells[l.posX - d][l.posY - d] = 1;
        }
      }
    }
    for (Light l : lights)
    {
      if (l.active)
        cells[l.posX][l.posY] = 2;
    }
    if (mX >= 0 && mX < sizeX && mY >= 0 && mY < sizeY) 
    {
      if (cells[mX][mY] == 0)
        cells[mX][mY] = 3;
      else if(cells[mX][mY] == 1)
        cells[mX][mY] = 4;
      else if(cells[mX][mY] == 2)
        cells[mX][mY] = 5;
    }
    for (int x = 0; x<sizeX; x++)
    {
      for (int y = 0; y<sizeY; y++)
      {
        if (cells[x][y] == 0) fill(#888888);
        if (cells[x][y] == 1) fill(#eeee88);
        if (cells[x][y] == 2) fill(#eeeeee);
        if (cells[x][y] == 3) fill(#aaaaaa);
        if (cells[x][y] == 4) fill(#ffffaa);
        if (cells[x][y] == 5) fill(#ffffff);
        rect(pos.x+size.x*x, pos.y+size.y*y, size.x, size.y);
        
      }
    }
  }
}
class Light
{
  int posX, posY;
  boolean active;
  Light(int x, int y, boolean a)
  {
    posX = x;
    posY = y;
    active = a;
  }
}
Board b;
int mX;
int mY; 
void setup()
{
  size (500, 500);
  
  b = new Board(6,6, new PVector(100, 100), new PVector (50, 50));
  b.lights.add(new Light(0,0,false));
  b.lights.add(new Light(0,0,false));
  b.lights.add(new Light(0,0,false));
}
void draw()
{
  background(#ffffff);
  mX = int(mouseX/b.size.x) - int(b.pos.x/b.size.x);
  mY = int(mouseY/b.size.y) - int(b.pos.y/b.size.y);
  b.Draw();
}
void mouseReleased()
{
  boolean placed = false;
  if (mX >= 0 && mX < b.sizeX && mY >= 0 && mY < b.sizeY)
  {
    for (Light l : b.lights)
    {
      if (l.posX == mX && l.posY == mY && l.active)
      {
        l.active = false; 
        placed = true;
      }
    }
    for (Light l : b.lights)
    {
      if (!l.active && !placed)
      {
        l.posX = mX;
        l.posY = mY;
        l.active = true;
        placed = true;
      }
    }
  }
}
