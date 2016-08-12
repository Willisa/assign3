
//GAMESTATES
final int GAME_START    = 0;
final int GAME_RUN      = 1;
final int GAME_LOSE     = 2;

//hpX control
final int FULL      = 1;
final int NOT_FULL  = 2;
final int EMPTY     = 0;

//enemy control
final int Straight  = 1;
final int Slope     = 2;
final int Diamond   = 3; 

PImage enemy ;
PImage fighter ;
PImage hp ;
PImage treasure ;
PImage bg1;
PImage bg2;
PImage end1;
PImage end2;
PImage enemy1;
PImage gainbomb;
PImage start1;
PImage start2;
float enemyX, enemyY; 
float enemyXSpeed, enemyYSpeed; 
float treasureX, treasureY;
float fighterX, fighterY;
float fighterSpeed;
float hpX;
float enemySpacing; 

int width, height;
int x1, x2;

boolean upPressed    = false;
boolean downPressed  = false;
boolean leftPressed  = false;
boolean rightPressed = false;

int hpState = FULL;
int gameState ;
int enemyState = Straight;

void setup () {
  // background
  width = 640;
  height = 480;
  size(640,480);
  x1 = 0;
  x2 = -width;
  //  load images
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  
  image(fighter, fighterX,  fighterY);
  fighterX = 580;
  fighterY = floor(random(60,420));
  fighterSpeed = 5;
  image( enemy, enemyX, enemyY);
  enemyX = -65;
  enemyY = floor(random(60,420));
  enemyXSpeed = 4;
  enemyYSpeed = 3;
  enemySpacing = 70;
  image(treasure, treasureX,  treasureY);
  treasureX = floor(random(60,580));
  treasureY = floor(random(60,420));
  image(hp, hpX, 0);
  hpX = 42; 
  gameState = GAME_START;
}

void draw() {
   //hp control
  if(0 < hpX  &&  hpX < 210){
    hpState = NOT_FULL;
    }
  if(hpX >= 210){
    hpX = 210;
    hpState = FULL;
    }
  if(hpX <= 0){
    hpState = EMPTY;
    }
  
  switch(hpState){    
      case FULL:
        if( treasureX - 20 <= fighterX + 20  && fighterX + 20 <= treasureX + 55  &&
            treasureY - 25 <= fighterY + 20  && fighterY + 20 <= treasureY + 55){
          treasureX = random(60,580); 
          treasureY = random(60,420);
        }
        break;
      
      case NOT_FULL:
        if(treasureX - 20 <= fighterX + 20  &&  fighterX + 20 <= treasureX + 55  &&
           treasureY - 20 <= fighterY + 20  &&  fighterY + 20 <= treasureY + 55){
         hpX += 210 * 10 / 100;
         treasureX=random(60,580); 
         treasureY=random(60,420);
        }
        break;
      
      case EMPTY:
        gameState=GAME_LOSE;
        break;
  }
  
  switch (gameState){
    case GAME_START:
    image(start2, 0, 0 );
    //mouse action
    if (444 >= mouseX && mouseX >= 213 &&  420 >= mouseY && mouseY >= 381){ 
      image(start1, 0, 0);
    if (mousePressed){
          // click
          gameState = GAME_RUN;
        }
    }
    break;
    
    case GAME_RUN:
    // background
    image( bg2, x1, 0 );
    image( bg1, x2, 0 );
    if( x1 == width )
      x1 = -width;
    else
      x1 += 2;
 
    if( x2 == width )
      x2 = -width;
    else
    x2 += 2;
      // enemy 
      switch(enemyState){
        case Straight:
        for(int i = 0; i < 5; i++){
          image(enemy, enemyX - i*enemySpacing,enemyY);
        }
        enemyX += 5;
        if (enemyX - 5*enemySpacing >= width) {
          enemyX = -70;
          enemyY = random(20,140);
          enemyState = Slope;
          }
         break; 
      
        case Slope:
         for(int i = 0; i < 5 ; i++){
         image(enemy, enemyX - i*enemySpacing,enemyY + i*enemySpacing);
          }
         enemyX += 5;
         if(enemyX - 5*enemySpacing >= width) {
          enemyX = -70;
          enemyY = random(140,300);
          enemyState = Diamond;
          }
       break;
       
       case Diamond:
       for(int i=0;i<3;i++){
            image(enemy,enemyX-i*enemySpacing,enemyY-i*enemySpacing);
            image(enemy,enemyX-i*enemySpacing,enemyY+i*enemySpacing);
            image(enemy,enemyX-(4-i)*enemySpacing,enemyY-i*enemySpacing);
            image(enemy,enemyX-(4-i)*enemySpacing,enemyY+i*enemySpacing);
           }
       enemyX += 5;
       if(enemyX - 5*enemySpacing >= width) {
        enemyX = -70;
        enemyY = random(80,400);
        enemyState = Straight;
       }
       break;  
      }
      //boundary detection(enemy)
       if( enemyY > 420){
        enemyY = 420;}
       if( enemyY < 60){ 
        enemyY = 60;}
      // treasure
      image(treasure,treasureX,treasureY);
      // fighter
      image(fighter,fighterX,fighterY);
      // move fighter 
       if (upPressed) {
          fighterY -= fighterSpeed;
        }
       if (downPressed) {
          fighterY += fighterSpeed;
        }
        if (leftPressed) {
          fighterX -= fighterSpeed;
        }
        if (rightPressed) {
          fighterX += fighterSpeed;
        }
     //move fighter(boundary detection)
        if (fighterX > width-50){
          fighterX = width-50; 
        }
        if (fighterX < 0){
           fighterX = 0; 
        }
  
        if (fighterY > height-50){
           fighterY = height-50;
        }
        if (fighterY < 0){
           fighterY = 0;
        }
      // hp
      fill(#ff0000);
      rectMode(CORNERS);
      rect(10,0,hpX,30);
      image(hp,5,0);
      break;
      
      case GAME_LOSE:
      image(end2, 0, 0 );
    //mouse action
    if (444 > mouseX && mouseX > 213 && 352 > mouseY && mouseY > 309   ){ 
      image(end1,0,0);
    if (mousePressed){
          // click
          gameState = GAME_RUN;
          hpState = FULL;
          
          fighterX = 580;
          fighterY = floor(random(60,420));
          fighterSpeed = 5;
          enemyX = 0;
          treasureX = random(60,580);
          treasureY = random(60,420);
          hpX = 42;
         }
       }
      break;
     }
  }


void keyPressed(){
  if (key == CODED) {  // detect special keys
    switch (keyCode) {  
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
  

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
