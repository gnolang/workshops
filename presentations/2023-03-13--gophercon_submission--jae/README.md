_NOTE: This speaker application is unusual, as it doesn't allow identifying
information_

# The Go Metaverse

## Elevator Pitch

Imagine a Go VM/interpreter that persists all values. (a new paradigm with no
DBs or ORMs)

Imagine if it were deterministic. (for replication & accountability)

Imagine interpreting the AST directly instead of bytecode. (intuitive, written
in Go)

Now slap it on a BFT ledger. (suddenly metaverse!)

## Description

The metaverse is already here, and its foundation is Go.

Most programming language (implementations) have been designed with two
assumptions that no longer hold.

The first assumption is that we need separation between RAM and persistent
storage; But memristors are like persistent RAM, and while a nascent
technology, the need for memristors in the field of AI for energy efficiency
will ensure its adoption. If there is no separation between RAM and disk, then
values (structs, arrays, primitives) persist by default. We will no longer need
databases (SQL or NoSQL) and also no ORMs. If in Unix & Plan9 “everything is a
file”, in the new paradigm “everything is a value”. This opens the door to a
new ecosystem of code optimized for the new memristor world.

The second assumption is that determinism isn’t important in programming
languages. In the past, few applications besides multiplayer game programming
required complete determinism. Our CPUs weren’t designed with determinism in
mind, so floating point non-determinism would cause issues across multiple
players on different architectures unless special care was taken. Now, web3
blockchain application programming requires determinism, but few VM/languages
provide the needed determinism. The EVM does, but it isn’t suitable for general
programming. WASM is now mostly deterministic, driven by web3 development, but
still doesn’t support determinism in threads. With threads and multicore CPUs,
determinism is even more difficult to achieve (but not impossible).

We present a novel virtual machine designed with auto-persisting and
determinism in mind, written in Go, for interpreting Go. This VM/interpreter is
not only suitable for general/web2 programming, it is also suitable for
replicated execution. When applied in the dapp/smart-contract context, it
becomes the foundation for a logic/language metaverse; where a struct{} is not
just a transient object in RAM, but an immortal persistent virtual object.

Furthermore, the design and implementation of this VM is intended to be as
intuitive as possible. The VM is not based on byte-code such as most VMs, but
the abstract syntax tree (AST) of Go itself, allowing the inner workings of the
machine to be accessible to all Go developers. This lets the VM serve as a
production-ready reference implementation, and basis for further innovation and
optimization.

## Notes

The VM exists and works; We can run a demo.

In terms of technical details, Goroutines are not yet supported but will be
soon. In the meantime, most of the rest of the Go spec is implemented and
passes the Yaegi test suite.

We have also created a multi-billion dollar ecosystem that uses other
code/projects we wrote in Go. Two of these projects have over 5k stars each.

