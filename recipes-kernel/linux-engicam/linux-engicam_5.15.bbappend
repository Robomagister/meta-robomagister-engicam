FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://devtool-fragment.cfg \
            file://0001-added-58Mhz-ldb-clock.patch \
            file://0002-added-imx8mp-icore-fasteth-robomagister-initial-supp.patch \
            file://0003-clean-robomagister-dtb.patch \
            "

