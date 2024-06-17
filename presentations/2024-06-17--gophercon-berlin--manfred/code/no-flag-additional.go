type Node struct {
	Value int
	Next  *Node
}
mypackage.ProcessNode(&Node{Value: 1, Next: &Node{Value: 2}})
