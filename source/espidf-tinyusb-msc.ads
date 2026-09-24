--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Wear_Levelling;

package ESPIDF.TinyUSB.MSC is

   type tinyusb_msc_storage_config_t is limited private;

   procedure Set_wl_handle
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.Wear_Levelling.wl_handle_t);

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