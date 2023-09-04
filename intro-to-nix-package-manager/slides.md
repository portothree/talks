---
author: Gustavo Porto
date: "2023"
paging: Slide %d / %d
---

# Introduction to Nix

Gustavo Porto

@portothree

2023

---

# Introduction to Nix

## What is Nix?

- A programming language
- A package manager
- A ~20MB program written in C++
- A method of compiling software from source
- A Linux distribution*

## What does Nix achieve

- Infrastructure as Code
- Reproducibility
- Software supply chain security

---

## Timeline

- **2003**: Fist Nix commit by Eelco Dolstra, the invetor
- **2004**: First papers on Nix
- **2006**: The Nix Thesis
- **2006**: NixOS By Armijn Hemel
- **2021**: NixOS 21.05:
  - `1745` Contributors, `292,223` Commits
- **2022 (December)**: NixOS 22.11:
  - `4758` Contributors, `428,836` Commits
- **2023 (Now)**: NixOS 23.05:
  - `5836` Contributors, `522,209` Commits

---

# How I started using Nix

- **2018**: Started hearing about it, but was too deep into the Debian community
  - Installed and tried it once to see if it could replace `apt`
  - End up forgetting about it
- **2019**: Saw a commit to a project I mantained at the time to add Nix installation instructions
  - In my mind Nix was just a regular packager manager and should behave just like `brew`, `yay` or `apt`.
  - So I raised a new PR and someone explained Nix properly to me.
  - -- INCLUDE PR SCREENSHOT --

---

# What I do with Nix

-- INCLUDE homelab REPO SCREENSHOT --
-- INCLUDE dotfiles REPO SCREENSHOT --

---

# What are people saying about Nix

-- INCLUDE TWEETS SCREENSHOTS --

---

# What is Nixpkgs

- "Standard library"
- 90,000+ reproducible recipes
- A repo on GitHub containing:
  - Packages
  - Functions
  - Compiling instructions for multiple languages / tools
  - NixOS modules and options

---

# Nix - Language

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

# Puzzle

What does that do?

```bash
cat ./examples/puzzle.nix
```

---

```bash
nix eval -f ./examples/puzzle.nix
```

Because the language is lazy, the question we have to ask is "What do we want from that attribute set"

---

Nix - Package manager

---

# Problems with traditional package managers 

Traditional package managers like `apt` and `Pacman` has multiple flaws which make them unreliable to be used in environments that need highly stable systems such as servers.

- Changes can't be undone
- Updates are not atomic (instant)
- Dependency Hell
    - Circular dependency conflict
    - Linear dependency conflict

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

---

# The old way

Written instructions:

Gitlab repo with instructions to compile and install Biozard Outbreak private server

https://gitlab.com/gh0stl1ne/Bioserver1/-/blob/master/Biohazard%20Outbreak%20private%20server.pdf

Nix flake:
https://github.com/MatthewCroughan/bioflake/blob/master/flake.nix


---

# NixOS - Distribution

Built from Nix Language, package manager and Nixpkgs collection

The result of running Nix Buid or Nix code you have written

Completely declarative

---

# How do you make a Linux distribution out of that?

- A distribution is a bunch of files
- In the end, the Nix package manager creates files
- Let's use Nix to create every (non user data) file

---

# Introducing the module system

```nix
{ ... }:
{
  services.openssh.enable = true;
}
```

---

# Customizing the SSH server config
 
```nix
{ ... }:
{
  services.openssh = {
    enable = true;
    openFirewall = false;
    allowSFTP = true;
    extraConfig = ''
      # Extra verbatim contents of sshd_config
    '';
  };
}
```

---

# Creating our own systemd module

```nix
{ ... }:
{
  systemd.services.myService = {
    description = "My really awesome service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${myPackage}/bin/myExec";
      DynamicUser = true;
    };
  };
}
```

---

# Other advantages

- Made out of simple building blocks
  - Makes it possible to develop tools
- Distributed Nix store
- Very strong community
- Usage as a server or workstation
- "Works for me" => "Works for everybody"

---

# Questions?
