class FfmpegLite < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-4.3.2.tar.xz"
  sha256 "46e4e64f1dd0233cbc0934b9f1c0da676008cad34725113fb7f802cfa84ccddb"
  head "https://github.com/FFmpeg/FFmpeg.git"

  depends_on "nasm" => :build
  depends_on "pkg-config" => :build

  depends_on "lame"
  depends_on "x264"
  depends_on "x265"
  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  conflicts_with "ffmpeg", :because => "both install `ffmpeg` binaries"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-pthreads
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-gpl
      --enable-libmp3lame
      --enable-libx264
      --enable-libx265
      --enable-videotoolbox
      --disable-libjack
      --disable-indev=jack
    ]

    system "./configure", *args
    system "make", "install"

    # Fix for Non-executables that were installed to bin/
    mv bin/"python", pkgshare/"python", :force => true
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
