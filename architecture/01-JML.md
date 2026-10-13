# OliverPay Identity Lifecycle Management Architecture

## 1. Project Overview

The OliverPay Identity Lifecycle Management Lab demonstrates
employee identity lifecycle management using Microsoft Entra ID,
Microsoft Graph PowerShell, security groups, dynamic groups and
application access.

The project models three primary employee lifecycle events:

- Joiner
- Mover
- Leaver

The lab also demonstrates automation using Microsoft Graph
PowerShell and certificate-based app-only authentication.

---

## 2. Architecture

```text
                         Employee Lifecycle
                                |
              +-----------------+-----------------+
              |                 |                 |
              v                 v                 v
           JOINER             MOVER            LEAVER
              |                 |                 |
              v                 v                 v
        Create User       Change Attributes    Disable User
              |                 |                 |
              v                 v                 v
       Department Rule    Dynamic Group      LEAVER-HOLD
              |                 |                 |
              v                 v                 v
       Dynamic Group      Access Changes       Audit Log
              |                 |
              v                 v
       Application Access
              
                         Microsoft Entra ID
                                |
                                v
                       Microsoft Graph API
                                |
                                v
                       PowerShell Automation
                                |
                                v
                 App-only Certificate Authentication