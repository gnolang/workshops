package tamagochi

// Tamagotchi structure
type Tamagotchi struct {
	hunger    int
	happiness int
	health    int
}

func (t *Tamagotchi) Feed() {
	t.updateStats()
	if t.dead() {
		return
	}
	t.hunger = bound(t.hunger-10, 0, 100)
}

func (t *Tamagotchi) Heal() { /* ...  */ }

func (t *Tamagotchi) Play() { /* ...  */ }
