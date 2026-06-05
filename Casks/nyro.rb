cask "nyro" do
  version "1.8.0"

  name "Nyro"
  desc "Local-first AI protocol gateway for OpenAI / Anthropic / Gemini"
  homepage "https://github.com/nyroway/nyro"

  on_macos do
    arch arm: "aarch64", intel: "x64"
    sha256 arm:   "e8605f5eb9c6f854b69d66c67e8749bfafd78dda15b835faefe0e4e922f4ab3c",
           intel: "7ecece41a387cfcf1bf34babccfbace217df27029488156d5a51838274ca0f3f"

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
    sha256 arm:   "07ddcbc91cc8d5f85d7491ea2652637abe1ef1551100b060609fa24fa2ef793f",
           intel: "bdae81bc178ee2362dab1a80a9af9e90e3f37de90a51cd11d76ca7b4d3453d39"

    url "https://github.com/nyroway/nyro/releases/download/v#{version}/Nyro_#{version}_#{arch}.AppImage"
    binary "Nyro_#{version}_#{arch}.AppImage", target: "nyro"

    preflight do
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/Nyro_#{version}_#{arch}.AppImage"]
    end
  end

end
