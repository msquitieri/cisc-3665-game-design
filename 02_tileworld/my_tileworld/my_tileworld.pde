/**
 * tileworld0.pde
 *
 * This program simulates a simplified version of the class TileWorld.
 * This code was written to be used as a skeleton for Assignment II for
 * CISC 3665 / Game Design (created by prof sklar).
 */

import java.util.HashSet;

int min_x = 0;
int min_y = 0;
int max_x = 400;
int max_y = 600;
int grid_size = 20;
int footer_length = 100;
int i = 0;

boolean isGameOver = false;
  
HashSet<PVector> holes = new HashSet<PVector>();
HashSet<PVector> tiles = new HashSet<PVector>();
HashSet<PVector> obstacles = new HashSet<PVector>();

Agent agent = new Agent(getRandomNewLoc());

/**
 * setup()
 * this function is called once, when the sketch starts up.
 */
void setup() {
  size( max_x, max_y+footer_length );
  ellipseMode( CORNER );
  agent.run();

  for (int i=0; i<40; i++) {
    holes.add(getRandomNewLoc());
    tiles.add(getRandomNewLoc());
    obstacles.add(getRandomNewLoc());
  }

} // end of setup()

/**
 * draw()
 * this function is called by the Processing "draw" loop,
 * i.e., every time the display window refreshes.
 */

void drawGrid() {
  stroke( #cccccc );
  for ( int x=min_x; x<max_x; x+=grid_size ) {
    line( x,min_y,x,max_y-1 );
  }
  for ( int y=min_y; y<max_y; y+=grid_size ) {
    line( min_x,y,max_x-1,y );
  }
}

void drawObjectsWithColor(HashSet<PVector> objects, int hue) {
  stroke(#cccccc);
  fill(hue);

  for (PVector obj : objects) {
    rect(obj.x, obj.y, grid_size, grid_size);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') agent.setRational(!agent.isRational());
}

void draw() {
  // draw grid for TileWorld
  background( #ffffff );
  drawGrid();
  // draw obstacle
  drawObjectsWithColor(obstacles, #cccccc);
  drawObjectsWithColor(tiles, #cc00cc);
  drawObjectsWithColor(holes, #000000);

  noFill();
  // draw agent
  if (agent.isRunning()) {
    // Change i to only move every ith frame.
    if (i == 0) {
      agent.move();
      if (holes.contains(agent.pos)) {
        gameOver();
      }
      i = 0;
    } else i++;
  }
  stroke( #0000ff );
  fill( #0000ff );
  ellipse( agent.pos.x, agent.pos.y, grid_size, grid_size );

  if (isGameOver) drawMessage("Game Over!");
  else drawMessage("Score: $" + agent.score+"\nBehaving Rational: " + agent.isRational());
} // end of draw()

void drawMessage(String message) {
  stroke(#000000);
  textSize(20);
  text(message, 10, max_y+footer_length/3);
}

void gameOver() {
  agent.stop();
  isGameOver = true;
}

void gameReset() {
  isGameOver = false;
  agent.score = 0;
  agent.run();
}

/**
 * mouseClicked()
 * this function responds to "mouse click" events.
 */
void mouseClicked() {
  gameReset();
} // end of mouseClicked()


/**
 * getRandomNewLoc()
 * this function returns a new PVector set to a random discrete location
 * in the grid.
 */
PVector getRandomNewLoc() {
  PVector newLocation;

  do {
    int x = ((int)random(min_x,max_x)/grid_size)*grid_size;
    int y = ((int)random(min_y,max_y)/grid_size)*grid_size;

    newLocation = new PVector(x, y);
  } while (holes.contains(newLocation) || tiles.contains(newLocation) || obstacles.contains(newLocation));

  return newLocation;
} // end of getRandomNewLoc()
