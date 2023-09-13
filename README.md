# OpenRail - A wrapper to OpenROAD

Currently, just some experiments with OpenROAD and raven-picorv32.

Only dependency needed is docker. I provide my own [docker image](https://hub.docker.com/repository/docker/killruana/openroad/general) for OpenROAD.


Implement the design for all supported platform:

```shell
$ make  # or make all
```

Implement the design for a specific platform:

```shell
$ make nangate45
$ make sky130hd
$ make sky130hs
```

Starting a container and manually implementing a design:

```shell
$ make shell
(docker) $ make DESIGN_CONFIG=./designs/skyhd130/raven-picorv32/config.mk
```