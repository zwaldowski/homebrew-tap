class PodmanAT4 < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"
  url "https://github.com/containers/podman/archive/v4.0.2.tar.gz"
  sha256 "cac4328b0a5e618f4f6567944e255d15fad3e1f7901df55603f1efdd7aaeda95"
  license "Apache-2.0"

  bottle do
    rebuild 1
  end

  keg_only :versioned_formula

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "qemu"

  resource "gvproxy" do
    url "https://github.com/containers/gvisor-tap-vsock/archive/v0.3.0.tar.gz"
    sha256 "6ca454ae73fce3574fa2b615e6c923ee526064d0dc2bcf8dab3cca57e9678035"
  end

  def install
    ENV["CGO_ENABLED"] = "1"
    os = OS.kernel_name.downcase

    inreplace "vendor/github.com/containers/common/pkg/config/config_#{os}.go",
              "/usr/local/libexec/podman",
              libexec

    system "make", "podman-remote-#{os}"
    if OS.mac?
      bin.install "bin/#{os}/podman" => "podman-remote"
      bin.install_symlink bin/"podman-remote" => "podman"
    else
      bin.install "bin/podman-remote"
    end

    resource("gvproxy").stage do
      system "make", "gvproxy"
      libexec.install "bin/gvproxy"
    end

    system "make", "podman-remote-#{os}-docs"
    man1.install Dir["docs/build/remote/#{os}/*.1"]

    bash_completion.install "completions/bash/podman"
    zsh_completion.install "completions/zsh/_podman"
    fish_completion.install "completions/fish/podman.fish"
  end

  test do
    assert_match "podman-remote version #{version}", shell_output("#{bin}/podman-remote -v")
    assert_match(/Cannot connect to Podman/i, shell_output("#{bin}/podman-remote info 2>&1", 125))

    machineinit_args = "--image-path fake-testi123 fake-testvm"
    machineinit_output = shell_output("#{bin}/podman-remote machine init #{machineinit_args} 2>&1", 125)
    assert_match "Error: open fake-testi123: no such file or directory", machineinit_output
  end
end
