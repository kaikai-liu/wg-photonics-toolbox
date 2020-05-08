This folder contains some examples that illustrate how to use the
various features of the waveguide modesolver.

============================================================
SEMIVECTORIAL MODESOLVER EXAMPLES:

basic_semivector.m - Illustrates basic usage of the semivector
    modesolver to calculate the quasi-TE and quasi-TM modes of a ridge
    waveguide.

nonuniform_mesh_semivector.m - Shows how to use the semivector
    modesolver with a non-uniform mesh.

pml_semivector_leaky_mode.m - Demonstrates the semivector modesolver
    with perfectly-matched layers at the edges of the computation window,
    implemented by complex coordinate stretching

coupler_even_odd.m - Shows how to calculate the even and odd modes of a
    pair of two adjacent coupled identical waveguides.

silicon_channel_semivector - Applies the semivector modesolver to
    compute the TE mode of a sub-micron silicon waveguide.  Comparison with
    the full-vector solution demonstrates some of the inaccuracy of the
    semivector approximation.

============================================================
FULL VECTOR MODESOLVER EXAMPLES

basic_fullvector.m - Illustrates the basic usage of the full-vector
    modesolver to find Hx and Hy for a simple ridge waveguide.

nonuniform_mesh_fullvector.m - Shows how to use the full-vector modesolver
    with a nonuniform mesh.

pml_fullvector_leaky_mode.m - Demonstrates the full-vector modesolver with
    perfectly matched layers at the edges of the computation window to
    calculate the leaky modes of a waveguide.

fiber_tm_mode.m - Calculates the first TM mode of a step-index fiber, in
    comparison to the exact modes.

uniaxial_channel.m - Demonstrates how to find the modes of a channel
    waveguide comprised of an anisotropic (uniaxial) core.

uniaxial_channel_rotated.m - Same as 'uniaxial_channel.m', except the
    c-axis of the core is rotated to an oblique angle, such that the
    epsilon tensor is non-diagonal.

fullvector_all_fields.m - Shows how to calculate the four remaining field
    components once Hx and Hy are known.

polymer_waveguide.m - Example of an anisotropic off-axis poled polymer
    waveguide.

faraday_waveguide.m - Calculates the modes of a gyrotropic waveguide.  Note
    that the modes exhibit right- and left-hand circular polarization.

silicon_channel.m - Calculates the full-vector modes of a
    silicon-on-insulator "nanowire" channel waveguide, and plots all six
    field components.
