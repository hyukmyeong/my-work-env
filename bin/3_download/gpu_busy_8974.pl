#!/usr/bin/perl

while(1)
{
    $gpu3d = `adb shell cat /sys/class/kgsl/kgsl-3d0/gpubusy`;
	$gpu2d0 = `adb shell cat  /sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/gpubusy`;
	$gpu2d1 = `adb shell cat  /sys/devices/platform/kgsl-2d1.1/kgsl/kgsl-2d1/gpubusy`;

	$pct = 0.0;
	if( $gpu3d =~ m/\s*(\d+)\s+(\d+)/)
	{
		if( $1 > 0  && $2 > 0 )
		{
			$pct = $1 / $2 * 100;
		}
	    printf("3D GPU Busy: %5.2f\%    ", $pct);
	}
	$pct = 0.0;
	if( $gpu2d0 =~ m/\s*(\d+)\s+(\d+)/)
	{
		if( $1 > 0  && $2 > 0 )
		{
			$pct = $1 / $2 * 100;
		}
	    printf("2D_0 GPU Busy: %5.2f\%   ", $pct);
	}
	$pct = 0.0;
	if( $gpu2d1 =~ m/\s*(\d+)\s+(\d+)/)
	{
		if( $1 > 0  && $2 > 0 )
		{
			$pct = $1 / $2 * 100;
		}
	    printf("2D_1 GPU Busy: %5.2f\%   ", $pct);
	}
	printf("\n");

	sleep 1;
}
