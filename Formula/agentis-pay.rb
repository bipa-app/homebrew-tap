class AgentisPay < Formula
  desc "Agentis Pay CLI - Pix payments with MCP agent support"
  homepage "https://agentispay.com"
  version "0.1.1"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-darwin-arm64.tar.gz"
    sha256 "3590d1650a779bc5f97cfb572788abfd1c6e6067ee74caa812aaa54e823b3915"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-darwin-x64.tar.gz"
    sha256 "2bd2df92de7777e6dc35744aec2b5a79aa59e095597c696824287d56a46a880a"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-linux-x64.tar.gz"
    sha256 "e240b24841c162fb76ee90fc75ca759b30a52be6f5a03b2030328e2580d3d3ec"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-linux-arm64.tar.gz"
    sha256 "bc245b92b07823b9ef317c1fa16913f9de5593d67bb03000e6a5367c21395288"
  end

  def install
    bin.install "agentis-pay"
  end

  test do
    system "#{bin}/agentis-pay", "--version"
  end
end
