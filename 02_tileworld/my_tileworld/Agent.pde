class Agent {
  public Agent(PVector pos) {
    this.pos = pos;
  }
  public Agent(int x, int y) {
    pos = new PVector(x, y);
  }
  public boolean isRunning() { return isRunning; }
  public void setRational(boolean b) { isRational = b; }
  public boolean isRational() { return isRational; }
  public void run() { isRunning = true; }
  public void stop() { isRunning = false; }
  public void move() {
    perceive();
    makeRandomMove();
  }
  private void incrementScore() { score++; }

  private void perceive() {
    tileSensor.update(pos, tiles);
    holeSensor.update(pos, holes);
    obstacleSensor.update(pos, obstacles);
  }

  private void moveNorth() {
    if (obstacleSensor.north == 1) return;
    if (tileSensor.north == 1 && (obstacleSensor.north == 2 || tileSensor.northSet.contains(2))) return;
    if (isRational && holeSensor.north == 1) return;

    // move tile north
    if (tileSensor.north == 1) {
      float y = pos.y-grid_size;
      if (y < min_y) y = max_y - grid_size;

      PVector tilePosition = new PVector(pos.x, y);

      tiles.remove(tilePosition);

      tilePosition.sub(0, grid_size, 0);
      if (tilePosition.y < min_y) tilePosition.y = max_y - grid_size;

      tiles.add(tilePosition);

      // Check if tile went into hole.
      if (holes.contains(tilePosition)) dropTileIntoHole(tilePosition);
    }

    agent.pos.y -= grid_size;
    if ( agent.pos.y < min_y ) {
      agent.pos.y = max_y - grid_size;
    }
  }
  private void moveEast() {
    if (obstacleSensor.east == 1) return;
    if (tileSensor.east == 1 && (obstacleSensor.east == 2 || tileSensor.eastSet.contains(2))) return;
    if (isRational && holeSensor.east == 1) return;

    // move tile east
    if (tileSensor.east == 1) {
      float x = pos.x+grid_size;
      if (x >= max_x) x = min_x;

      PVector tilePosition = new PVector(x, pos.y);

      tiles.remove(tilePosition);

      tilePosition.add(grid_size, 0, 0);
      if (tilePosition.x >= max_x) tilePosition.x = min_x;

      tiles.add(tilePosition);

      // Check if tile went into hole.
      if (holes.contains(tilePosition)) dropTileIntoHole(tilePosition);
    }

    agent.pos.x += grid_size;
    if ( agent.pos.x >= max_x ) {
      agent.pos.x = min_x;
    }
  }
  private void moveWest() {
    if (obstacleSensor.west == 1) return;
    if (tileSensor.west == 1 && (obstacleSensor.west == 2 || tileSensor.westSet.contains(2))) return;

    if (isRational && holeSensor.west == 1) return;

    // move tile west
    if (tileSensor.west == 1) {
      float x = pos.x-grid_size;
      if (x < min_x) x = max_x - grid_size;

      PVector tilePosition = new PVector(x, pos.y);

      tiles.remove(tilePosition);

      tilePosition.sub(grid_size, 0, 0);
      if (tilePosition.x < min_x) tilePosition.x = max_x - grid_size;

      tiles.add(tilePosition);

      // Check if tile went into hole.
      if (holes.contains(tilePosition)) dropTileIntoHole(tilePosition);
    }

    agent.pos.x -= grid_size;
    if ( agent.pos.x < min_x ) {
      agent.pos.x = max_x - grid_size;
    }
  }
  private void moveSouth() {
    if (obstacleSensor.south == 1) return;
    if (tileSensor.south == 1 && (obstacleSensor.south == 2 || tileSensor.southSet.contains(2))) return;

    if (isRational && holeSensor.south == 1) return;

    // move tile south
    if (tileSensor.south == 1) {
      float y = pos.y+grid_size;
      if (y >= max_y) y = min_y;

      PVector tilePosition = new PVector(pos.x, y);

      tiles.remove(tilePosition);

      tilePosition.add(0, grid_size, 0);
      if (tilePosition.y >= max_y) tilePosition.y = min_y;

      tiles.add(tilePosition);

      // Check if tile went into hole.
      if (holes.contains(tilePosition)) dropTileIntoHole(tilePosition);
    }

    agent.pos.y += grid_size;
    if ( agent.pos.y >= max_y ) {
      agent.pos.y = min_y;
    }
  }

  private void dropTileIntoHole(PVector position) {
    holes.remove(position);
    tiles.remove(position);

    incrementScore();
  }

  private void move(int direction) {
    if (direction == NORTH) moveNorth();
    else if (direction == WEST) moveWest();
    else if (direction == SOUTH) moveSouth();
    else if (direction == EAST) moveEast();
  }

  private void makeRandomMove() {
    int direction = (int)random( 0,4 );
    move(direction);
  } // end of makeRandomMove()

  public PVector pos;
  public int score = 0;
  private boolean isRunning;
  private boolean isRational = true;

  private Sensor tileSensor      = new Sensor(3, 3, 3, 3);
  private Sensor holeSensor      = new Sensor(3, 3, 3, 3);
  private Sensor obstacleSensor  = new Sensor(3, 3, 3, 3);

  private static final int NORTH = 0;
  private static final int WEST  = 1;
  private static final int SOUTH = 2;
  private static final int EAST  = 3;
}