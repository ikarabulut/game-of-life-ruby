# Game of Life README

## Requirements

- Latest Ruby Version
  - To check if you have ruby run `ruby -v` in your terminal app

### To download Ruby using rbenv:

- Install `rbenv` (ruby version manager) by running `brew install rbenv` in your terminal. If you need homebrew please follow these directions -> https://brew.sh/
- Once `rbenv` is installed run `rbenv install 3.0.3` to download the latest version.

## What is Conways Game of Life?

Conway’s Game of Life (GoL) is what is known as a zero-player game based on a system called a cellular automation. A player sets up an initial pattern on a board, based on alive or dead cells, and the board evolves through a series of generations.

The game is based on 4 simple rules:

1. If a living cell has less than two living neighbors, it is dead in the next generation, as if by underpopulation.

2. If a living cell has two or three living neighbors, it stays alive in the next generation.

3. If a living cell has more than three living neighbors, it is dead in teh next generation, as if by overcrowding.

4. If a dead cell has exactly three living neighbors, it comes to life in the next generation

Each evolution will run through these above rules and will determine the state of the world in the next generation.

## How to run the program

1. Clone down the repo by running `git clone https://github.com/ikarabulut/game-of-life-ruby.git`
2. `cd` into `game-of-life-ruby`

### To run the program

- run `rake run`
- Follow the prompts
- If you run infinity loops you need to enter `ctrl + c` to quit

### To run all tests

- run `bin/test`
