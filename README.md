## simpler

simpler is a local XSPEC convolution model that provides a lower energy cut-off
to a power law with the input blackbody shape, while keeping that same blackbody 
shape as another component in the energy spectral model.

simpler is a modification of the simpl model:
http://heasarc.gsfc.nasa.gov/xanadu/xspec/manual/XSmodelSimpl.html

See the XSPEC documentation for more info about local models: 
http://heasarc.gsfc.nasa.gov/xanadu/xspec/manual/XSappendixLocal.html

###Example

simpler*bbody will give you both a power law cut off at the temperature of 
bbody, and the bbody.