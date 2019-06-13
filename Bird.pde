class Bird implements Comparable<Bird>
{
  int x = 45;
  int y = width/2;
  float velocity = 0;
  float gravity = 0.9;
  int lift = 12;
  int timeAlive = 0;
  boolean dead = false;

  NeuralNetwork brain;
  
  Bird(){
    brain = new NeuralNetwork(2,4,1);
  } 
  
  Bird(NeuralNetwork nn) {
    brain = nn;
  }
  
  void show(PImage img) {
    //fill(255);
    //stroke(0);
    //ellipse(x, y, 40, 40);
    image(img, x, y, 50, 40);
  }
  
  void update() {
    timeAlive++;
    velocity += gravity;
    velocity *= 0.9;
    y += velocity;
    
    //hits top
    if(y < 0)
    {
      velocity = 0;
      y = height;
    }
    //hits bottom resets game and is handled by FlappyGenetics.pde
  }
  
  void up() {
     velocity -= lift;
  }
  
  void decide(int gapX, int gapY) {
    double[] inputLayer = {(double)(gapX - this.x), (double)(gapY - this.y)};
    double prediction = brain.guess(inputLayer)[0];
    if(prediction > 0.5) up();
  }
  
  void reset() {
    x = 45;
    y = width/2;
    timeAlive = 0;
    dead = false;
  }
  
  boolean collidedWith(Pipe pipe) {
    if(x > pipe.x && x < pipe.x + pipe.w)
      if(y < pipe.topHeight || y > pipe.topHeight + pipe.gapHeight)
        return true;
    return false; 
  }
  
  int compareTo(Bird b) {
    if(this.timeAlive == b.timeAlive) return 0;
    if(this.timeAlive > b.timeAlive) return 1;
    return -1;
  }
 
}
