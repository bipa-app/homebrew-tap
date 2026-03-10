class AgentisPay < Formula
  desc "Agentis Pay CLI - Pix payments with MCP agent support"
  homepage "https://github.com/bipa-app/agentis-pay"
  version "0.1.0"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/bipa-app/agentis-pay/releases/download/v0.1.0/agentis-pay-v0.1.0-darwin-arm64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/agentis-pay/releases/download/v0.1.0/agentis-pay-v0.1.0-darwin-x64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/bipa-app/agentis-pay/releases/download/v0.1.0/agentis-pay-v0.1.0-linux-x64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/bipa-app/agentis-pay/releases/download/v0.1.0/agentis-pay-v0.1.0-linux-arm64.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  end

  def install
    bin.install "agentis-pay"
  end

  test do
    system "#{bin}/agentis-pay", "--version"
  end
end
