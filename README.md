# \# OliverPay Entra ID Identity Lifecycle Management
# 
# \## Overview
# 
# This project demonstrates an identity lifecycle management
# solution using Microsoft Entra ID, Microsoft Graph PowerShell
# and PowerShell automation.
# 
# The lab models the lifecycle of employees from onboarding
# through departmental changes and eventual offboarding.
# 
# The project focuses on:
# 
# \- Joiner processes
# \- Mover processes
# \- Leaver processes
# \- Dynamic group membership
# \- Group-based application access
# \- Microsoft Graph automation
# \- App-only authentication
# \- Audit evidence
# \---
# 
# \## Architecture
# 
# ```text
# Employee Lifecycle
# &#x20;      |
# &#x20;      +-------------------+
# &#x20;      |                   |
# &#x20;      v                   v
# &#x20;   JOINER              MOVER
# &#x20;      |                   |
# &#x20;      v                   v
# &#x20;  Create User       Change Department
# &#x20;      |                   |
# &#x20;      v                   v
# &#x20;Dynamic Groups      Dynamic Groups
# &#x20;      |                   |
# &#x20;      v                   v
# &#x20;Application Access  Access Changes
# &#x20;      |
# &#x20;      |
# &#x20;      +--------------------+
# &#x20;                           |
# &#x20;                           v
# &#x20;                        LEAVER
# &#x20;                           |
# &#x20;                           v
# &#x20;                     Disable Account
# &#x20;                           |
# &#x20;                           v
# &#x20;                      LEAVER-HOLD
# &#x20;                           |
# &#x20;                           v
# &#x20;                        Audit Log
# &#x20;             Microsoft Graph
# &#x20;                    |

# &#x20;                    v

# &#x20;            PowerShell Automation

# &#x20;                    |

# &#x20;                    v

# &#x20;           App-only Authentication

