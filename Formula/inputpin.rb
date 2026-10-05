class Inputpin < Formula
  desc "Keep your selected keyboard input source in place"
  homepage "https://kaylaoneal.github.io/InputPin/"
  url "https://github.com/KaylaONeal/InputPin/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2370fcc93b5664ac80fe1ac0292189b4054615bd9a702812cd8e9831857195c6"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :ventura

  def install
    ENV["CLANG_MODULE_CACHE_PATH"] = buildpath/".build/module-cache"
    ENV["SWIFTPM_MODULECACHE_OVERRIDE"] = buildpath/".build/module-cache"
    ENV.delete("SIGNING_IDENTITY")
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
