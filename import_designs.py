#!/usr/bin/env python3
import itertools
import shlex
import shutil
from pathlib import Path

openroad_path = Path("../openroad")
openroad_flow_path = openroad_path / "flow"
designs_path = openroad_flow_path / "designs"
designs_src_path = designs_path / "src"
platforms_path = openroad_flow_path / "platforms"

# Extract the list of supported platforms
platforms = set(
    map(
        lambda p: p.name,
        filter(
            lambda p: (p / "config.mk").is_file(), platforms_path.iterdir()
        ),
    )
)

# Extract the list of supported designs
designs = set(
    map(lambda p: p.name, filter(Path.is_dir, designs_src_path.iterdir()))
)

# Extract the list of implemented platform for each design
implementations = {}
for platform_path in filter(
    lambda p: p.is_dir() and p.name in platforms, designs_path.iterdir()
):
    for design_path in filter(
        lambda p: p.name in designs and (p / "config.mk").exists(),
        platform_path.iterdir(),
    ):
        try:
            implementations[design_path.name].add(platform_path.name)
        except KeyError:
            implementations[design_path.name] = {platform_path.name}


def parse_config_mk(path: Path):
    config = {}

    stream = list(shlex.shlex(path.read_text()))
    i = 0
    stream_len = len(stream)
    while i < stream_len:
        if stream[i] == "export":
            i += 1
            key = stream[i]
            i += 2

            start = i
            while i < stream_len and stream[i] != "export":
                i += 1
            value = stream[start:i]
            config[key] = value
        else:
            i += 1

    return config


# Extract the implemented designs
out_designs_path = Path(__file__).parent / ".." / "designs"
for design, platforms_ in implementations.items():
    print(design)
    design_path = designs_src_path / design
    out_design_path = out_designs_path / design
    if out_design_path.exists():
        shutil.rmtree(out_design_path)

    # Copy README and LICENSE files
    for path in itertools.chain.from_iterable(
        map(design_path.glob, ["**/README*", "**/LICENSE*"])
    ):
        out_path = out_design_path / path.relative_to(design_path)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(path, out_path)

    # Copy verilog files
    for in_path in itertools.chain.from_iterable(
        map(design_path.glob, ["**/*.v"])
    ):
        path = in_path.relative_to(design_path)
        out_rtl_path = out_design_path / "rtl"
        out_path = out_rtl_path / path
        out_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(in_path, out_path)

    # Copy platform implementation files
    top_name = None
    for platform in platforms_:
        print(platform)
        in_path = designs_path / platform / design
        out_path = out_design_path / "impls" / platform
        shutil.copytree(in_path, out_path)
