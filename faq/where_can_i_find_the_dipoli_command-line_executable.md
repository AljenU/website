---
title: Where can I find the dipoli command-line executable?
tags: [faq, headmodel, source, matlab]
---

# Where can I find the dipoli command-line executable?

The Boundary Element Method (BEM) allows for source reconstruction of EEG data with realistic head geometries. FieldTrip implements the BEM method for EEG in a general fashion in the forward **[ft_compute_leadfield](https://github.com/fieldtrip/fieldtrip/blob/release/ft_compute_leadfield.m)** function. However, this requires that a previously prepared BEM model is passed to the **[ft_sourceanalysis](https://github.com/fieldtrip/fieldtrip/blob/release/ft_sourceanalysis.m)** function or to the **[ft_dipolefitting](https://github.com/fieldtrip/fieldtrip/blob/release/ft_dipolefitting.m)** function. To construct such an EEG BEM model, you can use the **[ft_prepare_headmodel](https://github.com/fieldtrip/fieldtrip/blob/release/ft_prepare_headmodel.m)** function, where in cfg.method you should specify `dipoli`, `bemcp` or `openmeeg`.

Dipoli is a command line application that was developed by [Thom Oostendorp](http://www.mbfys.ru.nl/~thom). A compiled version for Linux, macOS and Windows is included in `fieldtrip/external/dipoli`. Note that the Windows version cannot be called directly from within MATLAB.

## Linux

The dipoli executable for Linux was compiled on a 32-bit system. To run it on a 64-bit system, you need to install the "ia32-libs" library (sudo apt-get install ia32-libs). On newer systems, ia32-libs are deprecated so you should enable the i386 architecture (sudo dpkg --add-architecture i386 && sudo apt-get update) and install the 32-bit libraries (sudo apt-get install libc6:i386 libstdc++6:i386).
