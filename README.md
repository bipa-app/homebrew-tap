<p align="center">
  <a href="https://agentispay.com">
    <img src="assets/logo.png" alt="Bipa CLI" width="500" />
  </a>
</p>

<p align="center">
  <strong>Payment rails for AI agents — Pix, BRL, and beyond.</strong>
</p>

<p align="center">
  <a href="https://agentispay.com">Website</a> ·
  <a href="https://agentispay.com/docs">Docs</a> ·
  <a href="https://github.com/bipa-app/agentispay/releases">Releases</a>
</p>

---

## What is Bipa CLI?

Bipa CLI gives AI agents a programmable payment account. Agents can check balances, read transaction history, and send Pix transfers — all through a secure MCP (Model Context Protocol) server that plugs into Claude, ChatGPT, Cursor, Windsurf, VS Code, and any MCP-compatible host.

### Key capabilities

| Capability | Description |
|---|---|
| **Pix transfers** | Send and receive instant BRL payments via Pix keys |
| **Balance & history** | Real-time account balance and transaction feed |
| **BR Code decode** | Parse Pix QR codes and Copia & Cola payloads |
| **MCP server** | First-class integration with AI agent hosts |
| **OAuth login** | Secure browser-based authentication flow |
| **Keyring storage** | Credentials stored in OS-native keychain |

## Agent Skill

Install the Bipa CLI skill to give your AI agent full knowledge of how to use Bipa CLI — including account setup, Pix payments, and all available tools:

```bash
npx skills add bipa-app/agentispay
```

The skill teaches your agent how to:
- Help users open a Bipa account and complete onboarding
- Install and authenticate the Bipa CLI CLI
- Make Pix payments, check balances, decode QR codes
- Analyze transaction history and detect patterns

You can also view the skill reference directly from the CLI:

```bash
bipa-cli skill
```

## Install

```bash
curl -fsSL https://agentispay.com/install.sh | sh
```

The managed installer places a launcher in `~/.local/bin/bipa-cli` and keeps versioned binaries under `~/.bipa-cli/`.

Optional flags:

```bash
# Custom binary directory
curl -fsSL https://agentispay.com/install.sh | sh -s -- --bin-dir /usr/local/bin

# Pin a specific version
curl -fsSL https://agentispay.com/install.sh | sh -s -- --version v0.1.2
```

## Quick start

```bash
# Authenticate (prints URL for agents, --open to launch browser)
bipa-cli login --web

# Install the MCP server for Claude Desktop
bipa-cli mcp install --client claude

# Check your balance
bipa-cli pix balance

# Send a Pix payment
bipa-cli pix pay --key alice@example.com --amount 25,00 --note "coffee" --agent-message "Paying Alice for coffee"

# View recent transactions
bipa-cli pix history --limit 5
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

A remote MCP server is also available at `https://mcp.agentispay.com/mcp` with automatic OAuth 2.1 authentication — no local install required.

## Releases

This repository hosts pre-built binaries for every release. The managed installer downloads from the [Releases](https://github.com/bipa-app/agentispay/releases) page.

| Platform | Architecture | Asset |
|---|---|---|
| macOS | Apple Silicon | `bipa-cli-vX.Y.Z-darwin-arm64.tar.gz` |
| macOS | Intel | `bipa-cli-vX.Y.Z-darwin-x64.tar.gz` |
| Linux | x86_64 | `bipa-cli-vX.Y.Z-linux-x64.tar.gz` |
| Linux | ARM64 | `bipa-cli-vX.Y.Z-linux-arm64.tar.gz` |

## Links

- **Website**: [agentispay.com](https://agentispay.com)
- **Docs**: [agentispay.com/docs](https://agentispay.com/docs)

## License

MIT — see [LICENSE](LICENSE) for details.
