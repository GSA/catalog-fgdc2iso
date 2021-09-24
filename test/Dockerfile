FROM bats/bats

RUN apk add curl

COPY ./ /test/

# entrypoint is bats, supply args as CMD to bats
CMD ["-r", "/test/ping.bats"]
