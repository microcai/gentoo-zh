#!/usr/bin/bash

export OSU_SDL3=${OSU_SDL3:=%SDL3_DEFAULT%}
export OSU_EXTERNAL_UPDATE_PROVIDER=true

if command -v gamemoderun &> /dev/null; then
    exec $(command -v gamemoderun) /usr/lib/osu-lazer/osu! "$@"
fi

exec /usr/lib/osu-lazer/osu! "$@"
