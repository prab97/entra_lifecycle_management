# Joiner Scenario

## Scenario

John Miller joins OliverPay as a Software Engineer.

## Identity Attributes

- Department: Engineering
- Job title: Software Engineer
- Account type: Member
- Administrative role: None

## Expected Access Flow

John Miller
    ↓
Department = Engineering
    ↓
SEC-DYN-Engineering
    ↓
OliverPay Engineering Portal

## Expected Result

John should automatically become a member of
SEC-DYN-Engineering based on his Department attribute.

Because the Engineering application is assigned to the
SEC-DYN-Engineering group, John receives the corresponding
application access through group membership.

## IAM Principle

Access is assigned to a group rather than directly to the
individual user.

This reduces the need for manual application assignments
when employees join the organization.