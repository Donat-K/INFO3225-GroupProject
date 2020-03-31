class Grid {
  int[][] cells = new int[GridSize.GRID_WIDTH][GridSize.GRID_HEIGHT];
  int selected;
  
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
        stroke(Colour.RED);
        
        int i = int(mouseX / GridSize.CELL_SIZE);
        int j = int(mouseY / GridSize.CELL_SIZE);
        rect(i * GridSize.CELL_SIZE, j * GridSize.CELL_SIZE, GridSize.CELL_SIZE, GridSize.CELL_SIZE);
      }
    }
  
  boolean isWall(int xPos, int yPos) {
    int i = int(xPos / GridSize.CELL_SIZE);
    int j = int(yPos / GridSize.CELL_SIZE);
    return (cells[i][j] == CellType.WALL);
  }
  
  int cellType(int xPos, int yPos){
    int i = (int)(xPos / GridSize.CELL_SIZE);
    int j = (int)(yPos / GridSize.CELL_SIZE);
    return cells[i][j];
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
}

public static class CellType {
   public static final int EMPTY = 0;
   public static final int WALL = 1;
   public static final int CHEESE = 2;
   public static final int HOVER = 3;
}

public static class GridSize {
  public static final int CELL_SIZE = 40;
  public static final int GRID_WIDTH = 25;
  public static final int GRID_HEIGHT = 25;
}

public static class Random {
  static int generateInt(int min, int max) {//min and max are both inclusive.
    if (max < min) {
      throw new IllegalArgumentException("Max must be greater than min.");
    }
    else {
      return (int)(Math.random() * (max + 1 - min)) + min;
    }
  }
  
  static int generateStartPosition(int dimension){
      return generateInt((3 * GridSize.CELL_SIZE), (dimension * (GridSize.CELL_SIZE - 3))); 
  }
}
