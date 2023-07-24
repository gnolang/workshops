package counter

import (
	"io/ioutil"
	"strconv"
)

func IncrementCounter() (int, error) {
	counterBytes, err := ioutil.ReadFile("counter.txt")
	if err != nil {
		return 0, err
	}
	counter, err := strconv.Atoi(string(counterBytes))
	if err != nil {
		return 0, err
	}
	counter += 1 // HL
	err = ioutil.WriteFile("counter.txt", []byte(strconv.Itoa(counter)), 0644)
	if err != nil {
		return 0, err
	}
	return counter, nil
}
