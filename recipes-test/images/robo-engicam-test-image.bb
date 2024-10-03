SUMMARY = "Test image"

LICENSE = "CLOSED"

inherit core-image

IMAGE_FEATURES += " \
	debug-tweaks \
	weston \
    ssh-server-dropbear \
    tools-debug \
	package-management \
"

ENGICAM_PKGS = ""

ENGICAM_PKGS:imx8mp-icore-fasteth = " \
	imx8-brcm \
    brcm-patchram-plus \
    linux-firmware-bcm43430 \
"

ENGICAM_PKGS:imx8mp-icore-fasteth-robomagister = " \
    mlan-mod-load \
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
    iproute2 \
    tcpdump \
    memtester \
    evtest \
	i2c-tools \
	curl \
    ${ENGICAM_PKGS} \
    ${NETWORK_PKGS} \
"

IMAGE_FSTYPES = "wic.gz"

ROOTFS_POSTPROCESS_COMMAND:append = "fixInstallRootFs;"

fixInstallRootFs() {
    cd ${IMAGE_ROOTFS}
	
	sed -i '/\/dev\/mmcblk2p3.*/d' etc/fstab
	sed -i '/.*\/home\/weston.*/d' etc/fstab
}
