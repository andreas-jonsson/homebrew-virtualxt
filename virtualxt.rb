# frozen_string_literal: true

class Virtualxt < Formula
  desc "Portable, lightweight IBM PC/XT emulator written in Go"
  homepage "https://virtualxt.org"
  url "https://github.com/andreas-jonsson/virtualxt/archive/v0.5.1.tar.gz"
  version "0.5.1"
  sha256 "93f5232d794a9ecba88be50d227f86948a27290192a9ec7c777676724cec8477"
  license "GPL-3.0-or-later"
  head "https://github.com/andreas-jonsson/virtualxt.git", branch: "edge"

  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "sdl2"

  def install
    ENV["FULL_VERSION"] = "#{version}.0"

    system "go", "generate", "./..."
    system "go", "build", "-tags", "sdl"

    bin.install "virtualxt"
    bin.install "tools/package/homebrew/virtualxt.freedos"

    pkgshare.install "doc/manual" => "manual"
    pkgshare.install "bios/pcxtbios.bin"
    pkgshare.install "bios/vxtcga.bin"
    pkgshare.install "boot/freedos.img"
  end

  test do
    system "virtualxt.freedos", "-h"
  end
end
