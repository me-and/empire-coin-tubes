coin_diameter = 20;
coin_depth = 2;
number_of_coins = 20;

coin_diameter_space = 0.5;
coin_depth_space = 0.05;

wall_width = 1;
floor_depth = 1;

tube_inner_height = coin_depth * number_of_coins + coin_depth_space * (number_of_coins - 1);
tube_inner_diameter = coin_diameter + coin_diameter_space;

floor_slot_diameter = tube_inner_diameter / 2;

coin_slot_height = coin_depth + 2*coin_depth_space;
coin_slot_lip = coin_depth / 2;

tube_outer_height = tube_inner_height + floor_depth;
tube_outer_diameter = tube_inner_diameter + wall_width;

slot_width = 1;
slot_wavelength = 25;

$fn = 90;
slot_resolution = 0.7;

slack = 1;

module sine_wave (length, depth, height, amplitude, wavelength, resolution)
{
	for(i=[0:(length / resolution)])
	{
		translate([i * resolution, sin(i * 360 / wavelength * resolution)*amplitude - height/2, 0])
		cube([resolution * 2, height, depth]);
	}
}

module tube (inner_diameter, inner_height, floor_depth, wall_width)
{
	outer_height = inner_height + floor_depth;
	outer_diameter = inner_diameter + 2*wall_width;
	slot_amplitude = inner_diameter / 4;

	difference()
	{
		union()
		{
			translate([-outer_diameter/2, 0, 0])
			cube([outer_diameter, outer_diameter/2, outer_height]);

			cylinder(h=outer_height, d=outer_diameter);
		}

		union()
		{
			translate([0, 0, floor_depth])
			cylinder(h=inner_height + slack, d=inner_diameter);

			translate([0, 0, floor_depth])
			rotate([90, -90, 0])
			sine_wave(inner_height + slack, inner_diameter, slot_width, slot_amplitude, slot_wavelength, slot_resolution);
		}
	}
}

difference()
{
	tube(tube_inner_diameter, tube_inner_height, floor_depth, wall_width);

	union()
	{
		translate([0, 0, -slack])
		hull()
		{
			cylinder(h=2*slack + floor_depth + coin_slot_lip, d=floor_slot_diameter);

			translate([0, -tube_inner_diameter, 0])
			cylinder(h=2*slack + floor_depth + coin_slot_lip, d=floor_slot_diameter);
		}

		translate([0, 0, floor_depth + coin_slot_lip])
		hull()
		{
			cylinder(h=coin_slot_height, d=tube_inner_diameter);

			translate([0, -tube_inner_diameter, 0])
			cylinder(h=coin_slot_height, d=tube_inner_diameter);
		}
	}
}
