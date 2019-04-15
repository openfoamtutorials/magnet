//Inputs
magnet_radius = 0.1; // m
magnet_height = 0.02; // m
domain_radius = 1; // m

magnet_lc = 0.002;
domain_lc = 0.03 * domain_radius;

ce = 0;

// Magnet surface.
first_point = ce;
Point(ce++) = {0, 0, 0, magnet_lc};
Point(ce++) = {magnet_radius, 0, 0, magnet_lc};

magnet_loop_lines = {};
magnet_loop_lines += ce;
air_loop_lines = {};
air_loop_lines += ce;
Line(ce++) = {ce - 3, ce - 2};

Point(ce++) = {magnet_radius, -magnet_height, 0, magnet_lc};

magnet_loop_lines += ce;
air_loop_lines += ce;
Line(ce++) = {ce - 4, ce - 2};

Point(ce++) = {0, -magnet_height, 0, magnet_lc};

magnet_loop_lines += ce;
air_loop_lines += ce;
Line(ce++) = {ce - 4, ce - 2};

magnet_loop_lines += ce;
Line(ce++) = {ce - 3, first_point};

// Domain.
Point(ce++) = {0, -domain_radius, 0, domain_lc};

air_loop_lines += ce;
Line(ce++) = {ce - 5, ce - 2};

Point(ce++) = {domain_radius, -domain_radius, 0, domain_lc};

air_loop_lines += ce;
Line(ce++) = {ce - 4, ce - 2};

Point(ce++) = {domain_radius, domain_radius, 0, domain_lc};

air_loop_lines += ce;
Line(ce++) = {ce - 4, ce - 2};

Point(ce++) = {0, domain_radius, 0, domain_lc};

air_loop_lines += ce;
Line(ce++) = {ce - 4, ce - 2};

air_loop_lines += ce;
Line(ce++) = {ce - 3, first_point};



air_line_loop = ce;
Line Loop(ce++) = air_loop_lines[];
air_surface = ce;
Plane Surface(ce++) = air_line_loop;

wedgeAngle = 5 * Pi / 180;
Rotate {{0, 1, 0}, {0, 0, 0}, wedgeAngle / 2}
{
    Surface{air_surface};
}
domainEntities[] = Extrude {{0, 1, 0}, {0, 0, 0}, -wedgeAngle}
{
    Surface{air_surface};
    Layers{1};
    Recombine;
};

Physical Surface("wedge0") = {air_surface};
Physical Surface("wedge1") = {domainEntities[0]};
Physical Surface("fringe") = {domainEntities[{5 : 7}]};
Physical Surface("magnet_surface_top") = {domainEntities[2]};
Physical Surface("magnet_surface_side") = {domainEntities[3]};
Physical Surface("magnet_surface_bottom") = {domainEntities[4]};

Physical Volume("air") = {domainEntities[1]};

