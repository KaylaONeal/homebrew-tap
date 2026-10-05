class Inputpin < Formula
  desc "Keep your selected keyboard input source in place"
  homepage "https://kaylaoneal.github.io/InputPin/"
  url "https://github.com/KaylaONeal/InputPin/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "a0942d67ef9ca4756c92228de1f5761ab98e55b752a517d8925554c8e5426fa4"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :ventura

  def install
    ENV["CLANG_MODULE_CACHE_PATH"] = buildpath/".build/module-cache"
    ENV["SWIFTPM_MODULECACHE_OVERRIDE"] = buildpath/".build/module-cache"
    ENV.delete("SIGNING_IDENTITY")
    # Homebrew already sandboxes the build; nested SwiftPM sandboxing is unsupported.
    inreplace "build.sh", "swift build -c release", "swift build --disable-sandbox -c release"
    system "bash", "build.sh"
    prefix.install "build/InputPin.app"
    (bin/"inputpin").write <<~SH
      #!/bin/bash
      exec "#{opt_prefix}/InputPin.app/Contents/MacOS/InputPin" "$@"
    SH
  end

  def caveats
    <<~EOS
      Open the menu bar app:
        open "#{opt_prefix}/InputPin.app"
      This formula builds locally with ad hoc signing. For the notarized
      prebuilt app, use the InputPin cask instead. Install only one distribution
      at a time because both provide the inputpin command.
      Turn off launch at login in InputPin before uninstalling.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/inputpin --version").strip
    assert_match "--select", shell_output("#{bin}/inputpin --help")
    assert_path_exists prefix/"InputPin.app/Contents/Resources/AppIcon.icns"
  end
end
