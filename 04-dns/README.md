# DNS Configuration

This section documents the DNS configuration completed in the `lab.local` Active Directory environment.

The DNS role is installed on the domain controller, **DC01**, and provides name resolution for the lab network.

## Environment

| System | Operating System | IP Address | Role |
|---|---|---:|---|
| DC01 | Windows Server 2025 | 192.168.222.20 | Domain Controller and DNS Server |
| WIN11-01 | Windows 11 Pro | 192.168.222.30 | Domain-joined client |

**Domain:** `lab.local`  
**Network:** `192.168.222.0/24`

---

## Objectives

The objectives of this configuration were to:

- Verify the existing forward lookup zone
- Create a reverse lookup zone
- Create PTR records for the server and client
- Verify forward and reverse DNS resolution
- Resolve the `Server: Unknown` result displayed by `nslookup`

---

## Forward Lookup Zone

The `lab.local` forward lookup zone was created automatically when Active Directory Domain Services and DNS were configured.

The zone contains host records for:

- `DC01.lab.local` → `192.168.222.20`
- `WIN11-01.lab.local` → `192.168.222.30`
- `files.lab.local` → `192.168.222.20`

The `files.lab.local` record provides a friendly DNS name for accessing file-server resources hosted on DC01.

---

## Reverse Lookup Zone

A new IPv4 reverse lookup zone was created for the lab subnet.

The following network ID was used:

```text
192.168.222