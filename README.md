# MultiMICO init

Bootstrap Hooks for Host Initialisation

## Purpose 

When setting up barebone hardware infrastructure, we cannot rely on the fancy tools of cloud providers and shiny MAAS tools often require additional infrastructure, which makes it impractical in smaller or in distributed settings. Yet, we want to build on the principles of Infrastructure as Code even for bootstrapping infrastructures in less sophisticated settings such as home labs, edge clusters, or fog computing systems.

The MultiMICO init procedure provides a bootstrapping code for bootstrapping different edge computing infrastructure based on hardware MAC addresses based on the principles of [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code). The repositry provides the anchor for the Boot images produced by the [MultiMICO Imager](https://github.com/multimico/imager).

This bootstrap repository is the initial anchor for the bootstrapping process before a system is available to more advanced tools such as Ansible. This repository uses configuration files in the `config` directory to determine a system's targeted purpose and which secondary bootstrapping code should be used for preparing it for this purpose.

## Repository organisation

The repository has 2 main branches: 

The `main` branch provides the core bootstrapping code for all our infrastructure. 

The `cloud-init` branch is used by the boot image from the image customisation tool to trigger the bootstrapping process defined in the `main` branch. 

## Secondary bootstrapping

- [LXD Host setup with OVS networking](https://github.com/multimico/lxd-host)