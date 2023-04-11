# OpenRAIL: OpenROAD flows automation
# Copyright (C) 2023  Jonathan Tremesaygues <jonathan.tremesaygues@slaanesh.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
import logging
import shutil
from argparse import ArgumentParser, Namespace
from pathlib import Path
from typing import Optional, Sequence

from openrail.design import Design

logger = logging.getLogger(__name__)


def cmd_design_new(args: Namespace):
    output_dir = Path(args.directory) if args.directory is not None else Path()

    design_dir_path = output_dir / args.name

    # Create the design objects
    design = Design(
        name=args.name,
        path=design_dir_path.resolve(),
        top_name=args.top,
        verilog_files=[Path("rtl") / Path(f).name for f in args.verilog_files],
    )

    # Copy verilog files
    out_rtl_path = design_dir_path / "rtl"
    out_rtl_path.mkdir(parents=True, exist_ok=True)
    for verilog_file in (Path(f) for f in args.verilog_files):
        print(verilog_file)
        shutil.copy(verilog_file, out_rtl_path / verilog_file.name)

    # Create the design dir
    if design_dir_path.exists():
        logger.warning("%s already exists", design_dir_path)
    design_dir_path.mkdir(parents=True, exist_ok=True)

    # Save design.toml
    design.save()


def main(args: Optional[Sequence[str]] = None) -> None:
    parser = ArgumentParser()
    sub_parsers = parser.add_subparsers(required=True)

    ## Design
    design_parser = sub_parsers.add_parser(
        "design", help="Design related commands"
    )
    design_sub_parsers = design_parser.add_subparsers()

    # Design create
    design_new_parser = design_sub_parsers.add_parser("new")
    design_new_parser.add_argument(
        "-d",
        "--directory",
        default=None,
        help="Directory in which create the design folder",
    )
    design_new_parser.add_argument(
        "-t", "--top", default=None, help="Name of the top module"
    )
    design_new_parser.add_argument(
        "--verilog-files",
        nargs="*",
        default=None,
        help="Name of the top module",
    )
    design_new_parser.add_argument("name")
    design_new_parser.set_defaults(func=cmd_design_new)

    # Parse args and run command
    parsed_args = parser.parse_args(args)
    parsed_args.func(parsed_args)
