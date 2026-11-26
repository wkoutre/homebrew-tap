# Homebrew cask template. scripts/release.sh fills in 0.3.28 and 8e5c6c0b3ca05656f0d4e9bf20262911be7dc75198f43e9d48eed2f0c4bfee0e
# and writes dist/betterlink.rb, which each GitHub Release carries. It goes in
# the wkoutre/homebrew-tap repo as Casks/betterlink.rb (RELEASING.md).
cask "betterlink" do
  version "0.3.28"
  sha256 "8e5c6c0b3ca05656f0d4e9bf20262911be7dc75198f43e9d48eed2f0c4bfee0e"

  url "https://github.com/wkoutre/betterlink/releases/download/v#{version}/betterlink-#{version}.zip"
  name "betterlink"
  desc "Link router that opens each link in a chosen browser profile"
  homepage "https://github.com/wkoutre/betterlink"

  livecheck do
    url :url
    strategy :github_latest
  end

  # betterlink updates itself (Sparkle), so brew leaves it alone.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "betterlink.app"
  binary "#{appdir}/betterlink.app/Contents/Helpers/betterlink"

  uninstall quit: "com.wkoutre.betterlink"

  # Removes your Link Rules and config.ts from the standard settings folder.
  # A settings folder you chose yourself is left alone, and so is
  # ~/.local/bin/betterlink: zap can't tell the link Install Command made from
  # another program's file there. Remove it first with Uninstall on the
  # Agents page.
  zap trash: [
    "~/Library/Application Support/betterlink",
    "~/Library/Caches/com.wkoutre.betterlink",
    "~/Library/HTTPStorages/com.wkoutre.betterlink",
    "~/Library/Preferences/com.wkoutre.betterlink.plist",
  ]
end
