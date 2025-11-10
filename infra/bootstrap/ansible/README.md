# HomeLab Ansible Deployment

Ansible deployment setup for HomeLab infrastructure.

## Setup

1. Create and activate virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

## Usage

### Run full deployment (base packages + Docker + updates)
```bash
ansible-playbook -i inventories/development playbooks/site.yml
```

### Run specific roles
```bash
# Update packages only
ansible-playbook -i inventories/development playbooks/site.yml --tags update_packages

# Install base packages only
ansible-playbook -i inventories/development playbooks/site.yml --tags base_packages

# Install Docker only
ansible-playbook -i inventories/development playbooks/site.yml --tags docker

# Configure system (users, SSH keys, sudo)
ansible-playbook -i inventories/development playbooks/site.yml --tags system_config
```

## Structure

```
.
├── inventories/
│   └── development/
│       ├── hosts
│       ├── ssh_keys/
│       │   ├── smonaghan
│       │   
│       └── group_vars/
│           └── all/
│               └── main.yml
├── playbooks/
│   ├── site.yml
│   └── roles/
│       ├── system_config/
│       ├── base_packages/
│       ├── docker/
│       └── update_packages/
├── requirements.txt
├── ansible.cfg
└── README.md
```

## Environment

- **Development**: 192.168.178.4 Static -> Home network

## Roles


- **base_packages**: Installs essential system packages
- **docker**: Installs and configures Docker 
- **update_packages**: Updates all system packages

## System Configuration

The `system_config` role handles:
- User creation (smonaghan)
- SSH key deployment from `inventories/development/ssh_keys/`
- Passwordless sudo access
- SSH security hardening (disables root login, password auth)
- System settings (timezone, sysctl, ulimits)
- Optional fail2ban installation

