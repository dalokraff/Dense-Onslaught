local mod = get_mod("Dense Onslaught")

local mutator = mod:persistent_table("DenseOnslaught")

mod:dofile("scripts/mods/Dense Onslaught/base/base")

mutator.start = function()

	-- Backup existing horde tables.
	mutator.OriginalTerrorEventBlueprints = table.clone(TerrorEventBlueprints)
	mutator.OriginalHordeCompositions = table.clone(HordeCompositions)
	mutator.OriginalHordeCompositionsPacing = table.clone(HordeCompositionsPacing)
	mutator.OriginalBreedPacks = table.clone(BreedPacks)
	mutator.OriginalPackSpawningSettings = table.clone(PackSpawningSettings)
	mutator.OriginalRecycleSettings  = table.clone(RecycleSettings)
	mutator.OriginalPacingSettingsDefault = table.clone(PacingSettings.default)
	mutator.OriginalPacingSettingsChaos = table.clone(PacingSettings.chaos)
	mutator.OriginalPacingSettingsBeastmen = table.clone(PacingSettings.beastmen)
	mutator.OriginalSpecialsSettings = table.clone(SpecialsSettings)
	mutator.OriginalBossSettings = table.clone(BossSettings)
	mutator.OriginalBreedActions = table.clone(BreedActions)
	mutator.OriginalThreatValue = {}
	for name, breed in pairs(Breeds) do
		if breed.threat_value then
			mutator.OriginalThreatValue[name] = breed.threat_value
		end
	end
	mutator.OriginalBeastmenBannerBuff = BuffTemplates.healing_standard.buffs

	------------------------------------------------
	---------------------Pacing---------------------
	------------------------------------------------
	
	-- Ambient horde composition and spawn frequencies
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/ambient")
	-- Pacing Timers
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/pacing")
	-- Ambient Horde Composition
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/roaming_horde_composition")
	-- Skaven Horde Composition
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/skaven_horde_composition")
	-- Chaos Horde Composition
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/chaos_horde_composition")
	-- Beastmen Horde Composition
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/beastmen_composition")
	-- Special Spawn Settings
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/specials")
	-- Monster Trigger Settings
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/monsters")
	-- Patrol Trigger Settings
	mod:dofile("scripts/mods/Dense Onslaught/Mutator/patrols")
	
	------------------------------------------------
	---------------------Events---------------------
	------------------------------------------------
	
	-- Generic Event Horde Composition
	mod:dofile("scripts/mods/Dense Onslaught/Events/event_horde_composition")
	-- Righteous Stand
	mod:dofile("scripts/mods/Dense Onslaught/Events/righteous_stand")
	-- Convocation of Decay
	mod:dofile("scripts/mods/Dense Onslaught/Events/convocation_of_decay")
	-- Hunger in the Dark
	mod:dofile("scripts/mods/Dense Onslaught/Events/hunger_in_the_dark")
	-- Halescourge
	mod:dofile("scripts/mods/Dense Onslaught/Events/halescourge")
	-- Athel Yenlui
	mod:dofile("scripts/mods/Dense Onslaught/Events/athel_yenlui")
	-- Screaming Bell
	mod:dofile("scripts/mods/Dense Onslaught/Events/screaming_bell")
	-- Fort Brachshit
	mod:dofile("scripts/mods/Dense Onslaught/Events/fort_brachsenbrucke")
	-- Into the Nest
	mod:dofile("scripts/mods/Dense Onslaught/Events/into_the_nest")
	-- Against the Grain
	mod:dofile("scripts/mods/Dense Onslaught/Events/against_the_grain")
	--Empire in Flames
	mod:dofile("scripts/mods/Dense Onslaught/Events/empire_in_flames")
	-- Festering Ground
	mod:dofile("scripts/mods/Dense Onslaught/Events/festering_ground")
	-- Warcamp
	mod:dofile("scripts/mods/Dense Onslaught/Events/warcamp")
	-- Skittergate
	mod:dofile("scripts/mods/Dense Onslaught/Events/skittergate")
	-- The Pit
	mod:dofile("scripts/mods/Dense Onslaught/Events/the_pit")
	-- Blightreaper
	mod:dofile("scripts/mods/Dense Onslaught/Events/blightreaper")
	-- Horn of Magnus
	mod:dofile("scripts/mods/Dense Onslaught/Events/horn_of_magnus")
	-- Garden of Morr
	mod:dofile("scripts/mods/Dense Onslaught/Events/garden_of_morr")
	-- Engines of War
	mod:dofile("scripts/mods/Dense Onslaught/Events/engines_of_war")
	-- Dark Omens
	mod:dofile("scripts/mods/Dense Onslaught/Events/dark_omens")
	-- Blood in the Darkness
	mod:dofile("scripts/mods/Dense Onslaught/Events/blood_in_the_darkness")
	-- Enchanter's lair
	mod:dofile("scripts/mods/Dense Onslaught/Events/enchanters_lair")
	-- Trail of Treachery
	mod:dofile("scripts/mods/Dense Onslaught/Events/trail_of_treachery")

	create_weights()
	mod:enable_all_hooks()
	mutator.active = true
end

mutator.stop = function()

	TerrorEventBlueprints = mutator.OriginalTerrorEventBlueprints
	--HordeCompositions = mutator.OriginalHordeCompositions
	--PackSpawningSettings = mutator.OriginalPackSpawningSettings
	--PacingSettings.default = mutator.OriginalPacingSettingsDefault
	--PacingSettings.chaos = mutator.OriginalPacingSettingsChaos
	--SpecialsSettings = mutator.OriginalSpecialsSettings
	--BossSettings = mutator.OriginalBossSettings
	RecycleSettings.push_horde_if_num_alive_grunts_above = mutator.OriginalRecycleSettings.push_horde_if_num_alive_grunts_above
	RecycleSettings.max_grunts = mutator.OriginalRecycleSettings.max_grunts

	BeastmenStandardTemplates.healing_standard.radius = 15
	UtilityConsiderations.beastmen_place_standard.distance_to_target.max_value = 10
	BuffTemplates.healing_standard.buffs = mutator.OriginalBeastmenBannerBuff

	BreedPacks.skaven_beastmen = mutator.OriginalBreedPacks.skaven_beastmen
	BreedPacks.chaos_beastmen = mutator.OriginalBreedPacks.chaos_beastmen
	BreedPacks.beastmen = mutator.OriginalBreedPacks.beastmen
	BreedPacks.beastmen_elites = mutator.OriginalBreedPacks.beastmen_elites
	BreedPacks.beastmen_light = mutator.OriginalBreedPacks.beastmen_light
	BreedPacks.standard = mutator.OriginalBreedPacks.standard
	BreedPacks.standard_no_elites = mutator.OriginalBreedPacks.standard_no_elites
	BreedPacks.skaven = mutator.OriginalBreedPacks.skaven
	BreedPacks.shield_rats = mutator.OriginalBreedPacks.shield_rats
	BreedPacks.plague_monks = mutator.OriginalBreedPacks.plague_monks
	BreedPacks.marauders_shields = mutator.OriginalBreedPacks.marauders_shields

	PackSpawningSettings.default.area_density_coefficient = mutator.OriginalPackSpawningSettings.default.area_density_coefficient
	PackSpawningSettings.default_light.area_density_coefficient = mutator.OriginalPackSpawningSettings.default_light.area_density_coefficient
	PackSpawningSettings.skaven.area_density_coefficient = mutator.OriginalPackSpawningSettings.skaven.area_density_coefficient
	PackSpawningSettings.skaven_light.area_density_coefficient = mutator.OriginalPackSpawningSettings.skaven_light.area_density_coefficient
	PackSpawningSettings.chaos.area_density_coefficient = mutator.OriginalPackSpawningSettings.chaos.area_density_coefficient
	PackSpawningSettings.chaos_light.area_density_coefficient = mutator.OriginalPackSpawningSettings.chaos_light.area_density_coefficient
	PackSpawningSettings.beastmen.area_density_coefficient = mutator.OriginalPackSpawningSettings.beastmen.area_density_coefficient
	PackSpawningSettings.skaven_beastmen.area_density_coefficient = mutator.OriginalPackSpawningSettings.skaven_beastmen.area_density_coefficient
	PackSpawningSettings.chaos_beastmen.area_density_coefficient = mutator.OriginalPackSpawningSettings.chaos_beastmen.area_density_coefficient
	PackSpawningSettings.beastmen_light.area_density_coefficient = mutator.OriginalPackSpawningSettings.beastmen_light.area_density_coefficient

	PackSpawningSettings.default.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.default.roaming_set.breed_packs_override
	PackSpawningSettings.default_light.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.default_light.roaming_set.breed_packs_override
	PackSpawningSettings.skaven.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.skaven.roaming_set.breed_packs_override
	PackSpawningSettings.skaven_light.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.skaven_light.roaming_set.breed_packs_override
	PackSpawningSettings.chaos.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.chaos.roaming_set.breed_packs_override
	PackSpawningSettings.chaos_light.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.chaos_light.roaming_set.breed_packs_override
	PackSpawningSettings.beastmen.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.beastmen.roaming_set.breed_packs_override
	PackSpawningSettings.skaven_beastmen.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.skaven_beastmen.roaming_set.breed_packs_override
	PackSpawningSettings.chaos_beastmen.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.chaos_beastmen.roaming_set.breed_packs_override
	PackSpawningSettings.beastmen_light.roaming_set.breed_packs_override = mutator.OriginalPackSpawningSettings.beastmen_light.roaming_set.breed_packs_override

	PackSpawningSettings.default.difficulty_overrides = mutator.OriginalPackSpawningSettings.default.difficulty_overrides
	PackSpawningSettings.skaven.difficulty_overrides = mutator.OriginalPackSpawningSettings.skaven.difficulty_overrides
	PackSpawningSettings.skaven_light.difficulty_overrides = mutator.OriginalPackSpawningSettings.skaven_light.difficulty_overrides
	PackSpawningSettings.chaos.difficulty_overrides = mutator.OriginalPackSpawningSettings.chaos.difficulty_overrides
	PackSpawningSettings.beastmen.difficulty_overrides = mutator.OriginalPackSpawningSettings.beastmen.difficulty_overrides
	PackSpawningSettings.skaven_beastmen.difficulty_overrides = mutator.OriginalPackSpawningSettings.skaven_beastmen.difficulty_overrides
	PackSpawningSettings.chaos_beastmen.difficulty_overrides = mutator.OriginalPackSpawningSettings.chaos_beastmen.difficulty_overrides

	PacingSettings.default.peak_fade_threshold = mutator.OriginalPacingSettingsDefault.peak_fade_threshold
	PacingSettings.default.peak_intensity_threshold = mutator.OriginalPacingSettingsDefault.peak_intensity_threshold
	PacingSettings.default.sustain_peak_duration = mutator.OriginalPacingSettingsDefault.sustain_peak_duration
	PacingSettings.default.relax_duration = mutator.OriginalPacingSettingsDefault.relax_duration
	PacingSettings.default.horde_frequency = mutator.OriginalPacingSettingsDefault.horde_frequency
	PacingSettings.default.multiple_horde_frequency = mutator.OriginalPacingSettingsDefault.multiple_horde_frequency
	PacingSettings.default.max_delay_until_next_horde = mutator.OriginalPacingSettingsDefault.max_delay_until_next_horde
	PacingSettings.default.horde_startup_time = mutator.OriginalPacingSettingsDefault.horde_startup_time

	PacingSettings.default.mini_patrol.only_spawn_above_intensity = mutator.OriginalPacingSettingsDefault.mini_patrol.only_spawn_above_intensity
	PacingSettings.default.mini_patrol.only_spawn_below_intensity = mutator.OriginalPacingSettingsDefault.mini_patrol.only_spawn_below_intensity
	PacingSettings.default.mini_patrol.frequency = mutator.OriginalPacingSettingsDefault.mini_patrol.frequency
	PacingSettings.default.difficulty_overrides = mutator.OriginalPacingSettingsDefault.difficulty_overrides

	PacingSettings.chaos.peak_fade_threshold = mutator.OriginalPacingSettingsChaos.peak_fade_threshold
	PacingSettings.chaos.peak_intensity_threshold = mutator.OriginalPacingSettingsChaos.peak_intensity_threshold
	PacingSettings.chaos.sustain_peak_duration = mutator.OriginalPacingSettingsChaos.sustain_peak_duration
	PacingSettings.chaos.relax_duration = mutator.OriginalPacingSettingsChaos.relax_duration
	PacingSettings.chaos.horde_frequency = mutator.OriginalPacingSettingsChaos.horde_frequency
	PacingSettings.chaos.multiple_horde_frequency = mutator.OriginalPacingSettingsChaos.multiple_horde_frequency
	PacingSettings.chaos.max_delay_until_next_horde = mutator.OriginalPacingSettingsChaos.max_delay_until_next_horde
	PacingSettings.chaos.horde_startup_time = mutator.OriginalPacingSettingsChaos.horde_startup_time
	PacingSettings.chaos.multiple_hordes = mutator.OriginalPacingSettingsChaos.multiple_hordes

	PacingSettings.chaos.mini_patrol.only_spawn_above_intensity = mutator.OriginalPacingSettingsChaos.mini_patrol.only_spawn_above_intensity
	PacingSettings.chaos.mini_patrol.only_spawn_below_intensity = mutator.OriginalPacingSettingsChaos.mini_patrol.only_spawn_below_intensity
	PacingSettings.chaos.mini_patrol.frequency = mutator.OriginalPacingSettingsChaos.mini_patrol.frequency
	PacingSettings.chaos.difficulty_overrides = mutator.OriginalPacingSettingsChaos.difficulty_overrides

	PacingSettings.beastmen.peak_fade_threshold = mutator.OriginalPacingSettingsBeastmen.peak_fade_threshold
	PacingSettings.beastmen.peak_intensity_threshold = mutator.OriginalPacingSettingsBeastmen.peak_intensity_threshold
	PacingSettings.beastmen.sustain_peak_duration = mutator.OriginalPacingSettingsBeastmen.sustain_peak_duration
	PacingSettings.beastmen.relax_duration = mutator.OriginalPacingSettingsBeastmen.relax_duration
	PacingSettings.beastmen.horde_frequency = mutator.OriginalPacingSettingsBeastmen.horde_frequency
	PacingSettings.beastmen.multiple_horde_frequency = mutator.OriginalPacingSettingsBeastmen.multiple_horde_frequency
	PacingSettings.beastmen.max_delay_until_next_horde = mutator.OriginalPacingSettingsBeastmen.max_delay_until_next_horde
	PacingSettings.beastmen.horde_startup_time = mutator.OriginalPacingSettingsBeastmen.horde_startup_time

	PacingSettings.beastmen.mini_patrol.only_spawn_above_intensity = mutator.OriginalPacingSettingsBeastmen.mini_patrol.only_spawn_above_intensity
	PacingSettings.beastmen.mini_patrol.only_spawn_below_intensity = mutator.OriginalPacingSettingsBeastmen.mini_patrol.only_spawn_below_intensity
	PacingSettings.beastmen.mini_patrol.frequency = mutator.OriginalPacingSettingsBeastmen.mini_patrol.frequency
	PacingSettings.beastmen.difficulty_overrides = mutator.OriginalPacingSettingsBeastmen.difficulty_overrides

	HordeCompositionsPacing.small = mutator.OriginalHordeCompositionsPacing.small
	HordeCompositionsPacing.medium = mutator.OriginalHordeCompositionsPacing.medium
	HordeCompositionsPacing.large = mutator.OriginalHordeCompositionsPacing.large
	HordeCompositionsPacing.huge = mutator.OriginalHordeCompositionsPacing.huge
	HordeCompositionsPacing.huge_shields = mutator.OriginalHordeCompositionsPacing.huge_shields
	HordeCompositionsPacing.huge_armor = mutator.OriginalHordeCompositionsPacing.huge_armor
	HordeCompositionsPacing.huge_berzerker = mutator.OriginalHordeCompositionsPacing.huge_berzerker
	HordeCompositionsPacing.chaos_medium = mutator.OriginalHordeCompositionsPacing.chaos_medium
	HordeCompositionsPacing.chaos_large = mutator.OriginalHordeCompositionsPacing.chaos_large
	HordeCompositionsPacing.chaos_huge = mutator.OriginalHordeCompositionsPacing.chaos_huge
	HordeCompositionsPacing.chaos_huge_shields = mutator.OriginalHordeCompositionsPacing.chaos_huge_shields
	HordeCompositionsPacing.chaos_huge_armor = mutator.OriginalHordeCompositionsPacing.chaos_huge_armor
	HordeCompositionsPacing.chaos_huge_berzerker = mutator.OriginalHordeCompositionsPacing.chaos_huge_berzerker
	HordeCompositionsPacing.beastmen_medium = mutator.OriginalHordeCompositionsPacing.beastmen_medium
	HordeCompositionsPacing.beastmen_large = mutator.OriginalHordeCompositionsPacing.beastmen_large
	HordeCompositionsPacing.beastmen_huge = mutator.OriginalHordeCompositionsPacing.beastmen_huge
	HordeCompositionsPacing.beastmen_huge_armor = mutator.OriginalHordeCompositionsPacing.beastmen_huge_armor

	SpecialsSettings.default.max_specials = mutator.OriginalSpecialsSettings.default.max_specials
	SpecialsSettings.default_light.max_specials = mutator.OriginalSpecialsSettings.default_light.max_specials
	SpecialsSettings.skaven.max_specials = mutator.OriginalSpecialsSettings.skaven.max_specials
	SpecialsSettings.skaven_light.max_specials = mutator.OriginalSpecialsSettings.skaven_light.max_specials
	SpecialsSettings.chaos.max_specials = mutator.OriginalSpecialsSettings.chaos.max_specials
	SpecialsSettings.chaos_light.max_specials = mutator.OriginalSpecialsSettings.chaos_light.max_specials
	SpecialsSettings.beastmen.max_specials = mutator.OriginalSpecialsSettings.beastmen.max_specials
	SpecialsSettings.skaven_beastmen.max_specials = mutator.OriginalSpecialsSettings.skaven_beastmen.max_specials
	SpecialsSettings.chaos_beastmen.max_specials = mutator.OriginalSpecialsSettings.chaos_beastmen.max_specials
	PacingSettings.default.delay_specials_threat_value = mutator.OriginalPacingSettingsDefault.delay_specials_threat_value
	PacingSettings.chaos.delay_specials_threat_value = mutator.OriginalPacingSettingsChaos.delay_specials_threat_value
	PacingSettings.beastmen.delay_specials_threat_value = mutator.OriginalPacingSettingsBeastmen.delay_specials_threat_value
	SpecialsSettings.default.methods.specials_by_slots = mutator.OriginalSpecialsSettings.default.methods.specials_by_slots
	SpecialsSettings.default_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.default_light.methods.specials_by_slots
	SpecialsSettings.skaven.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven.methods.specials_by_slots
	SpecialsSettings.skaven_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven_light.methods.specials_by_slots
	SpecialsSettings.chaos.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos.methods.specials_by_slots
	SpecialsSettings.chaos_light.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos_light.methods.specials_by_slots
	SpecialsSettings.beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.beastmen.methods.specials_by_slots
	SpecialsSettings.skaven_beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.skaven_beastmen.methods.specials_by_slots
	SpecialsSettings.chaos_beastmen.methods.specials_by_slots = mutator.OriginalSpecialsSettings.chaos_beastmen.methods.specials_by_slots

	SpecialsSettings.default.difficulty_overrides = mutator.OriginalSpecialsSettings.default.difficulty_overrides
	SpecialsSettings.default_light.difficulty_overrides = mutator.OriginalSpecialsSettings.default_light.difficulty_overrides
	SpecialsSettings.skaven.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven.difficulty_overrides
	SpecialsSettings.skaven_light.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven_light.difficulty_overrides
	SpecialsSettings.chaos.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos.difficulty_overrides
	SpecialsSettings.chaos_light.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos_light.difficulty_overrides
	SpecialsSettings.beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.beastmen.difficulty_overrides
	SpecialsSettings.skaven_beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.skaven_beastmen.difficulty_overrides
	SpecialsSettings.chaos_beastmen.difficulty_overrides = mutator.OriginalSpecialsSettings.chaos_beastmen.difficulty_overrides

	for name, value in pairs(mutator.OriginalThreatValue) do
		Breeds[name].threat_value = value
	end

	Managers.state.conflict:set_threat_value("skaven_rat_ogre", mutator.OriginalThreatValue["skaven_rat_ogre"])
	Managers.state.conflict:set_threat_value("skaven_stormfiend", mutator.OriginalThreatValue["skaven_stormfiend"])
	Managers.state.conflict:set_threat_value("chaos_spawn", mutator.OriginalThreatValue["chaos_spawn"])
	Managers.state.conflict:set_threat_value("chaos_troll", mutator.OriginalThreatValue["chaos_troll"])
	Managers.state.conflict:set_threat_value("beastmen_minotaur", mutator.OriginalThreatValue["beastmen_minotaur"])

	BossSettings.default.boss_events.events = mutator.OriginalBossSettings.default.boss_events.events
	BossSettings.default_light.boss_events.events = mutator.OriginalBossSettings.default_light.boss_events.events
	BossSettings.skaven.boss_events.events = mutator.OriginalBossSettings.skaven.boss_events.events
	BossSettings.skaven_light.boss_events.events = mutator.OriginalBossSettings.skaven_light.boss_events.events
	BossSettings.chaos.boss_events.events = mutator.OriginalBossSettings.chaos.boss_events.events
	BossSettings.chaos_light.boss_events.events = mutator.OriginalBossSettings.chaos_light.boss_events.events
	BossSettings.beastmen.boss_events.events = mutator.OriginalBossSettings.beastmen.boss_events.events
	BossSettings.skaven_beastmen.boss_events.events = mutator.OriginalBossSettings.skaven_beastmen.boss_events.events
	BossSettings.chaos_beastmen.boss_events.events = mutator.OriginalBossSettings.chaos_beastmen.boss_events.events
	BossSettings.beastmen_light.boss_events.events = mutator.OriginalBossSettings.beastmen_light.boss_events.events

	HordeCompositions.event_smaller = mutator.OriginalHordeCompositions.event_smaller
	HordeCompositions.event_small = mutator.OriginalHordeCompositions.event_small
	HordeCompositions.event_medium = mutator.OriginalHordeCompositions.event_medium
	HordeCompositions.event_large = mutator.OriginalHordeCompositions.event_large
	HordeCompositions.event_small_chaos = mutator.OriginalHordeCompositions.event_small_chaos
	HordeCompositions.event_medium_chaos = mutator.OriginalHordeCompositions.event_medium_chaos
	HordeCompositions.event_large_chaos = mutator.OriginalHordeCompositions.event_large_chaos
	HordeCompositions.event_extra_spice_small = mutator.OriginalHordeCompositions.event_extra_spice_small
	HordeCompositions.event_extra_spice_medium = mutator.OriginalHordeCompositions.event_extra_spice_medium
	HordeCompositions.event_extra_spice_large = mutator.OriginalHordeCompositions.event_extra_spice_large

	HordeCompositions.military_end_event_chaos_01 = mutator.OriginalHordeCompositions.military_end_event_chaos_01
	HordeCompositions.military_end_event_berzerkers = mutator.OriginalHordeCompositions.military_end_event_berzerkers
	HordeCompositions.event_ussingen_gate_group = mutator.OriginalHordeCompositions.event_ussingen_gate_group

	table.remove(BreedBehaviors.chaos_exalted_sorcerer[7], 2)
	HordeCompositions.sorcerer_boss_event_defensive = mutator.OriginalHordeCompositions.sorcerer_boss_event_defensive
	HordeCompositions.sorcerer_extra_spawn = mutator.OriginalHordeCompositions.sorcerer_extra_spawn

	BreedActions.skaven_storm_vermin_warlord.spawn_allies.difficulty_spawn_list = mutator.OriginalBreedActions.skaven_storm_vermin_warlord.spawn_allies.difficulty_spawn_list
	BreedActions.skaven_storm_vermin_warlord.spawn_sequence.considerations.time_since_last.max_value = mutator.OriginalBreedActions.skaven_storm_vermin_warlord.spawn_sequence.considerations.time_since_last.max_value
	HordeCompositions.stronghold_boss_event_defensive = mutator.OriginalHordeCompositions.stronghold_boss_event_defensive
	HordeCompositions.stronghold_boss_trickle = mutator.OriginalHordeCompositions.stronghold_boss_trickle

	HordeCompositions.warcamp_boss_event_trickle = mutator.OriginalHordeCompositions.warcamp_boss_event_trickle
	HordeCompositions.warcamp_boss_event_defensive = mutator.OriginalHordeCompositions.warcamp_boss_event_defensive

	BreedActions.skaven_grey_seer.ground_combat.spawn_allies_cooldown = mutator.OriginalBreedActions.skaven_grey_seer.ground_combat.spawn_allies_cooldown
	BreedActions.skaven_grey_seer.ground_combat.staggers_until_teleport = mutator.OriginalBreedActions.skaven_grey_seer.ground_combat.staggers_until_teleport
	BreedActions.skaven_grey_seer.ground_combat.warp_lightning_spell_cooldown = mutator.OriginalBreedActions.skaven_grey_seer.ground_combat.warp_lightning_spell_cooldown
	BreedActions.skaven_grey_seer.ground_combat.vermintide_spell_cooldown = mutator.OriginalBreedActions.skaven_grey_seer.ground_combat.vermintide_spell_cooldown
	BreedActions.skaven_grey_seer.ground_combat.teleport_spell_cooldown = mutator.OriginalBreedActions.skaven_grey_seer.ground_combat.teleport_spell_cooldown
	HordeCompositions.skittergate_grey_seer_trickle = mutator.OriginalHordeCompositions.skittergate_grey_seer_trickle
	HordeCompositions.skittergate_boss_event_defensive = mutator.OriginalHordeCompositions.skittergate_boss_event_defensive
	Breeds.skaven_storm_vermin.primary_armor_category = nil
	Breeds.skaven_storm_vermin.max_health = BreedTweaks.max_health.stormvermin
	Breeds.skaven_storm_vermin.hit_mass_counts = BreedTweaks.hit_mass_counts.stormvermin
	Breeds.skaven_storm_vermin.bloodlust_health = BreedTweaks.bloodlust_health.skaven_elite
	Breeds.skaven_storm_vermin.size_variation_range = { 1.1, 1.175 }
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.min = 0
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.max = 30
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.min = 0
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.max = 5

	---------------------

	create_weights()
	mod:disable_all_hooks()
	mutator.active = false
end

local JOIN_MESSAGE = "Dense Onslaught Active"

mod:hook(MatchmakingManager, "rpc_matchmaking_request_join_lobby", function (func, self, channel_id, lobby_id, friend_join, client_dlc_unlocked_array)
	local peer_id = CHANNEL_TO_PEER_ID[channel_id]

	if mutator.active then
		mod:chat_whisper(peer_id, JOIN_MESSAGE)
	end

	return func(self, channel_id, lobby_id, friend_join, client_dlc_unlocked_array)
end)

mod:network_register("rpc_enable_white_sv", function (sender, enable)
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.min = 31
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.max = 31
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.min = 1
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.max = 1
end)

mod:network_register("rpc_disable_white_sv", function (sender, enable)
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.min = 0
	UnitVariationSettings.skaven_storm_vermin.material_variations.cloth_tint.max = 30
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.min = 0
	UnitVariationSettings.skaven_storm_vermin.material_variations.skin_tint.max = 5
end)

mod:hook_safe("ChatManager", "_add_message_to_list", function (self, channel_id, message_sender, local_player_id, message, is_system_message, pop_chat, is_dev, message_type, link, data)
	if message == JOIN_MESSAGE and not mutator.active then
		mod:network_send("rpc_enable_white_sv", "local", true)
	end
end)

mod.on_user_joined = function (player)
	if mutator.active then
		mod:network_send("rpc_enable_white_sv", player.peer_id, mutator.active)
	end
end

mutator.toggle = function()
	if Managers.state.game_mode == nil or (Managers.state.game_mode._game_mode_key ~= "inn" and Managers.player.is_server) then
		mod:echo("You must be in the keep to do that!")
		return
	end
	if Managers.matchmaking:_matchmaking_status() ~= "idle" then
		mod:echo("You must cancel matchmaking before toggling this.")
		return
	end
	if not mutator.active then
		if not Managers.player.is_server then
			mod:echo("You must be the host to activate this.")
			return
		end
		mutator.start()
		mod:network_send("rpc_enable_white_sv", "all", true)

		mod:chat_broadcast("Dense Onslaught ENABLED.")
	else
		mutator.stop()
		mod:network_send("rpc_disable_white_sv", "all", true)

		mod:chat_broadcast("Dense Onslaught DISABLED.")
	end
end


--[[
	Callback
--]]
-- Call when game state changes (e.g. StateLoading -> StateIngame)
mod.on_game_state_changed = function(status, state)
	if not Managers.player.is_server and mutator.active and Managers.state.game_mode ~= nil then
		mutator.stop()
		mod:echo("The Dense Onslaught mutator was disabled because you are no longer the server.")
	end
	return
end

--[[
	Execution
--]]
mod:command("dense_onslaught", "Toggle Dense Onslaught. Must be host and in the keep.", function() mutator.toggle() end)
if not mutator.active then
	mod:disable_all_hooks()
end
