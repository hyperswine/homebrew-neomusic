class NeoMusic < Formula
  desc "Algebraic music notation: render .neomusic scores to audio, MIDI and sheets"
  homepage "https://github.com/hyperswine/neomusic"
  url "https://github.com/hyperswine/neomusic/archive/refs/tags/v0.1.0.0.tar.gz"
  sha256 "1a754995da180746d0eed6c31aa2935126bb3b90d7f5ada1450bc411dd451e5e"
  license "GPL-3.0-only"
  head "https://github.com/hyperswine/neomusic.git", branch: "main"

  depends_on "cabal-install" => :build
  depends_on "ghc@9.8" => :build
  depends_on "ffmpeg"

  uses_from_macos "libffi"
  uses_from_macos "zlib"

  on_linux do
    depends_on "gmp"
  end

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
    pkgshare.install "examples"
  end

  test do
    (testpath/"tiny.neomusic").write <<~EOS
      tempo 120
      tuning 12 at C4
      instrument right = piano staff treble
      right: [0 4 7 12]:1/2
    EOS
    assert_match "4 notes", shell_output("#{bin}/neo-music check tiny.neomusic")
    system bin/"neo-music", "render", "tiny.neomusic", "-o", "tiny.wav"
    assert_path_exists testpath/"tiny.wav"
    assert_match "notes", shell_output("#{bin}/neo-music check #{pkgshare}/examples/neomusic/twinkle.neomusic")
  end
end
