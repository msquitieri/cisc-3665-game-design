/**
  * Agent.pde    23-oct-2011/sklar
  */
class Agent {

  PVector pos; // current (x,y) position of agent
  PVector vel; // current velocity of agent
  PVector acc; // current acceleration of agent
  int d = 30;  // diameter of the agent
  int max_x, max_y; // maximum x and y values for the agent (i.e., size of the arena)
  color mycolor; // the color for drawing the agent

  private Queue<Integer> movementQueue = new LinkedList<Integer>();

  /**
   * agent constructor
   */
  Agent( int x0, int y0, int c0 ) {
    max_x = x0;
    max_y = y0;
    mycolor = color( c0 );
    ellipseMode( CORNER );
    pos = new PVector( random(max_x-d), random(max_y-d) );
    vel = new PVector( 0, 0 );
    acc = new PVector( 0.5, 0.5 );
  } // end of agent constructor

  /**
   * reset()
   * resets the agent's position (to random) and velocity (to 0)
   */
  void reset() {
    pos.set( random( max_x-d ), random( max_y-d ), 0 );
    vel.set( 0, 0, 0 );
  } // end of reset()

  /**
   * getPos()
   * returns the agent's current (x,y) position
   */
  PVector getPos() {
    return( pos );
  } // end of getPos()

  /**
   * getDiameter()
   * returns the diameter of the agent
   */
  int getDiameter() {
    return( d );
  } // end of getDiameter()

  /**
   * draw()
   * this function draws the agent
   */
  void draw() {
    noFill();
    stroke( mycolor );
    strokeWeight( 3 );
    ellipse( pos.x, pos.y, d, d );
  } // end of draw()

  void move() {
    if (( pos.x+vel.x < 0 ) || ( pos.x+vel.x > max_x - d )) vel.x = -(vel.x);
    if (( pos.y+vel.y < 0 ) || ( pos.y+vel.y > max_y - d )) vel.y = -(vel.y);
    pos.x += vel.x;
    pos.y += vel.y;    
  }

  /**
   * kick()
   * adjusts the agent's velocity, as if it received a kick in the direction specified
   * by the "direction" argument
   */
  void kick( int direction ) {
    switch( direction ) {
    case NORTH:
      vel.y -= acc.y;
      break;
    case SOUTH:
      vel.y += acc.y;
      break;
    case WEST:
      vel.x -= acc.x;
      break;
    case EAST:
      vel.x += acc.x;
      break;
    } // end switch
  } // end of kick()

  /**
   * stop()
   */
  void stop() {
    vel.x = 0;
    vel.y = 0;
  } // end of stop()

  private List<Integer> getListOfAllDirections() {
    List<Integer> allDirections = new Vector<Integer>(4);

    allDirections.add(NORTH);
    allDirections.add(SOUTH);
    allDirections.add(EAST);
    allDirections.add(WEST);

    return allDirections;
  }

  private List<Integer> getListOfPossibleDirections(Obstacle collidedObstacle) {
    List<Integer> possibleDirections = getListOfAllDirections();
    
    // Must use new Integer(DIRECTION) to force the method 
    // List.remove(Object obj) and not List.remove(int index)
    if (collidedObstacle.hasTopCollisionWith(this)) { 
      println("Top collision!");
      possibleDirections.remove(new Integer(SOUTH));
    }
    if (collidedObstacle.hasBottomCollisionWith(this)) { 
      println("Bottom collision!");
      possibleDirections.remove(new Integer(NORTH));
    }
    if (collidedObstacle.hasLeftCollisionWith(this)) { 
      println("Left collision!");
      possibleDirections.remove(new Integer(EAST));
    }
    if (collidedObstacle.hasRightCollisionWith(this)) {
      println("Right collision!");
      possibleDirections.remove(new Integer(WEST));
    }

    return possibleDirections;
  }

  private PVector getVectorFromDirection(int direction) {
    PVector directionVector = null;

    if (direction == NORTH) directionVector = new PVector(0, -1);
    else if (direction == SOUTH) directionVector = new PVector(0, 1);
    else if (direction == EAST) directionVector = new PVector(1, 0);
    else if (direction == WEST) directionVector = new PVector(-1, 0);

    return directionVector;
  }

  Integer getRandomDirectionFromList(List<Integer> directions) {
    if (directions.size() == 0) return null;
    return directions.get((int)Math.floor(random(0, directions.size())));
  }

  Integer getBestDirectionFromList(List<Integer> directions, PVector opponent, Integer STEPS) {
    Map<Float, Integer> distanceToDirectionMap = new TreeMap<Float, Integer>();

    Float distance;
    PVector newPosition, newVelocity;
    for (Integer direction : directions) {
      newVelocity = getVectorFromDirection(direction);  
      newVelocity.mult(STEPS);

      newPosition = PVector.add(pos, newVelocity);

      distance = PVector.dist(newPosition, opponent);

      distanceToDirectionMap.put(distance, direction);
    }

    float min = Collections.min(distanceToDirectionMap.keySet());

    return distanceToDirectionMap.get(min);
  }

  /**
   * chase()
   * this function implements the "line of sight" algorithm from 
   * ch 2 of AI for Game Developers by Bourg and Sleemann (2004)
   */
  void chase( PVector opponent ) {

    if (movementQueue.peek() != null) {
      int direction = movementQueue.remove();
      vel = getVectorFromDirection(direction);
      return;
    }

    Obstacle collidedObstacle = getObstacleFromCollision(this);    
    if (collidedObstacle != null) {
      println("collided!!");

      final int STEPS = 30;
      List<Integer> possibleDirections = getListOfPossibleDirections(collidedObstacle);
      // int newDirection = getRandomDirectionFromList(possibleDirections);
      int newDirection = getBestDirectionFromList(possibleDirections, opponent, STEPS);

      for (int i=0; i<STEPS; i++) movementQueue.add(newDirection);

      if (newDirection == NORTH) {
        println("changing direction to NORTH");
      }
      else if (newDirection == SOUTH) { 
        println("changing direction to SOUTH");
      }
      else if (newDirection == EAST) { 
        println("changing direction to EAST");
      }
      else { 
        println("changing direction to WEST");
      }
        
    } else {
      // calculate "difference" vector between this agent and the opponent
      PVector diff = pos.sub( opponent,pos );
      // compute the distance between this agent and the opponent (magnitude of difference vector)
      float d = diff.mag();

      if ( d > 0 ) {
        // normalize difference vector
        diff.normalize();
        // adjust x and y velocity according to the difference vector
        vel = opponent.sub( diff, vel );
      }
    }
  } // end of chase()  
} // end of agent class
