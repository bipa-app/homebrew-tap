---
name: bipa
description: Use Bipa CLI to make Pix payments, check balances, analyze transaction history, and decode BR codes for AI agents. MUST use this skill whenever the user mentions paying someone via Pix, checking their balance, reviewing transactions, scanning a Pix QR code, setting up Bipa CLI, or asks the agent to handle any Brazilian instant payment. Also use when the user wants to automate recurring payments, detect duplicate transactions, or compose multi-step financial workflows. Use this skill even when the user just mentions "Pix", "Agentis", "BRL transfer", "pagamento", "saldo", or wants to send money to a CPF, email, phone, or CNPJ in Brazil.
---

# Bipa CLI

Bipa CLI gives AI agents the ability to make real Pix payments in Brazil. It works as a CLI tool and as an MCP server that exposes financial tools to any MCP-compatible agent.

Pix is Brazil's instant payment system — transfers settle in seconds, 24/7, free for individuals. Bipa CLI is built on Bipa's BCB-authorized financial infrastructure.

## First: Does the User Have a Bipa Account?

Before anything else, find out whether the user already has a Bipa account. Bipa CLI requires one. Ask directly:

> "Do you have a Bipa account? Bipa CLI uses Bipa as the underlying bank, so you'll need one to send/receive Pix."

### If they DON'T have an account → help them open one

Opening a Bipa account is free, takes ~5 minutes, and gives them access to:
- **Free Pix account** — send/receive instant BRL transfers 24/7
- **Buy & sell Bitcoin** — directly from the app
- **BTC/USDT/BRL collateralized credit card** — works with Apple Pay / Google Pay
- **Crypto rails** — Polygon, Ethereum, Bitcoin, Lightning Network

There are two paths to create a Bipa account:

#### Step 1: Register via web (agent can guide this)

Direct the user to **https://bipa.app/cadastro** — Bipa's web KYC flow. Walk them through it:

1. **CPF** — Enter their CPF (Brazilian tax ID, 11 digits). This starts the registration.
2. **Terms** — Accept Bipa's terms of service and privacy policy.
3. **Email** — Enter email, then verify with a 6-digit PIN sent to that email.
4. **Phone** — Enter phone number (Brazilian +55), then verify with a 6-digit PIN via SMS.
5. **Occupation** — Select occupation from a list.
6. **Income** — Declare monthly income range.
7. **PEP** — Declare if they are a politically exposed person (most people: "No").
8. **Address** — Enter CEP (postal code), the system auto-fills street/district. Add number + complement.
9. **Document verification** — Scan a QR code on their phone to take a selfie + photo of their ID document (RG or CNH). Bipa uses automated KYC verification.
10. **Processing** — Account is reviewed (usually approved within minutes).

**Requirements:**
- Valid Brazilian CPF
- Brazilian phone number (+55)
- Valid email address
- Brazilian residential address
- ID document (RG or CNH)

#### Step 2: Wait for approval

The user receives an email when their account is approved. They can also check by revisiting https://bipa.app/cadastro — the page reflects the current status.

#### Step 3: Activate the account in the Bipa app

This step requires the mobile app — it cannot be done on the web. The user must:

1. **Download the Bipa app**
   - iOS: https://apps.apple.com/br/app/bipa/id1560985113
   - Android: https://play.google.com/store/apps/details?id=app.bipa
2. **Log in** using the same phone number or email they registered with. Bipa sends a PIN to verify.
3. **Verify their identity** via liveness check (face authentication) to activate the new device.
4. **Complete in-app onboarding:**
   - **Create a Bipa Tag** — a unique username (like `@joao`) used as their identity on Bipa and for Lightning payments.
   - **Set a security PIN** — a numeric PIN for additional transaction security.
   - **Create their first Pix key** — this registers a Pix key (CPF, email, or phone) with the Central Bank so they can receive Pix transfers.

Once onboarding is complete, the account is fully active. The user can now receive Pix, buy/sell Bitcoin, and use all Bipa features.

#### Step 4: Connect to Bipa CLI

Now the user can log in to Bipa CLI and connect their agent. After this, they only need to open the Bipa app to approve or reject payments requested by their agent — everything else is automated.

### If they DO have an account → proceed to install & login

## Install Bipa CLI

```bash
# Managed installer (recommended for users and agents)
curl -fsSL https://agentispay.com/install.sh | sh
```

## Authenticate

Login now requires an explicit method flag:

```bash
# OAuth login — prints URL for agent-friendly workflows
bipa login --web

# OAuth login — opens browser automatically (human-friendly)
bipa login --web --open

# PIN-based login via email (two-step)
bipa login --pin --email user@example.com
bipa verify <PIN>

# PIN-based login via phone
bipa login --pin --phone "+55 11 99999 0000"
bipa verify <PIN>
```

Running `bipa login` without flags prints a usage summary.

For agents: prefer `--web` (prints the auth URL to stdout so you can present it to the user). For humans at the keyboard: use `--web --open`.

### Check session status

```bash
bipa whoami          # human-readable
bipa whoami -f json  # includes expires_at, expires_in_seconds, auth_method
```

## Set Up MCP for Claude Desktop

```bash
bipa mcp install --client claude
# Restart Claude Desktop to pick up the change
```

The MCP server reuses saved credentials. No tokens in config files.

Remote MCP is also available at `https://mcp.agentispay.com/mcp` with automatic OAuth 2.1 (for Claude.ai, ChatGPT, Cursor, VS Code, and other remote-capable clients).

## MCP Tools

| Tool | Description |
|---|---|
| `agentispay_pay` | Send a Pix payment (lookup + transfer in one call) |
| `agentispay_pix_send` | Alias for `agentispay_pay` |
| `agentispay_balance` | Current available balance in cents |
| `agentispay_history` | Transaction list (`limit?`, default 20, max 50) or detail by `id` |
| `agentispay_brcode_decode` | Decode a Pix QR / Copia e Cola string |
| `agentispay_deposit` | List deposit Pix keys |
| `agentispay_pix_keys` | List configured Pix keys |
| `agentispay_limits` | Transfer risk limits (daily and nightly) |
| `agentispay_account` | Account profile and metadata |
| `agentispay_whoami` | Session status (includes auth method and expiry) |

## CLI Commands

```
bipa pix pay --key <PIX_KEY> --amount <BRL> --agent-message "reason" [--note "memo"]
bipa pix pay --key <PIX_KEY> --amount-cents <CENTS> --agent-message "reason"
bipa pix pay --brcode <COPIA_E_COLA> --amount <BRL> --agent-message "reason"
bipa pix balance
bipa pix history [--limit N] [TRANSACTION_ID]
bipa pix brcode <BRCODE_STRING>
bipa pix keys
bipa pix deposit
bipa pix limits
bipa pix account
bipa whoami
bipa login --web [--open]
bipa logout
bipa skill
```

## Pix Key Types

Recipients are identified by Pix keys. The tool normalizes these automatically:

- **CPF**: `123.456.789-00` → `12345678900`
- **CNPJ**: `12.345.678/0001-99` → digits only
- **Phone**: `+55 (11) 99999-9999` → `5511999999999`
- **Email**: `alice@example.com` → as-is
- **EVP (random key)**: UUID like `550e8400-e29b-41d4-a716-446655440000`

Pass the key in any common format — normalization is handled internally.

## Critical Rules

1. **Pay includes recipient lookup.** `agentispay_pay` resolves the recipient automatically. Never try to look up a Pix key separately before paying.

2. **`agent_message` is required for every payment.** This text is shown to the human in the Bipa app during the approval step. Write a clear, honest explanation of why the agent is making this payment (e.g., "User asked me to pay João R$20 for lunch"). Payments without `agent_message` are rejected.

3. **Payments require human approval.** After calling `agentispay_pay`, the payment enters `awaiting_approval` status. The user must approve it in the Bipa mobile app via biometric (Face ID / Touch ID). Always inform the user and suggest checking `agentispay_history` later.

4. **Amounts.** MCP takes `amount_cents` (integer, must be > 0). CLI takes `--amount` in BRL (e.g., `12.34` or `12,34`) or `--amount-cents`. "R$50" = `amount_cents: 5000`.

5. **Idempotency is automatic.** The system generates unique keys internally. No need to pass `request_id` or `idempotency_key`.

6. **Never search Pix keys without payment intent.** Only resolve keys when the user explicitly wants to pay.

## Workflows

### Pay Someone

User: "Pay João R$20 for lunch"

**MCP:**
```json
{
  "name": "agentispay_pay",
  "arguments": {
    "key": "joao@email.com",
    "amount_cents": 2000,
    "note": "lunch",
    "agent_message": "User asked me to pay João R$20 for lunch"
  }
}
```

Response:
```json
{
  "status": "awaiting_approval",
  "key": "joao@email.com",
  "owner_name": "João Silva",
  "amount_brl": "R$ 20.00",
  "note": "lunch",
  "message": "Payment submitted. The user must approve this operation in the Bipa app. Use agentispay_history to check the transaction status."
}
```

Tell the user: *"I've submitted the R$20 payment to João Silva. Please approve it in the Bipa app."*

**CLI:**
```bash
bipa pix pay --key joao@email.com --amount 20 --note "lunch" --agent-message "Paying João for lunch"
```

### Pay a QR Code / Copia e Cola

**Direct pay (when amount is known):**
```bash
bipa pix pay --brcode "<COPIA_E_COLA>" --amount 50 --agent-message "Paying invoice from QR code"
```

**Decode first (when you need to read the details):**
1. `agentispay_brcode_decode` with the raw string
2. Read decoded fields: tag `54` = amount, tag `26` = merchant info (contains Pix key), tag `59` = merchant name, tag `60` = city
3. Pay with `agentispay_pay` using extracted key and amount

### Financial Snapshot

1. `agentispay_balance` → `available_cents`
2. `agentispay_history` (limit: 20) → recent transactions with `direction` (credit/debit), amounts, counterparty names, timestamps (BRT)

Present a clean summary: balance in R$, last transactions grouped by direction.

### Detect Recurring / Duplicate Transactions

1. `agentispay_history` with `limit: 50` (maximum)
2. Group by counterparty name and direction
3. Flag same-counterparty + same-amount entries

### Check Limits Before Large Transfers

`agentispay_limits` returns `daily_limit_cents`, `nightly_limit_cents`, and reset timeframes. Present these before big payments so the user knows if it'll go through.

## Error Handling

| Error | What to do |
|---|---|
| `recipient key was not found` | Ask user to verify the key |
| `recipient key is flagged as fraudulent` | Do not retry. Inform user. |
| `recipient key lookup was rate-limited` | Wait and retry |
| `amount_cents must be greater than zero` | Check amount conversion |
| `agent_message is required` | Always include why the agent is paying |
| `rate limit exceeded` | Wait `retry_after_seconds` then retry |
| `no active Bipa CLI session` | Run `bipa login --web` |
| `session expired` | Run `bipa login --web` again |

## Transaction Statuses

- `awaiting_approval` — waiting for user approval in Bipa app
- `scheduled` — approved, queued for settlement
- `succeeded` / `confirmed` — settled
- `pending` — in progress
- `failed` — transfer failed
- `created` — initial state

## Key Facts

- All amounts in BRL. MCP uses cents (integer). CLI accepts BRL decimals and cents.
- Transactions show `credit` (in) and `debit` (out) directions.
- Timestamps in BRT (UTC-3).
- Rate limits: 5 payments/min, 20 brcode decodes/min.
- Credentials stored in OS keychain (macOS Keychain, Windows Credential Manager).
- Transaction details include structured `sections` with labeled fields for full receipt info.
- Bipa CLI currently supports Pix. Bitcoin, stablecoins (USDC/USDT), and Lightning are coming soon via the same Bipa infrastructure.
