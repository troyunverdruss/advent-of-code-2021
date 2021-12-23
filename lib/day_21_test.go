package main

import "testing"

func Test_playGame(t *testing.T) {
	type args struct {
		player1Start int
		player2Start int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"one", args{4, 8}, 739785},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := playGame(tt.args.player1Start, tt.args.player2Start); got != tt.want {
				t.Errorf("playGame() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_modStartAt1(t *testing.T) {
	type args struct {
		n int
		m int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"1", args{1, 10}, 1},
		{"10", args{10, 10}, 10},
		{"11 => 1", args{11, 10}, 1},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := modStartAt1(tt.args.n, tt.args.m); got != tt.want {
				t.Errorf("modStartAt1() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_playGameDirac(t *testing.T) {
	type args struct {
		player1Start int
		player2Start int
	}
	tests := []struct {
		name string
		args args
		want int64
	}{
		{"part 2 example", args{player1Start: 4, player2Start: 8}, 444356092776315},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := playGameDirac(tt.args.player1Start, tt.args.player2Start); got != tt.want {
				t.Errorf("playGameDirac() = %v, want %v", got, tt.want)
			}
		})
	}
}
