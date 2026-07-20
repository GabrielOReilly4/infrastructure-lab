\# 01 - Active Directory



\## Overview



The objective of this project was to deploy a Windows Server 2025 Active Directory environment from scratch in a VMware home lab.



The environment simulates a small business infrastructure where users authenticate against a centralized domain controller, access shared resources based on security groups, and receive configuration through Group Policy.



\---



\## Lab Environment



| Machine | Operating System | Purpose |

|----------|------------------|----------|

| DC01 | Windows Server 2025 | Domain Controller, DNS Server, File Server |

| WIN11-01 | Windows 11 Enterprise | Domain-joined workstation |



Domain Name:



```

lab.local

```



\---



\## Objectives



\- Deploy Active Directory Domain Services (AD DS)

\- Configure DNS

\- Create an Organizational Unit (OU) structure

\- Create users and security groups

\- Join a Windows 11 workstation to the domain

\- Verify domain authentication

\- Prepare the environment for File Server and Group Policy projects



\---



\## Architecture



\*(Network diagram will be added later.)\*



\---



\## Configuration Steps



\### 1. Installed Server Roles



The Windows Server was configured with the following roles:



\- Active Directory Domain Services

\- DNS Server

\- File and Storage Services



!\[Installed Roles](screenshots/server-manager-installed-roles.png)



\---



\### 2. Organizational Unit Structure



To keep the directory organized, the following Organizational Units were created:



\- OU\_Users

\- OU\_Groups

\- OU\_Computers

\- OU\_Workstations

\- OU\_Servers



!\[OU Structure](screenshots/organizational-units.png)



\---



\### 3. Users and Security Groups



Created the following security groups:



\- IT

\- HR

\- Finance

\- IT\_Admins



Created the domain user:



\- gmello



The user was added to the appropriate security groups for role-based access.



!\[User Membership](screenshots/gmello-group-membership.png)



!\[IT Group Members](screenshots/it-group-members.png)



\---



\### 4. DNS Configuration



After promoting the server to a Domain Controller, the DNS Forward Lookup Zone was created automatically.



The workstation successfully registered its A record after joining the domain.



!\[DNS](screenshots/dns-forward-lookup-zone.png)



\---



\### 5. Domain Join



The Windows 11 workstation successfully joined the `lab.local` domain.



Users can authenticate using domain credentials.



!\[Domain Login](screenshots/domain-login.png)



\---



\### 6. Authentication Test



Authentication was verified from the Windows 11 workstation.



Commands executed:



```cmd

whoami

echo %LOGONSERVER%

```



Results:



\- Authenticated user: `LAB\\gmello`

\- Logon server: `\\\\DC01`



!\[Authentication](screenshots/domain-user-authentication.png)



\---



\## Skills Demonstrated



\- Windows Server Administration

\- Active Directory Deployment

\- DNS Configuration

\- Organizational Unit Design

\- User and Group Management

\- Domain Join

\- Authentication Verification

\- VMware Workstation



\---



\## Next Project



The next stage of the lab focuses on deploying a centralized File Server with:



\- Department shared folders

\- NTFS permissions

\- Share permissions

\- Access control using Active Directory security groups

