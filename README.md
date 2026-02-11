# Terraform Codebase Analysis

## 1) What this project is for

This Terraform project builds an **Azure hub-and-spoke network architecture** with these environments:

- **Hub** (central shared environment)
- **Clinical**
- **Non-Clinical**
- **Velocity**
- **Gateway** (contains Palo Alto firewall VM and gateway-related subnets)

Then it connects all of them using:

- **VNet peering**
- **Route tables**
- **A VPN Gateway in hub**

So, this is an infrastructure-as-code setup for a multi-network Azure environment.

---

## 2) Root-level files (top of repo)

### `provider.tf`
- Sets Terraform version and Azure provider (`azurerm` 4.54.0).
- Configures Azure authentication fields (`subscription_id`, `client_id`, etc.).
- Has provider features for resource groups.

### `main.tf`
This is the main orchestrator. It:
1. Creates one resource group for each environment.
2. Calls networking modules for each environment.
3. Calls compute modules to create VMs.
4. Calls extensions modules to configure VMs (timezone/software actions).
5. Calls gateway modules.
6. Calls `peering` module to connect all networks and add routing.

### `variable.tf`
- Defines all root input variables.
- Includes resource group names/locations for each environment.
- Includes VM maps (`hub_vms`, `clinical_vms`, etc.) and jump VM maps.
- Contains gateway location/resource-group variables too.

### `terraform.tfvars`
- Example/default environment values.
- Most VM map examples are commented out (templates for users).
- Shows expected shape of VM objects (size, image, private IP, subnet type, etc.).

### `outputs.tf`
- Currently empty (no root outputs defined).

---

## 3) Folder/module structure

The code is organized by environment and concern:

- `hub/`
  - `networking/`
  - `compute/`
  - `extensions/`
- `clinical/`
  - `networking/`
  - `compute/`
  - `extensions/`
- `non_clinical/`
  - `networking/`
  - `compute/`
  - `extensions/`
- `velocity/`
  - `networking/`
  - `compute/`
  - `extensions/`
- `gateway/`
  - `networking/`
  - `compute/`
- `peering/`

Each module has:
- `main.tf` → resources
- `variable.tf` → inputs
- `outputs.tf` → outputs (where needed)

---

## 4) Networking modules (what they create)

## Hub networking (`hub/networking`)
Creates:
- Hub VNet
- Hub subnets:
  - management subnet
  - shared subnet
  - gateway subnet
- NAT Gateway + Public IP
- NAT association to shared subnet

Exports IDs and names for use by other modules.

## Clinical networking (`clinical/networking`)
Creates:
- Clinical VNet
- Three subnets:
  - management
  - shared subnet 1
  - shared subnet 2
- NAT Gateway + Public IP
- NAT association

Exports VNet/subnet IDs.

## Non-clinical networking (`non_clinical/networking`)
Creates:
- Non-clinical VNet
- Three subnets:
  - management
  - shared subnet 1
  - shared subnet 2

Exports VNet/subnet IDs.

## Velocity networking (`velocity/networking`)
Creates:
- Velocity VNet
- Two subnets:
  - management
  - shared subnet 1

Exports VNet/subnet IDs.

## Gateway networking (`gateway/networking`)
Creates:
- Gateway VNet
- Specialized subnets for firewall/networking:
  - management
  - trust
  - untrust
  - gateway
  - custom
  - dev

Exports VNet/subnet IDs.

---

## 5) Compute modules (what they create)

## Hub/Clinical/Non-clinical/Velocity compute
These modules are very similar. They:

1. Merge `jumpvms` + `vms` into one internal map.
2. Create NSGs (management and shared).
3. Optionally create Public IPs for VMs with `attach_public_ip = true`.
4. Create NICs and attach to proper subnet based on `subnet_type`.
5. Associate NICs with NSGs.
6. Create Windows and Linux VMs using `for_each`.
7. Add a 10GB managed data disk and attach it.
8. Output maps of VM IDs by OS and location map.

### Important behavior
- `subnet_type` drives subnet selection.
- `os_type` decides Windows vs Linux VM resource.
- Some image fields are hardcoded in module resources (not always using variable image fields directly).

## Gateway compute (`gateway/compute`)
Creates a **Palo Alto VM-Series BYOL firewall** setup:
- Public IP for management NIC.
- Management NSG allowing HTTPS/SSH inbound.
- Three NICs:
  - management
  - trust
  - untrust (with IP forwarding enabled)
- Linux VM resource using Palo Alto marketplace image and plan.

Also outputs firewall management public IP.

---

## 6) Extensions modules (post-VM config)

Exists for hub/clinical/non-clinical/velocity.

They mainly do:
- Timezone mapping by Azure region.
- Validation (using `null_resource` preconditions) to fail early if a region timezone is missing.
- Windows VM extension for setting timezone on jump VMs.
- Linux VM extension (custom script) for timezone setting when `install_software = true`.
- Some optional software-install logic is present but commented out.

Simple meaning: after VM creation, these modules apply extra OS-level settings.

---

## 7) Peering module (`peering/`)

This is the connectivity brain of the project.

It creates:

1. **Hub VPN Gateway** (public IP + virtual network gateway in hub).
2. **Route tables** for gateway, velocity, clinical, and non-clinical VNets.
3. **Subnet route table associations** so subnets actually use those routes.
4. **VNet peerings**:
   - Hub ↔ Gateway
   - Hub ↔ Clinical
   - Hub ↔ Non-Clinical
   - Hub ↔ Velocity
   - Gateway ↔ Clinical
   - Gateway ↔ Non-Clinical
   - Gateway ↔ Velocity

Gateway transit flags are set where needed:
- Hub side allows gateway transit.
- Spokes use remote gateways.

In plain terms: this module wires all network islands together and defines traffic directions.

---

## 8) How data flows between modules

1. Root `main.tf` creates resource groups.
2. Root calls each `networking` module.
3. Networking outputs subnet/VNet IDs.
4. Root passes those IDs into `compute` modules.
5. Compute outputs VM IDs + locations.
6. Root passes VM IDs/locations into `extensions` modules.
7. Root passes all VNet/subnet details to `peering` module.

So each module depends on outputs from previous layers.

---

## 9) Component-by-component quick map

- **Provider config** → `provider.tf`
- **Environment orchestration** → `main.tf`
- **Input contract** → `variable.tf`
- **Environment values/examples** → `terraform.tfvars`
- **Hub network** → `hub/networking`
- **Hub VMs** → `hub/compute`
- **Hub VM configuration** → `hub/extensions`
- **Clinical network/VMs/extensions** → `clinical/*`
- **Non-clinical network/VMs/extensions** → `non_clinical/*`
- **Velocity network/VMs/extensions** → `velocity/*`
- **Gateway network** → `gateway/networking`
- **Palo Alto firewall VM** → `gateway/compute`
- **Cross-network peering and routing** → `peering`

---

## 10) Good things in this code

- Clear modular structure.
- Reusable VM patterns using `for_each` maps.
- Explicit subnet CIDRs and naming.
- Route and peering logic centralized in one place.
- Validation checks for missing timezone mappings.

---

## 11) Things to review/improve

- `provider.tf` currently keeps credential fields in code. Better to use environment variables, managed identity, or secure CI secrets.
- Root `outputs.tf` is empty; adding key outputs (resource groups, vnet ids, firewall public ip) would help users.
- Some VM image fields in input objects may not be fully used if module hardcodes image references.
- In compute modules, public IP logic for mgmt subnet should always align with `attach_public_ip` setting to avoid mismatch.

---

## 12) In one sentence

This repository is a Terraform blueprint that builds a multi-environment Azure hub-and-spoke network with VMs, firewall gateway, and full peering/routing connectivity.
