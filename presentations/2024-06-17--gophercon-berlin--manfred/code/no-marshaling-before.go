func SomeHandler(w http.ResponseWriter, r *http.Request) {
	data := MyStruct{Field: "value"} // go logic
	_, err := json.NewEncoder(w).Encode(data)
}
