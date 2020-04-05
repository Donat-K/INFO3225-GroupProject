class Menu {
  
  float xPos;
  float yPos;
  float xLength;
  float yLength;
  
  int mouseScore = 0;
  int mazeScore = 0;
  int roundNum = 1;
  int cheeseNum = 0;
  int damageNum = 0;  
  
  PImage lose, start, victory;
  
  Menu(float xPos_, float yPos_, float xLength_, float yLength_) {  // Menu Constructor
    
    xPos = xPos_;
    yPos = yPos_;
    xLength = xLength_;
    yLength = yLength_;
    
  }
  
  void titleScreen() {  // Title Screen
    pushMatrix();
    
    fill(0, 0, 128);
    rect(xPos, yPos, xLength, yLength);
    imageMode(CENTER);
    start = loadImage("Start.jpg");
    image(start, xLength/2, yLength/2);
    textAlign(CENTER);
    textSize(100);
    fill(255, 255, 255);
    text("MOUSE VS. MAZE", 600, 100);
    
    popMatrix();
  }
  
  void winningScreen() {  // Victory Screen
    pushMatrix();
    
    fill(0, 128, 0);
    rect(xPos, yPos, xLength, yLength);
    imageMode(CENTER);
    victory = loadImage("Victory.jpg");
    image(victory, xLength/2, yLength/2);
    textAlign(CENTER);
    textSize(275);
    fill(0, 0, 0);
    text("YOU WIN", 600, 600);
    
    popMatrix();
  }
  
  void losingScreen() {  // Lose Screen
    pushMatrix();
    
    fill(128, 0, 0);
    rect(xPos, yPos, xLength, yLength);
    imageMode(CENTER);
    lose = loadImage("Lose.jpg");
    image(lose, xLength/2, yLength/2);
    textAlign(CORNER);
    textSize(100);
    fill(0, 0, 0);
    text("YOU LOSE", 100, 150);
    text("TRY AGAIN", 650, 700);
    
    popMatrix();
  }  
  
  void scoreMenu() {
    pushMatrix();
    
    fill(200, 200, 200);
    rect(xPos, yPos, xLength, yLength);
    textAlign(CENTER);
    textSize(24);
    fill(0, 0, 0);
    translate(xPos + xLength/2, yPos + yLength/2);
    text(mouseScore + " - " + mazeScore, 0, 10);
    
    popMatrix();
  }
  
  void roundMenu() {
    pushMatrix();
    
    fill(200, 200, 200);
    rect(xPos, yPos, xLength, yLength);
    textAlign(CENTER);
    textSize(24);
    fill(0, 0, 0);
    translate(xPos + xLength/2, yPos + yLength/2);
    text("Round: " + roundNum, 0, 10);
    
    popMatrix();
  }
  
  void cheeseMenu() {
    pushMatrix();
    
    fill(Colour.ORANGE);
    rect(xPos, yPos, xLength, yLength);
    textAlign(CENTER);
    textSize(24);
    fill(255, 255, 255);
    translate(xPos + xLength/2, yPos + yLength/2);
    text("Cheese: " + cheeseNum, 0, 10);
    
    popMatrix();
  }
  
  void damageMenu() {
    pushMatrix();
    
    fill(Colour.BLUE);
    rect(xPos, yPos, xLength, yLength);
    textAlign(CENTER);
    textSize(24);
    fill(255, 255, 255);
    translate(xPos + xLength/2, yPos + yLength/2);
    text("Hits: " + damageNum, 0, 10);
    
    popMatrix();
  }  
  
  void guideMenu() {
    pushMatrix();
    
    fill(200, 200, 200);
    rect(xPos, yPos, xLength, yLength);
    textAlign(CENTER);
    textSize(20);
    fill(0, 0, 0);
    translate(xPos + xLength/2, yPos);
    text("HELP MENU", 0, 22);
    translate(-xLength/2, 0);
    textAlign(LEFT);
    text("END: Clicking ends the game.", 5, 50);
    text("EMPTY: Clicking empties the square.", 5, 80);
    text("WALL: Clicking creates a wall.", 5, 110);
    text("CHEESE: Clicking creates cheese blocks.", 5, 140);
    text("RESET: Completely clears the grid.", 5, 170);
    text("READY: Ends the building phase.", 5, 200);
    
    popMatrix();
  }   
    
  
  
  
  
  
  
  
  
}
