# Lifecycle Workflow

## Workflow

LAB - Employee Leaver Offboarding

## Purpose

Automate the offboarding process for employees leaving
OliverPay.

## Scope

The workflow is restricted to a dedicated lab population:

LAB-Lifecycle-Test-Users

This prevents accidental changes to unrelated tenant users.

## Trigger

The workflow uses the employee leave lifecycle information
to identify users entering the offboarding process.

## Workflow Model

Employee Leave Event
        ↓
Lifecycle Workflow
        ↓
Offboarding Tasks
        ↓
Account / Access Actions
        ↓
Execution History

## Testing

A dedicated test user was used to validate the workflow.

Test user:

Liam Carter

The workflow execution was reviewed using the lifecycle
workflow execution/history information.

## Security Considerations

The workflow is scoped to test users rather than the entire
tenant.

This reduces the risk of unintended changes during testing.

## Evidence

Screenshots are stored in the screenshots directory.

## My Learnings 

### Microsoft Graph API & PowerShell Fundamentals
* Tenant ID vs. Object ID: The Tenant ID represents the entire organization's directory structure, while the Object ID (GUID) points to a specific resource or user account within that tenant.

* Permission Scopes: Holding the Global Administrator role is insufficient on its own; the active PowerShell session must explicitly request the required API scopes (e.g., User-LifeCycleInfo.ReadWrite.All) when executing Connect-MgGraph.

* Bypassing UPN Resolution Errors: A 404 (NotFound) error when running commands against a User Principal Name (UPN) is frequently caused by subtle typos in the domain string (e.g., Birmignham vs. Birmingham). Searching for the user's exact Object ID (GUID) and using it in the command bypasses string resolution and guarantees an exact match.

### Lifecycle Workflows & Group Management
* Static vs. Dynamic Groups: Native Lifecycle Workflow tasks like "Remove user from all groups" only process standard static group assignments. They skip Dynamic Groups because those memberships are strictly governed by underlying attribute rules rather than manual membership lists.

* Automating Dynamic Group Eviction: To successfully evict a leaver from a dynamic group (e.g., a Finance group), the workflow must include an Update user attributes task. This task clears or updates the specific property powering the dynamic rule (e.g., setting the Department attribute to blank) so the user no longer meets the inclusion criteria.

### Dynamic Group Evaluation Behavior
* Dynamic Group Evaluation Behavior
Background Processing Delays: Executing an attribute update does not instantly update dynamic group membership. Entra ID relies on background evaluation cycles to recalculate rules, which typically takes between 5 and 30 minutes to reflect in the directory.

* Forcing Immediate Evaluation: You can bypass the background wait time in the Entra Admin Center. Navigating to the group's Dynamic membership rules, checking the user in the Validate rules tab (which will show a red X if they no longer match), and clicking Save queues an immediate, priority recalculation of the group's members.