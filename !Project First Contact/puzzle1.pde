class Puzzle1
{
  class Square
  {
    PVector pos;
    PVector size;
    color col;
    int posX, posY;
    
    boolean isHovered(){
      if (mouseX >= pos.x + posX*size.x && mouseX <= pos.x+size.x + posX*size.x && mouseY >= pos.y + posY*size.y && mouseY <= pos.y+size.y + posY*size.y)
        return true;
      return false;
    }
    Square(PVector Pos, int x, int y, float s, color c)
    {
      size = new PVector (s,s);
      col = c;
      posX = x;
      posY = y;
      pos = new PVector (Pos.x, Pos.y );
    };
    void Draw()
    {
      Draw(col);
    };
    void Draw(color c)
    {
      fill(c);
      rect(pos.x + posX*size.x, pos.y+ posY*size.y, size.x, size.y);
    };
  }
  class Shape
  {
    PVector pos, initPos;
    Square[] sq;
    int count;
    color col;
    boolean selected = false;
    boolean placed = false;
    Board b;
    
    Shape (int[] x, int[] y, PVector Pos, float size, color c)
    {
      if (x.length != y.length) println("ur gay");
      else
      {
        pos = Pos;
        initPos = Pos.copy();
        count = x.length;
        sq = new Square[count];
        col = c;
        for (int i=0; i<x.length; i++)
        {
          sq[i] = new Square(pos, x[i], y[i], size, col);
        }
        selected = false;
      }
    }
    
    boolean isHovered()
    {
      for (int j=0; j<count; j++)
      {
        if (sq[j].isHovered()) return true;
      }
      return false;
    }
    void Draw ()
    {
      for (Square s : sq)
      {
        s.pos = pos;
        s.Draw();
      }
    }
    void Draw(color c)
    {
      for (Square s : sq)
      {
        s.pos = pos;
        s.Draw(c);
      }
    };
  }
  
  class Board
  {
    PVector pos;
    PVector sqSize;
    int sizeX, sizeY;
    boolean[][] grid;
    boolean completed = false;
    int shapeCnt;
    Shape[] sh;
    
    
    Board (PVector Pos, PVector SqSize, int SizeX, int SizeY, int cnt)
    {
      pos = Pos;
      sqSize = SqSize;
      sizeX = SizeX;
      sizeY = SizeY;
      sh = new Shape[cnt];
      grid = new boolean[sizeX][sizeY];
      for (boolean[] ba : grid)
      {
        for (boolean b: ba)
        {
          b = false;
        }
      }
    }
    void Draw ()
    {
      fill(#bbbbbb);
      for (int i=0; i<sizeX; i++)
      {
        for (int j=0; j<sizeY; j++)
        {
          rect(pos.x+sqSize.x*i, pos.y+sqSize.y*j, sqSize.x, sqSize.y);
        }
      }
    }
    void Debug()
    {
      for (boolean[] ba : grid)
      {
        for (boolean b: ba)
        {
          println(b);
        }
      }
    }
  }
  
  PVector globalSize;
  Shape[] sh;
  Board b;
  
  Shape selectedShape;
  boolean fits;
  int xloc, yloc;
  
  void setup()
  {
    globalSize = new PVector(50, 50);
   
    b = new Board (new PVector(50,50), globalSize, 5, 4, 4);
    b.sh[0] = new Shape (new int[]{0,0,1,1,2}, new int[]{0,1,1,2,2}, new PVector(450,50), globalSize.x, #3377cc);
    b.sh[1] = new Shape (new int[]{0,1,2,1,2,2}, new int[]{0,0,0,1,1,2}, new PVector(450,250), globalSize.x, #dddd00);
    b.sh[2] = new Shape (new int[]{0,1,1,1,1}, new int[]{3,3,2,1,0}, new PVector(450,450), globalSize.x, #cc0000);
    b.sh[3] = new Shape (new int[]{0,0,1,2}, new int[]{0,1,1,1}, new PVector(760,50), globalSize.x, #22ddcc);
  }
  void draw()
  {
    background(#ffffff);
    b.Draw();
    if (selectedShape != null)
    {
      fits = true;
      for (Square s: selectedShape.sq)
      {
        PVector gPos = new PVector (s.pos.x + s.posX*s.size.x, s.pos.y + s.posY*s.size.y);
        if (!(gPos.x + globalSize.x/2 > b.pos.x && gPos.x - globalSize.x/2 < b.pos.x + (b.sizeX-1)*globalSize.x && 
            gPos.y + globalSize.y/2 > b.pos.y && gPos.y - globalSize.y/2 < b.pos.y + (b.sizeY-1)*globalSize.y))
          fits = false;
      }
      xloc = int((selectedShape.pos.x+globalSize.x/2 - b.pos.x)/globalSize.x);
      yloc = int((selectedShape.pos.y+globalSize.y/2 - b.pos.y)/globalSize.y);
      if (fits)
      {
        for (Square s: selectedShape.sq)
        {
          if ( b.grid[s.posX+xloc][s.posY+yloc])
            fits = false;
        }
      }
      if (fits)
      {
        for (Square s: selectedShape.sq)
        {
          fill(#ffffaa);
          rect(b.pos.x+(s.posX+xloc)*s.size.x,b.pos.y+(s.posY+yloc)*s.size.y, globalSize.x, globalSize.y);
        }
      }
      println(selectedShape.col);
    }
    for (int i=0; i<b.sh.length; i++)
    {
      color fill = b.sh[i].col;
      for (int j=0; j<b.sh[i].count; j++)
      {
        if (b.sh[i].sq[j].isHovered()) fill = lerpColor(b.sh[i].col, #ffffff, 0.2);
      }
      if (b.sh[i].selected) {b.sh[i].pos.x+=mouseX-pmouseX; b.sh[i].pos.y+=mouseY -pmouseY; }
      b.sh[i].Draw(fill);
      stroke(0);
    }
    b.Debug();
  }
  
  void mouseReleased()
  {
    boolean selected = false;
    for (int i=0; i<b.sh.length; i++)
    {
      if (b.sh[i].isHovered() && !b.sh[i].selected)
      {
        if (selectedShape == b.sh[i])
        {
          b.sh[i].selected = false;
          selectedShape = null;
        }
        else if (!selected)
        {
          selectedShape = b.sh[i];
          b.sh[i].selected = true;
          selected = true;
          if (b.sh[i].placed)
          {
            xloc = int((selectedShape.pos.x+globalSize.x/2 - b.pos.x)/globalSize.x);
            yloc = int((selectedShape.pos.y+globalSize.y/2 - b.pos.y)/globalSize.y);
            for (Square s : b.sh[i].sq)
              b.grid[s.posX+xloc][s.posY+yloc] = false;
          }
        }
      }
      else if (b.sh[i].isHovered() && b.sh[i].selected)
      {
        if (fits)
        {
          b.sh[i].placed = true;
          b.sh[i].pos = new PVector (b.pos.x+xloc*globalSize.x, b.pos.y+yloc*globalSize.y);
          for (Square s : b.sh[i].sq)
            b.grid[s.posX+xloc][s.posY+yloc] = true;
        }
        else
        {
          b.sh[i].placed = false;
        }
        b.sh[i].selected = false;
        selectedShape = null;
      }
      if (!b.sh[i].selected && !b.sh[i].placed)
      {
        b.sh[i].pos = b.sh[i].initPos.copy();
      }
    }
  }
  
  void keyReleased()
  {
    if(keyCode ==' ' && selectedShape!=null)
    {
      selectedShape.selected = false;
      selectedShape = null;
    }
  }
}
