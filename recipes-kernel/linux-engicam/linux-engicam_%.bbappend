FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

NAND_DISPLAY_DEVICETREE = "imx8mp-icore-fasteth-ctouch2-n-and.dts"
STELIAU_DISPLAY_DEVICETREE = "imx8mp-icore-fasteth-ctouch2-steliau.dts"
ROBOMAGISTER_DEVICETREE = "imx8mp-icore-fasteth-robomagister.dts"

SRC_URI:append:imx8mp-icore-fasteth = " \
	file://${STELIAU_DISPLAY_DEVICETREE} \
	file://rb_kernel_config \
"

SRC_URI:append:imx8mp-icore-fasteth-robomagister = " \
	file://0001-added-58Mhz-ldb-clock.patch \
	file://0002-imx8mp-icore-fasteth-robomagister-defconfig.patch \
	file://${ROBOMAGISTER_DEVICETREE} \
"

SRCREV:imx8mp-icore-fasteth = "8df7a9abbd5201596c676d5cf33da8d2ef34a98e"

kernel_conf_variable() {
	CONF_SED_SCRIPT="$CONF_SED_SCRIPT /CONFIG_$1[ =]/d;"
	if test "$2" = "n"
	then
		echo "# CONFIG_$1 is not set" >> ${B}/.config
	else
		echo "CONFIG_$1=$2" >> ${B}/.config
	fi
}

do_configure:prepend() {
	kernel_conf_variable LOGO n
}

do_configure:append:imx8mp-icore-fasteth() {
    cp ${WORKDIR}/${STELIAU_DISPLAY_DEVICETREE} ${S}/arch/arm64/boot/dts/engicam/
}

do_configure:append:imx8mp-icore-fasteth-robomagister() {
    cp -f ${WORKDIR}/${ROBOMAGISTER_DEVICETREE} ${S}/arch/arm64/boot/dts/engicam/
}

# override Engicam's defconfig - do it here because (quote):
#
# "IMPORTANT: This task effectively disables kernel config fragments
#  since the config fragments applied in do_kernel_configme are replaced."
#
# starting point: sources/meta-freescale/recipes-kernel/linux/linux-imx/mx8-nxp-bsp/defconfig)
#
# bitbake linux-engicam -c menuconfig
#
# cp tmp/work/imx8mp_icore_fasteth-poky-linux/linux-engicam/5.15.71+gitAUTOINC+8df7a9abbd-r0/build/.config ../sources/meta-robomagister-engicam/recipes-kernel/linux-engicam/linux-engicam/${MACHINE}/rb_defconfig
#
do_copy_defconfig:imx8mp-icore-fasteth() {
	install -d ${B}
	mkdir -p ${B}
    cp -f ${WORKDIR}/rb_kernel_config ${B}/.config
}