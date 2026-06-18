cask "nyro" do
  version "1.8.2"

  name "Nyro"
  desc "Local-first AI protocol gateway for OpenAI / Anthropic / Gemini"
  homepage "https://github.com/nyroway/nyro"

  on_macos do
    arch arm: "aarch64", intel: "x64"
    sha256 arm:   "b7ec0a3fcd8015bf0d978adad38936c30df57cca10cb2c21cd45fbd72338053e",
           intel: "a13017a055d7d9cb4d66c0f116afc5c338f5a195f04b420ef9fbfc072de7864a"

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
    sha256 arm:   "aed72dff46d071c2a49d004b510ba6eef955b21cb84ec451fddf84ff01a3b9d3",
           intel: "3238c9173ef591778fd7e00953357687a385c99ed60cd27acf8445bd46b31492"

    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_#{arch}.AppImage"
    binary "Nyro_#{version}_#{arch}.AppImage", target: "nyro"

    preflight do
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/Nyro_#{version}_#{arch}.AppImage"]
    end
  end

end
