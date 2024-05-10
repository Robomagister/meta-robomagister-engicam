FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

NAND_DISPLAY_DEVICETREE = "imx8mp-icore-fasteth-ctouch2-n-and.dts"

SRC_URI += "\
	file://rb_kernel_config \
"

SRC_URI:append:imx8mp-icore-fasteth = " \
	file://0003-Goodix-touchscreen-driver.patch \
	file://${NAND_DISPLAY_DEVICETREE} \
"

SRC_URI:append:imx8mp-icore-fasteth-robomagister = " \
	file://0001-added-58Mhz-ldb-clock.patch \
	file://0002-added-imx8mp-icore-fasteth-robomagister-initial-supp.patch \
	file://0003-clean-robomagister-dtb.patch \
"

SRCREV:imx8mp-icore-fasteth = "8df7a9abbd5201596c676d5cf33da8d2ef34a98e"

do_configure:append:imx8mp-icore-fasteth() {
    cp ${WORKDIR}/${NAND_DISPLAY_DEVICETREE} ${S}/arch/arm64/boot/dts/engicam
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
do_copy_defconfig() {
	install -d ${B}
	mkdir -p ${B}
    cp -f ${WORKDIR}/rb_kernel_config ${B}/.config
}