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
		{"one", args{4,8}, 739785},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := playGame(tt.args.player1Start, tt.args.player2Start); got != tt.want {
				t.Errorf("playGame() = %v, want %v", got, tt.want)
			}
		})
	}
}
