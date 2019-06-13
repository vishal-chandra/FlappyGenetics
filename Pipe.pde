class Pipe 
{
   int w = 50;
   int x = width;
   int gapHeight = 100;
   int topHeight = int(random(height - gapHeight));
   int bottomHeight = topHeight + gapHeight;
   int speed = 4;
   
   void show()
   {
     fill(0);
     rect(x, 0, w, topHeight);
     rect(x, bottomHeight, w, height);
   }
   
   void update()
   {
     x -= speed;
   }
}
