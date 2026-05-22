cask "nyro" do
  version "1.7.6"

  name "Nyro"
  desc "Local-first AI protocol gateway for OpenAI / Anthropic / Gemini"
  homepage "https://github.com/nyroway/nyro"

  on_macos do
    arch arm: "aarch64", intel: "x64"
    sha256 arm:   "a4d85825bec8f8e289f24d4abd1b12dae549c22338027af7f2d7ffe17ee7224f",
           intel: "3ed519673857aa6cea664346eb7b8991e50491b485bcadbdd5de9d13432456fb"

    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_#{arch}.dmg"

    app "Nyro.app"
    postflight do
      system_command "/usr/bin/xattr",
                     args: ["-rd", "com.apple.quarantine", "#{appdir}/Nyro.app"]
    end

    zap trash: [
      "~/Library/Application Support/com.nyro.ai-gateway",
      "~/Library/Caches/com.nyro.ai-gateway",
      "~/Library/Preferences/com.nyro.ai-gateway.plist",
      "~/Library/Saved Application State/com.nyro.ai-gateway.savedState",
    ]

    caveats <<~EOS
      If macOS still blocks Nyro after install, run:
        sudo xattr -rd com.apple.quarantine "/Applications/Nyro.app"
    EOS
  end

  on_linux do
    arch arm: "aarch64", intel: "amd64"
    sha256 arm:   "a056d6444b499071837708819ead3f6c68958a8da1fab3dd0f40a8fe7c35357e",
           intel: "57f97671f5832e834896e8adba9172cca94fbc6ce8046a75cabd720226451550"

    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_#{arch}.AppImage"
    binary "Nyro_#{version}_#{arch}.AppImage", target: "nyro"

    preflight do
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/Nyro_#{version}_#{arch}.AppImage"]
    end
  end

end
