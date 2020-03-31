int phase;
Menu titleScreen, winningScreen, losingScreen, scoreMenu;
Grid grid;
Button empty, wall, cheese, start, reset, end, ready;

void settings(){
  width = GridSize.CELL_SIZE * GridSize.GRID_WIDTH;
  height = GridSize.CELL_SIZE * GridSize.GRID_HEIGHT;
  size(width + 400, height);
 }

void setup() {
  phase = PhaseType.START;  // Game starts on the opening screen
 
  
  titleScreen = new Menu(0, 0, width, height);//Creating the Start and Ending Screens
  winningScreen = new Menu(0, 0, width, height);
  losingScreen = new Menu(0, 0, width, height);
  
  start = new Button(600, 750, 200, 100, ButtonType.START);
  end = new Button(width - 400, ButtonSize.HEIGHT, ButtonType.END);
  
  empty = new Button(width - 400, ButtonSize.HEIGHT * 2, ButtonType.EMPTY);
  wall = new Button(width - 400, ButtonSize.HEIGHT * 3, ButtonType.WALL);
  cheese = new Button(width - 400, ButtonSize.HEIGHT * 4, ButtonType.CHEESE);
  reset = new Button(width - 400, ButtonSize.HEIGHT * 5, ButtonType.RESET);
  ready = new Button(width - 400, ButtonSize.HEIGHT * 6, ButtonType.READY);
  scoreMenu = new Menu(width - 400, 0, 100, 50);
  
  grid = new Grid();
  
  
}

void draw() {
  
  if (phase == PhaseType.START) {  // Display Title Screen at the start
    titleScreen.titleScreen();
    start.draw();  
  }      
  else if (phase == PhaseType.SETUP) {  // Display the Maze while the game is on
    grid.draw();
    
    
    scoreMenu.scoreMenu();
    end.draw();
    empty.draw();
    wall.draw();
    cheese.draw();
    reset.draw();
    ready.draw();
  }    
  else if (phase == PhaseType.END) {  // Display the Ending Screen, either Victory or Defeat
    if (scoreMenu.mouseScore > scoreMenu.mazeScore) {
      winningScreen.winningScreen();
    } else if (scoreMenu.mouseScore <= scoreMenu.mazeScore) {
      losingScreen.losingScreen();
    }
  }
}

void mouseDragged() {
   if (grid.isMouseOnGrid()){
     grid.changeCell(mouseX, mouseY, grid.selected); 
   }
}
  
void mousePressed() {
  if (start.isMouseOverButton()) {
    phase = PhaseType.SETUP;
  }
  else if (end.isMouseOverButton()) {
    phase = PhaseType.END;   
  }
   else if (reset.isMouseOverButton()) {
    grid.reset();   
  }
   else if (empty.isMouseOverButton()) {
    empty.isSelected = true;
    wall.isSelected = false;
    cheese.isSelected = false;
    grid.selected = CellType.EMPTY;
  }
   else if (wall.isMouseOverButton()) {
    empty.isSelected = false;
    wall.isSelected = true;
    cheese.isSelected = false;
    grid.selected = CellType.WALL;
  }
  else if (cheese.isMouseOverButton()) {
    empty.isSelected = false;
    wall.isSelected = false;
    cheese.isSelected = true; 
    grid.selected = CellType.CHEESE;
  }
  if (grid.isMouseOnGrid()){
     grid.changeCell(mouseX, mouseY, grid.selected); 
  }
}

public static class PhaseType {
   public static final int START = 0;
   public static final int SETUP = 1;
   public static final int PLAY = 2;
   public static final int END = 3;
}
