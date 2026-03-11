class AgentisPay < Formula
  desc "Agentis Pay CLI - Pix payments with MCP agent support"
  homepage "https://agentispay.com"
  version "0.1.1"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-darwin-arm64.tar.gz"
    sha256 "46fe5462cd1156d8e41eb4a6a42b65a4221cfdb8c54912c24903629eea8ada90"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-darwin-x64.tar.gz"
    sha256 "24065b6743988254e43d6a92832dd176462fb26c726f353e1bb8828c75b8f8fe"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-linux-x64.tar.gz"
    sha256 "a000a0fa594d63c297cf71fd4f5013a5a6c364e8752c9520dca618a156b32847"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/bipa-app/homebrew-tap/releases/download/v0.1.1/agentis-pay-v0.1.1-linux-arm64.tar.gz"
    sha256 "aa25f7eef1a841078ac94c18cc2998ff5c3f4ce2192e6bbabd28658c701ba53b"
  end

  def install
    bin.install "agentis-pay"
  end

  test do
    system "#{bin}/agentis-pay", "--version"
  end
end
