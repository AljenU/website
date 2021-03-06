---
title: ft_connectivity_mutualinformation
---
```plaintext
 FT_CONNECTIVITY_MUTUALINFORMATION computes mutual information using
 either the information breakdown toolbox (ibtb), as described in Magri
 et al., BMC Neuroscience 2009, 1471-2202, or Robin Ince's Gaussian copula
 based parametric approach (gcmi). The function is a helper function for
 FT_CONNECTIVITYANALYSIS. As a standalone function, it could be used as
 follows:

 Use as
   mi = ft_connectivity_mutualinformation(data, ...)

 The input data should be a Nchan x Nobservations matrix.

 Additional input arguments come as key-value pairs:
   method     = string, 'ibtb' (default), or 'gcmi'.

 The following arguments pertain to the 'ibtb' method:
   histmethod = The way that histograms are generated from the data. Possible values
                are 'eqpop' (default), 'eqspace', 'ceqspace', 'gseqspace'.
                See the help of the 'binr' function in the ibtb toolbox for more information.
   numbin     = scalar value. The number of bins used to create the histograms needed for
                the entropy computations
   opts       = structure that is passed on to the 'information' function in the ibtb
                toolbox. See the help of that function for more information.
   refindx    = scalar value or 'all'. The channel that is used as 'reference channel'.

 The output contains the estimated mutual information between all channels and the reference channel(s).

 See also FT_CONNECTIVITYANALYSIS
```
