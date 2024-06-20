type User struct {
	Name string
	Age  int
}
var users []User
users = append(users, User{"John Doe", 30})
for _, user := range users {
	/* logic */
}
