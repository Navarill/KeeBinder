--[[
		KeeBinder
		User-defined keybinds for The Elder Scrolls Online
		License: (to be determined)
 ]]

local KeeBinder = "KeeBinder"

COLLECTIBLES =
{
    -- Assistants
    ADERENE_FARGRAVE_DREGS_DEALER = 10617,
    ALLARIA_ERWEN_THE_EXPORTER = 396,
    BARON_JANGLEPLUME_THE_BANKER = 8994,
    CASSUS_ANDRONICUS_THE_MERCENARY = 397,
    EZABI_THE_BANKER = 6376,
    FACTOTUM_COMMERCE_DELEGATE = 9744,
    FACTOTUM_PROPERTY_STEWARD = 9743,
    FEZEZ_THE_MERCHANT = 6378,
    GHRASHAROG_ARMORY_ASSISTANT = 9745,
    GILADIL_THE_RAGPICKER = 10184,
    NUZHIMEH_THE_MERCHANT = 300,
    PEDDLER_OF_PRIZES_THE_MERCHANT = 8995,
    PIRHARRI_THE_SMUGGLER = 301,
    THYSIS_ANDROMO_THE_BANKER = 267,
    ZUGOTH_ARMORY_ADVISOR = 10618,

    -- Companions
    BASTIAN_HALLIX = 9245,
    EMBER = 9911,
    ISOBEL_VELOISE = 9912,
    MIRI_ELENDIS = 9353,

    -- Tools
    ANTIQUARIANS_EYE = 8006,
    BREDAS_BOTTOMLESS_MEAD_MUG = 1168,
    FIRE_ROCK = 602,
    JUBILEE_CAKE_2022 = 10287,
    PIE_OF_MISRULE = 1167,
    RELIC_OF_THE_SENTINEL = 8883,
    WITCHMOTHERS_WHISTLE = 479,
}

local function CreateBindings()
    for _, collectibleId in pairs(COLLECTIBLES) do
        local name, _, _, _, unlocked = GetCollectibleInfo(collectibleId)
        if unlocked then
            local stringId = "SI_BINDING_NAME_KEEBINDER_" .. collectibleId
            if GetString(_G[stringId]) == "" then
                ZO_CreateStringId(stringId, ZO_CachedStrFormat(SI_COLLECTIBLE_NAME_FORMATTER, name))
            end
        end
    end
end

local function OnAddonLoaded(_, addonName)
    if addonName == KeeBinder then
        CreateBindings()

        EVENT_MANAGER:RegisterForEvent(KeeBinder, EVENT_COLLECTIBLE_UPDATED, CreateBindings)
        EVENT_MANAGER:RegisterForEvent(KeeBinder, EVENT_COLLECTION_UPDATED, CreateBindings)
        EVENT_MANAGER:UnregisterForEvent(KeeBinder, EVENT_ADD_ON_LOADED)
    end
end

EVENT_MANAGER:RegisterForEvent(KeeBinder, EVENT_ADD_ON_LOADED, OnAddonLoaded)
