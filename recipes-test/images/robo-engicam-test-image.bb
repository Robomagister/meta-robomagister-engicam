SUMMARY = "Test image"

LICENSE = "CLOSED"

inherit core-image

IMAGE_FEATURES += " \
	debug-tweaks \
	weston \
	splash \
"

ENGICAM_PKGS = ""

ENGICAM_PKGS:imx8mp-icore-fasteth = " \
    brcm-patchram-plus \
    linux-firmware-bcm43430 \
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
	kernel-image-image \
    linux-firmware \
	u-boot-engicam-env \
	chromium-ozone-wayland \
    ${ENGICAM_PKGS} \
    ${NETWORK_PKGS} \
"

IMAGE_INSTALL:append:mx8m = "\
	imx8-brcm \
"

IMAGE_FSTYPES = "wic.gz"

ROOTFS_POSTPROCESS_COMMAND:append = "fixInstallRootFs;"

fixInstallRootFs() {
    cd ${IMAGE_ROOTFS}
	
	sed -i '/\/dev\/mmcblk2p3.*/d' etc/fstab
	sed -i '/.*\/home\/weston.*/d' etc/fstab
}
