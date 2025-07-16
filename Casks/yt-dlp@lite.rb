cask "yt-dlp@lite" do
  version "2024.03.10"
  sha256 "4620d1d3a73510e158e3fb65a8f4cb6ee54585ddc711fc8c1bc4fa3cee974cac"

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with formula: "homebrew/core/yt-dlp"
  depends_on macos: ">= :big_sur"

  binary "yt-dlp_macos", target: "yt-dlp"
end
