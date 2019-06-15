#!/usr/bin/env bats

@test "test CPU_FLAGS_X86" {
	_cpuid2cpuflags=$(cpuid2cpuflags | sed 's/: /="/;s/$/"/')
	_make_conf=$(grep CPU_FLAGS_X86 /etc/portage/make.conf)
	[ "$_cpuid2cpuflags" == "$_make_conf" ]
}


@test "test MAKEOPTS" {
	_cpus=$(grep -c ^processor /proc/cpuinfo)
        _makeopts='MAKEOPTS="-j'$((++_cpus))'"'
	_make_conf=$(grep MAKEOPTS /etc/portage/make.conf)
	[ "$_makeopts" == "$_make_conf" ]
}


@test "test MICROCODE_SIGNATURES" {
	_sig='-s '$(iucode_tool -S 2>&1 | sed 's/.*signature \(.*\)/\1/')
	_make_conf=$(grep MICROCODE_SIGNATURES /etc/portage/make.conf)
	[ -z "${_make_conf##*$sig*}" ]
}
