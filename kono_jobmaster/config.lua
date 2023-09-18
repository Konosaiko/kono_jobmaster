Config = {
    defaultlang = "fr",
    Align = "center",

    Key = 0x760A9C6F, --[G]

    Blipsprite = 1879260108, --common sprite
    

    BlipsActive = true,

    Locations = {
        Boulangerie = {
            Job = "baker",

            Blipcoords = {x = 1375.17, y = -858.74, z = 69.33}, 
            Name = "Boulangerie",

            StoragePosition = {x = 1366.08, y = -868.72, z = 69.4},

            Blipsprite = 819673798, -- set false to use common sprite

            HarvestPosition = {x = 1373.5, y = -848.23, z = 70.36},
            itemName = "coal",
            harvestAnimation = "hoeing",
            harvestAnimationDuration = 5000,
            harvestNotification = "Vous avez récolté un blé.",

            TreatmentPosition = {x = 1367.76, y = -849.54, z = 70.82},
            itemTreated = "apple",
            treatmentAnimation = "shoveling",
            treatmentAnimationDuration = 2200,
            treatmentNotification = "Vous avez traité un blé.",
        },
        
    }
}