# MultiMICO init
Bootstrap Hooks for Host Initialisation

The MultiMICO init procedure provides a bootstrapping code for initialising our edge cluster infrastructure. 

The repository has 2 main branches: 

The `main` branch provides the core bootstrapping code for all our infrastructure. 

The `cloud-init` branch is used by the boot image from the image customisation tool to trigger the bootstrapping process defined in the `main` branch. 