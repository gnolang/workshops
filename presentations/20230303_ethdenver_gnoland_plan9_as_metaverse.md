# Who am I?
 * Jae Kwon
 * 2014: Tendermint (BFT PoS), AIB
 * 2017: Cosmos, CosmosSDK, ICF
 * 2021: Gno


# Why Go?
 * simple spec
 * type-check safety
 * garbage-collected
 * object-oriented, but no inheritance
 * -> succinct intuitive programs!
 * --> more adoption!!


# e.g. diamond inheritance problem
 * Solidity and Python use "C3", but complex \
    https://forum.openzeppelin.com/t/solidity-diamond-inheritance/2694
 * Java doesn't support multiple inheritance
 * Go supports arbitrary struct embedding \
    simpler conflict resolution


# Go, but why Gno?
 * deterministic
 * intuitive VM
 * auto-persistence
 * auto-merklization


# Gno: intuitive VM.
 * EVM: \
  program code (solidity) -> \
    EVM bytecode (new low-level construct) -> \
      EVM implementation (C++/Go/Python/Rust)
 * GNOVM: \
  program code (Go) -> \
    Go AST (if, else, func, struct, etc) -> \
      GNOVM implementation (Go)


# Gno: auto-persisted
 * all values are persisted (unless gc)
 * no need for ORMs, DBs, or binary codecs
 * more succinct code


# Gno: auto-merkle-ized
 * tree structure defined by Gno impl \
    e.g. avl tree vs patricia trie in user-zone
 * permissionless IBC, e.g. "IBC2/GNO"


# Gno user-defined data-structures

```go
// gno.land/p/demo/avl/node.gno

// Node
type Node struct {
	key       string
	value     interface{}
	height    int8
	size      int
	leftNode  *Node
	rightNode *Node
}
```


# Gno vs Solidity vs CosmosSDK

In Gno, the following simple concept...

```go
// realm package gno.land/r/jaekwon/demo
// source code viewable there.

var x int

func Incr() {
	x += 1
}
```


# Gno vs Solidity
 * "Solidity is a curly-bracket language designed to target the Ethereum Virtual Machine (EVM)."
 * Solidity is still actively evolving
 * The most intuitive target is AST (not a bytecode VM)

```solidity
// contract 0x503b6dd2fc5b285cdfef...
// address, code, obfuscated.
pragma solidity ^0.8.17;

contract Primitives {
    bool int x = 0;

    function incr() public {
        x += 1;
    }
}
```


# Gno GRC720 example

```go
package grc721

type IGRC721 interface {
	BalanceOf(owner std.Address) (uint64, error)
	OwnerOf(tid TokenID) (std.Address, error)
	SafeTransferFrom(from, to std.Address, tid TokenID) error
	TransferFrom(from, to std.Address, tid TokenID) error
	Approve(approved std.Address, tid TokenID) error
	SetApprovalForAll(operator std.Address, approved bool) error
	GetApproved(tid TokenID) (std.Address, error)
	IsApprovedForAll(owner, operator std.Address) bool
}
```


# Gno vs CosmosSDK
 * "ctx"
 * determinism
 * keeper/handler pattern
 * binary codec (no ORM)

```go
// cli/cli.go
// msg.go
// handler.go
// keeper.go  <-- here
//  * with binary encoding/decoding of x.
//  * no 'x' variable.
//  * could use Amino-based object store.

type Keeper struct {
	// expected to be prefix store.
	storeKey               storetypes.StoreKey
}

func (k *Keeper) Incr(sdk.Context) {
	store := ctx.KVStore(k.storeKey)
	bz := store.Get("x")
	if bz == nil {
		panic("XXX")
	}
	x, err := strconv.Atoi(bz)

	x += 1 // all we wanted

	if err != nil {
		panic("XXX")
	}
	bz = strconv.Itoa(x)
	store.Set("x", bz)
}
```


# Gno for social applications

```go
// from gno.land/r/demo/boards/post.gno

// A Post is a "thread" or a "reply" depending on context.
// A thread is a Post of a Board that holds other replies.
type Post struct {
	board       *Board
	id          PostID
	creator     std.Address
	title       string // optional
	body        string
	replies     avl.Tree // Post.id -> *Post
	repliesAll  avl.Tree // Post.id -> *Post (all replies, for top-level posts)
	reposts     avl.Tree // Board.id -> Post.id
	threadID    PostID   // original Post.id
	parentID    PostID   // parent Post.id (if reply or repost)
	repostBoard BoardID  // original Board.id (if repost)
	createdAt   time.Time
	updatedAt   time.Time
}
```


# Gno vs Gno.land
 * Gno == language
 * Gno.land == GnoVM + Tendermint2
 * available as ICS consumer zones too


# GNOVM license model
 * Copyleft but with strong attribution
 * Strong attribution in code and main README
 * Link back to Gno.land from your main interface for X years
 * -> your success is our success
 * Your GNO contracts are licensed how you want


# Gno.land vs Plan9
 * Plan9 (since late 1980s): \
    Rob Pike, Ken Thompson, Dave Presotto, and Phil Winterbottom
 * Go (2017): \
    Robert Griesemer, Rob Pike and Ken Thompson


# What is a "metaverse"?
 * a virtual world?
 * a _persistent_ virtual world.
 * substrate should be language+logic (logos).
 * logos completeness theorem: \
   logos -> physics -> logos -> physics...


# Gno.land is Plan9 as metaverse
 * UNIX: everything is a file
 * PLAN9: UNIX + pervasive network
 * GNO.LAND: everything is a Go object + IBC

# Governance
 * focus on expertise and values
 * -> remove financial incentives!
 * tiers of members
 * top tier has sufficient (1) contributions, (2) expertise, and (3) values
 * $GNOT: a fee token with self governance 


# Action Items
 * follow github.com/gnolang/gno
 * visit gno.land
 * help us create "Game of Realms"
 * contribute!
