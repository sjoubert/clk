#!/usr/bin/env python
# -*- coding:utf-8 -*-

import versioneer
from setuptools import setup, find_packages
import fasterentrypoint

versions = versioneer.get_versions()
version = versions["version"]
if version == u"0+unknown":
    version = u"sha:{}".format(versions["full-revisionid"])

cmdclass = versioneer.get_cmdclass()

setup(
    name='clk',
    cmdclass=cmdclass,
    version=version,
    author='Samuel Loury',
    author_email='konubinixweb@gmail.com',
    description='A framework to help you have an awesome CLI',
    packages=find_packages(),
    long_description="See https://clk-project.org/ or https://github.com/clk-project/clk",
    zip_safe=False,
    python_requires='>=3',
    install_requires=[
        "click>=6.4,<8",
        "click-log",
        "click-didyoumean",
        "click-completion>=0.5.0",
        "glob2",
        "colorama",
        "python-dateutil",
        "keyring",
        "tabulate",
        "networkx",
        "pydotplus",
        "pluginbase",
        "appdirs",
        "ipdb",
        "humanize",
        "Pygments",
        "cached-property",
        "requests",
    ],
    entry_points={'console_scripts': [
        'clk=clk.main:main',
    ]},
)
