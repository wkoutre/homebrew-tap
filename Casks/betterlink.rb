# Homebrew cask template. scripts/release.sh fills in 0.3.32 and b1863c1444be5f074bcb08ae2c8e5c22acd7f023600f350fa36d72d04a9a09f0
# and writes dist/betterlink.rb, which each GitHub Release carries. It goes in
# the wkoutre/homebrew-tap repo as Casks/betterlink.rb (RELEASING.md).
cask "betterlink" do
  version "0.3.32"
  sha256 "b1863c1444be5f074bcb08ae2c8e5c22acd7f023600f350fa36d72d04a9a09f0"

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
