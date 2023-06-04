package demo // OMIT
import "strings" // OMIT
func greetings(name string) string { // private
	return "Welcome, " + name + "!"
}

func Render(path string) string {
	switch {
	case path == "hello":
		return "world!"
	case strings.HasPrefix(path, "greetings/"):
		name := strings.Split(path, "/")[1] // take string after slash
		name = strings.Title(name)          // capitalize first letter
		return greetings(name)
	}
	return "404"
}
