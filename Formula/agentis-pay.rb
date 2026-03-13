class AgentisPay < Formula
  desc "Agentis Pay CLI - Pix payments with MCP agent support"
  homepage "https://agentispay.com"
  version "0.1.2"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.2/agentis-pay-v0.1.2-darwin-arm64.tar.gz"
    sha256 "8703de1dd670f303f8d1d0efdbae3d679ebe5e89daa93afd9c6412c5f9a8e58a"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.2/agentis-pay-v0.1.2-darwin-x64.tar.gz"
    sha256 "a16d612cd800f2f16d9f88fd72d2a373149c4c597078209ead8173eda75c204e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.2/agentis-pay-v0.1.2-linux-x64.tar.gz"
    sha256 "352a57fa92b791a2d96a5365653de0e64138c224a83be5ed46fcca02dc1eeaa0"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.2/agentis-pay-v0.1.2-linux-arm64.tar.gz"
    sha256 "27cfd5ed01623d517d1c185c6d0b558288b372314f64e0f0b5be2f28678135f8"
  end

  def install
    bin.install "agentis-pay"
  end

  test do
    system "#{bin}/agentis-pay", "--version"
  end
end
