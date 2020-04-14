import processing.sound.*;

int phase;
Menu titleScreen, winningScreen, losingScreen, scoreMenu, roundMenu, pointsMenu, healthMenu, guideMenu;
Grid grid;
Player player;
Button empty, wall, cheese, start, reset, end, ready;
SoundFile opening, setup, playing, loss, victory;

void settings(){
  width = GridSize.CELL_SIZE * GridSize.GRID_WIDTH;
  height = GridSize.CELL_SIZE * GridSize.GRID_HEIGHT;
  size(width + 400, height);
 }

void setup() {
  phase = PhaseType.START;  // Game starts on the opening screen
 
  opening = new SoundFile(this, "Opening.mp3");
  setup = new SoundFile(this, "Setup.mp3");
  playing = new SoundFile(this, "Playing.mp3");
  loss = new SoundFile(this, "Loss.mp3");
  victory = new SoundFile(this, "Victory.mp3");

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
  roundMenu = new Menu(width - 300, 0, 150, 50);
  pointsMenu = new Menu(width - 300, 200, 150, 50);
  healthMenu = new Menu(width - 300, 150, 150, 50);
  guideMenu = new Menu(width - 400, 350, 400, 250);
 
  grid = new Grid();
  player = new Player();
  
  opening.play();
  
}

void draw() {  
  if (phase == PhaseType.START) {  // Display Title Screen at the start
    titleScreen.titleScreen();
    start.draw();
  } 
  
  if (phase == PhaseType.PLAY) { 
    player.draw();   
    if (player.health <= 0){
      scoreMenu.mazeScore++;
      grid.reset();
      player.reset();
    }  
    if (grid.cheeseNum > 1){
      if (player.points == grid.cheeseNum){
        scoreMenu.mouseScore++;
        grid.reset();
        player.reset();
      }
    }
  }
  
  if (phase == PhaseType.SETUP || phase == PhaseType.PLAY) {  // Display the Maze while the game is on
    opening.stop();
    if (!setup.isPlaying()) {
      setup.play();
    }

    fill(Colour.BLACK);
    rect(0, 0, width + 400, height); // Square to Hide start Menu  
    grid.draw();
    player.render(); //shows the player's initial position (but does not move)
    
    scoreMenu.scoreMenu();
    roundMenu.roundMenu();
    pointsMenu.cheeseMenu();
    healthMenu.healthMenu();
    guideMenu.guideMenu();
    
    end.draw();
    empty.draw();
    wall.draw();
    cheese.draw();
    reset.draw();
    ready.draw();
  }
  
  else if (phase == PhaseType.END) {  // Display the Ending Screen, either Victory or Defeat
    setup.stop();
    if (scoreMenu.mouseScore > scoreMenu.mazeScore) {
      winningScreen.winningScreen();
      if (!victory.isPlaying()) {
        victory.play();
      }
    } else if (scoreMenu.mouseScore <= scoreMenu.mazeScore) {
      losingScreen.losingScreen();
      if (!loss.isPlaying()) {
        loss.play();
      }
    }
  }
}

void mouseDragged() {
  if (phase == PhaseType.SETUP) {   
    grid.placeBlock();
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
    player.reset();
    phase = PhaseType.SETUP;
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
  else if (ready.isMouseOverButton()){
    phase = PhaseType.PLAY;
    grid.countCheese();
  }
  if (phase == PhaseType.SETUP) {   
    grid.placeBlock();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      player.direction = Direction.RIGHT;
    }
    if (keyCode == DOWN) {
      player.direction = Direction.DOWN;
    }
    if (keyCode == LEFT) {
      player.direction = Direction.LEFT;
    }
    if (keyCode == UP) {
      player.direction = Direction.UP;
    }
  }  
  if (key == 's' || key == 'S'){
    if (player.speed == 1) {
      player.speed = 3;
    } else if (player.speed == 3) {
      player.speed = 1;
    }
  } 
}

public static class PhaseType {
   public static final int START = 0;
   public static final int SETUP = 1;
   public static final int PLAY = 2;
   public static final int END = 3;
}
