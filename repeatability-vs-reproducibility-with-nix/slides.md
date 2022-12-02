---
author: Gustavo Porto
date: ""
paging: Slide %d / %d
---

# Repeatability vs. Reproducibility with Nix

In the fields of chemistry and engineering, scientists perform the same
experiment several times in order to confirm their findings.
Repeatability measures the variation in measurements taken by a single instrument
or person under the same conditions, while reproducibility measures wheather
an entire experiment can be reproduced in its entirety.

Experiments need to happen in a isolated environment, software engineers
have containers to isolate environments, but they are not enough.

Because containers are not reproducible, they are repeatable.

---

# A container defined in a Dockerfile is reproducible, right?

```bash
cat Dockerfile
```
---

# A different result every time?

```bash
cat examples/hashdifference.txt
```

---

# So how do we do this with a Nix Flake instead?

```bash
cat flake.nix
nix flake show
```

We can put any of the 80,000 packages from Nixpkgs we want in that `contents`
argument, or make our own derivation

---

# Let's build and run it

```bash
nix build .#my-container-image
ls -lah result
docker load < result
docker run my-container-image
```

---

# Why?

Docker is repeatable, but not reproducible. It defines instructions, but trusts
the internet unconditionally, without performing any hashing. Dockerfiles do not
provide you with a toolset for performing reproducible builds.

---

# What does Nix guarantee?

## Same inputs, same outputs

Nix guarantees that all of the inputs for a build will be gathered reproducibly,
and that the build process will be performed offline, in a sandbox, meaning the
output should be the same every time.

# What does Nix not guarantee?

## Sometimes, build processes are not deterministic despite everything

Nix cannot force the build process to be deterministic, but it does more than
most tools, by implementing a methodology for performing reproducible builds and
providing you with an expression language to define the build.

---

# Questions?

