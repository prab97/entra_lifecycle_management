# Mover Scenario

## Scenario

Arjun Chauhan transfers from Engineering to Finance.

## Before the Move

Department:

Engineering

Dynamic group:

SEC-DYN-Engineering

Application:

OliverPay Engineering Portal

Access flow:

Arjun Chauhan
    ↓
Engineering
    ↓
SEC-DYN-Engineering
    ↓
Engineering Portal

## Change

John's organizational attributes are updated:

Department:
Finance

Job title:
Financial Systems Analyst

## After the Move

Dynamic group:

SEC-DYN-Finance

Application:

OliverPay Finance Portal

Access flow:

Arjun Chauhan
    ↓
Finance
    ↓
SEC-DYN-Finance
    ↓
Finance Portal

## Expected Access Change

John should no longer be a member of
SEC-DYN-Engineering after the dynamic membership
evaluation.

John should become a member of SEC-DYN-Finance.

## IAM Principle

Application access is determined by group membership,
while group membership is driven by the user's organizational
attributes.

This reduces manual access administration during employee
transfers.

Current Process is attribute-driven: 

Admin/HR
   ↓
Changes user's attributes
   ↓
Entra dynamic group evaluates
   ↓
Membership changes
   ↓
Application access changes