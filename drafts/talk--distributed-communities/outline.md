Title: **Distributed communities: how to build timeless and decentralized apps, with Go**

Outline:

>Gno is a programming language to build decentralized and distributed applications, like blogs, discussion boards and social networks. Paired with gno.land, it can be used to launch these, with minimal effort.
>
>Join us as we present how you can use Gno and example use cases. TODO
## 1. Project presentation

Present the project, how it works, what it aims to do.

- What is Gno?
	- Showcase of what has been built: blog, boards, microblog, social, gnoverflow; delving into snippets of code, and showing how a simple thing gets built, rendered, and called.
- Gno tooling
	- Showcase of gnodev, gno repl, gno debugger; how we can use it to work on a blog realm; gnobro, etc.
- Gno realms as out-of-the-box GRPC + gno.land as AWS
	- Show how we can call other realms just by calling them as functions; but these are applications with state, and this is somewhat similar to calling them using GRPC.
	- To deploy these realms, we use Gno.land. Gno.land serves as an "AWS" of sorts; the chain has the application, and it is distributed on all the nodes, and the validators can also be "called" to deliver transactions. 
	- On Gno.land, the author of the realm only "pays" to publish the realm; but the sustainance of the realm itself is payed by the users in gas fees.

## 2. Use cases

Present use cases for Gno, how it can be used to build X, and how it's better OR different from the current way of doing things (ie. comparison with current social platforms, ways to build communities, etc., showing also the current downsides of using something like Gno)

- Building social communities on gno.land
	- Examples of how we can build boards, microblogs, GnoSocial on top of Gno.
	- Showcase of how these spaces can exist and be regulated by code.
	- Compare gno.land vs facebook/twitter
	- Compare gno.land vs mastodon/fediverse
- Building communes and companies on gno.land
	- Examples of how smart contracts can be used to build organizations, which are regulated in structure and financing directly with clear, and simple code.
	- Everything is transparent; and the rules for governance can be written as code.
	- Turning what are currently "social contracts" into real "code contracts", which computers on the chain can enforce.
	- Compare gno realm vs a legal contract.
	- Compare gno.land company vs a real company.
- Building game servers on gno.land
	- Example of how you can build something like gnochess on gno, and other examples of game servers that can be built on gno.land
	- Still on-line communities, that can outlast the parent companies
	- For real-time games, gno.land will not be good because it's slower than necessary. Our goal is not to centralize everything on the chain though; everyone can fork, and make their own chain. Gno is just a better way to program dapps; we don't claim though to be making the ultimate blockchain for every use case.
	- Compare gno.land vs traditional client-server games.

## 3. Dissecting the GnoVM

- Gno primer
	- What features are different from normal Go.
	- What "patterns" are different from normal Go.
	- Determinism, like time.Now() and random.
- GnoVM primer
	- Diagram of GnoVM processing of code.
	- How data gets stored into global variables.
- A journey in VM land
	- Show how a simple program works and is first parsed and preprocessed on the chain; and then executed.
- Compare: solidity / wasm.
	- Source code is source of truth; anyone can inspect and fork
	- Surface area is larger; but there are benefits that we plan on doing (like being able to query information about code and state to the VM)
	- Not domain-specific; so you don't have to be invested in blockchains to try out Gno.
