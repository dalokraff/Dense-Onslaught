local ground_zero = {}

local ACTIONS = BreedActions.chaos_exalted_sorcerer
local restore_bubbledude = {
	"BTSpawnAllies",
	enter_hook = "sorcerer_spawn_horde",
	name = "sorcerer_spawn_horde",
	action_data = ACTIONS.spawn_allies_horde
}

table.insert(BreedBehaviors.chaos_exalted_sorcerer[7], 2, restore_bubbledude)

ground_zero.dense_gz_elevator_guards_a = {
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_1",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_2",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_3",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_4",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_5",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_a_6",
        breed_name = "skaven_storm_vermin_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_1",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_2",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_3",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_4",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_5",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_6",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_7",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "ele_guard_b_8",
        breed_name = "skaven_clan_rat_with_shield"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_1",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_2",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_3",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_4",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_5",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "spawn_at_raw",
        spawner_id = "onslaught_ele_guard_c_6",
        breed_name = "skaven_storm_vermin_commander"
    },
    {
        "delay",
        duration = 5
    }
}

ground_zero.dense_gz_chaos_boss = {
    {
        "set_master_event_running",
        name = "gz_chaos_boss"
    },
    {
        "disable_kick"
    },
    {
        "control_pacing",
        enable = false
    },
    {
        "control_specials",
        enable = false
    },
    {
        "spawn_at_raw",
        spawner_id = "warcamp_chaos_boss",
        breed_name = "chaos_exalted_sorcerer"
    },
    {
        "continue_when",
        condition = function (t)
            return count_event_breed("chaos_exalted_sorcerer") == 1
        end
    },
    {
        "continue_when",
        condition = function (t)
            return count_event_breed("chaos_exalted_sorcerer") < 1
        end
    },
    {
        "flow_event",
        flow_event_name = "gz_chaos_boss_dead"
    },
    {
        "control_pacing",
        enable = true
    },
    {
        "control_specials",
        enable = true
    }
}

return ground_zero