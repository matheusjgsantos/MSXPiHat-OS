################################################################################
#
# sunxi-mali-mainline-driver
#
################################################################################

SUNXI_MALI_MAINLINE_DRIVER_VERSION = 143ff2b17de63ce931c4f758771969e75c09a4c7
SUNXI_MALI_MAINLINE_DRIVER_SITE = $(call github,mripard,sunxi-mali,$(SUNXI_MALI_MAINLINE_DRIVER_VERSION))
SUNXI_MALI_MAINLINE_DRIVER_DEPENDENCIES = linux
SUNXI_MALI_MAINLINE_DRIVER_LICENSE = GPL-2.0
SUNXI_MALI_MAINLINE_DRIVER_LICENSE_FILES = LICENSE

SUNXI_MALI_MAINLINE_DRIVER_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KDIR=$(LINUX_DIR)

define SUNXI_MALI_MAINLINE_DRIVER_USE_APPLY_PATCHES
	ln -sf $(SUNXI_MALI_MAINLINE_REV)/series $(@D)/patches
	$(SED) 's|quilt push -a|$(TOPDIR)/support/scripts/apply-patches.sh . ../patches|' \
		$(@D)/build.sh
endef

SUNXI_MALI_MAINLINE_DRIVER_POST_PATCH_HOOKS += SUNXI_MALI_MAINLINE_DRIVER_USE_APPLY_PATCHES

define SUNXI_MALI_MAINLINE_DRIVER_BUILD_CMDS
	cd $(@D) && $(SUNXI_MALI_MAINLINE_DRIVER_MAKE_OPTS) \
		$(SHELL) ./build.sh -r $(SUNXI_MALI_MAINLINE_REV) -j $(PARALLEL_JOBS) -b
endef

define SUNXI_MALI_MAINLINE_DRIVER_INSTALL_TARGET_CMDS
	cd $(@D) && $(SUNXI_MALI_MAINLINE_DRIVER_MAKE_OPTS) \
		$(SHELL) ./build.sh -r $(SUNXI_MALI_MAINLINE_REV) -j $(PARALLEL_JOBS) -i
endef

$(eval $(generic-package))
