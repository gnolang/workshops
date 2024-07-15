# Nebular Workshop

Welcome to my Nebular 2024 Workshop!

This workshop will teach you the basics of creating, debugging, and deploying smart contracts on Gno.Land. You'll explore the Gnolang and Gnoland ecosystem tools: `gno`, `gnodev`, and `gnokey`. By the end, you'll deploy your first smart contract on Gno.Land.

This is the local development experience. There are other ways to develop on Gno. Check out [Gno Play](https://play.gno.land).

### How To Play With This Workshop:

#### GitPod (recommended)
Use GitPod, a remote machine with an editor and all necessary tools pre-installed.
[![Open in GitPod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gfanton/workshop-nebular)

#### Locally
You will need [Golang](https://go.dev/doc/install) installed and set up. Then clone this repo and run `make deps` to install the necessary dependencies. It will:
- Clone a forked version of GNO (necessary to work with GitPod)
- Install the necessary tools: `gno`, `gnodev`, `gnoland`

## 01_Gnolang

This section focuses on `gno`, the CLI tool companion for Gnolang, the integrated Go language. There is no blockchain involved in this part.

## 02_Gnodev

This section focuses on `gnodev`, the Gno development tool for working on Gno packages. It includes a `gnoland` blockchain and `gnoweb`, a web application to help you visualize your contract.

## 03_Gnokey

This section focuses on `gnokey`, the Gno development tool for interacting with the chain.

## 04_Gno.Land

This section focuses on publishing a contract on `gno.land`.
