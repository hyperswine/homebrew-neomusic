# hyperswine/neomusic Homebrew tap

The Homebrew formula for [neomusic](https://github.com/hyperswine/neomusic)'s `neo-music`
command. It renders `.neomusic` scores to WAV/MP3/FLAC/Ogg/Opus/M4A, MIDI, and numeric
or LilyPond sheets.

## Install

```sh
brew install hyperswine/neomusic/neo-music
# or: brew tap hyperswine/neomusic && brew install neo-music
```

It builds from source (there are no bottles). That pulls in `ghc@9.8` and
`cabal-install` as build dependencies, downloads the Haskell packages it needs,
and takes several minutes. neomusic is tested with GHC 9.8.x. `ffmpeg` is a
runtime dependency, used for every format except WAV. For `staff --pdf`,
install LilyPond separately (`brew install lilypond`).

`brew install --HEAD hyperswine/neomusic/neo-music` builds the current `main` instead.

## Use

```sh
neo-music play song.neomusic                 # render and play (afplay on macOS)
neo-music render song.neomusic -o song.flac  # --rate, --bits, --mp3-quality, --no-dither
neo-music midi song.neomusic -o song.mid
neo-music check song.neomusic
```

The examples are installed under `$(brew --prefix)/share/neo-music/examples/neomusic/`.

## Recorded samples

The scores that use recorded instruments (VSCO 2 CE, Salamander piano, Meta guitars,
the OpenAIR room) need sample libraries. These are not part of the formula. Fetch
them with the repository's checksummed script and point `NEOMUSIC_SAMPLES` at them:

```sh
git clone https://github.com/hyperswine/neomusic && cd neomusic
python3 scripts/fetch-samples.py --samples ~/neomusic-samples --fetch   # ~4 GB
export NEOMUSIC_SAMPLES=~/neomusic-samples
```

## License

The formula files in this tap are MIT-licensed (see LICENSE). neomusic itself is
GPL-3.0-only.
