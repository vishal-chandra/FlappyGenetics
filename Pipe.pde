class Pipe 
{   
   //settings
   int gapHeight = 100;
   int topHeight = int(random(height - gapHeight));
   int bottomHeight = topHeight + gapHeight;
   int speed = 4;
   
   //pipe attr
   int w = 50; //width
   int x = width;
   int y = topHeight + gapHeight/2;
   boolean behindBird = false;
   
   void show()
   {
     stroke(147, 200, 79);
     fill(147, 200, 79);
     rect(x, 0, w, topHeight);
     rect(x, bottomHeight, w, height);
   }
   
   void update()
   {
     x -= speed;
   }
}
