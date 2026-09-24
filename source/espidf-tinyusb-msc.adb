--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.TinyUSB.MSC is

   -------------------
   -- Set_wl_handle --
   -------------------

   procedure Set_wl_handle
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.Wear_Levelling.wl_handle_t)
   is
      procedure Imported
        (Self : in out tinyusb_msc_storage_config_t;
         To   : ESPIDF.Wear_Levelling.wl_handle_t)
        with Import, Convention => C,
             External_Name => "__ada_SET_tinyusb_msc_storage_config_wl_handle";

   begin
      Imported (Self, To);
   end Set_wl_handle;

   --------------------------------------
   -- tinyusb_msc_new_storage_spiflash --
   --------------------------------------

   procedure tinyusb_msc_new_storage_spiflash
     (config : tinyusb_msc_storage_config_t;
      handle : in out tinyusb_msc_storage_handle_t) is
   begin
      Ada_ESP_Check_Error (tinyusb_msc_new_storage_spiflash (config, handle));
   end tinyusb_msc_new_storage_spiflash;

end ESPIDF.TinyUSB.MSC;