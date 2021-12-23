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

	part2 := playGameDirac(player1Start, player2Start)
	fmt.Println("Part 2: ", part2)
}

func playGameDirac(player1Start int, player2Start int) int64 {
	player1 := Player{id: 1, start: player1Start, position: player1Start, score: 0}
	player2 := Player{id: 2, start: player2Start, position: player2Start, score: 0}
	result := takeTurn(make(map[string]Result), 0, []Player{player1, player2})
	if result.p1Wins > result.p2Wins {
		return result.p1Wins
	} else {
		return result.p2Wins
	}
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
	player.position = modStartAt1(player.position, 10)
	player.score += player.position
	//fmt.Printf("Player turn %d, rolled %d, position %d, score: %d, die rolls %d\n", player.id, rolled, player.position, player.score, die.rolls)
}

func playerTurnDirac(player *Player, roll int) {
	player.position += roll
	player.position = modStartAt1(player.position, 10)
	player.score += player.position
}

type Result struct {
	p1Wins int64
	p2Wins int64
}

func takeTurn(memo map[string]Result, playerTurn int, players []Player) Result {
	key := makeKey(
		playerTurn,
		players[0].score,
		players[0].position,
		players[1].score,
		players[1].position)
	val, ok := memo[key]
	if ok {
		return val
	}

	result := Result{p1Wins: 0, p2Wins: 0}

	for _, roll := range diracRollOptions() {
		p1 := players[0]
		p2 := players[1]

		if playerTurn == 0 {
			playerTurnDirac(&p1, roll)
			if playerHasWonDirac(&p1) {
				result.p1Wins += 1
			} else {
				tempResult := takeTurn(memo, (playerTurn+1)%2, []Player{p1, p2})
				result.p1Wins += tempResult.p1Wins
				result.p2Wins += tempResult.p2Wins
			}
		} else {
			playerTurnDirac(&p2, roll)
			if playerHasWonDirac(&p2) {
				result.p2Wins += 1
			} else {
				tempResult := takeTurn(memo, (playerTurn+1)%2, []Player{p1, p2})
				result.p1Wins += tempResult.p1Wins
				result.p2Wins += tempResult.p2Wins
			}
		}
	}
	memo[key] = result
	return result
}

func makeKey(playerTurn int, p1Score int, p1Pos int, p2Score int, p2Pos int) string {
	return fmt.Sprintf(
		"%d %d %d %d %d",
		playerTurn,
		p1Score,
		p1Pos,
		p2Score,
		p2Pos,
	)
}

func playerHasWon(player *Player) bool {
	return player.score >= 1000
}

func playerHasWonDirac(player *Player) bool {
	return player.score >= 21
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

func diracRollOptions() []int {
	return []int{3, 4, 5, 4, 5, 6, 5, 6, 7, 4, 5, 6, 5, 6, 7, 6, 7, 8, 5, 6, 7, 6, 7, 8, 7, 8, 9}
}

type DiracDie struct {
	rollOptions []int
}

func (die *Die) roll() int {
	roll := die.value
	die.value += 1
	die.rolls += 1
	die.value = modStartAt1(die.value, 100)
	return roll
}

func modStartAt1(n int, m int) int {
	return (((n + m) - 1) % m) + 1
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
