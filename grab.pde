/*
 * Touche for Arduino
 * Vidualization Example 04
 *
 */
 
 float recVoltageMax;
 float recTimeMax;
float voltageMax; //電圧の最大値
float timeMax; //電圧が最大値だったときの時間
int start;
int goal;
boolean vanishflag = false;

BallSystem bs;

void setup() {
  //画面サイズ
  size(800, 600);
  colorMode(RGB, 255, 255, 255, 100);
  background(0, 0, 0, 100);
  bs = new BallSystem(new PVector(width/2, height/2));
  // ポートを設定
  // PortSelected=5; 
  // シリアルポートを初期化
  // SerialPortSetup();
}

void draw() {
  background(0, 0, 0, 100);
  
  if(mousePressed==true){
    bs.addParticle();
    bs.run();
  }
  if(vanishflag==true){
    bs.vanishBalls();
  }
  //びん
  pushMatrix();
  translate(width/2, height/2);
  fill(255, 0, 0, 100);
  rect(-100, -100, 150, 300);
  popMatrix();
}

//マウスをクリック
void mouseReleased() {
  vanishflag = true;
  //現在の最大値を記録
  //recVoltageMax = voltageMax;
  //recTimeMax = timeMax;
}

void stop() {
  //myPort.stop();
  //super.stop();
}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class BallSystem {
  ArrayList<Ball> balls;
  PVector origin;

  BallSystem(PVector position) {
    origin = position.copy();
    balls = new ArrayList<Ball>();
  }

  void addParticle() {
    balls.add(new Ball(origin));
  }

  void vanishBalls(){
    if(balls.size() <= 0) vanishflag = false;
    else{
      for (int i = balls.size()-1; i >= 0; i--) {
        Ball p = balls.get(i);
        p.vanish();

        if (p.isDead()) {
          balls.remove(i);
        }
      }
    }
  }

  void run() {
    for (int i = balls.size()-1; i >= 0; i--) {
      Ball p = balls.get(i);
      p.run();
      if (p.isDead()) {
        balls.remove(i);
      }
    }
  }
  
  void delete(){
    balls.clear();
  }
}


// A simple Ball class

class Ball {
  int x;
  int y;
  int speedX;
  int speedY;
  int lifespan;

  Ball(PVector origin){
    x = (int)origin.x;
    y = (int)origin.y;

    speedX = (int)random(-10, 10);
    speedY = (int)random(-10, -1);

    while(speedX == 0){
      speedX = (int)random(-10, 10);
    }
    lifespan = 255;
  }

  void run(){
    update();
    display();
  }

  void update(){
    x += speedX;
    y += speedY;

    if(x < 0 || x > width){
      speedX *= -1;
    }
    if(y < 0 || y > height){
      speedY *= -1;
    }
  }
  void vanish(){
    display();
  }

  void display(){
    fill(255,  0, 0, lifespan--);
    ellipse(x, y, 20, 20);
  }

  boolean isDead(){
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}