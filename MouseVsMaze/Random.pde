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
