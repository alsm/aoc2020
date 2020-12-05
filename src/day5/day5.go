package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io/ioutil"
	"sort"
	"strconv"
	"strings"
)

func main() {
	var seats []int
	data, _ := ioutil.ReadFile("day5.txt")
	lines := bufio.NewScanner(bytes.NewReader(data))
	for lines.Scan() {
		f := strings.Map(func(r rune) rune {
			switch r {
			case 'F', 'L':
				return '0'
			default:
				return '1'
			}
		}, lines.Text())
		v, _ := strconv.ParseInt(f, 2, 64)
		seats = append(seats, int(v))
	}
	sort.Ints(seats)

	fmt.Println(seats[len(seats)-1])
	for i, v := range seats[:len(seats)-2] {
		if seats[i+1]-v > 1 {
			fmt.Println(v + 1)
		}
	}
}
