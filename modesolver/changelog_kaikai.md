# Change Log

#### changed `fiber.m` for one more output `edges`

`phi = linspace(0,pi/2,100);
edges{1,:} = r*cos(phi);
edges{2,:} = r*sin(phi);`

#### changed `postprocess.m` to remove spikes in `Ex,Ey,Ez`

`Nxy = round(size(Ex)/20);
Ex = filloutliers(Ex,'linear','movmedian',Nxy(1),1);
Ex = filloutliers(Ex,'linear','movmedian',Nxy(2),2);
Ey = filloutliers(Ey,'linear','movmedian',Nxy(1),1);
Ey = filloutliers(Ey,'linear','movmedian',Nxy(2),2);
Ez = filloutliers(real(Ez),'linear','movmedian',Nxy(1),1)+1j*filloutliers(imag(Ez),'linear','movmedian',Nxy(1),1);
Ez = filloutliers(real(Ez),'linear','movmedian',Nxy(2),2)+1j*filloutliers(imag(Ez),'linear','movmedian',Nxy(2),2);`

This works best `Nxy = round(size(Ex)/20)`

`20` may be subject to change.

#### add `waveguidemesh_D_shape.m` for D-shape waveguide

#### add `waveguidemesh_fiber.m` for full fiber mesh and edges

#### add `waveguidemesh_rect.m` for rectangular waveguide mesh and edges



# Note

#### use `stretchmesh.m` 

- `[x,y,xc,yc,dx,dy] = stretchmesh(x,y,nlayers,factor,method)`

- `nlayers(1)` is the number of layers on the north boundary to be stretched

- `factor(1)` is the corresponding factor

- `nlayers(1)` should **only include cladding mesh grids to prevent core dimension distortion**. For example, parts of core grids get stretched and core dimension distorted.

  <img src="C:\Users\Kaikai Liu\Documents\Markdown image\image-20200503095742051.png" alt="image-20200503095742051" style="zoom:33%;" />

#### dispersion property calculated by modesolver and simulated by COMSOL are totally matched, including material dispersion and waveguide dispersion.
