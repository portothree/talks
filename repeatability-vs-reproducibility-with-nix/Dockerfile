FROM ubuntu:latest
    # ^^^^^ ^^^^^^<-- Latest when? When I run `docker build`?
    #   ^
    # Ubuntu layer is not intrinsically attached to source,
    # where is the Dockerfile? Who knows?
RUN apt-get update && apt-get install hello -y
   # ^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^<---- Doesn't compile anything from source
   # Will resolve a different package list
   # every time, some packages might disappear
CMD [ "hello" ]
# ^^^^^^^^^^^^^ Assumes the 'hello' package puts 'hello' binary on the $PATH, which may change
