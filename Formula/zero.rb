class Zero < Formula
  desc "Radically simple personal bootstrapping tool for macOS"
  homepage "https://github.com/zero-sh/zero.sh"
  url "https://github.com/zero-sh/zero.sh/archive/refs/tags/0.6.0.tar.gz"
  sha256 "66f3a7fdeb14b6680a4f79f93edcee7db8a93568595b41e3ea2c89d9bc541f51"
  license "MIT"
  head "https://github.com/zero-sh/zero.sh.git", branch: "master"

  depends_on "apply-user-defaults"
  depends_on "mas"
  depends_on "stow"

  uses_from_macos "swift" => :build

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/zero"

    ENV["OUT_DIR"] = buildpath
    system "swift", "run", "--disable-sandbox", "generate-completions"
    zsh_completion.install "_zero"
  end

  test do
    assert_match "Version: #{version}", shell_output("#{bin}/zero --version")
  end
end
