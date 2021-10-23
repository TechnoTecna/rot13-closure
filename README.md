# rot13-closure

Small program that given a list of words compute its largest subset closed by rot13.

## Installation

This package is built with [stack](https://github.com/commercialhaskell/stack). You should install it on your system using your usual package manager.

You can then download and build the program as follow:

```bash 
# Use git
$ git clone https://github.com/TechnoTecna/rot13-closure.git

# Move into the directory
$ cd rot13-closure

# Build the project with stack
$ stack build
```

## Usage

You can now run the program with stack as follow:

```bash
$ stack exec rot13-closure <filename>
```

`<filename>` should contain a whitespace-separated list of word. For example, you can try with one the provided dictionary:

```bash
$ stack exec rot13-closure data/english.txt
```

If you want you can also install the program on your machine with:

```
$ stack install
```

It should then be available in your `PATH`.
