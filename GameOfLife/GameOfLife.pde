final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
boolean paused = false;

void setup() {
  size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];

  //initialize grid by randomly giving a state to each cell
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      if (Math.random() < DENSITY) {
        grid[row][col] = 1;
      } else {
        grid[row][col] = 0;
      }
    }
  }
}

void draw() {
  if (!paused) {

    showGrid();
    grid = calcNextGrid();
  }
}


void keyPressed() {
  paused = !paused;
}

//determine if a cell will die or be born
int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      int neighbors = countNeighbors(row, col);
      if (grid[row][col] == 1 && (neighbors < 2 || neighbors > 3)) {
        nextGrid[row][col] = 0;
      } else if (grid[row][col] == 0 && neighbors == 3) {
        nextGrid[row][col] = 1;
      } else {
        nextGrid[row][col] = grid[row][col];
      }
    }
  }

  return nextGrid;
}


//figures out how many neighbors an alive cell has and if it should die or be born
int countNeighbors(int y, int x) {
  int n = 0; // don't count yourself!

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j<=1; j++) {
      int row = (y + i + grid.length) % grid.length;
      int col = (x + j + grid[0].length) % grid[0].length;
      n += grid[row][col];
    }
  }
  n -= grid[y][x];
  return n;
}


//shows the grid
void showGrid() {
  background(255);
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      if (grid[row][col] == 1) {
        fill(255, 0, 0);
      } else {
        fill(0);
      }
      rect(col * SPACING, row * SPACING, SPACING, SPACING);
    }
  }
}
