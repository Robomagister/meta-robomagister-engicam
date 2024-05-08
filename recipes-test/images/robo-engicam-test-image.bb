SUMMARY = "Test image"

LICENSE = "CLOSED"

inherit core-image

ROOTFS_POSTPROCESS_COMMAND:append:imx8mp-icore-fasteth = "fix_bcm43430;"

fix_bcm43430() {
    cd ${IMAGE_ROOTFS}/lib/firmware/brcm
    ln -sf brcmfmac43430-sdio.bin brcmfmac43430-sdio.engi,imx8-icore.bin
}

IMAGE_FEATURES += " \
    read-only-rootfs \
	debug-tweaks \
"

ENGICAM_PKGS = ""

ENGICAM_PKGS:imx8mp-icore-fasteth = " \
    brcm-patchram-plus \
    linux-firmware-bcm43430 \
    linux-firmware \
	kernel-image-image \
	u-boot-engicam-env \
"

ENGICAM_PKGS:imx8mp-icore-fasteth-robomagister = " \
    linux-firmware \
	kernel-image-image \
	u-boot-engicam-env \
"

NETWORK_PKGS = " \
	networkmanager \
	networkmanager-nmcli \
	networkmanager-wifi \
"

CORE_IMAGE_EXTRA_INSTALL += " \
    firmwared \
    tzdata \
	kernel-image \
	kernel-devicetree \
    ${ENGICAM_PKGS} \
    ${NETWORK_PKGS} \
"

IMAGE_INSTALL:append:mx8m = "\
	imx8-brcm \
"

IMAGE_FSTYPES = "wic.gz"
