# Access Model

## Principle

Application access is assigned to security groups rather than
individual users.

## Engineering

Department:

Engineering

Dynamic group:

SEC-DYN-Engineering

Application:

OliverPay Engineering Portal

Access flow:

User → Department → Dynamic Group → Application

## Finance

Department:

Finance

Dynamic group:

SEC-DYN-Finance

Application:

OliverPay Finance Portal

Access flow:

User → Department → Dynamic Group → Application

## Mover Scenario

When a user's department changes, dynamic group membership is
reevaluated.

Example:

Engineering → Finance

Expected result:

1. User leaves SEC-DYN-Engineering.
2. User joins SEC-DYN-Finance.
3. Engineering application access is removed.
4. Finance application access becomes available.

This demonstrates attribute-driven access management.

              IDENTITY LIFECYCLE
                     │
       ┌─────────────┼─────────────┐
       ↓             ↓             ↓
    JOINER         MOVER         LEAVER
       │             │             │
       ↓             ↓             ↓
   New user      Department      User leaves
                  changes            │
       │             │               ↓
       ↓             ↓           Disable
   Provision     Recalculate      account
       │          access             │
       ↓             │               ↓
   Group/access      ↓           Remove access
                  Update             │
                                    ↓
                              Lifecycle Workflow