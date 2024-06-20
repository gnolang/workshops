func main() {
	flag.StringVar(&myStringFlag, "stringFlag", "default", "usage")
	flag.IntVar(&myIntFlag, "intFlag", 0, "usage")
	flag.Parse()
	MyFunc(*myStringFlag, *myIntFlag)
}

$> myprogram --stringFlag foo --intFlag 42
