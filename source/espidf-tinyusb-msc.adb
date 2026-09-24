--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.TinyUSB.MSC is

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