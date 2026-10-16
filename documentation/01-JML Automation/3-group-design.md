# Group Design

## Purpose

The lab uses Microsoft Entra security groups to represent
department-based access boundaries.

## Assigned Groups

The following groups were initially created with assigned membership:

- SEC-Engineering
- SEC-Finance
- SEC-HR
- SEC-Sales
- SEC-IT

These groups demonstrate manually managed group membership.

## Dynamic Groups

Dynamic security groups were created to demonstrate
attribute-based membership:

- SEC-DYN-Engineering
- SEC-DYN-Finance
- SEC-DYN-HR
- SEC-DYN-Sales
- SEC-DYN-IT

Dynamic membership is based on the user's Department attribute.

Example:

user.department -eq "Engineering"

## Mover Scenario

When a user's department changes, dynamic group membership
can change automatically after Microsoft Entra evaluates the
updated user attributes.

Example:

Engineering → Finance

The user's membership in the Engineering dynamic group is
removed when the Department attribute no longer matches.