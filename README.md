# kono_jobmaster
#### Description
Job script for RedM servers using the [VORP](https://github.com/VORPCORE) framework.
Add new locations in config.lua and items related. The script allows you to create simple job with harvest, treatment and storage. Fully customizable, you can add a craft locations and ped to sell with vorp_crafting and vorp_stores.

#### Features
- Custom blip with setable coords and name
- Storage Position
- Harvest position, customizable item, animation and notification
- Treatment position, requires harvested item, customizable item processed, animation and notification 


#### Dependencies
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_crafting](https://github.com/VORPCORE/vorp_crafting)
- [vorp_stores](https://github.com/VORPCORE/vorp_stores-lua)


#### Installation
- Add `kono_jobmaster` folder to your resources folder
- Add `ensure kono_jobmaster` to your `resources.cfg`
- Ensure this script *after* dependencies script
- Add new locations in config.lua
- Add items related to your database
- Restart server

#### Credits
- Konosaiko

#### GitHub
- https://github.com/Konosaiko/kono_jobmaster
