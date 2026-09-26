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
   --  TinyUSB MSC storage mount point.
   --  @enum TINYUSB_MSC_STORAGE_MOUNT_USB Storage is exposed to the USB host.
   --  @enum TINYUSB_MSC_STORAGE_MOUNT_APP
   --    Storage is mounted for local application use.

   type tinyusb_msc_storage_config_t is limited private;
   --  TinyUSB MSC storage configuration.

   procedure Set_wl_handle
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.Wear_Levelling.wl_handle_t);
   --  Set wear levelling handle for SPI flash storage.
   --  @param To Wear levelling handle.

   procedure Set_base_path
     (Self : in out tinyusb_msc_storage_config_t;
      To   : ESPIDF.C_Strings.const_char_ptr);
   --  Set filesystem mount path.
   --  @param To
   --    Filesystem mount path. Set to null to use the default component
   --    path.

   procedure Set_format_if_mount_failed
     (Self : in out tinyusb_msc_storage_config_t;
      To   : Boolean);
   --  Set whether to format the filesystem when mount fails.
   --  @param To
   --    If FAT partition can not be mounted, and this parameter is true,
   --    create partition table and format the filesystem.

   procedure Set_mount_point
     (Self : in out tinyusb_msc_storage_config_t;
      To   : tinyusb_msc_mount_point_t);
   --  Set requested initial storage owner after creation.
   --  @param To Requested initial storage owner.

   type tinyusb_msc_storage_s is limited private;

   type tinyusb_msc_storage_handle_t is access all tinyusb_msc_storage_s
     with Convention => C;
   --  Opaque handle for a TinyUSB MSC storage instance.

   function tinyusb_msc_new_storage_spiflash
     (config : tinyusb_msc_storage_config_t;
      handle : in out tinyusb_msc_storage_handle_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "tinyusb_msc_new_storage_spiflash";
   --  Create a TinyUSB MSC storage instance backed by SPI flash.
   --  @param config Storage configuration.
   --  @param handle Output for the created storage handle.
   --  @return
   --    - `ESP_OK` if storage was created successfully
   --    - `ESP_ERR_INVALID_ARG` if wear levelling handle of `config` is
   --      invalid
   --    - `ESP_ERR_NOT_SUPPORTED` if the TinyUSB MSC buffer is smaller than
   --      the wear levelling sector size
   --    - `ESP_ERR_NO_MEM` if memory allocation fails
   --    - `ESP_FAIL` if the storage cannot be mapped to a LUN
   --    - other error codes from driver installation, storage medium setup,
   --      or filesystem mounting

   procedure tinyusb_msc_new_storage_spiflash
     (config : tinyusb_msc_storage_config_t;
      handle : in out tinyusb_msc_storage_handle_t);
   --  Create a TinyUSB MSC storage instance backed by SPI flash.
   --  @param config Storage configuration.
   --  @param handle Output for the created storage handle.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_INVALID_ARG` if wear levelling handle of `config` is
   --      invalid
   --    - `ESP_ERR_NOT_SUPPORTED` if the TinyUSB MSC buffer is smaller than
   --      the wear levelling sector size
   --    - `ESP_ERR_NO_MEM` if memory allocation fails
   --    - `ESP_FAIL` if the storage cannot be mapped to a LUN
   --    - other error codes from driver installation, storage medium setup,
   --      or filesystem mounting

   function tinyusb_msc_set_storage_mount_point
     (handle      : tinyusb_msc_storage_handle_t;
      mount_point : tinyusb_msc_mount_point_t) return esp_err_t
     with Import, Convention => C,
          External_Name => "tinyusb_msc_set_storage_mount_point";
   --  Request the active mount point for a storage instance.
   --
   --  This subprogram requests switching storage ownership between the
   --  application and the USB host.
   --
   --  Note: This subprogram does not propagate failures from the internal
   --  mount/unmount helpers to the caller.
   --  @param handle Storage handle returned by a storage creation function.
   --  @param mount_point Requested mount point.
   --  @return
   --    - `ESP_OK` if mount point was set successfully
   --    - `ESP_ERR_INVALID_STATE` if the MSC driver is not installed

   procedure tinyusb_msc_set_storage_mount_point
     (handle      : tinyusb_msc_storage_handle_t;
      mount_point : tinyusb_msc_mount_point_t);
   --  Request the active mount point for a storage instance.
   --
   --  This subprogram requests switching storage ownership between the
   --  application and the USB host.
   --
   --  Note: This subprogram does not propagate failures from the internal
   --  mount/unmount helpers to the caller.
   --  @param handle Storage handle returned by a storage creation function.
   --  @param mount_point Requested mount point.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_INVALID_STATE` if the MSC driver is not installed

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