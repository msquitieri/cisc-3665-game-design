/**
 * tileworld0.pde
 *
 * This program simulates a simplified version of the class TileWorld.
 * This code was written to be used as a skeleton for Assignment II for
 * CISC 3665 / Game Design (created by prof sklar).
 */

int min_x = 0;
int min_y = 0;
int max_x = 400;
int max_y = 600;
int grid_size = 10;

PVector agent = getRandomLoc();
PVector hole = getRandomLoc();
PVector tile = getRandomLoc();
PVector obstacle = getRandomLoc();


// agent state variables
int STOPPED = 0;
int RUNNING = 1;
int agentState = STOPPED;



/**
 * setup()
 * this function is called once, when the sketch starts up.
 */
void setup() {
  size( max_x, max_y );
  ellipseMode( CORNER );
  agentState = RUNNING;
} // end of setup()



/**
 * draw()
 * this function is called by the Processing "draw" loop,
 * i.e., every time the display window refreshes.
 */
void draw() {
  // draw grid for TileWorld
  background( #ffffff );
  stroke( #cccccc );
  for ( int x=min_x; x<max_x; x+=grid_size ) {
    line( x,min_y,x,max_y-1 );
  }
  for ( int y=min_y; y<max_y; y+=grid_size ) {
    line( min_x,y,max_x-1,y );
  }
  // draw obstacle
  stroke( #cccccc );
  fill( #cccccc );
  rect( obstacle.x, obstacle.y, grid_size, grid_size );
  // draw hole
  stroke( #cccccc );
  fill( #000000 );
  rect( hole.x, hole.y, grid_size, grid_size );
  // draw tile
  stroke( #cccccc );
  fill( #cc00cc );
  rect( tile.x, tile.y, grid_size, grid_size );
  noFill();
  // draw agent
  if ( agentState == RUNNING ) {
    makeRandomMove();
  }
  stroke( #0000ff );
  fill( #0000ff );
  ellipse( agent.x, agent.y, grid_size, grid_size );
} // end of draw()


/**
 * mouseClicked()
 * this function responds to "mouse click" events.
 */
void mouseClicked() {
  if ( agentState == STOPPED ) {
    agentState = RUNNING;
  }
  else {
    agentState = STOPPED;
  }
} // end of mouseClicked()


/**
 * getRandomLoc()
 * this function returns a new PVector set to a random discrete location
 * in the grid.
 */
PVector getRandomLoc() {
  return( new PVector(
  ((int)random(min_x,max_x)/grid_size)*grid_size,
  ((int)random(min_y,max_y)/grid_size)*grid_size ));
} // end of getRandomLoc()


/**
 * makeRandomMove()
 * this function causes the agent to move randomly (north, south, east or west).
 * if the agent reaches the edge of its world, it wraps around.
 */
void makeRandomMove() {
  int direction = (int)random( 0,4 );
  switch( direction ) {
  case 0: // north
    agent.y -= grid_size;
    if ( agent.y < min_y ) {
      agent.y = max_y - grid_size;
    }
    break;
  case 1: // west
    agent.x -= grid_size;
    if ( agent.x < min_x ) {
      agent.x = max_x - grid_size;
    }
    break;
  case 2: // south
    agent.y += grid_size;
    if ( agent.y >= max_y ) {
      agent.y = min_y;
    }
    break;
  case 3: // east
    agent.x += grid_size;
    if ( agent.x >= max_x ) {
      agent.x = min_x;
    }
    break;
  } // end of switch
} // end of makeRandomMove()

