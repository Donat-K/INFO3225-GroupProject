class Player {
  int speed;
  int xPos;
  int yPos;
  int health;
  int points;
  int direction;
  int size = GridSize.CELL_SIZE;
  color colour;
  
  Player() {
    direction = Direction.STOP;
    speed = 1;
    health = 10;
    points = 0;
    colour = Colour.GREY;
    xPos = Random.generateStartPosition(GridSize.GRID_WIDTH);
    yPos = Random.generateStartPosition(GridSize.GRID_HEIGHT);
  }
 
  void draw() {
    move();
    render();
  }
  
  void move() {
    int nextX = xPos;
    int nextY = yPos;
    
    if (direction == Direction.STOP){
      return;
    }
    if (direction == Direction.RIGHT) {
      nextX = xPos += speed;
    }
    if (direction == Direction.DOWN) {
      nextY = yPos += speed;
    }
    if (direction == Direction.LEFT) {
      nextX = xPos -= speed;
    }
    if (direction == Direction.UP) {
      nextY = yPos -= speed;
    }
    
    if (nextX <= 1 || nextX >= (GridSize.GRID_WIDTH*28) - 1 || nextY <= 1 || nextY >= height - 1){
      direction = Direction.STOP;
      return;
    }
    checkBlock(nextX, nextY);
  }
  
  void reset(){
    phase = PhaseType.SETUP;    
    direction = Direction.STOP;
    health = 10;
    points = 0;
    grid.cheeseNum = 0;
    roundMenu.roundNum++;
    colour = Colour.GREY;
    xPos = Random.generateStartPosition(GridSize.GRID_WIDTH);
    yPos = Random.generateStartPosition(GridSize.GRID_HEIGHT);
  }
  
  void render() {
    pushMatrix();
    stroke(0);
    fill(colour);
    ellipseMode(CENTER);
    ellipse(xPos, yPos, size, size);
    popMatrix();
  }
  
  void checkBlock(int nextX, int nextY){
     if (grid.cellType(nextX, nextY) == CellType.WALL) {
          colour = Colour.RED;
          health--;
          direction = Direction.STOP;
        }
     else {
        colour  = Colour.GREY;
        xPos = nextX;
        yPos = nextY;
     }
     if (grid.cellType(nextX, nextY) == CellType.CHEESE) {
       grid.changeCell(nextX, nextY, CellType.EMPTY);
       points++;
       xPos = nextX;
       yPos = nextY;
     }
  } 
}

public static class Direction {
  public static final int RIGHT = 0;
  public static final int DOWN = 1;
  public static final int LEFT = 2;
  public static final int UP = 3;
  public static final int STOP = 4;
}
