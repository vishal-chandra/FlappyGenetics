class Bird
{
  int x = 45;
  int y = width/2;
  float velocity = 0;
  float gravity = 0.9;
  int lift = 12;
  
  void show()
  {
    fill(255);
    stroke(0);
    ellipse(x, y, 40, 40);
  }
  
  void update()
  {
    velocity += gravity;
    velocity *= 0.9;
    y += velocity;
    
    if(y > height)
    {
      velocity = 0;
      y = height;
    }
    if(y < 0)
    {
      y = 0;
      velocity = 0;
    }
  }
  
  void up()
  {
     velocity -= lift;
  }
  
  void reset()
  {
    x = 45;
    y = width/2;
  }
  
  boolean collidedWith(Pipe pipe)
  {
    if(x > pipe.x && x < pipe.x + pipe.w)
      if(y < pipe.topHeight || y > pipe.topHeight + pipe.gapHeight)
        return true;
    return false; 
  }
}
