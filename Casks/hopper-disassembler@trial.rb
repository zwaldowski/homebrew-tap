cask "hopper-disassembler@trial" do
  version "5.19.5"
  sha256 "1b319a69f02cd139ddb64667dcb172400efbda2e7b70c715348889c39a3c8ced"

  url "https://www.hopperapp.com/downloader/hopperv4/Hopper-#{version}-demo.dmg",
      user_agent: :fake
  name "Hopper Disassembler"
  desc "Disassemble, decompile, and debug your applications"
  homepage "https://www.hopperapp.com/"

  livecheck do
    url "https://www.hopperapp.com/rss/changelog.xml"
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  auto_updates true

  app "Hopper Disassembler v4.app"
  binary "#{appdir}/Hopper Disassembler v4.app/Contents/MacOS/hopper"

  zap trash: [
    "~/Library/Application Support/Hopper Disassembler v4",
    "~/Library/Application Support/Hopper",
    "~/Library/Caches/com.cryptic-apps.hopper-web-4",
    "~/Library/Preferences/com.cryptic-apps.hopper-web-4.plist",
    "~/Library/Saved Application State/com.cryptic-apps.hopper-web-4.savedState",
  ]
end
