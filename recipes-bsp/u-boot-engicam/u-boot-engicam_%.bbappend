FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
	file://0001-Fix-u-boot-default-env.patch \
"

UBOOT_INITIAL_ENV = "u-boot-initial-env"

do_configure:append() {
    # Remove fdtfile, if present
    sed -i '/"fdtfile=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
}

do_configure:append:imx8mp-icore-fasteth() {
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"fdtfile=imx8mp-icore-fasteth-ctouch2-steliau.dtb\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}

do_configure:append:imx8mp-icore-fasteth-robomagister() {
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"fdtfile=imx8mp-icore-fasteth-robomagister.dtb\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}

do_configure:append:env-prod() {
	sed -i '/"bootdelay=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
	sed -i '/"console=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"bootdelay=-2\\0" \\/' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"console=ttynull\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}
