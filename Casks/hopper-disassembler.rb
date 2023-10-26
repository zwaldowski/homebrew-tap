cask "hopper-disassembler" do
  version "5.13.2"
  sha256 "174d7c83e73c1ae2a2adf686a745eb2c9a1107e68fa034851c6977eb530f8ee3"

  url "https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-#{version}-demo.dmg",
      verified: "d2ap6ypl1xbe4k.cloudfront.net/"
  name "Hopper Disassembler"
  desc "Disassemble, decompile, and debug your applications"
  homepage "https://www.hopperapp.com/"

  livecheck do
    url "https://www.hopperapp.com/HopperWeb/appcast_v4.php"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  compat_major = "4"
  app "Hopper Disassembler v#{compat_major}.app"
  binary "#{appdir}/Hopper Disassembler v#{compat_major}.app/Contents/MacOS/hopper"

  zap trash: [
    "~/Library/Application Support/Hopper",
    "~/Library/Caches/com.cryptic-apps.hopper-web-#{compat_major}",
    "~/Library/Preferences/com.cryptic-apps.hopper-web-#{compat_major}.plist",
    "~/Library/Saved Application State/com.cryptic-apps.hopper-web-#{compat_major}.savedState",
  ]
end
