/*
 *  Copyright (C) 2026, Vadim Godunko
 *
 *  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#include "tinyusb_msc.h"

const int __ada_SIZEOF_tinyusb_msc_storage_config_t = sizeof(tinyusb_msc_storage_config_t);

void __ada_SET_tinyusb_msc_storage_config_mount_point(tinyusb_msc_storage_config_t *self, tinyusb_msc_mount_point_t to)
{
    self->mount_point = to;
}

void __ada_SET_tinyusb_msc_storage_config_wl_handle(tinyusb_msc_storage_config_t *self, wl_handle_t to)
{
    self->medium.wl_handle = to;
}
