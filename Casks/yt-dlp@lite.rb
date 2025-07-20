cask "yt-dlp@lite" do
  version "2025.06.30"
  sha256 "e2273b717c09c87413fc8cc2bedea5ed436bdfd9b2cf62b5458d7301aa5e769b"

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
