class Sensor {
  public Sensor(int north_sight, int east_sight, int south_sight, int west_sight) {
    NORTH_SIGHT = north_sight;
    EAST_SIGHT = east_sight;
    SOUTH_SIGHT = south_sight;
    WEST_SIGHT = west_sight;

    // Keeps track of CLOSEST object in those directions.
    north = east = south = west = 0;
    // Keeps track of EVERY object within *_SIGHT.
    northSet = new HashSet<Integer>();
    eastSet = new HashSet<Integer>();
    westSet = new HashSet<Integer>();
    southSet = new HashSet<Integer>();
  }

  public void update(PVector currentPosition, HashSet<PVector> toSense) {
    resetSensors();
    updateNorth(currentPosition, toSense);
    updateEast(currentPosition, toSense);
    updateSouth(currentPosition, toSense);
    updateWest(currentPosition, toSense);
  }

  private void resetSensors() {
    north = east = south = west = 0;
    northSet.clear();
    eastSet.clear();
    southSet.clear();
    westSet.clear();
  }

  private void updateNorth(PVector pos, HashSet<PVector> toSense) {
    PVector toTest;
    int y;

    for (int i=1; i<=NORTH_SIGHT; i++) {
      y = (int)pos.y - (i*grid_size);

      if (y < min_y) y = max_y - abs(y);
      toTest = new PVector(pos.x, y);

      if (toSense.contains(toTest)) {
        if (this.north == 0) this.north = i;
        this.northSet.add(i);
      }
    }
  }

  private void updateEast(PVector pos, HashSet<PVector> toSense) {
    PVector toTest;
    int x;

    for (int i=1; i<=EAST_SIGHT; i++) {
      x = (int)pos.x + (i*grid_size);

      if (x >= max_x) {
        int steps = ((x - max_x)/grid_size);
        x = min_x + (steps*grid_size);
      }

      toTest = new PVector(x, pos.y);

      if (toSense.contains(toTest)) {
        if (this.east == 0) this.east = i;
        this.eastSet.add(i);
      }
    }
  }

  private void updateSouth(PVector pos, HashSet<PVector> toSense) {
    PVector toTest;
    int y;

    for (int i=1; i<=SOUTH_SIGHT; i++) {
      y = (int)pos.y + (i*grid_size);
      if (y >= max_y) {
        int steps = (y - max_y)/grid_size;
        y = min_y + (steps * grid_size);
      }

      toTest = new PVector(pos.x, y);

      if (toSense.contains(toTest)) {
        if (this.south == 0) this.south = i;
        this.southSet.add(i);
      }
    }
  }

  private void updateWest(PVector pos, HashSet<PVector> toSense) {
    PVector toTest;
    int x;

    for (int i=1; i<=WEST_SIGHT; i++) {
      x = (int)pos.x - (i*grid_size);

      if (x < min_x) x = max_x - abs(x);

      toTest = new PVector(x, pos.y);

      if (toSense.contains(toTest)) {
        if (this.west == 0) this.west = i;
        this.westSet.add(i);
      }
    }
  }

  // public String toString() { return "(" + north + ", " + east + ", " + south + ", " + west + ")"; }
  public String toString() { return northSet + "\n" + eastSet + "\n" + southSet + "\n" + westSet + "\n"; }
  public int north, east, south, west;
  public HashSet<Integer> northSet, eastSet, southSet, westSet;

  private int NORTH_SIGHT, EAST_SIGHT, SOUTH_SIGHT, WEST_SIGHT;
}