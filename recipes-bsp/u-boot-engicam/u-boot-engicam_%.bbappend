FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

UBOOT_SRC = "git://github.com/Robomagister/u-boot-engicam-nxp-2022.04.git;protocol=https"
SRCBRANCH = "rb"
SRCREV = "e01d87319317d706fb1fd61b0e9791212a4b588b"

SRC_URI += "\
	file://u-boot-altboot.cfg \
"

UBOOT_INITIAL_ENV = "u-boot-initial-env"

do_configure:append:imx8mp-icore-fasteth() {
    sed -i '/"fdtfile=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"fdtfile=imx8mp-icore-fasteth-ctouch2-steliau.dtb\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}

do_configure:append:env-prod() {
	sed -i '/"bootdelay=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
	sed -i '/"console=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"bootdelay=-2\\0" \\/' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"console=ttynull\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}
