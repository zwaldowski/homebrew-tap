class ApplyUserDefaults < Formula
  desc "Small tool to set macOS user defaults from a YAML file"
  homepage "https://github.com/zero-sh/apply-user-defaults"
  url "https://github.com/zero-sh/apply-user-defaults/archive/refs/tags/0.1.2.tar.gz"
  sha256 "2c7c1e4e8ae0fbf1765a5a019ffbd45d185334e4c21e6593b0258198fee5dd0f"
  license "Apache-2.0"
  revision 1
  head "https://github.com/zero-sh/apply-user-defaults.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zwaldowski/tap"
    sha256 cellar: :any_skip_relocation, big_sur: "a8c1a1763eabaaa3774eb8806622be8239f56f331cef166efd3c0e00c97baa6c"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/apply-user-defaults-*/out"].first
    bash_completion.install "#{out_dir}/apply-user-defaults.bash"
    fish_completion.install "#{out_dir}/apply-user-defaults.fish"
    zsh_completion.install "#{out_dir}/_apply-user-defaults"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apply-user-defaults --version")
  end
end
