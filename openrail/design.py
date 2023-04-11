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
from pathlib import Path
from typing import Optional, Sequence

import tomlkit


class Design:
    def __init__(
        self,
        name: str,
        path: Path,
        top_name: Optional[str] = None,
        verilog_files: Optional[Sequence[Path]] = None,
    ) -> None:
        self.name = name
        self.path = path
        self.top_name = top_name if top_name is not None else self.name
        self.verilog_files = (
            list(verilog_files) if verilog_files is not None else []
        )

    def save(self):
        data = {}
        data["design"] = {}
        data["design"]["name"] = self.name
        data["design"]["top_name"] = self.top_name
        data["design"]["verilog_files"] = list(map(str, self.verilog_files))

        with (self.path / "design.toml").open("w") as f:
            tomlkit.dump(data, f)
