/*
  Q Learning with Flappy Bird
  by Vishal Chandra
  
  300 birds play the game at once, then the top 24
  are selected for the next generation. They produce
  276 (24 C 2) offspring to fill the rest of the generation.
  This continues...
  
  Press D to download the current alltime best bird
*/

//assets
Flock flock;
ArrayList<Pipe> pipes = new ArrayList();

//text
PImage img;
PFont font;

void setup() {
  font = createFont("helvetica", 16, true);
  img = loadImage("flappy.png");
  size(600, 600);
  background(255);
  frameRate(60);
  
  //init assets
  flock = new Flock(); 
  pipes.add(new Pipe());
}

void draw() {
    runFPGA();
}

void runFPGA() {
  background(255);
  
  //update birds
  for(Bird bird : flock.birds) {
    
    if(!bird.dead) {
      bird.show(img);
      bird.update();
      
      //dies if it hits the ground
      if(bird.y > height) { 
        bird.dead = true;
      }
    }
  }
  
  //new pipes
  if(frameCount % 100 == 0) {
    pipes.add(new Pipe());
  }
  
  //update pipe info
  for(int i = 0; i < pipes.size(); i++) {
    
    Pipe p = pipes.get(i);
    p.show();
    p.update();
    
    if(p.x < -p.w) {
      pipes.remove(i);
      i--; //avoid arraylist skip
    }
    
    if(p.x < flock.birds[0].x) p.behindBird = true;
    
    for(Bird bird : flock.birds) { 
      if(bird.collidedWith(p)) bird.dead = true;
    }
    
  }
  
  //check which pipe is closer and feed that to
  //the neural networks
  Pipe p = getClosestPipe();
  for(Bird bird : flock.birds)
    bird.decide(p.x, p.y);
  
  //checking if all dead
  if(allDead()) {
    flock.runGA();
    reset();
  }
  
  
  fill(0);
  //convert frames to seconds
  text("Alltime Best Bird: \n" + flock.alltimeBestScore/30 + " secs", 500, 10);
  text("Generation: " + flock.generation, 500, 40);
}

Pipe getClosestPipe() {
  Pipe p;
  if(!pipes.get(0).behindBird) {
    p = pipes.get(0);
  }
  else {
    p = pipes.get(1); 
  }
  return p;
}

boolean allDead() {
  boolean allDead = true;
  for(Bird bird : flock.birds) {
    if(!bird.dead) {
      allDead = false;
      break;
    }
  }
  return allDead;
}

void keyPressed() {
    if(key == 'D' || key == 'd') {
      flock.downloadBest();
    }
}

void reset() {
  for(Bird bird : flock.birds)
    bird.reset();
  pipes.clear();
  frameCount = 1;
  pipes.add(new Pipe());
}
