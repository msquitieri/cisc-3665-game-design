class Point {
  public Point(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
  }

  public Point(int radius) {
  	this.x = getRandomX(radius);
  	this.y = getRandomY(radius);
  	this.radius = radius;
  }

	private int getRandomX(int radius) {
		int rand = ceil(random(width));

		// Take care of edge cases.
		if (rand < radius) rand += radius;
		if (rand-width >= 0 && rand-width <= radius) rand -= radius;

		return rand;  
	}

  private int getRandomY(int radius) {
	  int rand = ceil(random(height));

	  // Take care of edge cases.
	  if (rand < radius) rand += radius;
	  if (rand-height >= 0 && rand-height <= radius) rand -= radius;
	  
	  return rand;
  }

  public int x;
  public int y; 
  public int radius;
}
