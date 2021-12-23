package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
)

func main() {
	lines := readInput()
	player1Start, player2Start := parseInput(lines)

	fmt.Printf("player 1 start: %d\n", player1Start)
	fmt.Printf("player 1 start: %d\n", player2Start)

	part1 := playGame(player1Start, player2Start)

	fmt.Println("Part 1: ", part1)
}

func playGame(player1Start int, player2Start int) int {
	player1 := Player{id: 1, start: player1Start, position: player1Start, score: 0}
	player2 := Player{id: 2, start: player2Start, position: player2Start, score: 0}
	die := Die{value: 1}

	part1 := 0
	for true {
		playerTurn(&player1, &die)
		if playerHasWon(&player1) {
			part1 = player2.score * die.rolls
			break
		}
		playerTurn(&player2, &die)
		if playerHasWon(&player2) {
			part1 = player1.score * die.rolls
			break
		}
	}

	return part1
}

func playerTurn(player *Player, die *Die) {
	rolled := 0
	for i := 0; i < 3; i++ {
		roll := die.roll()
		rolled += roll
		player.position += roll
	}
	player.position = player.position % 10
	if player.position == 0 {
		player.score += 10
	} else {
		player.score += player.position
	}

	//fmt.Printf("Player turn %d, rolled %d, position %d, score: %d, die rolls %d\n", player.id, rolled, player.position, player.score, die.rolls)
}

func playerHasWon(player *Player) bool {
	return player.score >= 1000
}

type Player struct {
	id       int
	start    int
	position int
	score    int
}

type Die struct {
	value int
	rolls int
}

func (die *Die) roll() int {
	roll := die.value
	die.value += 1
	die.rolls += 1
	if die.value > 100 {
		die.value = 1
	}
	return roll
}

func parseInput(lines []string) (int, int) {
	player1Start, err := strconv.Atoi(strings.Split(lines[0], " ")[4])
	if err != nil {
		log.Fatal(err)
	}
	player2Start, err := strconv.Atoi(strings.Split(lines[1], " ")[4])
	if err != nil {
		log.Fatal(err)
	}
	return player1Start, player2Start
}

func readInput() []string {
	content, err := ioutil.ReadFile("input/day21.txt")
	if err != nil {
		log.Fatal(err)
	}
	return strings.Split(string(content), "\n")
}
