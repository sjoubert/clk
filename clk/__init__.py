#!/usr/bin/env python
# -*- coding:utf-8 -*-

from __future__ import print_function, absolute_import

# keep it at the begin in order to get an accurate startup time
from datetime import datetime

startup_time = datetime.now()

from clk import monkeypatch  # NOQA: E402
from clk import log  # NOQA: E402
from clk.overloads import entry_point  # NOQA: E402

monkeypatch.do()

LOGGER = log.get_logger(__name__)
log.basic_config(LOGGER)
LOGGERS = {LOGGER}