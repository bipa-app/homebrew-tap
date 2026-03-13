<p align="center">
  <a href="https://agentispay.com">
    <img src="assets/logo.png" alt="Agentis Pay" width="500" />
  </a>
</p>

<p align="center">
  <strong>Payment rails for AI agents — Pix, BRL, and beyond.</strong>
</p>

<p align="center">
  <a href="https://agentispay.com">Website</a> ·
  <a href="https://github.com/bipa-app/agentispay/releases">Releases</a>
</p>

---

## What is Agentis Pay?

Agentis Pay gives AI agents a programmable payment account. Agents can check balances, read transaction history, and send Pix transfers — all through a secure MCP (Model Context Protocol) server that plugs into Claude, ChatGPT, and any MCP-compatible host.

### Key capabilities

| Capability | Description |
|---|---|
| **Pix transfers** | Send and receive instant BRL payments via Pix keys |
| **Balance & history** | Real-time account balance and transaction feed |
| **BR Code decode** | Parse Pix QR codes and Copia & Cola payloads |
| **MCP server** | First-class integration with AI agent hosts |
| **OAuth login** | Secure browser-based authentication flow |
| **Keyring storage** | Credentials stored in OS-native keychain |

## Install

```bash
curl -fsSL https://agentispay.com/install.sh | sh
```

The managed installer places a launcher in `~/.local/bin/agentis-pay` and keeps versioned binaries under `~/.agentis-pay/`.

Optional flags:

```bash
# Custom binary directory
curl -fsSL https://agentispay.com/install.sh | sh -s -- --bin-dir /usr/local/bin

# Pin a specific version
curl -fsSL https://agentispay.com/install.sh | sh -s -- --version v0.1.2
```

## Quick start

```bash
# Authenticate
agentis-pay login

# Install the MCP server for Claude Desktop
agentis-pay mcp install --client claude

# Check your balance
agentis-pay pix balance

# Send a Pix payment
agentis-pay pix pay --key alice@example.com --amount 25,00 --note "coffee"

# View recent transactions
agentis-pay pix history --limit 5
```

## MCP tools

Once installed, Claude Desktop (or any MCP host) can use these tools:

| Tool | Description |
|---|---|
| `agentispay_whoami` | Session status |
| `agentispay_account` | Account profile and metadata |
| `agentispay_balance` | Available balance in cents |
| `agentispay_history` | Transaction history (list or detail) |
| `agentispay_deposit` | Pix keys for receiving deposits |
| `agentispay_pix_keys` | Configured Pix keys |
| `agentispay_limits` | Transfer risk limits |
| `agentispay_brcode_decode` | Decode Pix BR Code payloads |
| `agentispay_pay` | Create a Pix transfer |
| `agentispay_pix_send` | Alias for `agentispay_pay` |

## Releases

This repository hosts pre-built binaries for every release. The managed installer downloads from the [Releases](https://github.com/bipa-app/agentispay/releases) page.

| Platform | Architecture | Asset |
|---|---|---|
| macOS | Apple Silicon | `agentis-pay-vX.Y.Z-darwin-arm64.tar.gz` |
| macOS | Intel | `agentis-pay-vX.Y.Z-darwin-x64.tar.gz` |
| Linux | x86_64 | `agentis-pay-vX.Y.Z-linux-x64.tar.gz` |
| Linux | ARM64 | `agentis-pay-vX.Y.Z-linux-arm64.tar.gz` |

## Links

- **Website**: [agentispay.com](https://agentispay.com)

## License

MIT — see [LICENSE](LICENSE) for details.
