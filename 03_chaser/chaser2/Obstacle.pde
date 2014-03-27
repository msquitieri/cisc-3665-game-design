class Obstacle {
  public Obstacle(PVector pos) {
    this.pos = pos;
  }
  public Obstacle(int x, int y) {
    this.pos = new PVector(x, y);
  }
  public PVector getPos() { return pos; }
  public void draw() {
    noStroke();
    fill(COLOR);
    rect(pos.x, pos.y, LENGTH, LENGTH);
  }
  public int hashCode() { return pos.hashCode(); }
  public boolean equals(Object obj) {
    boolean result = false;
    if (obj instanceof Obstacle) {
      Obstacle obstacle = (Obstacle) obj;
      result = obstacle.getPos().equals(pos);
    }
    return result;
  }
  public boolean hasCollisionWith(Agent agent) {
    return !(noLeftCollision(agent) || noRightCollision(agent) || noTopCollision(agent) || noBottomCollision(agent));
  }
  private boolean noRightCollision(Agent agent) {
    float obstacleRight = pos.x + LENGTH;
    float agentLeft = agent.getPos().x;

    return obstacleRight < agentLeft;
  }
  private boolean noTopCollision(Agent agent) {
    float agentBottom = agent.getPos().y + agent.getDiameter();
    float obstacleTop = pos.y;

    return obstacleTop > agentBottom;
  }
  private boolean noBottomCollision(Agent agent) {
    float agentTop = agent.getPos().y;
    float obstacleBottom = pos.y + LENGTH;

    return obstacleBottom < agentTop;
  }
  private boolean noLeftCollision(Agent agent) {
    float obstacleLeft = pos.x;
    float agentRight = agent.getPos().x + agent.getDiameter();

    return obstacleLeft > agentRight;
  }

  public boolean hasLeftCollisionWith(Agent agent) {
    float obstacleLeft = pos.x;
    float agentRight = agent.getPos().x + agent.getDiameter();

    return (abs(obstacleLeft - agentRight) < agent.getDiameter()/2);
  }
  public boolean hasRightCollisionWith(Agent agent) {
    float obstacleRight = pos.x + LENGTH;
    float agentLeft = agent.getPos().x;

    return (abs(obstacleRight - agentLeft) < agent.getDiameter()/2);
  }
  public boolean hasTopCollisionWith(Agent agent) {
    float agentBottom = agent.getPos().y + agent.getDiameter();
    float obstacleTop = pos.y;

    return (abs(obstacleTop - agentBottom) < agent.getDiameter()/2);
  }
  public boolean hasBottomCollisionWith(Agent agent) {
    float agentTop = agent.getPos().y;
    float obstacleBottom = pos.y + LENGTH;

    return (abs(obstacleBottom - agentTop) < agent.getDiameter()/2);
  }

  private PVector pos;
  private static final int LENGTH = 30;
  private static final int COLOR = #000000;
}
