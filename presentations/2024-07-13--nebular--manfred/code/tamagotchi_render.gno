package tamagochi

var tam Tamagochi

// Interaction function ...

func Render(path string) string {
	switch {
	case tam.Health() == 0:
		return "😵" // dead face
	case tam.Health() < 30:
		return "😷" // sick face
	case tam.Happiness() < 30:
		return "😢" // sad face
	case tam.Hunger() > 70:
		return "😫" // hungry face
	default:
		return "😃" // happy face
	}
}
