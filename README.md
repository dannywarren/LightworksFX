# LightworksFX

A collection of shader effect templates for the [Lightworks NLE](http://www.lwks.com/).


## Strobe

Blends between foreground and background clips at repeated intervals.

Known Issues:

- [ ] Changing the effect length drastically changes the strobe timings
- [ ] Does not include any advanced blending options 

Todo:

- [ ] Check whether there are is any way to expose frame information to shaders
- [ ] Check whether we can hook in to another shader without having to copy and paste it
- [ ] If we have to copy and paste, check in to whether or not it is ok to borrow and modify the existing blend shader distributed with lightworks

