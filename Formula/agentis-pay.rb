class AgentisPay < Formula
  desc "Agentis Pay CLI - Pix payments with MCP agent support"
  homepage "https://agentispay.com"
  version "0.1.0"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.0/agentis-pay-v0.1.0-darwin-arm64.tar.gz"
    sha256 "bd2e95770808bef0ad83b3854c72ae4fb892e0c6eaae354676d2b70c7315acd0"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.0/agentis-pay-v0.1.0-darwin-x64.tar.gz"
    sha256 "a727fcb5b4d969392c399f412c5ff669cf34bd25b09faf746560efe048c6369d"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.0/agentis-pay-v0.1.0-linux-x64.tar.gz"
    sha256 "6e8c65b26808babfde7b65da45698f5aedc49f103e0264e3cd2a1b12c26298e4"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.0/agentis-pay-v0.1.0-linux-arm64.tar.gz"
    sha256 "47a763d1165ba21b3b73bfd6238b74f9aec020fc43faed166dd791d956561097"
  end

  def install
    bin.install "agentis-pay"
  end

  test do
    system "#{bin}/agentis-pay", "--version"
  end
end
