package setup

import "time"

func Render(_ string) string {
	return time.Now().String()
}
