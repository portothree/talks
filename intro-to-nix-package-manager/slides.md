---
author: Gustavo Porto
date: ""
paging: Slide %d / %d
---

# Introduction to the Nix package manager

Traditional package managers like `apt` and `Pacman` has multiple flaws which make them unreliable to be used in environments that need highly stable systems such as servers.

---

# Problems with traditional package managers 

- Changes can't be undone
- Updates are not atomic (instant)
- Dependency Hell
    - Circular dependency conflict
    - Linear dependency conflict

---

# What is the Nix language?

- Invented by Eelco Dolstra in his PhD thesis in 2003
  - The Purely Functional Software Deployment Model[^1]
  [1]: https://edolstra.github.io/pubs/phd-thesis.pdf
- Domain specific language (DSL) for specifying reproducible builds
- Lazily evaluated
- Purely Functional programming language (Not procedural, ordering doesn't matter)
- Declarative, rather than imperative
- Everything is an expression, no side effects

---

# Attribute set example

```bash
cat ./examples/attr-set.nix
```

---

# Let's evaluate x

```bash
nix eval -f ./examples/attr-set.nix x
```

---

# Let's evaluate y


```bash
nix eval -f ./examples/attr-set.nix y
```

---

# Let's evaluate z

```bash
nix eval -f ./examples/attr-set.nix z
```

---

# A basic concrete example, compiling hello-world from GNU

```bash
cat ./examples/hello-world.nix
```

```bash
nix build -f ./examples/hello-world.nix
ls -lah result/bin
file result/bin/hello
result/bin/hello
```
---

# Solving traditional package manager problems

By being a purely functional package manager. Nix was designed to be a reliable and reproducible, solving the common problems posed by traditional package managers.

All packages built by Nix have a unique hash attached to them which is derived by the dependencies of the package.

Recompiling the package by changing a dependency version will result in a totally different package with a different hash.

---

# Multiple versions

Because of the hashing scheme, different versions of a package end up in different paths in the Nix store, so they don't interfere with each other.

---

# Atomic changes and rollbacks

Since the updated packages are totally different packages from the existing ones, the old packages will not be deleted. The new packages will simply be *symlinked* over the old ones.

This will not break the sysstem if the update process is interrupted in between.

Since the old version of a package are still there, you can rollback your machine to the old package anytime.

---

# Reproducibility

Through Nix, it is very easy to replicate development environments. Fixing the "works on my machine" problem, since everything is declarative and pinned.
