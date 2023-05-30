// user-defined data-structures
// gno.land/p/demo/avl/node.gno
package avl // OMIT

type Node struct { // HL
	key       string
	value     interface{}
	height    int8
	size      int
	leftNode  *Node
	rightNode *Node
}
