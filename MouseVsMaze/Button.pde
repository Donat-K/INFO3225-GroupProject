public class Button {
  int xPos;
  int yPos;
  int xWidth;
  int yHeight;
  boolean startOver = false;
  boolean endOver = false;
  int type;
  color colour;
  color highlight;
  String label;
  boolean isSelected;

  Button(int xPos, int yPos, int type) {  // Button Constructor
    this.xPos = xPos;
    this.yPos = yPos;
    xWidth = ButtonSize.WIDTH;
    yHeight = ButtonSize.HEIGHT;
    isSelected  = false;
    this.type = type;
    
    if (type == ButtonType.START){
      colour = Colour.GREEN;
      highlight = Colour.DARK_GREEN;
      label = "START";
    }
    else if (type == ButtonType.END){
      colour = Colour.RED;
      highlight = Colour.DARK_RED;
      label = "END";
    }
    else if (type == ButtonType.EMPTY){
      colour = Colour.BLACK;
      highlight = Colour.DARK_GREY;
      label = "EMPTY";
    }
     else if (type == ButtonType.WALL){
      colour = Colour.BLUE;
      highlight = Colour.DARK_BLUE;
      label = "WALL";
    }
    else if (type == ButtonType.CHEESE){
      colour = Colour.ORANGE;
      highlight = Colour.DARK_ORANGE;
      label = "CHEESE";
    }
     else if (type == ButtonType.RESET){
      colour = Colour.GREY;
      highlight = Colour.RED;
      label = "RESET";
    }
    else if (type == ButtonType.READY){
      colour = Colour.GREEN;
      highlight = Colour.DARK_GREEN;
      label = "READY";
    }
  }
  
  Button(int xPos, int yPos, int xWidth, int yHeight,  int type) {
    this(xPos, yPos, type);
    this.xWidth = xWidth;
    this.yHeight = yHeight;
  }

  
  void draw() {
   pushMatrix();

   if (isMouseOverButton()){
     fill(highlight);
   }
   else {
     fill(colour);
   }
   
   if(isSelected){
     strokeWeight(5);
     stroke(Colour.RED);
   } else {
      strokeWeight(1);
      stroke(Colour.WHITE);  
    }
    rect(xPos, yPos, xWidth, yHeight);
    textAlign(CENTER, CENTER);
    textSize(yHeight * 0.5);
    fill(Colour.WHITE);
    text(label, xPos + (xWidth / 2), yPos + (yHeight / 2));
    
    popMatrix();
  }
    
  boolean isMouseOverButton(){
    if ((mouseX >= xPos) && (mouseX <= xPos + xWidth)){
      if ((mouseY >= yPos) && (mouseY <= yPos + yHeight)){
        return true;
      }
    }
    return false;
  }
}

public static class ButtonType {
   public static final int EMPTY = 0;
   public static final int WALL = 1;
   public static final int CHEESE = 2;
   public static final int START = 3;
   public static final int RESET = 4;
   public static final int END = 5;
   public static final int READY = 6;
}

public static class ButtonSize {
   public static final int WIDTH = 100;
   public static final int HEIGHT = 50;
   
}
