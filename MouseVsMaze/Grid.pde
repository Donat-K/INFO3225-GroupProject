class Grid {
  int[][] cells = new int[GridSize.GRID_WIDTH][GridSize.GRID_HEIGHT];
  int selected;
  int cheeseNum = 0;
  
  Grid() {
    //selected = CellType.EMPTY;
    for (int i = 0; i < (GridSize.GRID_WIDTH); i++) {
      for (int j = 0; j < (GridSize.GRID_HEIGHT); j++) {
        cells[i][j] = CellType.EMPTY;
      }
   }
  }
  
  int checkWallVicinity(int i, int j) {
    int wallCount = 0;
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        if (cells[i + x][j + y] == CellType.WALL) {
          wallCount++;
        }
      }
    }
    return wallCount;
  }
  
  void reset(){
    for (int i = 0; i < (GridSize.GRID_WIDTH); i++) {
      for (int j = 0; j < (GridSize.GRID_HEIGHT); j++) {
        cells[i][j] = CellType.EMPTY;
      }
    }
  }
  
  void draw() {  
      //Fills in the cells with the appropriate color.
      for (int i = 0; i < (GridSize.GRID_WIDTH); i++) { 
        for (int j = 0; j < (GridSize.GRID_HEIGHT); j++) { 
          stroke(Colour.WHITE);
          if (cells[i][j] == CellType.HOVER) { 
           stroke(Colour.RED);  
          }
          if (cells[i][j] == CellType.EMPTY) {  
            fill(Colour.BLACK);   
          }       
          else if (cells[i][j] == CellType.WALL) {   
            fill(Colour.BLUE);
          }  
          else if (cells[i][j] == CellType.CHEESE) { 
           fill(Colour.ORANGE);
          }
          rect(i * GridSize.CELL_SIZE, j * GridSize.CELL_SIZE, GridSize.CELL_SIZE, GridSize.CELL_SIZE);
        }  
      }      
      //Outlines hovered cell in red
      if(isMouseOnGrid()){
        noFill();
        stroke(Colour.RED);        
        int i = (int)(mouseX / GridSize.CELL_SIZE);
        int j = (int)(mouseY / GridSize.CELL_SIZE);
        rect(i * GridSize.CELL_SIZE, j * GridSize.CELL_SIZE, GridSize.CELL_SIZE, GridSize.CELL_SIZE);
      }
  }
  
  void randomFill() {
    for (int i = 0; i < (GridSize.GRID_WIDTH); i++) {
      for (int j = 0; j < (GridSize.GRID_HEIGHT); j++) {
        int chance = Random.generateInt(1, 16);
        if ((i == 0) || (j == 0) || (i == GridSize.GRID_WIDTH - 1) || (j == GridSize.GRID_WIDTH - 1)) {//creates wall around edges of grid
          cells[i][j] = CellType.WALL;
          continue;
        }
         //increases chances of wall being generated adjacent to existing wall.
          if (cells[i - 1][j] == CellType.WALL || cells[i + 1][j] == CellType.WALL) {
            chance -= 1;
            if (cells[i][j - 1] == CellType.WALL && cells[i][j + 1] == CellType.WALL) {
             chance += 1; 
            }
          }
          if (cells[i][j - 1] == CellType.WALL || cells[i][j + 1] == CellType.WALL) {
            chance -= 1;
            if (cells[i - 1][j] == CellType.WALL && cells[i + 1][j] == CellType.WALL) {
             chance += 1; 
            }
          }
          if (chance >= 7 && chance < 15){
          cells[i][j] = CellType.EMPTY;
          }
          if (chance >= 15 && chance <= 16){
          cells[i][j] = CellType.CHEESE;
          }
          //decreases chances of blocked off areas
          if (checkWallVicinity(i, j) >= 3) {
            chance += 6;
          }
          if (chance >= 0 && chance < 7){
            cells[i][j] = CellType.WALL;
          }
        }
      }
    }
  
  void countCheese() {
    for (int i = 0; i < (GridSize.GRID_WIDTH); i++) { 
      for (int j = 0; j < (GridSize.GRID_HEIGHT); j++) { 
        if (cells[i][j] == CellType.CHEESE) { 
           cheeseNum++;
        }
      }
    }
  }
  
  int cellType(int xPos, int yPos){
    int i = (int)(xPos / GridSize.CELL_SIZE);
    int j = (int)(yPos / GridSize.CELL_SIZE);
    System.out.println("x: " + xPos + ", y: " + yPos + "\ni: " + i + ", j: " + j);
    if (!(i <= 0) && !(i >= GridSize.GRID_WIDTH) && !(j<= 0) && !(j >= GridSize.GRID_HEIGHT)){
      return cells[i][j];
    }
    else {
      return -1;
    }
  }
  
  boolean isMouseOnGrid(){
     if(mouseX >= 0 && mouseX <= GridSize.CELL_SIZE * GridSize.GRID_WIDTH){
      if(mouseY >= 0 && mouseY <= GridSize.CELL_SIZE * GridSize.GRID_HEIGHT){
        return true;
      }
     }
    return false;
  }
    
   void changeCell(int xPos, int yPos, int cellType) {
     int i = int(xPos / GridSize.CELL_SIZE);
     int j = int(yPos / GridSize.CELL_SIZE);
     cells[i][j] = cellType;
   }
   
   void placeBlock(){
     if (grid.isMouseOnGrid()){
        //Prevents placing of block on top of player
        //if ((mouseX >= (player.xPos + GridSize.CELL_SIZE / 2)) || (mouseX <= (player.xPos - GridSize.CELL_SIZE / 2))){
          //if((mouseY >= (player.yPos + GridSize.CELL_SIZE / 2)) || (mouseY <= (player.yPos - GridSize.CELL_SIZE / 2))){
            grid.changeCell(mouseX, mouseY, grid.selected); 
          //}
      // } 
     }
   }
}

public static class CellType {
   public static final int EMPTY = 0;
   public static final int WALL = 1;
   public static final int CHEESE = 2;
   public static final int HOVER = 3;
}

public static class GridSize {
  public static final int CELL_SIZE = 28;
  public static final int GRID_WIDTH = 35;
  public static final int GRID_HEIGHT = 35;
}
