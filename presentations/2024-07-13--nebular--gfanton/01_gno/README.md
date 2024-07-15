## 01_Gno - Go, little brother

In this section, you will learn to use the `gno` CLI to run and test Gno packages. This part does not rely on a blockchain; instead, it operates solely on the GnoVM.

### Package

A GNO package is generally composed of:

* a `gno.mod` file that describes the package and its dependencies
* some `*.gno` files (and optionally some `*_test.gno` files for testing)
* an optional `README.md`

Explore the different files in the current package (in the same folder as this README).

### Run Gno Package
To execute your package, run the following command from the directory containing the package:

```bash
$ gno run .
```

This command runs the `main()` function in the `main.gno` file, which serves as the entry point of the package.

### Testing Gno Packages
Run tests using the `gno test .` command. This command executes all functions prefixed with `Test` in files that are suffixed with `_test.gno`.

```bash
$ gno test .
```
