cask "yt-dlp@lite" do
  version "2025.08.20"
  sha256 "835d7709542170f52170184dbbfcf941963e66ed50be2ccf1431cba40ec6c7ba"

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  binary "yt-dlp_macos", target: "yt-dlp"
end
