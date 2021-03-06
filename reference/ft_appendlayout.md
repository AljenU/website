---
title: ft_appendlayout
---
```plaintext
 FT_APPENDLAYOUT concatenates multiple layout descriptions that have been constructed
 separately.

 Use as
   combined = ft_appendlayout(cfg, layout1, layout2, ...)
 where the input layouts result from FT_PREPARE_LAYOUT and the configuration
 should contain
   cfg.direction = string, 'horizontal' or 'vertical' (default = 'horizontal')
   cfg.align     = string, 'center', 'left', 'right', 'top' or 'bottom' (default = 'center')
   cfg.distance  = number, distance between layouts (default is automatic)
   cfg.xscale    = number, scaling to apply to input layouts along the horizontal direction (default = 1)
   cfg.yscale    = number, scaling to apply to input layouts along the vertical direction (default = 1)

 See also FT_PREPARE_LAYOUT, FT_LAYOUTPLOT, FT_APPENDSENS
```
