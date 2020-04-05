class Player {
  int speed = 1;
  int xPos;
  int yPos;
  int direction;
  int size = GridSize.CELL_SIZE;
  
  Player() {
    direction = Random.generateInt(0,3);
    xPos = 50;
    yPos = 50;
    //xPos = Random.generateStartPosition(GridSize.GRID_WIDTH);
    //yPos = Random.generateStartPosition(GridSize.GRID_HEIGHT);
  }
 
  void draw() {
    move();
    render();
  }
  
  void move() {
    int lastX = xPos;
    int lastY = yPos;
    if (direction == Direction.RIGHT) {
      xPos += speed;
    }
    if (direction == Direction.DOWN) {
      yPos += speed;
    }
    if (direction == Direction.LEFT) {
      xPos -= speed;
    }
    if (direction == Direction.UP) {
      yPos -= speed;
    }
    
    if ((xPos >= width) || (xPos <= 0)) {
      xPos = Math.abs(xPos - width);
    }
    if ((yPos >= height) || (yPos <= 0)) {
      yPos = Math.abs(yPos - height);
    }
    
    if (grid.isWall(xPos, yPos)) {
      xPos = lastX;
      yPos = lastY;
    }
  }
  
  void reset(){
    //player = new Player();
  }
  
  void render() {
    pushMatrix();
    translate(xPos, yPos);
    stroke(0);
    fill(Colour.GREY);
    ellipseMode(CENTER);
    ellipse(xPos, yPos, size, size);
    popMatrix();
  }
}

public static class Direction {
  public static final int RIGHT = 0;
  public static final int DOWN = 1;
  public static final int LEFT = 2;
  public static final int UP = 3;
}
