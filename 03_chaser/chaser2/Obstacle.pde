class Obstacle {
	public Obstacle(PVector pos) {
		this.pos = pos;
	}
	public Obstacle(int x, int y) {
		this.pos = new PVector(x, y);
	}
	public void draw() {
		fill(color);
		rect(pos.x, pos.y, LENGTH, LENGTH);
	}

	private PVector pos;
	private static final int LENGTH = 30;
	private static final int color = #000000;
}