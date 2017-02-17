FROM carwow/erlang

# install elixir
RUN mkdir -p /tmp/elixir-build && \
    cd /tmp/elixir-build && \
    apk add --no-cache --update --virtual .elixir-build \
      make && \
    apk add --no-cache --update \
      git && \
    git clone https://github.com/elixir-lang/elixir && \
    cd elixir && \
    git checkout v1.4.0 && \
    make && make install && \
    mix local.hex --force && \
    mix local.rebar --force && \
    cd $HOME && \
    rm -rf /tmp/elixir-build && \
    apk del .elixir-build

ONBUILD ADD . /opt/app
ONBUILD WORKDIR /opt/app
ONBUILD RUN mix local.hex --force
ONBUILD RUN mix local.rebar --force
ONBUILD RUN mix deps.get
ONBUILD RUN mix compile
