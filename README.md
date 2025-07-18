
fork INFO
=========

This coreboot fork includes ongoing work for the [ASRock E3C246D4I](https://www.asrockrack.com/general/productdetail.asp?Model=E3C246D4I-2T#Specifications) server mainboard based on a port by [Arthur Heymans](https://github.com/arthurheymans)

A detailed usage guide is available here: 
[Revisiting open-source firmware on the e3c246d4i](https://vandermeij.tech/revisiting-open-source-firmware-on-the-e3c246d4i.html)

coreboot README
===============

coreboot is a Free Software project aimed at replacing the proprietary
firmware (BIOS/UEFI) found in most computers. coreboot performs the
required hardware initialization to configure the system, then passes
control to a different executable, referred to in coreboot as the
payload. Most often, the primary function of the payload is to boot the
operating system (OS).

With the separation of hardware initialization and later boot logic,
coreboot is perfect for a wide variety of situations. It can be used
for specialized applications that run directly in the firmware, running
operating systems from flash, loading custom bootloaders, or
implementing firmware standards, like PC BIOS services or UEFI. This
flexibility allows coreboot systems to include only the features
necessary in the target application, reducing the amount of code and
flash space required.

### Copyrights

The copyright on coreboot is owned by quite a large number of individual
developers and companies. A list of companies and individuals with known
copyright claims is present at the top level of the coreboot source tree
in the 'AUTHORS' file. Please check the git history of each of the
source files for details.


### Licenses

Because of the way coreboot began, using a significant amount of source
code from the Linux kernel, it's licensed the same way as the Linux
Kernel, with GNU General Public License (GPL) Version 2. Individual
files are licensed under various licenses, though all are compatible
with GPLv2. The resulting coreboot image is licensed under the GPL,
version 2. All source files should have an SPDX license identifier at
the top for clarification.

Files under coreboot/Documentation/ are licensed under CC-BY 4.0 terms.
As an exception, files under Documentation/ with a history older than
2017-05-24 might be under different licenses.

Files in the coreboot/src/commonlib/bsd directory are all licensed with
the BSD-3-clause license.  Many are also dual-licensed GPL-2.0-only or
GPL-2.0-or-later.  These files are intended to be shared with libpayload
or other BSD licensed projects.

The libpayload project contained in coreboot/payloads/libpayload may be
licensed as BSD or GPL, depending on the code pulled in during the build
process. All GPL source code should be excluded unless the Kconfig
option to include it is set.


The Software Freedom Conservancy
--------------------------------

Since 2017, coreboot has been a member of [The Software Freedom
Conservancy](https://sfconservancy.org/), a nonprofit organization
devoted to ethical technology and driving initiatives to make technology
more inclusive. The conservancy acts as coreboot's fiscal sponsor and
legal advisor.
