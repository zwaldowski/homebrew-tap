class FfmpegLite < Formula
  desc "Convert audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-7.0.tar.gz"
  sha256 "943a2a28044947c17a905c39075494b0da46ec0795224c2c61eff986518321eb"
  license "GPL-2.0-or-later"
  head "https://github.com/FFmpeg/FFmpeg.git", branch: "master"

  livecheck do
    url "https://ffmpeg.org/download.html"
    regex(/href=.*?ffmpeg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/zwaldowski/tap"
    sha256 ventura: "4de8b161add5a192887d018686a5d76b2b1916540b4c23f2571599fd9efe2839"
  end

  depends_on "pkg-config" => :build
  depends_on "lame"
  depends_on "x264"
  depends_on "x265"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  on_intel do
    depends_on "nasm" => :build
  end

  conflicts_with "homebrew/core/ffmpeg", because: "both install `ffmpeg` binaries"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-gpl
      --enable-libmp3lame
      --enable-libx264
      --enable-libx265
      --enable-libxml2
      --disable-ffprobe
      --disable-lzma
    ]

    # Needs corefoundation, coremedia, corevideo
    args += %w[--enable-videotoolbox --enable-audiotoolbox] if OS.mac?
    args << "--enable-neon" if Hardware::CPU.arm?

    system "./configure", *args
    system "make", "install"
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
