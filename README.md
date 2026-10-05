# Homebrew tap

The maintained custom tap for [InputPin](https://github.com/KaylaONeal/InputPin), a native macOS input-source pinning utility. MIT licensed, macOS 13 Ventura or later.

## Build locally

```sh
brew install kaylaoneal/tap/inputpin
open "$(brew --prefix inputpin)/InputPin.app"
```

Requires Xcode 15+. The formula builds a SHA-256-pinned source tag locally with ad hoc signing and installs the app and `inputpin` CLI. It does not download a notarized binary.

## Prebuilt app

After the notarized release is published:

```sh
brew install --cask kaylaoneal/tap/inputpin
```

The cask downloads an exact Developer ID signed, notarized release and verifies its SHA-256. Apple Silicon and Intel are included. This tap is separate from Homebrew's official catalog.

Install either the source formula or the cask, because both provide the `inputpin` command. Turn off launch at login and quit InputPin before uninstalling. Ordinary uninstall preserves your preferences.

## Contribute

Keep fixed versions, verified upstream URLs and real checksums. Run Homebrew style, audit, install and test checks. Source formula CI builds and runs CLI checks on macOS. Report app bugs in the [InputPin repository](https://github.com/KaylaONeal/InputPin/issues).
