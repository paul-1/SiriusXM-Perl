# SiriusXM Perl Implementation - Installation Guide

## Quick Start

1. **Install Dependencies**
   ```bash
   sudo apt update
   sudo apt install libwww-perl libhttp-daemon-perl liburi-perl libmime-base64-perl
   ```

2. **Make Script Executable**
   ```bash
   chmod +x sxm.pl
   ```

3. **Test Installation**
   ```bash
   ./test_sxm.pl
   ```

4. **Run with Valid Credentials**
   ```bash
   ./sxm.pl your_username your_password -l
   ./sxm.pl your_username your_password -p 9999
   ```

## Systemd Service Setup

To run as a system service, create a systemd unit file:

```ini
[Unit]
Description=SiriusXM Perl Channel Service
Requires=network.target

[Service]
WorkingDirectory=/opt/sxm
Type=exec
ExecStart=/usr/bin/perl /opt/sxm/sxm.pl user password -p 8888
Restart=always
# Security settings
ProtectSystem=yes
ProtectKernelTunables=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
RestrictAddressFamilies=AF_INET AF_INET6 AF_UNIX
RestrictNamespaces=yes

[Install]
WantedBy=multi-user.target
```

For environment variable support:
```ini
[Service]
WorkingDirectory=/opt/sxm
EnvironmentFile=/opt/sxm/credentials
User=sxm
ExecStart=/usr/bin/perl /opt/sxm/sxm.pl dummy dummy -e -p 8888
```

Where `/opt/sxm/credentials` contains:
```
SXM_USER=your_username
SXM_PASS=your_password
```

## Features Comparison

| Feature | Python sxm.py | Perl sxm.pl |
|---------|---------------|-------------|
| Authentication | ✓ | ✓ |
| Channel listing | ✓ | ✓ |
| HLS streaming | ✓ | ✓ |
| Environment vars | ✓ | ✓ |
| Canadian region | ✓ | ✓ |
| Multi-level logging | ✗ | ✓ |
| Signal handling | Basic | Enhanced |
| Error handling | Basic | Comprehensive |
| Documentation | Minimal | Extensive |
| Type safety | Runtime | Compile-time |