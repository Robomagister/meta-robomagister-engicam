FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0002-Fix-u-boot-default-env-for-Engicam-iMX8M-Plus-C.Touc.patch \
            file://0001-Don-t-overwrite-mmcroot-with-hard-coded-partition-nu.patch \
            file://0003-Fix-mmcdev.patch \
            file://0005-Pass-the-correct-init-parameter-to-use-overlayfs-etc.patch \
            "

UBOOT_INITIAL_ENV = "u-boot-initial-env"

do_configure:append:imx8mp-icore-fasteth() {
    # Remove exisiting fdtfile, if there is one
    sed -i '/"fdtfile=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
    # Add new fdtfile
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"fdtfile=imx8mp-icore-fasteth-ctouch2-n-and.dtb\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}

do_configure:append:imx8mp-icore-fasteth-robomagister() {
    sed -i '/"fdtfile=.*\\0" \\/d' ${S}/include/configs/imx8mp_icore.h
    sed -i 's/\("boot_fit=.*\\0" \\\)/\0\n \t"fdtfile=imx8mp-icore-fasteth-robomagister.dtb\\0" \\/' ${S}/include/configs/imx8mp_icore.h
}
