--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.C_Strings;
with ESPIDF.Wear_Levelling;

package ESPIDF.TinyUSB.MSC is

   type tinyusb_msc_mount_point_t is
     (TINYUSB_MSC_STORAGE_MOUNT_USB,
      TINYUSB_MSC_STORAGE_MOUNT_APP) with Convention => C;

   type tinyusb_msc_storage_config_t is limited private;

   procedure Set_wl_handle
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.Wear_Levelling.wl_handle_t);

   procedure Set_base_path
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.C_Strings.const_char_ptr);

   procedure Set_format_if_mount_failed
     (Self : in out tinyusb_msc_storage_config_t;
      To   : Boolean);

   procedure Set_mount_point
     (Self : in out tinyusb_msc_storage_config_t;
      To   : tinyusb_msc_mount_point_t);

   type tinyusb_msc_storage_s is limited private;

   type tinyusb_msc_storage_handle_t is access all tinyusb_msc_storage_s
     with Convention => C;

   function tinyusb_msc_new_storage_spiflash
     (config : tinyusb_msc_storage_config_t;
      handle : in out tinyusb_msc_storage_handle_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "tinyusb_msc_new_storage_spiflash";

   procedure tinyusb_msc_new_storage_spiflash
     (config : tinyusb_msc_storage_config_t;
      handle : in out tinyusb_msc_storage_handle_t);

   function tinyusb_msc_set_storage_mount_point
     (handle      : tinyusb_msc_storage_handle_t;
      mount_point : tinyusb_msc_mount_point_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "tinyusb_msc_set_storage_mount_point";

   procedure tinyusb_msc_set_storage_mount_point
     (handle      : tinyusb_msc_storage_handle_t;
      mount_point : tinyusb_msc_mount_point_t);

private

   sizeof_tinyusb_msc_storage_config_t : constant int
     with Import, Convention => C,
          External_Name => "__ada_SIZEOF_tinyusb_msc_storage_config_t";

   type tinyusb_msc_storage_config_t is
     new C_Object_Storage (1 .. sizeof_tinyusb_msc_storage_config_t)
       with Convention              => C,
            Default_Component_Value => 0;

   type tinyusb_msc_storage_s is null record with Convention => C;

end ESPIDF.TinyUSB.MSC;