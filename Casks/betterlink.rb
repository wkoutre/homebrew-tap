# Homebrew cask template. scripts/release.sh fills in 0.3.16 and e45b30acafe1304fefd4053d10bb558f020afe658b09f0a417fe4c6adbe9a10f
# and writes dist/betterlink.rb, which each GitHub Release carries. It goes in
# the wkoutre/homebrew-tap repo as Casks/betterlink.rb (RELEASING.md).
cask "betterlink" do
  version "0.3.16"
  sha256 "e45b30acafe1304fefd4053d10bb558f020afe658b09f0a417fe4c6adbe9a10f"

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
