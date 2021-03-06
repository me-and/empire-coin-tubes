coin_diameter = 10;
coin_depth = 1;
number_of_coins = 20;

coin_diameter_space = 0.5;
coin_depth_space = 0.05;

wall_width = 1;
floor_depth = 1;

slot_height = coin_depth + coin_depth_space * 2;

tube_inner_height = coin_depth * number_of_coins + coin_depth_space * (number_of_coins - 1) + slot_height;
tube_inner_diameter = coin_diameter + coin_diameter_space;

tube_outer_height = tube_inner_height + floor_depth;
tube_outer_diameter = tube_inner_diameter + wall_width;

$fn = 90;

difference()
{
	translate([-tube_outer_diameter/2, 0, 0])
	cube([tube_outer_diameter, tube_outer_diameter/2, tube_outer_height]);

	translate([0, 0, floor_depth])
	cylinder(h=tube_inner_height + 1, d=tube_inner_diameter);
}

cylinder(h=floor_depth, d=tube_inner_diameter);
