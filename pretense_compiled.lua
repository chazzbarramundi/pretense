--[[
Pretense Dynamic Mission Engine v2.0.alpha4
## Description:

Pretense Dynamic Mission Engine (PDME) is a the heart and soul of the Pretense missions.
You are allowed to use and modify this script for personal or private use.
Please do not share modified versions of this script.
Please do not reupload missions that use this script.
Please do not charge money for access to missions using this script.

## Links:

ED Forums Post: <https://forum.dcs.world/topic/327483-pretense-dynamic-campaign>

Pretense Manual: <https://github.com/Dzsek/pretense>

If you'd like to buy me a beer: <https://www.buymeacoffee.com/dzsek>

Makes use of Mission scripting tools (Mist): <https://github.com/mrSkortch/MissionScriptingTools>

@script PDME
@author Dzsekeb

]]--

-----------------[[ GroupCorrection.lua ]]-----------------

Group.getByNameBase = Group.getByName

function Group.getByName(name)
    local g = Group.getByNameBase(name)
    if not g then return nil end
    if g:getSize() == 0 then return nil end
    return g
end

-----------------[[ END OF GroupCorrection.lua ]]-----------------



-----------------[[ WarehouseManager.lua ]]-----------------

WarehouseManager = {}

do
	local JSON = (loadfile('Scripts/JSON.lua'))()

	function WarehouseManager.addAllWeapons(airfield, amount)
		local ab = Airbase.getByName(airfield)
		if not ab then return end

		local wh = ab:getWarehouse()
		if not wh then return end

		for i,v in pairs(WarehouseManager.weapons) do
			if v>0 then
				wh:addItem(i, amount*v)
			end
		end
	end

	function WarehouseManager.addAllFuel(airfield, amount)
		local ab = Airbase.getByName(airfield)
		if not ab then return end

		local wh = ab:getWarehouse()
		if not wh then return end

		wh:addLiquid(0, amount)
		wh:addLiquid(1, amount)
		wh:addLiquid(2, amount)
		wh:addLiquid(3, amount)
	end

	function WarehouseManager.restore(airfield, inventory)
		local ab = Airbase.getByName(airfield)
		if not ab then return end

		local wh = ab:getWarehouse()
		if not wh then return end

		local inv = JSON:decode(inventory)
		
		for i,v in pairs(inv.weapon) do
			wh:setItem(i,v)
		end

		for i,v in pairs(inv.aircraft) do
			wh:setItem(i,v)
		end

		wh:setLiquidAmount(0, inv.liquids.jet)
		wh:setLiquidAmount(1, inv.liquids.avgas)
		wh:setLiquidAmount(2, inv.liquids.mw)
		wh:setLiquidAmount(3, inv.liquids.diesel)
	end

	function WarehouseManager.toString(airfield)
		local ab = Airbase.getByName(airfield)
		if not ab then return end

		local wh = ab:getWarehouse()
		if not wh then return end

		local inv = wh:getInventory()

		inv.liquids = {
			jet = inv.liquids[0],
			avgas = inv.liquids[1],
			mw = inv.liquids[2],
			diesel = inv.liquids[3]
		}

		local inventory = JSON:encode(inv)
		return inventory
	end

	WarehouseManager.weapons= {
		["weapons.droptanks.Bidon"] = 1,
		["weapons.missiles.P_24T"] = 1,
		["weapons.bombs.BLU-3B_OLD"] = 1,
		["weapons.missiles.AGM_154"] = 1,
		["weapons.nurs.HYDRA_70_M151_M433"] = 1,
		["weapons.bombs.British_GP_250LB_Bomb_Mk5"] = 1,
		["weapons.containers.{OV10_SMOKE}"] = 1,
		["weapons.bombs.BLU-4B_OLD"] = 1,
		["weapons.nurs.S5MO_HEFRAG_FFAR"] = 1,
		["weapons.bombs.GBU_38"] = 1,
		["weapons.missiles.AIM-9P3"] = 1,
		["weapons.bombs.BEER_BOMB"] = 1,
		["weapons.containers.LANTIRN"] = 1,
		["weapons.nurs.C_8CM_GN"] = 1,
		["weapons.bombs.FAB-500SL"] = 1,
		["weapons.nurs.C_13"] = 1,
		["weapons.bombs.250-2"] = 1,
		["weapons.droptanks.Spitfire_tank_1"] = 1,
		["weapons.missiles.AGM_65G"] = 1,
		["weapons.missiles.AGM_65A"] = 1,
		["weapons.missiles.AGM_78B"] = 1,
		["weapons.containers.Hercules_JATO"] = 1,
		["weapons.nurs.HYDRA_70_M259"] = 1,
		["weapons.containers.uh-60l_pilot"] = 1,
		["weapons.missiles.AGM_84E"] = 1,
		["weapons.bombs.AN_M30A1"] = 1,
		["weapons.nurs.C_25"] = 1,
		["weapons.containers.AV8BNA_ALQ164"] = 1,
		["weapons.containers.lav-25"] = 1,
		["weapons.missiles.P_60"] = 1,
		["weapons.bombs.OH58D_Red_Smoke_Grenade"] = 1,
		["weapons.bombs.FAB_1500"] = 1,
		["weapons.missiles.AIM-92E"] = 1,
		["weapons.droptanks.FuelTank_350L"] = 1,
		["weapons.bombs.AAA Vulcan M163 Skid [21577lb]"] = 1,
		["weapons.missiles.Kormoran"] = 1,
		["weapons.droptanks.HB_F14_EXT_DROPTANK_EMPTY"] = 1,
		["weapons.missiles.KD_63B"] = 1,
		["weapons.missiles.AIM_120"] = 1,
		["weapons.missiles.AIM_54C_Mk60"] = 1,
		["weapons.bombs.APC Cobra Air [10912lb]"] = 1,
		["weapons.missiles.Vikhr_M"] = 1,
		["weapons.nurs.FFAR M156 WP"] = 1,
		["weapons.nurs.British_HE_60LBSAPNo2_3INCHNo1"] = 1,
		["weapons.missiles.DWS39_MJ2"] = 1,
		["weapons.bombs.HEBOMBD"] = 1,
		["weapons.missiles.CATM_9M"] = 1,
		["weapons.bombs.Mk_81"] = 1,
		["weapons.droptanks.Drop_Tank_300_Liter"] = 1,
		["weapons.containers.HMMWV_M1025"] = 1,
		["weapons.bombs.SAM CHAPARRAL Air [21624lb]"] = 1,
		["weapons.missiles.AGM_154A"] = 1,
		["weapons.bombs.Mk_84AIR_TP"] = 1,
		["weapons.bombs.GBU_31_V_3B"] = 1,
		["weapons.nurs.C_8CM_WH"] = 1,
		["weapons.missiles.Matra Super 530D"] = 1,
		["weapons.nurs.ARF8M3TPSM"] = 1,
		["weapons.missiles.TGM_65H"] = 1,
		["weapons.bombs.Type_200A"] = 1,
		["weapons.nurs.M8rocket"] = 1,
		["weapons.bombs.GBU_27"] = 1,
		["weapons.missiles.AGR_20A"] = 1,
		["weapons.droptanks.M2KC_RPL_522_EMPTY"] = 1,
		["weapons.droptanks.M2KC_02_RPL541"] = 1,
		["weapons.missiles.AGM_84A"] = 1,
		["weapons.bombs.APC BTR-80 Air [23936lb]"] = 1,
		["weapons.missiles.P_33E"] = 1,
		["weapons.missiles.Ataka_9M120"] = 1,
		["weapons.bombs.MK76"] = 1,
		["weapons.bombs.AB_250_2_SD_2"] = 1,
		["weapons.missiles.Rb 05A"] = 1,
		["weapons.missiles.HB-AIM-7E-2"] = 1,
		["weapons.bombs.ART GVOZDIKA [34720lb]"] = 1,
		["weapons.missiles.AGM_78A"] = 1,
		["weapons.bombs.FAB_100SV"] = 1,
		["weapons.bombs.BetAB_500"] = 1,
		["weapons.droptanks.M2KC_02_RPL541_EMPTY"] = 1,
		["weapons.droptanks.PTB600_MIG15"] = 1,
		["weapons.missiles.Rb 24J"] = 1,
		["weapons.missiles.P_27PE"] = 1,
		["weapons.droptanks."] = 1,
		["weapons.missiles.LS_6"] = 1,
		["weapons.nurs.WGr21"] = 1,
		["weapons.bombs.SAMP250HD"] = 1,
		["weapons.containers.alq-184long"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_WingTank_R_EMPTY"] = 1,
		["weapons.containers.{EclairM_60}"] = 1,
		["weapons.bombs.British_SAP_250LB_Bomb_Mk5"] = 1,
		["weapons.bombs.SAB_250_200"] = 1,
		["weapons.bombs.Mk_83CT"] = 1,
		["weapons.missiles.AIM-7P"] = 1,
		["weapons.missiles.AT_6"] = 1,
		["weapons.containers.HB_ALE_40_0_120"] = 1,
		["weapons.nurs.SNEB_TYPE254_H1_GREEN"] = 1,
		["weapons.nurs.SNEB_TYPE250_F1B"] = 1,
		["weapons.containers.U22A"] = 1,
		["weapons.containers.kg600"] = 1,
		["weapons.bombs.CBU_105"] = 1,
		["weapons.droptanks.FW-190_Fuel-Tank"] = 1,
		["weapons.missiles.X_58"] = 1,
		["weapons.containers.HB_ALE_40_0_0"] = 1,
		["weapons.containers.Fantasm"] = 1,
		["weapons.missiles.BK90_MJ1_MJ2"] = 1,
		["weapons.nurs.FFAR_Mk61"] = 1,
		["weapons.missiles.TGM_65D"] = 1,
		["weapons.containers.BRD-4-250"] = 1,
		["weapons.bombs.HB_F4E_GBU15V1"] = 1,
		["weapons.missiles.P_73"] = 1,
		["weapons.bombs.AN_M66"] = 1,
		["weapons.bombs.APC LAV-25 Air [22520lb]"] = 1,
		["weapons.missiles.AIM-7MH"] = 1,
		["weapons.containers.HB_F14_EXT_AN_APQ-167"] = 1,
		["weapons.nurs.LWL_RP"] = 1,
		["weapons.droptanks.SEAHAWK_120_Fuel_Tank"] = 1,
		["weapons.bombs.SC_250_T3_J"] = 1,
		["weapons.bombs.SAM LINEBACKER [34720lb]"] = 1,
		["weapons.missiles.AGM_86C"] = 1,
		["weapons.missiles.X_35"] = 1,
		["weapons.bombs.AGM_62_I"] = 1,
		["weapons.bombs.MK106"] = 1,
		["weapons.containers.ETHER"] = 1,
		["weapons.bombs.BETAB-500S"] = 1,
		["weapons.nurs.C_5"] = 1,
		["weapons.containers.TANGAZH"] = 1,
		["weapons.bombs.British_MC_500LB_Bomb_Mk2"] = 1,
		["weapons.containers.ANAWW_13"] = 1,
		["weapons.droptanks.droptank_108_gal"] = 1,
		["weapons.droptanks.DFT_300_GAL_A4E_LR"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_BLUE}"] = 1,
		["weapons.missiles.GAR-8"] = 1,
		["weapons.bombs.BELOUGA"] = 1,
		["weapons.containers.{EclairM_33}"] = 1,
		["weapons.bombs.ART 2S9 NONA Air [19140lb]"] = 1,
		["weapons.bombs.BR_250"] = 1,
		["weapons.bombs.IAB-500"] = 1,
		["weapons.bombs.LYSBOMB 11086"] = 1,
		["weapons.containers.AN_ASQ_228"] = 1,
		["weapons.containers.Stub_Wing"] = 1,
		["weapons.missiles.P_27P"] = 1,
		["weapons.bombs.OH58D_Green_Smoke_Grenade"] = 1,
		["weapons.bombs.SD_250_Stg"] = 1,
		["weapons.missiles.R_530F_IR"] = 1,
		["weapons.bombs.British_SAP_500LB_Bomb_Mk5"] = 1,
		["weapons.bombs.FAB-250M54"] = 1,
		["weapons.containers.{M2KC_AAF}"] = 1,
		["weapons.missiles.CM-802AKG_AI"] = 1,
		["weapons.bombs.CBU_103"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_RED}"] = 1,
		["weapons.missiles.X_29T"] = 1,
		["weapons.missiles.Sea_Eagle"] = 1,
		["weapons.missiles.C-701IR"] = 1,
		["weapons.containers.fullCargoSeats"] = 1,
		["weapons.bombs.GBU_15_V_31_B"] = 1,
		["weapons.bombs.APC M1043 HMMWV Armament Air [7023lb]"] = 1,
		["weapons.missiles.PL-5EII"] = 1,
		["weapons.bombs.SC_250_T1_L2"] = 1,
		["weapons.torpedoes.mk46torp_name"] = 1,
		["weapons.containers.F-15E_AAQ-33_XR_ATP-SE"] = 1,
		["weapons.missiles.AIM_7"] = 1,
		["weapons.missiles.AGM_122"] = 1,
		["weapons.bombs.HEBOMB"] = 1,
		["weapons.bombs.CBU_97"] = 1,
		["weapons.bombs.MK-81SE"] = 1,
		["weapons.nurs.Zuni_127"] = 1,
		["weapons.containers.{M2KC_AGF}"] = 1,
		["weapons.droptanks.Hercules_ExtFuelTank"] = 1,
		["weapons.containers.{SMOKE_WHITE}"] = 1,
		["weapons.droptanks.droptank_150_gal"] = 1,
		["weapons.nurs.HYDRA_70_WTU1B"] = 1,
		["weapons.missiles.GB-6-SFW"] = 1,
		["weapons.bombs.GBU_28"] = 1,
		["weapons.missiles.AIM-9E"] = 1,
		["weapons.droptanks.HB_F14_EXT_DROPTANK"] = 1,
		["weapons.missiles.Super_530F"] = 1,
		["weapons.missiles.Ataka_9M220"] = 1,
		["weapons.bombs.BDU_33"] = 1,
		["weapons.bombs.OH6_FRAG"] = 1,
		["weapons.bombs.Transport M818 [16000lb]"] = 1,
		["weapons.bombs.ATGM M1045 HMMWV TOW Air [7183lb]"] = 1,
		["weapons.missiles.C_701T"] = 1,
		["weapons.missiles.X_25MR"] = 1,
		["weapons.droptanks.fueltank230"] = 1,
		["weapons.droptanks.PTB-490C-MIG21"] = 1,
		["weapons.bombs.M1025 HMMWV Air [6160lb]"] = 1,
		["weapons.nurs.SNEB_TYPE254_F1B_GREEN"] = 1,
		["weapons.missiles.R_550"] = 1,
		["weapons.bombs.KAB_1500LG"] = 1,
		["weapons.missiles.AGM_84D"] = 1,
		["weapons.missiles.YJ-83K"] = 1,
		["weapons.missiles.AIM_54C_Mk47"] = 1,
		["weapons.missiles.BRM-1_90MM"] = 1,
		["weapons.missiles.Ataka_9M120F"] = 1,
		["weapons.droptanks.1100L Tank"] = 1,
		["weapons.bombs.BAP_100"] = 1,
		["weapons.adapters.lau-88"] = 1,
		["weapons.missiles.P_40T"] = 1,
		["weapons.missiles.GB-6"] = 1,
		["weapons.bombs.FAB-250M54TU"] = 1,
		["weapons.missiles.DWS39_MJ1"] = 1,
		["weapons.missiles.CM-802AKG"] = 1,
		["weapons.bombs.FAB_250"] = 1,
		["weapons.missiles.C_802AK"] = 1,
		["weapons.bombs.OH58D_Yellow_Smoke_Grenade"] = 1,
		["weapons.bombs.SD_500_A"] = 1,
		["weapons.bombs.GBU_32_V_2B"] = 1,
		["weapons.missiles.KD_63"] = 1,
		["weapons.containers.marder"] = 1,
		["weapons.missiles.ADM_141B"] = 1,
		["weapons.bombs.ROCKEYE"] = 1,
		["weapons.missiles.BK90_MJ1"] = 1,
		["weapons.containers.BTR-80"] = 1,
		["weapons.bombs.SAM ROLAND ADS [34720lb]"] = 1,
		["weapons.containers.wmd7"] = 1,
		["weapons.missiles.AIM-7E-2"] = 1,
		["weapons.nurs.HVAR"] = 1,
		["weapons.containers.HMMWV_M1043"] = 1,
		["weapons.droptanks.PTB-800-MIG21"] = 1,
		["weapons.missiles.AGM_114"] = 1,
		["weapons.containers.HB_ORD_Pave_Spike_Fast"] = 1,
		["weapons.bombs.APC M1126 Stryker ICV [29542lb]"] = 1,
		["weapons.bombs.APC M113 Air [21624lb]"] = 1,
		["weapons.bombs.M_117"] = 1,
		["weapons.missiles.AGM_65D"] = 1,
		["weapons.droptanks.MB339_TT320_L"] = 1,
		["weapons.missiles.AGM_86"] = 1,
		["weapons.missiles.SPIKE_ER2"] = 1,
		["weapons.bombs.BDU_45LGB"] = 1,
		["weapons.containers.KINGAL"] = 1,
		["weapons.missiles.AGM_65H"] = 1,
		["weapons.nurs.RS-82"] = 1,
		["weapons.nurs.SNEB_TYPE252_F1B"] = 1,
		["weapons.bombs.BL_755"] = 1,
		["weapons.containers.F-15E_AAQ-28_LITENING"] = 1,
		["weapons.nurs.SNEB_TYPE256_F1B"] = 1,
		["weapons.missiles.AGM_84H"] = 1,
		["weapons.missiles.AIM_54"] = 1,
		["weapons.missiles.X_31A"] = 1,
		["weapons.bombs.KAB_500Kr"] = 1,
		["weapons.containers.SPS-141-100"] = 1,
		["weapons.missiles.BK90_MJ2"] = 1,
		["weapons.missiles.Super_530D"] = 1,
		["weapons.bombs.CBU_52B"] = 1,
		["weapons.droptanks.PTB-450"] = 1,
		["weapons.bombs.IFV MCV-80 [34720lb]"] = 1,
		["weapons.containers.SPS-141"] = 1,
		["weapons.containers.2-c9"] = 1,
		["weapons.missiles.AIM-9JULI"] = 1,
		["weapons.droptanks.MB339_TT500_R"] = 1,
		["weapons.nurs.C_8CM"] = 1,
		["weapons.containers.BARAX"] = 1,
		["weapons.missiles.P_40R"] = 1,
		["weapons.missiles.YJ-12"] = 1,
		["weapons.bombs.BDU_45"] = 1,
		["weapons.nurs.SNEB_TYPE254_H1_YELLOW"] = 1,
		["weapons.bombs.Durandal"] = 1,
		["weapons.droptanks.i16_eft"] = 1,
		["weapons.droptanks.AV8BNA_AERO1D_EMPTY"] = 1,
		["weapons.bombs.BLU-3B_GROUP"] = 1,
		["weapons.containers.HB_ALE_40_30_0"] = 1,
		["weapons.containers.Hercules_Battle_Station_TGP"] = 1,
		["weapons.nurs.C_8CM_VT"] = 1,
		["weapons.droptanks.HB_HIGH_PERFORMANCE_CENTERLINE_600_GAL"] = 1,
		["weapons.missiles.PL-12"] = 1,
		["weapons.missiles.R-3R"] = 1,
		["weapons.bombs.GBU_54_V_1B"] = 1,
		["weapons.droptanks.MB339_TT320_R"] = 1,
		["weapons.bombs.RN-24"] = 1,
		["weapons.bombs.GBU_10"] = 1,
		["weapons.bombs.ARV BRDM-2 Air [12320lb]"] = 1,
		["weapons.bombs.ARV BRDM-2 Skid [12210lb]"] = 1,
		["weapons.missiles.R_550_M1"] = 1,
		["weapons.nurs.SNEB_TYPE251_F1B"] = 1,
		["weapons.missiles.X_41"] = 1,
		["weapons.containers.{MIG21_SMOKE_WHITE}"] = 1,
		["weapons.bombs.MK_82AIR"] = 1,
		["weapons.missiles.R_530F_EM"] = 1,
		["weapons.bombs.SAMP400LD"] = 1,
		["weapons.missiles.AGM_114K"] = 1,
		["weapons.bombs.AB_250_2_SD_10A"] = 1,
		["weapons.missiles.ADM_141A"] = 1,
		["weapons.missiles.AGM_65B"] = 1,
		["weapons.bombs.British_GP_500LB_Bomb_Mk4"] = 1,
		["weapons.missiles.AGM_65E"] = 1,
		["weapons.containers.sa342_dipole_antenna"] = 1,
		["weapons.bombs.OFAB-100 Jupiter"] = 1,
		["weapons.nurs.SNEB_TYPE257_F1B"] = 1,
		["weapons.missiles.Rb 04E (for A.I.)"] = 1,
		["weapons.bombs.AN-M66A2"] = 1,
		["weapons.missiles.P_27T"] = 1,
		["weapons.droptanks.LNS_VIG_XTANK"] = 1,
		["weapons.containers.ALQ-184"] = 1,
		["weapons.missiles.R-55"] = 1,
		["weapons.torpedoes.YU-6"] = 1,
		["weapons.containers.RobbieTank1"] = 1,
		["weapons.droptanks.PTB_120_F86F35"] = 1,
		["weapons.missiles.PL-8B"] = 1,
		["weapons.missiles.AGM_45B"] = 1,
		["weapons.containers.SKY_SHADOW"] = 1,
		["weapons.nurs.British_HE_60LBFNo1_3INCHNo1"] = 1,
		["weapons.missiles.P_77"] = 1,
		["weapons.torpedoes.LTF_5B"] = 1,
		["weapons.bombs.BLU-3_GROUP"] = 1,
		["weapons.missiles.R-3S"] = 1,
		["weapons.nurs.SNEB_TYPE253_H1"] = 1,
		["weapons.missiles.PL-8A"] = 1,
		["weapons.bombs.APC BTR-82A Skid [24888lb]"] = 1,
		["weapons.containers.Sborka"] = 1,
		["weapons.missiles.AGM_65L"] = 1,
		["weapons.missiles.X_28"] = 1,
		["weapons.missiles.KD_20"] = 1,
		["weapons.missiles.TGM_65G"] = 1,
		["weapons.nurs.SNEB_TYPE257_H1"] = 1,
		["weapons.bombs.BetAB_500ShP"] = 1,
		["weapons.missiles.X_25ML"] = 1,
		["weapons.nurs.UG_90MM"] = 1,
		["weapons.bombs.BLG66"] = 1,
		["weapons.missiles.Rb_04"] = 1,
		["weapons.nurs.C_8CM_RD"] = 1,
		["weapons.containers.{EclairM_06}"] = 1,
		["weapons.bombs.OH6_SMOKE_GREEN"] = 1,
		["weapons.bombs.LYSBOMB 11087"] = 1,
		["weapons.bombs.RBK_500AO"] = 1,
		["weapons.missiles.AIM-9P"] = 1,
		["weapons.bombs.British_GP_500LB_Bomb_Mk4_Short"] = 1,
		["weapons.containers.MB339_Vinten"] = 1,
		["weapons.nurs.HYDRA_70_MK61"] = 1,
		["weapons.missiles.Rb 74"] = 1,
		["weapons.missiles.Rb 15F"] = 1,
		["weapons.bombs.LYSBOMB 11088"] = 1,
		["weapons.containers.UH60L_Jayhawk"] = 1,
		["weapons.containers.Pavehawk"] = 1,
		["weapons.nurs.ARAKM70BHE"] = 1,
		["weapons.droptanks.JAYHAWK_80gal_Fuel_Tankv2"] = 1,
		["weapons.bombs.AAA Vulcan M163 Air [21666lb]"] = 1,
		["weapons.missiles.X_29L"] = 1,
		["weapons.droptanks.JAYHAWK_120_Fuel_Tank"] = 1,
		["weapons.containers.Seahawk_Pylon"] = 1,
		["weapons.containers.{F14-LANTIRN-TP}"] = 1,
		["weapons.bombs.FAB-250-M62"] = 1,
		["weapons.missiles.AIM_120C"] = 1,
		["weapons.nurs.LWL_MPP"] = 1,
		["weapons.containers.leftSeat"] = 1,
		["weapons.bombs.SAMP250LD"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_GREEN}"] = 1,
		["weapons.nurs.S_5KP"] = 1,
		["weapons.bombs.FAB-500M54TU"] = 1,
		["weapons.missiles.SPIKE_ER"] = 1,
		["weapons.missiles.AIM-92J"] = 1,
		["weapons.bombs.GBU_31_V_4B"] = 1,
		["weapons.droptanks.PTB400_MIG15"] = 1,
		["weapons.missiles.HB-AIM-7E"] = 1,
		["weapons.bombs.SPG M1128 Stryker MGS [33036lb]"] = 1,
		["weapons.missiles.AIM-9L"] = 1,
		["weapons.containers.AAQ-33"] = 1,
		["weapons.containers.ALQ-131"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_Center_Fuel_Tank_EMPTY"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_WingTank_EMPTY"] = 1,
		["weapons.missiles.AIM_9X"] = 1,
		["weapons.containers.HB_ALE_40_15_90"] = 1,
		["weapons.containers.MH60_SOAR"] = 1,
		["weapons.droptanks.F-15E_Drop_Tank"] = 1,
		["weapons.droptanks.M2KC_08_RPL541_EMPTY"] = 1,
		["weapons.droptanks.oiltank"] = 1,
		["weapons.containers.MB339_SMOKE-POD"] = 1,
		["weapons.containers.MB339_TravelPod"] = 1,
		["weapons.nurs.C_8"] = 1,
		["weapons.bombs.SAM CHAPARRAL Skid [21516lb]"] = 1,
		["weapons.containers.Gepard"] = 1,
		["weapons.droptanks.PTB_580G_F1"] = 1,
		["weapons.containers.{EclairM_15}"] = 1,
		["weapons.containers.HB_F14_EXT_TARPS"] = 1,
		["weapons.containers.16c_hts_pod"] = 1,
		["weapons.missiles.P_27TE"] = 1,
		["weapons.droptanks.Mosquito_Drop_Tank_100gal"] = 1,
		["weapons.droptanks.Mosquito_Drop_Tank_50gal"] = 1,
		["weapons.containers.IRDeflector"] = 1,
		["weapons.bombs.ODAB-500PM"] = 1,
		["weapons.bombs.BAP-100"] = 1,
		["weapons.droptanks.PTB-490-MIG21"] = 1,
		["weapons.containers.SPRD"] = 1,
		["weapons.missiles.GB-6-HE"] = 1,
		["weapons.bombs.GBU-43/B(MOAB)"] = 1,
		["weapons.bombs.Generic Crate [20000lb]"] = 1,
		["weapons.containers.HB_F14_EXT_ECA"] = 1,
		["weapons.missiles.Rb 24"] = 1,
		["weapons.bombs.IFV BMD-1 Skid [17930lb]"] = 1,
		["weapons.droptanks.PTB400_MIG19"] = 1,
		["weapons.containers.{MIG21_SMOKE_RED}"] = 1,
		["weapons.bombs.IFV BMD-1 Air [18040lb]"] = 1,
		["weapons.bombs.APC MTLB Skid [26290lb]"] = 1,
		["weapons.nurs.SPRD-99"] = 1,
		["weapons.containers.SHPIL"] = 1,
		["weapons.torpedoes.Mark_46"] = 1,
		["weapons.missiles.AGM_45A"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_ORANGE}"] = 1,
		["weapons.bombs.SAB_100MN"] = 1,
		["weapons.nurs.FFAR Mk5 HEAT"] = 1,
		["weapons.bombs.IFV TPZ FUCH [33440lb]"] = 1,
		["weapons.containers.2c6m"] = 1,
		["weapons.containers.{ECM_POD_L_175V}"] = 1,
		["weapons.bombs.IFV M2A2 Bradley [34720lb]"] = 1,
		["weapons.containers.LANTIRN-F14-TARGET"] = 1,
		["weapons.bombs.MK77mod0-WPN"] = 1,
		["weapons.bombs.SC_50"] = 1,
		["weapons.containers.ASO-2"] = 1,
		["weapons.missiles.AGM_88"] = 1,
		["weapons.nurs.S_5M"] = 1,
		["weapons.containers.HMMWV_M973"] = 1,
		["weapons.droptanks.M2KC_08_RPL541"] = 1,
		["weapons.nurs.S-24A"] = 1,
		["weapons.bombs.RBK_250_275_AO_1SCH"] = 1,
		["weapons.bombs.ATGM M1134 Stryker [30337lb]"] = 1,
		["weapons.bombs.Transport Tigr Skid [15730lb]"] = 1,
		["weapons.bombs.OH58D_White_Smoke_Grenade"] = 1,
		["weapons.bombs.KAB_500S"] = 1,
		["weapons.missiles.AIM-7F"] = 1,
		["weapons.missiles.AIM-7E"] = 1,
		["weapons.bombs.CBU_99"] = 1,
		["weapons.nurs.HYDRA_70_M257"] = 1,
		["weapons.bombs.FAB-500TA"] = 1,
		["weapons.missiles.AGR_20_M282"] = 1,
		["weapons.droptanks.MB339_FT330"] = 1,
		["weapons.bombs.OH58D_Blue_Smoke_Grenade"] = 1,
		["weapons.containers.HMMWV_M1045"] = 1,
		["weapons.bombs.SAMP125LD"] = 1,
		["weapons.containers.OV-10A_Paratrooper"] = 1,
		["weapons.missiles.X_25MP"] = 1,
		["weapons.containers.{CE2_SMOKE_WHITE}"] = 1,
		["weapons.nurs.SNEB_TYPE252_H1"] = 1,
		["weapons.missiles.AGM_65F"] = 1,
		["weapons.droptanks.800L Tank"] = 1,
		["weapons.missiles.AIM-9P5"] = 1,
		["weapons.bombs.Transport Tigr Air [15900lb]"] = 1,
		["weapons.nurs.SNEB_TYPE254_H1_RED"] = 1,
		["weapons.bombs.HB_F4E_GBU_8_HOBOS"] = 1,
		["weapons.containers.dlpod_akg"] = 1,
		["weapons.nurs.FFAR Mk1 HE"] = 1,
		["weapons.bombs.Mk_84AIR_GP"] = 1,
		["weapons.bombs.RN-28"] = 1,
		["weapons.bombs.BIN_200"] = 1,
		["weapons.nurs.ARAKM70BAPPX"] = 1,
		["weapons.nurs.SNEB_TYPE251_H1"] = 1,
		["weapons.nurs.HYDRA_70_M229"] = 1,
		["weapons.bombs.BLU_4B_GROUP"] = 1,
		["weapons.droptanks.DFT_400_GAL_A4E"] = 1,
		["weapons.missiles.AIM-9J"] = 1,
		["weapons.nurs.ARF8M3API"] = 1,
		["weapons.bombs.EWR SBORKA Air [21624lb]"] = 1,
		["weapons.containers.Otokar_Cobra"] = 1,
		["weapons.bombs.Transport URAL-375 [14815lb]"] = 1,
		["weapons.missiles.CM_802AKG"] = 1,
		["weapons.missiles.X_22"] = 1,
		["weapons.containers.FAS"] = 1,
		["weapons.nurs.S-25-O"] = 1,
		["weapons.droptanks.JAYHAWK_120_Fuel_Dual_Tank"] = 1,
		["weapons.nurs.SNEB_TYPE253_F1B"] = 1,
		["weapons.missiles.R-13M"] = 1,
		["weapons.missiles.X_31P"] = 1,
		["weapons.bombs.RBK_500U"] = 1,
		["weapons.missiles.AIM_54A_Mk47"] = 1,
		["weapons.bombs.GBU_31"] = 1,
		["weapons.missiles.AGM_154B"] = 1,
		["weapons.bombs.HEMTT TFFT [34400lb]"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_Center_Fuel_Tank"] = 1,
		["weapons.nurs.M261_MPSM_Rocket"] = 1,
		["weapons.bombs.BLG66_BELOUGA"] = 1,
		["weapons.containers.F-15E_AAQ-13_LANTIRN"] = 1,
		["weapons.droptanks.800L Tank Empty"] = 1,
		["weapons.containers.PAVETACK"] = 1,
		["weapons.bombs.AN-M81"] = 1,
		["weapons.missiles.AIM_54A_Mk60"] = 1,
		["weapons.droptanks.DFT_300_GAL_A4E"] = 1,
		["weapons.droptanks.DFT_150_GAL_A4E"] = 1,
		["weapons.missiles.AIM_9"] = 1,
		["weapons.bombs.IFV BTR-D Air [18040lb]"] = 1,
		["weapons.bombs.BAT-120"] = 1,
		["weapons.bombs.KAB_1500T"] = 1,
		["weapons.bombs.BR_500"] = 1,
		["weapons.droptanks.PTB_200_F86F35"] = 1,
		["weapons.bombs.SAMP400HD"] = 1,
		["weapons.bombs.Mk_82Y"] = 1,
		["weapons.missiles.AKD-10"] = 1,
		["weapons.missiles.SD-10"] = 1,
		["weapons.bombs.IFV BTR-D Skid [17930lb]"] = 1,
		["weapons.containers.ais-pod-t50_r"] = 1,
		["weapons.bombs.Transport UAZ-469 Air [3747lb]"] = 1,
		["weapons.droptanks.fuel_tank_230"] = 1,
		["weapons.droptanks.M2KC_RPL_522"] = 1,
		["weapons.missiles.AGM_130"] = 1,
		["weapons.missiles.LS_6_500"] = 1,
		["weapons.missiles.X_65"] = 1,
		["weapons.containers.bmp-1"] = 1,
		["weapons.containers.BOZ-100"] = 1,
		["weapons.bombs.British_GP_500LB_Bomb_Mk5"] = 1,
		["weapons.missiles.Kh-66_Grom"] = 1,
		["weapons.bombs.FAB-500M54"] = 1,
		["weapons.containers.U22"] = 1,
		["weapons.bombs.LYSBOMB 11089"] = 1,
		["weapons.bombs.BLU-4B_GROUP"] = 1,
		["weapons.bombs.OH58D_Violet_Smoke_Grenade"] = 1,
		["weapons.containers.ah-64d_radar"] = 1,
		["weapons.nurs.HYDRA_70_M156"] = 1,
		["weapons.containers.F-15E_AXQ-14_DATALINK"] = 1,
		["weapons.bombs.P-50T"] = 1,
		["weapons.bombs.SC_500_L2"] = 1,
		["weapons.bombs.British_MC_250LB_Bomb_Mk1"] = 1,
		["weapons.missiles.Kh25MP_PRGS1VP"] = 1,
		["weapons.bombs.CBU_87"] = 1,
		["weapons.missiles.OH58D_FIM_92"] = 1,
		["weapons.missiles.DWS39_MJ1_MJ2"] = 1,
		["weapons.bombs.AN_M65"] = 1,
		["weapons.nurs.HYDRA_70_M151"] = 1,
		["weapons.bombs.IFV BMP-3 [32912lb]"] = 1,
		["weapons.bombs.APC MTLB Air [26400lb]"] = 1,
		["weapons.bombs.OFAB-100-120TU"] = 1,
		["weapons.containers.uh-60l_copilot"] = 1,
		["weapons.bombs.AN_M57"] = 1,
		["weapons.bombs.GBU_16"] = 1,
		["weapons.droptanks.FPU_8A"] = 1,
		["weapons.containers.aaq-28LEFT litening"] = 1,
		["weapons.nurs.C_8OFP2"] = 1,
		["weapons.containers."] = 1,
		["weapons.containers.F-18-LDT-POD"] = 1,
		["weapons.nurs.SNEB_TYPE254_F1B_RED"] = 1,
		["weapons.bombs.British_MC_500LB_Bomb_Mk1_Short"] = 1,
		["weapons.containers.HB_ALE_40_30_60"] = 1,
		["weapons.missiles.AGM_65K"] = 1,
		["weapons.droptanks.FuelTank_150L"] = 1,
		["weapons.nurs.S5M1_HEFRAG_FFAR"] = 1,
		["weapons.nurs.C_8OM"] = 1,
		["weapons.bombs.SAM ROLAND LN [34720b]"] = 1,
		["weapons.bombs.LS_6_100"] = 1,
		["weapons.bombs.AGM_62"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_WingTank_R"] = 1,
		["weapons.missiles.RB75T"] = 1,
		["weapons.containers.SORBCIJA_R"] = 1,
		["weapons.missiles.R-13M1"] = 1,
		["weapons.bombs.British_GP_250LB_Bomb_Mk1"] = 1,
		["weapons.bombs.AB_500_1_SD_10A"] = 1,
		["weapons.bombs.FAB_50"] = 1,
		["weapons.bombs.Mk_83"] = 1,
		["weapons.missiles.ALARM"] = 1,
		["weapons.containers.KBpod"] = 1,
		["weapons.nurs.HYDRA_70_MK1"] = 1,
		["weapons.bombs.MK_82SNAKEYE"] = 1,
		["weapons.missiles.RB75B"] = 1,
		["weapons.bombs.SC_500_J"] = 1,
		["weapons.containers.{EclairM_51}"] = 1,
		["weapons.bombs.MK77mod1-WPN"] = 1,
		["weapons.droptanks.1100L Tank Empty"] = 1,
		["weapons.containers.HB_ORD_Pave_Spike"] = 1,
		["weapons.bombs.British_GP_500LB_Bomb_Mk1"] = 1,
		["weapons.nurs.SNEB_TYPE259E_F1B"] = 1,
		["weapons.bombs.British_MC_250LB_Bomb_Mk2"] = 1,
		["weapons.bombs.BDU_50HD"] = 1,
		["weapons.bombs.IFV BMP-2 [25168lb]"] = 1,
		["weapons.containers.SORBCIJA_L"] = 1,
		["weapons.missiles.RS2US"] = 1,
		["weapons.droptanks.HB_F-4E_EXT_WingTank"] = 1,
		["weapons.nurs.C_8CM_BU"] = 1,
		["weapons.containers.Hercules_Battle_Station"] = 1,
		["weapons.bombs.AN_M64"] = 1,
		["weapons.containers.rearCargoSeats"] = 1,
		["weapons.bombs.Mk_82"] = 1,
		["weapons.bombs.KAB_500"] = 1,
		["weapons.bombs.BDU_50LGB"] = 1,
		["weapons.containers.{EclairM_42}"] = 1,
		["weapons.missiles.AGM_12C_ED"] = 1,
		["weapons.droptanks.PTB760_MIG19"] = 1,
		["weapons.bombs.GBU_39"] = 1,
		["weapons.nurs.S-5M"] = 1,
		["weapons.containers.{Eclair}"] = 1,
		["weapons.bombs.BDU_45B"] = 1,
		["weapons.bombs.RBK_250"] = 1,
		["weapons.missiles.AGM_12B"] = 1,
		["weapons.nurs.R4M"] = 1,
		["weapons.missiles.AIM-92C"] = 1,
		["weapons.missiles.LD-10"] = 1,
		["weapons.droptanks.F-15E_Drop_Tank_Empty"] = 1,
		["weapons.nurs.HYDRA_70_MK5"] = 1,
		["weapons.bombs.FAB_100M"] = 1,
		["weapons.containers.supply_m134"] = 1,
		["weapons.missiles.HOT3_MBDA"] = 1,
		["weapons.bombs.British_GP_250LB_Bomb_Mk4"] = 1,
		["weapons.nurs.C_8CM_YE"] = 1,
		["weapons.missiles.Rb 04E"] = 1,
		["weapons.nurs.SNEB_TYPE259E_H1"] = 1,
		["weapons.droptanks.PTB300_MIG15"] = 1,
		["weapons.bombs.250-3"] = 1,
		["weapons.missiles.TOW"] = 1,
		["weapons.containers.m-113"] = 1,
		["weapons.containers.MPS-410"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_YELLOW}"] = 1,
		["weapons.bombs.FAB_100"] = 1,
		["weapons.bombs.OH6_SMOKE_YELLOW"] = 1,
		["weapons.droptanks.droptank_110_gal"] = 1,
		["weapons.bombs.LUU_2B"] = 1,
		["weapons.containers.F-18-FLIR-POD"] = 1,
		["weapons.containers.MATRA-PHIMAT"] = 1,
		["weapons.containers.smoke_pod"] = 1,
		["weapons.missiles.AGM_12C"] = 1,
		["weapons.containers.AAQ-28_LITENING"] = 1,
		["weapons.containers.F-15E_AAQ-14_LANTIRN"] = 1,
		["weapons.bombs.BLU_3B_GROUP"] = 1,
		["weapons.missiles.R-60"] = 1,
		["weapons.bombs.BETAB-500M"] = 1,
		["weapons.bombs.GBU_24"] = 1,
		["weapons.nurs.ARAKM70BAP"] = 1,
		["weapons.containers.rightSeat"] = 1,
		["weapons.missiles.MMagicII"] = 1,
		["weapons.containers.HEMTT"] = 1,
		["weapons.nurs.HYDRA_70_M282"] = 1,
		["weapons.missiles.AGM_119"] = 1,
		["weapons.bombs.KAB_1500Kr"] = 1,
		["weapons.droptanks.AV8BNA_AERO1D"] = 1,
		["weapons.missiles.AGM_12A"] = 1,
		["weapons.nurs.ARF8M3HEI"] = 1,
		["weapons.bombs.OH6_SMOKE_BLUE"] = 1,
		["weapons.missiles.MICA_T"] = 1,
		["weapons.containers.uaz-469"] = 1,
		["weapons.nurs.SNEB_TYPE254_F1B_YELLOW"] = 1,
		["weapons.bombs.APC BTR-82A Air [24998lb]"] = 1,
		["weapons.nurs.HYDRA_70_M274"] = 1,
		["weapons.missiles.P_24R"] = 1,
		["weapons.nurs.S-24B"] = 1,
		["weapons.missiles.Igla_1E"] = 1,
		["weapons.droptanks.Spitfire_slipper_tank"] = 1,
		["weapons.nurs.C_24"] = 1,
		["weapons.missiles.MICA_R"] = 1,
		["weapons.missiles.LAU_61_APKWS_M282"] = 1,
		["weapons.bombs.GBU_31_V_2B"] = 1,
		["weapons.bombs.Mk_84"] = 1,
		["weapons.missiles.CATM_65K"] = 1,
		["weapons.droptanks.PTB_1200_F1"] = 1,
		["weapons.nurs.SNEB_TYPE256_H1"] = 1,
		["weapons.bombs.BDU_50LD"] = 1,
		["weapons.containers.pl5eii"] = 1,
		["weapons.bombs.Squad 30 x Soldier [7950lb]"] = 1,
		["weapons.containers.{EclairM_24}"] = 1,
		["weapons.bombs.AN-M88"] = 1,
		["weapons.missiles.X_59M"] = 1,
		["weapons.bombs.OH6_SMOKE_RED"] = 1,
		["weapons.containers.zsu-23-4"] = 1,
		["weapons.missiles.RB75"] = 1,
		["weapons.missiles.Mistral"] = 1,
		["weapons.droptanks.MB339_TT500_L"] = 1,
		["weapons.bombs.SAM SA-13 STRELA [21624lb]"] = 1,
		["weapons.bombs.SAM Avenger M1097 Air [7200lb]"] = 1,
		["weapons.containers.Spear"] = 1,
		["weapons.bombs.RBK_500U_OAB_2_5RT"] = 1,
		["weapons.missiles.S_25L"] = 1,
		["weapons.nurs.British_AP_25LBNo1_3INCHNo1"] = 1,
		["weapons.missiles.Rb 15F (for A.I.)"] = 1,
		["weapons.bombs.GBU_12"] = 1,
		["weapons.containers.{US_M10_SMOKE_TANK_WHITE}"] = 1,
		["weapons.bombs.FAB_500"] = 1,
		["weapons.containers.HVAR_rocket"] = 1,
	}
end

-----------------[[ END OF WarehouseManager.lua ]]-----------------



-----------------[[ DependencyManager.lua ]]-----------------

DependencyManager = {}

do
    DependencyManager.dependencies = {}

    function DependencyManager.register(name, dependency)
        DependencyManager.dependencies[name] = dependency
        env.info("DependencyManager - "..name.." registered")
    end

    function DependencyManager.get(name)
        return DependencyManager.dependencies[name]
    end
end

-----------------[[ END OF DependencyManager.lua ]]-----------------



-----------------[[ Config.lua ]]-----------------

Config = Config or {}
Config.lossCompensation = Config.lossCompensation or 1.1 -- gives advantage to the side with less zones. Set to 0 to disable
Config.randomBoost = Config.randomBoost or 0.0004 -- adds a random factor to build speeds that changes every 30 minutes, set to 0 to disable
Config.buildSpeed = Config.buildSpeed or 10 -- structure and defense build speed
Config.missionBuildSpeedReduction = Config.missionBuildSpeedReduction or 0.12 -- reduction of build speed in case of ai missions
Config.maxDistFromFront = Config.maxDistFromFront or 129640 -- max distance in meters from front after which zone is forced into low activity state (export mode)

if Config.restrictMissionAcceptance == nil then Config.restrictMissionAcceptance = true end -- if set to true, missions can only be accepted while landed inside friendly zones

Config.missions = Config.missions or {}
Config.missionBoardSize = Config.missionBoardSize or 10

Config.carrierSpawnCost = Config.carrierSpawnCost or 1000 -- resource cost for carrier when players take off, set to 0 to disable restriction
Config.zoneSpawnCost = Config.zoneSpawnCost or 1000 -- resource cost for zones when players take off, set to 0 to disable restriction
if Config.disableUnstuck == nil then Config.disableUnstuck = false end
Config.salvageChance = Config.salvageChance or 0.5
if Config.useRadio == nil then Config.useRadio = true end
Config.gciRadioTimeout = Config.gciRadioTimeout or 60
Config.gciMaxCallouts = Config.gciMaxCallouts or 3

if Config.showInventory == nil then Config.showInventory = false end -- set to true to show mission inventory on zones

Config.chillMode = false
if Config.chillMode then
    Config.buildSpeed = 8
    Config.missionBuildSpeedReduction = 0.08
    Config.restrictMissionAcceptance = false
    Config.carrierSpawnCost = 500
    Config.zoneSpawnCost = 500
end

Config.dev = false
if Config.dev then
    Config.showInventory = true
    Config.restrictMissionAcceptance = false
end

-----------------[[ END OF Config.lua ]]-----------------



-----------------[[ Utils.lua ]]-----------------

Utils = {}
do
	local JSON = (loadfile('Scripts/JSON.lua'))()

	function Utils.getPointOnSurface(point)
		return {x = point.x, y = land.getHeight({x = point.x, y = point.z}), z= point.z}
	end
	
	function Utils.getTableSize(tbl)
		local cnt = 0
		for i,v in pairs(tbl) do cnt=cnt+1 end
		return cnt
	end

	function Utils.isInArray(value, array)
		for _,v in ipairs(array) do
			if value == v then
				return true
			end
		end
	end

	Utils.cache = {}
	Utils.cache.groups = {}
	function Utils.getOriginalGroup(groupName)
		if Utils.cache.groups[groupName] then
			return Utils.cache.groups[groupName]
		end

		for _,coalition in pairs(env.mission.coalition) do
			for _,country in pairs(coalition.country) do
				local tocheck = {}
				table.insert(tocheck, country.plane)
				table.insert(tocheck, country.helicopter)
				table.insert(tocheck, country.ship)
				table.insert(tocheck, country.vehicle)
				table.insert(tocheck, country.static)

				for _, checkGroup in ipairs(tocheck) do
					for _,item in pairs(checkGroup.group) do
						Utils.cache.groups[item.name] = item
						if item.name == groupName then
							return item
						end
					end
				end
			end
		end
	end
	
	function Utils.getBearing(fromvec, tovec)
		local fx = fromvec.x
		local fy = fromvec.z
		
		local tx = tovec.x
		local ty = tovec.z
		
		local brg = math.atan2(ty - fy, tx - fx)
		
		
		if brg < 0 then
			 brg = brg + 2 * math.pi
		end
		
		brg = brg * 180 / math.pi
		

		return brg
	end

	function Utils.getHeadingDiff(heading1, heading2) -- heading1 + result == heading2
		local diff = heading1 - heading2
		local absDiff = math.abs(diff)
		local complementaryAngle = 360 - absDiff
	
		if absDiff <= 180 then 
			return -diff
		elseif heading1 > heading2 then
			return complementaryAngle
		else
			return -complementaryAngle
		end
	end
	
	function Utils.getAGL(object)
		local pt = object:getPoint()
		return pt.y - land.getHeight({ x = pt.x, y = pt.z })
	end

	function Utils.round(number)
		return math.floor(number+0.5)
	end
	
	function Utils.isLanded(unit, ignorespeed)
		--return (Utils.getAGL(unit)<5 and mist.vec.mag(unit:getVelocity())<0.10)
		
		if ignorespeed then
			return not unit:inAir()
		else
			return (not unit:inAir() and mist.vec.mag(unit:getVelocity())<1)
		end
	end

	function Utils.getEnemy(ofside)
		if ofside == 1 then return 2 end
		if ofside == 2 then return 1 end
	end
	
	function Utils.isGroupActive(group)
		if group and group:getSize()>0 and group:getController():hasTask() then 
			return not Utils.allGroupIsLanded(group, true)
		else
			return false
		end
	end
	
	function Utils.isInAir(unit)
		--return Utils.getAGL(unit)>5
		return unit:inAir()
	end
	
	function Utils.isInZone(unit, zonename)
		local zn = CustomZone:getByName(zonename)
		if zn then
			return zn:isInside(unit:getPosition().p)
		end
		
		return false
	end

	function Utils.isInCircle(point, center, radius)
		local dist = mist.utils.get2DDist(point, center)
		return dist<radius
	end
	
	function Utils.isCrateSettledInZone(crate, zonename)
		local zn = CustomZone:getByName(zonename)
		if zn and crate then
			return (zn:isInside(crate:getPosition().p) and Utils.getAGL(crate)<1)
		end
		
		return false
	end
	
	function Utils.someOfGroupInZone(group, zonename)
		for i,v in pairs(group:getUnits()) do
			if Utils.isInZone(v, zonename) then
				return true
			end
		end
		
		return false
	end
	
	function Utils.allGroupIsLanded(group, ignorespeed)
		for i,v in pairs(group:getUnits()) do
			if not Utils.isLanded(v, ignorespeed) then
				return false
			end
		end
		
		return true
	end
	
	function Utils.someOfGroupInAir(group)
		for i,v in pairs(group:getUnits()) do
			if Utils.isInAir(v) then
				return true
			end
		end
		
		return false
	end
	
	Utils.canAccessFS = true
	function Utils.saveTable(filename, data)
		if not Utils.canAccessFS then 
			return
		end
		
		if not io then
			Utils.canAccessFS = false
			trigger.action.outText('Persistance disabled', 30)
			return
		end
	
		local str = JSON:encode(data)
		-- local str = 'return (function() local tbl = {}'
		-- for i,v in pairs(data) do
		-- 	str = str..'\ntbl[\''..i..'\'] = '..Utils.serializeValue(v)
		-- end
		
		-- str = str..'\nreturn tbl end)()'
	
		local File = io.open(filename, "w")
		File:write(str)
		File:close()
	end
	
	function Utils.serializeValue(value)
		local res = ''
		if type(value)=='number' or type(value)=='boolean' then
			res = res..tostring(value)
		elseif type(value)=='string' then
			res = res..'\''..value..'\''
		elseif type(value)=='table' then
			res = res..'{ '
			for i,v in pairs(value) do
				if type(i)=='number' then
					res = res..'['..i..']='..Utils.serializeValue(v)..','
				else
					res = res..'[\''..i..'\']='..Utils.serializeValue(v)..','
				end
			end
			res = res:sub(1,-2)
			res = res..' }'
		end
		return res
	end
	
	function Utils.loadTable(filename)
		if not Utils.canAccessFS then 
			return
		end
		
		if not lfs then
			Utils.canAccessFS = false
			trigger.action.outText('Persistance disabled', 30)
			return
		end
		
		if lfs.attributes(filename) then
			local File = io.open(filename, "r")
			local str = File:read('*all')
			File:close()

			return JSON:decode(str)
		end
	end
	
	function Utils.toLocalVector(origin, target)
		return {
			x = target.x - origin.x,
			y = target.y - origin.y
		}
	end

	function Utils.rotateVector(vec, angles)
		local rad = math.rad(angles)
		return {
			x = vec.x*math.cos(rad) + vec.y*math.sin(rad),
			y = vec.y*math.cos(rad) - vec.x*math.sin(rad)
		}
	end
	
	function Utils.merge(table1, table2)
		local result = {}
		for i,v in pairs(table1) do
			result[i] = v
		end
		
		for i,v in pairs(table2) do
			result[i] = v
		end
		
		return result
	end

	function Utils.log(func)
		return function(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
			local err, msg = pcall(func,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
			if not err then
				env.info("ERROR - callFunc\n"..msg)
				env.info('Traceback\n'..debug.traceback())
			end
		end
	end

	function Utils.getAmmo(group, type)
		local count = 0
		for _, u in ipairs(group:getUnits()) do
			if u:isExist() then
				local ammo = u:getAmmo()
				for i,v in pairs(ammo) do
					if v.desc.typeName == type then
						count = count + v.count
					end
				end
			end
		end

		return count
	end

	function Utils.getAmmoCount(group)
		local count = 0
		for _, u in ipairs(group:getUnits()) do
			if u:isExist() then
				local ammo = u:getAmmo()
				if ammo then
					for i,v in pairs(ammo) do
						count = count + v.count
					end
				end
			end
		end
		
		return count
	end
end



-----------------[[ END OF Utils.lua ]]-----------------



-----------------[[ MenuRegistry.lua ]]-----------------

MenuRegistry = {}

do
    MenuRegistry.triggers = {}
    MenuRegistry.unitTriggers = {}

    MenuRegistry.menus = {}
    function MenuRegistry.register(order, registerfunction, context)
        for i=1,order,1 do
            if not MenuRegistry.menus[i] then MenuRegistry.menus[i] = {func = function() end, context = {}} end
        end

        MenuRegistry.menus[order] = {func = registerfunction, context = context}
    end

    local ev = {}
    function ev:onEvent(event)
        MenuRegistry.handleEvent(event)
    end
    
    world.addEventHandler(ev)

    function MenuRegistry.handleEvent(event)
        if event.initiator and event.initiator.isExist and event.initiator:isExist() and event.initiator.getPlayerName and event.initiator:getPlayerName() then
            env.info('MenuRegistry - playerevent type='..event.id)
        end

        if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or
            event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.isExist and event.initiator:isExist() and event.initiator.getPlayerName then

            local player = event.initiator:getPlayerName()
            if player then
                local lastTrigger = MenuRegistry.triggers[player]
                env.info('MenuRegistry - last trigger time '..tostring(lastTrigger)..' type='..event.id)
                if not lastTrigger or (timer.getTime() - lastTrigger) > 1 then
                    MenuRegistry.triggers[player] = timer.getTime()
                    env.info('MenuRegistry - creating menus for player: '..player)
                    for i,v in ipairs(MenuRegistry.menus) do
                        local err, msg = pcall(v.func, event, v.context)
                        if not err then
                            env.info("MenuRegistry - ERROR :\n"..msg)
                            env.info('Traceback\n'..debug.traceback())
                        end
                    end
                end
            end
        end
    end

    function MenuRegistry.triggerMenusForUnit(unit)
        if unit:isExist() then
            if unit.getPlayerName and unit:getPlayerName() then
                local tr = MenuRegistry.unitTriggers[unit:getID()]
                if not tr then
                    local event = {
                        initiator = unit,
                        id = world.event.S_EVENT_PLAYER_ENTER_UNIT,
                    }
    
                    MenuRegistry.handleEvent(event)
                    MenuRegistry.unitTriggers[unit:getID()] = true
                end
            else
                local tr = MenuRegistry.unitTriggers[unit:getID()]
                if tr then
                    MenuRegistry.unitTriggers[unit:getID()] = false
                end
            end
        end
    end

    function MenuRegistry.showTargetZoneMenu(groupid, name, action, targetside, minDistToFront, data, includeCarriers, onlyRevealed,includeFarps, excludeZones)
		local zones = ZoneCommand.getAllZones()

        if targetside and type(targetside) == 'number' then
            targetside = { targetside }
        end

        local zns = {}
        if not excludeZones then
            for i,v in pairs(zones) do
                if not targetside or Utils.isInArray(v.side,targetside) then 
                    if not minDistToFront or v.distToFront <= minDistToFront then
                        if not onlyRevealed or v.revealTime>0 then
                            table.insert(zns, v)
                        end
                    end
                end
            end
        end

        if includeCarriers then
            for i,v in pairs(CarrierCommand.getAllCarriers()) do
                if not targetside or Utils.isInArray(v.side,targetside) then 
                    table.insert(zns, v)
                end
            end
        end

        if includeFarps then
            for i,v in pairs(FARPCommand.getAllFARPs()) do
                if not targetside or Utils.isInArray(v.side,targetside) then 
                    table.insert(zns, v)
                end
            end
        end

        if #zns == 0 then return false end

        table.sort(zns, function(a,b) return a.name < b.name end)

        local executeAction = function(act, params)
			local err = act(params)
			if not err then
				missionCommands.removeItemForGroup(params.groupid, params.menu)
			end
		end

		local menu = missionCommands.addSubMenuForGroup(groupid, name)
		local sub1 = nil

		local count = 0
		for i,v in ipairs(zns) do
            count = count + 1
            if count<10 then
                missionCommands.addCommandForGroup(groupid, v.name, menu, executeAction, action, {zone = v, menu=menu, groupid=groupid, data=data})
            elseif count==10 then
                sub1 = missionCommands.addSubMenuForGroup(groupid, "More", menu)
                missionCommands.addCommandForGroup(groupid, v.name, sub1, executeAction, action, {zone = v, menu=menu, groupid=groupid, data=data})
            elseif count%9==1 then
                sub1 = missionCommands.addSubMenuForGroup(groupid, "More", sub1)
                missionCommands.addCommandForGroup(groupid, v.name, sub1, executeAction, action, {zone = v, menu=menu, groupid=groupid, data=data})
            else
                missionCommands.addCommandForGroup(groupid, v.name, sub1, executeAction, action, {zone = v, menu=menu, groupid=groupid, data=data})
            end
		end
		
		return menu
    end
end

-----------------[[ END OF MenuRegistry.lua ]]-----------------



-----------------[[ CustomZone.lua ]]-----------------


CustomZone = {}
do
	function CustomZone:getByName(name)
		local obj = {}
		obj.name = name
		
		local zd = nil
		for _,v in ipairs(env.mission.triggers.zones) do
			if v.name == name then
				zd = v
				break
			end
		end
		
		if not zd then
			return nil
		end
		
		obj.type = zd.type -- 2 == quad, 0 == circle
		if obj.type == 2 then
			obj.vertices = {}
			for _,v in ipairs(zd.verticies) do
				local vertex = {
					x = v.x,
					y = 0,
					z = v.y
				}
				table.insert(obj.vertices, vertex)
			end
		end
		
		obj.radius = zd.radius
		obj.point = {
			x = zd.x,
			y = 0,
			z = zd.y
		}
		
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	function CustomZone:isQuad()
		return self.type==2
	end
	
	function CustomZone:isCircle()
		return self.type==0
	end
	
	function CustomZone:isInside(point)
		if self:isCircle() then
			local dist = mist.utils.get2DDist(point, self.point)
			return dist<self.radius
		elseif self:isQuad() then
			return mist.pointInPolygon(point, self.vertices)
		end
	end
	
	function CustomZone:draw(id, border, background)
		if self:isCircle() then
			trigger.action.circleToAll(-1,id,self.point, self.radius,border,background,1)
		elseif self:isQuad() then
			trigger.action.quadToAll(-1,id,self.vertices[4], self.vertices[3], self.vertices[2], self.vertices[1],border,background,1)
		end
	end
	
	function CustomZone:getRandomSpawnZone()
		local spawnZones = {}
		for i=1,100,1 do
			local zname = self.name..'-'..i
			if trigger.misc.getZone(zname) then
				table.insert(spawnZones, zname)
			else
				break
			end
		end
		
		if #spawnZones == 0 then return nil end
		
		local choice = math.random(1, #spawnZones)
		return spawnZones[choice]
	end
	
	function CustomZone:spawnGroup(product, acceptedSurface)
		local spname = self.name
		local spawnzone = nil
		
		if not spawnzone then
			spawnzone = self:getRandomSpawnZone()
		end
		
		if spawnzone then
			spname = spawnzone
		end

		if not acceptedSurface then
			acceptedSurface = {
				[land.SurfaceType.LAND] = true
			}
		end
		
		local pnt = mist.getRandomPointInZone(spname)
		for i=1,500,1 do
			if acceptedSurface[land.getSurfaceType(pnt)] then
				break
			end

			pnt = mist.getRandomPointInZone(spname)
		end

		local template = product.template
		if product.templates then
			template = product.templates[math.random(1, #product.templates)]
		end

		local newgr = Spawner.createObject(product.name, template, pnt, product.side, nil, nil, acceptedSurface, spname)

		return newgr
	end
end






-----------------[[ END OF CustomZone.lua ]]-----------------



-----------------[[ PlayerLogistics.lua ]]-----------------

PlayerLogistics = {}
do
	PlayerLogistics.allowedTypes = {}
	PlayerLogistics.allowedTypes['Mi-24P'] = { supplies = true, sling = true, personCapacity = 8, boxCapacity=2 }
	PlayerLogistics.allowedTypes['Mi-8MT'] = { supplies = true, sling = true, personCapacity = 24, boxCapacity=4 }
	PlayerLogistics.allowedTypes['UH-1H'] = { supplies = true, sling = true, personCapacity = 12, boxCapacity=1}
	PlayerLogistics.allowedTypes['Hercules'] = { supplies = true, sling = false, personCapacity = 92, boxCapacity=20 }
	PlayerLogistics.allowedTypes['UH-60L'] = { supplies = true, sling = true, personCapacity = 12, boxCapacity=2}
	PlayerLogistics.allowedTypes['Ka-50'] = { supplies = false, sling = false}
	PlayerLogistics.allowedTypes['Ka-50_3'] = { supplies = false, sling = false}
	PlayerLogistics.allowedTypes['SA342L'] = { supplies = true, sling = false, personCapacity = 1}
	PlayerLogistics.allowedTypes['SA342M'] = { supplies = true, sling = false, personCapacity = 1}
	PlayerLogistics.allowedTypes['SA342Minigun'] = { supplies = true, sling = false, personCapacity = 1}
	PlayerLogistics.allowedTypes['OH-6A'] = { supplies = true, sling = true, personCapacity = 4, boxCapacity=1}
	PlayerLogistics.allowedTypes['AH-64D_BLK_II'] = { supplies = false, sling = false}
	PlayerLogistics.allowedTypes['OH58D'] = { supplies = false, sling = false}
	PlayerLogistics.allowedTypes['CH-47Fbl1'] = { supplies = true, sling = true, personCapacity = 33}

	PlayerLogistics.allowedTypes['M 818'] = 				{ isCA = true, supplies = false, sling=true, personCapacity = 12, boxCapacity=4}
	PlayerLogistics.allowedTypes['M-2 Bradley'] = 			{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}
	PlayerLogistics.allowedTypes['M6 Linebacker'] = 		{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}
	PlayerLogistics.allowedTypes['M-113'] = 				{ isCA = true, supplies = false, sling=true, personCapacity = 12, boxCapacity=1}
	PlayerLogistics.allowedTypes['MaxxPro_MRAP'] = 			{ isCA = true, supplies = false, sling=true, personCapacity = 10, boxCapacity=1}
	PlayerLogistics.allowedTypes['M1043 HMMWV Armament'] = 	{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}
	PlayerLogistics.allowedTypes['M1045 HMMWV TOW'] = 		{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}
	PlayerLogistics.allowedTypes['Land_Rover_101_FC'] = 	{ isCA = true, supplies = false, sling=true, personCapacity = 4, boxCapacity=2}
	PlayerLogistics.allowedTypes['Marder'] = 				{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}
	PlayerLogistics.allowedTypes['MCV-80'] = 				{ isCA = true, supplies = false, sling=true, personCapacity = 7, boxCapacity=2}
	PlayerLogistics.allowedTypes['VAB_Mephisto'] = 			{ isCA = true, supplies = false, sling=true, personCapacity = 6, boxCapacity=1}

	PlayerLogistics.groundVehicles = {
		['truck'] = 	{ price =  100, template='player-truck',  		label='truck', isCW = true },
		['truck2'] = 	{ price =  50, 	template='player-truck-small',  label='truck', isCW = true },
		['hmv'] = 		{ price = 300, 	template='player-hm',  			label='sup', 	isCW = true   },
		['hmvat'] = 	{ price = 350, 	template='player-hmat',  		label='sup'  },
		['m113'] = 		{ price = 400, template='player-m113',  		label='apc', 	isCW = true   },
		['mrap'] = 		{ price = 600, template='player-mrap',  		label='apc'   },
		['marder'] = 	{ price = 800, template='player-marder', 		label='apc', 	isCW = true  },
		['warrior'] = 	{ price = 1500, template='player-warrior', 		label='ifv', 	isCW = true  },
		['brad'] = 		{ price = 2500, template='player-brad',  		label='ifv'	  },
		['mephisto'] = 	{ price = 2500, template='player-mephisto', 	label='apc',  },
		['hmvaa'] = 	{ price = 2500, template='player-hmaa',  		label='sam'   },
		['bradaa'] = 	{ price = 2700, template='player-bradaa',  		label='ifv'   },
		['gepard'] =	{ price = 3500, template='player-gepard',  		label='aaa', 	isCW = true   },
		['roland'] = 	{ price = 5000, template='player-roland', 		label='sam',  },
		['arty'] = 		{ price = 1500, template='player-arty', 		label='arty', 	isCW = true  },
		['mlrs'] = 		{ price = 3000, template='player-mlrs', 		label='arty'  },
		['abrams'] = 	{ price = 5000, template='player-abrams', 		label='tank'  },
		['patton'] = 	{ price = 4000, template='player-m60', 			label='tank', 	isCW = true  },
	}

	PlayerLogistics.startingMP = 10800

	PlayerLogistics.hercVehicles = {
		['weapons.bombs.APC M1043 HMMWV Armament Air [7023lb]'] = 	{ tag='hmv', hasChute=true},
		['weapons.bombs.APC M113 Air [21624lb]'] = 					{ tag='m113', hasChute=true},
		['weapons.bombs.SAM Avenger M1097 Air [7200lb]'] = 			{ tag='hmvaa', hasChute=true},
		['weapons.bombs.APC M1043 HMMWV Armament Skid [6912lb]'] =  { tag='hmv', hasChute=false},
		['weapons.bombs.APC M113 Skid [21494lb]'] = 				{ tag='m113', hasChute=false},
		['weapons.bombs.SAM Avenger M1097 Skid [7090lb]'] = 		{ tag='hmvaa', hasChute=false},
		['weapons.bombs.IFV M2A2 Bradley [34720lb]'] = 				{ tag='brad', hasChute=false},
		['weapons.bombs.Transport M818 [16000lb]'] = 				{ tag='truck', hasChute=false},
		['weapons.bombs.SAM LINEBACKER [34720lb]'] = 				{ tag='bradaa', hasChute=false},
		['weapons.bombs.IFV MARDER [34720lb]'] = 					{ tag='marder', hasChute=false},
		['weapons.bombs.IFV MCV-80 [34720lb]'] = 					{ tag='warrior', hasChute=false},
		['weapons.bombs.SAM ROLAND LN [34720lb]'] = 				{ tag='roland', hasChute=false},
		['weapons.bombs.ATGM M1045 HMMWV TOW Skid [7073lb]'] = 		{ tag='hmvat', hasChute=false},
		['weapons.bombs.ATGM M1045 HMMWV TOW Air [7189lb]'] = 		{ tag='hmvat', hasChute=true},
	}

	PlayerLogistics.infantryTypes = {
		capture = 'capture',
		sabotage = 'sabotage',
		ambush = 'ambush',
		engineer = 'engineer',
		manpads = 'manpads',
		spy = 'spy',
		rapier = 'rapier',
		assault = 'assault',
		extractable = 'extractable'
	}

	PlayerLogistics.buildables = {
		farp = 'farp-pad',
		fuel = 'fuel-barrels',
		ammo = 'ammo-boxes',
		medtent = 'tent_2',
		tent = 'tent_1',
		generator = 'hesco_gen',
		radar = 'hawksr',
		satuplink = 'hawkpcp',
		forklift = 'forklift'
	}

	function PlayerLogistics.getInfantryName(infType)
		if infType==PlayerLogistics.infantryTypes.capture then
			return "Capture Squad"
		elseif infType==PlayerLogistics.infantryTypes.sabotage then
			return "Sabotage Squad"
		elseif infType==PlayerLogistics.infantryTypes.ambush then
			return "Ambush Squad"
		elseif infType==PlayerLogistics.infantryTypes.engineer then
			return "Engineer"
		elseif infType==PlayerLogistics.infantryTypes.manpads then
			return "MANPADS"
		elseif infType==PlayerLogistics.infantryTypes.spy then
			return "Spy"
		elseif infType==PlayerLogistics.infantryTypes.rapier then
			return "Rapier SAM"
		elseif infType==PlayerLogistics.infantryTypes.assault then
			return "Assault Squad"
		elseif infType==PlayerLogistics.infantryTypes.extractable then
			return "Extracted infantry"
		end

		return "INVALID SQUAD"
	end
	
	function PlayerLogistics:new()
		local obj = {}
		obj.groupMenus = {} -- groupid = path
		obj.carriedCargo = {} -- groupid = source
		obj.carriedInfantry = {} -- groupid = source
		obj.carriedPilots = {} --groupid = source
		obj.carriedBoxes = {} -- groupid = source
		obj.registeredSquadGroups = {}
		obj.lastLoaded = {} -- groupid = zonename

		obj.trackedPlayerVehicles = {}

		obj.hercTracker = {
			cargos = {},
			cargoCheckFunctions = {}
		}

		obj.hercPreparedDrops = {}

		obj.trackedBoxes = {}
		obj.trackedBuildings = {}

		obj.humanResource = {
			max = 15,
			current = 10,
			progress = 0,
			spawncost = 60*30
		}
		
		setmetatable(obj, self)
		self.__index = self
		
		obj:start()
		
		DependencyManager.register("PlayerLogistics", obj)
		return obj
	end

	function PlayerLogistics:restorePlayerVehicles(savedVehicles)
		for i,v in pairs(savedVehicles) do
		
			local result = Spawner.createPlayerVehicle(v.template.template, v.name, v.pos, v.side)
			if result then
				self.trackedPlayerVehicles[v.name] = { name = v.name, template = v.template, side = v.side, mp = v.mp}

				if v.carry.carriedInfantry then
					for i,v in ipairs(v.carry.carriedInfantry) do
						if v.loadedAt then
							local zn = ZoneCommand.getZoneByName(v.loadedAt)
							if not zn then
								zn = FARPCommand.getFARPByName(v.loadedAt)
							end

							if not zn then
								zn = CarrierCommand.getCarrierByName(v.loadedAt)
							end

							v.loadedAt = zn
						end
					end
				end

				timer.scheduleFunction(function(param,time)
					local g = Group.getByName(param.data.name)
					if g then
						param.context.carriedCargo[g:getID()] = param.data.carry.carriedCargo
						param.context.carriedInfantry[g:getID()]  = param.data.carry.carriedInfantry
						param.context.carriedPilots[g:getID()]  = param.data.carry.carriedPilots
						param.context.carriedBoxes[g:getID()]  = param.data.carry.carriedBoxes
					end
				end, {context = self, data = v}, timer.getTime()+1)
			end
		end
	end

	function PlayerLogistics:registerSquadGroup(squadType, groupname, weight, cost, jobtime, extracttime, squadSize, side)
		self.registeredSquadGroups[squadType] = { name=groupname, type=squadType, weight=weight, cost=cost, jobtime=jobtime, extracttime=extracttime, size = squadSize, side=side}
	end
	
	function PlayerLogistics:start()
		if not ZoneCommand then return end
	
        MenuRegistry.register(3, function(event, context)
			if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player then
					local unitType = event.initiator:getDesc()['typeName']
					local groupid = event.initiator:getGroup():getID()
					local groupname = event.initiator:getGroup():getName()
					
					local logistics = context.allowedTypes[unitType]
					
					if logistics and (logistics.supplies or logistics.sling or logistics.personCapacity) then
						if context.groupMenus[groupid] then
							missionCommands.removeItemForGroup(groupid, context.groupMenus[groupid])
							context.groupMenus[groupid] = nil
						end

						if not context.groupMenus[groupid] then
							local size = event.initiator:getGroup():getSize()
							if size > 1 then
								trigger.action.outText('WARNING: group '..groupname..' has '..size..' units. Logistics will only function for group leader', 10)
							end
							
							local cargomenu = missionCommands.addSubMenuForGroup(groupid, 'Logistics')
							if logistics.supplies then
								local supplyMenu = missionCommands.addSubMenuForGroup(groupid, 'Supplies', cargomenu)
								
								local loadMenu = missionCommands.addSubMenuForGroup(groupid, 'Load', supplyMenu)
								missionCommands.addCommandForGroup(groupid, 'Load 100 supplies', loadMenu, Utils.log(context.loadSupplies), context, {group=groupname, amount=100})
								missionCommands.addCommandForGroup(groupid, 'Load 500 supplies', loadMenu, Utils.log(context.loadSupplies), context, {group=groupname, amount=500})
								missionCommands.addCommandForGroup(groupid, 'Load 1000 supplies', loadMenu, Utils.log(context.loadSupplies), context, {group=groupname, amount=1000})
								missionCommands.addCommandForGroup(groupid, 'Load 2000 supplies', loadMenu, Utils.log(context.loadSupplies), context, {group=groupname, amount=2000})
								missionCommands.addCommandForGroup(groupid, 'Load 5000 supplies', loadMenu, Utils.log(context.loadSupplies), context, {group=groupname, amount=5000})

								local unloadMenu = missionCommands.addSubMenuForGroup(groupid, 'Unload', supplyMenu)
								missionCommands.addCommandForGroup(groupid, 'Unload 100 supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=100})
								missionCommands.addCommandForGroup(groupid, 'Unload 500 supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=500})
								missionCommands.addCommandForGroup(groupid, 'Unload 1000 supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=1000})
								missionCommands.addCommandForGroup(groupid, 'Unload 2000 supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=2000})
								missionCommands.addCommandForGroup(groupid, 'Unload 5000 supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=5000})
								missionCommands.addCommandForGroup(groupid, 'Unload all supplies', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=9999999})
								missionCommands.addCommandForGroup(groupid, 'Unload as fuel (1:1)', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=1000, convert='fuel'})
								missionCommands.addCommandForGroup(groupid, 'Unload as munitions (50:1)', unloadMenu, Utils.log(context.unloadSupplies), context, {group=groupname, amount=1000, convert='ammo'})
							end

							if logistics.sling or logistics.boxCapacity then
								local crateMenu = missionCommands.addSubMenuForGroup(groupid, 'Crates', cargomenu)


								local supMenu = missionCommands.addSubMenuForGroup(groupid, 'Supply', crateMenu)
								missionCommands.addCommandForGroup(groupid, 'Supply Crate (500)', supMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=500})
								missionCommands.addCommandForGroup(groupid, 'Supply Crate (1000)', supMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000})
								missionCommands.addCommandForGroup(groupid, 'Supply Crate (2000)', supMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=2000})
								missionCommands.addCommandForGroup(groupid, 'Fuel Crate (1000)', supMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000, convert='fuel'})
								missionCommands.addCommandForGroup(groupid, 'Munitions Crate (1000)', supMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000, convert='ammo'})
								
								local farpMenu = missionCommands.addSubMenuForGroup(groupid, 'FARP', crateMenu)
								missionCommands.addCommandForGroup(groupid, 'Landing pad (2000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=2000, content=PlayerLogistics.buildables.farp})
								missionCommands.addCommandForGroup(groupid, 'Radar (2000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=2000, content=PlayerLogistics.buildables.radar})
								missionCommands.addCommandForGroup(groupid, 'Ammo Cache (500)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=500, content=PlayerLogistics.buildables.ammo})
								missionCommands.addCommandForGroup(groupid, 'Fuel Cache (500)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=500, content=PlayerLogistics.buildables.fuel})
								missionCommands.addCommandForGroup(groupid, 'Field hospital (1000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000, content=PlayerLogistics.buildables.medtent})
								missionCommands.addCommandForGroup(groupid, 'Command center (1500)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1500, content=PlayerLogistics.buildables.tent})
								missionCommands.addCommandForGroup(groupid, 'Generator (2000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=2000, content=PlayerLogistics.buildables.generator})
								missionCommands.addCommandForGroup(groupid, 'Satellite Uplink (1000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000, content=PlayerLogistics.buildables.satuplink})
								missionCommands.addCommandForGroup(groupid, 'Fork Lift (1000)', farpMenu, Utils.log(context.packSupplies), context, {group=groupname, amount=1000, content=PlayerLogistics.buildables.forklift})
								
								missionCommands.addCommandForGroup(groupid, 'Unpack Crate', crateMenu, Utils.log(context.unpackSupplies), context, {group=groupname})
								
								missionCommands.addCommandForGroup(groupid, 'Load Crate', crateMenu, Utils.log(context.loadClosestCrate), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Unload Crate', crateMenu, Utils.log(context.unloadCrates), context, groupname)
								if not logistics.isCA then
									missionCommands.addCommandForGroup(groupid, 'Pickup guidance(closest)', crateMenu, Utils.log(context.startSlingGuidance), context, groupname)
								end
							end

							local sqs = {}
							for sqType,_ in pairs(context.registeredSquadGroups) do
								table.insert(sqs,sqType)
							end
							table.sort(sqs)

							if logistics.personCapacity then
								local infMenu = missionCommands.addSubMenuForGroup(groupid, 'Infantry', cargomenu)
								
								local loadInfMenu = missionCommands.addSubMenuForGroup(groupid, 'Load', infMenu)
								for _,sqType in ipairs(sqs) do
									local menuName =  'Load '..PlayerLogistics.getInfantryName(sqType)..'('..context.registeredSquadGroups[sqType].size..')'
									missionCommands.addCommandForGroup(groupid, menuName, loadInfMenu, Utils.log(context.loadInfantry), context, {group=groupname, type=sqType})
								end

								local unloadInfMenu = missionCommands.addSubMenuForGroup(groupid, 'Unload', infMenu)
								for _,sqType in ipairs(sqs) do
									local menuName =  'Unload '..PlayerLogistics.getInfantryName(sqType)
									missionCommands.addCommandForGroup(groupid, menuName, unloadInfMenu, Utils.log(context.unloadInfantry), context, {group=groupname, type=sqType})
								end
								missionCommands.addCommandForGroup(groupid, 'Unload Extracted squad', unloadInfMenu, Utils.log(context.unloadInfantry), context, {group=groupname, type=PlayerLogistics.infantryTypes.extractable})

								missionCommands.addCommandForGroup(groupid, 'Extract squad', infMenu, Utils.log(context.extractSquad), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Unload all', infMenu, Utils.log(context.unloadInfantry), context, {group=groupname})

								local csarMenu = missionCommands.addSubMenuForGroup(groupid, 'CSAR', cargomenu)
								missionCommands.addCommandForGroup(groupid, 'Show info (closest)', csarMenu, Utils.log(context.showPilot), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Smoke marker (closest)', csarMenu, Utils.log(context.smokePilot), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Flare (closest)', csarMenu, Utils.log(context.flarePilot), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Extract pilot', csarMenu, Utils.log(context.extractPilot), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Unload pilots', csarMenu, Utils.log(context.unloadPilots), context, groupname)
							end

							if logistics.personCapacity or logistics.supplies then
								missionCommands.addCommandForGroup(groupid, 'Status', cargomenu, Utils.log(context.cargoStatus), context, groupname)
								missionCommands.addCommandForGroup(groupid, 'Unload Everything', cargomenu, Utils.log(context.unloadAll), context, groupname)
							end
							
							if unitType == 'Hercules' then
								local loadmasterMenu = missionCommands.addSubMenuForGroup(groupid, 'Loadmaster', cargomenu)

								for _,sqType in ipairs(sqs) do
									local menuName =  'Prepare '..PlayerLogistics.getInfantryName(sqType)
									missionCommands.addCommandForGroup(groupid, menuName, loadmasterMenu, Utils.log(context.hercPrepareDrop), context, {group=groupname, type=sqType})
								end

								missionCommands.addCommandForGroup(groupid, 'Prepare Supplies', loadmasterMenu, Utils.log(context.hercPrepareDrop), context, {group=groupname, type='supplies'})
							end
							
							context.groupMenus[groupid] = cargomenu
						end
						
						if not logistics.isCA then
							if context.carriedCargo[groupid] then
								context.carriedCargo[groupid] = 0
							end
							
							if context.carriedBoxes[groupid] then
								context.carriedBoxes[groupid] = {}
							end

							if context.carriedInfantry[groupid] then
								context.carriedInfantry[groupid] = {}
							end

							if context.carriedPilots[groupid] then
								context.carriedPilots[groupid] = {}
							end
							
							if context.lastLoaded[groupid] then
								context.lastLoaded[groupid] = nil
							end
						end
							
						if context.hercPreparedDrops[groupid] then
							context.hercPreparedDrops[groupid] = nil
						end
					end
				end
            end
		end, self)

		local ev = {}
		ev.context = self
		function ev:onEvent(event)
			if event.id == world.event.S_EVENT_SHOT and event.initiator and event.initiator:isExist() then
				local unitName = event.initiator:getName()
				local groupId = event.initiator:getGroup():getID()
				local name = event.weapon:getDesc().typeName
				if name == 'weapons.bombs.Generic Crate [20000lb]' then
					local prepared = self.context.hercPreparedDrops[groupId]

					if not prepared then
						prepared = 'supplies'
								
						if self.context.carriedInfantry[groupId] then
							for _,v in ipairs(self.context.carriedInfantry[groupId]) do
								if v.type ~= PlayerLogistics.infantryTypes.extractable then
									prepared = v.type
									break
								end
							end
						end

						env.info('PlayerLogistics - Hercules - auto preparing '..prepared)
					end

					if prepared then
						if prepared == 'supplies' then
							env.info('PlayerLogistics - Hercules - supplies getting dropped')
							local carried = self.context.carriedCargo[groupId]
							local amount = 0
							if carried and carried > 0 then
								amount = 9000
								if carried < amount then
									amount = carried
								end
							end
							
							if amount > 0 then
								self.context.carriedCargo[groupId] = math.max(0,self.context.carriedCargo[groupId] - amount)
								if not self.context.hercTracker.cargos[unitName] then
									self.context.hercTracker.cargos[unitName] = {}
								end
								
								table.insert(self.context.hercTracker.cargos[unitName],{
									object = event.weapon,
									supply = amount,
									lastLoaded = self.context.lastLoaded[groupId],
									unit = event.initiator
								})
								
								env.info('PlayerLogistics - Hercules - '..unitName..' deployed crate with '..amount..' supplies')
								self.context:processHercCargos(unitName)
								self.context.hercPreparedDrops[groupId] = nil
								trigger.action.outTextForUnit(event.initiator:getID(), 'Crate with '..amount..' supplies deployed', 10)
							else
								trigger.action.outTextForUnit(event.initiator:getID(), 'Empty crate deployed', 10)
							end
						else
							env.info('PlayerLogistics - Hercules - searching for prepared infantry')
							local toDrop = nil
							local remaining = {}
							if self.context.carriedInfantry[groupId] then
								for _,v in ipairs(self.context.carriedInfantry[groupId]) do
									if v.type == prepared and toDrop == nil then
										toDrop = v
									else
										table.insert(remaining, v)
									end
								end
							end
							
							
							if toDrop then
								env.info('PlayerLogistics - Hercules - dropping '..toDrop.type)
								if not self.context.hercTracker.cargos[unitName] then
									self.context.hercTracker.cargos[unitName] = {}
								end
								
								table.insert(self.context.hercTracker.cargos[unitName],{
									object = event.weapon,
									squad = toDrop,
									lastLoaded = self.context.lastLoaded[groupId],
									unit = event.initiator
								})
								
								env.info('PlayerLogistics - Hercules - '..unitName..' deployed crate with '..toDrop.type)
								self.context:processHercCargos(unitName)
								self.context.hercPreparedDrops[groupId] = nil
								
								local squadName = PlayerLogistics.getInfantryName(prepared)
								trigger.action.outTextForUnit(event.initiator:getID(), squadName..' crate deployed.', 10)
								self.context.carriedInfantry[groupId] = remaining
								local weight = self.context:getCarriedPersonWeight(event.initiator:getGroup():getName())
								trigger.action.setUnitInternalCargo(event.initiator:getName(), weight)
							else
								trigger.action.outTextForUnit(event.initiator:getID(), 'Empty crate deployed', 10)
							end
						end
					else
						trigger.action.outTextForUnit(event.initiator:getID(), 'Empty crate deployed', 10)
					end
				end

				if PlayerLogistics.hercVehicles[name] then
					local veh = PlayerLogistics.hercVehicles[name]
					local pv = PlayerLogistics.groundVehicles[veh.tag]

					local carried = self.context.carriedCargo[groupId]
					if carried and carried >= pv.price then
						self.context.carriedCargo[groupId] = math.max(0,self.context.carriedCargo[groupId] - pv.price)
					else
						event.weapon:destroy()
						return
					end
						
					if veh.hasChute then
						if not self.context.hercTracker.cargos[unitName] then
							self.context.hercTracker.cargos[unitName] = {}
						end
						
						table.insert(self.context.hercTracker.cargos[unitName],{
							object = event.weapon,
							vehicle = veh,
							lastLoaded = self.context.lastLoaded[groupId],
							unit = event.initiator
						})
						
						env.info('PlayerLogistics - Hercules - '..unitName..' deployed '..veh.tag)
						self.context:processHercCargos(unitName)
					else
						if Utils.getAGL(event.weapon) > 5 then
							event.weapon:destroy()
						else
							local pos = Utils.getPointOnSurface(event.weapon:getPoint())
							local num = math.floor(timer.getTime())
							local rand = math.random(100,999)
							local name = 'player-'..pv.label..num..rand
							local result = Spawner.createPlayerVehicle(pv.template, name, pos, 2)
							if result then
								self.context.trackedPlayerVehicles[name] = { name = name, template = pv, side = 2, mp = PlayerLogistics.startingMP}
							end
						end
					end
				end
			end
		end
		
		world.addEventHandler(ev)

		timer.scheduleFunction(function(param,time)
			for i,v in pairs(param.context.trackedBoxes) do
				v.lifetime = v.lifetime - 10
				if v.lifetime <= 0 then
					local box = StaticObject.getByName(i) or Unit.getByName(i)
					if box then
						if Utils.isLanded(box) then
							local zn = ZoneCommand.getZoneOfPoint(box:getPoint())
							if not zn then zn = FARPCommand.getFARPOfPoint(box:getPoint()) end

							if zn then 
								zn:addResource(v.amount)
								zn:refreshText()
							end

							box:destroy() 
						else
							v.lifetime = 15*60
						end
					end
					param.context.trackedBoxes[v] = nil
				end
			end

			if param.context.humanResource.current < param.context.humanResource.max then
				param.context.humanResource.progress = param.context.humanResource.progress + 60
			end

			if param.context.humanResource.progress >= param.context.humanResource.spawncost then
				param.context.humanResource.progress = 0
				param.context.humanResource.current = param.context.humanResource.current + 1
			end

			for i,v in pairs(param.context.trackedPlayerVehicles) do
				local g = Group.getByName(v.name)
				if g and g:isExist() and g:getSize()>0 then
					local u = g:getUnit(1)

					MenuRegistry.triggerMenusForUnit(u)

					local zn = ZoneCommand.getZoneOfPoint(u:getPoint())
					if not zn then 
						zn = FARPCommand.getFARPOfPoint(u:getPoint())
					end

					local hadMessage = false
					if zn and zn.side == u:getCoalition() then
						local amount = 60*5
						local cost = amount/10

						if v.mp < PlayerLogistics.startingMP and zn.resource > cost then
							v.mp = math.min(v.mp + amount, PlayerLogistics.startingMP)
							zn:removeResource(cost)
							
							local msg = 'Vehicle Maintenance: '..string.format("%.0f", (math.max(v.mp,0)/PlayerLogistics.startingMP)*100)..'%'
							trigger.action.outTextForUnit(u:getID(), msg, 9)
							hadMessage = true
						end
					else
						v.mp = math.max(v.mp - 10, 0)
					end

					if v.mp <= 60*30 and not hadMessage then
						local msg = 'Vehicle Maintenance: '..string.format("%.0f", (math.max(v.mp,0)/PlayerLogistics.startingMP)*100)..'%'

						msg = msg..'\n Enter a friendly zone to recover'

						trigger.action.outTextForUnit(u:getID(), msg, 9)
					end
					
					if v.mp <= 0 and math.random()<0.05 then
						local msg = 'Vehicle broke down'
						trigger.action.outTextForUnit(u:getID(), msg, 10)
						trigger.action.explosion(u:getPoint(), 20)
					end
				else
					param.context.trackedPlayerVehicles[i] = nil
				end
			end

			return time+10
		end, {context = self}, timer.getTime()+10)

		DependencyManager.get("MarkerCommands"):addCommand('remove', function(event, _, state)
			local z = FARPCommand.getFARPOfPoint(event.pos)
			if z then 
				z:scheduleRemoval()
				return true
			end
		end, false, self)

        DependencyManager.get("MarkerCommands"):addCommand('spawn',function(event, item, state)
			if not item then return false end

			local z = ZoneCommand.getZoneOfPoint(event.pos)
			if not z then 
				z = FARPCommand.getFARPOfPoint(event.pos) 
				if z and not z:hasFeature(PlayerLogistics.buildables.tent) then
					return false
				end
			end

			if not z then return false end
			if z.side ~= 2 then return false end
			if z:criticalOnSupplies() then return false end

			local options = {}
			for i,v in pairs(PlayerLogistics.groundVehicles) do
				if Config.isColdWar then
					if v.isCW then
						options[i] = v
					end
				else
					options[i] = v
				end
			end

			if item == 'ls' then
				local sortedop = {}
				for i,v in pairs(options) do
					v.name = i
					table.insert(sortedop, v)
				end

				table.sort(sortedop, function(a,b) return a.name < b.name end)

				local m = 'Available to spawn:\n'
				for i,v in pairs(sortedop) do
					if v.price <= z.resource then
						m = m..'\nspawn:'..v.name..' ['..v.price..']'
					end
				end

				trigger.action.outText(m, 15)
				return false
			end

			local op = options[item]

			if op and z.resource >= op.price then
				local num = math.floor(timer.getTime())
				local rand = math.random(100,999)
				local name = 'player-'..op.label..num..rand
				local result = Spawner.createPlayerVehicle(op.template, name, event.pos, 2)
				if result then
					z:removeResource(op.price)
					z:refreshText()
					state.trackedPlayerVehicles[name] = { name = name, template = op, side = 2, mp = PlayerLogistics.startingMP}
					return true
				end
			end
        end, true, self)
	end

	function PlayerLogistics:processHercCargos(unitName)
		if not self.hercTracker.cargoCheckFunctions[unitName] then
			env.info('PlayerLogistics - Hercules - start tracking cargos of '..unitName)
			self.hercTracker.cargoCheckFunctions[unitName] = timer.scheduleFunction(function(params, time)
				local reschedule = params.context:checkHercCargo(params.unitName, time)
				if not reschedule then
					params.context.hercTracker.cargoCheckFunctions[params.unitName] = nil
					env.info('PlayerLogistics - Hercules - stopped tracking cargos of '..params.unitName)
				end
				
				return reschedule
			end, {unitName=unitName, context = self}, timer.getTime()+0.1)
		end
	end

	function PlayerLogistics:checkHercCargo(unitName, time)
		local cargos = self.hercTracker.cargos[unitName]
		if cargos and #cargos > 0 then
			local remaining = {}
			for _,cargo in ipairs(cargos) do
				if cargo.object and cargo.object:isExist() then
					local alt = Utils.getAGL(cargo.object)
					if alt < 5 then
						self:deliverHercCargo(cargo)
					else
						table.insert(remaining, cargo)
					end
				else
					env.info('PlayerLogistics - Hercules - cargo crashed '..tostring(cargo.supply))
					if cargo.squad then 
						env.info('PlayerLogistics - Hercules - squad crashed '..tostring(cargo.squad.type))
					end

					if cargo.vehicle then 
						env.info('PlayerLogistics - Hercules - vehicle crashed '..tostring(cargo.vehicle.tag))
					end

					if cargo.unit and cargo.unit:isExist() then
						if cargo.squad then
							local squadName = PlayerLogistics.getInfantryName(cargo.squad.type)
							trigger.action.outTextForUnit(cargo.unit:getID(), 'Cargo drop of '..cargo.unit:getPlayerName()..' with '..squadName..' crashed', 10)
						elseif cargo.supply then
							trigger.action.outTextForUnit(cargo.unit:getID(), 'Cargo drop of '..cargo.unit:getPlayerName()..' with '..cargo.supply..' supplies crashed', 10)
						end
					end
				end
			end

			if #remaining > 0 then
				self.hercTracker.cargos[unitName] = remaining
				return time + 0.1
			end
		end
	end

	function PlayerLogistics:deliverHercCargo(cargo)
		if cargo.object and cargo.object:isExist() then
			if cargo.supply then
				local zone = ZoneCommand.getZoneOfWeapon(cargo.object)
				if not zone then zone = FARPCommand.getFARPOfWeapon(cargo.object) end
				if zone then
					zone:addResource(cargo.supply)
					env.info('PlayerLogistics - Hercules - '..cargo.supply..' delivered to '..zone.name)

					self:awardSupplyXP(cargo.lastLoaded, zone, cargo.unit, cargo.supply)
				end
			elseif cargo.squad then
				local pos = Utils.getPointOnSurface(cargo.object:getPoint())
				pos.y = pos.z
				pos.z = nil
				local surface = land.getSurfaceType(pos)
				if surface == land.SurfaceType.LAND or surface == land.SurfaceType.ROAD or surface == land.SurfaceType.RUNWAY then
					local zn = ZoneCommand.getZoneOfPoint(pos)
					if not zn then FARPCommand.getFARPOfPoint(pos) end
					
					local lastLoad = cargo.squad.loadedAt
					if lastLoad and zn and zn.side == cargo.object:getCoalition() and zn.name==lastLoad.name then
						if self.registeredSquadGroups[cargo.squad.type] then
							local cost = self.registeredSquadGroups[cargo.squad.type].cost
							zn:addResource(cost)
							zn:refreshText()
							if cargo.unit and cargo.unit:isExist() then
								local squadName = PlayerLogistics.getInfantryName(cargo.squad.type)
								trigger.action.outTextForUnit(cargo.unit:getID(), squadName..' unloaded', 10)
							end
						end
					else
						local error = DependencyManager.get("SquadTracker"):spawnInfantry(self.registeredSquadGroups[cargo.squad.type], pos)
						if not error then
							env.info('PlayerLogistics - Hercules - '..cargo.squad.type..' deployed')
							
							local squadName = PlayerLogistics.getInfantryName(cargo.squad.type)
							
							if cargo.unit and cargo.unit:isExist() and cargo.unit.getPlayerName then
								trigger.action.outTextForUnit(cargo.unit:getID(), squadName..' deployed', 10)
								local player = cargo.unit:getPlayerName()
								local xp = RewardDefinitions.actions.squadDeploy * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)
								
								DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)
								
								if zn then
									DependencyManager.get("MissionTracker"):tallyUnloadSquad(player, zn.name, cargo.squad.type)
								else
									DependencyManager.get("MissionTracker"):tallyUnloadSquad(player, '', cargo.squad.type)
								end
								trigger.action.outTextForUnit(cargo.unit:getID(), '+'..math.floor(xp)..' XP', 10)
							end
						end
					end
				else
					env.info('PlayerLogistics - Hercules - '..cargo.squad.type..' dropped on invalid surface '..tostring(surface))
					local cpos = cargo.object:getPoint()
					env.info('PlayerLogistics - Hercules - cargo spot X:'..cpos.x..' Y:'..cpos.y..' Z:'..cpos.z)
					env.info('PlayerLogistics - Hercules - surface spot X:'..pos.x..' Y:'..pos.y)
					local squadName = PlayerLogistics.getInfantryName(cargo.squad.type)
					trigger.action.outTextForUnit(cargo.unit:getID(), 'Cargo drop of '..cargo.unit:getPlayerName()..' with '..squadName..' crashed', 10)
				end
			elseif cargo.vehicle then
				local pos = Utils.getPointOnSurface(cargo.object:getPoint())
				pos.y = pos.z
				pos.z = nil
				local surface = land.getSurfaceType(pos)
				if surface == land.SurfaceType.LAND or surface == land.SurfaceType.ROAD or surface == land.SurfaceType.RUNWAY then
					local pv = PlayerLogistics.groundVehicles[cargo.vehicle.tag]
					local pos = Utils.getPointOnSurface(cargo.object:getPoint())
					local num = math.floor(timer.getTime())
					local rand = math.random(100,999)
					local name = 'player-'..pv.label..num..rand
					local result = Spawner.createPlayerVehicle(pv.template, name, pos, 2)
					if result then
						self.trackedPlayerVehicles[name] = { name = name, template = pv, side = 2, mp = PlayerLogistics.startingMP}
					end
				end
			end

			cargo.object:destroy()
		end
	end

	function PlayerLogistics:hercPrepareDrop(params)
		local groupname = params.group
		local type = params.type
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)

			if type == 'supplies' then
				local cargo = self.carriedCargo[gr:getID()]
				if cargo and cargo > 0 then
					self.hercPreparedDrops[gr:getID()] = type
					trigger.action.outTextForUnit(un:getID(), 'Supply drop prepared', 10)
				else
					trigger.action.outTextForUnit(un:getID(), 'No supplies onboard the aircraft', 10)
				end
			else
				local exists = false
				if self.carriedInfantry[gr:getID()] then
					for i,v in ipairs(self.carriedInfantry[gr:getID()]) do
						if v.type == type then
							exists = true
							break
						end
					end
				end
			
				if exists then
					self.hercPreparedDrops[gr:getID()] = type
					local squadName = PlayerLogistics.getInfantryName(type)
					trigger.action.outTextForUnit(un:getID(), squadName..' drop prepared', 10)
				else
					local squadName = PlayerLogistics.getInfantryName(type)
					trigger.action.outTextForUnit(un:getID(), 'No '..squadName..' onboard the aircraft', 10)
				end
			end
		end
	end

	function PlayerLogistics:awardSupplyXP(lastLoad, zone, unit, amount)
		if lastLoad and zone.name~=lastLoad.name then
			if unit and unit.isExist and unit:isExist() and unit.getPlayerName then
				local player = unit:getPlayerName()
				local xp = amount*RewardDefinitions.actions.supplyRatio

				local totalboost = 0
				local dist = mist.utils.get2DDist(lastLoad.zone.point, zone.zone.point)
				if dist > 15000 then
					local extradist = math.max(dist - 15000, 85000)
					local kmboost = extradist/85000
					local actualboost = xp * kmboost * 1
					totalboost = totalboost + actualboost
				end

				local both = true
				if zone:criticalOnSupplies() then
					local actualboost = xp * RewardDefinitions.actions.supplyBoost
					totalboost = totalboost + actualboost
				else 
					both = false
				end

				if zone.distToFront == 0 then
					local actualboost = xp * RewardDefinitions.actions.supplyBoost
					totalboost = totalboost + actualboost
				else 
					both = false
				end

				if both then
					local actualboost = xp * 1
					totalboost = totalboost + actualboost
				end

				xp = xp + totalboost

				if lastLoad.distToFront >= zone.distToFront then
					xp = xp * 0.25
				end

				xp = xp * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)

				DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)
				DependencyManager.get("MissionTracker"):tallySupplies(player, amount, zone.name)
				trigger.action.outTextForUnit(unit:getID(), '+'..math.floor(xp)..' XP', 10)
			end
		end
	end
	
	function PlayerLogistics.markWithSmoke(zonename)
		local zone = CustomZone:getByName(zonename)
		local p = Utils.getPointOnSurface(zone.point)
		trigger.action.smoke(p, 0)
	end
	
	function PlayerLogistics.getWeight(supplies)
		return math.floor(supplies)
	end

	function PlayerLogistics:getCarriedBoxWeight(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return 0 end
			
			local max = PlayerLogistics.allowedTypes[un:getDesc().typeName].boxCapacity

			if not self.carriedBoxes[gr:getID()] then self.carriedBoxes[gr:getID()] = {} end
			local boxes = self.carriedBoxes[gr:getID()]
			local weight = 0
			for i,v in ipairs(boxes) do
				weight = weight + PlayerLogistics.getWeight(v.amount)
			end

			return weight
		end
	end

	function PlayerLogistics:getCarriedPersonWeight(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return 0 end
			
			local max = PlayerLogistics.allowedTypes[un:getDesc().typeName].personCapacity

			local pilotWeight = 0
			local squadWeight = 0
			if not self.carriedPilots[gr:getID()] then self.carriedPilots[gr:getID()] = {} end
			local pilots = self.carriedPilots[gr:getID()]
			if pilots then 
				pilotWeight = 70 * #pilots
			end

			if not self.carriedInfantry[gr:getID()] then self.carriedInfantry[gr:getID()] = {} end
			local squads = self.carriedInfantry[gr:getID()]
			if squads then
				for _,squad in ipairs(squads) do 
					squadWeight = squadWeight + squad.weight
				end
			end

			return pilotWeight + squadWeight
		end
	end

	function PlayerLogistics:getOccupiedPersonCapacity(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return 0 end
			if self.carriedCargo[gr:getID()] and self.carriedCargo[gr:getID()] > 0 then return 0 end
			
			local max = PlayerLogistics.allowedTypes[un:getDesc().typeName].personCapacity

			local pilotCount = 0
			local squadCount = 0
			if not self.carriedPilots[gr:getID()] then self.carriedPilots[gr:getID()] = {} end
			local pilots = self.carriedPilots[gr:getID()]
			if pilots then 
				pilotCount = #pilots
			end

			if not self.carriedInfantry[gr:getID()] then self.carriedInfantry[gr:getID()] = {} end
			local squads = self.carriedInfantry[gr:getID()]
			if squads then
				for _,squad in ipairs(squads) do 
					squadCount = squadCount + squad.size
				end
			end

			local total = pilotCount + squadCount

			return total
		end
	end

	function PlayerLogistics:getRemainingPersonCapacity(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return 0 end
			if self.carriedCargo[gr:getID()] and self.carriedCargo[gr:getID()] > 0 then return 0 end
			if self.carriedBoxes[gr:getID()] and #self.carriedBoxes[gr:getID()] > 0 then return 0 end
			
			local max = PlayerLogistics.allowedTypes[un:getDesc().typeName].personCapacity

			local total = self:getOccupiedPersonCapacity(groupname)

			return max - total
		end
	end

	function PlayerLogistics:canFitBoxes(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return false end
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName].boxCapacity then return false end
			if self:getOccupiedPersonCapacity(groupname) > 0 then return false end
			if self.carriedCargo[gr:getID()] and self.carriedCargo[gr:getID()] > 0 then return false end

			local carried = 0
			if self.carriedBoxes[gr:getID()] then
				carried = #self.carriedBoxes[gr:getID()]
			end
			
			return carried < PlayerLogistics.allowedTypes[un:getDesc().typeName].boxCapacity
		end
	end

	function PlayerLogistics:canFitCargo(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return false end
			if self:getOccupiedPersonCapacity(groupname) > 0 then return false end
			if self.carriedBoxes[gr:getID()] and #self.carriedBoxes[gr:getID()] > 0 then return false end

			return true
		end
	end

	function PlayerLogistics:canFitPersonnel(groupname, toFit)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			if not PlayerLogistics.allowedTypes[un:getDesc().typeName] then return false end
			if self.carriedBoxes[gr:getID()] and #self.carriedBoxes[gr:getID()] > 0 then return false end

			return self:getRemainingPersonCapacity(groupname) >= toFit
		end
	end

	function PlayerLogistics:getClosestBox(pos, dist)
		if not dist then dist = 500 end
		local closest = nil
		local mindist = 99999
		for i,v in pairs(self.trackedBoxes) do
			local obj = StaticObject.getByName(i) or Unit.getByName(i)
			if obj and obj:isExist() then
				local d = mist.utils.get2DDist(obj:getPoint(), pos)
				if d<=dist and d<=mindist then
					mindist = d
					closest = v
				end
			end
		end

		return closest
	end

	function PlayerLogistics:unloadCrates(groupname, all)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if not self.carriedBoxes[gr:getID()] then self.carriedBoxes[gr:getID()] = {} end

		if not self:isCargoDoorOpen(un) then
			trigger.action.outTextForUnit(un:getID(), 'Can not unload crates while cargo door closed', 10)
			return
		end

		if un then
			if #self.carriedBoxes[gr:getID()] == 0 then
				trigger.action.outTextForUnit(un:getID(), 'No crates onboard', 10)
				return
			end

			if all then
				for i,v in ipairs(self.carriedBoxes[gr:getID()]) do
					local unitPos = un:getPosition()
					local unitheading = math.atan2(unitPos.x.z, unitPos.x.x)

					local ahead = 15
					local area = 5
		
					local vec = {
						x = unitPos.x.x * ahead,
						z = unitPos.x.z * ahead
					}
		
					local offset = un:getPoint()
					offset.x = offset.x + vec.x
					offset.y = offset.z + vec.z
					offset.z = nil
		
					offset.x = offset.x + math.random(-area,area)
					offset.y = offset.y + math.random(-area,area)

					v.pos = offset
					self:restoreBox(v)
					trigger.action.outTextForUnit(un:getID(), 'Unloaded '..v.name, 10)
				end
				
				self.carriedBoxes[gr:getID()] = {}
			else
				local v = self.carriedBoxes[gr:getID()][1]
				local unitPos = un:getPosition()
				local unitheading = math.atan2(unitPos.x.z, unitPos.x.x)

				local ahead = 15
				local area = 5
	
				local vec = {
					x = unitPos.x.x * ahead,
					z = unitPos.x.z * ahead
				}
	
				local offset = un:getPoint()
				offset.x = offset.x + vec.x
				offset.y = offset.z + vec.z
				offset.z = nil
	
				offset.x = offset.x + math.random(-area,area)
				offset.y = offset.y + math.random(-area,area)

				v.pos = offset
				self:restoreBox(v)
				trigger.action.outTextForUnit(un:getID(), 'Unloaded '..v.name, 10)

				table.remove(self.carriedBoxes[gr:getID()], 1)
			end

			local w = self:getCarriedBoxWeight(groupname)
			trigger.action.setUnitInternalCargo(un:getName(), w)
		end
	end
	
	function PlayerLogistics:loadClosestCrate(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		
		if not self.carriedBoxes[gr:getID()] then self.carriedBoxes[gr:getID()] = {} end

		if not self:isCargoDoorOpen(un) then
			trigger.action.outTextForUnit(un:getID(), 'Can not load crates while cargo door closed', 10)
			return
		end

		if un then
			local box = self:getClosestBox(un:getPoint(), 20)

			if box then
				local unitType = un:getDesc()['typeName']
				local logistics = self.allowedTypes[unitType]
				if not self:canFitBoxes(groupname) then
					trigger.action.outTextForUnit(un:getID(), 'Not enough free space onboard.', 10)
					return
				end
				
				local obj = StaticObject.getByName(box.name) or Unit.getByName(box.name)
				if obj then
					table.insert(self.carriedBoxes[gr:getID()], {
                        name = box.name,
                        amount = box.amount, 
                        origin = box.origin.name,
                        side = un:getCoalition(),
                        type = box.type,
                        pos = {},
                        lifetime = box.lifetime,
                        content = box.content,
                        convert = box.convert,
                        isSalvage = box.isSalvage
                    })

					self.trackedBoxes[box.name] = nil
					obj:destroy() 
					trigger.action.outTextForUnit(un:getID(), 'Loaded '..box.name, 10)
					local w = self:getCarriedBoxWeight(groupname)
					trigger.action.setUnitInternalCargo(un:getName(), w)
				end
			else
				trigger.action.outTextForUnit(un:getID(), 'No crates nearby.', 10)
			end
		end
	end

	function PlayerLogistics:startSlingGuidance(groupname)
		local gr = Group.getByName(groupname)
		local un = gr:getUnit(1)
		if un then
			local box = self:getClosestBox(un:getPoint())

			if box then
				trigger.action.outTextForUnit(un:getID(), 'Starting Guidance on '..box.name, 10)

				timer.scheduleFunction(function(param,time)
					local pu = param.unit
					local c = StaticObject.getByName(param.box.name)
					
					if not pu or not pu:isExist() or not c or not c:isExist() or not Utils.isLanded(c) then 
						return 
					end

					local dist = mist.utils.get2DDist(pu:getPoint(), c:getPoint())
					if dist > 500 then return end
					
					param.context:printSlingGuidance(pu,c)
					param.timeout = param.timeout - 1
					return time+1
				end, {box = box, unit = un, timeout = 300, context = self}, timer.getTime()+1)
			else
				trigger.action.outTextForUnit(un:getID(), 'No crates nearby.', 10)
			end
		end
	end

	function PlayerLogistics:printSlingGuidance(unit, cargo)
		local upos = unit:getPoint()
		local cpos = cargo:getPoint()

		local slingoffset = PlayerLogistics.slingPos[unit:getDesc().typeName]

		local altdif = math.abs(upos.y-cpos.y)

		local origin = {
			x = upos.x,
			y = upos.z
		}

		local tgt = {
			x = cpos.x,
			y = cpos.z
		}

		local bearing = math.deg(math.atan2(unit:getPosition().x.z, unit:getPosition().x.x))
		if bearing < 0 then
			bearing = 360+bearing
		end
		
		local localvec = Utils.toLocalVector(origin, tgt)

		local offset = Utils.rotateVector(localvec, bearing)
		

		if slingoffset then
			offset.x = offset.x + slingoffset.fwd
		end

		local msg = ''

		local vright = false
		if offset.x < -1 then 
			msg = " "..math.floor(math.abs(offset.x)).."m\n↓↓↓\n\n\n"
		elseif offset.x > 1 then
			msg = "↑↑↑\n "..math.floor(math.abs(offset.x)).."m\n\n\n"
		else
			msg = "↓↓↓\n  X \n↑↑↑\n\n"
			vright = true
		end
		
		local hright = false
		if offset.y < -1 then 
			right = "" 
			msg = msg.."← ← ← "..math.floor(math.abs(offset.y)).."m"
		elseif offset.y > 1 then
			msg = msg..""..math.floor(math.abs(offset.y)).."m → → →"
		else
			msg = msg.."→ → → X ← ← ←"
			hright = true
		end

		if vright and hright then
			msg =      "      ↓ ↓ ↓\n"
			msg = msg.."→ → → X ← ← ←\n"
			msg = msg.."      ↑ ↑ ↑"
		end

		msg = msg..'\n\n↥ '..math.floor(altdif)..'m ↥'

		trigger.action.outTextForUnit(unit:getID(), msg, 1)
	end

	function PlayerLogistics:showPilot(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				local data = DependencyManager.get("CSARTracker"):getClosestPilot(un:getPoint())
				
				if not data then 
					trigger.action.outTextForUnit(un:getID(), 'No pilots in need of extraction', 10)
					return
				end

				local pos = data.pilot:getUnit(1):getPoint()
				local brg = math.floor(Utils.getBearing(un:getPoint(), data.pilot:getUnit(1):getPoint()))
				local dist = data.dist
				local dstft = math.floor(dist/0.3048)

				local msg = data.name..' requesting extraction'
				msg = msg..'\n\n Distance: '
				if dist>1000 then
					local dstkm = string.format('%.2f',dist/1000)
					local dstnm = string.format('%.2f',dist/1852)
					
					msg = msg..dstkm..'km | '..dstnm..'nm'
				else
					local dstft = math.floor(dist/0.3048)
					msg = msg..math.floor(dist)..'m | '..dstft..'ft'
				end
				
				msg = msg..'\n Bearing: '..brg
				
				trigger.action.outTextForUnit(un:getID(), msg, 10)
			end
		end
	end
	
	function PlayerLogistics:smokePilot(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				local data = DependencyManager.get("CSARTracker"):getClosestPilot(un:getPoint())
				
				if not data or data.dist >= 5000 then 
					trigger.action.outTextForUnit(un:getID(), 'No pilots nearby', 10)
					return
				end

				DependencyManager.get("CSARTracker"):markPilot(data)
				trigger.action.outTextForUnit(un:getID(), 'Location of '..data.name..' marked with green smoke.', 10)
			end
		end
	end
	
	function PlayerLogistics:flarePilot(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				local data = DependencyManager.get("CSARTracker"):getClosestPilot(un:getPoint())
				
				if not data or data.dist >= 5000 then 
					trigger.action.outTextForUnit(un:getID(), 'No pilots nearby', 10)
					return
				end

				DependencyManager.get("CSARTracker"):flarePilot(data)
				trigger.action.outTextForUnit(un:getID(), data.name..' has deployed a green flare', 10)
			end
		end
	end
	
	function PlayerLogistics:unloadPilots(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				local pilots = self.carriedPilots[gr:getID()]
				if not pilots or #pilots==0 then
					trigger.action.outTextForUnit(un:getID(), 'No pilots onboard', 10)
					return
				end

				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload pilot while in air', 10)
					return
				end
				
				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload pilot while cargo door closed', 10)
					return
				end

				local zn = ZoneCommand.getZoneOfUnit(un:getName())
				if not zn then 
					zn = CarrierCommand.getCarrierOfUnit(un:getName())
				end

				if not zn then
					zn = FARPCommand.getFARPOfUnit(un:getName())
					if zn and not zn:hasFeature(PlayerLogistics.buildables.medtent) then
						trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Field Hospital. Can not offload pilots.', 10)
						return
					end
				end
				
				if not zn then
					trigger.action.outTextForUnit(un:getID(), 'Can only unload extracted pilots while within a friendly zone', 10)
					return
				end
				
				if zn.side ~= 0 and zn.side ~= un:getCoalition()then
					trigger.action.outTextForUnit(un:getID(), 'Can only unload extracted pilots while within a friendly zone', 10)
					return
				end

				zn:addResource(200*#pilots)
				zn:refreshText()

				self.humanResource.current = self.humanResource.current + #pilots

				if un.getPlayerName then
					local player = un:getPlayerName()

					local xp = #pilots*RewardDefinitions.actions.pilotExtract

					xp = xp * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)

					DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)
					DependencyManager.get("MissionTracker"):tallyUnloadPilot(player, zn.name)
					trigger.action.outTextForUnit(un:getID(), '+'..math.floor(xp)..' XP', 10)
				end

				self.carriedPilots[gr:getID()] = {}
				trigger.action.setUnitInternalCargo(un:getName(), 0)
				trigger.action.outTextForUnit(un:getID(), 'Pilots unloaded', 10)
			end
		end
	end
	
	function PlayerLogistics:extractPilot(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				if not self:canFitPersonnel(groupname, 1) then
					trigger.action.outTextForUnit(un:getID(), 'Not enough free space onboard. (Need 1)', 10)
					return
				end

				if Utils.isLanded(un, true) then
					local data = DependencyManager.get("CSARTracker"):getClosestPilot(un:getPoint())
					if data and data.dist < 25 then
						self:embarkPilot(gr, un, data)
						return
					else
						trigger.action.outTextForUnit(un:getID(), 'Wait for pilot to board.', 10)
						local pilotgr = Group.getByName(data.name)
						if pilotgr and pilotgr:isExist() then
							TaskExtensions.sendToPoint(pilotgr, un:getPoint())
						end

						timer.scheduleFunction(function(param, time)
							local un = param.player
							local self = param.context
							local pilot = param.pilot
							local gr = un:getGroup()

							if Utils.isInAir(un) then 
								trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Took off', 10)
								return 
							end

							if not self:isCargoDoorOpen(un) then
								trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Cargo door closed', 10)
								return
							end

							local pilotgr = Group.getByName(pilot.name)
							if not pilotgr or not pilotgr:isExist() then
								trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Pilot is MIA.', 10)
								return 
							end

							local psize = pilotgr:getSize()
							if not self:canFitPersonnel(gr:getName(), psize) then
								trigger.action.outTextForUnit(un:getID(), 'Not enough free space onboard. (Need '..psize..')', 10)
								return
							end

							local pPos = un:getPoint()
							local sPos = pilotgr:getUnit(1):getPoint()

							local dist = mist.utils.get2DDist(pPos, sPos)

							if dist < 25 then
								self:embarkPilot(gr, un, pilot)
								return
							else
								return time+5
							end
						end, {context = self, pilot = data, player = un}, timer.getTime()+5)
					end
				else
					timer.scheduleFunction(function(param,time) 
						local self = param.context
						local un = param.unit
						if not un then return end
						if not un:isExist() then return end
						local gr = un:getGroup()

						local data = DependencyManager.get("CSARTracker"):getClosestPilot(un:getPoint())

						if not data or data.dist > 500 then
							trigger.action.outTextForUnit(un:getID(), 'There is no pilot nearby that needs extraction', 10)
							return
						else
							if not self:isCargoDoorOpen(un) then
								trigger.action.outTextForUnit(un:getID(), 'Cargo door closed', 1)
							elseif Utils.getAGL(un) > 70 then
								trigger.action.outTextForUnit(un:getID(), 'Altitude too high (< 70 m). Current: '..string.format('%.2f',Utils.getAGL(un))..' m', 1)
							elseif mist.vec.mag(un:getVelocity())>5 then
								trigger.action.outTextForUnit(un:getID(), 'Moving too fast (< 5 m/s). Current: '..string.format('%.2f',mist.vec.mag(un:getVelocity()))..' m/s', 1)
							else
								if data.dist > 25 then
									trigger.action.outTextForUnit(un:getID(), 'Too far (< 25m). Current: '..string.format('%.2f',data.dist)..' m', 1)
								else
									self:embarkPilot(gr, un, data)
									return
								end
							end
						end

						param.trys = param.trys - 1
						if param.trys > 0 then
							return time+1
						end
					end, {context = self, unit = un, trys = 60}, timer.getTime()+0.1)
				end
			end
		end
	end

	function PlayerLogistics:embarkPilot(gr, un, data)
		if not self.carriedPilots[gr:getID()] then self.carriedPilots[gr:getID()] = {} end
		table.insert(self.carriedPilots[gr:getID()], data.name)
		local player = un:getPlayerName()
		DependencyManager.get("MissionTracker"):tallyLoadPilot(player, data)
		DependencyManager.get("CSARTracker"):removePilot(data.name)
		local weight = self:getCarriedPersonWeight(gr:getName())
		trigger.action.setUnitInternalCargo(un:getName(), weight)
		trigger.action.outTextForUnit(un:getID(), data.name..' onboard. ('..weight..' kg)', 10)
	end

	function PlayerLogistics:embarkSquad(gr, un, sqsize, squadgr, squad)
		if not self.carriedInfantry[gr:getID()] then self.carriedInfantry[gr:getID()] = {} end

		table.insert(self.carriedInfantry[gr:getID()],{type = PlayerLogistics.infantryTypes.extractable, size = sqsize, weight = sqsize * 70})
		
		local weight = self:getCarriedPersonWeight(gr:getName())

		trigger.action.setUnitInternalCargo(un:getName(), weight)
		
		local loadedInfName = PlayerLogistics.getInfantryName(PlayerLogistics.infantryTypes.extractable)
		trigger.action.outTextForUnit(un:getID(), loadedInfName..' onboard. ('..weight..' kg)', 10)
		
		local player = un:getPlayerName()
		DependencyManager.get("MissionTracker"):tallyLoadSquad(player, squad)
		DependencyManager.get("SquadTracker"):removeSquad(squad.name)
		
		squadgr:destroy()
	end

	function PlayerLogistics:extractSquad(groupname)
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then

				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry while in air', 10)
					return
				end
				
				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry while cargo door closed', 10)
					return
				end

				local squad, distance = DependencyManager.get("SquadTracker"):getClosestExtractableSquad(un:getPoint(), un:getCoalition())
				if squad and distance < 300 then
					local squadgr = Group.getByName(squad.name)
					if squadgr and squadgr:isExist() then
						local sqsize = squadgr:getSize()
						if not self:canFitPersonnel(groupname, sqsize) then
							trigger.action.outTextForUnit(un:getID(), 'Not enough free space onboard. (Need '..sqsize..')', 10)
							return
						end

						if distance < 25 then
							self:embarkSquad(gr, un, sqsize, squadgr, squad)
						else
							trigger.action.outTextForUnit(un:getID(), 'Wait for squad to board.', 10)
							TaskExtensions.sendToPoint(squadgr, un:getPoint())
							timer.scheduleFunction(function(param, time)
								local un = param.player
								local self = param.context
								local squad = param.squad

								if not un then return end
								
								local gr = un:getGroup()

								if Utils.isInAir(un) then 
									trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Took off', 10)
									return 
								end

								if not self:isCargoDoorOpen(un) then
									trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Cargo door closed', 10)
									return
								end

								local squadgr = Group.getByName(squad.name)
								if not squadgr or not squadgr:isExist() then
									trigger.action.outTextForUnit(un:getID(), 'Extraction aborted. Squad is MIA.', 10)
									return 
								end

								local sqsize = squadgr:getSize()
								if not self:canFitPersonnel(gr:getName(), sqsize) then
									trigger.action.outTextForUnit(un:getID(), 'Not enough free space onboard. (Need '..sqsize..')', 10)
									return
								end

								local pPos = un:getPoint()
								
								local sPos = squadgr:getUnit(1):getPoint()

								local dist = mist.utils.get2DDist(pPos, sPos)
								for i,v in ipairs(squadgr:getUnits()) do
									local d = mist.utils.get2DDist(pPos, v:getPoint())
									if d<dist then dist = d end
								end

								if dist < 25 then
									self:embarkSquad(gr, un, sqsize, squadgr, squad)
									return
								else
									return time+5
								end
							end, {context = self, squad = squad, player = un}, timer.getTime()+5)
						end
					end
				else
					trigger.action.outTextForUnit(un:getID(), 'There is no infantry nearby that is ready to be extracted.', 10)
				end
			end
		end
	end

	function PlayerLogistics:loadInfantry(params)
		if not ZoneCommand then return end
		
		local gr = Group.getByName(params.group)
		local squadType = params.type
		local squadName = PlayerLogistics.getInfantryName(squadType)
		
		local squadCost = 0
		local squadSize = 999999
		local squadWeight = 0
		if self.registeredSquadGroups[squadType] then
			squadCost = self.registeredSquadGroups[squadType].cost
			squadSize = self.registeredSquadGroups[squadType].size
			squadWeight = self.registeredSquadGroups[squadType].weight
		end
		
		if gr then
			local un = gr:getUnit(1)
			if un then
				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry while in air', 10)
					return
				end
				
				local zn = ZoneCommand.getZoneOfUnit(un:getName())
				if not zn then 
					zn = CarrierCommand.getCarrierOfUnit(un:getName())
				end

				if not zn then 
					zn = FARPCommand.getFARPOfUnit(un:getName())
					if zn and not zn:hasFeature(PlayerLogistics.buildables.tent) then
						trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Command Center. Can not load infantry.', 10)
						return
					end
				end
				
				if not zn then
					trigger.action.outTextForUnit(un:getID(), 'Can only load infantry while within a friendly zone', 10)
					return
				end
				
				if zn.side ~= un:getCoalition() then
					trigger.action.outTextForUnit(un:getID(), 'Can only load infantry while within a friendly zone', 10)
					return
				end

				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry while cargo door closed', 10)
					return
				end

				if zn:criticalOnSupplies() then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry, zone is low on resources', 10)
					return
				end

				if squadSize > self.humanResource.current then
					trigger.action.outTextForUnit(un:getID(), 'Can not load infantry, not enough available personnel. [Need: '..squadSize..', Available: '..self.humanResource.current..']', 10)
					return
				end

				if zn.resource < zn.spendTreshold + squadCost then
					trigger.action.outTextForUnit(un:getID(), 'Can not afford to load '..squadName..' (Cost: '..squadCost..'). Resources would fall to a critical level.', 10)
					return
				end

				if not self:canFitPersonnel(params.group, squadSize) then
					trigger.action.outTextForUnit(un:getID(), 'Not enough free space on board. (Need '..squadSize..')', 10)
					return
				end
				
				zn:removeResource(squadCost)
				zn:refreshText()

				self.humanResource.current = math.max(self.humanResource.current - squadSize, 0)

				if not self.carriedInfantry[gr:getID()] then self.carriedInfantry[gr:getID()] = {} end
				table.insert(self.carriedInfantry[gr:getID()],{ type = squadType, size = squadSize, weight = squadWeight, loadedAt = zn })
				self.lastLoaded[gr:getID()] = zn
				
				local weight = self:getCarriedPersonWeight(gr:getName())
				trigger.action.setUnitInternalCargo(un:getName(), weight)
				
				local loadedInfName = PlayerLogistics.getInfantryName(squadType)
				trigger.action.outTextForUnit(un:getID(), loadedInfName..' onboard. ('..weight..' kg) '..self.humanResource.current..' personnel remaining.', 10)
			end
		end
	end

	function PlayerLogistics:unloadInfantry(params)
		if not ZoneCommand then return end
		local groupname = params.group
		local sqtype = params.type
		
		local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un then
				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload infantry while in air', 10)
					return
				end

				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload infantry while cargo door closed', 10)
					return
				end

				local carriedSquads = self.carriedInfantry[gr:getID()]
				if not carriedSquads or #carriedSquads == 0 then
					trigger.action.outTextForUnit(un:getID(), 'No infantry onboard', 10)
					return
				end
				
				local toUnload = carriedSquads
				local remaining = {}
				if sqtype then
					toUnload = {}
					local sqToUnload = nil
					for _,sq in ipairs(carriedSquads) do
						if sq.type == sqtype and not sqToUnload then
							sqToUnload = sq
						else
							table.insert(remaining, sq)
						end
					end

					if sqToUnload then toUnload = { sqToUnload } end
				end

				if #toUnload == 0 then
					if sqtype then
						local squadName = PlayerLogistics.getInfantryName(sqtype)
						trigger.action.outTextForUnit(un:getID(), 'No '..squadName..' onboard.', 10)
					else
						trigger.action.outTextForUnit(un:getID(), 'No infantry onboard.', 10)
					end

					return
				end
				
				local zn = ZoneCommand.getZoneOfUnit(un:getName())
				if not zn then 
					zn = CarrierCommand.getCarrierOfUnit(un:getName())
				end
				
				if not zn then 
					zn = FARPCommand.getFARPOfUnit(un:getName())
					if zn and not zn:hasFeature(PlayerLogistics.buildables.tent) then
						trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Command Center. Can not unload infantry.', 10)
						zn = nil
					end
				end

				for _, sq in ipairs(toUnload) do
					local squadName = PlayerLogistics.getInfantryName(sq.type)
					local lastLoad = sq.loadedAt
					if lastLoad and zn and zn.side == un:getCoalition() and zn.name==lastLoad.name then
						if self.registeredSquadGroups[sq.type] then
							local cost = self.registeredSquadGroups[sq.type].cost
							zn:addResource(cost)
							zn:refreshText()

							self.humanResource.current = self.humanResource.current + sq.size
							trigger.action.outTextForUnit(un:getID(), squadName..' unloaded', 10)
						end
					else
						if sq.type == PlayerLogistics.infantryTypes.extractable then
							if not zn then
								trigger.action.outTextForUnit(un:getID(), 'Can only unload extracted infantry while within a friendly zone', 10)
								table.insert(remaining, sq)
							elseif zn.side ~= un:getCoalition() then
								trigger.action.outTextForUnit(un:getID(), 'Can only unload extracted infantry while within a friendly zone', 10)
								table.insert(remaining, sq)
							else
								trigger.action.outTextForUnit(un:getID(), 'Infantry recovered', 10)
								zn:addResource(200)
								zn:refreshText()

								self.humanResource.current = self.humanResource.current + sq.size
								
								if un.getPlayerName then
									local player = un:getPlayerName()
									local xp = RewardDefinitions.actions.squadExtract * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)
			
									DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)
									DependencyManager.get("MissionTracker"):tallyUnloadSquad(player, zn.name, sq.type)
									trigger.action.outTextForUnit(un:getID(), '+'..math.floor(xp)..' XP', 10)
								end
							end
						elseif self.registeredSquadGroups[sq.type] then
							local pos = Utils.getPointOnSurface(un:getPoint())
		
							local error = DependencyManager.get("SquadTracker"):spawnInfantry(self.registeredSquadGroups[sq.type], pos)
							
							if not error then
								trigger.action.outTextForUnit(un:getID(), squadName..' deployed', 10)
		
								if un.getPlayerName then
									local player = un:getPlayerName()
									local xp = RewardDefinitions.actions.squadDeploy * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)
				
									DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)

									if zn then
										DependencyManager.get("MissionTracker"):tallyUnloadSquad(player, zn.name, sq.type)
									else
										local z = DependencyManager.get("SquadTracker"):getTargetZone(pos, sq.type, un:getCoalition())
										local name = ''
										if z then name = z.name end
										DependencyManager.get("MissionTracker"):tallyUnloadSquad(player, name, sq.type)
									end
									trigger.action.outTextForUnit(un:getID(), '+'..math.floor(xp)..' XP', 10)
								end
							else
								trigger.action.outTextForUnit(un:getID(), 'Failed to deploy squad, no suitable location nearby', 10)
								table.insert(remaining, sq)
							end
						else
							trigger.action.outText("ERROR: SQUAD TYPE NOT REGISTERED", 60)
						end
					end
				end
				
				self.carriedInfantry[gr:getID()] = remaining
				local weight = self:getCarriedPersonWeight(groupname)
				trigger.action.setUnitInternalCargo(un:getName(), weight)
			end
		end
	end

	function PlayerLogistics:unloadAll(groupname)
		local gr = Group.getByName(groupname)
		if gr then 
			local un = gr:getUnit(1)
			if un then
				local cargo = self.carriedCargo[gr:getID()]
				local squad = self.carriedInfantry[gr:getID()]
				local pilot = self.carriedPilots[gr:getID()]
				local boxes = self.carriedBoxes[gr:getID()]

				if cargo and cargo>0 then
					self:unloadSupplies({group=groupname, amount=9999999})
				end

				if squad and #squad>0 then
					self:unloadInfantry({group=groupname})
				end

				if pilot and #pilot>0 then
					self:unloadPilots(groupname)
				end

				if boxes and #boxes>0 then
					self:unloadCrates(groupname, true)
				else
					self:unpackSupplies({group = groupname}, true, true)
				end
			end
		end
	end
	
	function PlayerLogistics:cargoStatus(groupName)
		local gr = Group.getByName(groupName)
		if gr then
			local un = gr:getUnit(1)
			if un then
				local onboard = self.carriedCargo[gr:getID()]
				if onboard and onboard > 0 then
					local weight = self.getWeight(onboard)
					trigger.action.outTextForUnit(un:getID(), onboard..' supplies onboard. ('..weight..' kg)', 10)
				else
					local msg = ''
					local squads = self.carriedInfantry[gr:getID()]
					if squads and #squads>0 then
						msg = msg..'Squads:\n'

						for _,squad in ipairs(squads) do
							local infName = PlayerLogistics.getInfantryName(squad.type)
							msg = msg..'  \n'..infName..' (Size: '..squad.size..')'
						end
					end

					local pilots = self.carriedPilots[gr:getID()]
					if pilots and #pilots>0 then
						msg = msg.."\n\nPilots:\n"
						for i,v in ipairs(pilots) do
							msg = msg..'\n '..v
						end

					end
					
					local logisticsStats = PlayerLogistics.allowedTypes[un:getDesc().typeName]
					if logisticsStats then
						local max = logisticsStats.personCapacity
						if max then
							local occupied = self:getOccupiedPersonCapacity(groupName)

							msg = msg..'\n\nPersonell Capacity: '..occupied..'/'..max
							
							msg = msg..'\n('..self:getCarriedPersonWeight(groupName)..' kg)'
						end

						if logisticsStats.boxCapacity then
							local boxes = self.carriedBoxes[gr:getID()] or {}
							msg = msg..'\n\nCrate Capacity: '..#boxes..'/'..logisticsStats.boxCapacity
							if boxes and #boxes>0 then
								msg = msg.."\n\nCrates:\n"
								for i,v in ipairs(boxes) do
									msg = msg..'\n '..v.name..'('..v.amount..' kg)'
								end
							end
							msg = msg..'\n('..self:getCarriedBoxWeight(groupName)..' kg)'
						end
					end

					if un:getDesc().typeName == 'Hercules' then
						local preped = self.hercPreparedDrops[gr:getID()]
						if preped then
							if preped == 'supplies' then
								msg = msg..'\nSupplies prepared for next drop.'
							else
								local squadName = PlayerLogistics.getInfantryName(preped)
								msg = msg..'\n'..squadName..' prepared for next drop.'
							end
						end
					end

					msg = msg..'\n\nPersonnel ready for deployment: '..self.humanResource.current

					trigger.action.outTextForUnit(un:getID(), msg, 10)
				end
			end
		end
	end

	function PlayerLogistics:isCargoDoorOpen(unit)
		if unit then
			local tp = unit:getDesc().typeName
			if tp == "Mi-8MT" then
				if unit:getDrawArgumentValue(86) == 1 then return true end
				if unit:getDrawArgumentValue(38) > 0.85 then return true end
			elseif tp == "UH-1H" then
				if unit:getDrawArgumentValue(43) == 1 then return true end
				if unit:getDrawArgumentValue(44) == 1 then return true end
			elseif tp == "Mi-24P" then
				if unit:getDrawArgumentValue(38) == 1 then return true end
				if unit:getDrawArgumentValue(86) == 1 then return true end
			elseif tp == "CH-47Fbl1" then
				if unit:getDrawArgumentValue(86) > 0.85 then return true end
			elseif tp == "Hercules" then
				if unit:getDrawArgumentValue(1215) == 1 and unit:getDrawArgumentValue(1216) == 1 then return true end
			elseif tp == "UH-60L" then
				if unit:getDrawArgumentValue(401) == 1 then return true end
				if unit:getDrawArgumentValue(402) == 1 then return true end
			elseif tp == "SA342Mistral" then
				if unit:getDrawArgumentValue(34) == 1 then return true end
				if unit:getDrawArgumentValue(38) == 1 then return true end
			elseif tp == "SA342L" then
				if unit:getDrawArgumentValue(34) == 1 then return true end
				if unit:getDrawArgumentValue(38) == 1 then return true end
			elseif tp == "SA342M" then
				if unit:getDrawArgumentValue(34) == 1 then return true end
				if unit:getDrawArgumentValue(38) == 1 then return true end
			elseif tp == "SA342Minigun" then
				if unit:getDrawArgumentValue(34) == 1 then return true end
				if unit:getDrawArgumentValue(38) == 1 then return true end
			elseif tp == "OH-6A" then
                if unit:getDrawArgumentValue(35) >= 0.3 then return true end
                if unit:getDrawArgumentValue(105) >= 0.3 then return true end
                if unit:getDrawArgumentValue(106) >= 0.3 then return true end
                if unit:getDrawArgumentValue(107) >= 0.3 then return true end
                if unit:getDrawArgumentValue(108) >= 0.3 then return true end
                if unit:getDrawArgumentValue(109) >= 0.3 then return true end
                if unit:getDrawArgumentValue(110) >= 0.3 then return true end
			else
				return true
			end
		end
	end

	function PlayerLogistics:unpackSupplies(params, supressNoBoxesMsg, all)
		local groupName = params.group

		local gr = Group.getByName(groupName)
		local un = gr:getUnit(1)
		if un then
			local boxes = {}

			for cname, cdata in pairs(self.trackedBoxes) do
				local cobj = StaticObject.getByName(cname) or Unit.getByName(cname)
				if cobj and cobj:isExist() and Utils.isLanded(cobj) then
					local dist = mist.utils.get3DDist(un:getPoint(), cobj:getPoint())
					if dist < 50  then 
						table.insert(boxes, {data = cdata, obj = cobj, dist = dist})
					end
				end
			end

			table.sort(boxes, function(a,b) return a.dist < b.dist end)

			if not supressNoBoxesMsg and #boxes == 0 then
				trigger.action.outTextForUnit(un:getID(), 'No packed supplies found nearby', 10)
				return
			end

			for _,v in ipairs(boxes) do
				
				local lastLoad = v.data.origin
				if v.data.content then
					local zn = ZoneCommand.getZoneOfPoint(v.obj:getPoint())
					if not zn and v.data.content == PlayerLogistics.buildables.farp then
						zn = FARPCommand.getFARPOfPoint(v.obj:getPoint())
					end

					if zn then
						zn:addResource(v.data.amount)
						zn:refreshText()
					
						trigger.action.outTextForUnit(un:getID(), v.data.amount..' supplies unpacked from '..v.data.name, 10)
					else
						trigger.action.outTextForUnit(un:getID(), 'Unpacked '..v.data.name, 10)

						local name = self:generateBuildingName(v.data.content)

						local p = {
							x = v.obj:getPoint().x,
							y = v.obj:getPoint().z
						}

						Spawner.createObject(name, v.data.content, p, v.obj:getCoalition(), 0, 0, {
							[land.SurfaceType.LAND] = true, 
							[land.SurfaceType.ROAD] = true,
							[land.SurfaceType.RUNWAY] = true
						})

						self.trackedBuildings[name] = { name=name, type=v.data.content }

						if v.data.content == PlayerLogistics.buildables.farp then
							timer.scheduleFunction(function(param, time)
								local f = FARPCommand:new(param.name, 500)
								param.context.trackedBuildings[param.name].farp = f
							end, {name = name, context = self}, timer.getTime()+2)
						else
							timer.scheduleFunction(function(param, time)
								local f = FARPCommand.getFARPOfPoint(param.pos)
								if f then f:refreshFeatures() end
							end, {pos = v.obj:getPoint()}, timer.getTime()+2)
						end
					end
				else
					if v.data.convert then
						local farp = FARPCommand.getFARPOfPoint(v.obj:getPoint())
						if not farp then
							trigger.action.outTextForUnit(un:getID(), 'Can only unpack fuel and ammo crates near a FARP', 10)
							return
						end

						self:unloadToFarp(un, farp, v.data.amount, v.data.convert)
					else
						local zn = ZoneCommand.getZoneOfPoint(v.obj:getPoint())
						if not zn then zn = FARPCommand.getFARPOfPoint(v.obj:getPoint()) end

						if not zn or zn.side ~= un:getCoalition() then
							trigger.action.outTextForUnit(un:getID(), v.data.name..' can only be unpacked within a friendly zone.', 10)
							return
						end

						self:awardSupplyXP(lastLoad, zn, un, v.data.amount)
						zn:addResource(v.data.amount)
						zn:refreshText()
						
						trigger.action.outTextForUnit(un:getID(), v.data.amount..' supplies unpacked from '..v.data.name, 10)
						DependencyManager.get("MissionTracker"):tallyUnpackCrate(un:getPlayerName(), zn.name, v.data)
					end
				end

				v.obj:destroy()
				self.trackedBoxes[v.data.name] = nil

				if not all then	break end
			end
		end
	end
	
	function PlayerLogistics:packSupplies(params)
		local groupName = params.group
		local amount = params.amount
		local content = params.content
		local convert = params.convert
		local free = params.free

		local gr = Group.getByName(groupName)
		local un = gr:getUnit(1)
		if un then
			if Utils.isInAir(un) then
				if free then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload crates while in air.', 10)
				else
					trigger.action.outTextForUnit(un:getID(), 'Can not request crates while in air.', 10)
				end
				return
			end
			
			local zn = ZoneCommand.getZoneOfUnit(un:getName())

			if not zn and not free then 
				zn = FARPCommand.getFARPOfUnit(un:getName())
				if zn and not zn:hasFeature(PlayerLogistics.buildables.forklift) then
					trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Forklift. Can not request crates.', 10)
					return
				end
			end

			if not zn and not free then
				trigger.action.outTextForUnit(un:getID(), 'Can only request crates whithin a friendly zone', 10)
				return
			end
			
			if zn.side ~= un:getCoalition() and not free  then
				trigger.action.outTextForUnit(un:getID(), 'Can only request crates whithin a friendly zone', 10)
				return
			end

			if zn:criticalOnSupplies() and not free  then
				trigger.action.outTextForUnit(un:getID(), 'Can not request crate, zone is low on resources', 10)
				return
			end

			if zn.resource < zn.spendTreshold + amount and not free  then
				trigger.action.outTextForUnit(un:getID(), 'Can not request crate if resources would fall to a critical level.', 10)
				return
			end

			local unitPos = un:getPosition()

			local ahead = 15
			local area = 5

			local vec = {
				x = unitPos.x.x * ahead,
				z = unitPos.x.z * ahead
			}

			local offset = un:getPoint()
			offset.x = offset.x + vec.x
			offset.y = offset.z + vec.z
			offset.z = nil

			offset.x = offset.x + math.random(-area,area)
			offset.y = offset.y + math.random(-area,area)

			local boxcontent = self:getBoxContent(content)

			if convert == 'ammo' then
				boxcontent = 'Munitions'
			elseif convert == 'fuel' then
				boxcontent = 'Fuel'	
			end

			local cname = self:generateCargoName(boxcontent)
			local boxtype = self:getBoxType(amount)
			Spawner.createCrate(cname, boxtype, offset, un:getCoalition(), 1, 15, amount)
			if not free then
				zn:removeResource(amount)
				zn:refreshText()
			end

			self.trackedBoxes[cname] = {name=cname, amount = amount, origin=zn, type=boxtype, lifetime = 5*60*60, content=content, convert=convert}
			trigger.action.outTextForUnit(un:getID(), amount..' supplies packed in '..cname..' ahead of you.', 10)
		end
	end

	function PlayerLogistics:getBoxContent(content)
		local boxcontent = 'Supply'
		if content == PlayerLogistics.buildables.farp then
			boxcontent = "Landing pad"
		elseif content == PlayerLogistics.buildables.ammo then
			boxcontent = "Ammo Cache"
		elseif content == PlayerLogistics.buildables.fuel then
			boxcontent = "Fuel Cache"
		elseif content == PlayerLogistics.buildables.medtent then
			boxcontent = "Field Hospital"
		elseif content == PlayerLogistics.buildables.tent then
			boxcontent = "Command Center"
		elseif content == PlayerLogistics.buildables.generator then
			boxcontent = "Generator"
		elseif content == PlayerLogistics.buildables.radar then
			boxcontent = "Radar"
		elseif content == PlayerLogistics.buildables.satuplink then
			boxcontent = "Sat Uplink"
		elseif content == PlayerLogistics.buildables.forklift then
			boxcontent = "Forklift"
		end

		return boxcontent
	end

	function PlayerLogistics:restoreBox(data)
		Spawner.createCrate(data.name, data.type, data.pos, data.side, 1, 15, data.amount)
		local org = ZoneCommand.getZoneByName(data.origin)
		if not org then 
			org = {
				name='locally sourced', 
				isCarrier=false, 
				zone={ 
					point = {
						x=data.pos.x, 
						z=data.pos.y, 
						y=land.getHeight({ x = data.pos.x, y = data.pos.y }) 
					}
				},
				distToFront = 0
			}
		end
		self.trackedBoxes[data.name] = {name=data.name, amount = data.amount, origin=org, type=data.type, lifetime = data.lifetime, content = data.content, convert=data.convert, isSalvage=data.isSalvage}
	end

	PlayerLogistics.cargotypes = {
		["cargonet"] = {min = 100, max = 10000},
		["barrels"] = {min = 100, max = 480},
		["ammo_box"] = {min = 1000, max = 2000}
	}

	function PlayerLogistics:getBoxType(amount)
		local viable = {}
		for i,v in pairs(PlayerLogistics.cargotypes) do
			if amount <= v.max and amount >= v.min then
				table.insert(viable, i)
			end
		end

		if #viable == 0 then return "cargonet" end

		return viable[math.random(1,#viable)]
	end

	PlayerLogistics.cargoNames = {}
	PlayerLogistics.cargoNames.adjectives = {"Stealthy", "Agile", "Robust", "Tactical", "Strategic", "Armored", "Clandestine", "Swift", "Fortified", "Covert"}
	PlayerLogistics.cargoNames.nouns = {"Supply", "Crate", "Package", "Container", "Shipment", "Depot", "Cache", "Stockpile", "Arsenal", "Cargo"}

	function PlayerLogistics:generateCargoName(content)
        local adjective = self.cargoNames.adjectives[math.random(1,#self.cargoNames.adjectives)]
        local noun = self.cargoNames.nouns[math.random(1,#self.cargoNames.nouns)]

        local cname = adjective..noun..'('..content..')'

        if self.trackedBoxes[cname] then
            for i=1,1000,1 do
                local try = cname..'-'..i
                if not self.trackedBoxes[try] then
                    cname = try
                    break
                end
            end
        end

        if not self.trackedBoxes[cname] then
            return cname
        end
    end

	PlayerLogistics.farpNames = {"Able", "Baker", "Dog", "Easy", "Fox", "George", "How", "Item", "Jig", "King", "Love", "Nan", "Oboe", "Peter", "Queen", "Roger", "Sugar", "Tare", "Uncle", "William", "Yoke", "Zebra"}
	function PlayerLogistics:generateBuildingName(type)

		if type == PlayerLogistics.buildables.farp then
			type = 'FARP'
		end

        local name = self.farpNames[math.random(1,#self.farpNames)]..'('..type..')'

		if self.trackedBuildings[name] then
			for i=1,1000,1 do
				local try = name..'-'..i
				if not self.trackedBuildings[name] then
					name = try
					break
				end
			end
		end

		if not self.trackedBuildings[name] then
			return name
		end
    end

	function PlayerLogistics:loadSupplies(params)
		if not ZoneCommand then return end
		
		local groupName = params.group
		local amount = params.amount
		
		local gr = Group.getByName(groupName)
		if gr then
			local un = gr:getUnit(1)
			if un then
				if not self:canFitCargo(groupName) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load cargo. Personnel or boxes already onboard.', 10)
					return
				end

				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load supplies while in air', 10)
					return
				end
				
				local zn = ZoneCommand.getZoneOfUnit(un:getName())
				if not zn then 
					zn = CarrierCommand.getCarrierOfUnit(un:getName())
				end
				
				if not zn then 
					zn = FARPCommand.getFARPOfUnit(un:getName())
				end

				if not zn then
					trigger.action.outTextForUnit(un:getID(), 'Can only load supplies while within a friendly zone', 10)
					return
				end
				
				if zn.side ~= un:getCoalition() then
					trigger.action.outTextForUnit(un:getID(), 'Can only load supplies while within a friendly zone', 10)
					return
				end

				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not load supplies while cargo door closed', 10)
					return
				end

				if zn:criticalOnSupplies() then
					trigger.action.outTextForUnit(un:getID(), 'Can not load supplies, zone is low on resources', 10)
					return
				end

				if zn.resource < zn.spendTreshold + amount then
					trigger.action.outTextForUnit(un:getID(), 'Can not load supplies if resources would fall to a critical level.', 10)
					return
				end

				local carried = self.carriedCargo[gr:getID()] or 0
				if amount > zn.resource then
					amount = zn.resource
				end
				
				zn:removeResource(amount)
				zn:refreshText()
				self.carriedCargo[gr:getID()] = carried + amount
				self.lastLoaded[gr:getID()] = zn
				local onboard = self.carriedCargo[gr:getID()]
				local weight = self.getWeight(onboard)

				if un:getDesc().typeName == "Hercules" then
					local loadedInCrates = 0
					local ammo = un:getAmmo()
					if ammo then 
						for _,load in ipairs(ammo) do
							if load.desc.typeName == 'weapons.bombs.Generic Crate [20000lb]' then
								loadedInCrates = 9000 * load.count
							end
						end
					end

					local internal = 0
					if weight > loadedInCrates then
						internal = weight - loadedInCrates
					end

					trigger.action.setUnitInternalCargo(un:getName(), internal)
				else
					trigger.action.setUnitInternalCargo(un:getName(), weight)
				end

				trigger.action.outTextForUnit(un:getID(), amount..' supplies loaded', 10)
				trigger.action.outTextForUnit(un:getID(), onboard..' supplies onboard. ('..weight..' kg)', 10)
			end
		end
	end

	function PlayerLogistics:unloadToFarp(playerunit, farp, amount, convert)
		if convert == 'ammo' then
			local divider = 50
			if farp:hasFeature(PlayerLogistics.buildables.ammo) then divider = 25 end

			amount = math.floor(amount/divider)
			WarehouseManager.addAllWeapons(farp.name, amount)
			trigger.action.outTextForUnit(playerunit:getID(), 'FARP supplied with '..amount..' munitions', 10)
		elseif convert == 'fuel' then
			local divider = 1
			if farp:hasFeature(PlayerLogistics.buildables.fuel) then divider = 0.5 end
			amount = math.floor(amount/divider)

			WarehouseManager.addAllFuel(farp.name, amount)
			trigger.action.outTextForUnit(playerunit:getID(), 'FARP supplied with '..amount..'L fuel', 10)
		end
	end

	function PlayerLogistics:unloadSupplies(params)
		if not ZoneCommand then return end
		
		local groupName = params.group
		local amount = params.amount
		local convert = params.convert
		
		local gr = Group.getByName(groupName)
		if gr then
			local un = gr:getUnit(1)
			if un then
				if Utils.isInAir(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload supplies while in air', 10)
					return
				end

				if not self:isCargoDoorOpen(un) then
					trigger.action.outTextForUnit(un:getID(), 'Can not unload supplies while cargo door closed', 10)
					return
				end

				if not self.carriedCargo[gr:getID()] or self.carriedCargo[gr:getID()] == 0 then
					trigger.action.outTextForUnit(un:getID(), 'No supplies loaded', 10)
					return
				end

				local zn = nil
				local farp = nil
				if convert then
					farp = FARPCommand.getFARPOfUnit(un:getName())
					if not farp then
						trigger.action.outTextForUnit(un:getID(), 'Can only unload fuel and ammo while while landed at a FARP', 10)
						return
					end
				else
					zn = ZoneCommand.getZoneOfUnit(un:getName())
					if not zn then 
						zn = CarrierCommand.getCarrierOfUnit(un:getName())
					end

					if not zn then 
						zn = FARPCommand.getFARPOfUnit(un:getName())
					end
					
					if not zn then
						trigger.action.outTextForUnit(un:getID(), 'Can only unload supplies while within a friendly zone', 10)
						return
					end
					
					if zn.side ~= 0 and zn.side ~= un:getCoalition()then
						trigger.action.outTextForUnit(un:getID(), 'Can only unload supplies while within a friendly zone', 10)
						return
					end
				end

				local carried = self.carriedCargo[gr:getID()]
				if amount > carried then
					amount = carried
				end
				
				self.carriedCargo[gr:getID()] = carried-amount

				if convert then
					self:unloadToFarp(un, farp, amount, convert)
				else
					zn:addResource(amount)
					zn:refreshText()

					local lastLoad = self.lastLoaded[gr:getID()]
					self:awardSupplyXP(lastLoad, zn, un, amount)
				end
				
				local onboard = self.carriedCargo[gr:getID()]
				local weight = self.getWeight(onboard)
			
				if un:getDesc().typeName == "Hercules" then
					local loadedInCrates = 0
					local ammo = un:getAmmo()
					for _,load in ipairs(ammo) do
						if load.desc.typeName == 'weapons.bombs.Generic Crate [20000lb]' then
							loadedInCrates = 9000 * load.count
						end
					end

					local internal = 0
					if weight > loadedInCrates then
						internal = weight - loadedInCrates
					end
					
					trigger.action.setUnitInternalCargo(un:getName(), internal)
				else
					trigger.action.setUnitInternalCargo(un:getName(), weight)
				end

				trigger.action.outTextForUnit(un:getID(), amount..' supplies unloaded', 10)
				trigger.action.outTextForUnit(un:getID(), onboard..' supplies remaining onboard. ('..weight..' kg)', 10)
			end
		end
	end

	PlayerLogistics.slingPos = {}
	PlayerLogistics.slingPos['Mi-24P'] = { fwd = -1.0 }
	--PlayerLogistics.slingPos['Mi-8MT'] = { }
	--PlayerLogistics.slingPos['UH-1H'] = { }
	PlayerLogistics.slingPos['UH-60L'] = { fwd = -2}
	PlayerLogistics.slingPos['OH-6A'] = { fwd = -2 }
	--PlayerLogistics.slingPos['CH-47ph'] = { }
end

-----------------[[ END OF PlayerLogistics.lua ]]-----------------



-----------------[[ GroupMonitor.lua ]]-----------------

GroupMonitor = {}
do
	GroupMonitor.blockedDespawnTime = 10*60 --used to despawn aircraft that are stuck taxiing for some reason
	GroupMonitor.landedDespawnTime = 10
	GroupMonitor.atDestinationDespawnTime = 2*60
	GroupMonitor.recoveryReduction = 0.8 -- reduce recovered resource from landed missions by this amount to account for maintenance

	GroupMonitor.siegeExplosiveTime = 5*60 -- how long until random upgrade is detonated in zone
	GroupMonitor.siegeExplosiveStrength = 1000 -- detonation strength

	GroupMonitor.timeBeforeSquadDeploy = 10*60
	GroupMonitor.squadChance = 0.001
	GroupMonitor.ambushChance = 0.7

	GroupMonitor.aiSquads = {
		ambush = {
			[1] = {
				name='ambush-squad-red', 
				type=PlayerLogistics.infantryTypes.ambush,
				weight = 900,
				cost= 300,
				jobtime= 60*60*2,
				extracttime= 0,
				size = 5,
				side = 1,
				isAISpawned = true
			},
			[2] = {
				name='ambush-squad', 
				type=PlayerLogistics.infantryTypes.ambush,
				weight = 900,
				cost= 300,
				jobtime= 60*60,
				extracttime= 60*60,
				size = 5,
				side = 2,
				isAISpawned = true
			},
		},
		manpads = {
			[1] = {
				name='manpads-squad-red',
				type=PlayerLogistics.infantryTypes.manpads, 
				weight = 900,
				cost= 500,
				jobtime= 60*60*2,
				extracttime= 0,
				size = 5, 
				side= 1,
				isAISpawned = true
			},
			[2] = {
				name='manpads-squad',
				type=PlayerLogistics.infantryTypes.manpads, 
				weight = 900,
				cost= 500,
				jobtime= 60*60,
				extracttime= 60*60,
				size = 5, 
				side= 2,
				isAISpawned = true
			}
		},
		assault = {
			[1] = {
				name='assault-squad-red',
				type=PlayerLogistics.infantryTypes.assault, 
				weight = 600,
				cost= 600,
				jobtime= 60*120,
				extracttime= 0,
				size = 6, 
				side= 1,
				isAISpawned = true
			},
			[2] = {
				name='assault-squad',
				type=PlayerLogistics.infantryTypes.assault, 
				weight = 600,
				cost= 600,
				jobtime= 60*120,
				extracttime= 60*60,
				size = 6, 
				side= 2,
				isAISpawned = true
			}
		}
	}

	function GroupMonitor:new()
		local obj = {}
		obj.groups = {}
		obj.supplySpawners = {}
		setmetatable(obj, self)
		self.__index = self
		
		obj:start()

		DependencyManager.register("GroupMonitor", obj)
		return obj
	end

	function GroupMonitor.isAirAttack(misType)
		if misType == ZoneCommand.missionTypes.cas then return true end
		if misType == ZoneCommand.missionTypes.cas_helo then return true end
		if misType == ZoneCommand.missionTypes.strike then return true end
		if misType == ZoneCommand.missionTypes.patrol then return true end
		if misType == ZoneCommand.missionTypes.sead then return true end
	end

	function GroupMonitor.hasWeapons(group)
		for _,un in ipairs(group:getUnits()) do
			local wps = un:getAmmo()
			if wps then
				for _,w in ipairs(wps) do
					if w.desc.category ~= 0 and w.count > 0 then
						return true
					end
				end
			end
		end
	end

	function GroupMonitor:sendHome(trackedGroup)
		if trackedGroup.home == nil then 
			env.info("GroupMonitor - sendHome "..trackedGroup.name..' does not have home set')
			return
		end

		if trackedGroup.returning then return end


		local gr = Group.getByName(trackedGroup.name)
		if gr then
			if trackedGroup.product.missionType == ZoneCommand.missionTypes.cas_helo then
				local hsp = trigger.misc.getZone(trackedGroup.home.name..'-hsp')
				if not hsp then
					hsp = trigger.misc.getZone(trackedGroup.home.name)
				end

				local alt = DependencyManager.get("ConnectionManager"):getHeliAlt(trackedGroup.target.name, trackedGroup.home.name)
				TaskExtensions.landAtPointFromAir(gr, {x=hsp.point.x, y=hsp.point.z}, alt)
			else
				local homeZn = trigger.misc.getZone(trackedGroup.home.name)
				TaskExtensions.landAtAirfield(gr, {x=homeZn.point.x, y=homeZn.point.z})
			end
			
			local cnt = gr:getController()
			cnt:setOption(0,4) -- force ai hold fire
			cnt:setOption(1, 4) -- force reaction on threat to allow abort
			
			trackedGroup.returning = true
			env.info('GroupMonitor - sendHome ['..trackedGroup.name..'] returning home')
		end
	end
	
	function GroupMonitor:registerGroup(product, target, home, savedData)
		self.groups[product.name] = {name = product.name, lastStateTime = timer.getAbsTime(), product = product, target = target, home = home, stuck_marker = 0}

		if savedData and savedData.state and savedData.state ~= 'uninitialized' then
			env.info('GroupMonitor - registerGroup ['..product.name..'] restored state '..savedData.state..' dur:'..savedData.lastStateDuration)
			self.groups[product.name].state = savedData.state
			self.groups[product.name].lastStateTime = timer.getAbsTime() - savedData.lastStateDuration
			self.groups[product.name].spawnedSquad = savedData.spawnedSquad
		end
	end
	
	function GroupMonitor:start()
        local ev = {}
        ev.context = self
        function ev:onEvent(event)
            if not event.initiator or not event.initiator.getName or not event.initiator.getPoint then return end
            if event.id==world.event.S_EVENT_DEAD or event.id==world.event.S_EVENT_CRASH then
				local name = event.initiator:getName()
				if name and self.context.supplySpawners[name] then
					if math.random() <= Config.salvageChance then
						local pos = event.initiator:getPoint()
						local amount = self.context.supplySpawners[name]

						local cname = DependencyManager.get('PlayerLogistics'):generateCargoName("Salvage")
						local ctype = DependencyManager.get('PlayerLogistics'):getBoxType(amount)

						local spos = {
							x = pos.x + math.random(-15,15),
							y = pos.z + math.random(-15,15)
						}

						Spawner.createCrate(cname, ctype, spos, 2, 1, 15, amount)

						local origin = {
							name='locally sourced', 
							isCarrier=false, 
							zone={ point=pos },
							distToFront = 0
						}

						DependencyManager.get('PlayerLogistics').trackedBoxes[cname] = {name=cname, amount = amount, type=ctype, origin = origin, lifetime=60*60*2, isSalvage=true}
					end
				end
			end
        end

		world.addEventHandler(ev)

		timer.scheduleFunction(function(param, time)
			local self = param.context
			
			for i,v in pairs(self.groups) do
				local isDead = false
				if v.product.missionType == 'supply_convoy' or v.product.missionType == 'assault' then
					isDead = self:processSurface(v)
					if isDead then 
						MissionTargetRegistry.removeBaiTarget(v) --safety measure in case group is dead
					end
				else
					isDead = self:processAir(v)
				end
				
				if isDead then
					self.groups[i] = nil
				end
			end
			
			return time+10
		end, {context = self}, timer.getTime()+1)
	end

	function GroupMonitor:getGroup(name)
		return self.groups[name]
	end
	
	function GroupMonitor:processSurface(group) -- states: [started, enroute, atdestination, siege]
		local gr = Group.getByName(group.name)
		if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end
		
		if not group.state then 
			group.state = 'started'
			group.lastStateTime = timer.getAbsTime()
			env.info('GroupMonitor: processSurface ['..group.name..'] starting')
		end
		
		if group.state =='started' then
			if gr then
				local firstUnit = gr:getUnit(1):getName()
				local z = ZoneCommand.getZoneOfUnit(firstUnit)
				if not z then 
					z = CarrierCommand.getCarrierOfUnit(firstUnit)
				end
				
				if not z then
					env.info('GroupMonitor: processSurface ['..group.name..'] is enroute')
					group.state = 'enroute'
					group.lastStateTime = timer.getAbsTime()
					MissionTargetRegistry.addBaiTarget(group)
				elseif timer.getAbsTime() - group.lastStateTime > GroupMonitor.blockedDespawnTime then
					env.info('GroupMonitor: processSurface ['..group.name..'] despawned due to blockage')
					gr:destroy()
					StrategicAI.pushResource(group.product)
					return true
				end
			end
		elseif group.state =='enroute' then
			if gr then
				if group.product.missionType=='supply_convoy' then
					for _,ssu in ipairs(gr:getUnits()) do
						self.supplySpawners[ssu:getName()] = group.product.capacity/gr:getInitialSize()
					end
				end

				local firstUnit = gr:getUnit(1):getName()
				local z = ZoneCommand.getZoneOfUnit(firstUnit)
				if not z then 
					z = CarrierCommand.getCarrierOfUnit(firstUnit)
				end
				
				if z and (z.name==group.target.name or z.name==group.home.name) then
					MissionTargetRegistry.removeBaiTarget(group)
					
					if group.product.missionType == 'supply_convoy' then
						env.info('GroupMonitor: processSurface ['..group.name..'] has arrived at destination')
						group.state = 'atdestination'
						group.lastStateTime = timer.getAbsTime()
						z:capture(gr:getCoalition())
						local percentSurvived = gr:getSize()/gr:getInitialSize()
						local todeliver = math.floor(group.product.capacity * percentSurvived)
						z:addResource(todeliver)
						z:pushMisOfType(group.product.missionType) 
						env.info('GroupMonitor: processSurface ['..group.name..'] has supplied ['..z.name..'] with ['..todeliver..']')
					elseif group.product.missionType == 'assault' then
						if z.side == gr:getCoalition() then
							env.info('GroupMonitor: processSurface ['..group.name..'] has arrived at destination')
							group.state = 'atdestination'
							group.lastStateTime = timer.getAbsTime()
							local percentSurvived = gr:getSize()/gr:getInitialSize()
							z:pushMisOfType(group.product.missionType)
							env.info('GroupMonitor: processSurface ['..z.name..'] has recovered mission ['..group.product.missionType..'] from ['..group.name..']')
						elseif z.side == 0 then
							env.info('GroupMonitor: processSurface ['..group.name..'] has arrived at destination')
							group.state = 'atdestination'
							group.lastStateTime = timer.getAbsTime()
							z:capture(gr:getCoalition())
							env.info('GroupMonitor: processSurface ['..group.name..'] has captured ['..z.name..']')
							z:pushMisOfType(group.product.missionType) 
						elseif z.side ~= gr:getCoalition() and z.side ~= 0  then
							env.info('GroupMonitor: processSurface ['..group.name..'] starting siege')
							group.state = 'siege'
							group.lastStateTime = timer.getAbsTime()
						end
					end
				else
					if group.product.missionType == 'supply_convoy' then
						if not group.returning and group.target and group.target.side ~= group.product.side and group.target.side ~= 0 then
							local supplyPoint = trigger.misc.getZone(group.home.name..'-sp')
							if not supplyPoint then
								supplyPoint = trigger.misc.getZone(group.home.name)
							end
	
							if supplyPoint then 
								group.returning = true
								env.info('GroupMonitor: processSurface ['..group.name..'] returning home')
								TaskExtensions.moveOnRoadToPoint(gr,  {x=supplyPoint.point.x, y=supplyPoint.point.z})
							end
						elseif GroupMonitor.isStuck(group) then
							env.info('GroupMonitor: processSurface ['..group.name..'] is stuck, trying to get unstuck')

							local tgtname = group.target.name
							if group.returning then 
								tgtname = group.home.name
							end

							local supplyPoint = trigger.misc.getZone(tgtname..'-sp')
							if not supplyPoint then
								supplyPoint = trigger.misc.getZone(tgtname)
							end
							TaskExtensions.moveOnRoadToPoint(gr,  {x=supplyPoint.point.x, y=supplyPoint.point.z}, true)
							
							group.unstuck_attempts = group.unstuck_attempts or 0
							group.unstuck_attempts = group.unstuck_attempts + 1

							if group.unstuck_attempts >= 5 then
								env.info('GroupMonitor: processSurface ['..group.name..'] is stuck, trying to get unstuck by teleport')
								group.unstuck_attempts = 0
								local frUnit = gr:getUnit(1)
								local pos = frUnit:getPoint()

								mist.teleportToPoint({
									groupName = group.name,
									action = 'teleport',
									initTasks = false,
									point = {x=pos.x+math.random(-25,25), y=pos.y, z = pos.z+math.random(-25,25)}
								})

								timer.scheduleFunction(function(params, time)
									local group = params.gr
									local tgtname = group.target.name
									if group.returning then 
										tgtname = group.home.name
									end
									local gr = Group.getByName(group.name)
									local supplyPoint = trigger.misc.getZone(tgtname..'-sp')
									if not supplyPoint then
										supplyPoint = trigger.misc.getZone(tgtname)
									end

									TaskExtensions.moveOnRoadToPoint(gr,  {x=supplyPoint.point.x, y=supplyPoint.point.z}, true)
								end, {gr = group}, timer.getTime()+2)
							end
						end
					elseif group.product.missionType == 'assault' then
						local frUnit = gr:getUnit(1)
						if frUnit then
							local skipDetection = false
							if group.lastStarted and (timer.getAbsTime() - group.lastStarted) < (30) then
								skipDetection = true
							else
								group.lastStarted = nil
							end

							local shouldstop = false
							if not skipDetection then
								local controller = frUnit:getController()
								local targets = controller:getDetectedTargets()

								if #targets > 0 then
									for _,tgt in ipairs(targets) do
										if tgt.visible and tgt.object then
											if tgt.object.isExist and tgt.object:isExist() and tgt.object.getCoalition and tgt.object:getCoalition()~=frUnit:getCoalition() and 
												Object.getCategory(tgt.object) == 1 then
												local dist = mist.utils.get3DDist(frUnit:getPoint(), tgt.object:getPoint())
												if dist < 700 then
													if not group.isstopped then
														env.info('GroupMonitor: processSurface ['..group.name..'] stopping to engage targets')
														TaskExtensions.stopAndDisperse(gr)
														group.isstopped = true
														group.lastStopped = timer.getAbsTime()
													end
													shouldstop = true
													break
												end
											end
										end
									end
								end
							end

							if group.lastStopped then
								if (timer.getAbsTime() - group.lastStopped) > (3*60) then
								env.info('GroupMonitor: processSurface ['..group.name..'] override stop, waited too long')
									shouldstop = false
									group.lastStarted = timer.getAbsTime()
								end
							end

							if not shouldstop and group.isstopped then
								env.info('GroupMonitor: processSurface ['..group.name..'] resuming mission')
								local tp = {
									x = group.target.zone.point.x,
									y = group.target.zone.point.z
								}

								TaskExtensions.moveOnRoadToPointAndAssault(gr, tp, group.target.built)
								group.isstopped = false
								group.lastStopped = nil
							end

							if not shouldstop and not group.isstopped then
								if GroupMonitor.isStuck(group) then
									env.info('GroupMonitor: processSurface ['..group.name..'] is stuck, trying to get unstuck')
									local tp = {
										x = group.target.zone.point.x,
										y = group.target.zone.point.z
									}

									TaskExtensions.moveOnRoadToPointAndAssault(gr, tp, group.target.built, true)

									group.unstuck_attempts = group.unstuck_attempts or 0
									group.unstuck_attempts = group.unstuck_attempts + 1

									if group.unstuck_attempts >= 5 then
										env.info('GroupMonitor: processSurface ['..group.name..'] is stuck, trying to get unstuck by teleport')
										group.unstuck_attempts = 0
										local pos = frUnit:getPoint()

										mist.teleportToPoint({
											groupName = group.name,
											action = 'teleport',
											initTasks = false,
											point = {x=pos.x+math.random(-25,25), y=pos.y, z = pos.z+math.random(-25,25)}
										})

										timer.scheduleFunction(function(params, time)
											local group = params.group
											local gr = Group.getByName(gr)
											local tp = {
												x = group.target.zone.point.x,
												y = group.target.zone.point.z
											}
		
											TaskExtensions.moveOnRoadToPointAndAssault(gr, tp, group.target.built, true)
										end, {gr = group}, timer.getTime()+2)
									end
								elseif group.unstuck_attempts and group.unstuck_attempts > 0 then
									group.unstuck_attempts = 0
								end
							end

							if not group.spawnedSquad and group.target:hasEnemyDefense(gr:getCoalition()) then
								local pos = gr:getUnit(1):getPoint()
								local tgdist = mist.utils.get2DDist(pos, group.target.zone.point)
								if tgdist < 500+group.target.zone.radius then
									local squadData = GroupMonitor.aiSquads.assault[gr:getCoalition()]
									local num = math.random(1,3)
									for i=1,num do
										DependencyManager.get("SquadTracker"):spawnInfantry(squadData, pos)
										env.info('GroupMonitor: processSurface ['..group.name..'] has deployed '..squadData.type..' squad')
									end
									group.spawnedSquad = true
								end
							end

							local timeElapsed = timer.getAbsTime() - group.lastStateTime
							if not group.spawnedSquad and timeElapsed > GroupMonitor.timeBeforeSquadDeploy then
								
								local die = math.random()
								if die < GroupMonitor.squadChance then
									local pos = gr:getUnit(1):getPoint()
									local squadData = nil
									if math.random() > GroupMonitor.ambushChance then
										squadData = GroupMonitor.aiSquads.manpads[gr:getCoalition()]
									else
										squadData = GroupMonitor.aiSquads.ambush[gr:getCoalition()]
									end

									DependencyManager.get("SquadTracker"):spawnInfantry(squadData, pos)
									env.info('GroupMonitor: processSurface ['..group.name..'] has deployed '..squadData.type..' squad')
									group.spawnedSquad = true
								end
							end
						end
					end
				end
			end
		elseif group.state == 'atdestination' then
			if timer.getAbsTime() - group.lastStateTime > GroupMonitor.atDestinationDespawnTime then
				
				if gr then
					local firstUnit = gr:getUnit(1):getName()
					local z = ZoneCommand.getZoneOfUnit(firstUnit)
					if not z then 
						z = CarrierCommand.getCarrierOfUnit(firstUnit)
					end
					if z and z.side == 0 then
						env.info('GroupMonitor: processSurface ['..group.name..'] is at neutral zone')
						z:capture(gr:getCoalition())
						env.info('GroupMonitor: processSurface ['..group.name..'] has captured ['..z.name..']')
					else
						env.info('GroupMonitor: processSurface ['..group.name..'] starting siege')
						group.state = 'siege'
						group.lastStateTime = timer.getAbsTime()
					end

					env.info('GroupMonitor: processSurface ['..group.name..'] despawned after arriving at destination')
					gr:destroy()
					return true
				end
			end
		elseif group.state == 'siege' then
			if group.product.missionType ~= 'assault' then 
				group.state = 'atdestination'
				group.lastStateTime = timer.getAbsTime()
			else
				if timer.getAbsTime() - group.lastStateTime > GroupMonitor.siegeExplosiveTime then
					if gr then
						local firstUnit = gr:getUnit(1):getName()
						local z = ZoneCommand.getZoneOfUnit(firstUnit)
						local success = false
						
						if z then
							for i,v in pairs(z.built) do
								if v.type == 'upgrade' and v.side ~= gr:getCoalition() then
									local st = StaticObject.getByName(v.name)
									if not st then st = Group.getByName(v.name) end
									local pos = st:getPoint()
									trigger.action.explosion(pos, GroupMonitor.siegeExplosiveStrength)
									group.lastStateTime = timer.getAbsTime()
									success = true
									env.info('GroupMonitor: processSurface ['..group.name..'] detonating structure at '..z.name)
									--trigger.action.outTextForCoalition(z.side, z.name..' is under attack by ground forces', 10)
									
									if z.side == 2 then
										local sourcePos = {
											x = z.zone.point.x,
											y = 9144,
											z = z.zone.point.z,
										}

										if math.random()>0.5 then
											TransmissionManager.queueMultiple({'zones.names.'..z.name, 'zones.events.underattack.1'}, TransmissionManager.radios.command, sourcePos)
										else
											TransmissionManager.queueMultiple({'zones.events.underattack.2','zones.names.'..z.name}, TransmissionManager.radios.command, sourcePos)
										end
									end

									break
								end
							end
						end

						if not success then
							env.info('GroupMonitor: processSurface ['..group.name..'] no targets to detonate, switching to atdestination')
							group.state = 'atdestination'
							group.lastStateTime = timer.getAbsTime()
						end
					end
				end
			end
		end
	end

	function GroupMonitor.isStuck(group)
		if Config.disableUnstuck then return false end
		
		local gr = Group.getByName(group.name)
		if not gr then return false end
		if gr:getSize() == 0 then return false end

		local un = gr:getUnit(1)
		if un and un:isExist() and mist.vec.mag(un:getVelocity()) >= 0.01 and group.stuck_marker > 0 then
			group.stuck_marker = 0
			group.unstuck_attempts = 0
			env.info('GroupMonitor: isStuck ['..group.name..'] is moving, reseting stuck marker velocity='..mist.vec.mag(un:getVelocity()))
		end

		if un and un:isExist() and mist.vec.mag(un:getVelocity()) < 0.01 then
			group.stuck_marker = group.stuck_marker + 1
			env.info('GroupMonitor: isStuck ['..group.name..'] is not moving, increasing stuck marker to '..group.stuck_marker..' velocity='..mist.vec.mag(un:getVelocity()))

			if group.stuck_marker >= 3 then
				group.stuck_marker = 0
				env.info('GroupMonitor: isStuck ['..group.name..'] is stuck')
				return true
			end
		end

		return false
	end
	
	function GroupMonitor:processAir(group)-- states: [takeoff, inair, landed]
		local gr = Group.getByName(group.name)
		if not gr then return true end
		if not gr:isExist() or gr:getSize()==0 then 
			gr:destroy()
			return true
		end
		--[[
		if group.product.missionType == 'cas' or group.product.missionType == 'cas_helo' or group.product.missionType == 'strike' or group.product.missionType == 'sead' then
			if MissionTargetRegistry.isZoneTargeted(group.target) and group.product.side == 2 and not group.returning then 
				env.info('GroupMonitor - mission ['..group.name..'] to ['..group.target..'] canceled due to player mission')

				GroupMonitor.sendHome(group)
			end
		end
		]]--
		
		if not group.state then 
			group.state = 'takeoff' 
			env.info('GroupMonitor: processAir ['..group.name..'] taking off')
		end
		
		if group.state =='takeoff' then
			if timer.getAbsTime() - group.lastStateTime > GroupMonitor.blockedDespawnTime then
				if gr and gr:getSize()>0 and gr:getUnit(1) and gr:getUnit(1):isExist() then
					local frUnit = gr:getUnit(1)
					local cz = CarrierCommand.getCarrierOfUnit(frUnit:getName())
					if Utils.allGroupIsLanded(gr, cz ~= nil) then
						env.info('GroupMonitor: processAir ['..group.name..'] is blocked, despawning')
						local frUnit = gr:getUnit(1)
						if frUnit then
							local firstUnit = frUnit:getName()
							local z = ZoneCommand.getZoneOfUnit(firstUnit)
							if not z then 
								z = CarrierCommand.getCarrierOfUnit(firstUnit)
							end
							if z then
								StrategicAI.pushResource(group.product)
								env.info('GroupMonitor: processAir ['..z.name..'] has recovered resource from ['..group.name..']')
							end
						end

						gr:destroy()
						return true
					end
				end
			elseif gr and Utils.someOfGroupInAir(gr) then
				env.info('GroupMonitor: processAir ['..group.name..'] is in the air')
				group.state = 'inair'
				group.lastStateTime = timer.getAbsTime()
			end
		elseif group.state =='inair' then
			if gr then
				if group.product.missionType=='supply_air' then
					for _,ssu in ipairs(gr:getUnits()) do
						self.supplySpawners[ssu:getName()] = group.product.capacity/gr:getInitialSize()
					end
				end

				local unit = gr:getUnit(1)
				if not unit or not unit.isExist or not unit:isExist() then return end
				
				local cz = CarrierCommand.getCarrierOfUnit(unit:getName())
				if Utils.allGroupIsLanded(gr, cz ~= nil) then
					env.info('GroupMonitor: processAir ['..group.name..'] has landed')
					group.state = 'landed'
					group.lastStateTime = timer.getAbsTime()

					if unit then
						local firstUnit = unit:getName()
						local z = ZoneCommand.getZoneOfUnit(firstUnit)
						if not z then 
							z = CarrierCommand.getCarrierOfUnit(firstUnit)
						end
						
						if group.product.missionType == 'supply_air' then
							if z then
								z:capture(gr:getCoalition())
								z:addResource(group.product.capacity)
								z:pushMisOfType(group.product.missionType) 
								env.info('GroupMonitor: processAir ['..group.name..'] has supplied ['..z.name..'] with ['..group.product.capacity..']')
							end
						else
							if z and z.side == gr:getCoalition() then
								local percentSurvived = gr:getSize()/gr:getInitialSize()
								local torecover = math.floor(group.product.cost * percentSurvived * GroupMonitor.recoveryReduction)
								z:pushMisOfType(group.product.missionType) 
								env.info('GroupMonitor: processAir ['..z.name..'] has recovered product ['..group.product.missionType..'] from ['..group.name..']')
							end
						end
					else
						env.info('GroupMonitor: processAir ['..group.name..'] size ['..gr:getSize()..'] has no unit 1')
					end
				else
					if GroupMonitor.isAirAttack(group.product.missionType) and not group.returning then
						if not GroupMonitor.hasWeapons(gr) then
							env.info('GroupMonitor: processAir ['..group.name..'] size ['..gr:getSize()..'] has no weapons outside of shells')
							self:sendHome(group)
						elseif group.product.missionType == ZoneCommand.missionTypes.cas_helo then 
							local frUnit = gr:getUnit(1)
							local controller = frUnit:getController()
							local targets = controller:getDetectedTargets()

							local tgtToEngage = {}
							if #targets > 0 then
								for _,tgt in ipairs(targets) do
									if tgt.visible and tgt.object and tgt.object.isExist and tgt.object:isExist() then
										if Object.getCategory(tgt.object) == Object.Category.UNIT and 
											tgt.object.getCoalition and tgt.object:getCoalition()~=frUnit:getCoalition() and 
											Unit.getCategoryEx(tgt.object) == Unit.Category.GROUND_UNIT then

											local dist = mist.utils.get3DDist(frUnit:getPoint(), tgt.object:getPoint())
											if dist < 2000 then
												table.insert(tgtToEngage, tgt.object)
											end
										end
									end
								end
							end

							if not group.isengaging and #tgtToEngage > 0 then
								env.info('GroupMonitor: processAir ['..group.name..'] engaging targets')
								TaskExtensions.heloEngageTargets(gr, tgtToEngage, group.product.expend)
								group.isengaging = true
								group.startedEngaging = timer.getAbsTime()
							elseif group.isengaging and #tgtToEngage == 0 and group.startedEngaging and (timer.getAbsTime() - group.startedEngaging) > 60*5 then
								env.info('GroupMonitor: processAir ['..group.name..'] resuming mission')
								if group.returning then
									group.returning = nil
									self:sendHome(group)
								else
									if group.target then
										local homePos = group.home.zone.point
										TaskExtensions.executeHeloCasMission(gr, group.target.built, group.product.expend, group.product.altitude, {homePos = homePos})
									end
								end
								group.isengaging = false
							end
						end
					elseif group.product.missionType == 'supply_air' then
						if not group.returning and group.target and group.target.side ~= group.product.side and group.target.side ~= 0 then
							local supplyPoint = trigger.misc.getZone(group.home.name..'-hsp')
							if not supplyPoint then
								supplyPoint = trigger.misc.getZone(group.home.name)
							end

							if supplyPoint then 
								group.returning = true
								local alt = DependencyManager.get("ConnectionManager"):getHeliAlt(group.target.name, group.home.name)
								TaskExtensions.landAtPointFromAir(gr,  {x=supplyPoint.point.x, y=supplyPoint.point.z}, alt)
								env.info('GroupMonitor: processAir ['..group.name..'] returning home')
							end
						end
					end
				end
			end
		elseif group.state =='landed' then
			if timer.getAbsTime() - group.lastStateTime > GroupMonitor.landedDespawnTime then
				if gr then
					env.info('GroupMonitor: processAir ['..group.name..'] despawned after landing')
					gr:destroy()
					return true
				end
			end
		end
	end
end

-----------------[[ END OF GroupMonitor.lua ]]-----------------



-----------------[[ ConnectionManager.lua ]]-----------------

ConnectionManager = {}
do
	ConnectionManager.currentLineIndex = 5000
	function ConnectionManager:new()
		local obj = {}
		obj.connections = {}
		obj.zoneConnections = {}
		obj.heliAlts = {}
		obj.blockedRoads = {}
		setmetatable(obj, self)
		self.__index = self

		DependencyManager.register("ConnectionManager", obj)
		return obj
	end

	function ConnectionManager:addConnection(f, t, blockedRoad, heliAlt)
		local i = ConnectionManager.currentLineIndex
		ConnectionManager.currentLineIndex = ConnectionManager.currentLineIndex + 1
		
		table.insert(self.connections, {from=f, to=t, index=i})
		self.zoneConnections[f] = self.zoneConnections[f] or {}
		self.zoneConnections[t] = self.zoneConnections[t] or {}
		self.zoneConnections[f][t] = true
		self.zoneConnections[t][f] = true
		
		if heliAlt then
			self.heliAlts[f] = self.heliAlts[f] or {}
			self.heliAlts[t] = self.heliAlts[t] or {}
			self.heliAlts[f][t] = heliAlt
			self.heliAlts[t][f] = heliAlt
		end

		if blockedRoad then
			self.blockedRoads[f] = self.blockedRoads[f] or {}
			self.blockedRoads[t] = self.blockedRoads[t] or {}
			self.blockedRoads[f][t] = true
			self.blockedRoads[t][f] = true
		end

		local from = CustomZone:getByName(f)
		local to = CustomZone:getByName(t)

		if not from then env.info("ConnectionManager - addConnection: missing zone "..f) end
		if not to then env.info("ConnectionManager - addConnection: missing zone "..t) end
		
		if blockedRoad then
			trigger.action.lineToAll(-1, i, from.point, to.point, {1,1,1,0.5}, 3)
		else
			trigger.action.lineToAll(-1, i, from.point, to.point, {1,1,1,0.5}, 2)
		end
	end
	
	function ConnectionManager:getConnectionsOfZone(zonename)
		if not self.zoneConnections[zonename] then return {} end
		
		local connections = {}
		for i,v in pairs(self.zoneConnections[zonename]) do
			table.insert(connections, i)
		end
		
		return connections
	end

	function ConnectionManager:isRoadBlocked(f,t)
		if self.blockedRoads[f] then 
			return self.blockedRoads[f][t]
		end

		if self.blockedRoads[t] then 
			return self.blockedRoads[t][f]
		end
	end

	function ConnectionManager:getHeliAltSimple(f,t)
		if self.heliAlts[f] then 
			if self.heliAlts[f][t] then
				return self.heliAlts[f][t]
			end
		end

		if self.heliAlts[t] then 
			if self.heliAlts[t][f] then
				return self.heliAlts[t][f]
			end
		end
	end

	function ConnectionManager:getHeliAlt(f,t)
		local alt = self:getHeliAltSimple(f,t)
		if alt then return alt end

		if self.heliAlts[f] then 
			local max = -1
			for zn,_ in pairs(self.heliAlts[f]) do
				local alt = self:getHeliAltSimple(f, zn)
				if alt then
					if alt > max then
						max = alt
					end
				end

				alt = self:getHeliAltSimple(zn, t)
				if alt then
					if alt > max then
						max = alt
					end
				end
			end
			
			if max > 0 then return max end
		end

		if self.heliAlts[t] then 
			local max = -1
			for zn,_ in pairs(self.heliAlts[t]) do
				local alt = self:getHeliAltSimple(t, zn)
				if alt then
					if alt > max then
						max = alt
					end
				end

				alt = self:getHeliAltSimple(zn, f)
				if alt then
					if alt > max then
						max = alt
					end
				end
			end

			if max > 0 then return max end
		end
	end
end

-----------------[[ END OF ConnectionManager.lua ]]-----------------



-----------------[[ TaskExtensions.lua ]]-----------------

TaskExtensions = {}
do
	function TaskExtensions.getAttackTask(targetName, expend, altitude)
		local tgt = Group.getByName(targetName)
		if tgt then
			return { 
				id = 'AttackGroup', 
				params = { 
					groupId = tgt:getID(),
					expend = expend,
					weaponType = Weapon.flag.AnyWeapon,
					groupAttack = true,
					altitudeEnabled = (altitude ~= nil),
					altitude = altitude
				} 
			}
		else
			tgt = StaticObject.getByName(targetName)
			if not tgt then tgt = Unit.getByName(targetName) end
			if tgt then
				return { 
					id = 'AttackUnit', 
					params = { 
						unitId = tgt:getID(),
						expend = expend,
						weaponType = Weapon.flag.AnyWeapon,
						groupAttack = true,
						altitudeEnabled = (altitude ~= nil),
						altitude = altitude
					} 
				}
			end
		end
	end

	function TaskExtensions.getTargetPos(targetName)
		local tgt = StaticObject.getByName(targetName)
		if not tgt then tgt = Unit.getByName(targetName) end
		if tgt then
			return tgt:getPoint()
		end
	end

	function TaskExtensions.getDefaultWaypoints(startPos, task, tgpos, reactivated, landUnitID)
		local defwp = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if reactivated then
			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = reactivated.currentPos.x,
				y = reactivated.currentPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = 4572,
				alt_type = AI.Task.AltitudeType.BARO, 
				task = task
			})
		else
			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})

			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = 4572,
				alt_type = AI.Task.AltitudeType.BARO, 
				task = task
			})
		end

		if tgpos then
			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = tgpos.x,
				y = tgpos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = 4572,
				alt_type = AI.Task.AltitudeType.BARO,
				task = task
			})
		end

		if landUnitID then
			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				linkUnit = landUnitID,
				helipadId = landUnitID,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		else
			table.insert(defwp.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		end

		return defwp
	end

	function TaskExtensions.executeSeadMission(group,targets, expend, altitude, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local expCount = AI.Task.WeaponExpend.ALL
		if expend then
			expCount = expend
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local viable = {}
		for i,v in pairs(targets) do
			if v.type == 'defense' and v.side ~= group:getCoalition() then
				local gr = Group.getByName(v.name)
				for _,unit in ipairs(gr:getUnits()) do
					if unit:hasAttribute('SAM SR') or unit:hasAttribute('SAM TR') then
						table.insert(viable, unit:getName())
					end
				end
			end
		end

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
					{ 
						id = 'EngageTargets', 
						params = {  
						  targetTypes = {'SAM SR', 'SAM TR'}
						} 
					}
				}
			}
		}

		for i,v in ipairs(viable) do
			local task = TaskExtensions.getAttackTask(v, expCount, alt)
			table.insert(attack.params.tasks, task)
		end

		local firstunitpos = nil
		local tgt = viable[1]
		if tgt then 
			firstunitpos = Unit.getByName(tgt):getPoint()
		end
		
		local mis = TaskExtensions.getDefaultWaypoints(startPos, attack, firstunitpos, reactivated, landUnitID)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.overFlyPointAndReturn(group, targetPos, altitude, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local mis = TaskExtensions.getDefaultWaypoints(startPos, nil, targetPos, reactivated, landUnitID)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAA(group)
	end

	function TaskExtensions.executeStrikeMission(group, targets, expend, altitude, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local expCount = AI.Task.WeaponExpend.ALL
		if expend then
			expCount = expend
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
				}
			}
		}

		for i,v in pairs(targets) do
			if v.type == 'upgrade' and v.side ~= group:getCoalition() then
				local task = TaskExtensions.getAttackTask(v.name, expCount, alt)
				table.insert(attack.params.tasks, task)
			end
		end

		local mis = TaskExtensions.getDefaultWaypoints(startPos, attack, nil, reactivated, landUnitID)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.executePinpointStrikeMission(group, targetPos, expend, altitude, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local expCount = AI.Task.WeaponExpend.ALL
		if expend then
			expCount = expend
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local attack = {
			id = 'Bombing', 
			params = { 
				point = {
					x = targetPos.x, 
					y = targetPos.z
				},
				attackQty = 1,
				weaponType = Weapon.flag.AnyBomb,
				expend = expCount,
				groupAttack = true, 
				altitude = alt,
				altitudeEnabled = (altitude ~= nil),
			} 
		}

		local diff = {
			x = targetPos.x - startPos.x,
			z = targetPos.z - startPos.z
		}

		local tp = {
			x = targetPos.x - diff.x*0.5,
			z = targetPos.z - diff.z*0.5
		}

		local mis = TaskExtensions.getDefaultWaypoints(startPos, attack, tp, reactivated, landUnitID)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.executeCasMission(group, targets, expend, altitude, reactivated)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
				}
			}
		}

		local expCount = AI.Task.WeaponExpend.ONE
		if expend then
			expCount = expend
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		for i,v in pairs(targets) do
			if v.type == 'defense' then
				local g = Group.getByName(i)
				if g and g:getCoalition()~=group:getCoalition() then
					local task = TaskExtensions.getAttackTask(i, expCount, alt)
					table.insert(attack.params.tasks, task)
				end
			end
		end

		local mis = TaskExtensions.getDefaultWaypoints(startPos, attack, nil, reactivated)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.executeBaiMission(group, targets, expend, altitude, reactivated)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
					{ 
						id = 'EngageTargets', 
						params = {  
						  targetTypes = {'Vehicles'}
						} 
					}
				}
			}
		}

		local expCount = AI.Task.WeaponExpend.ONE
		if expend then
			expCount = expend
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		for i,v in pairs(targets) do
			if v.type == 'mission' and (v.missionType == 'assault' or v.missionType == 'supply_convoy') then
				local g = Group.getByName(i)
				if g and g:getSize()>0 and g:getCoalition()~=group:getCoalition() then
					local task = TaskExtensions.getAttackTask(i, expCount, alt)
					table.insert(attack.params.tasks, task)
				end
			end
		end

		local mis = TaskExtensions.getDefaultWaypoints(startPos, attack, nil, reactivated)

		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.heloEngageTargets(group, targets, expend)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
				}
			}
		}

		local expCount = AI.Task.WeaponExpend.ONE
		if expend then
			expCount = expend
		end
		
		for i,v in pairs(targets) do
			local task = { 
				id = 'AttackUnit', 
				params = { 
					unitId = v:getID(),
					expend = expend,
					weaponType = Weapon.flag.AnyWeapon,
					groupAttack = true
				} 
			}

			table.insert(attack.params.tasks, task)
		end

		group:getController():pushTask(attack)
	end

	function TaskExtensions.executeHeloCasMission(group, targets, expend, altitude, reactivated)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
				}
			}
		}

		local expCount = AI.Task.WeaponExpend.ONE
		if expend then
			expCount = expend
		end
		
		local alt = 61
		if altitude then
			alt = altitude/3.281
		end

		for i,v in pairs(targets) do
			if v.type == 'defense' then
				local g = Group.getByName(i)
				if g and g:getCoalition()~=group:getCoalition() then
					local task = TaskExtensions.getAttackTask(i, expCount, alt)
					table.insert(attack.params.tasks, task)
				end
			end
		end

		local land = {
			id='Land',
			params = {
				point = {x = startPos.x, y=startPos.z},
				x = startPos.x,
				y = startPos.z,
				--combatLandingFlag = true
			}
		}

		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if reactivated then
			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = reactivated.currentPos.x+1000,
				y = reactivated.currentPos.z+1000,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = alt,
				alt_type = AI.Task.AltitudeType.RADIO, 
				task = attack
			})
		else
			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO,
			})

			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = startPos.x+1000,
				y = startPos.z+1000,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = alt,
				alt_type = AI.Task.AltitudeType.RADIO, 
				task = attack
			})
		end

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = startPos.x,
			y = startPos.z,
			speed = 257,
			action = AI.Task.TurnMethod.FIN_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.RADIO, 
			task = land
		})
		
		group:getController():setTask(mis)
		TaskExtensions.setDefaultAG(group)
	end

	function TaskExtensions.executeTankerMission(group, point, altitude, frequency, tacan, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()
		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local freq = 259500000
		if frequency then
			freq = math.floor(frequency*1000000)
		end

		local setfreq = {
			id = 'SetFrequency', 
			params = { 
				frequency = freq,
				modulation = 0
			} 
		}

		local setbeacon = {
			id = 'ActivateBeacon', 
			params = { 
				type = 4, -- TACAN type
				system = 4, -- Tanker TACAN
				name = 'tacan task', 
				callsign = group:getUnit(1):getCallsign():sub(1,3), 
				frequency = tacan,
				AA = true,
				channel = tacan,
				bearing = true,
				modeChannel = "X"
			} 
		}

		local distFromPoint = 20000
		local theta = math.random() * 2 * math.pi
  
		local dx = distFromPoint * math.cos(theta)
		local dy = distFromPoint * math.sin(theta)

		local pos1 = {
			x = point.x + dx,
			y = point.z + dy
		}

		local pos2 = {
			x = point.x - dx,
			y = point.z - dy
		}

		local orbit_speed = 97
		local travel_speed = 450

		local orbit = { 
			id = 'Orbit', 
			params = { 
				pattern = AI.Task.OrbitPattern.RACE_TRACK,
				point = pos1,
   				point2 = pos2,
				speed = orbit_speed,
				altitude = alt
			}
		}

		local script = {
			id = "WrappedAction",
			params = {
				action = {
					id = "Script",
					params = 
					{
						command = "trigger.action.outTextForCoalition("..group:getCoalition()..", 'Tanker on station. "..(freq/1000000).." AM', 15)",
					}
				}
			}
		}

		local tanker = {
			id = 'Tanker', 
			params = { 
			}
		}

		local task = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}
			}
		}

		if reactivated then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = pos1.x,
				y = pos1.y,
				speed = travel_speed,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = alt,
				alt_type = AI.Task.AltitudeType.BARO,
				task = tanker
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO,
				task = tanker
			})
		end

		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = pos1.x,
			y = pos1.y,
			speed = orbit_speed,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO,
			task = {
				id = 'ComboTask',
				params = {
					tasks = {
						script
					}
				}
			}
		})

		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = pos2.x,
			y = pos2.y,
			speed = orbit_speed,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO,
			task = {
				id = 'ComboTask',
				params = {
					tasks = {
						orbit
					}
				}
			}
		})

		if landUnitID then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				linkUnit = landUnitID,
				helipadId = landUnitID,
				x = startPos.x,
				y = startPos.z,
				speed = travel_speed,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				x = startPos.x,
				y = startPos.z,
				speed = travel_speed,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		end
			
		group:getController():setTask(task)
		group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.PASSIVE_DEFENCE)
		group:getController():setCommand(setfreq)
		group:getController():setCommand(setbeacon)
	end

	function TaskExtensions.executeAwacsMission(group, point, altitude, frequency, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()
		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local freq = 259500000
		if frequency then
			freq = math.floor(frequency*1000000)
		end

		local setfreq = {
			id = 'SetFrequency', 
			params = { 
				frequency = freq,
				modulation = 0
			} 
		}

		local distFromPoint = 10000
		local theta = math.random() * 2 * math.pi
  
		local dx = distFromPoint * math.cos(theta)
		local dy = distFromPoint * math.sin(theta)

		local pos1 = {
			x = point.x + dx,
			y = point.z + dy
		}

		local pos2 = {
			x = point.x - dx,
			y = point.z - dy
		}

		local orbit = { 
			id = 'Orbit', 
			params = { 
				pattern = AI.Task.OrbitPattern.RACE_TRACK,
				point = pos1,
   				point2 = pos2,
				altitude = alt
			}
		}

		local script = {
			id = "WrappedAction",
			params = {
				action = {
					id = "Script",
					params = 
					{
						command = "trigger.action.outTextForCoalition("..group:getCoalition()..", 'AWACS on station. "..(freq/1000000).." AM', 15)",
					}
				}
			}
		}


		local awacs = {
			id = 'ComboTask',
			params = {
				tasks = {
					{
						id = "WrappedAction",
						params = 
						{
							action = 
							{
								id = "EPLRS",
								params = {
									value = true,
									groupId = group:getID(),
								}
							}
						}
					},
					{
						id = 'AWACS', 
						params = { 
						}	
					}
				}
			}
		}

		local task = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if reactivated then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = pos1.x,
				y = pos1.y,
				speed = 257,
				action = AI.Task.TurnMethod.FLY_OVER_POINT,
				alt = alt,
				alt_type = AI.Task.AltitudeType.BARO,
				task = awacs
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO,
				task = awacs
			})
		end
			
		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = pos1.x,
			y = pos1.y,
			speed = 257,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO,
			task = {
				id = 'ComboTask',
				params = {
					tasks = {
						script
					}
				}
			}
		})

		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = pos2.x,
			y = pos2.y,
			speed = 257,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO,
			task = {
				id = 'ComboTask',
				params = {
					tasks = {
						orbit
					}
				}
			}
		})

		if landUnitID then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				linkUnit = landUnitID,
				helipadId = landUnitID,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		end
		
		group:getController():setTask(task)
		group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.PASSIVE_DEFENCE)
		group:getController():setCommand(setfreq)
	end
	
	function TaskExtensions.executePatrolMission(group, point, altitude, range, reactivated, landUnitID)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		if reactivated then
			reactivated.currentPos = startPos
			startPos = reactivated.homePos
		end

		local rng = 25 * 1852
		if range then
			rng = range * 1852
		end
		
		local alt = 4572
		if altitude then
			alt = altitude/3.281
		end

		local search = { 
			id = 'EngageTargets',
			params = {
				maxDist = rng,
				targetTypes = { 'Planes', 'Helicopters' }
			} 
		}

		local distFromPoint = 10000
		local theta = math.random() * 2 * math.pi
  
		local dx = distFromPoint * math.cos(theta)
		local dy = distFromPoint * math.sin(theta)

		local p1 = {
			x = point.x + dx,
			y = point.z + dy
		}

		local p2 = {
			x = point.x - dx,
			y = point.z - dy
		}

		local orbit = {
			id = 'Orbit',
			params = {
				pattern = AI.Task.OrbitPattern.RACE_TRACK,
				point = p1,
				point2 = p2,
				speed = 154,
				altitude = alt
			}
		}

		local task = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if not reactivated then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO,
				task = search
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = reactivated.currentPos.x,
				y = reactivated.currentPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = alt,
				alt_type = AI.Task.AltitudeType.BARO,
				task = search
			})
		end

		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = p1.x,
			y = p1.y,
			speed = 257,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO
		})

		table.insert(task.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = p2.x,
			y = p2.y,
			speed = 257,
			action = AI.Task.TurnMethod.FLY_OVER_POINT,
			alt = alt,
			alt_type = AI.Task.AltitudeType.BARO,
			task = orbit
		})

		if landUnitID then
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				linkUnit = landUnitID,
				helipadId = landUnitID,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		else
			table.insert(task.params.route.points, {
				type= AI.Task.WaypointType.LAND,
				x = startPos.x,
				y = startPos.z,
				speed = 257,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = 0,
				alt_type = AI.Task.AltitudeType.RADIO
			})
		end
		
		group:getController():setTask(task)
		TaskExtensions.setDefaultAA(group)
	end

	function TaskExtensions.setDefaultAA(group)
		group:getController():setOption(AI.Option.Air.id.PROHIBIT_AG, true)
		group:getController():setOption(AI.Option.Air.id.JETT_TANKS_IF_EMPTY, true)
		group:getController():setOption(AI.Option.Air.id.PROHIBIT_JETT, true)
		group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.EVADE_FIRE)
		group:getController():setOption(AI.Option.Air.id.MISSILE_ATTACK, AI.Option.Air.val.MISSILE_ATTACK.MAX_RANGE)

		local weapons = 268402688  -- AnyMissile
		group:getController():setOption(AI.Option.Air.id.RTB_ON_OUT_OF_AMMO, weapons)
	end

	function TaskExtensions.setDefaultAG(group)
		--group:getController():setOption(AI.Option.Air.id.PROHIBIT_AA, true)
		group:getController():setOption(AI.Option.Air.id.JETT_TANKS_IF_EMPTY, true)
		group:getController():setOption(AI.Option.Air.id.PROHIBIT_JETT, true)
		group:getController():setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.EVADE_FIRE)

		local weapons = 2147485694 + 30720 + 4161536 -- AnyBomb + AnyRocket + AnyASM
		group:getController():setOption(AI.Option.Air.id.RTB_ON_OUT_OF_AMMO, weapons)
	end

	function TaskExtensions.stopAndDisperse(group)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local pos = group:getUnit(1):getPoint()
		group:getController():setTask({
			id='Mission',
			params = {
				route = {
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = pos.x,
							y = pos.z,
							speed = 1000,
							action = AI.Task.VehicleFormation.OFF_ROAD
						},
						[2] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = pos.x+math.random(25),
							y = pos.z+math.random(25),
							speed = 1000,
							action = AI.Task.VehicleFormation.DIAMOND
						},
					}
				}  
			}
        })
	end

	function TaskExtensions.moveOnRoadToPointAndAssault(group, point, targets, detour)
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local srx, sry = land.getClosestPointOnRoads('roads', startPos.x, startPos.z)
		local erx, ery = land.getClosestPointOnRoads('roads', point.x, point.y)

		local mis = {
			id='Mission',
			params = {
				route = {
					points = {}
				}  
			}
		}

		if detour then
			local detourPoint = {x = startPos.x, y = startPos.z}

			local direction = {
				x = erx - startPos.x,
				y = ery - startPos.y
			}

			local magnitude = (direction.x^2 + direction.y^2) ^ 0.5
			if magnitude > 0.0 then
				direction.x = direction.x / magnitude
				direction.y = direction.y / magnitude

				local scale = math.random(250,500)
				direction.x = direction.x * scale
				direction.y = direction.y * scale

				detourPoint.x = detourPoint.x + direction.x
				detourPoint.y = detourPoint.y + direction.y
			else
				detourPoint.x = detourPoint.x + math.random(-500,500)
				detourPoint.y = detourPoint.y + math.random(-500,500)
			end
				
			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = detourPoint.x,
				y = detourPoint.y,
				speed = 1000,
				action = AI.Task.VehicleFormation.OFF_ROAD
			})

			srx, sry = land.getClosestPointOnRoads('roads', detourPoint.x, detourPoint.y)
		end

		
		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = srx,
			y = sry,
			speed = 1000,
			action = AI.Task.VehicleFormation.ON_ROAD
		})

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = erx,
			y = ery,
			speed = 1000,
			action = AI.Task.VehicleFormation.ON_ROAD
		})

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = point.x,
			y = point.y,
			speed = 1000,
			action = AI.Task.VehicleFormation.DIAMOND
		})
	

		for i,v in pairs(targets) do
			if v.type == 'defense' then
				local group = Group.getByName(v.name)
				if group then
					for i,v in ipairs(group:getUnits()) do
						local unpos = v:getPoint()
						local pnt = {x=unpos.x, y = unpos.z}
	
						table.insert(mis.params.route.points, {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = pnt.x,
							y = pnt.y,
							speed = 10,
							action = AI.Task.VehicleFormation.DIAMOND
						})
					end
				end
			end
		end
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.assaultGroup(group, target)
		if not group or not target then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local mis = {
			id='Mission',
			params = {
				route = {
					points = {}
				}  
			}
		}
		
		local attack = {
			id = 'ComboTask',
			params = {
				tasks = {
				}
			}
		}

		table.insert(attack.params.tasks, {
			enabled = true,
			id = 'AttackGroup',
			number = 3,
			params = {
				groupId = target:getID()
			}
		})

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = startPos.x,
			y = startPos.z,
			speed = 100,
			action = AI.Task.VehicleFormation.DIAMOND,
			task = attack
		})

		for i,v in ipairs(target:getUnits()) do
			local tgtp = v:getPoint()
			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = tgtp.x,
				y = tgtp.z,
				speed = 100,
				action = AI.Task.VehicleFormation.DIAMOND
			})
		end
		
		group:getController():setOption(9, 1)
		group:getController():setOption(9, 0)
		group:getController():setTask(mis)
	end
	
	function TaskExtensions.moveOnRoadToPoint(group, point, detour) -- point = {x,y}
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()
		
		local srx, sry = land.getClosestPointOnRoads('roads', startPos.x, startPos.z)
		local erx, ery = land.getClosestPointOnRoads('roads', point.x, point.y)

		local mis = {
			id='Mission',
			params = {
				route = {
					points = {
					}
				}  
			}
		}

		if detour then
			local detourPoint = {x = startPos.x, y = startPos.z}

			local direction = {
				x = erx - startPos.x,
				y = ery - startPos.y
			}

			local magnitude = (direction.x^2 + direction.y^2) ^ 0.5
			if magnitude > 0.0 then
				direction.x = direction.x / magnitude
				direction.y = direction.y / magnitude

				local scale = math.random(250,1000)
				direction.x = direction.x * scale
				direction.y = direction.y * scale

				detourPoint.x = detourPoint.x + direction.x
				detourPoint.y = detourPoint.y + direction.y
			else
				detourPoint.x = detourPoint.x + math.random(-500,500)
				detourPoint.y = detourPoint.y + math.random(-500,500)
			end
				
			table.insert(mis.params.route.points, {
				type= AI.Task.WaypointType.TURNING_POINT,
				x = detourPoint.x,
				y = detourPoint.y,
				speed = 1000,
				action = AI.Task.VehicleFormation.OFF_ROAD
			})

			srx, sry = land.getClosestPointOnRoads('roads', detourPoint.x, detourPoint.y)
		end

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = srx,
			y = sry,
			speed = 1000,
			action = AI.Task.VehicleFormation.ON_ROAD
		})

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = erx,
			y = ery,
			speed = 1000,
			action = AI.Task.VehicleFormation.ON_ROAD
		})

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.TURNING_POINT,
			x = point.x,
			y = point.y,
			speed = 1000,
			action = AI.Task.VehicleFormation.OFF_ROAD
		})

		group:getController():setTask(mis)
	end
	
	function TaskExtensions.landAtPointFromAir(group, point, alt)
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local atype = AI.Task.AltitudeType.RADIO
		if alt then
			atype = AI.Task.AltitudeType.BARO
		else
			alt = 500
		end

		local land = {
			id='Land',
			params = {
				point = point,
				x = point.x,
				y = point.y,
				--combatLandingFlag = true
			}
		}
		
		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = startPos.x,
							y = startPos.z,
							speed = 500,
							action = AI.Task.TurnMethod.FIN_POINT,
							alt = alt,
							alt_type = atype
						},
						[2] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = point.x,
							y = point.y,
							speed = 257,
							action = AI.Task.TurnMethod.FIN_POINT,
							alt = alt,
							alt_type = atype, 
							task = land
						}
					}
				}  
			}
		}
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.landAtPoint(group, point, alt, skiptakeoff) -- point = {x,y}
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local atype = AI.Task.AltitudeType.RADIO
		if alt then
			atype = AI.Task.AltitudeType.BARO
		else
			alt = 500
		end
		
		local land = {
			id='Land',
			params = {
				point = point,
				x = point.x,
				y = point.y,
				--combatLandingFlag = true
			}
		}

		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if not skiptakeoff then
			table.insert(mis.params.route.points,{
				type = AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = alt,
				alt_type = atype
			})
		end
		
		table.insert(mis.params.route.points,{
			type = AI.Task.WaypointType.TURNING_POINT,
			x = point.x,
			y = point.y,
			speed = 257,
			action = AI.Task.TurnMethod.FIN_POINT,
			alt = alt,
			alt_type = atype, 
			task = land
		})
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.landAtShip(group, ship, alt, skiptakeoff)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local startPos = group:getUnit(1):getPoint()

		local atype = AI.Task.AltitudeType.RADIO
		if alt then
			atype = AI.Task.AltitudeType.BARO
		else
			alt = 500
		end

		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {}
				}  
			}
		}

		if not skiptakeoff then
			table.insert(mis.params.route.points,{
				type = AI.Task.WaypointType.TAKEOFF,
				x = startPos.x,
				y = startPos.z,
				speed = 0,
				action = AI.Task.TurnMethod.FIN_POINT,
				alt = alt,
				alt_type = atype
			})
		end


		local landpos = ship:getPoint()

		table.insert(mis.params.route.points, {
			type= AI.Task.WaypointType.LAND,
			linkUnit = ship:getID(),
			helipadId = ship:getID(),
			x = landpos.x,
			y = landpos.z,
			speed = 257,
			action = AI.Task.TurnMethod.FIN_POINT,
			alt = 0,
			alt_type = AI.Task.AltitudeType.RADIO
		})
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.landAtAirfield(group, point) -- point = {x,y}
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		
		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = point.x,
							y = point.z,
							speed = 257,
							action = AI.Task.TurnMethod.FIN_POINT,
							alt = 4572,
							alt_type = AI.Task.AltitudeType.BARO
						},
						[2] = {
							type= AI.Task.WaypointType.LAND,
							x = point.x,
							y = point.z,
							speed = 257,
							action = AI.Task.TurnMethod.FIN_POINT,
							alt = 0,
							alt_type = AI.Task.AltitudeType.RADIO
						}
					}
				}  
			}
		}
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.fireAtTargets(group, targets, amount)
		if not group then return end
		if not group:isExist() or group:getSize() == 0 then return end

		local units = {}
		for i,v in pairs(targets) do
			local g = Group.getByName(v.name)
			if g then
				for i2,v2 in ipairs(g:getUnits()) do
					table.insert(units, v2)
				end
			else
				local s = StaticObject.getByName(v.name)
				if s then
					table.insert(units, s)
				end
			end
		end
		
		if #units == 0 then
			return
		end
		
		local selected = {}
		for i=1,amount,1 do
			if #units == 0 then 
				break
			end
			
			local tgt = math.random(1,#units)
			
			table.insert(selected, units[tgt])
			table.remove(units, tgt)
		end
		
		while #selected < amount do
			local ind = math.random(1,#selected)
			table.insert(selected, selected[ind])
		end
		
		for i,v in ipairs(selected) do
			local unt = v
			if unt then
				local target = {}
				target.x = unt:getPosition().p.x
				target.y = unt:getPosition().p.z
				target.radius = 100
				target.expendQty = 1
				target.expendQtyEnabled = true
				local fire = {id = 'FireAtPoint', params = target}
				
				group:getController():pushTask(fire)
			end
		end
	end

	function TaskExtensions.carrierGoToPos(group, point)
		if not group or not point then return end
		if not group:isExist() or group:getSize()==0 then return end
		
		local mis = {
			id='Mission',
			params = {
				route = {
					airborne = true,
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = point.x,
							y = point.z,
							speed = 50,
							action = AI.Task.TurnMethod.FIN_POINT
						}
					}
				}  
			}
		}
		
		group:getController():setTask(mis)
	end

	function TaskExtensions.stopCarrier(group)
		if not group then return end
		if not group:isExist() or group:getSize()==0 then return end
		local point = group:getUnit(1):getPoint()

		group:getController():setTask({
			id='Mission',
			params = {
				route = {
					airborne = false,
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = point.x,
							y = point.z,
							speed = 0,
							action = AI.Task.TurnMethod.FIN_POINT
						}
					}
				}  
			}
		})
	end

	function TaskExtensions.sendToPoint(group, point)
		local gp = group:getUnit(1):getPoint()

		local mis = {
			id='Mission',
			params = {
				route = {
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = gp.x,
							y = gp.z,
							speed = 1000,
							action = AI.Task.VehicleFormation.DIAMOND
						},
						[2] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = point.x,
							y = point.z,
							speed = 1000,
							action = AI.Task.VehicleFormation.DIAMOND
						}
					}
				}  
			}
		}

		group:getController():setOption(0, 4)
		group:getController():setOption(9, 1)
		group:getController():setTask(mis)
	end

	function TaskExtensions.stopGroup(group)
		local gp = group:getUnit(1):getPoint()

		local mis = {
			id='Mission',
			params = {
				route = {
					points = {
						[1] = {
							type= AI.Task.WaypointType.TURNING_POINT,
							x = gp.x,
							y = gp.z,
							speed = 0,
							action = AI.Task.VehicleFormation.DIAMOND
						}
					}
				}  
			}
		}

		group:getController():setOption(0, 0)
		group:getController():setOption(9, 2)
		group:getController():setTask(mis)
	end

	function TaskExtensions.enableSamEvasion(group)
		group:getController():setOption(31, true)
	end

	function TaskExtensions.setupCarrier(unit, icls, acls, tacan, link4, radio)
		if not unit then return end
		if not unit:isExist() then return end

		local commands = {}
		if icls then
			table.insert(commands, { 
				id = 'ActivateICLS', 
				params = {
				  type = 131584,
				  channel = icls, 
				  unitId = unit:getID(), 
				  name = "ICLS "..icls, 
				} 
			})
		end

		if acls then
			table.insert(commands, { 
				id = 'ActivateACLS', 
				params = {
				  unitId = unit:getID(), 
				  name = "ACLS",
				}
			})
		end

		if tacan then
			table.insert(commands, { 
				id = 'ActivateBeacon', 
				params = { 
				  type = 4, 
				  system = 4, 
				  name = "TACAN "..tacan.channel, 
				  callsign = tacan.callsign, 
				  frequency = tacan.channel, 
				  channel = tacan.channel,
				  bearing = true,
				  modeChannel = "X"
				}
			})
		end

		if link4 then
			table.insert(commands, { 
				id = 'ActivateLink4', 
				params = {
				  unitId = unit:getID(),
				  frequency = link4, 
				  name = "Link4 "..link4, 
				}
			})
		end

		if radio then
			table.insert(commands, {
				id = "SetFrequency",
				params = {
				   power = 100,
				   modulation = 0,
				   frequency = radio,
				}
			})
		end

		for i,v in ipairs(commands) do
			unit:getController():setCommand(v)
		end

		unit:getGroup():getController():setOption(AI.Option.Ground.id.AC_ENGAGEMENT_RANGE_RESTRICTION, 30)
	end
end

-----------------[[ END OF TaskExtensions.lua ]]-----------------



-----------------[[ MarkerCommands.lua ]]-----------------

MarkerCommands = {}
do
	function MarkerCommands:new()
		local obj = {}
		obj.commands = {} --{command=string, action=function}
		
		setmetatable(obj, self)
		self.__index = self
		
		obj:start()
		
		DependencyManager.register("MarkerCommands", obj)
		return obj
	end
	
	function MarkerCommands:addCommand(command, action, hasParam, state)
		table.insert(self.commands, {command = command, action = action, hasParam = hasParam, state = state})
	end
	
	function MarkerCommands:start()
		local markEditedEvent = {}
		markEditedEvent.context = self
		function markEditedEvent:onEvent(event)
			if event.id == 26 and event.text and (event.coalition == 1 or event.coalition == 2) then -- mark changed
				local success = false
				env.info('MarkerCommands - input: '..event.text)
				
				for i,v in ipairs(self.context.commands) do
					if (not v.hasParam) and event.text == v.command then
						success = v.action(event, nil, v.state)
						break
					elseif v.hasParam and event.text:find('^'..v.command..':') then
						local param = event.text:gsub('^'..v.command..':', '')
						success = v.action(event, param, v.state)
						break
					end
				end
				
				if success then
					trigger.action.removeMark(event.idx)
				end
			end
		end
		
		world.addEventHandler(markEditedEvent)
	end
end


-----------------[[ END OF MarkerCommands.lua ]]-----------------



-----------------[[ MiniGCI.lua ]]-----------------

MiniGCI = {}

do
    function MiniGCI:new(side)
        local o = {}
        o.side = side
        o.tgtSide = 0
        if side == 1 then
            o.tgtSide = 2
        elseif side == 2 then
            o.tgtSide = 1
        end

        o.radars = {}
        o.contacts = {}
        o.lastContactsTime = 0
        o.radarTypes = {
            'SAM SR',
            'EWR',
            'AWACS'
        }

        setmetatable(o, self)
		self.__index = self
		return o
    end

    function MiniGCI:refreshRadars()
        local allunits = coalition.getGroups(self.side)

        local radars = {}
        for _,g in ipairs(allunits) do
            for _,u in ipairs(g:getUnits()) do
                for _,a in ipairs(self.radarTypes) do
                    if u:hasAttribute(a) then
                        table.insert(radars, u)
                        break
                    end
                end
            end
        end

        self.radars = radars
    end

    function MiniGCI:scanForContacts()
        local dect = {}
        for _,u in ipairs(self.radars) do
            if u:isExist() then
                local detected = u:getController():getDetectedTargets(Controller.Detection.RADAR)
                for _,d in ipairs(detected) do
                    if d and d.object and d.object.isExist and d.object:isExist() and 
                        Object.getCategory(d.object) == Object.Category.UNIT and
                        d.object.getCoalition and
                        d.object:getCoalition() == self.tgtSide then
                            
                        if not dect[d.object:getName()] then
                            dect[d.object:getName()] = d.object
                        end
                    end
                end
            end
        end

        self.contacts = dect
        self.lastContactsTime = timer.getTime()
    end

    function MiniGCI:getContacts()
        return self.contacts
    end
end

-----------------[[ END OF MiniGCI.lua ]]-----------------



-----------------[[ StrategicAI/AIBase.lua ]]-----------------

AIBase = {}

do
    function AIBase:new(side, createMissions)
        local obj = {}
        obj.side = side
        obj.createMissions = createMissions
        setmetatable(obj, self)
		self.__index = self
        
        obj:createState()
        return obj
    end

    function AIBase:makeDecissions()
    end

    function AIBase:serializeState()
    end

    function AIBase:restoreState(state)
    end

    function AIBase:createState()
    end
end

-----------------[[ END OF StrategicAI/AIBase.lua ]]-----------------



-----------------[[ StrategicAI/Robert.lua ]]-----------------

Robert = AIBase:new() -- randomly assignes builds and tasking, same as old Pretense AI

do
    function Robert:createState()
        self.deployChance = 0.7
    end

    function Robert:makeDecissions()
        local viableAttack = {}
        local viableDefend = {}
        local canBuild = {}
        local needsSupplies = {}
        local friendlyZones = {}
        local viableSupports = {}

        local add = table.insert
        for i,v in pairs(ZoneCommand.getAllZones()) do
            if v.distToFront~=nil then
                if v.side == self.side then
                    if v:canBuild() or v:canMissionBuild() then
                        add(canBuild, v)
                    end

                    if v:needsSupplies(2000) then
                        add(needsSupplies, v)
                    end
                    
                    if v.distToFront~= nil and v.distToFront == 4 then
                        add(viableSupports, v)
                    end
                else
                    if v.distToFront~=nil and v.distToFront <= 1 then
                        add(viableAttack, v)
                    end
                end

                if v.distToFront <= 1 then
                    add(viableDefend, v)
                end
            end
        end

        table.sort(needsSupplies, function(a,b)
            if a.distToFront~=nil and b.distToFront == nil then
                return true
            elseif a.distToFront == nil and b.distToFront ~= nil then
                return false
            elseif a.distToFront == b.distToFront then
                return a.resource < b.resource
            else
                return a.distToFront<b.distToFront
            end
        end)

        self:decideBuilds(canBuild)
        self:decideDefensive(viableDefend)
        self:decideOffensive(viableAttack)
        self:decideSupports(viableSupports)
        self:decideSupplies(needsSupplies)

        if self.createMissions then
            DependencyManager.get("MissionTracker"):fillEmptySlots()
        end
    end

    function Robert:decideBuilds(buildableZones)
        local supplyTypes = {
            [ZoneCommand.missionTypes.supply_air] = true,
            [ZoneCommand.missionTypes.supply_convoy] = true,
            [ZoneCommand.missionTypes.supply_transfer] = true,
        }

        for _,z in ipairs(buildableZones) do
            if z:canBuild() then
                local canAfford = {}
                for _,v in ipairs(z.upgrades[z.side]) do
                    local isBuilt = StrategicAI.isProductBuilt(v)

                    if not isBuilt then
                        if z:canBuildProduct(v) then
                            table.insert(canAfford, {product = v, reason='upgrade'})
                        end
                    else
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) then
                                if v2.type == 'mission' and not z:criticalOnSupplies() then
                                    if v2.missionType == ZoneCommand.missionTypes.supply_transfer then
                                        if z.distToFront > 1 then
                                            table.insert(canAfford, {product = v2, reason='mission'})
                                        end
                                    elseif v2.missionType == ZoneCommand.missionTypes.supply_air or v2.missionType == ZoneCommand.missionTypes.supply_convoy then
                                        if z.distToFront <= 1 then
                                            table.insert(canAfford, {product = v2, reason='mission'})
                                        end
                                    end
                                elseif v2.type=='defense' and z.mode ~='export' and z.mode ~='supply' and v2.cost > 0 then
                                    local g = Group.getByName(v2.name)
                                    if not g then
                                        table.insert(canAfford, {product = v2, reason='defense'})
                                    elseif g:getSize() < (g:getInitialSize()*math.random(40,100)/100) then
                                        table.insert(canAfford, {product = v2, reason='repair'})
                                    end
                                end
                            end
                        end
                    end
                end

                if #canAfford > 0 then
                    local choice = math.random(1, #canAfford)
                    
                    if canAfford[choice] then
                        local p = canAfford[choice]
                        if p.reason == 'repair' then
                            z:queueBuild(p.product, true)
                        else
                            z:queueBuild(p.product)
                        end
                    end
                end
            end

            if z:canMissionBuild() and not z:criticalOnSupplies() then
                local canMission = {}
                for _,v in ipairs(z.upgrades[z.side]) do
                    if StrategicAI.isProductBuilt(v) then
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) and not StrategicAI.isProductBuilt(v2) and v2.type == 'mission' then 
                                if not supplyTypes[v2.missionType] then
                                    if v2.missionType ~= ZoneCommand.missionTypes.assault or z.distToFront==0 then
                                        if math.random() < ZoneCommand.missionValidChance then
                                            table.insert(canMission, {product = v2, reason='mission'})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            
                if #canMission > 0 then
                    local choice = math.random(1, #canMission)
                    
                    if canMission[choice] then
                        local p = canMission[choice]
                        z:queueBuild(p.product)
                    end
                end
            end
        end
    end

    function Robert:decideSupplies(zonesToSupply)
        if #zonesToSupply == 0 then return end

        local supplyTypes = {
            [ZoneCommand.missionTypes.supply_air] = true,
            [ZoneCommand.missionTypes.supply_convoy] = true,
            [ZoneCommand.missionTypes.supply_transfer] = true,
        }

        for _,z in ipairs(zonesToSupply) do
            local sources = {}
            for _,v in pairs(StrategicAI.resources[self.side]) do
                if supplyTypes[v.missionType] then
                    table.insert(sources, v)
                end
            end
            
            local simulated = z.distToFront > 1

            local pick = nil
            for _,n in ipairs(sources) do
                local stype = 'transfer'
                if simulated then
                    if n.missionType == ZoneCommand.missionTypes.supply_transfer then
                        stype = 'transfer'
                    end
                else
                    if n.missionType == ZoneCommand.missionTypes.supply_convoy  then
                        stype = 'convoy'
                    elseif n.missionType == ZoneCommand.missionTypes.supply_air then
                        stype = 'air'
                    end
                end

                if not pick then
                    if n.owner:canSupply(z, stype, n.capacity) then
                        pick = n
                    end
                else
                    if n.owner:canSupply(z, stype, n.capacity) and n.owner.resource > pick.owner.resource then
                        pick = n
                    end
                end
            end

            if pick then
                StrategicAI.activateMission(pick, z)
            end
        end
    end

    function Robert:decideDefensive(zonesToDefend)
        if #zonesToDefend == 0 then return end

        for _,v in pairs(StrategicAI.resources[self.side]) do
            if math.random() < self.deployChance then
                if v.missionType == ZoneCommand.missionTypes.patrol then
                    local choice = zonesToDefend[math.random(1, #zonesToDefend)]
                    StrategicAI.activateMission(v, choice)
                end
            end
        end
    end

    function Robert:decideOffensive(zonesToAttack)
        if #zonesToAttack == 0 then return end

        local captureable = {}
        local attackable = {}
        for _,v in ipairs(zonesToAttack) do
            if v.side == 0 then
                table.insert(captureable, v)
            elseif v.side ~= self.side then
                table.insert(attackable, v)
            end
        end

        for _,v in pairs(StrategicAI.resources[self.side]) do
            if math.random() < self.deployChance then
                if v.missionType == ZoneCommand.missionTypes.supply_air then
                    local viable = {}
                    for _, z in ipairs(captureable) do
                        if v.owner:canSupply(z, 'air', v.capacity) then
                            table.insert(viable, z)
                        end
                    end

                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                elseif v.missionType == ZoneCommand.missionTypes.supply_convoy then
                    local viable = {}
                    for _, z in ipairs(captureable) do
                        if v.owner:canSupply(z, 'convoy', v.capacity) then
                            table.insert(viable, z)
                        end
                    end

                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                elseif v.missionType == ZoneCommand.missionTypes.cas then
                    if math.random() < 0.3 then
                        local tggroups = {}
                        for _,tgt in pairs(DependencyManager.get("GroupMonitor").groups) do
                            if v.side ~= tgt.product.side and 
                                (tgt.product.missionType == ZoneCommand.missionTypes.assault or tgt.product.missionType == ZoneCommand.missionTypes.supply_convoy) then 
                                    local gr = Group.getByName(tgt.name)
                                    if gr and gr:isExist() and gr:getSize()>0 then
                                        local un = gr:getUnit(1)
                                        if un and un:isExist() then
                                            local dist = mist.utils.get2DDist(v.owner.zone.point, un:getPoint())
                                            if dist < 60000 then
                                                table.insert(tggroups, {product = v, dist = dist})
                                            end
                                        end
                                    end
                            end
                        end

                        table.sort(tggroups, function(a,b)
                            return a.dist < b.dist
                        end)

                        local targets = {}
                        local count = 0
                        for i,v in ipairs(tggroups) do
                            targets[v.product.name] = v.product
                            count = count + 1
                            if count >=3 then break end
                        end

                        if count > 0 then
                            StrategicAI.activateMission(v, { baiTargets = targets})
                        end
                    else
                        local viable = {}
                        for _,z in ipairs(attackable) do
                            if z.distToFront == 0 and not z:hasEnemySAMRadar(v.side) and z:hasEnemyDefense(v.side) then
                            table.insert(viable, z)
                            end
                        end

                        if #viable > 0 then
                            StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                        end
                    end
                elseif v.missionType == ZoneCommand.missionTypes.cas_helo then
                    local viable = {}
                    for _,z in ipairs(attackable) do
                        if z.distToFront == 0 and not z:hasEnemySAMRadar(v.side) and z:hasEnemyDefense(v.side) and v.owner:canAttack(z, 'cas_helo') then
                        table.insert(viable, z)
                        end
                    end
                    
                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                elseif v.missionType == ZoneCommand.missionTypes.strike then
                    local viable = {}
                    for _,z in ipairs(attackable) do
                        if z.distToFront == 0 and not z:hasEnemySAMRadar(v.side) and z:hasEnemyStructure(v.side) then
                        table.insert(viable, z)
                        end
                    end
                    
                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                elseif v.missionType == ZoneCommand.missionTypes.sead then
                    local viable = {}
                    for _,z in ipairs(attackable) do
                        if z.distToFront <= 1 and z:hasEnemySAMRadar(v.side) then
                        table.insert(viable, z)
                        end
                    end
                    
                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                elseif v.missionType == ZoneCommand.missionTypes.assault then
                    local viable = {}
                    for _,z in ipairs(attackable) do
                        if v.owner:isNeighbour(z) and not DependencyManager.get("ConnectionManager"):isRoadBlocked(v.owner.name, z.name) then
                        table.insert(viable, z)
                        end
                    end
                    
                    if #viable > 0 then
                        StrategicAI.activateMission(v, viable[math.random(1,#viable)])
                    end
                end
            end
        end
    end

    function Robert:decideSupports(zonesToSupport)
        if #zonesToSupport == 0 then return end

        for _,v in pairs(StrategicAI.resources[self.side]) do
            if math.random() < self.deployChance then
                if v.missionType == ZoneCommand.missionTypes.awacs or v.missionType == ZoneCommand.missionTypes.tanker then
                    local choice = zonesToSupport[math.random(1, #zonesToSupport)]
                    StrategicAI.activateMission(v, choice)
                end
            end
        end
    end
end

-----------------[[ END OF StrategicAI/Robert.lua ]]-----------------



-----------------[[ StrategicAI/Bob.lua ]]-----------------

Bob = Robert:new() -- same as robert, but doesnt use CAP

do
    function Bob:makeDecissions()
        local viableAttack = {}
        local canBuild = {}
        local needsSupplies = {}
        local friendlyZones = {}
        local viableSupports = {}

        local add = table.insert
        for i,v in pairs(ZoneCommand.getAllZones()) do
            if v.distToFront~=nil then
                if v.side == self.side then
                    if v:canBuild() or v:canMissionBuild() then
                        add(canBuild, v)
                    end

                    if v:needsSupplies(2000) then
                        add(needsSupplies, v)
                    end
                    
                    if v.distToFront~= nil and v.distToFront == 4 then
                        add(viableSupports, v)
                    end
                else
                    if v.distToFront~=nil and v.distToFront <= 1 then
                        add(viableAttack, v)
                    end
                end
            end
        end

        table.sort(needsSupplies, function(a,b)
            if a.distToFront~=nil and b.distToFront == nil then
                return true
            elseif a.distToFront == nil and b.distToFront ~= nil then
                return false
            elseif a.distToFront == b.distToFront then
                return a.resource < b.resource
            else
                return a.distToFront<b.distToFront
            end
        end)

        self:decideBuilds(canBuild)
        self:decideOffensive(viableAttack)
        self:decideSupports(viableSupports)
        self:decideSupplies(needsSupplies)
        
        if self.createMissions then
            DependencyManager.get("MissionTracker"):fillEmptySlots()
        end
    end

    function Bob:decideBuilds(buildableZones)
        local supplyTypes = {
            [ZoneCommand.missionTypes.supply_air] = true,
            [ZoneCommand.missionTypes.supply_convoy] = true,
            [ZoneCommand.missionTypes.supply_transfer] = true,
        }

        for _,z in ipairs(buildableZones) do
            if z:canBuild() then
                local canAfford = {}
                for _,v in ipairs(z.upgrades[z.side]) do
                    local isBuilt = StrategicAI.isProductBuilt(v)

                    if not isBuilt then
                        if z:canBuildProduct(v) then
                            table.insert(canAfford, {product = v, reason='upgrade'})
                        end
                    else
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) then
                                if v2.type == 'mission' and not z:criticalOnSupplies() then
                                    if v2.missionType == ZoneCommand.missionTypes.supply_transfer then
                                        if z.distToFront > 1 then
                                            table.insert(canAfford, {product = v2, reason='mission'})
                                        end
                                    elseif v2.missionType == ZoneCommand.missionTypes.supply_air or v2.missionType == ZoneCommand.missionTypes.supply_convoy then
                                        if z.distToFront <= 1 then
                                            table.insert(canAfford, {product = v2, reason='mission'})
                                        end
                                    end
                                elseif v2.type=='defense' and z.mode ~='export' and z.mode ~='supply' and v2.cost > 0 then
                                    local g = Group.getByName(v2.name)
                                    if not g then
                                        table.insert(canAfford, {product = v2, reason='defense'})
                                    elseif g:getSize() < (g:getInitialSize()*math.random(40,100)/100) then
                                        table.insert(canAfford, {product = v2, reason='repair'})
                                    end
                                end
                            end
                        end
                    end
                end

                if #canAfford > 0 then
                    local choice = math.random(1, #canAfford)
                    
                    if canAfford[choice] then
                        local p = canAfford[choice]
                        if p.reason == 'repair' then
                            z:queueBuild(p.product, true)
                        else
                            z:queueBuild(p.product)
                        end
                    end
                end
            end

            if z:canMissionBuild() and not z:criticalOnSupplies() then
                local canMission = {}
                for _,v in ipairs(z.upgrades[z.side]) do
                    if StrategicAI.isProductBuilt(v) then
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) and not StrategicAI.isProductBuilt(v2) and v2.type == 'mission' then 
                                if not supplyTypes[v2.missionType] and v2.missionType~=ZoneCommand.missionTypes.patrol then
                                    if v2.missionType ~= ZoneCommand.missionTypes.assault or z.distToFront==0 then
                                        if math.random() < ZoneCommand.missionValidChance then
                                            table.insert(canMission, {product = v2, reason='mission'})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            
                if #canMission > 0 then
                    local choice = math.random(1, #canMission)
                    
                    if canMission[choice] then
                        local p = canMission[choice]
                        z:queueBuild(p.product)
                    end
                end
            end
        end
    end
end

-----------------[[ END OF StrategicAI/Bob.lua ]]-----------------



-----------------[[ StrategicAI/Cameron.lua ]]-----------------

Cameron = AIBase:new() -- chooses a few objectives and focuses on them, requests products it needs, directs cap to zones with enemy aircraft nearby

do
    function Cameron:createState()
        self.objectives = {}
        self.maxObj = 2
        self.otherAssigned = {}
        self.assignedTargets = {}
        self.maxCap = 2
        self.maxBai = 1
        self.maxTicks = 6*60*2 -- 1 tick per 10 seconds 6 ticks per minute, 6*60 ticks per hour

        self.gci = MiniGCI:new(self.side)

        Cameron.misPriorities = {
            [ZoneCommand.missionTypes.patrol] = 1,
            [ZoneCommand.missionTypes.assault] = 2,
            [ZoneCommand.missionTypes.sead] = 3,
            [ZoneCommand.missionTypes.strike] = 4,
            [ZoneCommand.missionTypes.cas] = 5,
            [ZoneCommand.missionTypes.cas_helo] = 6,
            [ZoneCommand.missionTypes.supply_air] = 7,
            [ZoneCommand.missionTypes.supply_convoy] = 8,
            [ZoneCommand.missionTypes.awacs] = 9,
            [ZoneCommand.missionTypes.tanker] = 10,
            [ZoneCommand.missionTypes.supply_transfer] = 11,
        }
    end

    function Cameron:restoreState(state)
        if not state then return end

        for i,v in ipairs(state.objectives) do
            local assigned = {}
            for pn, po in pairs(v.assignedResources) do
                assigned[pn] = ZoneCommand.getZoneByName(po.owner):getProductByName(po.pname)
            end

            table.insert(self.objectives, {
                target = ZoneCommand.getZoneByName(v.target),
                requestedResources = {},
                assignedResources = assigned,
                ticks = v.ticks
            })
        end

        for pn, po in pairs(state.otherAssigned) do
            self.otherAssigned[pn] = ZoneCommand.getZoneByName(po.owner):getProductByName(po.pname)
            self.assignedTargets[pn] = po.tname
        end
    end

    function Cameron:serializeState()
        local state = {
            objectives = {},
            otherAssigned = {}
        }

        for i,v in ipairs(self.objectives) do
            local ob = {
                target = v.target.name,
                assignedResources = {},
                ticks = v.ticks
            }

            for pn,po in pairs(v.assignedResources) do
                ob.assignedResources[pn] = {pname = po.name, owner = po.owner.name}
            end

            table.insert(state.objectives, ob)
        end

        for i,v in pairs(self.otherAssigned) do
            state.otherAssigned[i] = { pname = v.name, owner = v.owner.name, tname = self.assignedTargets[i] }
        end

        return state
    end

    local function isMissionActive(product)
        if not product then return false end

        local g = DependencyManager.get("GroupMonitor"):getGroup(product.name)
        if g then
            if g.returning then return false end

            local gr = Group.getByName(g.product.name)
            if gr and gr:isExist() and gr:getSize()>0 then
                return true
            end
        end

        return false
    end

    function Cameron:makeDecissions()

        local viableAttack = {}
        local viableDefend = {}
        local canBuild = {}
        local needsSupplies = {}
        local friendlyZones = {}
        local viableSupports = {}

        local add = table.insert
        for i,v in pairs(ZoneCommand.getAllZones()) do
            if v.distToFront~=nil then
                if v.side == self.side then
                    if v:canBuild() or v:canMissionBuild() then
                        add(canBuild, v)
                    end

                    if v:needsSupplies(2000) then
                        add(needsSupplies, v)
                    end
                    
                    if v.distToFront~= nil and v.distToFront == 4 then
                        add(viableSupports, v)
                    end
                else
                    if v.distToFront~=nil and v.distToFront == 0 then
                        add(viableAttack, v)
                    end
                end

                if v.distToFront <= 1 and v.side == self.side then
                    add(viableDefend, v)
                end
            end
        end

        table.sort(needsSupplies, function(a,b)
            if a.distToFront~=nil and b.distToFront == nil then
                return true
            elseif a.distToFront == nil and b.distToFront ~= nil then
                return false
            elseif a.distToFront == b.distToFront then
                return a.resource < b.resource
            else
                return a.distToFront<b.distToFront
            end
        end)

        self.gci:refreshRadars()
        self.gci:scanForContacts()

        self:processPlan({
            viableAttack = viableAttack,
            viableDefend = viableDefend,
            canBuild = canBuild,
            needsSupplies = needsSupplies,
            friendlyZones = friendlyZones,
            viableSupports = viableSupports,
        })

        if self.createMissions then
            DependencyManager.get("MissionTracker"):fillEmptySlots()
        end
    end

    function Cameron:processPlan(zones)
        while #self.objectives < self.maxObj and #zones.viableAttack>0 do
            local o = self:createObjective(zones.viableAttack)
            if not o then break end
            table.insert(self.objectives, o)
        end

        local keep = {}
        for _,v in ipairs(self.objectives) do
            local isComplete = self:processObjective(v)
            if not isComplete then
                table.insert(keep, v)
            else
                -- //TODO: reasign resources from completed or abandoned objective
            end
        end
        self.objectives = keep

        local requested = {}
        for _,v in ipairs(self.objectives) do
            for res, amount in pairs(v.requestedResources) do
                requested[res] = requested[res] or 0
                requested[res] = requested[res] + amount
            end
        end
        
        local supportNeeds = self:processSupports(zones.viableSupports)
        for res,amount in pairs(supportNeeds) do
            requested[res] = requested[res] or 0
            requested[res] = requested[res] + amount
        end

        local defenseNeeds = self:processDefense(zones.viableDefend)
        for res,amount in pairs(defenseNeeds) do
            requested[res] = requested[res] or 0
            requested[res] = requested[res] + amount
        end

        self:processBuilds(zones, requested)

        self:processSupplies(zones)

        for i,v in pairs(self.otherAssigned) do
            if not isMissionActive(v) then
                self.otherAssigned[i] = nil
                self.assignedTargets[i] = nil
            end
        end
    end

    local function getMissionOfType(mistype, resourceList, tankerType, pos)
        local all = {}
        for _,v in pairs(resourceList) do
            if v.missionType == mistype then
                if tankerType then
                    if v.variant == tankerType then
                        table.insert(all,v)
                    end
                else
                    table.insert(all,v)
                end
            end
        end

        local closest = nil
        local cdist = 999999999
        for i,v in ipairs(all) do
            local dist = mist.utils.get2DDist(v.owner.zone.point, pos)
            if dist < cdist then
                closest = v
                cdist = dist
            end
        end

        return closest
    end

    local function createMission(objective, type, myside, assigned)
        local activated = false

        if assigned then objective.assignedResources[assigned.name] = nil end

        local res = getMissionOfType(type, StrategicAI.resources[myside], nil, objective.target.zone.point)
        if res then
            local success = false
            if res.missionType == ZoneCommand.missionTypes.assault then
                if res.owner:canAttack(objective.target, 'assault') then
                    success = StrategicAI.activateMission(res, objective.target)
                end
            elseif res.missionType == ZoneCommand.missionTypes.cas_helo then
                if res.owner:canAttack(objective.target, 'cas_helo') then
                    success = StrategicAI.activateMission(res, objective.target)
                end
            else
                success = StrategicAI.activateMission(res, objective.target)
            end

            if success then
                objective.assignedResources[res.name] = res
                activated = true
            end
        else
            objective.requestedResources[type] = (objective.requestedResources[type] or 0) + 1
        end

        return activated
    end

    local function ensureMission(objective, type, myside)
        local activated = false
        local assigned = getMissionOfType(type, objective.assignedResources, nil, objective.target.zone.point)
        if not isMissionActive(assigned) then
            activated = createMission(objective, type, myside, assigned)
        end

        return activated
    end

    function Cameron:processSupports(suportzones)
        if #suportzones == 0 then return {} end

        local needs = {}

        local awacstgt = suportzones[math.random(1,#suportzones)]
        local awacs = getMissionOfType(ZoneCommand.missionTypes.awacs, self.otherAssigned, nil, awacstgt.zone.point)
        if not isMissionActive(awacs) then
            if awacs then self.otherAssigned[awacs.name] = nil end

            local res = getMissionOfType(ZoneCommand.missionTypes.awacs, StrategicAI.resources[self.side], nil, awacstgt.zone.point)
            if res then
                local success = StrategicAI.activateMission(res, awacstgt)
                if success then
                    self.otherAssigned[res.name] = res
                    self.assignedTargets[res.name] = awacstgt.name
                end
            else
                needs[ZoneCommand.missionTypes.awacs] = 1
            end
        end

        local ttypes = { 'Drogue', 'Boom' }
        for _, ttype in ipairs(ttypes) do
            local tankertgt = suportzones[math.random(1,#suportzones)]
            local tanker = getMissionOfType(ZoneCommand.missionTypes.tanker, self.otherAssigned, ttype, tankertgt.zone.point)
            if not isMissionActive(tanker) then
                if tanker then self.otherAssigned[tanker.name] = nil end
                
                local res = getMissionOfType(ZoneCommand.missionTypes.tanker, StrategicAI.resources[self.side], ttype, tankertgt.zone.point)
                if res then
                    local success = StrategicAI.activateMission(res, tankertgt)
                    if success then
                        self.otherAssigned[res.name] = res
                        self.assignedTargets[res.name] = tankertgt.name
                    end
                else
                    needs[ZoneCommand.missionTypes.tanker] = (needs[ZoneCommand.missionTypes.tanker] or 0) + 1
                end
            end
        end

        return needs
    end

    function Cameron:processDefense(defendZones)
        local needs = {}
        local defendCaps = {}
        local defendCas = {}
        for i,v in pairs(self.otherAssigned) do
            if v.missionType == ZoneCommand.missionTypes.patrol then
                if not isMissionActive(v) then
                    self.otherAssigned[v.name] = nil
                    self.assignedTargets[v.name] = nil
                else
                    table.insert(defendCaps, v)
                end
            elseif v.missionType == ZoneCommand.missionTypes.cas then
                if not isMissionActive(v) then
                    self.otherAssigned[v.name] = nil
                    self.assignedTargets[v.name] = nil
                else
                    table.insert(defendCas, v)
                end
            end
        end

        local enemyPerZone = {}
        for i,v in pairs(self.gci:getContacts()) do
            local closest = ZoneCommand.getClosestZoneToPoint(v:getPoint(), self.side)
            if closest then
                enemyPerZone[closest.name] = (enemyPerZone[closest.name] or 0) + 1
            end
        end
            
        local indexed = {}
        for i,v in pairs(enemyPerZone) do
            table.insert(indexed, {name=i, count=v})
        end

        table.sort(indexed, function(a,b) return a.count<b.count end)

        if #indexed > 0 then
            local assignments = {}
            for i=1,self.maxCap do
                local ind = indexed[i]
                if ind then assignments[ind.name] = 'none' end
            end

            local reassign = {}
            for i,v in ipairs(defendCaps) do
                local assigned = self.assignedTargets[v.name]
                if assignments[assigned] == 'none' then
                    assignments[assigned] = v
                else
                    table.insert(reassign, v)
                end
            end

            for i,v in pairs(assignments) do
                if v == 'none' then
                    if #reassign > 0 then
                        local item = reassign[1]
                        if item then
                            local tgtzone = ZoneCommand.getZoneByName(i)
                            local success = AIActivator.reAssignMission(item, tgtzone)

                            if success then
                                --env.info('Cameron - processDefense: reassigning '..item.name..' from '..self.assignedTargets[item.name]..' to '..tgtzone.name)
                                self.otherAssigned[item.name] = item
                                self.assignedTargets[item.name] = tgtzone.name
                                table.remove(reassign, 1)
                            end
                        end
                    end
                end
            end
        end

        -- //TODO: index bai targets

        if #defendCaps < self.maxCap then
            if #indexed > 0 then
                for i=1,(self.maxCap-#defendCaps) do
                    if indexed[i] then
                        local z = ZoneCommand.getZoneByName(indexed[i].name)
                        --env.info('Cameron - processDefense: tgt: '..z.name)

                        local hasAssignment = false
                        for pn, tn in pairs(self.assignedTargets) do
                            if tn==z.name and isMissionActive(self.otherAssigned[pn]) then
                                hasAssignment = true
                                break
                            end
                        end

                        if not hasAssignment then
                            local cap = getMissionOfType(ZoneCommand.missionTypes.patrol, StrategicAI.resources[self.side], nil, z.zone.point)
                            if cap then
                                local success = StrategicAI.activateMission(cap, z)
                                if success then
                                    self.otherAssigned[cap.name] = cap
                                    self.assignedTargets[cap.name] = z.name
                                end
                            else
                                needs[ZoneCommand.missionTypes.patrol] = (needs[ZoneCommand.missionTypes.patrol] or 0) + 1
                            end
                        end
                    end
                end
            end  
        end

        if #defendCas < self.maxBai then
            -- //TODO: activate bai missions or request needs for eached indexed bai target, attempt getting bai from closest possible place
        end

        return needs
    end

    local function pickSupply(target, sources)
        local simulated = target.distToFront > 1
    
        local pick = nil
        for _,n in ipairs(sources) do
            local stype = 'transfer'
            if simulated then
                if n.missionType == ZoneCommand.missionTypes.supply_transfer then
                    stype = 'transfer'
                end
            else
                if n.missionType == ZoneCommand.missionTypes.supply_convoy  then
                    stype = 'convoy'
                elseif n.missionType == ZoneCommand.missionTypes.supply_air then
                    stype = 'air'
                end
            end

            if not pick then
                if n.owner:canSupply(target, stype, n.capacity) then
                    pick = n
                end
            else
                if n.owner:canSupply(target, stype, n.capacity) and n.owner.resource > pick.owner.resource then
                    pick = n
                end
            end
        end

        return pick
    end

    function Cameron:processSupplies(zones)
        local supplyTypes = {
            [ZoneCommand.missionTypes.supply_air] = true,
            [ZoneCommand.missionTypes.supply_convoy] = true,
            [ZoneCommand.missionTypes.supply_transfer] = true,
        }

        local unassignedNeutral = {}
        for i,v in ipairs(zones.viableAttack) do
            if v.side == 0 then
                local assigned = nil
                for prod,target in pairs(self.assignedTargets) do
                    if target == v.name and self.otherAssigned[prod] and supplyTypes[self.otherAssigned[prod].missionType] then
                        assigned = true
                        break
                    end
                end

                if not assigned then
                    for _,o in ipairs(self.objectives) do
                        for _, prod in pairs(o.assignedResources) do
                            if supplyTypes[prod.missionType] and prod.target and prod.target.name == v.name then
                                assigned = true
                                break
                            end
                        end
                    end
                end

                if not assigned then
                    table.insert(unassignedNeutral, v)
                end
            end
        end

        local requests = {}
        for i,v in ipairs(unassignedNeutral) do
            requests[v.name] = 1001
        end

        for i,v in ipairs(zones.friendlyZones) do
            local need = 0

            if v.currentBuild then
                need = need + (v.currentBuild.product.cost - v.currentBuild.progress)
            end

            if v.currentMissionBuild then
                need = need + (v.currentMissionBuild.product.cost - v.currentMissionBuild.progress)
            end

            if v.resource < need then
                requests[v.name] = need - v.resource
            end
        end

        if #zones.needsSupplies > 0 then
            for i,v in pairs(self.otherAssigned) do
                if v.missionType == ZoneCommand.missionTypes.supply_air or v.missionType == ZoneCommand.missionTypes.supply_convoy then
                    local g = DependencyManager.get("GroupMonitor"):getGroup(v.name)
                    if g and g.returning then
                        local gr = Group.getByName(g.product.name)
                        if gr and gr:isExist() and gr:getSize()>0 then
                            local un = gr:getUnit(1)
                            local pos = un:getPoint()
                            local closest = nil
                            local cdist = 9999999
                            for _,z in ipairs(zones.needsSupplies) do
                                if z.side == self.side then
                                    local d = mist.utils.get2DDist(z.zone.point, pos)
                                    if d < cdist then
                                        closest = z
                                        cdist = d
                                    end
                                end
                            end

                            if closest then
                                local success = AIActivator.reAssignMission(v, closest)

                                if success then
                                    self.otherAssigned[v.name] = v
                                    self.assignedTargets[v.name] = closest.name
                                end
                            end
                        end
                    end
                end
            end
        end

        for i,v in pairs(requests) do
            --env.info('Cameron - processSupplies: '..i..' requesting '..v)

            if v<1000 then 
                --env.info('Cameron - processSupplies: '..i..' request denied, not priority')
            else
                local hasAssigned = false
                for name,prod in pairs(self.otherAssigned) do
                    if prod.missionType == ZoneCommand.missionTypes.supply_air or prod.missionType == ZoneCommand.missionTypes.supply_convoy then
                        if i==self.assignedTargets[prod.name] and isMissionActive(prod) then
                            hasAssigned = true
                            break
                        end
                    end
                end

                if not hasAssigned then
                    local z = ZoneCommand.getZoneByName(i)
                    local sources = {}
                    for _,prod in pairs(StrategicAI.resources[self.side]) do
                        if supplyTypes[prod.missionType] then
                            table.insert(sources, prod)
                        end
                    end
                    
                    local pick = pickSupply(z, sources)
                    
                    if pick then
                        local success = StrategicAI.activateMission(pick, z)
                        if success then
                            self.otherAssigned[pick.name] = pick
                            self.assignedTargets[pick.name] = z.name
                        end
                    end
                end
            end
        end

        if #zones.needsSupplies > 0 then 
    
            for _,z in ipairs(zones.needsSupplies) do
                local hasAssigned = false
                for name, prod in pairs(self.otherAssigned) do
                    if prod.missionType == ZoneCommand.missionTypes.supply_air or prod.missionType == ZoneCommand.missionTypes.supply_convoy then
                        if z.name==self.assignedTargets[prod.name] and isMissionActive(prod) then
                            hasAssigned = true
                            break
                        end
                    end
                end

                if not hasAssigned then
                    local sources = {}
                    for _,v in pairs(StrategicAI.resources[self.side]) do
                        if supplyTypes[v.missionType] then
                            table.insert(sources, v)
                        end
                    end
                    
                    local pick = pickSupply(z, sources)
                    
                    if pick then
                        local success = StrategicAI.activateMission(pick, z)
                        if success then
                            self.otherAssigned[pick.name] = pick
                            self.assignedTargets[pick.name] = z.name
                        end
                    end
                end
            end
        end
    end

    local function pickMainBuilds(canBuild)
        for _,z in ipairs(canBuild) do
            if z:canBuild() then
                local canAfford = {
                    upgrades = {},
                    defenses = {},
                    missions = {}
                }
                
                for _,v in ipairs(z.upgrades[z.side]) do
                    local isBuilt = StrategicAI.isProductBuilt(v)

                    if not isBuilt then
                        if z:canBuildProduct(v) then
                            table.insert(canAfford.upgrades, {product = v, reason='upgrade'})
                        end
                    else
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) then
                                if v2.type == 'mission' then
                                    if v2.missionType == ZoneCommand.missionTypes.supply_transfer then
                                        if z.distToFront > 1 then
                                            table.insert(canAfford.missions, {product = v2, reason='mission'})
                                        end
                                    elseif v2.missionType == ZoneCommand.missionTypes.supply_air or v2.missionType == ZoneCommand.missionTypes.supply_convoy then
                                        if z.distToFront <= 1 then
                                            table.insert(canAfford.missions, {product = v2, reason='mission'})
                                        end
                                    end
                                elseif v2.type=='defense' and z.mode ~='export' and z.mode ~='supply' and v2.cost > 0 then
                                    local g = Group.getByName(v2.name)
                                    if not g then
                                        table.insert(canAfford.defenses, {product = v2, reason='defense'})
                                    elseif g:getSize() < (g:getInitialSize()*math.random(40,100)/100) then
                                        table.insert(canAfford.defenses, {product = v2, reason='repair'})
                                    end
                                end
                            end
                        end
                    end
                end

                table.sort(canAfford.upgrades, function(a,b) return a.product.value > b.product.value end)
                table.sort(canAfford.defenses, function(a,b)
                    if a.reason == 'repair' and b.reason ~= 'repair' then return true end
                    if a.reason ~= 'repair' and b.reason == 'repair' then return false end
                    if a.reason == 'repair' and b.reason == 'repair' then return a.product.cost < b.product.cost end
                end)

                table.sort(canAfford.missions, function(a,b)
                    if a.product.missionType == ZoneCommand.missionTypes.supply_air then
                        if b.product.missionType == ZoneCommand.missionTypes.supply_convoy then return true end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_air then return a.product.cost < b.product.cost end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_transfer then return true end
                    end

                    if a.product.missionType == ZoneCommand.missionTypes.supply_convoy then
                        if b.product.missionType == ZoneCommand.missionTypes.supply_convoy then return a.product.cost < b.product.cost end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_air then return false end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_transfer then return true end
                    end

                    if a.product.missionType == ZoneCommand.missionTypes.supply_transfer then
                        if b.product.missionType == ZoneCommand.missionTypes.supply_convoy then return false end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_air then return false end
                        if b.product.missionType == ZoneCommand.missionTypes.supply_transfer then return a.product.cost < b.product.cost end
                    end
                end)

                if #canAfford.upgrades > 0 then
                    local p = nil
                    for _,u in ipairs(canAfford.upgrades) do
                        if z.resource >= u.product.cost then
                            p = u.product
                            break
                        end
                    end

                    if not p then
                        p = canAfford.upgrades[#canAfford.upgrades].product
                    end

                    z:queueBuild(p)
                else
                    if #canAfford.defenses > 0 then
                        if z.distToFront == 0 or #canAfford.missions == 0 then
                            local p = canAfford.defenses[1]
                            if p.reason == 'repair' then
                                z:queueBuild(p.product, true)
                            else
                                z:queueBuild(p.product)
                            end
                        else
                            if math.random() < 0.4 then
                                local p = canAfford.defenses[1]
                                if p.reason == 'repair' then
                                    z:queueBuild(p.product, true)
                                else
                                    z:queueBuild(p.product)
                                end
                            else
                                local p = canAfford.missions[1]
                                z:queueBuild(p.product)
                            end
                        end
                    elseif #canAfford.missions > 0 then
                        local p = canAfford.missions[1]
                        z:queueBuild(p.product)
                    end
                end
            end
        end
    end

    function Cameron:processBuilds(zones, requested)
        -- local msg = "Cameron - processBuilds: build requests:"
        -- for type, amount in pairs(requested) do
        --     msg = msg..'\n'..type..' - '..amount
        -- end
        -- env.info(msg)

        local canBuild = zones.canBuild
        local canRetask = {}

        for i,v in ipairs(zones.friendlyZones) do
            if v.currentBuild and v.currentBuild.product.type == 'mission' then
                local mistype = v.currentBuild.product.missionType
                if requested[mistype] and requested[mistype] > 0 then
                    requested[mistype] = requested[mistype] - 1
                end
            end

            if v.currentMissionBuild then
                local mistype = v.currentMissionBuild.product.missionType
                if requested[mistype] and requested[mistype] > 0 then
                    requested[mistype] = requested[mistype] - 1
                end

                if not requested[mistype] then
                    table.insert(canRetask, v)
                end
            end
        end

        if requested[ZoneCommand.missionTypes.supply_air] or requested[ZoneCommand.missionTypes.supply_convoy] then
            local remaining = {}

            for _,z in ipairs(canBuild) do
                if z:canBuild() then
                    local prod = nil
                    if requested[ZoneCommand.missionTypes.supply_air] and requested[ZoneCommand.missionTypes.supply_air] > 0 then
                        prod = z:getProductOfType(ZoneCommand.productTypes.mission, ZoneCommand.missionTypes.supply_air)
                    end

                    if not prod and requested[ZoneCommand.missionTypes.supply_convoy] and requested[ZoneCommand.missionTypes.supply_convoy] > 0 then
                        prod = z:getProductOfType(ZoneCommand.productTypes.mission, ZoneCommand.missionTypes.supply_convoy)
                    end

                    if prod and z:canBuildProduct(prod) and z.distToFront <= 1 then
                        z:queueBuild(prod)
                        requested[prod.missionType] = requested[prod.missionType] - 1
                    end
                end

                if z:canBuild() or z:canMissionBuild() then
                    table.insert(remaining, z)
                end
            end

            canBuild = remaining
        end

        local mainResRequests = pickMainBuilds(canBuild)

        local prioritized = {}
        for type,amount in pairs(requested) do
            table.insert(prioritized, {type = type, amount = amount})
        end

        table.sort(prioritized, function(a,b) return Cameron.misPriorities[a.type] < Cameron.misPriorities[b.type] end)

        for i, pr in ipairs(prioritized) do
            local type = pr.type
            local amount = pr.amount
            if amount > 0 then
                for _,z in ipairs(canBuild) do
                    if z:canMissionBuild() then
                        local p = z:getProductOfType('mission', type)
                        if p and z:canBuildProduct(p) then
                            z:queueBuild(p)
                            requested[type] = amount - 1
                        end
                    end
                end
            end
        end

        for _,z in ipairs(canBuild) do
            if z:canMissionBuild() and not z:criticalOnSupplies() then
                local canMission = {}
                for _,v in ipairs(z.upgrades[z.side]) do
                    if StrategicAI.isProductBuilt(v) then
                        for _,v2 in ipairs(v.products) do
                            if z:canBuildProduct(v2) and not StrategicAI.isProductBuilt(v2) and v2.type == 'mission' then 
                                if v2.missionType ~= ZoneCommand.missionTypes.assault or z.distToFront==0 then
                                    if math.random() < ZoneCommand.missionValidChance then
                                        table.insert(canMission, {product = v2, reason='mission'})
                                    end
                                end
                            end
                        end
                    end
                end
            
                if #canMission > 0 then
                    local choice = math.random(1, #canMission)
                    
                    if canMission[choice] then
                        local p = canMission[choice]
                        z:queueBuild(p.product)
                    end
                end
            end
        end

        -- local msg = "Cameron - processBuilds: remaining requests:"
        -- for type, amount in pairs(requested) do
        --     msg = msg..'\n'..type..' - '..amount
        -- end
        -- env.info(msg)
    end

    function Cameron:processObjective(objective)
        --env.info("Cameron - processObjective: procesing target "..objective.target.name)
        objective.requestedResources = {}
        objective.ticks = objective.ticks + 1
        if objective.ticks > self.maxTicks then return true end
        if objective.target.side == self.side then return true end
        if objective.target.distToFront ~=0 then return true end

        for i,v in pairs(objective.assignedResources) do
            if not isMissionActive(v) then
                objective.assignedResources[i] = nil
            end
        end

        if objective.target:hasEnemySAMRadar(self.side) then
            --env.info("Cameron - processObjective: "..objective.target.name.." has radar, requesting sead")
            ensureMission(objective, ZoneCommand.missionTypes.sead, self.side)
            
            --env.info("Cameron - processObjective: "..objective.target.name.." has radar, requesting cas")
            local cas = getMissionOfType(ZoneCommand.missionTypes.cas, objective.assignedResources, nil, objective.target.zone.point)
            local cas_helo = getMissionOfType(ZoneCommand.missionTypes.cas_helo, objective.assignedResources, nil, objective.target.zone.point)
            if not isMissionActive(cas) and not isMissionActive(cas_helo) then
                local activated = createMission(objective, ZoneCommand.missionTypes.cas_helo, self.side, cas_helo)
                if not activated then
                    createMission(objective, ZoneCommand.missionTypes.cas, self.side, cas)
                end
            end

            --env.info("Cameron - processObjective: "..objective.target.name.." has radar, requesting assault")
            ensureMission(objective, ZoneCommand.missionTypes.assault, self.side)
        else
            if objective.target.side ~= 0 and objective.target.side ~= self.side then
                --env.info("Cameron - processObjective: "..objective.target.name.." is enemy, requesting cap")
                ensureMission(objective, ZoneCommand.missionTypes.patrol, self.side)

                if objective.target:hasEnemyDefense(self.side) then
                    --env.info("Cameron - processObjective: "..objective.target.name.." has defenses, requesting cas")
                    local cas = getMissionOfType(ZoneCommand.missionTypes.cas, objective.assignedResources, nil, objective.target.zone.point)
                    local cas_helo = getMissionOfType(ZoneCommand.missionTypes.cas_helo, objective.assignedResources, nil, objective.target.zone.point)

                    if not isMissionActive(cas) and not isMissionActive(cas_helo) then
                        local activated = createMission(objective, ZoneCommand.missionTypes.cas_helo, self.side, cas_helo)
                        if not activated then
                            createMission(objective, ZoneCommand.missionTypes.cas, self.side, cas)
                        end
                    end

                    --env.info("Cameron - processObjective: "..objective.target.name.." has defenses, requesting assault")
                    ensureMission(objective, ZoneCommand.missionTypes.assault, self.side)
                end

                if objective.target:hasEnemyStructure(self.side) then
                    --env.info("Cameron - processObjective: "..objective.target.name.." has structures, requesting sead")
                    ensureMission(objective, ZoneCommand.missionTypes.strike, self.side)
                end
            elseif objective.target.side == 0 then
                --env.info("Cameron - processObjective: "..objective.target.name.." is neutral, requesting cap")
                ensureMission(objective, ZoneCommand.missionTypes.patrol, self.side)

                if objective.target:hasEnemyDefense(self.side) then
                    --env.info("Cameron - processObjective: "..objective.target.name.." has defenses, requesting cas")
                    local cas = getMissionOfType(ZoneCommand.missionTypes.cas, objective.assignedResources, nil, objective.target.zone.point)
                    local cas_helo = getMissionOfType(ZoneCommand.missionTypes.cas_helo, objective.assignedResources, nil, objective.target.zone.point)

                    if not isMissionActive(cas) and not isMissionActive(cas_helo) then
                        local activated = createMission(objective, ZoneCommand.missionTypes.cas_helo, self.side, cas_helo)
                        if not activated then
                            createMission(objective, ZoneCommand.missionTypes.cas, self.side)
                        end
                    end

                    --env.info("Cameron - processObjective: "..objective.target.name.." has defenses, requesting capture")
                    local assault = getMissionOfType(ZoneCommand.missionTypes.assault, objective.assignedResources, nil, objective.target.zone.point)
                    local sup_convoy = getMissionOfType(ZoneCommand.missionTypes.supply_convoy, objective.assignedResources, nil, objective.target.zone.point)
                    local sup_air = getMissionOfType(ZoneCommand.missionTypes.supply_air, objective.assignedResources, nil, objective.target.zone.point)

                    if not isMissionActive(assault) and not isMissionActive(sup_convoy) and not isMissionActive(sup_air) then
                        createMission(objective, ZoneCommand.missionTypes.assault, self.side)
                    end
                else
                    --env.info("Cameron - processObjective: "..objective.target.name.." does not have defenses, requesting capture")
                    local assault = getMissionOfType(ZoneCommand.missionTypes.assault, objective.assignedResources, nil, objective.target.zone.point)
                    local sup_convoy = getMissionOfType(ZoneCommand.missionTypes.supply_convoy, objective.assignedResources, nil, objective.target.zone.point)
                    local sup_air = getMissionOfType(ZoneCommand.missionTypes.supply_air, objective.assignedResources, nil, objective.target.zone.point)

                    if not isMissionActive(sup_convoy) and not isMissionActive(sup_air) and not isMissionActive(assault) then
                        --env.info("Cameron - processObjective: "..objective.target.name.." nothing on route, requesting air supply")
                        local activated = createMission(objective, ZoneCommand.missionTypes.supply_air, self.side)
                        if not activated then
                            --env.info("Cameron - processObjective: "..objective.target.name.." no air, requesting convoy")
                            createMission(objective, ZoneCommand.missionTypes.supply_convoy, self.side)
                        end
                    end
                end
            end
        end
    end

    function Cameron:createObjective(viableAttack)
        local existing = {}
        for _,v in ipairs(self.objectives) do
            existing[v.target.name]=true
        end

        local captureable = {}
        local attackable = {}
        for _,v in ipairs(viableAttack) do
            if not existing[v.name] then
                if v.side == 0 then
                    table.insert(captureable, v)
                elseif v.side ~= self.side then
                    table.insert(attackable, v)
                end
            end
        end

        local pick = nil
        if #captureable > 0 then
            pick = captureable[math.random(1, #captureable)]
        end

        if not pick then
            pick = attackable[math.random(1,#attackable)]
        end

        if pick then
            return {
                target = pick,
                requestedResources = {},
                assignedResources = {},
                ticks = 0
            }
        else
            return
        end
    end
end

-----------------[[ END OF StrategicAI/Cameron.lua ]]-----------------



-----------------[[ StrategicAI.lua ]]-----------------

StrategicAI = {}

do
    StrategicAI.resources = {
        [1] = {},
        [2] = {}
    }

    function StrategicAI.start()
        env.info("StrategicAI - starting")
        StrategicAI.blueAI = Cameron:new(2, true)
        StrategicAI.redAI = Cameron:new(1)
        timer.scheduleFunction(function(param,time)
            env.info('StrategicAI - culling invalid resources')

            for i,v in ipairs(StrategicAI.resources) do
                for i2,v2 in pairs(v) do
                    if v2.owner.side ~= v2.side then
                        v[i2] = nil
                        env.info('StrategicAI - removed '..v2.name..' as owner zone is no longer same side')
                    end
                end
            end

            env.info('StrategicAI - making decissions')
            StrategicAI.blueAI:makeDecissions()
            StrategicAI.redAI:makeDecissions()

            return time + 10
        end, nil, timer.getTime()+10)
    end

    function StrategicAI.activateMission(product, target)
		env.info('StrategicAI.activateMission - activating mission '..product.name..'('..product.display..')')
        local success = AIActivator.activateMission(product, target)
        if success then
            StrategicAI.resources[product.side][product.name] = nil
        else
		    env.info('StrategicAI.activateMission - failed to activate '..product.name..'('..product.display..')')
        end

        return success
	end

    function StrategicAI.isProductBuilt(product)
        local u = Group.getByName(product.name)
		if not u then u = StaticObject.getByName(product.name) end

        if u then return true end
        
        if StrategicAI.getResourceByName(product.name, product.side) then return true end
    end

    function StrategicAI.getResourceByName(name, side)
        if side then
            return StrategicAI.resources[side][name] 
        end

        if StrategicAI.resources[1][name] then return StrategicAI.resources[1][name] end
        if StrategicAI.resources[2][name] then return StrategicAI.resources[2][name] end
    end

    function StrategicAI.pushResource(product)
        env.info("StrategicAI - new mission available to deploy: "..product.name)
        local restable = StrategicAI.resources[product.side]
        restable[product.name] = product
    end

    function StrategicAI.tapResource(product)
        StrategicAI.resources[product.side][name]=nil
        env.info("StrategicAI - "..product.name.." tapped for use")
    end
end

-----------------[[ END OF StrategicAI.lua ]]-----------------



-----------------[[ AIActivator.lua ]]-----------------

AIActivator = {}

do
	local function teleportToPos(groupName, pos)
		if pos.y == nil then
			pos.y = land.getHeight({ x = pos.x, y = pos.z })
		end

		local vars = {
			groupName = groupName,
			point = pos,
			action = 'respawn',
			initTasks = false
		}

		mist.teleportToPoint(vars)
	end

    local function getDefaultPos(savedData, isAir)
		local action = 'Off Road'
		local speed = 0
		if isAir then
			action = 'Turning Point'
			speed = 250
		end

		local vars = {
			groupName = savedData.productName,
			point = savedData.position,
			action = 'respawn',
			heading = savedData.heading,
			initTasks = false,
			route = { 
				[1] = {
					alt = savedData.position.y,
					type = 'Turning Point',
					action = action,
					alt_type = 'BARO',
					x = savedData.position.x,
					y = savedData.position.z,
					speed = speed
				}
			}
		}

		return vars
	end

    function AIActivator.reAssignMission(product, target)
        local g = DependencyManager.get("GroupMonitor"):getGroup(product.name)
        if not g then return false end
        if not g.state then return false end
        
        local success = AIActivator.activateMission(product, target, { 
            productName = product.name,
            ownerName = product.owner.name,
            type = product.missionType,
            lastMission = { zoneName = target.name },
            spawnedSquad = g.spawnedSquad,
            targetName = target.name,
            homeName = product.owner.name,
            state = g.state,
            lastStateDuration = g.lastStateTime,
            supressSpawn = true
        })

        return success
    end

    function AIActivator.activateMission(product, target, saveData)
        local homePos = nil
        local deductCost = false

        local supplyTypes = {
            [ZoneCommand.missionTypes.supply_air] = 'air',
            [ZoneCommand.missionTypes.supply_convoy] = 'convoy',
            [ZoneCommand.missionTypes.supply_transfer] = 'transfer',
        }

        if not saveData and supplyTypes[product.missionType] then
            if not product.owner:canSupply(target, supplyTypes[product.missionType], product.capacity) then 
                env.info("AIActivator - activateMission "..product.owner.name.." can not afford "..product.capacity.." for "..product.name)
                return false 
            end
        end
        
        if product.missionType~=ZoneCommand.missionTypes.supply_transfer then
            if saveData then
                if not saveData.supressSpawn then
                    mist.teleportToPoint(getDefaultPos(saveData, true))
                end

                if saveData.lastMission.zoneName then
                    target = ZoneCommand.getZoneByName(saveData.lastMission.zoneName)
                elseif saveData.lastMission.baiTargets then
                    target = { baiTargets = {} }
                    for i,v in pairs(saveData.lastMission.baiTargets) do
                        target.baiTargets[i] = ZoneCommand.getZoneByName(v.ownerName):getProductByName(v.productName)
                    end
                end

                if saveData.homeName then
                    local hPos = trigger.misc.getZone(saveData.homeName).point
                    homePos = {homePos = hPos}
                end
            else
                local og = Utils.getOriginalGroup(product.name)
                if og then
                    teleportToPos(product.name, {x=og.x, z=og.y})
                    env.info("AIActivator - activateMission teleporting to OG pos")
                else
                    mist.respawnGroup(product.name, true)
                    env.info("AIActivator - activateMission fallback to respawnGroup")
                end

                deductCost = true
            end

            
            if target.baiTargets then
                product.lastMission = { baiTargets = {} }
                for i,v in pairs(target.baiTargets) do
                    product.lastMission.baiTargets[i] = { productName=v.name, ownerName=v.owner.name }
                end

                DependencyManager.get("GroupMonitor"):registerGroup(product, nil, product.owner, saveData)
            else
                product.lastMission = {zoneName = target.name}
                DependencyManager.get("GroupMonitor"):registerGroup(product, target, product.owner, saveData)
            end
        end

        if product.missionType==ZoneCommand.missionTypes.supply_convoy then
            AIActivator.activateSupplyConvoyMission(product, target, deductCost)
        elseif product.missionType==ZoneCommand.missionTypes.supply_air then
            AIActivator.activateAirSupplyMission(product, target, deductCost)
        elseif product.missionType==ZoneCommand.missionTypes.supply_transfer then
            AIActivator.activateSupplyTransfer(product, target)
        elseif product.missionType==ZoneCommand.missionTypes.patrol then
            AIActivator.activatePatrolMission(product, target, homePos)
        elseif product.missionType==ZoneCommand.missionTypes.cas then
            if target.baiTargets then
                AIActivator.activateBaiMission(product, target, homePos)
            else
                AIActivator.activateCasMission(product, target, homePos)
            end
        elseif product.missionType==ZoneCommand.missionTypes.cas_helo then
            AIActivator.activateCasMission(product, target, homePos)
        elseif product.missionType==ZoneCommand.missionTypes.sead then
            AIActivator.activateSeadMission(product, target, homePos)
        elseif product.missionType==ZoneCommand.missionTypes.strike then
            AIActivator.activateStrikeMission(product, target, homePos)
        elseif product.missionType==ZoneCommand.missionTypes.assault then
            AIActivator.activateAssaultMission(product, target)
        elseif product.missionType==ZoneCommand.missionTypes.awacs then
            AIActivator.activateAwacsMission(product, target, homePos)
        elseif product.missionType==ZoneCommand.missionTypes.tanker then
            AIActivator.activateTankerMission(product, target, homePos)
        end

        env.info("AIActivator - "..product.missionType.." - "..product.name.." from "..product.owner.name.." targeting "..target.name)

        return true
    end

    function AIActivator.activateTankerMission(product, target, homePos)
        timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.prod.name)
			if gr then
				local un = gr:getUnit(1)
				if un then 
					local callsign = un:getCallsign()
					RadioFrequencyTracker.registerRadio(param.prod.name, '[Tanker('..param.prod.variant..')] '..callsign, param.prod.freq..' AM | TCN '..param.prod.tacan..'X')
				end

				local point = trigger.misc.getZone(param.target.name).point
				product.lastMission = { zoneName = param.target.name }
				TaskExtensions.executeTankerMission(gr, point, param.prod.altitude, param.prod.freq, param.prod.tacan, param.homePos)
			end
		end, {prod=product, target=target, homePos = homePos}, timer.getTime()+1)
    end

    function AIActivator.activateAwacsMission(product, target, homePos)
        timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.prod.name)
			if gr then
				local un = gr:getUnit(1)
				if un then 
					local callsign = un:getCallsign()
					RadioFrequencyTracker.registerRadio(param.prod.name, '[AWACS] '..callsign, param.prod.freq..' AM')
				end

				local point = trigger.misc.getZone(param.target.name).point
				product.lastMission = { zoneName = param.target.name }
				TaskExtensions.executeAwacsMission(gr, point, param.prod.altitude, param.prod.freq, param.homePos)
				
			end
		end, {prod=product, target=target, homePos = homePos}, timer.getTime()+1)
    end

    function AIActivator.activateBaiMission(product, target, homePos)
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.prod.name)
            TaskExtensions.executeBaiMission(gr, param.targets, param.prod.expend, param.prod.altitude, param.homePos)
        end, {prod=product, targets=target.baiTargets, homePos = homePos}, timer.getTime()+1)
    end
    
    function AIActivator.activateAssaultMission(product, target)
		local tgtPoint = trigger.misc.getZone(target.name)
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.name)
            TaskExtensions.moveOnRoadToPointAndAssault(gr, param.point, param.targets)
        end, {name=product.name, point={ x=tgtPoint.point.x, y = tgtPoint.point.z}, targets=target.built}, timer.getTime()+1)
    end

    function AIActivator.activateStrikeMission(product, target, homePos)
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.prod.name)
            TaskExtensions.executeStrikeMission(gr, param.targets, param.prod.expend, param.prod.altitude, param.homePos)
        end, {prod=product, targets=target.built, homePos = homePos}, timer.getTime()+1)
    end
    
    function AIActivator.activateSeadMission(product, target, homePos)
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.prod.name)
            TaskExtensions.executeSeadMission(gr, param.targets, param.prod.expend, param.prod.altitude, param.homePos)
        end, {prod=product, targets=target.built, homePos = homePos}, timer.getTime()+1)
    end

    function AIActivator.activateCasMission(product, target, homePos)
        local ishelo = product.missionType == ZoneCommand.missionTypes.cas_helo
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.prod.name)
            if param.helo then
                TaskExtensions.executeHeloCasMission(gr, param.targets, param.prod.expend, param.prod.altitude, param.homePos)
            else
                TaskExtensions.executeCasMission(gr, param.targets, param.prod.expend, param.prod.altitude, param.homePos)
            end
        end, {prod=product, targets=target.built, helo = ishelo, homePos = homePos}, timer.getTime()+1)
    end

    function AIActivator.activatePatrolMission(product, target, homePos)
        timer.scheduleFunction(function(param)
            local gr = Group.getByName(param.prod.name)

            local point = trigger.misc.getZone(param.target.name).point

            TaskExtensions.executePatrolMission(gr, point, param.prod.altitude, param.prod.range, param.home)
        end, {prod=product, target = target, home=homePos}, timer.getTime()+1)
    end

    function AIActivator.activateSupplyTransfer(product, target)
        product.owner:removeResource(product.capacity)
        target:addResource(product.capacity)
		env.info('AIActivator - activateSupplyTransfer - '..product.owner.name..' transfered '..product.capacity..' to '..target.name)
    end

    function AIActivator.activateAirSupplyMission(product, target, deductCost)

        local supplyPoint = trigger.misc.getZone(target.name..'-hsp')
        if not supplyPoint then
            supplyPoint = trigger.misc.getZone(target.name)
        end

        if supplyPoint then 
            if deductCost then
                product.owner:removeResource(product.capacity)
            end

            local alt = DependencyManager.get("ConnectionManager"):getHeliAlt(product.owner.name, target.name)
            timer.scheduleFunction(function(param)
                local gr = Group.getByName(param.name)
                TaskExtensions.landAtPoint(gr, param.point, param.alt)
            end, {name=product.name, point={ x=supplyPoint.point.x, y = supplyPoint.point.z}, alt = alt}, timer.getTime()+1)
        end
    end

    function AIActivator.activateSupplyConvoyMission(product, target, deductCost)

        local supplyPoint = trigger.misc.getZone(target.name..'-sp')
        if not supplyPoint then
            supplyPoint = trigger.misc.getZone(target.name)
        end
        
        if supplyPoint then 
            if deductCost then
                product.owner:removeResource(product.capacity)
            end

            product.lastMission = {zoneName = target.name}
            timer.scheduleFunction(function(param)
                local gr = Group.getByName(param.name)
                TaskExtensions.moveOnRoadToPoint(gr, param.point)
            end, {name=product.name, point={ x=supplyPoint.point.x, y = supplyPoint.point.z}}, timer.getTime()+1)
        end
    end
end

-----------------[[ END OF AIActivator.lua ]]-----------------



-----------------[[ ZoneCommand.lua ]]-----------------

ZoneCommand = {}
do
	ZoneCommand.currentZoneIndex = 1000
	ZoneCommand.allZones = {}
	ZoneCommand.buildSpeed = Config.buildSpeed
	ZoneCommand.missionValidChance = 0.9
	ZoneCommand.missionBuildSpeedReduction = Config.missionBuildSpeedReduction
	ZoneCommand.revealTime = 0
	ZoneCommand.staticRegistry = {}

	ZoneCommand.modes = {
		normal = 'normal',
		supply = 'supply',
		export = 'export'
	}
	
	ZoneCommand.productTypes = {
		upgrade = 'upgrade',
		mission = 'mission',
		defense = 'defense'
	}
	
	ZoneCommand.missionTypes = {
		supply_air = 'supply_air',
		supply_convoy = 'supply_convoy',
		cas = 'cas',
		cas_helo = 'cas_helo',
		strike = 'strike',
		patrol = 'patrol',
		sead = 'sead',
		assault = 'assault',
		supply_transfer = 'supply_transfer',
		awacs = 'awacs',
		tanker = 'tanker'
	}
	
	function ZoneCommand:new(zonename)
		local obj = {}
		obj.name = zonename
		obj.side = 0
		obj.resource = 0
		obj.resourceChange = 0
		obj.maxResource = 20000
		obj.spendTreshold = 5000
		obj.keepActive = false
		obj.boostScale = 1.0
		obj.extraBuildResources = 0
		obj.sabotageDebt = 0
		obj.reservedMissions = {}
		obj.isHeloSpawn = false
		obj.isPlaneSpawn = false
		obj.spawnSurface = nil
		
		obj.zone = CustomZone:getByName(zonename)
		obj.products = {}
		obj.mode = 'normal' 
		--[[
			normal: buys whatever it can
			supply: buys only supply missions
			export: supply mode, but also sells all defense groups from the zone
		]]--
		obj.index = ZoneCommand.currentZoneIndex
		ZoneCommand.currentZoneIndex = ZoneCommand.currentZoneIndex + 1
		
		obj.built = {}
		obj.income = 0
				
		--draw graphics
		local color = {0.7,0.7,0.7,0.3}
		if obj.side == 1 then
			color = {1,0,0,0.3}
		elseif obj.side == 2 then
			color = {0,0,1,0.3}
		end
		
		obj.zone:draw(obj.index, color, color)
		
		local point = obj.zone.point

		if obj.zone:isCircle() then
			point = {
				x = obj.zone.point.x,
				y = obj.zone.point.y,
				z = obj.zone.point.z + obj.zone.radius
			}
		elseif obj.zone:isQuad() then
			local largestZ = obj.zone.vertices[1].z
			local largestX = obj.zone.vertices[1].x
			for i=2,4,1 do
				if obj.zone.vertices[i].z > largestZ then
					largestZ = obj.zone.vertices[i].z
					largestX = obj.zone.vertices[i].x
				end
			end
			
			point = {
				x = largestX,
				y = obj.zone.point.y,
				z = largestZ
			}
		end
		
		--trigger.action.textToAll(1,1000+obj.index,point, {0,0,0,0.8}, {1,1,1,0.5}, 15, true, '')
		--trigger.action.textToAll(2,2000+obj.index,point, {0,0,0,0.8}, {1,1,1,0.5}, 15, true, '')
		trigger.action.textToAll(-1,2000+obj.index,point, {0,0,0,0.8}, {1,1,1,0.5}, 15, true, '') --show blue to all
		setmetatable(obj, self)
		self.__index = self
		
		obj:refreshText()
		obj:start()
		ZoneCommand.allZones[obj.name] = obj
		return obj
	end
	
	function ZoneCommand.setNeighbours()
		local conManager = DependencyManager.get("ConnectionManager")
		for name,zone in pairs(ZoneCommand.allZones) do
			local neighbours = conManager:getConnectionsOfZone(name)
			zone.neighbours = {}
			for _,zname in ipairs(neighbours) do
				zone.neighbours[zname] = ZoneCommand.getZoneByName(zname)
			end
		end
	end
	
	function ZoneCommand.getZoneByName(name)
		if not name then return nil end
		return ZoneCommand.allZones[name]
	end
	
	function ZoneCommand.getAllZones()
		return ZoneCommand.allZones
	end
	
	function ZoneCommand.getZoneOfUnit(unitname)
		local un = Unit.getByName(unitname)
		
		if not un then 
			return nil
		end
		
		for i,v in pairs(ZoneCommand.allZones) do
			if Utils.isInZone(un, i) then
				return v
			end
		end
		
		return nil
	end
	
	function ZoneCommand.getZoneOfWeapon(weapon)
		if not weapon then 
			return nil
		end
		
		for i,v in pairs(ZoneCommand.allZones) do
			if Utils.isInZone(weapon, i) then
				return v
			end
		end
		
		return nil
	end

	function ZoneCommand.getClosestZoneToPoint(point, side, invert)
		local minDist = 9999999
		local closest = nil
		for i,v in pairs(ZoneCommand.allZones) do
			if not side or (not invert and side == v.side) or (invert and side ~= v.side) then
				local d = mist.utils.get2DDist(v.zone.point, point)
				if d < minDist then
					minDist = d
					closest = v
				end
			end
		end
		
		return closest, minDist
	end
	
	function ZoneCommand.getZoneOfPoint(point)
		for i,v in pairs(ZoneCommand.allZones) do
			local z = CustomZone:getByName(i)
			if z and z:isInside(point) then
				return v
			end
		end
		
		return nil
	end

	function ZoneCommand:boostProduction(amount)
		self.extraBuildResources = self.extraBuildResources + amount
		env.info('ZoneCommand:boostProduction - '..self.name..' production boosted by '..amount..' to a total of '..self.extraBuildResources)
	end

	function ZoneCommand:getProductOfType(type, mistype)
		local prods = {}
		for i,v in ipairs(self.upgrades) do
			if v.type == type then 
				prods[v.name] = v
			end

			for i2,v2 in ipairs(v) do
				for i3,v3 in ipairs(v2.products) do
					if v3.type == type then
						if mistype then 
							if v3.missionType == mistype then
								prods[v3.name] = v3
							end
						else
							prods[v3.name] = v3
						end
					end
				end
			end
		end

		for _,v in pairs(prods) do
			if not StrategicAI.isProductBuilt(v) then
				return v
			end
		end
	end

	function ZoneCommand:pushMisOfType(mistype) 
		local aimises = {}
		for i,v in ipairs(self.upgrades) do
			for i2,v2 in ipairs(v) do
				for i3,v3 in ipairs(v2.products) do
					if v3.type == 'mission' then 
						if v3.missionType == mistype then
							aimises[v3.name] = v3
						end
					end
				end
			end
		end

		for _,v in pairs(aimises) do
			if not StrategicAI.isProductBuilt(v) then
				StrategicAI.pushResource(v)
				break
			end
		end
	end

	function ZoneCommand:canSupply(target, type, amount)
		if target.side~=0 and self.side ~= target.side then return false end
		
		if self:criticalOnSupplies() then return false end
		
		--if self.resource - amount <= self.spendTreshold then return false end

		if target.side ~= 0 then
			if target:criticalOnSupplies() then
				if self.distToFront < target.distToFront then return false end
			else
				if self.distToFront <= target.distToFront then return false end
			end

			if (self.resource*2) < target.resource then return false end
		end
		
		if self.resource < amount then return false end
		
		if type=='air' then
			local dist = mist.utils.get2DDist(self.zone.point, target.zone.point)
			if dist > 50000 then return false end
		elseif type=='convoy' then
			if not self.neighbours[target.name] then return false end
			if DependencyManager.get("ConnectionManager"):isRoadBlocked(self.name, target.name) then return false end
		elseif type=='transfer' then
			if target.side ~= self.side then return false end
			if not self.neighbours[target.name] then return false end
		end
		
		return true
	end

	function ZoneCommand:canAttack(target, type)
		if target.side == self.side then return false end

		if type=='assault' then
			if not self.neighbours[target.name] then return false end
			if DependencyManager.get("ConnectionManager"):isRoadBlocked(self.name, target.name) then return false end
		elseif type=='cas_helo' then
			local dist = mist.utils.get2DDist(self.zone.point, target.zone.point)
			if dist > 50000 then return false end
		end

		return true
	end

	function ZoneCommand:sabotage(explosionSize, sourcePoint)
		local minDist = 99999999
		local closest = nil
		for i,v in pairs(self.built) do
			if v.type == 'upgrade' then
				local st = StaticObject.getByName(v.name)
				if not st then st = Group.getByName(v.name) end
				local pos = st:getPoint()

				local d = mist.utils.get2DDist(pos, sourcePoint)
				if d < minDist then
					minDist = d;
					closest = pos
				end
			end
		end

		if closest then
			trigger.action.explosion(closest, explosionSize)
			env.info('ZoneCommand:sabotage - Structure has been sabotaged at '..self.name)
		end

		local damagedResources = math.random(2000,5000)
		self.sabotageDebt = damagedResources
		self:refreshText()
	end

	local function missionToSymbol(type)
		if type == ZoneCommand.missionTypes.supply_transfer then return 'x' end
		if type == ZoneCommand.missionTypes.supply_air then return 's' end
		if type == ZoneCommand.missionTypes.supply_convoy then return 's' end
		if type == ZoneCommand.missionTypes.assault then return 't' end
		if type == ZoneCommand.missionTypes.awacs then return 'a' end
		if type == ZoneCommand.missionTypes.cas then return 'c' end
		if type == ZoneCommand.missionTypes.cas_helo then return 'c' end
		if type == ZoneCommand.missionTypes.patrol then return 'f' end
		if type == ZoneCommand.missionTypes.sead then return 'r' end
		if type == ZoneCommand.missionTypes.strike then return 'b' end
		if type == ZoneCommand.missionTypes.tanker then return 'g' end

		return 'o'
	end
	
	function ZoneCommand:refreshText()
		local build = ''
		if self.currentBuild then
			local job = ''
			local display = self.currentBuild.product.display
			if self.currentBuild.product.type == 'upgrade' then
				job = display
			elseif self.currentBuild.product.type == 'defense' then
				if self.currentBuild.isRepair then
					job = display..' (repair)'
				else
					job = display
				end
			elseif self.currentBuild.product.type == 'mission' then
				job = display
			end
			
			build = '\n['..job..' '..math.min(math.floor((self.currentBuild.progress/self.currentBuild.product.cost)*100),100)..'%]'
		end

		local mBuild = ''
		if self.currentMissionBuild then
			local job = ''
			local display = self.currentMissionBuild.product.display
			job = display
			
			mBuild = '\n['..job..' '..math.min(math.floor((self.currentMissionBuild.progress/self.currentMissionBuild.product.cost)*100),100)..'%]'
		end

		if self.sabotageDebt > 0 then
			build = '\n[Sabotaged]'
			mBuild = ''
		end
		
		local status=''
		if self.side ~= 0 and self:criticalOnSupplies() then
			status = '(!)'
		end

		local color = {0.3,0.3,0.3,1}
		if self.side == 1 then
			color = {0.7,0,0,1}
		elseif self.side == 2 then
			color = {0,0,0.7,1}
		end

		local readyToDeploy = ''
		if Config.showInventory and self.side ~= 0 then
			for i,v in pairs(StrategicAI.resources[self.side]) do
				if v.owner.name == self.name then
					readyToDeploy = readyToDeploy..missionToSymbol(v.missionType)
				end
			end
		end

		--trigger.action.setMarkupColor(1000+self.index, color)
		trigger.action.setMarkupColor(2000+self.index, color)

		local label = '['..self.resource..'/'..self.maxResource..']'..status..build..mBuild

		if #readyToDeploy > 0 then
			label = label..'\n'..readyToDeploy
		end

		if self.side == 1 then
			--trigger.action.setMarkupText(1000+self.index, self.name..label)

			if self.revealTime > 0 then
				trigger.action.setMarkupText(2000+self.index, self.name..label)
			else
				trigger.action.setMarkupText(2000+self.index, self.name)
			end
		elseif self.side == 2 then
			--if self.revealTime > 0 then
			--	trigger.action.setMarkupText(1000+self.index, self.name..label)
			--else
			--	trigger.action.setMarkupText(1000+self.index, self.name)
			--end
			trigger.action.setMarkupText(2000+self.index, self.name..label)
		elseif self.side == 0 then
			--trigger.action.setMarkupText(1000+self.index, ' '..self.name..' ')
			trigger.action.setMarkupText(2000+self.index, ' '..self.name..' ')
		end
	end
	
	function ZoneCommand:setSide(side)
		self.side = side

		if self.side == 0 then
			self.revealTime = 0
			
			self.resource = 0
			self.extraBuildResources = 0
			self.sabotageDebt = 0
			self.mode = 'normal'
			self.currentBuild = nil
			self.currentMissionBuild = nil
		end

		local color = {0.7,0.7,0.7,0.3}
		if self.side==1 then
			color = {1,0,0,0.3}
		elseif self.side==2 then
			color = {0,0,1,0.3}
		end
		
		trigger.action.setMarkupColorFill(self.index, color)
		trigger.action.setMarkupColor(self.index, color)
		trigger.action.setMarkupTypeLine(self.index, 1)

		if self.side == 2 and (self.isHeloSpawn or self.isPlaneSpawn) then
			trigger.action.setMarkupTypeLine(self.index, 2)
			trigger.action.setMarkupColor(self.index, {0,1,0,1})
		end

		self:refreshText()

		if self.airbaseName then
			local ab = Airbase.getByName(self.airbaseName)
			if ab then
				if ab:autoCaptureIsOn() then ab:autoCapture(false) end
				ab:setCoalition(self.side)
			else
				for i=1,10,1 do
					local ab = Airbase.getByName(self.airbaseName..'-'..i)
					if ab then
						if ab:autoCaptureIsOn() then ab:autoCapture(false) end
						ab:setCoalition(self.side)
					end
				end
			end
		end
	end
	
	function ZoneCommand:addResource(amount)
		self.resource = self.resource+amount
		self.resource = math.floor(math.min(self.resource, self.maxResource))
	end
	
	function ZoneCommand:removeResource(amount)
		self.resource = self.resource-amount
		self.resource = math.floor(math.max(self.resource, 0))
	end

	function ZoneCommand:reveal(time)
		local revtime = 60
		if time then
			revtime = time
		end

		self.revealTime = 60*revtime
		self:refreshText()
	end
	
	function ZoneCommand:needsSupplies(sendamount)
		return self.resource + sendamount<self.maxResource
	end
	
	function ZoneCommand:criticalOnSupplies()
		return self.resource<=self.spendTreshold
	end
	
	function ZoneCommand:capture(side, isSetup)
		if self.side == 0 then
			if not isSetup then
				local sidetxt = "Neutral"
				if side == 1 then
					sidetxt = "Red"
				elseif side == 2 then
					sidetxt = "Blue"
				end

				--trigger.action.outText(self.name.." has been captured by "..sidetxt, 15)
				
				local sourcePos = {
					x = self.zone.point.x,
					y = 9144,
					z = self.zone.point.z,
				}

				if side == 1 then
					if math.random()>0.5 then
						TransmissionManager.queueMultiple({'zones.events.capturedbythem.1','zones.names.'..self.name}, TransmissionManager.radios.command, sourcePos)
					else
						TransmissionManager.queueMultiple({'zones.names.'..self.name,'zones.events.capturedbythem.2'}, TransmissionManager.radios.command, sourcePos)
					end
				elseif side == 2 then
					if math.random()>0.5 then
						TransmissionManager.queueMultiple({'zones.events.capturedbyus.1','zones.names.'..self.name}, TransmissionManager.radios.command, sourcePos)
					else
						TransmissionManager.queueMultiple({'zones.names.'..self.name, 'zones.events.capturedbyus.2'}, TransmissionManager.radios.command, sourcePos)
					end
				end
			end
			self:setSide(side)
			local p = self.upgrades[side][1]
			self:instantBuild(p)
			if not isSetup then
				for i,v in pairs(p.products) do
					if v.cost < 0 then
						self:instantBuild(v)
					end
				end
			end
		end
	end
	
	function ZoneCommand:instantBuild(product)
		if product.type == 'defense' or product.type == 'upgrade' then
			env.info('ZoneCommand: instantBuild ['..product.name..']')
			if self.built[product.name] == nil then
				self.zone:spawnGroup(product, self.spawnSurface)
				self.built[product.name] = product
			end
		end
	end
	
	function ZoneCommand:fullUpgrade(resourcePercentage)
		if not resourcePercentage then resourcePercentage = 0.25 end
		self.resource = math.floor(self.maxResource*resourcePercentage)
		self:fullBuild()
	end

	function ZoneCommand:fullBuild(useCost)
		if self.side ~= 1 and self.side ~= 2 then return end

		for i,v in ipairs(self.upgrades[self.side]) do
			if useCost then
				local cost = v.cost * useCost
				if self.resource >= cost then
					self:removeResource(cost)
				else
					break
				end
			end

			self:instantBuild(v)

			for i2,v2 in ipairs(v.products) do
				if (v2.type == 'defense' or v2.type=='upgrade') and v2.cost > 0 then
					if useCost then
						local cost = v2.cost * useCost
						if self.resource >= cost then
							self:removeResource(cost)
						else
							break
						end
					end

					self:instantBuild(v2)
				end
			end
		end
	end
	
	function ZoneCommand:start()
		timer.scheduleFunction(function(param, time)
			local self = param.context
			local initialRes = self.resource
			
			--generate income
			if self.side ~= 0 then
				self:addResource(self.income)
			end
			
			--untrack destroyed zone upgrades
			for i,v in pairs(self.built) do
				local u = Group.getByName(i)
				if u and u:getSize() == 0 then
					u:destroy()
					self.built[i] = nil
				end
				
				if not u then
					u = StaticObject.getByName(i)
					if u and u:getLife()<1 then
						u:destroy()
						self.built[i] = nil
					end
				end
				
				if not u then 
					self.built[i] = nil
				end
			end
			
			--upkeep costs for defenses
			for i,v in pairs(self.built) do
				if v.type == 'defense' and v.upkeep then
					v.strikes = v.strikes or 0
					if self.resource >= v.upkeep then
						self:removeResource(v.upkeep)
						v.strikes = 0
					else
						if v.strikes < 6 then
							v.strikes = v.strikes+1
						else
							local u = Group.getByName(i)
							if u then 
								v.strikes = nil
								u:destroy()
								self.built[i] = nil
							end
						end
					end
				elseif v.type == 'upgrade' and v.income then
					self:addResource(v.income)
				end
			end
			
			--check if zone should be reverted to neutral
			local hasUpgrade = false
			for i,v in pairs(self.built) do
				if v.type=='upgrade' then
					hasUpgrade = true
					break
				end
			end
			
			if not hasUpgrade and self.side ~= 0 then
				local sidetxt = "Neutral"
				if self.side == 1 then
					sidetxt = "Red"
				elseif self.side == 2 then
					sidetxt = "Blue"
				end

				--trigger.action.outText(sidetxt.." has lost control of "..self.name, 15)
				local sourcePos = {
					x = self.zone.point.x,
					y = 9144,
					z = self.zone.point.z,
				}

				if self.side == 2 then
					if math.random()>0.5 then
						TransmissionManager.queueMultiple({'zones.events.lost.1', 'zones.names.'..self.name}, TransmissionManager.radios.command, sourcePos)
					else
						TransmissionManager.queueMultiple({'zones.names.'..self.name, 'zones.events.lost.2'}, TransmissionManager.radios.command, sourcePos)
					end
				elseif self.side == 1 then
					if math.random()>0.5 then
						TransmissionManager.queueMultiple({'zones.events.lostbythem.1', 'zones.names.'..self.name}, TransmissionManager.radios.command, sourcePos)
					else
						TransmissionManager.queueMultiple({'zones.names.'..self.name, 'zones.events.lostbythem.2'}, TransmissionManager.radios.command, sourcePos)
					end
				end

				self:setSide(0)
			end
			
			--sell defenses if export mode
			if self.side ~= 0 and self.mode == 'export' then
				for i,v in pairs(self.built) do
					if v.type=='defense' then
						local g = Group.getByName(i)
						if g then g:destroy() end
						self:addResource(math.floor(v.cost/2))
						self.built[i] = nil
					end
				end
			end
			
			self:progressBuild()
			
			self.resourceChange = self.resource - initialRes
			self:refreshText()
			
			--use revealTime resource
			if self.revealTime > 0 then
				self.revealTime = math.max(0,self.revealTime-10)
			end

			return time+10
		end, {context = self}, timer.getTime()+1)
	end
	
	function ZoneCommand:progressBuild()
		self:progressMainBuild()
		self:progressMissionBuild()
	end

	function ZoneCommand:progressMainBuild()
		if not self.currentBuild then return end

		if self.currentBuild and self.currentBuild.product.side ~= self.side then
			env.info('ZoneCommand:progressBuild '..self.name..' - stopping build, zone changed owner')
			self.currentBuild = nil
			return
		end

		if not self:canBuildProduct(self.currentBuild.product) then 
			env.info('ZoneCommand:progressBuild '..self.name..' - stopping build, zone lost ability to build current product')
			self.currentBuild = nil
			return
		end

		if self.currentBuild then
			local cost = self.currentBuild.product.cost
			if self.currentBuild.isRepair then
				cost = math.floor(self.currentBuild.product.cost/2)
			end
			
			if self.currentBuild.progress < cost then
				if self.currentBuild.isRepair and not Group.getByName(self.currentBuild.product.name) then
					env.info('ZoneCommand:progressBuild '..self.name..' - stopping build, group to repair no longer exists')
					self.currentBuild = nil
				else
					if self.currentBuild.isRepair then
						local gr = Group.getByName(self.currentBuild.product.name)
						if gr and self.currentBuild.unitcount and gr:getSize() < self.currentBuild.unitcount then
							env.info('ZoneCommand:progressBuild '..self.name..' - restarting build, group to repair has casualties')
							self.currentBuild.unitcount = gr:getSize()
							self:addResource(self.currentBuild.progress)
							self.currentBuild.progress = 0
						end
					end

					local step = math.floor(ZoneCommand.buildSpeed * self.boostScale)
					if step > self.resource then step = 1 end
					
					if step <= self.resource then
						self:removeResource(step)

						if self.sabotageDebt > 0 then
							self.sabotageDebt = math.max(self.sabotageDebt - step, 0)
							env.info('ZoneCommand:progressBuild - '..self.name..' consumed '..step..' resources for sabotage repair, remaining '..self.sabotageDebt)
						else
							local actualStep = step
							if self.currentBuild.product.type == 'mission' then
								local progress = step*self.missionBuildSpeedReduction
								actualStep = math.max(1, math.floor(progress))
							end

							self.currentBuild.progress = self.currentBuild.progress + actualStep
							
							if self.extraBuildResources > 0 then
								local extrastep = step
								if self.extraBuildResources < extrastep then
									extrastep = self.extraBuildResources
								end
								
								self.extraBuildResources = math.max(self.extraBuildResources - extrastep, 0)

								local actualExtraStep = extrastep
								if self.currentBuild.product.type == 'mission' then
									local progress = extrastep*self.missionBuildSpeedReduction
									actualExtraStep = math.max(1, math.floor(progress))
								end
								self.currentBuild.progress = self.currentBuild.progress + actualExtraStep
								
								env.info('ZoneCommand:progressBuild - '..self.name..' consumed '..extrastep..' extra resources, remaining '..self.extraBuildResources)
							end
						end
					end
				end
			else
				if self.currentBuild.product.type == 'mission' then
					StrategicAI.pushResource(self.currentBuild.product)
				elseif self.currentBuild.product.type == 'defense' or self.currentBuild.product.type == 'upgrade' then
					if self.currentBuild.isRepair then
						if Group.getByName(self.currentBuild.product.name) then
							self.zone:spawnGroup(self.currentBuild.product, self.spawnSurface)
						end
					else
						self.zone:spawnGroup(self.currentBuild.product, self.spawnSurface)
					end
					
					self.built[self.currentBuild.product.name] = self.currentBuild.product
				end

				self.currentBuild = nil
			end
		end
	end

	function ZoneCommand:progressMissionBuild()
		if not self.currentMissionBuild then return end

		if self.sabotageDebt > 0 then return end

		if self.currentMissionBuild and self.currentMissionBuild.product.side ~= self.side then
			env.info('ZoneCommand:progressBuild '..self.name..' - stopping mission build, zone changed owner')
			self.currentMissionBuild = nil
			return
		end

		if not self:canBuildProduct(self.currentMissionBuild.product) then 
			env.info('ZoneCommand:progressBuild '..self.name..' - stopping build, zone lost ability to build current product')
			self.currentMissionBuild = nil
			return
		end

		local cost = self.currentMissionBuild.product.cost
			
		if self.currentMissionBuild.progress < cost then
			local step = math.floor(ZoneCommand.buildSpeed * self.boostScale)

			if step > self.resource then step = 1 end

			local progress = step*self.missionBuildSpeedReduction
			local reducedCost = math.max(1, math.floor(progress))
			if reducedCost <= self.resource and self.sabotageDebt == 0 then
				self:removeResource(reducedCost)
				self.currentMissionBuild.progress = self.currentMissionBuild.progress + progress
			end
		else
			StrategicAI.pushResource(self.currentMissionBuild.product)
			self.currentMissionBuild = nil
		end
	end
	
	function ZoneCommand:queueBuild(product, isRepair, progress)

		local mainQueueTypes = {
			[ZoneCommand.productTypes.upgrade] = true,
			[ZoneCommand.productTypes.defense] = true,
		}
		
		local supplyTypes = {
			[ZoneCommand.missionTypes.supply_air] = true,
			[ZoneCommand.missionTypes.supply_convoy] = true,
			[ZoneCommand.missionTypes.supply_transfer] = true,
		}

		if not self:canBuildProduct(product) then return false end
		
		if mainQueueTypes[product.type] or (product.type==ZoneCommand.productTypes.mission and supplyTypes[product.missionType]) and self.currentBuild==nil then
			local unitcount = nil
			if isRepair then
				local g = Group.getByName(product.name)
				if g then
					unitcount = g:getSize()
					env.info('ZoneCommand:queueBuild - '..self.name..' '..product.name..' has '..unitcount..' units')
				end
			end

			self.currentBuild = { product = product, progress = (progress or 0), isRepair = isRepair, unitcount = unitcount}
			env.info('ZoneCommand:queueBuild - '..self.name..' starting '..product.name..'('..product.display..') as its build')
			return true
		elseif product.type == ZoneCommand.productTypes.mission and not supplyTypes[product.missionType] and self.currentMissionBuild==nil then
			self.currentMissionBuild = { product = product, progress = (progress or 0)}
			env.info('ZoneCommand:queueBuild - '..self.name..' starting '..product.name..'('..product.display..') as its mission build')
			return true
		end
	end

	function ZoneCommand:requirementsMet(product)
		for _,v in ipairs(self.upgrades[self.side]) do
			local u = Group.getByName(v.name)
			if not u then u = StaticObject.getByName(v.name) end
			
			if not u then
				if v.name == product.name then
					return true
				end
			elseif u ~= nil then
				for _,v2 in ipairs(v.products) do
					if v2.name == product.name then
						return true
					end
				end
			end
		end

		return false
	end

	function ZoneCommand:canBuildProduct(product)
		if product.side ~= self.side then return false end

		if product.type == ZoneCommand.productTypes.upgrade then
			if self.built[product.name] == nil then return self:requirementsMet(product) end
		elseif product.type == ZoneCommand.productTypes.defense then
			if self.built[product.name] == nil then
				return self:requirementsMet(product)
			else
				local g = Group.getByName(product.name)
				if g and g:isExist() and g:getSize() < g:getInitialSize() then
					return self:requirementsMet(product)
				end
			end
		elseif product.type == ZoneCommand.productTypes.mission then
			if not StrategicAI.isProductBuilt(product) then
				return self:requirementsMet(product)
			end
		end

		return false
	end

	function ZoneCommand:canBuild()
		if not self.currentBuild then return true end
	end

	function ZoneCommand:canMissionBuild()
		if not self.keepActive and self.mode ~= 'normal' then return false end
		if self.currentMissionBuild then return false end

		return true
	end

	function ZoneCommand:isNeighbour(zone)
		return self.neighbours[zone.name] ~= nil
	end

	function ZoneCommand:hasEnemySAMRadar(myside)
		if myside == 1 then
			return self:hasSAMRadarOnSide(2)
		elseif myside == 2 then
			return self:hasSAMRadarOnSide(1)
		end
	end

	function ZoneCommand:hasEnemyDefense(myside)
		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.defense and v.side ~= myside then 
				return true
			end
		end
	end

	function ZoneCommand:hasEnemyStructure(myside)
		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.upgrade and v.side ~= myside then 
				return true
			end
		end
	end

	function ZoneCommand:hasSAMRadarOnSide(side)
		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.defense and v.side == side then 
				local gr = Group.getByName(v.name)
				if gr then
					for _,unit in ipairs(gr:getUnits()) do
						if unit:hasAttribute('SAM SR') or unit:hasAttribute('SAM TR') then
							return true
						end
					end
				end
			end
		end
	end

	function ZoneCommand:hasRunway()
		local zones = self:getRunwayZones()
		return #zones > 0
	end

	function ZoneCommand:getRunwayZones()
		local runways = {}
		for i=1,10,1 do
			local name = self.name..'-runway-'..i
			local zone = trigger.misc.getZone(name)
			if zone then 
				runways[i] = {name = name, zone = zone}
			else
				break
			end
		end

		return runways
	end

	function ZoneCommand:getRandomUnitWithAttributeOnSide(attributes, side)
		local available = {}
		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.upgrade and v.side == side then
				local st = StaticObject.getByName(v.name)
				if st then
					for _,a in ipairs(attributes) do
						if a == "Buildings" and ZoneCommand.staticRegistry[v.name] then -- dcs does not consider all statics buildings so we compensate
							table.insert(available, v)
						end
					end
				end
			elseif v.type == ZoneCommand.productTypes.defense and v.side == side then 
				local gr = Group.getByName(v.name)
				if gr then
					for _,unit in ipairs(gr:getUnits()) do
						for _,a in ipairs(attributes) do
							if unit:hasAttribute(a) then
								table.insert(available, v)
							end
						end
					end
				end
			end
		end

		if #available > 0 then
			return available[math.random(1, #available)]
		end
	end

	function ZoneCommand:hasUnitWithAttributeOnSide(attributes, side, amount)
		local count = 0

		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.upgrade and v.side == side then
				local st = StaticObject.getByName(v.name)
				if st and st:isExist() then
					for _,a in ipairs(attributes) do
						if a == "Buildings" and ZoneCommand.staticRegistry[v.name] then -- dcs does not consider all statics buildings so we compensate
							if amount==nil then
								return true
							else
								count = count + 1
								if count >= amount then return true end
							end
						end
					end
				end
			elseif v.type == ZoneCommand.productTypes.defense and v.side == side then 
				local gr = Group.getByName(v.name)
				if gr then
					for _,unit in ipairs(gr:getUnits()) do
						if unit:isExist() then
							for _,a in ipairs(attributes) do
								if unit:hasAttribute(a) then
									if amount==nil then
										return true
									else
										count = count + 1
										if count >= amount then return true end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function ZoneCommand:getUnitCountWithAttributeOnSide(attributes, side)
		local count = 0

		for i,v in pairs(self.built) do
			if v.type == ZoneCommand.productTypes.upgrade and v.side == side then
				local st = StaticObject.getByName(v.name)
				if st then
					for _,a in ipairs(attributes) do
						if a == "Buildings" and ZoneCommand.staticRegistry[v.name] then
							count = count + 1
							break
						end
					end
				end
			elseif v.type == ZoneCommand.productTypes.defense and v.side == side then 
				local gr = Group.getByName(v.name)
				if gr then
					for _,unit in ipairs(gr:getUnits()) do
						for _,a in ipairs(attributes) do
							if unit:hasAttribute(a) then
								count = count + 1
								break
							end
						end
					end
				end
			end
		end

		return count
	end
	
	function ZoneCommand:defineUpgrades(upgrades)
		self.upgrades = upgrades
		
		for side,sd in ipairs(self.upgrades) do
			for _,v in ipairs(sd) do
				v.side = side
				v.owner = self
				
				local cat = nil
				if v.template then
					cat = TemplateDB.getData(v.template)
				elseif v.templates then
					cat = TemplateDB.getData(v.templates[1])
				end

				if cat.dataCategory == TemplateDB.type.static then
					ZoneCommand.staticRegistry[v.name] = true
				end
				
				for _,v2 in ipairs(v.products) do
					v2.side = side
					v2.owner = self

					if v2.type == "mission" then
						local gr = Group.getByName(v2.name)
						
						if not gr then
							if v2.missionType ~= ZoneCommand.missionTypes.supply_transfer then
								env.info("ZoneCommand - ERROR declared group does not exist in mission: ".. v2.name)
							end
						else
							gr:destroy() 
						end
					end
				end
			end
		end
	end

	function ZoneCommand:getAllProducts()
		local flatList = {}
		for i,v in ipairs(self.upgrades) do
			for i2,v2 in ipairs(v) do
				flatList[v2.name] = v2
				for i3,v3 in ipairs(v2.products) do
					flatList[v3.name] = v3
				end
			end
		end

		return flatList
	end
	
	function ZoneCommand:getProductByName(name)
		for i,v in ipairs(self.upgrades) do
			for i2,v2 in ipairs(v) do
				if v2.name == name then
					return v2
				else
					for i3,v3 in ipairs(v2.products) do
						if v3.name == name then 
							return v3
						end
					end
				end
			end
		end

		return nil
	end

	function ZoneCommand:cleanup()
		local zn = trigger.misc.getZone(self.name)
		local pos =  {
			x = zn.point.x, 
			y = land.getHeight({x = zn.point.x, y = zn.point.z}), 
			z= zn.point.z
		}
		local radius = zn.radius*2
		world.removeJunk({id = world.VolumeType.SPHERE,params = {point = pos, radius = radius}})
	end
end




-----------------[[ END OF ZoneCommand.lua ]]-----------------



-----------------[[ BattlefieldManager.lua ]]-----------------

BattlefieldManager = {}
do
	BattlefieldManager.closeOverride = 27780 -- 15nm
	BattlefieldManager.farOverride = Config.maxDistFromFront -- default 100nm
	BattlefieldManager.boostScale = {[0] = 1.0, [1]=1.0, [2]=1.0}
	BattlefieldManager.noRedZones = false
	BattlefieldManager.noBlueZones = false
	
	function BattlefieldManager:new()
		local obj = {}
		
		setmetatable(obj, self)
		self.__index = self
		obj:start()
		return obj
	end
	
	function BattlefieldManager:start()
		timer.scheduleFunction(function(param, time)
			local self = param.context
			
			local zones = ZoneCommand.getAllZones()
			local torank = {}
			
			--reset ranks and define frontline
			for name,zone in pairs(zones) do
				zone.distToFront = nil
				zone.closestEnemyDist = nil
				
				if zone.neighbours then
					for nName, nZone in pairs(zone.neighbours) do
						if zone.side ~= nZone.side then
							zone.distToFront = 0
						end
					end
				end
				
				--set dist to closest enemy
				for name2,zone2 in pairs(zones) do
					if zone.side ~= zone2.side then
						local dist = mist.utils.get2DDist(zone.zone.point, zone2.zone.point)
						if not zone.closestEnemyDist or dist < zone.closestEnemyDist then
							zone.closestEnemyDist = dist
						end
					end
				end
			end
			
			for name,zone in pairs(zones) do
				if zone.distToFront == 0 then
					for nName, nZone in pairs(zone.neighbours) do
						if nZone.distToFront == nil then
							table.insert(torank, nZone)
						end
					end
				end
			end

			-- build ranks of every other zone
			while #torank > 0 do
				local nexttorank = {}
				for _,zone in ipairs(torank) do
					if not zone.distToFront then
						local minrank = 999
						for nName,nZone in pairs(zone.neighbours) do
							if nZone.distToFront then
								if nZone.distToFront<minrank then
									minrank = nZone.distToFront
								end
							else
								table.insert(nexttorank, nZone)
							end
						end
						zone.distToFront = minrank + 1
					end
				end
				torank = nexttorank
			end
			
			for name, zone in pairs(zones) do
				if zone.keepActive then
					if zone.closestEnemyDist and zone.closestEnemyDist > BattlefieldManager.farOverride and zone.distToFront > 3 then
						zone.mode = ZoneCommand.modes.export
					else
						if zone.mode ~= ZoneCommand.modes.normal then
							zone:fullBuild(1.0)
						end
						zone.mode = ZoneCommand.modes.normal
					end
				else
					if not zone.distToFront or zone.distToFront == 0 or (zone.closestEnemyDist and zone.closestEnemyDist < BattlefieldManager.closeOverride) then
						if zone.mode ~= ZoneCommand.modes.normal then
							zone:fullBuild(1.0)
						end
						zone.mode = ZoneCommand.modes.normal
					elseif zone.distToFront == 1 then
						zone.mode = ZoneCommand.modes.supply
					elseif zone.distToFront > 1 then
						zone.mode = ZoneCommand.modes.export
					end
				end

				zone.boostScale = self.boostScale[zone.side]
			end
			
			return time+60
		end, {context = self}, timer.getTime()+1)

		timer.scheduleFunction(function(param, time)
			local self = param.context
			
			local zones = ZoneCommand.getAllZones()
			
			local noRed = true
			local noBlue = true
			for name, zone in pairs(zones) do
				if zone.side == 1 then
					noRed = false
				elseif zone.side == 2 then
					noBlue = false
				end

				if not noRed and not noBlue then
					break
				end
			end

			if noRed then
				BattlefieldManager.noRedZones = true
			end

			if noBlue then
				BattlefieldManager.noBlueZones = true
			end
			
			return time+10
		end, {context = self}, timer.getTime()+1)

		timer.scheduleFunction(function(param, time)
			local x = math.random(-50,50) -- the lower limit benefits blue, higher limit benefits red, adjust to increase limit of random boost variance, default (-50,50)
			local boostIntensity = Config.randomBoost -- adjusts the intensity of the random boost variance, default value = 0.0004
			local factor = (x*x*x*boostIntensity)/100  -- the farther x is the higher the factor, negative beneifts blue, pozitive benefits red
			param.context.boostScale[1] = 1.0+factor
			param.context.boostScale[2] = 1.0-factor

			local red = 0
			local blue = 0
			for i,v in pairs(ZoneCommand.getAllZones()) do
				if v.side == 1 then
					red = red + 1
				elseif v.side == 2 then
					blue = blue + 1
				end

				--v:cleanup()
			end

			-- push factor towards coalition with less zones (up to 0.5)
			local multiplier = Config.lossCompensation -- adjust this to boost losing side production(higher means losing side gains more advantage) (default 1.25)
			local total = red + blue
			local redp = (0.5-(red/total))*multiplier
			local bluep = (0.5-(blue/total))*multiplier

			-- cap factor to avoid increasing difficulty until the end
			redp = math.min(redp, 0.15)
			bluep = math.max(bluep, -0.15)

			param.context.boostScale[1] = param.context.boostScale[1] + redp
			param.context.boostScale[2] = param.context.boostScale[2] + bluep

			--limit to numbers above 0
			param.context.boostScale[1] = math.max(0.01,param.context.boostScale[1])
			param.context.boostScale[2] = math.max(0.01,param.context.boostScale[2])

			env.info('BattlefieldManager - power red = '..param.context.boostScale[1])
			env.info('BattlefieldManager - power blue = '..param.context.boostScale[2])

			return time+(60*30)
		end, {context = self}, timer.getTime()+1)
	end
end

-----------------[[ END OF BattlefieldManager.lua ]]-----------------



-----------------[[ Preset.lua ]]-----------------

Preset = {}
do
    function Preset:new(obj)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

	function Preset:extend(new)
		return Preset:new(Utils.merge(self, new))
	end
end

-----------------[[ END OF Preset.lua ]]-----------------



-----------------[[ PlayerTracker.lua ]]-----------------

PlayerTracker = {}
do
    PlayerTracker.savefile = 'player_stats_v2.0.json'
    PlayerTracker.statTypes = {
        xp = 'XP',
        cmd = "CMD",
        survivalBonus = "SB"
    }

    PlayerTracker.cmdShopTypes = {
        smoke = 'smoke',
        jtac = 'jtac',
        bribe1 = 'bribe1',
        bribe2 = 'bribe2',
        artillery = 'artillery',
        sabotage1 = 'sabotage1',
    }

    PlayerTracker.cmdShopPrices = {
        [PlayerTracker.cmdShopTypes.smoke] = 1,
        [PlayerTracker.cmdShopTypes.jtac] = 20,
        [PlayerTracker.cmdShopTypes.bribe1] = 10,
        [PlayerTracker.cmdShopTypes.bribe2] = 15,
        [PlayerTracker.cmdShopTypes.artillery] = 40,
        [PlayerTracker.cmdShopTypes.sabotage1] = 30,
    }

    PlayerTracker.callsigns = { 'Caveman', 'Casper', 'Banjo', 'Boomer', 'Shaft', 'Wookie', 'Tiny', 'Tool', 'Trash', 'Orca', 'Irish', 'Flex', 'Grip', 'Dice', 'Duck', 'Poet', 'Jack', 'Lego', 'Hurl', 'Spin' }
    table.sort(PlayerTracker.callsigns)

	function PlayerTracker:new()
		local obj = {}
        obj.stats = {}
        obj.config = {}
        obj.tempStats = {}
        obj.groupMenus = {}
        obj.groupShopMenus = {}
        obj.groupTgtMenus = {}
        obj.playerEarningMultiplier = {}

        if lfs then 
            local dir = lfs.writedir()..'Missions/Saves/'
            lfs.mkdir(dir)
            PlayerTracker.savefile = dir..PlayerTracker.savefile
            env.info('Pretense - Player stats file path: '..PlayerTracker.savefile)
        end

        local save = Utils.loadTable(PlayerTracker.savefile)
        if save then 
            obj.stats = save.stats or {}
            obj.config = save.config or {}
        end

		setmetatable(obj, self)
		self.__index = self
		
        obj:init()

		DependencyManager.register("PlayerTracker", obj)
		return obj
	end

    function PlayerTracker:init()
        local ev = {}
        ev.context = self
        function ev:onEvent(event)
            if not event.initiator then return end
            if not event.initiator.getPlayerName then return end
            if not event.initiator.getCoalition then return end

            local player = event.initiator:getPlayerName()
            if not player then return end
            
            local blocked = false
            if event.id==world.event.S_EVENT_BIRTH then
                if event.initiator and Object.getCategory(event.initiator) == Object.Category.UNIT and 
                    (Unit.getCategoryEx(event.initiator) == Unit.Category.AIRPLANE or Unit.getCategoryEx(event.initiator) == Unit.Category.HELICOPTER)  then
                    
                        local pname = event.initiator:getPlayerName()
                        if pname then
                            local un = event.initiator

                            local zn = ZoneCommand.getZoneOfUnit(un:getName())
                            if not zn then CarrierCommand.getCarrierOfUnit(un:getName()) end
                            if not zn then FARPCommand.getFARPOfUnit(un:getName()) end

                            if zn then
                                local isDifferentSide = zn.side ~= un:getCoalition()
                                local isNotSuported = zn.side == 1
                                local noResources = zn.resource < Config.zoneSpawnCost

                                local gr = event.initiator:getGroup()
                                if isDifferentSide or noResources or isNotSuported then
                                    blocked = true

                                    for i,v in pairs(net.get_player_list()) do
                                        if net.get_name(v) == pname then
                                            net.send_chat_to('Can not spawn as '..gr:getName()..' in enemy/neutral zone or zone without enough resources' , v)
                                            timer.scheduleFunction(function(param, time)
                                                net.force_player_slot(param, 0, '')
                                            end, v, timer.getTime()+0.1)
                                            break
                                        end
                                    end

                                    trigger.action.outTextForGroup(gr:getID(), 'Can not spawn as '..gr:getName()..' in enemy/neutral zone or zone without enough resources',5)
                                    if event.initiatior and event.initiator:isExist() then 
                                        event.initiator:destroy()
                                    end
                                end
                            end
                        end
                end
            end

            if event.id == world.event.S_EVENT_BIRTH and not blocked then
                -- init stats for player if not exist
                if not self.context.stats[player] then
                    self.context.stats[player] = {}
                end

                -- reset temp track for player
                self.context.tempStats[player] = nil

                local minutes = 0
                local multiplier = 1.0
                if self.context.stats[player][PlayerTracker.statTypes.survivalBonus] ~= nil then
                    minutes = self.context.stats[player][PlayerTracker.statTypes.survivalBonus]
                    multiplier = PlayerTracker.minutesToMultiplier(minutes)
                end

                self.context.playerEarningMultiplier[player] = { spawnTime = timer.getAbsTime(), unit = event.initiator, multiplier = multiplier, minutes = minutes }

                local config = self.context:getPlayerConfig(player)
                if config.gci_warning_radius then
                    local gci = DependencyManager.get("GCI")
                    gci:registerPlayer(player, event.initiator, config.gci_warning_radius, config.gci_metric)
                end
            end

            if event.id == world.event.S_EVENT_KILL then
                local target = event.target
                
                if not target then return end
                if not target.getCoalition then return end
                
                if target:getCoalition() == event.initiator:getCoalition() then return end
                
                local xpkey = PlayerTracker.statTypes.xp
                local award = PlayerTracker.getXP(target)

                award = math.floor(award * self.context:getPlayerMultiplier(player))

                local instantxp = math.floor(award*0.25)
                local tempxp = award - instantxp

                self.context:addStat(player, instantxp, PlayerTracker.statTypes.xp)
                local msg = '[XP] '..self.context.stats[player][xpkey]..' (+'..instantxp..')'
                env.info("PlayerTracker.kill - "..player..' awarded '..tostring(instantxp)..' xp')
                
                self.context:addTempStat(player, tempxp, PlayerTracker.statTypes.xp)
                msg = msg..'\n+'..tempxp..' XP (unclaimed)'
                env.info("PlayerTracker.kill - "..player..' awarded '..tostring(tempxp)..' xp (unclaimed)')

                trigger.action.outTextForUnit(event.initiator:getID(), msg, 5)
            end

            if event.id==world.event.S_EVENT_EJECTION then
				self.context.stats[player] = self.context.stats[player] or {}
                local ts = self.context.tempStats[player]
                if ts then
                    local un = event.initiator
                    local key = PlayerTracker.statTypes.xp
                    local xp = self.context.tempStats[player][key]
                    if xp then
                        xp = xp * self.context:getPlayerMultiplier(player)
                        trigger.action.outTextForUnit(un:getID(), 'Ejection. 30\% XP claimed', 5)
                        self.context:addStat(player, math.floor(xp*0.3), PlayerTracker.statTypes.xp)
                        trigger.action.outTextForUnit(un:getID(), '[XP] '..self.context.stats[player][key]..' (+'..math.floor(xp*0.3)..')', 5)
                    end
                    
                    self.context.tempStats[player] = nil
                end
			end

            if event.id==world.event.S_EVENT_TAKEOFF then
                local un = event.initiator
                env.info('PlayerTracker - '..player..' took off in '..tostring(un:getID())..' '..un:getName())
                if self.context.stats[player][PlayerTracker.statTypes.survivalBonus] ~= nil then
                    self.context.stats[player][PlayerTracker.statTypes.survivalBonus] = nil
                    trigger.action.outTextForUnit(un:getID(), 'Taken off, survival bonus no longer secure.', 10)
                end

                local zn = ZoneCommand.getZoneOfUnit(un:getName())
                if not zn then zn = CarrierCommand.getCarrierOfUnit(un:getName()) end
                if not zn then zn = FARPCommand.getFARPOfUnit(un:getName()) end

                if zn then
                    local cost = Config.zoneSpawnCost
                    if zn.isCarrier then cost = Config.carrierSpawnCost end
                    if zn.isFARP then cost = 0 end

                    zn:removeResource(cost)
                end
			end

            if event.id==world.event.S_EVENT_ENGINE_SHUTDOWN then
                local un = event.initiator
                local zn = ZoneCommand.getZoneOfUnit(un:getName())
                if not zn then 
                    zn = CarrierCommand.getCarrierOfUnit(un:getName())
                end
                
                if not zn then 
                    zn = FARPCommand.getFARPOfUnit(un:getName())
                    if zn and not zn:hasFeature(PlayerLogistics.buildables.satuplink) then
                        trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Satellite Uplink. Can not secure survival bonus.', 10)
                        return
                    end
                end

                if un and un:isExist() and zn and zn.side == un:getCoalition() then
                    env.info('PlayerTracker - '..player..' has shut down engine of '..tostring(un:getID())..' '..un:getName()..' at '..zn.name)
                    self.context.stats[player][PlayerTracker.statTypes.survivalBonus] = self.context:getPlayerMinutes(player)
                    self.context:save()
                    trigger.action.outTextForUnit(un:getID(), 'Engines shut down. Survival bonus secured.', 10)
                    env.info('PlayerTracker - '..player..' secured survival bonus of '..self.context.stats[player][PlayerTracker.statTypes.survivalBonus]..' minutes')
                end
			end

            if event.id==world.event.S_EVENT_LAND then
                self.context:validateLanding(event.initiator, player)
			end
        end

		world.addEventHandler(ev)
        self:periodicSave()
        self:menuSetup()

        timer.scheduleFunction(function(params, time)
            local players = params.context.playerEarningMultiplier
            for i,v in pairs(players) do
                if v.unit.isExist and v.unit:isExist() then
                    if v.multiplier < 5.0 and v.unit and v.unit:isExist() and Utils.isInAir(v.unit) then
                        v.minutes = v.minutes + 1
                        v.multiplier = PlayerTracker.minutesToMultiplier(v.minutes)
                    end
                end
            end

            return time+60
        end, {context = self}, timer.getTime()+60)
    end

    function PlayerTracker:validateLanding(unit, player, manual)
        local un = unit
        local zn = ZoneCommand.getZoneOfUnit(unit:getName())
        if not zn then 
            zn = CarrierCommand.getCarrierOfUnit(unit:getName())
        end
        
        if not zn then 
            zn = FARPCommand.getFARPOfUnit(unit:getName())
        end

        env.info('PlayerTracker - '..player..' landed in '..tostring(un:getID())..' '..un:getName())
        if un and zn and zn.side == un:getCoalition() then
            trigger.action.outTextForUnit(unit:getID(), "Wait 10 seconds to validate landing...", 10)
            timer.scheduleFunction(function(param, time)
                local un = param.unit
                if not un or not un:isExist() then return end
                
                local player = param.player
                local isLanded = Utils.isLanded(un, true)
                local zn = ZoneCommand.getZoneOfUnit(un:getName())
                if not zn then 
                    zn = CarrierCommand.getCarrierOfUnit(un:getName())
                end
                
                if not zn then 
                    zn = FARPCommand.getFARPOfUnit(unit:getName())
                    if zn and not zn:hasFeature(PlayerLogistics.buildables.satuplink) then
                        trigger.action.outTextForUnit(unit:getID(), zn.name..' lacks a Satellite Uplink', 10)
                        return
                    end
                end

                env.info('PlayerTracker - '..player..' checking if landed: '..tostring(isLanded))

                if zn and isLanded then
                    if not manual then
                        if zn.isCarrier then
                            zn:addResource(Config.carrierSpawnCost)
                        else
                            zn:addResource(Config.zoneSpawnCost)
                        end
                    end

                    if param.context.tempStats[player] then 
                        if zn and zn.side == un:getCoalition() then
                            param.context.stats[player] = param.context.stats[player] or {}
                            
                            trigger.action.outTextForUnit(un:getID(), 'Rewards claimed', 5)
                            for _,key in pairs(PlayerTracker.statTypes) do
                                local value = param.context.tempStats[player][key]
                                env.info("PlayerTracker.landing - "..player..' redeeming '..tostring(value)..' '..key)
                                if value then 
                                    param.context:commitTempStat(player, key)
                                    trigger.action.outTextForUnit(un:getID(), key..' +'..value..'', 5)
                                end
                            end

                            param.context:save()
                        end
                    end
                end
            end, {player = player, unit = unit, context = self}, timer.getTime()+10)
        end
    end

    function PlayerTracker:addTempStat(player, amount, stattype)
        self.tempStats[player] = self.tempStats[player] or {}
        self.tempStats[player][stattype] = self.tempStats[player][stattype] or 0
        self.tempStats[player][stattype] = self.tempStats[player][stattype] + amount
    end

    function PlayerTracker:addStat(player, amount, stattype)
        self.stats[player] = self.stats[player] or {}
        self.stats[player][stattype] = self.stats[player][stattype] or 0

        if stattype == PlayerTracker.statTypes.xp then
            local cur = self:getRank(self.stats[player][stattype])
            if cur then 
                local nxt = self:getRank(self.stats[player][stattype] + amount)
                if nxt and cur.rank < nxt.rank then
                    trigger.action.outText(player..' has leveled up to rank: '..nxt.name, 10)
                    if nxt.cmdAward and nxt.cmdAward > 0 then
                        self:addStat(player, nxt.cmdAward, PlayerTracker.statTypes.cmd)
                        trigger.action.outText(player.." awarded "..nxt.cmdAward.." CMD tokens", 10)
                        env.info("PlayerTracker.addStat - Awarded "..player.." "..nxt.cmdAward.." CMD tokens for rank up to "..nxt.name)
                    end
                end
            end
        end

        self.stats[player][stattype] = self.stats[player][stattype] + amount
    end

    function PlayerTracker:commitTempStat(player, statkey)
        local value = self.tempStats[player][statkey]
        if value then 
            self:addStat(player, value, statkey)

            self.tempStats[player][statkey] = nil
        end
    end

    function PlayerTracker:addRankRewards(player, unit, isTemp)
        local rank = self:getPlayerRank(player)
        if not rank then return end

        local cmdChance = rank.cmdChance
        if cmdChance > 0 then 

            local tkns = 0
            for i=1,rank.cmdTrys,1 do
                local die = math.random()
                if die <= cmdChance then 
                    tkns = tkns + 1
                end
            end

            if tkns > 0 then
                if isTemp then
                    self:addTempStat(player, tkns, PlayerTracker.statTypes.cmd)
                else
                    self:addStat(player, tkns, PlayerTracker.statTypes.cmd)
                end

                local msg = ""
                if isTemp then
                    msg = '+'..tkns..' CMD (unclaimed)'
                else
                    msg = '[CMD] '..self.stats[player][PlayerTracker.statTypes.cmd]..' (+'..tkns..')'
                end

                trigger.action.outTextForUnit(unit:getID(), msg, 5)
                env.info("PlayerTracker.addRankRewards - Awarded "..player.." "..tkns.." CMD tokens with chance "..cmdChance)
            end
        end
    end

    function PlayerTracker.getXP(unit)
        local xp = 30

        if unit:hasAttribute('Planes') then xp = xp + 20 end
        if unit:hasAttribute('Helicopters') then xp = xp + 20 end
        if unit:hasAttribute('Infantry') then xp = xp + 10 end
        if unit:hasAttribute('SAM SR') then xp = xp + 15 end
        if unit:hasAttribute('SAM TR') then xp = xp + 15 end
        if unit:hasAttribute('IR Guided SAM') then xp = xp + 10 end
        if unit:hasAttribute('Ships') then xp = xp + 20 end
        if unit:hasAttribute('Buildings') then xp = xp + 30 end
        if unit:hasAttribute('Tanks') then xp = xp + 10 end

        return xp
    end

    function PlayerTracker:menuSetup()
        
        MenuRegistry.register(1, function(event, context)
			if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player then
					local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()
					
                    if context.groupMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, context.groupMenus[groupid])
                        context.groupMenus[groupid] = nil
                    end

                    if not context.groupMenus[groupid] then
                        
                        local menu = missionCommands.addSubMenuForGroup(groupid, 'Player')
                        missionCommands.addCommandForGroup(groupid, 'Stats', menu, Utils.log(context.showGroupStats), context, groupname)
                        missionCommands.addCommandForGroup(groupid, 'Frequencies', menu, Utils.log(context.showFrequencies), context, groupname)
                        missionCommands.addCommandForGroup(groupid, 'Validate Landing', menu, Utils.log(context.validateLandingMenu), context, groupname)

                        local cmenu = missionCommands.addSubMenuForGroup(groupid, 'Config', menu)
                        local missionWarningMenu = missionCommands.addSubMenuForGroup(groupid, 'No mission warning', cmenu)
                        missionCommands.addCommandForGroup(groupid, 'Activate', missionWarningMenu, Utils.log(context.setNoMissionWarning), context, groupname, true)
                        missionCommands.addCommandForGroup(groupid, 'Deactivate', missionWarningMenu, Utils.log(context.setNoMissionWarning), context, groupname, false)

                        local missionWarningMenu = missionCommands.addSubMenuForGroup(groupid, 'GCI Text reports', cmenu)
                        missionCommands.addCommandForGroup(groupid, 'Activate', missionWarningMenu, Utils.log(context.setGCITextReports), context, groupname, true)
                        missionCommands.addCommandForGroup(groupid, 'Deactivate', missionWarningMenu, Utils.log(context.setGCITextReports), context, groupname, false)
                        
                        context.groupMenus[groupid] = menu
                    end
				end
            end
		end, self)

        MenuRegistry.register(5, function(event, context)
			if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player then
                    local rank = context:getPlayerRank(player)
                    if not rank then return end

                    local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()

                    if context.groupShopMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, context.groupShopMenus[groupid])
                        context.groupShopMenus[groupid] = nil
                    end
                    
                    if context.groupTgtMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, context.groupTgtMenus[groupid])
                        context.groupTgtMenus[groupid] = nil
                    end

                    if not context.groupShopMenus[groupid] then
                        
                        local menu = missionCommands.addSubMenuForGroup(groupid, 'Command & Control')
                        missionCommands.addCommandForGroup(groupid, 'Deploy Smoke ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.smoke]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.smoke)
                        missionCommands.addCommandForGroup(groupid, 'Hack enemy comms ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.bribe1]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.bribe1)
                        missionCommands.addCommandForGroup(groupid, 'Bribe enemy officer ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.bribe2]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.bribe2)
                        missionCommands.addCommandForGroup(groupid, 'Shell zone with artillery ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.artillery]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.artillery)
                        missionCommands.addCommandForGroup(groupid, 'Sabotage enemy zone ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.sabotage1]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.sabotage1)
                        
                        if CommandFunctions.jtac then
                            missionCommands.addCommandForGroup(groupid, 'Deploy JTAC ['..PlayerTracker.cmdShopPrices[PlayerTracker.cmdShopTypes.jtac]..' CMD]', menu, Utils.log(context.buyCommand), context, groupname, PlayerTracker.cmdShopTypes.jtac)
                        end

                        context.groupShopMenus[groupid] = menu
                    end
				end
            end
		end, self)
		
        DependencyManager.get("MarkerCommands"):addCommand('stats',function(event, _, state) 
            local unit = nil
            if event.initiator then 
                unit = event.initiator
            elseif world.getPlayer() then
                unit = world.getPlayer()
            end

            if not unit then return false end

            state:showGroupStats(unit:getGroup():getName())
            return true
        end, false, self)

        DependencyManager.get("MarkerCommands"):addCommand('freqs',function(event, _, state) 
            local unit = nil
            if event.initiator then 
                unit = event.initiator
            elseif world.getPlayer() then
                unit = world.getPlayer()
            end

            if not unit then return false end

            state:showFrequencies(unit:getGroup():getName())
            return true
        end, false, self)
    end

    function PlayerTracker:setNoMissionWarning(groupname, active)
        local gr = Group.getByName(groupname)
        if gr and gr:getSize()>0 then 
            local un = gr:getUnit(1)
            if un then
                local player = un:getPlayerName()
                if player then
                    self:setPlayerConfig(player, "noMissionWarning", active)
                end
            end
        end
    end   
    
    function PlayerTracker:setGCITextReports(groupname, active)
        local gr = Group.getByName(groupname)
        if gr and gr:getSize()>0 then 
            local un = gr:getUnit(1)
            if un then
                local player = un:getPlayerName()
                if player then
                    self:setPlayerConfig(player, "gciTextReports", active)
                end
            end
        end
    end

    function PlayerTracker:buyCommand(groupname, itemType)
        local gr = Group.getByName(groupname)
        if gr and gr:getSize()>0 then 
            local un = gr:getUnit(1)
            if un then
                local player = un:getPlayerName()
                local cost = PlayerTracker.cmdShopPrices[itemType]
                local cmdTokens = self.stats[player][PlayerTracker.statTypes.cmd]

                if cmdTokens and cost <= cmdTokens then
                    local canPurchase = true

                    if self.groupTgtMenus[gr:getID()] then
                        missionCommands.removeItemForGroup(gr:getID(), self.groupTgtMenus[gr:getID()])
                        self.groupTgtMenus[gr:getID()] = nil
                    end

                    if itemType == PlayerTracker.cmdShopTypes.smoke then

                        self.groupTgtMenus[gr:getID()] = MenuRegistry.showTargetZoneMenu(gr:getID(), "Smoke Marker target", function(params) 
                            CommandFunctions.smokeTargets(params.zone, 5)
                            trigger.action.outTextForGroup(params.groupid, "Targets marked at "..params.zone.name.." with red smoke", 5)
                        end, 1, 1, nil, nil, true)

                        if self.groupTgtMenus[gr:getID()] then
                            trigger.action.outTextForGroup(gr:getID(), "Select target from radio menu",10)
                        else
                            trigger.action.outTextForGroup(gr:getID(), "No valid targets available",10)
                            canPurchase = false
                        end

                    elseif itemType == PlayerTracker.cmdShopTypes.jtac then

                        self.groupTgtMenus[gr:getID()] = MenuRegistry.showTargetZoneMenu(gr:getID(), "JTAC target", function(params) 

                            CommandFunctions.spawnJtac(params.zone)
                            trigger.action.outTextForGroup(params.groupid, "Reaper orbiting "..params.zone.name,5)

                        end, 1, 1)

                        if self.groupTgtMenus[gr:getID()] then
                            trigger.action.outTextForGroup(gr:getID(), "Select target from radio menu",10)
                        else
                            trigger.action.outTextForGroup(gr:getID(), "No valid targets available",10)
                            canPurchase = false
                        end

                    elseif itemType== PlayerTracker.cmdShopTypes.bribe1 then

                        timer.scheduleFunction(function(params, time)
                            local count = 0
                            for i,v in pairs(ZoneCommand.getAllZones()) do
                                if v.side == 1 and v.distToFront <= 1 then
                                    if math.random()<0.5 then
                                        v:reveal()
                                        DependencyManager.get("ReconManager"):revealEnemyInZone(v, nil, 1, 1)
                                        count = count + 1
                                    end
                                end
                            end
                            if count > 0 then
                                trigger.action.outTextForGroup(params.groupid, "Intercepted enemy communications have revealed information on "..count.." enemy zones",20)
                            else
                                trigger.action.outTextForGroup(params.groupid, "No useful information has been intercepted",20)
                            end
                        end, {groupid=gr:getID()}, timer.getTime()+60)

                        trigger.action.outTextForGroup(gr:getID(), "Attempting to intercept enemy comms...",60)

                    elseif itemType == PlayerTracker.cmdShopTypes.bribe2 then
                        timer.scheduleFunction(function(params, time)
                            local count = 0
                            for i,v in pairs(ZoneCommand.getAllZones()) do
                                if v.side == 1 then
                                    if math.random()<0.5 then
                                        v:reveal()
                                        DependencyManager.get("ReconManager"):revealEnemyInZone(v, nil, 1, 0.5)
                                        count = count + 1
                                    end
                                end
                            end

                            if count > 0 then
                                trigger.action.outTextForGroup(params.groupid, "Bribed officer has shared intel on "..count.." enemy zones",20)
                            else
                                trigger.action.outTextForGroup(params.groupid, "Bribed officer has stopped responding to attempted communications.",20)
                            end
                        end, {groupid=gr:getID()}, timer.getTime()+(60*5))
                        
                        trigger.action.outTextForGroup(gr:getID(), "Bribe has been transfered to enemy officer. Waiting for contact...",20)
                    elseif itemType == PlayerTracker.cmdShopTypes.artillery then
                        self.groupTgtMenus[gr:getID()] = MenuRegistry.showTargetZoneMenu(gr:getID(), "Artillery target", function(params)
                            CommandFunctions.shellZone(params.zone, 50)
                        end, 1, 1)

                        if self.groupTgtMenus[gr:getID()] then
                            trigger.action.outTextForGroup(gr:getID(), "Select target from radio menu",10)
                        else
                            trigger.action.outTextForGroup(gr:getID(), "No valid targets available",10)
                            canPurchase = false
                        end

                    elseif itemType == PlayerTracker.cmdShopTypes.sabotage1 then
                        self.groupTgtMenus[gr:getID()] = MenuRegistry.showTargetZoneMenu(gr:getID(), "Sabotage target", function(params)
                            CommandFunctions.sabotageZone(params.zone)
                        end, 1, 1)

                        if self.groupTgtMenus[gr:getID()] then
                            trigger.action.outTextForGroup(gr:getID(), "Select target from radio menu",10)
                        else
                            trigger.action.outTextForGroup(gr:getID(), "No valid targets available",10)
                            canPurchase = false
                        end
                    end
                    
                    if canPurchase then
                        self.stats[player][PlayerTracker.statTypes.cmd] = self.stats[player][PlayerTracker.statTypes.cmd] - cost
                    end
                else
                    trigger.action.outTextForUnit(un:getID(), "Insufficient CMD to buy selected item", 5)
                end
            end
        end
    end

    function PlayerTracker:showFrequencies(groupname)
        local gr = Group.getByName(groupname)
        if gr then 
            for i,v in pairs(gr:getUnits()) do
                if v.getPlayerName and v:getPlayerName() then
                    local message = RadioFrequencyTracker.getRadioFrequencyMessage(gr:getCoalition())
                    trigger.action.outTextForUnit(v:getID(), message, 20)
                end
            end
        end
    end

    function PlayerTracker:validateLandingMenu(groupname)
        local gr = Group.getByName(groupname)
        if gr then 
            for i,v in pairs(gr:getUnits()) do
                if v.getPlayerName and v:getPlayerName() then
                    self:validateLanding(v, v:getPlayerName(), true)
                end
            end
        end
    end

    function PlayerTracker:showGroupStats(groupname)
        local gr = Group.getByName(groupname)
        if gr then 
            for i,v in pairs(gr:getUnits()) do
                if v.getPlayerName and v:getPlayerName() then
                    local player = v:getPlayerName()
                    local message = '['..player..']\n'
                    
                    local stats = self.stats[player]
                    if stats then
                        local xp = stats[PlayerTracker.statTypes.xp]
                        if xp then
                            local rank, nextRank = self:getRank(xp)
                            
                            message = message ..'\nXP: '..xp

                            if rank then
                                message = message..'\nRank: '..rank.name

                                if rank.cmdChance > 0 then
                                    message = message..'\nCMD rolls per mission: '..rank.cmdTrys
                                    message = message..'\nCMD chance per roll: '..math.floor(rank.cmdChance*100)..'%'
                                end
                            end

                            if nextRank then
                                message = message..'\nXP needed for promotion: '..(nextRank.requiredXP-xp)
                                if rank then
                                    message = message..'\nPromotion rewards:'

                                    if rank.cmdTrys == 0 and nextRank.cmdTrys > 0 then
                                        message = message..'\n  Command and Control unlocked'
                                    end

                                    if nextRank.cmdAward and nextRank.cmdAward>0 then
                                        message = message..'\n  +'..nextRank.cmdAward..' CMD'
                                    end
                                    
                                    if nextRank.cmdTrys > rank.cmdTrys then
                                        message = message..'\n  CMD rolls per mission: +'..(nextRank.cmdTrys-rank.cmdTrys)
                                    end
                                
                                    if nextRank.cmdChance > rank.cmdChance then
                                        message = message..'\n  CMD chance per roll: +'..math.floor((nextRank.cmdChance-rank.cmdChance)*100)..'%'
                                    end

                                    if rank.allowCarrierSupport ~= nextRank.allowCarrierSupport then
                                        message = message..'\n  Carrier support unlocked'
                                    end

                                    if rank.allowCarrierCommand ~= nextRank.allowCarrierCommand then
                                        message = message..'\n  Carrier command unlocked'
                                    end

                                    message = message..'\n\n'
                                end
                            end
                        end

                        local multiplier = self:getPlayerMultiplier(player)
                        if multiplier then
                            message = message..'\nSurvival XP multiplier: '..string.format("%.2f", multiplier)..'x'
                            
                            if stats[PlayerTracker.statTypes.survivalBonus] ~= nil then
                                message = message..' [SECURED]'
                            end
                        end

                        local cmd = stats[PlayerTracker.statTypes.cmd]
                        if cmd then
                            message = message ..'\n\nCMD: '..cmd
                        end
                    end

                    local tstats = self.tempStats[player]
                    if tstats then
                        message = message..'\n'
                        local tempxp =  tstats[PlayerTracker.statTypes.xp]
                        if tempxp and tempxp > 0 then
                            message = message .. '\nUnclaimed XP: '..tempxp
                        end

                        local tempcmd =  tstats[PlayerTracker.statTypes.cmd]
                        if tempcmd and tempcmd > 0 then
                            message = message .. '\nUnclaimed CMD: '..tempcmd
                        end
                    end

                    trigger.action.outTextForUnit(v:getID(), message, 10)
                end
            end
        end
    end

    function PlayerTracker:setPlayerConfig(player, setting, value)
        local cfg = self:getPlayerConfig(player)
        cfg[setting] = value
    end

    function PlayerTracker.callsignToString(callsign)
        return callsign.name..' '..callsign.num1..'-'..callsign.num2
    end

    local function isCallsignTaken(choice, config)
        for i,v in pairs(config) do
            if PlayerTracker.callsignToString(v.gci_callsign) == PlayerTracker.callsignToString(choice) then
                return true
            end
        end
    end

    function PlayerTracker:generateCallsign(forcename)
        local choice = ''
        if forcename then
            choice = { name = forcename, num1=1, num2=1 }
        else
            choice = { name = PlayerTracker.callsigns[math.random(1,#PlayerTracker.callsigns)], num1=1, num2=1 }
            
            if isCallsignTaken(choice, self.config) then
                for i=1,10,1 do
                    choice = { name = PlayerTracker.callsigns[math.random(1,#PlayerTracker.callsigns)], num1=1, num2=1 }
                    if not isCallsignTaken(choice, self.config) then
                        break
                    end
                end
            end
        end 

        while isCallsignTaken(choice, self.config) do
            if choice.num2 < 9 then 
                choice.num2 = choice.num2 + 1 
            elseif choice.num1 < 9 then
                choice.num1 = choice.num1 + 1
                choice.num2 = 1
            else
                break
            end
        end

        return choice
    end

    function PlayerTracker:getPlayerConfig(player)
        if not self.config[player] then
            self.config[player] = {
                noMissionWarning = false,
                gciTextReports = true,
                gci_warning_radius = nil,
                gci_metric = nil,
                gci_callsign = self:generateCallsign()
            }
        end

        return self.config[player]
    end

    function PlayerTracker:periodicSave()
        timer.scheduleFunction(function(param, time)
            param:save()
            return time+60
        end, self, timer.getTime()+60)
    end

    function PlayerTracker:save()
        local tosave = {}
        tosave.stats = self.stats
        tosave.config = self.config
        
        tosave.zones = {}
        tosave.zones.red = {}
        tosave.zones.blue = {}
        tosave.zones.neutral = {}
        for i,v in pairs(ZoneCommand.getAllZones()) do
            if v.side == 1 then
                table.insert(tosave.zones.red,v.name)
            elseif v.side == 2 then
                table.insert(tosave.zones.blue,v.name)
            elseif v.side == 0 then
                table.insert(tosave.zones.neutral,v.name)
            end
        end

        tosave.players = {}
        for i,v in ipairs(coalition.getPlayers(2)) do
            if v and v:isExist() and v.getPlayerName then
                table.insert(tosave.players, {name=v:getPlayerName(), unit=v:getDesc().typeName})
            end
        end

        Utils.saveTable(PlayerTracker.savefile, tosave)
        env.info("PlayerTracker - state saved")
    end

    PlayerTracker.ranks = {}
    PlayerTracker.ranks[1] =  { rank=1,  name='E-1 Airman basic',           requiredXP = 0,        cmdChance = 0,       cmdAward=0,     cmdTrys=0}
    PlayerTracker.ranks[2] =  { rank=2,  name='E-2 Airman',                 requiredXP = 2000,     cmdChance = 0,       cmdAward=0,     cmdTrys=0}
    PlayerTracker.ranks[3] =  { rank=3,  name='E-3 Airman first class',     requiredXP = 4500,     cmdChance = 0,       cmdAward=0,     cmdTrys=0}
    PlayerTracker.ranks[4] =  { rank=4,  name='E-4 Senior airman',          requiredXP = 7700,     cmdChance = 0,       cmdAward=0,     cmdTrys=0}
    PlayerTracker.ranks[5] =  { rank=5,  name='E-5 Staff sergeant',         requiredXP = 11800,    cmdChance = 0.01,    cmdAward=1,     cmdTrys=1}
    PlayerTracker.ranks[6] =  { rank=6,  name='E-6 Technical sergeant',     requiredXP = 17000,    cmdChance = 0.01,    cmdAward=5,     cmdTrys=10}
    PlayerTracker.ranks[7] =  { rank=7,  name='E-7 Master sergeant',        requiredXP = 23500,    cmdChance = 0.03,    cmdAward=5,     cmdTrys=10}
    PlayerTracker.ranks[8] =  { rank=8,  name='E-8 Senior master sergeant', requiredXP = 31500,    cmdChance = 0.06,    cmdAward=10,    cmdTrys=10}
    PlayerTracker.ranks[9] =  { rank=9,  name='E-9 Chief master sergeant',  requiredXP = 42000,    cmdChance = 0.10,    cmdAward=10,    cmdTrys=10}
    PlayerTracker.ranks[10] = { rank=10, name='O-1 Second lieutenant',      requiredXP = 52800,    cmdChance = 0.14,    cmdAward=20,    cmdTrys=15}
    PlayerTracker.ranks[11] = { rank=11, name='O-2 First lieutenant',       requiredXP = 66500,    cmdChance = 0.20,    cmdAward=20,    cmdTrys=15}
    PlayerTracker.ranks[12] = { rank=12, name='O-3 Captain',                requiredXP = 82500,    cmdChance = 0.27,    cmdAward=25,    cmdTrys=15, allowCarrierSupport=true}
    PlayerTracker.ranks[13] = { rank=13, name='O-4 Major',                  requiredXP = 101000,   cmdChance = 0.34,    cmdAward=25,    cmdTrys=20, allowCarrierSupport=true}
    PlayerTracker.ranks[14] = { rank=14, name='O-5 Lieutenant colonel',     requiredXP = 122200,   cmdChance = 0.43,    cmdAward=25,    cmdTrys=20, allowCarrierSupport=true}
    PlayerTracker.ranks[15] = { rank=15, name='O-6 Colonel',                requiredXP = 146300,   cmdChance = 0.52,    cmdAward=30,    cmdTrys=20, allowCarrierSupport=true}
    PlayerTracker.ranks[16] = { rank=16, name='O-7 Brigadier general',      requiredXP = 173500,   cmdChance = 0.63,    cmdAward=35,    cmdTrys=25, allowCarrierSupport=true, allowCarrierCommand=true}
    PlayerTracker.ranks[17] = { rank=17, name='O-8 Major general',          requiredXP = 204000,   cmdChance = 0.74,    cmdAward=40,    cmdTrys=25, allowCarrierSupport=true, allowCarrierCommand=true}
    PlayerTracker.ranks[18] = { rank=18, name='O-9 Lieutenant general',     requiredXP = 238000,   cmdChance = 0.87,    cmdAward=45,    cmdTrys=25, allowCarrierSupport=true, allowCarrierCommand=true}
    PlayerTracker.ranks[19] = { rank=19, name='O-10 General',               requiredXP = 275700,   cmdChance = 0.95,    cmdAward=50,    cmdTrys=30, allowCarrierSupport=true, allowCarrierCommand=true}

    function PlayerTracker:getPlayerRank(playername)
        if self.stats[playername] then
            local xp = self.stats[playername][PlayerTracker.statTypes.xp]
            if xp then
                return self:getRank(xp)
            end
        end
    end

    function PlayerTracker:getPlayerMultiplier(playername)
        if self.playerEarningMultiplier[playername] then
            return self.playerEarningMultiplier[playername].multiplier
        end

        return 1.0
    end

    function PlayerTracker:getPlayerMinutes(playername)
        if self.playerEarningMultiplier[playername] then
            return self.playerEarningMultiplier[playername].minutes
        end

        return 0
    end

    function PlayerTracker.minutesToMultiplier(minutes)
        local multi = 1.0
        if minutes > 10 and minutes <= 60 then
            multi = 1.0 + ((minutes-10)*0.05)
        elseif minutes > 60 then
            multi = 1.0 + (50*0.05) + ((minutes - 60)*0.025)
        end

        return math.min(multi, 5.0)
    end

    function PlayerTracker:getRank(xp)
        local rank = nil
        local nextRank = nil
        for _, rnk in ipairs(PlayerTracker.ranks) do
            if rnk.requiredXP <= xp then
                rank = rnk
            else
                nextRank = rnk
                break
            end
        end

        return rank, nextRank
    end
end

-----------------[[ END OF PlayerTracker.lua ]]-----------------



-----------------[[ ReconArea.lua ]]-----------------

ReconArea = {}
do
    ReconArea.currentIndex = 80000
    ReconArea.defaultLifetime = 60*60

    function ReconArea:new(zoneName, productName)
        local obj = {}
        obj.name = ""
        obj.points = {}
        obj.lifetime = ReconArea.defaultLifetime
        obj.padding = 250

        obj.zonename = zoneName
        obj.productname = productName

        obj.index = ReconArea.currentIndex
		ReconArea.currentIndex = ReconArea.currentIndex + 1

        setmetatable(obj, self)
		self.__index = self
        return obj
    end

    function ReconArea:getCenterAndRadius()
        local center = { x=0, z=0}

        for _,point in ipairs(self.points) do
            center.x = center.x + point.x
            center.z = center.z + point.z
        end

        center.x = center.x/#self.points
        center.z = center.z/#self.points

        local maxdist = 0
        for _,point in ipairs(self.points) do
            local dist = mist.utils.get2DDist(center, point)
            maxdist = math.max(maxdist, dist)
        end

        return center, maxdist
    end

    function ReconArea:refreshMovingGroup()
        if not self.group or not self.group:isExist() or self.group:getSize() == 0 then 
            self:remove()
            return true
        end

        self.points = {}
        for i,v in ipairs(self.group:getUnits()) do
            self:addPoint(v:getPoint())
        end

        local center, maxdist = self:getCenterAndRadius()
        
        trigger.action.setMarkupPositionStart(self.index, center)
        trigger.action.setMarkupRadius(self.index, maxdist+self.padding)
        trigger.action.setMarkupPositionStart(self.index+10000, {x = center.x, z = center.z+maxdist+self.padding})
    end

    function ReconArea:drawMovingGroup(group)
        if not group or not group:isExist() or group:getSize() == 0 then return end
        
        self.group = group

        self.points = {}
        for i,v in ipairs(group:getUnits()) do
            self:addPoint(v:getPoint())
        end

        local center, maxdist = self:getCenterAndRadius()
        local border = {0,0,0,0.7}
        local background = {1,1,1,0.05}
        trigger.action.circleToAll(-1,self.index, center, maxdist + self.padding, border, background, 3)
        trigger.action.textToAll(-1, self.index+10000, {x = center.x, z = center.z+maxdist+self.padding}, {0,0,0,0.7}, {0,0,0,0}, 15, true, self.name)
    end

    function ReconArea:draw()
        local square = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
        }

        if self.points[1] then
            local p = self.points[1]
            square.left = p.z
            square.right = p.z
            square.top = p.x
            square.bottom = p.x
        end

        for _,point in ipairs(self.points) do
            if point.x < square.bottom then square.bottom = point.x end
            if point.x > square.top then square.top = point.x end
            if point.z < square.left then square.left = point.z end
            if point.z > square.right then square.right = point.z end
        end

        square.bottom = square.bottom - self.padding
        square.top = square.top + self.padding
        square.left = square.left - self.padding
        square.right = square.right + self.padding
        
        local border = {0,0,0,0.7}
        local background = {1,1,1,0.05}

		trigger.action.quadToAll(-1,self.index, 
            {x = square.top, z = square.left},
            {x = square.top, z = square.right},
            {x = square.bottom, z = square.right},
            {x = square.bottom, z = square.left},
            border,background,3)

        trigger.action.textToAll(-1, self.index+10000, {x = square.top, z = square.left}, {0,0,0,0.7}, {0,0,0,0}, 15, true, self.name)
    end

    function ReconArea:remove()
        trigger.action.removeMark(self.index)
        trigger.action.removeMark(self.index+10000)
    end

    function ReconArea:addPoint(point)
        table.insert(self.points, point)
    end
end

-----------------[[ END OF ReconArea.lua ]]-----------------



-----------------[[ ReconManager.lua ]]-----------------

ReconManager = {}
do
    ReconManager.groupMenus = {}
    ReconManager.requiredProgress = 5*60
    ReconManager.updateFrequency = 5

    function ReconManager:new()
        local obj = {}
        obj.recondata = {}
        obj.cancelRequests = {}
        obj.reconAreas = {}

        setmetatable(obj, self)
		self.__index = self
		DependencyManager.register("ReconManager", obj)
        obj:init()
        return obj
    end

    function ReconManager:init()
        MenuRegistry.register(7, function(event, context)
            if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
                local player = event.initiator:getPlayerName()
                if player then
                    local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()
                    
                    if ReconManager.groupMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, ReconManager.groupMenus[groupid])
                        ReconManager.groupMenus[groupid] = nil
                    end
    
                    if not ReconManager.groupMenus[groupid] then
                        local menu = missionCommands.addSubMenuForGroup(groupid, 'Recon')
                        missionCommands.addCommandForGroup(groupid, 'Report visible', menu, Utils.log(context.delayedDiscoverGroups), context, groupname)
                        
                        local stats = ReconManager.getAircraftStats(event.initiator:getDesc().typeName)
                        if stats and stats.canRecon then
                            missionCommands.addCommandForGroup(groupid, 'Start', menu, Utils.log(context.activateRecon), context, groupname)
                            missionCommands.addCommandForGroup(groupid, 'Cancel', menu, Utils.log(context.cancelRecon), context, groupname)
                            missionCommands.addCommandForGroup(groupid, 'Analyze', menu, Utils.log(context.analyzeData), context, groupname)
                            
                            if stats.uploadRate > 0 then
                                missionCommands.addCommandForGroup(groupid, 'Transmit & Analyze', menu, Utils.log(context.uploadData), context, groupname)
                            end
                        end

                        
                        ReconManager.groupMenus[groupid] = menu
                    end
                end
            end
        end, self)

        timer.scheduleFunction(function(param, time)
            local remaining = {}
            for _, ra in ipairs(param.context.reconAreas) do
                ra.lifetime = ra.lifetime - 5
                if ra.lifetime <= 0 then
                    ra:remove()
                else
                    local shouldkeep = true
                    if ra.group then
                        local deleted = ra:refreshMovingGroup()
                        if deleted then shouldkeep = false end
                    end

                    if shouldkeep then
                        table.insert(remaining, ra) 
                    end
                end
            end

            param.context.reconAreas = remaining
            
            return time+5
        end, {context = self}, timer.getTime()+5)
    end

    function ReconManager:activateRecon(groupname)
        local gr = Group.getByName(groupname)
		if gr then
			local un = gr:getUnit(1)
			if un and un:isExist() then
                timer.scheduleFunction(function(param, time)
                    local cancelRequest = param.context.cancelRequests[param.groupname]
                    if cancelRequest and (timer.getAbsTime() - cancelRequest < 5) then
                        param.context.cancelRequests[param.groupname] = nil
                        return
                    end

                    local shouldUpdateMsg = (timer.getAbsTime() - param.lastUpdate) > ReconManager.updateFrequency

                    local withinParameters = false

                    local pgr = Group.getByName(param.groupname)
                    if not pgr then 
                        return 
                    end
                    local pun = pgr:getUnit(1)
                    if not pun or not pun:isExist() then 
                        return
                    end

                    local closestZone = nil
                    if param.lastZone then
                        if param.lastZone.side == pun:getCoalition() then
                            local msg = param.lastZone.name..' is now friendly.'
                            msg = msg..'\n Discarding data.'
                            trigger.action.outTextForUnit(pun:getID(), msg, 20)
                            param.lastZone = nil
                            closestZone = ZoneCommand.getClosestZoneToPoint(pun:getPoint(), pun:getCoalition(), true)
                        else
                            closestZone = param.lastZone
                        end
                    else
                        closestZone = ZoneCommand.getClosestZoneToPoint(pun:getPoint(), pun:getCoalition(), true)
                    end
                    
                    if not closestZone then
                        return
                    end

                    local stats = ReconManager.getAircraftStats(pun:getDesc().typeName)
                    local currentParameters = {
                        distance = 0,
                        deviation = 0,
                        percent_visible = 0
                    }
                    
                    currentParameters.distance = mist.utils.get2DDist(pun:getPoint(), closestZone.zone.point)

                    local unitPos = pun:getPosition()
                    local unitheading = math.deg(math.atan2(unitPos.x.z, unitPos.x.x))
                    local bearing = Utils.getBearing(pun:getPoint(), closestZone.zone.point)
                    
                    currentParameters.deviation = math.abs(Utils.getHeadingDiff(unitheading, bearing))

                    local unitsCount = 0
                    local visibleCount = 0
                    for _,product in pairs(closestZone.built) do
                        if product.side ~= pun:getCoalition() then
                            local gr = Group.getByName(product.name)
                            if gr then
                                for _,enemyUnit in ipairs(gr:getUnits()) do
                                    unitsCount = unitsCount+1
                                    local from = pun:getPoint()
                                    from.y = from.y+1.5
                                    local to = enemyUnit:getPoint()
                                    to.y = to.y+1.5
                                    if land.isVisible(from, to) then
                                        visibleCount = visibleCount+1
                                    end
                                end 
                            else
                                local st = StaticObject.getByName(product.name)
                                if st then
                                    unitsCount = unitsCount+1
                                    local from = pun:getPoint()
                                    from.y = from.y+1.5
                                    local to = st:getPoint()
                                    to.y = to.y+1.5
                                    if land.isVisible(from, to) then
                                        visibleCount = visibleCount+1
                                    end
                                end
                            end
                        end
                    end
                    
                    if unitsCount > 0 and visibleCount > 0 then
                        currentParameters.percent_visible = visibleCount/unitsCount
                    end

                    if currentParameters.distance < (stats.minDist * 1000) and currentParameters.percent_visible >= 0.5 then
                        if stats.maxDeviation then
                            if currentParameters.deviation <= stats.maxDeviation then
                                withinParameters = true
                            end
                        else
                            withinParameters = true
                        end
                    end

                    if withinParameters then
                        if not param.lastZone then
                            param.lastZone = closestZone
                        end

                        param.timeout = 300

                        local speed = stats.recon_speed * currentParameters.percent_visible
                        param.progress = math.min(param.progress + speed, ReconManager.requiredProgress)

                        if shouldUpdateMsg then
                            local msg = "[Recon: "..param.lastZone.name..']'
                            msg = msg.."\nProgress: "..string.format('%.1f', (param.progress/ReconManager.requiredProgress)*100)..'%\n'
                            msg = msg.."\nVisibility: "..string.format('%.1f', currentParameters.percent_visible*100)..'%'
                            trigger.action.outTextForUnit(pun:getID(), msg, ReconManager.updateFrequency)

                            param.lastUpdate = timer.getAbsTime()
                        end
                    else
                        param.timeout = param.timeout - 1
                        if shouldUpdateMsg then

                            local msg = "[Nearest enemy zone: "..closestZone.name..']'
                            
                            if param.lastZone then
                                msg = "[Recon in progress: "..param.lastZone.name..']'
                                msg = msg.."\nProgress: "..string.format('%.1f', (param.progress/ReconManager.requiredProgress)*100)..'%\n'
                            end
                            
                            if stats.maxDeviation then
                                msg = msg.."\nDeviation: "..string.format('%.1f', currentParameters.deviation)..' deg (under '..stats.maxDeviation..' deg)'
                            end
                            
                            msg = msg.."\nDistance: "..string.format('%.2f', currentParameters.distance/1000)..'km (under '..stats.minDist..' km)'
                            msg = msg.."\nVisibility: "..string.format('%.1f', currentParameters.percent_visible*100)..'% (min 50%)'
                            msg = msg.."\n\nTime left: "..param.timeout..' sec'
                            trigger.action.outTextForUnit(pun:getID(), msg, ReconManager.updateFrequency)

                            param.lastUpdate = timer.getAbsTime()
                        end
                    end

                    if param.progress >= ReconManager.requiredProgress then

                        local msg = "Data recorded for "..param.lastZone.name
                        msg = msg.."\nAnalyze data at a friendly zone to recover results"
                        trigger.action.outTextForUnit(pun:getID(), msg, 20)

                        param.context.recondata[param.groupname] = param.lastZone
                        return
                    end
                    
                    if param.timeout > 0 then
                        return time+1
                    end

                    local msg = "Recon cancelled."
                    if param.progress > 0 then
                        msg = msg.." Data lost."
                    end 
                    trigger.action.outTextForUnit(pun:getID(), msg, 20)

                end, {context = self, groupname = groupname, timeout = 300, progress = 0, lastZone = nil, lastUpdate = timer.getAbsTime()-5}, timer.getTime()+1)
            end
        end
    end

    function ReconManager:cancelRecon(groupname)
        self.cancelRequests[groupname] = timer.getAbsTime()
    end

    function ReconManager:uploadData(groupname)
        local gr = Group.getByName(groupname)
        if not gr then return end
        local un = gr:getUnit(1)
        if not un or not un:isExist() then return end
        local player = un:getPlayerName()
        
        local zn = ZoneCommand.getZoneOfUnit(un:getName())
        if not zn then
            zn = CarrierCommand.getCarrierOfUnit(un:getName())
        end

        if not zn then
            zn = FARPCommand.getFARPOfUnit(un:getName())
        end

        local data = self.recondata[groupname]
        if not data then
            trigger.action.outTextForUnit(un:getID(), "No data recorded.", 5)
            return
        end

        if not zn or not Utils.isLanded(un, zn.isCarrier) or zn.side ~= un:getCoalition() then 
            timer.scheduleFunction(function(param, time) 
                local gr = Group.getByName(param.groupname)
                if not gr then return end
                local un = gr:getUnit(1)
                if not un or not un:isExist() then return end

                local data = self.recondata[groupname]
                if not data then return end

                local stats = ReconManager.getAircraftStats(un:getDesc().typeName)

                param.progress = param.progress - stats.uploadRate
                if param.progress <= 0 then
                    param.context:analyzeData(param.groupname, true)
                else
                    if timer.getTime() - param.lastMessageTime > 2 then 
                        local printProgress = string.format("%.2f", math.max(100.0-param.progress, 0.0))

                        trigger.action.outTextForUnit(un:getID(), "Uploading data ["..printProgress.."%]", 2)
                        param.lastMessageTime = timer.getTime()
                    end
                    return time+1
                end
            end, { context = self, groupname = groupname, progress = 100.0, lastMessageTime = timer.getTime()-10}, timer.getTime()+1)
        else
            self:analyzeData(groupname)
        end
    end

    function ReconManager:analyzeData(groupname, ignoreZone)
        local gr = Group.getByName(groupname)
        if not gr then return end
        local un = gr:getUnit(1)
        if not un or not un:isExist() then return end
        local player = un:getPlayerName()
        
        local zn = nil
        if not ignoreZone then
            zn = ZoneCommand.getZoneOfUnit(un:getName())
            if not zn then
                zn = CarrierCommand.getCarrierOfUnit(un:getName())
            end
            
            if not zn then
                zn = FARPCommand.getFARPOfUnit(un:getName())
                if zn and not zn:hasFeature(PlayerLogistics.buildables.satuplink) then
                    trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Satellite Uplink. Can not analyze recon data.', 10)
                    return
                end
            end

            if not zn or not Utils.isLanded(un, zn.isCarrier) or zn.side ~= un:getCoalition() then 
                trigger.action.outTextForUnit(un:getID(), "Recon data can only be analyzed while landed in a friendly zone.", 5)
                return 
            end
        end

        local data = self.recondata[groupname]
        if data then
            if data.side == un:getCoalition() then
                local msg = data.name..' is now friendly'
                msg = msg..'\n Data discarded.'
                trigger.action.outTextForUnit(un:getID(), msg, 20)
            else
                local wasRevealed = data.revealTime > 60
                data:reveal()

                local stats = ReconManager.getAircraftStats(un:getDesc().typeName)
                local side = 0
                if un:getCoalition() == 1 then 
                    side = 2
                elseif un:getCoalition() == 2 then
                    side = 1
                end

                self:revealEnemyInZone(data, un, side, stats.precission)

                local xp = RewardDefinitions.actions.recon * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(player)
                if wasRevealed then
                    xp = xp/10
                end

                if ignoreZone then
                    local instantxp = math.floor(xp*0.25)
                    local tempxp = math.floor(xp - instantxp)

                    DependencyManager.get("PlayerTracker"):addStat(player, instantxp, PlayerTracker.statTypes.xp)
                    env.info("ReconManager.analyzeData - "..player..' awarded '..tostring(instantxp)..' xp')

                    local msg = '[XP] '..DependencyManager.get("PlayerTracker").stats[player][PlayerTracker.statTypes.xp]..' (+'..instantxp..')'
                    DependencyManager.get("PlayerTracker"):addTempStat(player, tempxp, PlayerTracker.statTypes.xp)
                    msg = msg..'\n+'..tempxp..' XP (unclaimed)'
                    trigger.action.outTextForUnit(un:getID(), msg, 10)
                    env.info("ReconManager.analyzeData - "..player..' awarded '..tostring(tempxp)..' xp (unclaimed)')
                else
                    DependencyManager.get("PlayerTracker"):addStat(player, math.floor(xp), PlayerTracker.statTypes.xp)
                    local msg = '+'..math.floor(xp)..' XP'
                    trigger.action.outTextForUnit(un:getID(), msg, 10)
                end

                local analyzeZoneName = ''
                if zn then
                    analyzeZoneName = zn.name
                end

                DependencyManager.get("MissionTracker"):tallyRecon(player, data.name, analyzeZoneName)
            end

            self.recondata[groupname] = nil
        else
            trigger.action.outTextForUnit(un:getID(), "No data recorded.", 5)
        end
    end

    function ReconManager:delayedDiscoverGroups(groupname)
        local gr = Group.getByName(groupname)
        if not gr then return end
        local un = gr:getUnit(1)
        if not un or not un:isExist() then return end

        trigger.action.outTextForUnit(un:getID(), "Reporting...", 3)

        timer.scheduleFunction(function(param,time)
            param.context:discoverGroups(param.groupname)
        end, {context=self, groupname=groupname}, timer.getTime()+3)
    end

    function ReconManager:discoverGroups(groupname)
        local gr = Group.getByName(groupname)
        if not gr then return end
        local un = gr:getUnit(1)
        if not un or not un:isExist() then return end
        local player = un:getPlayerName()
        
        local stats = ReconManager.getAircraftStats(un:getDesc().typeName)
        local maxDev = stats.maxDeviation or 999

        local ppos = un:getPoint()
        local volume = {
            id = world.VolumeType.SPHERE,
            params = {
                point = {x=ppos.x, z=ppos.z, y=land.getHeight({x = ppos.x, y = ppos.z})},
                radius = stats.minDist*1000
            }
        }

        local groups = {}
        world.searchObjects(Object.Category.UNIT , volume, function(unit, collection)
            if unit and unit:isExist() and unit:getGroup() then 
                collection[unit:getGroup():getName()] = unit:getGroup()
            end

            return true
         end, groups)

        local count = 0
        for i,v in pairs(groups) do
            if i ~= groupname then
                local unitPos = un:getPosition()
                local unitheading = math.deg(math.atan2(unitPos.x.z, unitPos.x.x))
                local bearing = Utils.getBearing(un:getPoint(), v:getUnit(1):getPoint())
                
                local deviation = math.abs(Utils.getHeadingDiff(unitheading, bearing))

                if v:getCoalition()~=un:getCoalition() and deviation <= maxDev then
                    local from = un:getPoint()
                    from.y = from.y+1.5
                    local to = v:getUnit(1):getPoint()
                    to.y = to.y+1.5
                    if land.isVisible(from, to) then
                        local class = self:revealGroup(i, stats.precission*1000, stats.recon_speed*(60*3))
                        if class then 
                            trigger.action.outTextForUnit(un:getID(), class..' reported, bearing '..math.floor(bearing), 20) 
                            count = count + 1
                        end
                    end
                end
            end
        end

        if count == 0 then trigger.action.outTextForUnit(un:getID(), "Nothing to report", 20) end
    end

    function ReconManager:revealGroup(groupname, padding, lifetime)
        local gr = Group.getByName(groupname)
        if not gr or not gr:isExist() or gr:getSize()==0 then return end
        local class = ReconManager.classifyGroup(gr)
        if class == nil then return end

        local ra = ReconArea:new()
        ra.padding = padding
        ra.name = class..'-'..math.fmod(gr:getID(), 10000)

        if lifetime then ra.lifetime = lifetime end

        table.insert(self.reconAreas, ra)
        ra:drawMovingGroup(gr)

        return class
    end

    function ReconManager:revealEnemyInZone(zone, messageUnit, side, accuracy)
        if not accuracy then
            accuracy = 1.0
        end

        for _,bl in pairs(zone.built) do
            if bl.side == side then
                self:createReconArea(bl, zone, 250*accuracy)      
                if messageUnit then trigger.action.outTextForUnit(messageUnit:getID(), bl.display..' discovered at '..zone.name, 20) end
            end
        end
    end

    function ReconManager:createReconArea(product, zone, padding, lifetime, skipMissionTGT)
        local ra = ReconArea:new(zone.name, product.name)
        ra.padding = padding
        local keep = false

        if product.type == ZoneCommand.productTypes.upgrade then
            local tgt = StaticObject.getByName(product.name)
            if tgt then
                if not skipMissionTGT then MissionTargetRegistry.addStrikeTarget(product, zone) end
                local tgp = tgt:getPoint()
                if ra.padding > 30 then
                    tgp.x = tgp.x + math.random(-ra.padding, ra.padding)
                    tgp.z = tgp.z + math.random(-ra.padding, ra.padding)
                end
                ra:addPoint(tgp)
                keep = true
        
                ra.name = product.display..'-'..math.fmod(tgt:getID(), 10000)
            end
        elseif product.type == ZoneCommand.productTypes.defense then
            local tgt = Group.getByName(product.name)
            if tgt then
                local class = ReconManager.classifyGroup(tgt)
                if class then
                    for i,v in ipairs(tgt:getUnits()) do
                        local tgp = v:getPoint()
                        if ra.padding > 30 then
                            tgp.x = tgp.x + math.random(-ra.padding, ra.padding)
                            tgp.z = tgp.z + math.random(-ra.padding, ra.padding)
                        end
                        ra:addPoint(tgp)
                        keep = true
                    end

                    ra.name = class..'-'..math.fmod(tgt:getID(), 10000)
                end
            end
        end

        if keep then
            if lifetime then ra.lifetime = lifetime end
            table.insert(self.reconAreas, ra)
            ra:draw()
        end
    end

    function ReconManager.classifyGroup(group)
        local classes = {
            { class="LORAD", attr="LR SAM" },
            { class="MEDRAD", attr="MR SAM" },
            { class="SHORAD", attr="SR SAM" },
            { class="MANPADS", attr="MANPADS" },
            { class="IR SAM", attr="IR Guided SAM" },
            { class="AAA", attr="AAA" },
            { class="EWR", attr="EWR"},
            { class="ARMOR", attr="Armored vehicles" },
            { class="INFANTRY", attr="Infantry" },
            { class="UNARMED", attr="Unarmed vehicles" },
        }

        local class = nil
        local rank = #classes
        for i,v in ipairs(group:getUnits()) do
            for r,c in ipairs(classes) do
                if r > rank then break end

                if v:hasAttribute(c.attr) then 
                    class = c
                    rank = r
                end
            end
        end

        if class then return class.class end
    end

    function ReconManager.getAircraftStats(aircraftType)
        local stats = ReconManager.aircraftStats[aircraftType]
        if not stats then
            stats = { uploadRate = 0, precission = 1.0, recon_speed = 1, minDist = 5, maxDeviation = 45 }
        end

        return stats
    end

    ReconManager.aircraftStats = {
        ['A-10A'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['A-10C'] =         { uploadRate = 0, precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['A-10C_2'] =       { uploadRate = 0, precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['A-4E-C'] =        { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['AJS37'] =         { uploadRate = 0,   precission=0.7, recon_speed = 10, minDist = 10, maxDeviation = 90 },
        ['AV8BNA'] =        { uploadRate = 0,   precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['C-101CC'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['F-14A-135-GR'] =  { uploadRate = 0,   precission=0.5, recon_speed = 10, minDist = 5,  maxDeviation = 120 },
        ['F-4E-45MC'] =     { uploadRate = 0,   precission=0.5, recon_speed = 5,  minDist = 5,  maxDeviation = 90 },
        ['F-14B'] =         { uploadRate = 0,   precission=0.5, recon_speed = 10, minDist = 5,  maxDeviation = 120 },
        ['F-15C'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['F-16C_50'] =      { uploadRate = 0, precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['F-5E-3'] =        { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['F-86F Sabre'] =   { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['FA-18C_hornet'] = { uploadRate = 0, precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['Hercules'] =      { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['J-11A'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['JF-17'] =         { uploadRate = 0, precission=0.5, recon_speed = 2,  minDist = 20, maxDeviation = 120 },
        ['L-39ZA'] =        { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['M-2000C'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Mirage-F1BE'] =   { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Mirage-F1CE'] =   { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Mirage-F1EE'] =   { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-15bis'] =     { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-19P'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-21Bis'] =     { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-29A'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-29G'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['MiG-29S'] =       { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Su-25'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Su-25T'] =        { uploadRate = 0,   precission=0.8, recon_speed = 2,  minDist = 10, maxDeviation = 45 },
        ['Su-27'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['Su-33'] =         { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        ['T-45'] =          { uploadRate = 0,   precission=1.0, recon_speed = 1,  minDist = 5,  maxDeviation = 45 },
        
        ['AH-64D_BLK_II'] = { uploadRate = 0, precission=0.3, recon_speed = 5,  minDist = 15, maxDeviation = 120 },
        ['Ka-50'] =         { uploadRate = 0,   precission=0.3, recon_speed = 5,  minDist = 15, maxDeviation = 35  },
        ['Ka-50_3'] =       { uploadRate = 0,   precission=0.3, recon_speed = 5,  minDist = 15, maxDeviation = 35  },
        ['Mi-24P'] =        { uploadRate = 0,   precission=0.5, recon_speed = 5,  minDist = 10, maxDeviation = 60  },
        ['Mi-8MT'] =        { uploadRate = 0,   precission=0.8, recon_speed = 1,  minDist = 5,  maxDeviation = 30  },
        ['SA342L'] =        { uploadRate = 1.6,   precission=0.3, recon_speed = 5,  minDist = 10, maxDeviation = 120, canRecon=true },
        ['SA342M'] =        { uploadRate = 1.6,   precission=0.2, recon_speed = 10, minDist = 15, maxDeviation = 120, canRecon=true },
        ['SA342Minigun'] =  { uploadRate = 1.6,   precission=0.7, recon_speed = 3,  minDist = 5,  maxDeviation = 45, canRecon=true  },
        ['UH-1H'] =         { uploadRate = 0,   precission=0.8, recon_speed = 1,  minDist = 5,  maxDeviation = 30  },
        ['UH-60L'] =        { uploadRate = 0,   precission=0.8, recon_speed = 1,  minDist = 8,  maxDeviation = 45  },
        ['OH-6A'] =         { uploadRate = 1.6,   precission=0.8, recon_speed = 3,  minDist = 8,  maxDeviation = 45, canRecon=true  },
        ['OH58D'] =         { uploadRate = 5,   precission=0.1, recon_speed = 10, minDist = 15, maxDeviation = 190, canRecon=true },
        ['CH-47Fbl1'] =        { uploadRate = 0,   precission=0.8, recon_speed = 1,  minDist = 5,  maxDeviation = 30  },
        
        ['M 818'] = 	            { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['Land_Rover_101_FC'] = 	{ uploadRate = 0,   precission=0.8, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['M-2 Bradley'] = 	        { uploadRate = 0,   precission=0.5, recon_speed = 2, minDist = 5,  maxDeviation = 45 },
        ['M6 Linebacker'] = 	    { uploadRate = 0,   precission=0.5, recon_speed = 2, minDist = 5,  maxDeviation = 45 },
        ['M-113'] = 	            { uploadRate = 1.6, precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45, canRecon=true  },
        ['MLRS'] = 	                { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['M-109'] = 	            { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['M1A2C_SEP_V3'] = 	        { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['M-60'] = 	                { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['MaxxPro_MRAP'] = 	        { uploadRate = 1.6, precission=0.8, recon_speed = 5, minDist = 5,  maxDeviation = 45, canRecon=true  },
        ['M1043 HMMWV Armament'] = 	{ uploadRate = 1.6, precission=0.3, recon_speed = 10, minDist = 5,  maxDeviation = 45, canRecon=true  },
        ['M1097 Avenger'] = 	    { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['Gepard'] = 	            { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['VAB_Mephisto'] = 	        { uploadRate = 0,   precission=0.5, recon_speed = 2, minDist = 5,  maxDeviation = 45 },
        ['MCV-80'] = 	            { uploadRate = 0,   precission=0.5, recon_speed = 2, minDist = 5,  maxDeviation = 45 },
        ['Marder'] = 	            { uploadRate = 0,   precission=0.5, recon_speed = 2, minDist = 5,  maxDeviation = 45 },
        ['Roland ADS'] = 	        { uploadRate = 0,   precission=1.0, recon_speed = 1, minDist = 5,  maxDeviation = 45  },
        ['M1045 HMMWV TOW'] = 	    { uploadRate = 1.6, precission=0.3, recon_speed = 10, minDist = 5,  maxDeviation = 45, canRecon=true  }
    }
end

-----------------[[ END OF ReconManager.lua ]]-----------------



-----------------[[ SelfJtac.lua ]]-----------------

SelfJtac = {}

do
    SelfJtac.categories = {}
	SelfJtac.categories['SAM'] = {'SAM SR', 'SAM TR', 'IR Guided SAM','SAM LL','SAM CC'}
	SelfJtac.categories['Infantry'] = {'Infantry'}
	SelfJtac.categories['Armor'] = {'Tanks','IFV','APC'}
	SelfJtac.categories['Support'] = {'Unarmed vehicles','Artillery'}
	SelfJtac.categories['Structures'] = {'StaticObjects'}

    	--{name = 'groupname'}
	function SelfJtac:new(obj)
		obj = obj or {}
		obj.lasers = {tgt=nil, ir=nil}
		obj.target = nil
		obj.priority = nil
		obj.jtacMenu = nil
		obj.laserCode = 1688
        obj.groupID = Group.getByName(obj.name):getID()
		obj.side = Group.getByName(obj.name):getCoalition()
        obj.timer = nil
		setmetatable(obj, self)
		self.__index = self
		return obj
	end

    function SelfJtac:setCode(code)
        if code>=1111 and code <= 1788 then
            self.laserCode = code
            trigger.action.outTextForGroup(self.groupID, 'Laser code set to '..code, 10)
        else
            trigger.action.outTextForGroup(self.groupID, 'Invalid laser code. Must be between 1111 and 1788 ', 10)
        end
    end
	
	function SelfJtac:showMenu()
		local gr = Group.getByName(self.name)
		if not gr then
			return
		end
		
		if not self.jtacMenu then
			self.jtacMenu = missionCommands.addSubMenuForGroup(self.groupID, 'Laser Designator')
			
			missionCommands.addCommandForGroup(self.groupID, 'Search', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					dr:searchTarget()
				end
			end, self)

            
			missionCommands.addCommandForGroup(self.groupID, 'Clear', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					dr:clearTarget()
                    trigger.action.outTextForGroup(dr.groupID, 'Target cleared', 10)
				end
			end, self)

            missionCommands.addCommandForGroup(self.groupID, 'Target info', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					dr:printTarget(true)
				end
			end, self)
			
			local priomenu = missionCommands.addSubMenuForGroup(self.groupID, 'Priority', self.jtacMenu)
			for i,v in pairs(SelfJtac.categories) do
				missionCommands.addCommandForGroup(self.groupID, i, priomenu, function(dr, cat)
					if Group.getByName(dr.name) then
						dr:setPriority(cat)
                        if dr.target then
						    dr:searchTarget()
                        end
					end
				end, self, i)
			end

            local dial = missionCommands.addSubMenuForGroup(self.groupID, 'Code', self.jtacMenu)
            for i2=1,7,1 do
                local digit2 = missionCommands.addSubMenuForGroup(self.groupID, '1'..i2..'__', dial)
                for i3=1,9,1 do
                    local digit3 = missionCommands.addSubMenuForGroup(self.groupID, '1'..i2..i3..'_', digit2)
                    for i4=1,9,1 do
                        local code = tonumber('1'..i2..i3..i4)
                        missionCommands.addCommandForGroup(self.groupID, '1'..i2..i3..i4, digit3, self.setCode, self, code)
                    end
                end
            end
			
			missionCommands.addCommandForGroup(self.groupID, "Clear", priomenu, function(dr)
				if Group.getByName(dr.name) then
					dr:clearPriority()
				end
			end, self)
		end
	end
	
	function SelfJtac:setPriority(prio)
		self.priority = SelfJtac.categories[prio]
		self.prioname = prio
        trigger.action.outTextForGroup(self.groupID, 'Focusing on '..prio, 10)
	end
	
	function SelfJtac:clearPriority()
		self.priority = nil
	end
	
	function SelfJtac:setTarget(unit)
		
		local me = Group.getByName(self.name)
		if not me then return end

        local meun = me:getUnit(1)
        local stats = SelfJtac.getAircraftStats(meun:getDesc().typeName)
		
		local pnt = unit:getPoint()

        local unitPos = meun:getPosition()
        local unitheading = math.deg(math.atan2(unitPos.x.z, unitPos.x.x))
        local bearing = SelfJtac.getBearing(meun:getPoint(), pnt)
        local unitDistance = SelfJtac.getDist(pnt, meun:getPoint())
        
        local deviation = math.abs(SelfJtac.getHeadingDiff(unitheading, bearing))

        local from = meun:getPoint()
        from.y = from.y+1.5
        local to = unit:getPoint()
        to.y = to.y+1.5

        if unitDistance > (stats.minDist * 1000) or deviation > stats.maxDeviation or not land.isVisible(from, to) then
            self:clearTarget()
			trigger.action.outTextForGroup(self.groupID, "Target out of bounds, stoping laser", 10)
            return
        end

        local dst = 99999
        if self.prevPnt then
            dst = SelfJtac.getDist(pnt, self.prevPnt)
        end
        
        if not self.prevPnt or dst >= 0.5 then
            if self.lasers.tgt then
                self.lasers.tgt:setPoint(pnt)
            else
                self.lasers.tgt = Spot.createLaser(meun, { x = 0, y = 5.0, z = 0 }, Utils.getPointOnSurface(pnt), self.laserCode)
            end
            
            if self.lasers.ir then
                self.lasers.ir:setPoint(pnt)
            else
                self.lasers.ir = Spot.createInfraRed(meun, stats.laserOffset, pnt)
            end

            self.prevPnt = pnt
        end
		
		self.target = unit:getName()

        timer.scheduleFunction(function(param, time)
            param:updateTarget()
        end, self, timer.getTime()+0.5)
	end
	
	function SelfJtac:printTarget(makeitlast)
		local toprint = ''
		if self.target then
			local tgtunit = Unit.getByName(self.target)
            local isStructure = false
            if not tgtunit then 
                tgtunit = StaticObject.getByName(self.target)
                isStructure = true
            end

			if tgtunit and tgtunit:isExist() then
				local pnt = tgtunit:getPoint()
                local tgttype = "Unidentified"
                if isStructure then
                    tgttype = "Structure"
                else
                    tgttype = tgtunit:getTypeName()
                end
				
				if self.priority then
					toprint = 'Priority targets: '..self.prioname..'\n'
				end
				
				toprint = toprint..'Lasing '..tgttype..'\nCode: '..self.laserCode..'\n'
                local lat,lon,alt = coord.LOtoLL(pnt)
                local mgrs = coord.LLtoMGRS(coord.LOtoLL(pnt))
                if mist then
                    toprint = toprint..'\nDDM:  '.. mist.tostringLL(lat,lon,3)
                    toprint = toprint..'\nDMS:  '.. mist.tostringLL(lat,lon,2,true)
                    toprint = toprint..'\nMGRS: '.. mist.tostringMGRS(mgrs, 5)
                end
                
                local me = Group.getByName(self.name)
                if not me then return end
                local meun = me:getUnit(1)

                local bearing = SelfJtac.getBearing(meun:getPoint(), pnt)
                local unitDistance = SelfJtac.getDist(pnt, meun:getPoint())
                toprint = toprint..'\n\Brg: '..math.floor(bearing)
                toprint = toprint..'\n\Dst: '..Utils.round(unitDistance/1000)..'km'
                toprint = toprint..'\n\nAlt: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
			else
				makeitlast = false
				toprint = 'No Target'
			end
		else
			makeitlast = false
			toprint = 'No target'
		end
		
		local gr = Group.getByName(self.name)
		if makeitlast then
			trigger.action.outTextForGroup(self.groupID, toprint, 60)
		else
			trigger.action.outTextForGroup(self.groupID, toprint, 10)
		end
	end
	
	function SelfJtac:clearTarget()
		self.target = nil
        self.prevPnt = nil
	
		if self.lasers.tgt then
			self.lasers.tgt:destroy()
			self.lasers.tgt = nil
		end
		
		if self.lasers.ir then
			self.lasers.ir:destroy()
			self.lasers.ir = nil
		end
	end

	function SelfJtac:updateTarget()
        if Group.getByName(self.name) then
			if self.target then
				local un = Unit.getByName(self.target)
                
				if un and un:isExist() then
					if un:getLife()>=1 then
						self:setTarget(un)
                    else
                        self:clearTarget()
                        trigger.action.outTextForGroup(self.groupID, 'Kill confirmed. Stoping laser', 10)
					end
				else
                    local st = StaticObject.getByName(self.target)
                    if st and st:isExist() then
                        self:setTarget(st)
                    else
                        self:clearTarget()
                        trigger.action.outTextForGroup(self.groupID, 'Kill confirmed. Stoping laser', 10)
					end
                end
			end
		else
			self:clearTarget()
		end
    end


	function SelfJtac.getBearing(fromvec, tovec)
		local fx = fromvec.x
		local fy = fromvec.z
		
		local tx = tovec.x
		local ty = tovec.z
		
		local brg = math.atan2(ty - fy, tx - fx)
		
		
		if brg < 0 then
			 brg = brg + 2 * math.pi
		end
		
		brg = brg * 180 / math.pi
		

		return brg
	end

	function SelfJtac.getHeadingDiff(heading1, heading2) -- heading1 + result == heading2
		local diff = heading1 - heading2
		local absDiff = math.abs(diff)
		local complementaryAngle = 360 - absDiff
	
		if absDiff <= 180 then 
			return -diff
		elseif heading1 > heading2 then
			return complementaryAngle
		else
			return -complementaryAngle
		end
	end

    function SelfJtac.getDist(point1, point2)
        local vec = {x = point1.x - point2.x, y = point1.y - point2.y, z = point1.z - point2.z}
        return (vec.x^2 + vec.y^2 + vec.z^2)^0.5
    end
	
	function SelfJtac:searchTarget()
		local gr = Group.getByName(self.name)
		if gr and gr:isExist() then
            local un = gr:getUnit(1)
            local stats = SelfJtac.getAircraftStats(un:getDesc().typeName)

            local ppos = un:getPoint()
            local volume = {
                id = world.VolumeType.SPHERE,
                params = {
                    point = {x=ppos.x, z=ppos.z, y=land.getHeight({x = ppos.x, y = ppos.z})},
                    radius = stats.minDist*1000
                }
            }

            local targets = {}
            world.searchObjects({Object.Category.UNIT, Object.Category.STATIC}, volume, function(unit, collection)
                if unit and unit:isExist() then 
                    collection[unit:getName()] = unit
                end

                return true
            end, targets)

            local viabletgts = {}
            for i,v in pairs(targets) do
                if v and v:isExist() and v:getLife()>=1 and i ~= un:getName() and v:getCoalition()~=un:getCoalition() then
                    local unitPos = un:getPosition()
                    local unitheading = math.deg(math.atan2(unitPos.x.z, unitPos.x.x))
                    local bearing = SelfJtac.getBearing(un:getPoint(), v:getPoint())
                    
                    local deviation = math.abs(SelfJtac.getHeadingDiff(unitheading, bearing))
                    local unitDistance = SelfJtac.getDist(un:getPoint(), v:getPoint())
    
                    if unitDistance <= (stats.minDist*1000) and deviation <= stats.maxDeviation then
                        local from = un:getPoint()
                        from.y = from.y+1.5
                        local to = v:getPoint()
                        to.y = to.y+1.5
                        if land.isVisible(from, to) then
                            table.insert(viabletgts, v)
                        end
                    end
                end
            end
            
            if self.priority then
                local priorityTargets = {}
                for i,v in ipairs(viabletgts) do
                    for i2,v2 in ipairs(self.priority) do
                        if v2 == "StaticObjects" and Object.getCategory(v) == Object.Category.STATIC then
                            table.insert(priorityTargets, v)
                            break
                        elseif v:hasAttribute(v2) and v:getLife()>=1 then
                            table.insert(priorityTargets, v)
                            break
                        end
                    end
                end
                
                if #priorityTargets>0 then
                    viabletgts = priorityTargets
                else
                    trigger.action.outTextForGroup(self.groupID, 'No priority targets found, searching for anything...', 10)
                end
            end
            
            if #viabletgts>0 then
                local chosentgt = math.random(1, #viabletgts)
                self:setTarget(viabletgts[chosentgt])
                self:printTarget()
            else
                trigger.action.outTextForGroup(self.groupID, 'No targets found', 10)
                self:clearTarget()
            end
		end
	end

    function SelfJtac.getAircraftStats(aircraftType)
        local stats = SelfJtac.aircraftStats[aircraftType]
        if not stats then
            return
        end

        return stats
    end

    SelfJtac.aircraftStats = {
        ['SA342L'] =        { minDist = 10, maxDeviation = 120, laserOffset = { x = 1.4, y = 1.1, z = -0.35 }  },
        ['SA342M'] =        { minDist = 15, maxDeviation = 120, laserOffset =  { x = 1.4, y = 1.23, z = -0.35 }   },
        ['UH-60L'] =        { minDist = 8,  maxDeviation = 45,  laserOffset = { x = 4.65, y = -1.8, z = 0 }   },
        ['OH-6A'] =         { minDist = 8,  maxDeviation = 45,  laserOffset = { x = 1.35, y = 0.1, z = 0 }   },
    }

    SelfJtac.jtacs = {}

    MenuRegistry.register(8, function(event, context)
        if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
            local player = event.initiator:getPlayerName()
            if player then
                local stats = SelfJtac.getAircraftStats(event.initiator:getDesc().typeName)
                if stats then
                    local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()
                    if SelfJtac.jtacs[groupid] then
                        local oldjtac = SelfJtac.jtacs[groupid]
                        oldjtac:clearTarget()
                        missionCommands.removeItemForGroup(groupid, oldjtac.jtacMenu)
                        SelfJtac.jtacs[groupid] = nil
                    end

                    if not SelfJtac.jtacs[groupid] then
                        local newjtac = SelfJtac:new({name = groupname})
                        newjtac:showMenu()
                        SelfJtac.jtacs[groupid] = newjtac
                    end
                end
            end
        end
    end)
end



-----------------[[ END OF SelfJtac.lua ]]-----------------



-----------------[[ MissionTargetRegistry.lua ]]-----------------

MissionTargetRegistry = {}
do
    MissionTargetRegistry.playerTargetZones = {}

    function MissionTargetRegistry.addZone(zone)
        MissionTargetRegistry.playerTargetZones[zone] = true
    end

    function MissionTargetRegistry.removeZone(zone)
        MissionTargetRegistry.playerTargetZones[zone] = nil
    end

    function MissionTargetRegistry.isZoneTargeted(zone)
        return MissionTargetRegistry.playerTargetZones[zone] ~= nil
    end

    MissionTargetRegistry.baiTargets = {}

    function MissionTargetRegistry.addBaiTarget(target)
        MissionTargetRegistry.baiTargets[target.name] = target
        env.info('MissionTargetRegistry - bai target added '..target.name)
    end

    function MissionTargetRegistry.baiTargetsAvailable(coalition)
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.baiTargets) do
            if v.product.side == coalition then
                local tgt = Group.getByName(v.name)

                if not tgt or not tgt:isExist() or tgt:getSize()==0 then
                    MissionTargetRegistry.removeBaiTarget(v)
                elseif not v.state or v.state ~= 'enroute' then
                    MissionTargetRegistry.removeBaiTarget(v)
                else
                    table.insert(targets, v)
                end
            end
        end

        return #targets > 0
    end

    function MissionTargetRegistry.getRandomBaiTarget(coalition)
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.baiTargets) do
            if v.product.side == coalition then
                local tgt = Group.getByName(v.name)

                if not tgt or not tgt:isExist() or tgt:getSize()==0 then
                    MissionTargetRegistry.removeBaiTarget(v)
                elseif not v.state or v.state ~= 'enroute' then
                    MissionTargetRegistry.removeBaiTarget(v)
                else
                    table.insert(targets, v)
                end
            end
        end

        if #targets == 0 then return end

        local dice = math.random(1,#targets)
        
        return targets[dice]
    end

    function MissionTargetRegistry.removeBaiTarget(target)
        MissionTargetRegistry.baiTargets[target.name] = nil
        env.info('MissionTargetRegistry - bai target removed '..target.name)
    end

    MissionTargetRegistry.strikeTargetExpireTime = 60*60
    MissionTargetRegistry.strikeTargets = {}

    function MissionTargetRegistry.addStrikeTarget(target, zone)
        MissionTargetRegistry.strikeTargets[target.name] = {data=target, zone=zone, addedTime = timer.getAbsTime()}
        env.info('MissionTargetRegistry - strike target added '..target.name)
    end

    function MissionTargetRegistry.strikeTargetsAvailable(coalition, isDeep)
        for i,v in pairs(MissionTargetRegistry.strikeTargets) do
            if v.data.side == coalition then
                local tgt = StaticObject.getByName(v.data.name)
                if not tgt then tgt = Group.getByName(v.data.name) end

                if not tgt or not tgt:isExist() then
                    MissionTargetRegistry.removeStrikeTarget(v)
                elseif timer.getAbsTime() - v.addedTime > MissionTargetRegistry.strikeTargetExpireTime then
                    MissionTargetRegistry.removeStrikeTarget(v)
                elseif not isDeep or v.zone.distToFront >= 2 then
                    return true
                end
            end
        end

        return false
    end

    function MissionTargetRegistry.getRandomStrikeTarget(coalition, isDeep)
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.strikeTargets) do
            if v.data.side == coalition then
                local tgt = StaticObject.getByName(v.data.name)
                if not tgt then tgt = Group.getByName(v.data.name) end

                if not tgt or not tgt:isExist() then
                    MissionTargetRegistry.removeStrikeTarget(v)
                elseif timer.getAbsTime() - v.addedTime > MissionTargetRegistry.strikeTargetExpireTime then
                    MissionTargetRegistry.removeStrikeTarget(v)
                elseif not isDeep or v.zone.distToFront >= 2 then
                    table.insert(targets, v)
                end
            end
        end

        if #targets == 0 then return end

        local dice = math.random(1,#targets)

        return targets[dice]
    end

    function MissionTargetRegistry.getAllStrikeTargets(coalition)
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.strikeTargets) do
            if v.data.side == coalition then
                local tgt = StaticObject.getByName(v.data.name)
                if not tgt then tgt = Group.getByName(v.data.name) end

                if not tgt or not tgt:isExist() then
                    MissionTargetRegistry.removeStrikeTarget(v)
                elseif timer.getAbsTime() - v.addedTime > MissionTargetRegistry.strikeTargetExpireTime then
                    MissionTargetRegistry.removeStrikeTarget(v)
                else
                    table.insert(targets, v)
                end
            end
        end

        return targets
    end

    function MissionTargetRegistry.removeStrikeTarget(target)
        MissionTargetRegistry.strikeTargets[target.data.name] = nil
        env.info('MissionTargetRegistry - strike target removed '..target.data.name)
    end

    MissionTargetRegistry.extractableSquads = {}

    function MissionTargetRegistry.addSquad(squad)
        MissionTargetRegistry.extractableSquads[squad.name] = squad
        env.info('MissionTargetRegistry - squad added '..squad.name)
    end

    function MissionTargetRegistry.squadsReadyToExtract(onside)
        for i,v in pairs(MissionTargetRegistry.extractableSquads) do
            local gr = Group.getByName(i)
            if gr and gr:isExist() and gr:getSize() > 0 and gr:getCoalition() == onside then
                return true
            end
        end

        return false
    end

    function MissionTargetRegistry.getRandomSquad(onside)
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.extractableSquads) do
            local gr = Group.getByName(i)
            if gr and gr:isExist() and gr:getSize() > 0 and gr:getCoalition() == onside then
                table.insert(targets, v)
            end
        end

        if #targets == 0 then return end

        local dice = math.random(1,#targets)

        return targets[dice]
    end

    function MissionTargetRegistry.removeSquad(squad)
        MissionTargetRegistry.extractableSquads[squad.name] = nil
        env.info('MissionTargetRegistry - squad removed '..squad.name)
    end

    MissionTargetRegistry.extractablePilots = {}

    function MissionTargetRegistry.addPilot(pilot)
        MissionTargetRegistry.extractablePilots[pilot.name] = pilot
        env.info('MissionTargetRegistry - pilot added '..pilot.name)
    end

    function MissionTargetRegistry.pilotsAvailableToExtract()
        for i,v in pairs(MissionTargetRegistry.extractablePilots) do
            if v.pilot:isExist() and v.pilot:getSize() > 0 and v.remainingTime > 30*60 then
                return true
            end
        end

        return false
    end

    function MissionTargetRegistry.getRandomPilot()
        local targets = {}
        for i,v in pairs(MissionTargetRegistry.extractablePilots) do
            if v.pilot:isExist() and v.pilot:getSize() > 0 and v.remainingTime > 30*60 then
                table.insert(targets, v)
            end
        end

        if #targets == 0 then return end

        local dice = math.random(1,#targets)

        return targets[dice]
    end

    function MissionTargetRegistry.removePilot(pilot)
        MissionTargetRegistry.extractablePilots[pilot.name] = nil
        env.info('MissionTargetRegistry - pilot removed '..pilot.name)
    end
end

-----------------[[ END OF MissionTargetRegistry.lua ]]-----------------



-----------------[[ RadioFrequencyTracker.lua ]]-----------------

RadioFrequencyTracker = {}

do
    RadioFrequencyTracker.radios = {}

    function RadioFrequencyTracker.registerRadio(groupname, name, frequency)
        RadioFrequencyTracker.radios[groupname] = {name = name, frequency = frequency}    
    end

    local function radioToString(label, radio)
        local comFreq = '['..label..'] ['
        for i,v in ipairs(radio.freqs) do
            if i>1 then comFreq = comFreq..' ' end
            comFreq = comFreq..string.format("%.3f", v.frequency/1000000)
            if v.modulation == 0 then
                comFreq = comFreq..' AM'
            else
                comFreq = comFreq..' FM'
            end

            if i < #radio.freqs then comFreq = comFreq..' |' end
        end

        return comFreq..']'
    end

    function RadioFrequencyTracker.getRadioFrequencyMessage(side)
        local radios ={}
        for i,v in pairs(RadioFrequencyTracker.radios) do
            local gr = Group.getByName(i) 
            if gr and gr:getCoalition()==side then
                table.insert(radios, v)
            else
                RadioFrequencyTracker.radios[i] = nil
            end
        end

        table.sort(radios, function (a,b) 
            if a.permanent == b.permanent then
                return a.name < b.name 
            else
                return a.permanent
            end
        end)

        local msg = 'Active frequencies:'
        
        msg = msg..'\n  '..radioToString('Command', TransmissionManager.radios.command)
        msg = msg..'\n  '..radioToString('Infantry', TransmissionManager.radios.infantry)
        msg = msg..'\n  '..radioToString('GCI', TransmissionManager.radios.gci)

        for i,v in ipairs(radios) do
            msg = msg..'\n  '..v.name..' ['..v.frequency..']'
        end

        return msg
    end
end


-----------------[[ END OF RadioFrequencyTracker.lua ]]-----------------



-----------------[[ PersistenceManager.lua ]]-----------------

PersistenceManager = {}

do

    function PersistenceManager:new(path)
        local obj = {
            path = path,
            data = nil
        }

        setmetatable(obj, self)
		self.__index = self
        return obj
    end

    function PersistenceManager:restore()
        self:restoreZones()
        self:restoreAIMissions()
        self:restoreCsar()
        self:restoreSquads()
        self:restoreCarriers()
        self:restoreTrackedBoxes()
        self:restoreFarps()
        self:restoreHumanResource()
        self:restoreStrategy()
        self:restorePlayerVehicles()
        
        timer.scheduleFunction(function(param)
            param:restoreStrikeTargets()
            param:restoreReconAreas()
        end, self, timer.getTime()+5)
    end
    
    function PersistenceManager:restorePlayerVehicles()
        local save = self.data
        if save.playerVehicles then
            DependencyManager.get("PlayerLogistics"):restorePlayerVehicles(save.playerVehicles)
        end
    end

    function PersistenceManager:restoreStrategy()
        local save = self.data
        if save.strategy then 
            StrategicAI.redAI:restoreState(save.strategy.red)
            StrategicAI.blueAI:restoreState(save.strategy.blue)
        end
    end

    function PersistenceManager:restoreHumanResource()
        local save = self.data
        if save.humanResource then
            DependencyManager.get("PlayerLogistics").humanResource = save.humanResource
        end
    end

    function PersistenceManager:restoreFarps()
        local save = self.data
        if save.trackedBuildings then
            for i,v in ipairs(save.trackedBuildings) do
                Spawner.createObject(v.name, v.type, v.pos, v.side, 0, 0, {
                    [land.SurfaceType.LAND] = true, 
                    [land.SurfaceType.ROAD] = true,
                    [land.SurfaceType.RUNWAY] = true
                })

                DependencyManager.get("PlayerLogistics").trackedBuildings[v.name] = { name=v.name, type=v.type }
            end

            timer.scheduleFunction(function(param, time)
                for i,v in ipairs(save.trackedBuildings) do
                    if v.type == PlayerLogistics.buildables.farp then
                        if v.warehouse then
                            WarehouseManager.restore(v.name, v.warehouse)
                        end

                        if v.resource then
                            local f = FARPCommand:new(v.name, 500)
                            f.resource = v.resource
                            DependencyManager.get("PlayerLogistics").trackedBuildings[v.name].farp = f
                        end
                    end
                end
            end, save.trackedBuildings, timer.getTime()+2)
        end
    end

    function PersistenceManager:restoreTrackedBoxes()
        local save = self.data
        if save.trackedBoxes then
            for _,v in ipairs(save.trackedBoxes) do
                DependencyManager.get("PlayerLogistics"):restoreBox(v)
            end
        end
    end

    function PersistenceManager:restoreZones()
        local save = self.data
        for i,v in pairs(save.zones) do
            local z = ZoneCommand.getZoneByName(i)
            if z then
                z:setSide(v.side)
                z.resource = v.resource
                z.revealTime = v.revealTime
                z.extraBuildResources = v.extraBuildResources
                z.sabotageDebt = v.sabotageDebt or 0
                z.mode = v.mode
                z.distToFront = v.distToFront
                z.closestEnemyDist = v.closestEnemyDist
                for name,data in pairs(v.built) do
                    local pr = z:getProductByName(name)
                    z:instantBuild(pr)
    
                    if pr.type == 'defense' and type(data) == "table" then
                        local unitTypes = {}
                        for _,typeName in ipairs(data) do
                            if not unitTypes[typeName] then 
                                unitTypes[typeName] = 0
                            end
                            unitTypes[typeName] = unitTypes[typeName] + 1
                        end
    
                        timer.scheduleFunction(function(param, time)
                            local gr = Group.getByName(param.name)
                            if gr then
                                local types = param.data
                                local toKill = {}
                                for _,un in ipairs(gr:getUnits()) do
                                    local tp = un:getDesc().typeName
                                    if types[tp] and types[tp] > 0 then
                                        types[tp] = types[tp] - 1
                                    else
                                        table.insert(toKill, un)
                                    end
                                end
    
                                for _,un in ipairs(toKill) do
                                    un:destroy()
                                end
                            end
                        end, {data=unitTypes, name=name}, timer.getTime()+2)
                    end
                end
                
                if v.currentBuild then
                    local pr = z:getProductByName(v.currentBuild.name)
                    z:queueBuild(pr, v.currentBuild.isRepair, v.currentBuild.progress)
                end
    
                if v.currentMissionBuild then
                    local pr = z:getProductByName(v.currentMissionBuild.name)
                    z:queueBuild(pr, false, v.currentMissionBuild.progress)
                end
                
                z:refreshText()
            end
        end

        if save.missionResources then
            for i,v in ipairs(save.missionResources) do
                for i2,v2 in pairs(v) do
                    local z = ZoneCommand.getZoneByName(v2.ownername)
                    local prod = z:getProductByName(v2.prodname)

                    StrategicAI.pushResource(prod)
                end
            end
        end
    end

    function PersistenceManager:restoreAIMissions()
        local save = self.data
        local instantBuildStates = {
            ['uninitialized'] = true,
            ['takeoff'] = true,
        }
    
        local reActivateStates = {
            ['inair'] = true,
            ['enroute'] = true,
            ['atdestination'] = true,
            ['siege'] = true
        }
    
        for i,v in pairs(save.activeGroups) do
            if v.homeName and v.state then
                if instantBuildStates[v.state] then
                    local z = ZoneCommand.getZoneByName(v.homeName)
                    if z then
                        local pr = z:getProductByName(v.productName)
                        if z.side == pr.side then
                            z:instantBuild(pr)
                        end
                    end
                elseif v.lastMission and reActivateStates[v.state] then
                    timer.scheduleFunction(function(param, time)
                        local z = ZoneCommand.getZoneByName(param.ownerName)
                        local p = z:getProductByName(param.productName)
                        AIActivator.activateMission(p, nil, v)
                    end, v, timer.getTime()+3)
                end
            end
        end
    end

    function PersistenceManager:restoreCsar()
        local save = self.data
        if save.csarTracker then
            for i,v in pairs(save.csarTracker) do
                DependencyManager.get("CSARTracker"):restorePilot(v)
            end
        end
    end

    function PersistenceManager:restoreSquads()
        local save = self.data
        if save.squadTracker then
            for i,v in pairs(save.squadTracker) do
                local sdata = nil
                if v.isAISpawned then
                    if v.type == PlayerLogistics.infantryTypes.ambush then
                        sdata = GroupMonitor.aiSquads.ambush[v.side]
                    else 
                        sdata = GroupMonitor.aiSquads.manpads[v.side]
                    end
                else
                    sdata = DependencyManager.get("PlayerLogistics").registeredSquadGroups[v.type]
                end

                if sdata then
                    v.data = sdata
                    DependencyManager.get("SquadTracker"):restoreInfantry(v)
                end
            end
        end
    end

    function PersistenceManager:restoreStrikeTargets()
        local save = self.data
        if save.strikeTargets then
            for i,v in pairs(save.strikeTargets) do
                local zone = ZoneCommand.getZoneByName(v.zname)
                local product = zone:getProductByName(v.pname)

                MissionTargetRegistry.strikeTargets[i] = {
                    data = product,
                    zone = zone,
                    addedTime = timer.getAbsTime() - v.elapsedTime,
                    isDeep = isDeep
                }
            end
        end
    end

    function PersistenceManager:restoreReconAreas()
        local save = self.data
        if save.reconAreas then
            for i,v in pairs(save.reconAreas) do
                if v.gname then
                    local gr = Group.getByName(v.gname)
                    DependencyManager.get("ReconManager"):revealGroup(v.gname, v.padding, v.lifetime)
                else
                    local zone = ZoneCommand.getZoneByName(v.zname)
                    local product = zone:getProductByName(v.pname)
                    DependencyManager.get("ReconManager"):createReconArea(product, zone, v.padding, v.lifetime, true)
                end
            end
        end
    end

    function PersistenceManager:restoreCarriers()
        local save = self.data
        if save.carriers then
            for i,v in pairs(save.carriers) do
                local carrier = CarrierCommand.getCarrierByName(v.name)
                if carrier then 
                    carrier.resource = math.min(v.resource, carrier.maxResource)
                    carrier.weaponStocks = v.weaponStocks or {}

                    local group = Group.getByName(v.name)
                    if group then
                        local vars = {
                            groupName = group:getName(),
                            point = v.position.p,
                            action = 'teleport',
                            heading = math.atan2(v.position.x.z, v.position.x.x),
                            initTasks = false,
                            route = {}
                        }
                
                        mist.teleportToPoint(vars)

                        timer.scheduleFunction(function(param, time)
                            param:setupRadios()
                        end, carrier, timer.getTime()+3)

                        carrier.navigation.waypoints = v.navigation.waypoints
                        carrier.navigation.currentWaypoint = nil
                        carrier.navigation.nextWaypoint = v.navigation.currentWaypoint
                        carrier.navigation.loop = v.navigation.loop

                        if v.supportFlightStates then
                            for sfsName, sfsData in pairs(v.supportFlightStates) do
                                local sflight = carrier.supportFlights[sfsName]
                                if sflight then
                                    if sfsData.state == CarrierCommand.supportStates.inair and sfsData.targetName and sfsData.position then
                                        local zn = ZoneCommand.getZoneByName(sfsData.targetName)
                                        if not zn then 
                                            zn = CarrierCommand.getCarrierByName(sfsData.targetName)
                                        end

                                        if not zn then 
                                            zn = FARPCommand.getFARPByName(sfsData.targetName)
                                        end

                                        if zn then
                                            CarrierCommand.spawnSupport(sflight, zn, sfsData)
                                        end
                                    elseif sfsData.state == CarrierCommand.supportStates.takeoff and sfsData.targetName then
                                        local zn = ZoneCommand.getZoneByName(sfsData.targetName)
                                        if not zn then 
                                            zn = CarrierCommand.getCarrierByName(sfsData.targetName)
                                        end
                                        
                                        if not zn then 
                                            zn = FARPCommand.getFARPByName(sfsData.targetName)
                                        end

                                        if zn then
                                            CarrierCommand.spawnSupport(sflight, zn)
                                        end
                                    end
                                end
                            end
                        end

                        if v.aliveGroupMembers then
                            timer.scheduleFunction(function(param, time)
                                local g = Group.getByName(param.name)
                                if not g then return end
                                local grMembers = g:getUnits()
                                local liveMembers = {}
                                for _, agm in ipairs(param.aliveGroupMembers) do
                                    liveMembers[agm] = true
                                end

                                for _, gm in ipairs(grMembers) do
                                    if not liveMembers[gm:getName()] then
                                        gm:destroy()
                                    end
                                end
                            end, v, timer.getTime()+4)
                        end
                    end
                end
            end
        end
    end

    function PersistenceManager:canRestore()
        if self.data == nil then return false end
        
        local redExist = false
        local blueExist = false
        for _,z in pairs(self.data.zones) do
            if z.side == 1 and not redExist then redExist = true end
            if z.side == 2 and not blueExist then blueExist = true end

            if redExist and blueExist then break end
        end

        if not redExist or not blueExist then return false end

        return true
    end

    function PersistenceManager:load()
        self.data = Utils.loadTable(self.path)
    end

    function PersistenceManager:save()
        local tosave = {}
        
        tosave.zones = {}
        for i,v in pairs(ZoneCommand.getAllZones()) do
        
            tosave.zones[i] = {
                name = v.name,
                side = v.side,
                resource = v.resource,
                mode = v.mode,
                distToFront = v.distToFront,
                closestEnemyDist = v.closestEnemyDist,
                extraBuildResources = v.extraBuildResources,
                sabotageDebt = v.sabotageDebt,
                revealTime = v.revealTime,
                built = {}
            }
            
            for n,b in pairs(v.built) do
                if b.type == 'defense' then
                    local typeList = {}
                    local gr = Group.getByName(b.name)
                    if gr then
                        for _,unit in ipairs(gr:getUnits()) do
                            table.insert(typeList, unit:getDesc().typeName)
                        end

                        tosave.zones[i].built[n] = typeList
                    end
                else
                    tosave.zones[i].built[n] = true
                end
                
            end
            
            if v.currentBuild then
                tosave.zones[i].currentBuild = {
                    name = v.currentBuild.product.name, 
                    progress = v.currentBuild.progress,
                    side = v.currentBuild.side,
                    isRepair = v.currentBuild.isRepair
                }
            end

            if v.currentMissionBuild then
                tosave.zones[i].currentMissionBuild = {
                    name = v.currentMissionBuild.product.name, 
                    progress = v.currentMissionBuild.progress,
                    side = v.currentMissionBuild.side
                }
            end
        end

        tosave.missionResources = {}
        for i,v in ipairs(StrategicAI.resources) do
            tosave.missionResources[i] = {}
            for i2,v2 in pairs(v) do
                tosave.missionResources[i][i2] = {prodname = v2.name, ownername = v2.owner.name}
            end
        end

        tosave.activeGroups = {}
        for i,v in pairs(DependencyManager.get("GroupMonitor").groups) do
            tosave.activeGroups[i] = {
                productName = v.product.name,
                ownerName = v.product.owner.name,
                type = v.product.missionType
            }

            local gr = Group.getByName(v.product.name)
            if gr and gr:getSize()>0 then
                local un = gr:getUnit(1)
                if un then 
                    tosave.activeGroups[i].position = un:getPoint()
                    tosave.activeGroups[i].lastMission = v.product.lastMission
                    tosave.activeGroups[i].heading = math.atan2(un:getPosition().x.z, un:getPosition().x.x)
                end
            end

            if v.spawnedSquad then
                tosave.activeGroups[i].spawnedSquad = true
            end

            if v.target then
                tosave.activeGroups[i].targetName = v.target.name
            end

            if v.home then
                tosave.activeGroups[i].homeName = v.home.name
            end

            if v.state then
                tosave.activeGroups[i].state = v.state
                tosave.activeGroups[i].lastStateDuration = timer.getAbsTime() - v.lastStateTime
            else
                tosave.activeGroups[i].state = 'uninitialized'
                tosave.activeGroups[i].lastStateDuration = 0
            end
        end

        tosave.csarTracker = {}

        for i,v in pairs(DependencyManager.get("CSARTracker").activePilots) do
            if v.pilot:isExist() and v.pilot:getSize()>0 and v.remainingTime>60 then
                tosave.csarTracker[i] = {
                    name = v.name,
                    remainingTime = v.remainingTime,
                    pos = v.pilot:getUnit(1):getPoint()
                }
            end
        end

        tosave.squadTracker = {}

        for i,v in pairs(DependencyManager.get("SquadTracker").activeInfantrySquads) do
            tosave.squadTracker[i] = {
                state = v.state,
                remainingStateTime = v.remainingStateTime,
                position = v.position,
                deployPos = v.deployPos,
                targetPos = v.targetPos,
                name = v.name,
                type = v.data.type,
                side = v.data.side,
				isAISpawned = v.data.isAISpawned,
                discovered = v.discovered
            }
        end

        tosave.humanResource = DependencyManager.get("PlayerLogistics").humanResource

        tosave.carriers = {}
        for cname,cdata in pairs(CarrierCommand.getAllCarriers()) do
            local group = Group.getByName(cdata.name)
            if group and group:isExist() then

                tosave.carriers[cname] = {
                    name = cdata.name,
                    resource = cdata.resource,
                    position = group:getUnit(1):getPosition(),
                    navigation = cdata.navigation,
                    supportFlightStates = {},
                    weaponStocks = cdata.weaponStocks,
                    aliveGroupMembers = {}
                }

                for _, gm in ipairs(group:getUnits()) do
                    table.insert(tosave.carriers[cname].aliveGroupMembers, gm:getName())
                end

                for spname, spdata in pairs(cdata.supportFlights) do
                    tosave.carriers[cname].supportFlightStates[spname] = {
                        name = spdata.name, 
                        state = spdata.state,
                        lastStateDuration = timer.getAbsTime() - spdata.lastStateTime,
                        returning = spdata.returning
                    }

                    if spdata.target then
                        tosave.carriers[cname].supportFlightStates[spname].targetName = spdata.target.name
                    end

                    if spdata.state == CarrierCommand.supportStates.inair then
                        local spgr = Group.getByName(spname)
                        if spgr and spgr:isExist() and spgr:getSize()>0 then
                            local spun = spgr:getUnit(1)
                            if spun and spun:isExist() then
                                tosave.carriers[cname].supportFlightStates[spname].position = spun:getPoint()
                                tosave.carriers[cname].supportFlightStates[spname].heading = math.atan2(spun:getPosition().x.z, spun:getPosition().x.x)
                            end
                        end
                    end
                end
            end
        end

        tosave.strikeTargets = {}
        for i,v in pairs(MissionTargetRegistry.strikeTargets) do
            tosave.strikeTargets[i] = { pname = v.data.name, zname = v.zone.name, elapsedTime = timer.getAbsTime() - v.addedTime, isDeep = v.isDeep }
        end

        tosave.reconAreas = {}
        for i,v in ipairs(DependencyManager.get("ReconManager").reconAreas) do
            if v.group then
                table.insert(tosave.reconAreas,{
                    gname = v.group:getName(),
                    padding = v.padding,
                    lifetime = v.lifetime
                })
            else
                table.insert(tosave.reconAreas,{
                    zname = v.zonename,
                    pname = v.productname,
                    padding = v.padding,
                    lifetime = v.lifetime
                })
            end
        end

        tosave.trackedBoxes = {}
        for i,v in pairs(DependencyManager.get("PlayerLogistics").trackedBoxes) do
            if v.lifetime > 0 then
                local box = StaticObject.getByName(i) or Unit.getByName(i)
                if box and box:isExist() and Utils.isLanded(box) then
                    local p = box:getPoint()

                    table.insert(tosave.trackedBoxes, {
                        name = v.name,
                        amount = v.amount, 
                        origin = v.origin.name,
                        side = box:getCoalition(),
                        type = v.type,
                        pos = { x = p.x, y = p.z },
                        lifetime = v.lifetime,
                        content = v.content,
                        convert = v.convert,
                        isSalvage = v.isSalvage
                    })
                end
            end
        end

        tosave.trackedBuildings = {}
        for i,v in pairs(DependencyManager.get("PlayerLogistics").trackedBuildings) do
            if not v.isDeleted then
                local bl = StaticObject.getByName(i)
                if bl and bl:isExist() then
                    local p = bl:getPoint()

                    local wh = nil
                    if v.type == PlayerLogistics.buildables.farp then
                        wh = WarehouseManager.toString(v.name)
                    end

                    local res = nil
                    if v.farp then res = v.farp.resource end

                    table.insert(tosave.trackedBuildings, {
                        name = v.name,
                        side = bl:getCoalition(),
                        type = v.type,
                        pos = { x = p.x, y = p.z },
                        warehouse = wh,
                        resource = res
                    })
                else
                    local g = Group.getByName(i)
                    if g and g:isExist() and g:getSize()>0 then
                        local p = g:getUnit(1):getPoint()

                        table.insert(tosave.trackedBuildings, {
                            name = v.name,
                            side = g:getCoalition(),
                            type = v.type,
                            pos = { x = p.x, y = p.z }
                        })
                    end
                end
            end
        end

        tosave.strategy = {
            red = StrategicAI.redAI:serializeState(),
            blue = StrategicAI.blueAI:serializeState()
        }

        tosave.playerVehicles = {}
        for i,v in pairs(DependencyManager.get("PlayerLogistics").trackedPlayerVehicles) do
            local g = Group.getByName(i)
            if g and g:isExist() and g:getSize() > 0 then
                local u = g:getUnit(1)
                local pl = DependencyManager.get("PlayerLogistics")


                local carry = {}
                if pl.carriedCargo[g:getID()] then carry.carriedCargo = pl.carriedCargo[g:getID()] end
                if pl.carriedInfantry[g:getID()] then 
                    carry.carriedInfantry = {}
                    for i,v in ipairs(pl.carriedInfantry[g:getID()]) do
                        local inf = {
                            type = v.type,
                            weight = v.weight,
                            size = v.size,
                        }

                        if v.loadedAt then inf.loadedAt = v.loadedAt.name end

                        table.insert(carry.carriedInfantry, inf)
                    end
                end
                if pl.carriedPilots[g:getID()] then carry.carriedPilots = pl.carriedPilots[g:getID()] end
                if pl.carriedBoxes[g:getID()] then carry.carriedBoxes = pl.carriedBoxes[g:getID()] end

                tosave.playerVehicles[i] = { 
                    name = v.name, 
                    template = v.template, 
                    side = v.side, 
                    pos = u:getPoint(),
                    carry = carry,
                    mp = v.mp
                }
            end
        end

        Utils.saveTable(self.path, tosave)
    end
end

-----------------[[ END OF PersistenceManager.lua ]]-----------------



-----------------[[ TemplateDB.lua ]]-----------------

TemplateDB = {}

do
    TemplateDB.type = {
        group = 'group',
        static = 'static',
    }

    TemplateDB.templates = {}
    function TemplateDB.getData(objtype)
        return TemplateDB.templates[objtype]
    end

    TemplateDB.templates['player-truck'] = {
        units = { "M 818" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-truck-small'] = {
        units = { "Land_Rover_101_FC" },
        skill = "Good",
        dataCategory = TemplateDB.type.group,
        props = { Variant=3  }
    }

    TemplateDB.templates['player-brad'] = {
        units = { "M-2 Bradley" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-bradaa'] = {
        units = { "M6 Linebacker" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-m113'] = {
        units = { "M-113" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-mlrs'] = {
        units = { "MLRS" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-arty'] = {
        units = { "M-109" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-abrams'] = {
        units = { "M1A2C_SEP_V3" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-m60'] = {
        units = { "M-60" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-mrap'] = {
        units = { "MaxxPro_MRAP" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-hm'] = {
        units = { "M1043 HMMWV Armament" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-hmaa'] = {
        units = { "M1097 Avenger" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-gepard'] = {
        units = { "Gepard" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-mephisto'] = {
        units = { "VAB_Mephisto" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-warrior'] = {
        units = { "MCV-80" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-marder'] = {
        units = { "Marder" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-roland'] = {
        units = { "Roland ADS" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates['player-hmat'] = {
        units = { "M1045 HMMWV TOW" },
        skill = "Good",
        dataCategory = TemplateDB.type.group
    }

    TemplateDB.templates["pilot-replacement"] = {
        units = { "Soldier M4 GRG" },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["capture-squad"] = {
        units = {
            "Soldier M4 GRG",
            "Soldier M4 GRG",
            "Soldier M249",
            "Soldier M4 GRG"
        },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["sabotage-squad"] = {
        units = {
            "Soldier M4 GRG",
            "Soldier M249",
            "Soldier M249",
            "Soldier M4 GRG"
        },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["ambush-squad"] = {
        units = {
            "Soldier RPG",
            "Soldier RPG",
            "Soldier M249",
            "Soldier M4 GRG",
            "Soldier M4 GRG"
        },
        skill = "Good",
        invisible = true,
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["manpads-squad"] = {
        units = {
            "Soldier M4 GRG",
            "Soldier M249",
            "Soldier stinger",
            "Soldier stinger",
            "Soldier M4 GRG"
        },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["ambush-squad-red"] = {
        units = {
            "Paratrooper RPG-16",
            "Paratrooper RPG-16",
            "Infantry AK ver2",
            "Infantry AK",
            "Infantry AK ver3"
        },
        skill = "Good",
        invisible = true,
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["manpads-squad-red"] = {
        units = {
            "Infantry AK ver3",
            "Infantry AK ver2",
            "SA-18 Igla manpad",
            "SA-18 Igla manpad",
            "Infantry AK"
        },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["engineer-squad"] = {
        units = {
            "Soldier M4 GRG",
            "Soldier M4 GRG"
        },
        skill = "Good",
        dataCategory= TemplateDB.type.group
    }
    
    TemplateDB.templates["spy-squad"] = {
        units = {
            "Infantry AK"
        },
        skill = "Good",
        invisible = true,
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["rapier-squad"] = {
        units = {
            "rapier_fsa_blindfire_radar",
            "rapier_fsa_optical_tracker_unit",
            "rapier_fsa_launcher",
            "rapier_fsa_launcher",
            "Soldier M4 GRG",
            "Soldier M4 GRG"
        },
        skill = "Excellent",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["assault-squad"] = {
        units = {
            "Soldier M4 GRG",
            "Soldier M4 GRG",
            "Soldier RPG",
            "Soldier RPG",
            "Soldier M249",
            "Soldier M249"
        },
        skill = "Excellent",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["assault-squad-red"] = {
        units = {
            "Infantry AK ver3",
            "Paratrooper RPG-16",
            "Paratrooper RPG-16",
            "Infantry AK ver2",
            "Infantry AK",
            "Infantry AK ver3"
        },
        skill = "Excellent",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["hawksr"] = {
        units = {
            "Hawk sr"
        },
        skill = "Excellent",
        dataCategory= TemplateDB.type.group
    }    
    
    TemplateDB.templates["hawkpcp"] = {
        units = {
            "Hawk pcp"
        },
        skill = "Excellent",
        dataCategory= TemplateDB.type.group
    }

    TemplateDB.templates["tent"] = { type="FARP Tent", category="Fortifications", shape_name="PalatkaB", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["tent_1"] = { type="Tent01", category="Fortifications", shape_name="M92_Tent01", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["tent_2"] = { type="Tent02", category="Fortifications", shape_name="M92_Tent02", dataCategory=TemplateDB.type.static } -- medical
    TemplateDB.templates["tent_3"] = { type="Tent03", category="Fortifications", shape_name="M92_Tent03", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["tent_4"] = { type="Tent04", category="Fortifications", shape_name="M92_Tent04", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["tent_5"] = { type="Tent05", category="Fortifications", shape_name="M92_Tent05", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["barracks"] = { type="house1arm", category="Fortifications", shape_name=nil, dataCategory=TemplateDB.type.static }

    TemplateDB.templates["outpost"] = { type="outpost", category="Fortifications", shape_name=nil, dataCategory=TemplateDB.type.static }

    TemplateDB.templates["ammo-depot"] = { type=".Ammunition depot", category="Warehouses", shape_name="SkladC", dataCategory=TemplateDB.type.static }
    
    TemplateDB.templates["ammo-cache"] = { type="FARP Ammo Dump Coating", category="Fortifications", shape_name="SetkaKP", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["fuel-cache"] = { type="FARP Fuel Depot", category="Fortifications", shape_name="GSM Rus", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["farp-pad"] = { 
        type="FARP_SINGLE_01", 
        category="Heliports", 
        shape_name="FARP_SINGLE_01",
        heliport_callsign_id = 1,
        heliport_modulation = 0,
        heliport_frequency = 127.5,
        dataCategory=TemplateDB.type.static 
    }

    TemplateDB.templates["fuel-tank-small"] = { type="Fuel tank", category="Fortifications", shape_name="toplivo-bak", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["fuel-tank-big"] = { type="Tank", category="Warehouses", shape_name="bak", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["chem-tank"] = { type="Chemical tank A", category="Fortifications", shape_name="him_bak_a", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["factory-1"] = { type="Tech combine", category="Fortifications", shape_name="kombinat", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["factory-2"] = { type="Workshop A", category="Fortifications", shape_name="tec_a", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["oil-pump"] = { type="Pump station", category="Fortifications", shape_name="nasos", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["hangar"] = { type="Hangar A", category="Fortifications", shape_name="angar_a", dataCategory=TemplateDB.type.static }

    --TemplateDB.templates["excavator"] = { type="345 Excavator", category="Fortifications", shape_name="cat_3451", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["excavator"] = { type="CV_59_NS60", category="ADEquipment", shape_name="CV_59_NS60", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["farm-house-1"] = { type="Farm A", category="Fortifications", shape_name="ferma_a", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["farm-house-2"] = { type="Farm B", category="Fortifications", shape_name="ferma_b", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["antenna"] = { type="Comms tower M", category="Fortifications", shape_name="tele_bash_m", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["tv-tower"] = { type="TV tower", category="Fortifications", shape_name="tele_bash", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["command-center"] = { type=".Command Center", category="Fortifications", shape_name="ComCenter", dataCategory=TemplateDB.type.static }
    
    TemplateDB.templates["military-staff"] = { type="Military staff", category="Fortifications", shape_name="aviashtab", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["building1"] = { type="Building01_PBR", category="Fortifications", shape_name="M92_Building01_PBR", dataCategory=TemplateDB.type.static } -- factory/tech
    TemplateDB.templates["building2"] = { type="Building02_PBR", category="Fortifications", shape_name="M92_Building02_PBR", dataCategory=TemplateDB.type.static } -- factory/tech
    TemplateDB.templates["building3"] = { type="Building03_PBR", category="Fortifications", shape_name="M92_Building03_PBR", dataCategory=TemplateDB.type.static } -- factory/tech
    TemplateDB.templates["building4"] = { type="Building04_PBR", category="Fortifications", shape_name="M92_Building04_PBR", dataCategory=TemplateDB.type.static } -- factory/tech
    TemplateDB.templates["building5"] = { type="Building05_PBR", category="Fortifications", shape_name="M92_Building05_PBR", dataCategory=TemplateDB.type.static } -- farm building?
    TemplateDB.templates["building6"] = { type="Building06_PBR", category="Fortifications", shape_name="M92_Building06_PBR", dataCategory=TemplateDB.type.static } -- farm building?
    TemplateDB.templates["building7"] = { type="Building07_PBR", category="Fortifications", shape_name="M92_Building07_PBR", dataCategory=TemplateDB.type.static } -- compost
    TemplateDB.templates["building8"] = { type="Building08_PBR", category="Fortifications", shape_name="M92_Building08_PBR", dataCategory=TemplateDB.type.static } -- compost

    TemplateDB.templates["tower1"] = { type="Container_watchtower", category="Fortifications", shape_name="M92_Container_watchtower", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["hesco_gen"] = { type="HESCO_generator", category="Fortifications", shape_name="M92_HESCO_generator", dataCategory=TemplateDB.type.static } -- can work as ammo cache

    TemplateDB.templates["hesco1"] = { type="HESCO_post_1", category="Fortifications", shape_name="M92_HESCO_post_1", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["hesco_tower1"] = { type="HESCO_watchtower_1", category="Fortifications", shape_name="M92_HESCO_watchtower_1", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["hesco_tower2"] = { type="HESCO_watchtower_2", category="Fortifications", shape_name="M92_HESCO_watchtower_2", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["hesco_tower3"] = { type="HESCO_watchtower_3", category="Fortifications", shape_name="M92_HESCO_watchtower_3", dataCategory=TemplateDB.type.static }
    
    TemplateDB.templates["forklift"] = { type="CV_59_H60", category="ADEquipment", shape_name=nil, dataCategory=TemplateDB.type.static }

    TemplateDB.templates["ammo-boxes"] = { type="Cargo06", category="Fortifications", shape_name="M92_Cargo06", dataCategory=TemplateDB.type.static }
    TemplateDB.templates["fuel-barrels"] = { type="Cargo05", category="Fortifications", shape_name="M92_Cargo05", dataCategory=TemplateDB.type.static }

    TemplateDB.templates["hq-building"] = { type="af_hq", category="Fortifications", shape_name="syr_af_hq", dataCategory=TemplateDB.type.static }

    -- mass 1000 to 2000
    TemplateDB.templates['ammo_box'] = { type="ammo_cargo", category="Cargos", shape_name="ammo_box_cargo", dataCategory=TemplateDB.type.static}
    
    -- mass 100 to 480
    TemplateDB.templates['barrels'] = { type="barrels_cargo", category="Cargos", shape_name="barrels_cargo", dataCategory=TemplateDB.type.static}
    
    -- mass 100 to 4000
    TemplateDB.templates['container'] = { type="container_cargo", category="Cargos", shape_name="bw_container_cargo", dataCategory=TemplateDB.type.static }
    
    -- mass 100 to 10000
    TemplateDB.templates['cargonet'] = { type="uh1h_cargo", category="Cargos", shape_name="ab-212_cargo", dataCategory=TemplateDB.type.static }
end

-----------------[[ END OF TemplateDB.lua ]]-----------------



-----------------[[ Spawner.lua ]]-----------------

Spawner = {}

do
    function Spawner.createPilot(name, pos)
        local groupData = Spawner.getData("pilot-replacement", name, pos, nil, 5, {
            [land.SurfaceType.LAND] = true, 
            [land.SurfaceType.ROAD] = true,
            [land.SurfaceType.RUNWAY] = true,
        })

        return coalition.addGroup(country.id.CJTF_BLUE, Group.Category.GROUND, groupData)
    end

    function Spawner.createPlayerVehicle(template, name, position, side)
        local groupData = Spawner.getData(template, name, position, nil, 5, {
            [land.SurfaceType.LAND] = true, 
            [land.SurfaceType.ROAD] = true,
            [land.SurfaceType.RUNWAY] = true,
        })

        for i,v in ipairs(groupData.units) do
            v.playerCanDrive = true
            v.coldAtStart = true
        end

        return coalition.addGroup(country.id.CJTF_BLUE, Group.Category.GROUND, groupData)
    end

    function Spawner.createCrate(name, objType, pos, side, minDist, maxDist, weight)
        local data = Spawner.getData(objType, name, pos, minDist, maxDist, {
            [land.SurfaceType.LAND] = true, 
            [land.SurfaceType.ROAD] = true,
            [land.SurfaceType.RUNWAY] = true
        })

        if not data then return end

        data.mass = weight
        data.canCargo = true

        local cnt = country.id.CJTF_BLUE
        if side == 1 then
            cnt = country.id.CJTF_RED
        end

        if data.dataCategory == TemplateDB.type.static then
            return coalition.addStaticObject(cnt, data)
        end
    end

    function Spawner.createObject(name, objType, pos, side, minDist, maxDist, surfaceTypes, zone)
        if zone then
            zone = CustomZone:getByName(zone) -- expand zone name to CustomZone object
        end

        local data = Spawner.getData(objType, name, pos, minDist, maxDist, surfaceTypes, zone)

        if not data then return end

        local cnt = country.id.CJTF_BLUE
        if side == 1 then
            cnt = country.id.CJTF_RED
        end

        if data.dataCategory == TemplateDB.type.static then
            return coalition.addStaticObject(cnt, data)
        elseif data.dataCategory == TemplateDB.type.group then
            return coalition.addGroup(cnt, Group.Category.GROUND, data)
        end
    end

    function Spawner.getUnit(unitType, name, pos, skill, minDist, maxDist, surfaceTypes, zone)
        local nudgedPos = nil
		for i=1,500,1 do
            nudgedPos = mist.getRandPointInCircle(pos, maxDist, minDist)
           
            if zone then
                if zone:isInside(nudgedPos) and surfaceTypes[land.getSurfaceType(nudgedPos)] then
                    break
                end
            else
                if surfaceTypes[land.getSurfaceType(nudgedPos)] then
                    break
                end
            end

            if i==500 then env.info('Spawner - ERROR: failed to find good location') end
		end

        return {
            ["type"] = unitType,
            ["skill"] = skill,
            ["coldAtStart"] = false,
            ["x"] = nudgedPos.x,
            ["y"] = nudgedPos.y,
            ["name"] = name,
            ['heading'] = math.random()*math.pi*2,
            ["playerCanDrive"] = false
        }
    end

    function Spawner.getData(objtype, name, pos, minDist, maxDist, surfaceTypes, zone)
        if not maxDist then maxDist = 150 end
        if not surfaceTypes then surfaceTypes = { [land.SurfaceType.LAND]=true } end

        local data = TemplateDB.getData(objtype)
        if not data then 
            env.info("Spawner - ERROR: cant find group data "..tostring(objtype).." for group name "..name)
            return
        end

        local spawnData = {}

        if data.dataCategory == TemplateDB.type.static then
            if not surfaceTypes[land.getSurfaceType(pos)] then
                for i=1,500,1 do
                    pos = mist.getRandPointInCircle(pos, maxDist)

                    if zone then
                        if zone:isInside(pos) and surfaceTypes[land.getSurfaceType(pos)] then
                            break
                        end
                    else
                        if surfaceTypes[land.getSurfaceType(pos)] then
                            break
                        end
                    end
                    
                    if i==500 then env.info('Spawner - ERROR: failed to find good location') end
                end
            end

            spawnData = {
                ["type"] = data.type,
                ["name"] = name,
                ["shape_name"] = data.shape_name,
                ["category"] = data.category,
                ["x"] = pos.x,
                ["y"] = pos.y,
                ['heading'] = math.random()*math.pi*2
            }
        elseif data.dataCategory== TemplateDB.type.group then
            spawnData = {
                ["units"] = {},
                ["name"] = name,
                ["hiddenOnMFD"] = true,
                ["task"] = "Ground Nothing",
                ["route"] = {
                    ["points"]={
                        {
                            ["x"] = pos.x,
                            ["y"] = pos.y,
                            ["action"] = "Off Road",
                            ["speed"] = 0,
                            ["type"] = "Turning Point",
                            ["ETA"] = 0,
                            ["formation_template"] = "",
                            ["task"] = Spawner.getDefaultTask(data.invisible, data.isSam)
                        }
                    }
                }
            }

            if data.minDist then
                minDist = data.minDist
            end

            if data.maxDist then
                maxDist = data.maxDist
            end
            
            for i,v in ipairs(data.units) do
                local newUn = Spawner.getUnit(v, name.."-"..i, pos, data.skill, minDist, maxDist, surfaceTypes, zone)
                if data.props then
                    newUn.AddPropVehicle = data.props
                end

                table.insert(spawnData.units, newUn)
            end
        end

        spawnData.dataCategory = data.dataCategory
            
        return spawnData
    end

    function Spawner.getDefaultTask(invisible, isSam)
        local defTask =  {
            ["id"] = "ComboTask",
            ["params"] = 
            {
                ["tasks"] = 
                {
                    [1] = 
                    {
                        ["enabled"] = true,
                        ["auto"] = false,
                        ["id"] = "WrappedAction",
                        ["number"] = 1,
                        ["params"] = 
                        {
                            ["action"] = 
                            {
                                ["id"] = "Option",
                                ["params"] = 
                                {
                                    ["name"] = 9,
                                    ["value"] = 2,
                                },
                            },
                        },
                    }, 
                    [2] = 
                    {
                        ["enabled"] = true,
                        ["auto"] = false,
                        ["id"] = "WrappedAction",
                        ["number"] = 2,
                        ["params"] = 
                        {
                            ["action"] = 
                            {
                                ["id"] = "Option",
                                ["params"] = 
                                {
                                    ["name"] = 0,
                                    ["value"] = 0,
                                }
                            }
                        }
                    }
                }
            }
        }

        local index = 3

        if isSam then
            table.insert(defTask.params.tasks, {
                ["enabled"] = true,
                ["auto"] = false,
                ["id"] = "WrappedAction",
                ["number"] = index,
                ["params"] = 
                {
                    ["action"] = 
                    {
                        ["id"] = "Option",
                        ["params"] = 
                        {
                            ["name"] = 31,
                            ["value"] = true,
                        }
                    }
                }
            })
            index = index + 1
        end

        if invisible then 
            table.insert(defTask.params.tasks, {
                ["number"] = index,
                ["auto"] = false,
                ["id"] = "WrappedAction",
                ["enabled"] = true,
                ["params"] = 
                {
                    ["action"] = 
                    {
                        ["id"] = "SetInvisible",
                        ["params"] = 
                        {
                            ["value"] = true,
                        }
                    }
                }
            })
        end
        
        return defTask
    end
end

-----------------[[ END OF Spawner.lua ]]-----------------



-----------------[[ CommandFunctions.lua ]]-----------------

CommandFunctions = {}

do
    CommandFunctions.jtac = nil

    function CommandFunctions.spawnJtac(zone)
        if CommandFunctions.jtac then
            CommandFunctions.jtac:deployAtZone(zone)
            CommandFunctions.jtac:showMenu()
            CommandFunctions.jtac:setLifeTime(60)
            zone:reveal(60)
            DependencyManager.get("ReconManager"):revealEnemyInZone(zone, nil, 1, 0.5)
        end
    end

    function CommandFunctions.smokeTargets(zone, count)
        local units = {}
        for i,v in pairs(zone.built) do
            local g = Group.getByName(v.name)
            if g and g:isExist() then
                for i2,v2 in ipairs(g:getUnits()) do
                    if v2:isExist() then
                        table.insert(units, v2)
                    end
                end
            else
                local s = StaticObject.getByName(v.name)
                if s and s:isExist() then
                    table.insert(units, s)
                end
            end
        end
        
        local tgts = {}
        for i=1,count,1 do
            if #units > 0 then
                local selected = math.random(1,#units)
                table.insert(tgts, units[selected])
                table.remove(units, selected)
            end
        end
        
        for i,v in ipairs(tgts) do
            local pos = v:getPoint()
            trigger.action.smoke(pos, 1)
        end
    end

    function CommandFunctions.sabotageZone(zone)
        trigger.action.outText("Saboteurs have been dispatched to "..zone.name, 10)
        local delay = math.random(5*60, 7*60)
        local isReveled = zone.revealTime > 0
        timer.scheduleFunction(function(param, time)
            if not param.isRevealed then
                if math.random() < 0.3 then
                    trigger.action.outText("Saboteurs have been caught by the enemy before they could complete their mission", 10)
                    return
                end
            end

            local zone = param.zone
            local units = {}
            for i,v in pairs(zone.built) do
                if v.type == 'upgrade' then
                    local s = StaticObject.getByName(v.name)
                    if s and s:isExist() then
                        table.insert(units, s)
                    end
                end
            end
            
            if #units > 0 then
                local selected = units[math.random(1,#units)]

                timer.scheduleFunction(function(p2, t2)
                    if p2.count > 0 then
                        p2.count = p2.count - 1
                        local offsetPos = {
                            x = p2.pos.x + math.random(-25,25),
                            y = p2.pos.y,
                            z = p2.pos.z + math.random(-25,25)
                        }
            
                        offsetPos.y = land.getHeight({x = offsetPos.x, y = offsetPos.z})
                        trigger.action.explosion(offsetPos, 30)
                        return t2 + 0.05 + (math.random())
                    else
                        trigger.action.explosion(p2.pos, 2000)
                    end
                end, {count = 3, pos = selected:getPoint()}, timer.getTime()+0.5)

                trigger.action.outText("Saboteurs have succesfully triggered explosions at "..zone.name, 10)
            end
        end, { zone = zone , isRevealed = isReveled}, timer.getTime()+delay)
    end

    function CommandFunctions.shellZone(zone, count)
        local minutes = math.random(3,7)
        local seconds = math.random(-30,30)
        local delay = (minutes*60)+seconds

        local isRevealed = zone.revealTime > 0
        trigger.action.outText("Artillery preparing to fire on "..zone.name.." ETA: "..minutes.." minutes", 10)
        
        local positions = {}
        for i,v in pairs(zone.built) do
            local g = Group.getByName(v.name)
            if g and g:isExist() then
                for i2,v2 in ipairs(g:getUnits()) do
                    if v2:isExist() then
                        table.insert(positions, v2:getPoint())
                    end
                end
            else
                local s = StaticObject.getByName(v.name)
                if s and s:isExist() then
                    table.insert(positions, s:getPoint())
                end
            end
        end

        timer.scheduleFunction(function(param, time)
            trigger.action.outText("Artillery firing on "..param.zone.name.." ETA: 30 seconds", 10)
        end, {zone = zone}, timer.getTime()+delay-30)

        timer.scheduleFunction(function(param, time)
            param.count = param.count - 1
            
            local accuracy = 50
            if param.isRevealed then
                accuracy = 10
            end

            local selected = param.positions[math.random(1,#param.positions)]
            local offsetPos = {
                x = selected.x + math.random(-accuracy,accuracy),
                y = selected.y,
                z = selected.z + math.random(-accuracy,accuracy)
            }

            offsetPos.y = land.getHeight({x = offsetPos.x, y = offsetPos.z})

            trigger.action.explosion(offsetPos, 20)

            if param.count > 0 then
                return time+0.05+(math.random()*2)
            else
                trigger.action.outText("Artillery finished firing on "..param.zone.name, 10)
            end
        end, { positions = positions, count = count, zone = zone, isRevealed = isRevealed}, timer.getTime()+delay)
    end
end

-----------------[[ END OF CommandFunctions.lua ]]-----------------



-----------------[[ JTAC.lua ]]-----------------

JTAC = {}
do
	JTAC.categories = {}
	JTAC.categories['SAM'] = {'SAM SR', 'SAM TR', 'IR Guided SAM','SAM LL','SAM CC'}
	JTAC.categories['Infantry'] = {'Infantry'}
	JTAC.categories['Armor'] = {'Tanks','IFV','APC'}
	JTAC.categories['Support'] = {'Unarmed vehicles','Artillery'}
	JTAC.categories['Structures'] = {'StaticObjects'}
	
	--{name = 'groupname'}
	function JTAC:new(obj)
		obj = obj or {}
		obj.lasers = {tgt=nil, ir=nil}
		obj.target = nil
		obj.timerReference = nil
        obj.remainingLife = nil
		obj.tgtzone = nil
		obj.priority = nil
		obj.jtacMenu = nil
		obj.laserCode = 1688
		obj.side = Group.getByName(obj.name):getCoalition()
		setmetatable(obj, self)
		self.__index = self
		obj:initCodeListener()
		return obj
	end
	
	function JTAC:initCodeListener()
		local ev = {}
		ev.context = self
		function ev:onEvent(event)
			if event.id == 26 then
				if event.text:find('^jtac%-code:') then
					local s = event.text:gsub('^jtac%-code:', '')
					local code = tonumber(s)
					self.context:setCode(code)
                    trigger.action.removeMark(event.idx)
				end
			end
		end
		
		world.addEventHandler(ev)
	end

    function JTAC:setCode(code)
        if code>=1111 and code <= 1788 then
            self.laserCode = code
            trigger.action.outTextForCoalition(self.side, 'JTAC code set to '..code, 10)
        else
            trigger.action.outTextForCoalition(self.side, 'Invalid laser code. Must be between 1111 and 1788 ', 10)
        end
    end
	
	function JTAC:showMenu()
		local gr = Group.getByName(self.name)
		if not gr then
			return
		end
		
		if not self.jtacMenu then
			self.jtacMenu = missionCommands.addSubMenuForCoalition(self.side, 'JTAC')
			
			missionCommands.addCommandForCoalition(self.side, 'Target report', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					dr:printTarget(true)
				else
					missionCommands.removeItemForCoalition(dr.side, dr.jtacMenu)
					dr.jtacMenu = nil
				end
			end, self)
			
			missionCommands.addCommandForCoalition(self.side, 'Next Target', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					dr:searchTarget()
				else
					missionCommands.removeItemForCoalition(dr.side, dr.jtacMenu)
					dr.jtacMenu = nil
				end
			end, self)
			
			missionCommands.addCommandForCoalition(self.side, 'Deploy Smoke', self.jtacMenu, function(dr)
				if Group.getByName(dr.name) then
					local tgtunit = Unit.getByName(dr.target)
                    if not tgtunit then
                        tgtunit = StaticObject.getByName(dr.target)
                    end

					if tgtunit then
						trigger.action.smoke(tgtunit:getPoint(), 3)
						trigger.action.outTextForCoalition(dr.side, 'JTAC target marked with ORANGE smoke', 10)
					end
				else
					missionCommands.removeItemForCoalition(dr.side, dr.jtacMenu)
					dr.jtacMenu = nil
				end
			end, self)
			
			local priomenu = missionCommands.addSubMenuForCoalition(self.side, 'Set Priority', self.jtacMenu)
			for i,v in pairs(JTAC.categories) do
				missionCommands.addCommandForCoalition(self.side, i, priomenu, function(dr, cat)
					if Group.getByName(dr.name) then
						dr:setPriority(cat)
						dr:searchTarget()
					else
						missionCommands.removeItemForCoalition(dr.side, dr.jtacMenu)
						dr.jtacMenu = nil
					end
				end, self, i)
			end

            local dial = missionCommands.addSubMenuForCoalition(self.side, 'Set Laser Code', self.jtacMenu)
            for i2=1,7,1 do
                local digit2 = missionCommands.addSubMenuForCoalition(self.side, '1'..i2..'__', dial)
                for i3=1,9,1 do
                    local digit3 = missionCommands.addSubMenuForCoalition(self.side, '1'..i2..i3..'_', digit2)
                    for i4=1,9,1 do
                        local digit4 = missionCommands.addSubMenuForCoalition(self.side, '1'..i2..i3..i4, digit3)
                        local code = tonumber('1'..i2..i3..i4)
                        missionCommands.addCommandForCoalition(self.side, 'Accept', digit4, Utils.log(self.setCode), self, code)
                    end
                end
            end
			
			missionCommands.addCommandForCoalition(self.side, "Clear", priomenu, function(dr)
				if Group.getByName(dr.name) then
					dr:clearPriority()
					dr:searchTarget()
				else
					missionCommands.removeItemForCoalition(dr.side, dr.jtacMenu)
					dr.jtacMenu = nil
				end
			end, self)
		end
	end
	
	function JTAC:setPriority(prio)
		self.priority = JTAC.categories[prio]
		self.prioname = prio
	end
	
	function JTAC:clearPriority()
		self.priority = nil
	end
	
	function JTAC:setTarget(unit)
		
		if self.lasers.tgt then
			self.lasers.tgt:destroy()
			self.lasers.tgt = nil
		end
		
		if self.lasers.ir then
			self.lasers.ir:destroy()
			self.lasers.ir = nil
		end
		
		local me = Group.getByName(self.name)
		if not me then return end
		
		local pnt = unit:getPoint()
		self.lasers.tgt = Spot.createLaser(me:getUnit(1), { x = 0, y = 2.0, z = 0 }, pnt, self.laserCode)
		self.lasers.ir = Spot.createInfraRed(me:getUnit(1), { x = 0, y = 2.0, z = 0 }, pnt)
		
		self.target = unit:getName()
	end

    function JTAC:setLifeTime(minutes)
        self.remainingLife = minutes
        
        timer.scheduleFunction(function(param, time)
            if param.remainingLife == nil then return end

            local gr = Group.getByName(self.name)
		    if not gr then
                param.remainingLife = nil
                return 
            end

            param.remainingLife = param.remainingLife - 1
            if param.remainingLife < 0 then
                param:clearTarget()
                return
            end

            return time+60
        end, self, timer.getTime()+60)
    end
	
	function JTAC:printTarget(makeitlast)
		local toprint = ''
		if self.target and self.tgtzone then
			local tgtunit = Unit.getByName(self.target)
            local isStructure = false
            if not tgtunit then 
                tgtunit = StaticObject.getByName(self.target)
                isStructure = true
            end

			if tgtunit and tgtunit:isExist() then
				local pnt = tgtunit:getPoint()
                local tgttype = "Unidentified"
                if isStructure then
                    tgttype = "Structure"
                else
                    tgttype = tgtunit:getTypeName()
                end
				
				if self.priority then
					toprint = 'Priority targets: '..self.prioname..'\n'
				end
				
				toprint = toprint..'Lasing '..tgttype..' at '..self.tgtzone.name..'\nCode: '..self.laserCode..'\n'
				local lat,lon,alt = coord.LOtoLL(pnt)
				local mgrs = coord.LLtoMGRS(coord.LOtoLL(pnt))
				toprint = toprint..'\nDDM:  '.. mist.tostringLL(lat,lon,3)
				toprint = toprint..'\nDMS:  '.. mist.tostringLL(lat,lon,2,true)
				toprint = toprint..'\nMGRS: '.. mist.tostringMGRS(mgrs, 5)
				toprint = toprint..'\n\nAlt: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
			else
				makeitlast = false
				toprint = 'No Target'
			end
		else
			makeitlast = false
			toprint = 'No target'
		end
		
		local gr = Group.getByName(self.name)
		if makeitlast then
			trigger.action.outTextForCoalition(gr:getCoalition(), toprint, 60)
		else
			trigger.action.outTextForCoalition(gr:getCoalition(), toprint, 10)
		end
	end
	
	function JTAC:clearTarget()
		self.target = nil
	
		if self.lasers.tgt then
			self.lasers.tgt:destroy()
			self.lasers.tgt = nil
		end
		
		if self.lasers.ir then
			self.lasers.ir:destroy()
			self.lasers.ir = nil
		end
		
		if self.timerReference then
			timer.removeFunction(self.timerReference)
			self.timerReference = nil
		end
		
		local gr = Group.getByName(self.name)
		if gr then
			gr:destroy()
			missionCommands.removeItemForCoalition(self.side, self.jtacMenu)
			self.jtacMenu = nil
		end
	end
	
	function JTAC:searchTarget()
		local gr = Group.getByName(self.name)
		if gr and gr:isExist() then
			if self.tgtzone and self.tgtzone.side~=0 and self.tgtzone.side~=gr:getCoalition() then
				local viabletgts = {}
				for i,v in pairs(self.tgtzone.built) do
					local tgtgr = Group.getByName(v.name)
					if tgtgr and tgtgr:isExist() and tgtgr:getSize()>0 then
						for i2,v2 in ipairs(tgtgr:getUnits()) do
							if v2:isExist() and v2:getLife()>=1 then
								table.insert(viabletgts, v2)
							end
						end
                    else
                        tgtgr = StaticObject.getByName(v.name)
                        if tgtgr and tgtgr:isExist() then
                            table.insert(viabletgts, tgtgr)
                        end
                    end
				end
				
				if self.priority then
					local priorityTargets = {}
					for i,v in ipairs(viabletgts) do
						for i2,v2 in ipairs(self.priority) do
                            if v2 == "StaticObjects" and ZoneCommand.staticRegistry[v:getName()] then
                                table.insert(priorityTargets, v)
                                break
                            elseif v:hasAttribute(v2) and v:getLife()>=1 then
								table.insert(priorityTargets, v)
								break
							end
						end
					end
					
					if #priorityTargets>0 then
						viabletgts = priorityTargets
					else
						self:clearPriority()
						trigger.action.outTextForCoalition(gr:getCoalition(), 'JTAC: No priority targets found', 10)
					end
				end
				
				if #viabletgts>0 then
					local chosentgt = math.random(1, #viabletgts)
					self:setTarget(viabletgts[chosentgt])
					self:printTarget()
				else
					self:clearTarget()
				end
			else
				self:clearTarget()
			end
		end
	end
	
	function JTAC:searchIfNoTarget()
		if Group.getByName(self.name) then
			if not self.target then
				self:searchTarget()
			else
				local un = Unit.getByName(self.target)
				if un and un:isExist() then
					if un:getLife()>=1 then
						self:setTarget(un)
					else
						self:searchTarget()
					end
				else
                    local st = StaticObject.getByName(self.target)
                    if st and st:isExist() then
                        self:setTarget(st)
					else
						self:searchTarget()
					end
                end
			end
		else
			self:clearTarget()
		end
	end
	
	function JTAC:deployAtZone(zoneCom)
        self.remainingLife = nil
		self.tgtzone = zoneCom
		local p = CustomZone:getByName(self.tgtzone.name).point
		local vars = {}
		vars.gpName = self.name
		vars.action = 'respawn' 
		vars.point = {x=p.x, y=5000, z = p.z}
		mist.teleportToPoint(vars)
		
		timer.scheduleFunction(function(param,time)
			param.context:setOrbit(param.target, param.point)
		end, {context = self, target = self.tgtzone.zone, point = p}, timer.getTime()+1)
		
		if not self.timerReference then
			self.timerReference = timer.scheduleFunction(function(param, time)
				param:searchIfNoTarget()
				return time+5
			end, self, timer.getTime()+5)
		end
	end
	
	function JTAC:setOrbit(zonename, point)
		local gr = Group.getByName(self.name)
		if not gr then 
			return
		end
		
		local cnt = gr:getController()
		cnt:setCommand({ 
			id = 'SetInvisible', 
			params = { 
				value = true 
			} 
		})
  
		cnt:setTask({ 
			id = 'Orbit', 
			params = { 
				pattern = 'Circle',
				point = {x = point.x, y=point.z},
				altitude = 5000
			} 
		})
		
		self:searchTarget()
	end
end

-----------------[[ END OF JTAC.lua ]]-----------------



-----------------[[ CarrierMap.lua ]]-----------------

CarrierMap = {}
do
	CarrierMap.currentIndex = 15000
    function CarrierMap:new(zoneList)

        local obj = {}
        obj.zones = {}

        for i,v in ipairs(zoneList) do
            local zn = CustomZone:getByName(v)

            local id = CarrierMap.currentIndex
            CarrierMap.currentIndex = CarrierMap.currentIndex + 1
            
            zn:draw(id, {1,1,1,0.2}, {1,1,1,0.2})
            obj.zones[v] = {zone = zn, waypoints = {}}

            for subi=1,1000,1 do
                local subname = v..'-'..subi
                if CustomZone:getByName(subname) then
                    table.insert(obj.zones[v].waypoints, subname)
                else
                    break
                end
            end

            id = CarrierMap.currentIndex
            CarrierMap.currentIndex = CarrierMap.currentIndex + 1

            trigger.action.textToAll(-1, id , zn.point, {0,0,0,0.8}, {1,1,1,0}, 15, true, v)
            for i,wps in ipairs(obj.zones[v].waypoints) do
                id = CarrierMap.currentIndex
                CarrierMap.currentIndex = CarrierMap.currentIndex + 1
                local point = CustomZone:getByName(wps).point
                trigger.action.textToAll(-1, id, point, {0,0,0,0.8}, {1,1,1,0}, 10, true, wps)
            end
        end

        setmetatable(obj, self)
		self.__index = self

        return obj
    end

    function CarrierMap:getNavMap()
        local map = {}
        for nm, zn in pairs(self.zones) do
            table.insert(map, {name = zn.zone.name, waypoints = zn.waypoints})
        end

        table.sort(map, function(a,b) return a.name < b.name end)
        return map
    end
end

-----------------[[ END OF CarrierMap.lua ]]-----------------



-----------------[[ CarrierCommand.lua ]]-----------------

CarrierCommand = {}
do
    CarrierCommand.allCarriers = {}
	CarrierCommand.currentIndex = 6000
    CarrierCommand.isCarrier = true

	CarrierCommand.supportTypes = {
		strike = 'Strike',
		cap = 'CAP',
		awacs = 'AWACS',
		tanker = 'Tanker',
		transport = 'Transport',
		mslstrike = 'Cruise Missiles',
		sead = 'SEAD',
		recon = 'Recon'
	}

	CarrierCommand.supportStates = {
		takeoff = 'takeoff',
		inair = 'inair',
		landed = 'landed',
		none = 'none'
	}

	CarrierCommand.blockedDespawnTime = 15*60
	CarrierCommand.recoveryReduction = 0.8
	CarrierCommand.landedDespawnTime = 2*60
    
    function CarrierCommand:new(name, range, navmap, radioConfig, maxResource)
        local unit = Unit.getByName(name)
        if not unit then return end

        local obj = {}
        obj.name = name
        obj.range = range
        obj.side = unit:getCoalition()
        obj.resource = maxResource or 30000
        obj.maxResource = maxResource or 30000
		obj.spendTreshold = 500
        obj.revealTime = 0
        obj.isHeloSpawn = true
        obj.isPlaneSpawn = true
		obj.supportFlights = {}
		obj.extraSupports = {}
		obj.weaponStocks = {}
		obj.distToFront = 10
		
		obj.navigation = {
			currentWaypoint = nil,
			waypoints = {},
			loop = true
		}

		obj.navmap = navmap
        
        obj.tacan = radioConfig.tacan
        obj.icls = radioConfig.icls
        obj.acls = radioConfig.acls
        obj.link4 = radioConfig.link4
        obj.radio = radioConfig.radio

        obj.index = CarrierCommand.currentIndex
		CarrierCommand.currentIndex = CarrierCommand.currentIndex + 1

        local point = unit:getPoint()

		obj.zone = { point = point }

        local color = {0.7,0.7,0.7,0.3}
		if obj.side == 1 then
			color = {1,0,0,0.3}
		elseif obj.side == 2 then
			color = {0,0,1,0.3}
		end

        trigger.action.circleToAll(-1,3000+obj.index,point, obj.range, color, color, 1)
        
        point.z = point.z + obj.range
        trigger.action.textToAll(-1,2000+obj.index, point, {0,0,0,0.8}, {1,1,1,0.5}, 15, true, '')
		
        setmetatable(obj, self)
		self.__index = self

        obj:start()
        obj:refreshText()
		CarrierCommand.allCarriers[obj.name] = obj
        return obj
    end

	function CarrierCommand:setupRadios()
		local unit = Unit.getByName(self.name)
		TaskExtensions.setupCarrier(unit, self.icls, self.acls, self.tacan, self.link4, self.radio)
	end

    function CarrierCommand:start()
		self:setupRadios()

        timer.scheduleFunction(function(param, time)
            local self = param.context
            local unit = Unit.getByName(self.name)
            if not unit then
				self:clearDrawings()
				local gr = Group.getByName(self.name)
				if gr and gr:isExist() then
					TaskExtensions.stopCarrier(gr)
				end
				return
			end
			
			self:updateNavigation()
			self:updateSupports()
            self:refreshText()
			return time+10
        end, {context = self}, timer.getTime()+1)
    end

	function CarrierCommand:clearDrawings()
		if not self.cleared then
			trigger.action.removeMark(2000+self.index)
			trigger.action.removeMark(3000+self.index)
			self.cleared = true
		end
	end

	function CarrierCommand:updateSupports()
		for _, data in pairs(self.supportFlights) do
			self:processAir(data)
		end

		
		for wep, stock in pairs(self.weaponStocks) do
			local gr = Unit.getByName(self.name):getGroup()
			local realstock = Utils.getAmmo(gr, wep)
			self.weaponStocks[wep] = math.min(stock, realstock)	
		end
	end

	local function setState(group, state)
		group.state = state
		group.lastStateTime = timer.getAbsTime()
	end

	local function isAttack(group)
		if group.type == CarrierCommand.supportTypes.cap then return true end
		if group.type == CarrierCommand.supportTypes.strike then return true end
		if group.type == CarrierCommand.supportTypes.sead then return true end
	end

	local function hasWeapons(group)
		for _,un in ipairs(group:getUnits()) do
			local wps = un:getAmmo()
			if wps then
				for _,w in ipairs(wps) do
					if w.desc.category ~= 0 and w.count > 0 then
						return true
					end
				end
			end
		end
	end

	function CarrierCommand:processAir(group)
		local carrier = Unit.getByName(self.name)
		if not carrier or not carrier:isExist() then return end

		local gr = Group.getByName(group.name)
		if not gr or not gr:isExist() then
			if group.state ~= CarrierCommand.supportStates.none then
				setState(group, CarrierCommand.supportStates.none)
				group.returning = false
				env.info('CarrierCommand: processAir ['..group.name..'] does not exist state=none')
			end
			return
		end
		
		if gr:getSize() == 0 then
			gr:destroy()
			setState(group, CarrierCommand.supportStates.none)
			group.returning = false
			env.info('CarrierCommand: processAir ['..group.name..'] has no members state=none')
			return
		end

		if group.state == CarrierCommand.supportStates.none then
			setState(group, CarrierCommand.supportStates.takeoff)
			env.info('CarrierCommand: processAir ['..group.name..'] started existing state=takeoff')
		elseif group.state == CarrierCommand.supportStates.takeoff then
			if timer.getAbsTime() - group.lastStateTime > CarrierCommand.blockedDespawnTime then
				if gr and gr:getSize()>0 and gr:getUnit(1) and gr:getUnit(1):isExist() then
					local frUnit = gr:getUnit(1)
					local cz = CarrierCommand.getCarrierOfUnit(frUnit:getName())
					if Utils.allGroupIsLanded(gr, cz ~= nil) then
						env.info('CarrierCommand: processAir ['..group.name..'] is blocked, despawning')
						local frUnit = gr:getUnit(1)
						if frUnit then
							local firstUnit = frUnit:getName()
							local z = ZoneCommand.getZoneOfUnit(firstUnit)
							if not z then 
								z = CarrierCommand.getCarrierOfUnit(firstUnit)
							end
							if z then
								z:addResource(group.cost)
								env.info('CarrierCommand: processAir ['..z.name..'] has recovered ['..group.cost..'] from ['..group.name..']')
							end
						end

						gr:destroy()
						setState(group, CarrierCommand.supportStates.none)
						group.returning = false
						env.info('CarrierCommand: processAir ['..group.name..'] has been removed due to being blocked state=none')
						return
					end
				end
			elseif gr and Utils.someOfGroupInAir(gr) then
				env.info('CarrierCommand: processAir ['..group.name..'] is in the air state=inair')
				setState(group, CarrierCommand.supportStates.inair)
			end
		elseif group.state == CarrierCommand.supportStates.inair then
			if gr and gr:getSize()>0 and gr:getUnit(1) and gr:getUnit(1):isExist() then
				local frUnit = gr:getUnit(1)
				local cz = CarrierCommand.getCarrierOfUnit(frUnit:getName())
				if Utils.allGroupIsLanded(gr, cz ~= nil) then
					env.info('CarrierCommand: processAir ['..group.name..'] has landed state=landed')
					setState(group, CarrierCommand.supportStates.landed)

					local unit = gr:getUnit(1)
					if unit then
						local firstUnit = unit:getName()
						local z = ZoneCommand.getZoneOfUnit(firstUnit)
						if not z then 
							z = CarrierCommand.getCarrierOfUnit(firstUnit)
						end
						
						if group.type == CarrierCommand.supportTypes.transport then
							local tzone = z
							if not tzone then
								tzone = FARPCommand.getFARPOfUnit(firstUnit)
							end

							if tzone then
								tzone:capture(gr:getCoalition())
								tzone:addResource(group.cost)
								env.info('CarrierCommand: processAir ['..group.name..'] has supplied ['..tzone.name..'] with ['..group.cost..']')
							end
						else
							if z and z.side == gr:getCoalition() then
								local percentSurvived = gr:getSize()/gr:getInitialSize()
								local torecover = math.floor(group.cost * percentSurvived * CarrierCommand.recoveryReduction)
								z:addResource(torecover)
								env.info('CarrierCommand: processAir ['..z.name..'] has recovered ['..torecover..'] from ['..group.name..']')
							end
						end
					else
						env.info('CarrierCommand: processAir ['..group.name..'] size ['..gr:getSize()..'] has no unit 1')
					end
				else
					if isAttack(group) and not group.returning then
						if not hasWeapons(gr) then
							env.info('CarrierCommand: processAir ['..group.name..'] size ['..gr:getSize()..'] has no weapons outside of shells')
							group.returning = true

							local point = carrier:getPoint()
							TaskExtensions.landAtAirfield(gr, {x=point.x, y=point.z})
							local cnt = gr:getController()
							cnt:setOption(0,4) -- force ai hold fire
							cnt:setOption(1, 4) -- force reaction on threat to allow abort
						end
					elseif group.type == CarrierCommand.supportTypes.transport then
						if not group.returning and group.target and group.target.side ~= self.side and group.target.side ~= 0 then
							group.returning = true
							local point = carrier:getPoint()
							TaskExtensions.landAtPointFromAir(gr,  {x=point.x, y=point.z}, group.altitude)
							env.info('CarrierCommand: processAir ['..group.name..'] returning home due to invalid target')
						end
					elseif group.type == CarrierCommand.supportTypes.recon then
						local pos = frUnit:getPoint()
						local closestZn, dist = ZoneCommand.getClosestZoneToPoint(pos, Utils.getEnemy(self.side))
						if closestZn and closestZn.revealTime == 0 and dist<=12000 then
							closestZn:reveal()
							DependencyManager.get("ReconManager"):revealEnemyInZone(closestZn, nil, Utils.getEnemy(self.side), 0.3)
							env.info('CarrierCommand: processAir ['..group.name..'] revealed ['..closestZn.name..']')
						end

						if not group.returning and group.target.revealTime > 0 then
							group.returning = true
							local point = carrier:getPoint()
							TaskExtensions.landAtPointFromAir(gr,  {x=point.x, y=point.z}, group.altitude)
							env.info('CarrierCommand: processAir ['..group.name..'] returning home due to completed objective')
						end
					end
				end
			end
		elseif group.state == CarrierCommand.supportStates.landed then
			if timer.getAbsTime() - group.lastStateTime > CarrierCommand.landedDespawnTime then
				if gr then
					gr:destroy()
					setState(group, CarrierCommand.supportStates.none)
					group.returning = false
					env.info('CarrierCommand: processAir ['..group.name..'] despawned after landing state=none')
					return true
				end
			end
		end
	end

	function CarrierCommand:setWaypoints(wplist)
		self.navigation.waypoints = wplist
		self.navigation.currentWaypoint = nil
		self.navigation.nextWaypoint = 1
		self.navigation.loop = #wplist > 1
	end

	function CarrierCommand:updateNavigation()
		local unit = Unit.getByName(self.name)

		if self.navigation.nextWaypoint then
			local dist = 0
			if self.navigation.currentWaypoint then
				local tgzn = self.navigation.waypoints[self.navigation.currentWaypoint]
				local point = CustomZone:getByName(tgzn).point
				dist = mist.utils.get2DDist(unit:getPoint(), point)
			end

			if dist<2000 then
				self.navigation.currentWaypoint = self.navigation.nextWaypoint

				local tgzn = self.navigation.waypoints[self.navigation.currentWaypoint]
				local point = CustomZone:getByName(tgzn).point
				env.info("CarrierCommand - sending "..self.name.." to "..tgzn.." x"..point.x.." z"..point.z)
				TaskExtensions.carrierGoToPos(unit:getGroup(), point)

				if self.navigation.loop then
					self.navigation.nextWaypoint = self.navigation.nextWaypoint + 1
					if self.navigation.nextWaypoint > #self.navigation.waypoints then
						self.navigation.nextWaypoint = 1
					end
				else
					self.navigation.nextWaypoint = nil
				end
			end
		else
			local dist = 9999999
			if self.navigation.currentWaypoint then
				local tgzn = self.navigation.waypoints[self.navigation.currentWaypoint]
				local point = CustomZone:getByName(tgzn).point
				dist = mist.utils.get2DDist(unit:getPoint(), point)
			end

			if dist<2000 then
				env.info("CarrierCommand - "..self.name.." stopping after reached waypoint")
				TaskExtensions.stopCarrier(unit:getGroup())
				self.navigation.currentWaypoint = nil
			end
		end
	end

	function CarrierCommand:addSupportFlight(name, cost, type, data)
		self.supportFlights[name] = { 
			name = name, 
			cost = cost, 
			type = type, 
			target = nil,
			state = CarrierCommand.supportStates.none, 
			lastStateTime = timer.getAbsTime(),
			carrier = self
		}

		for i,v in pairs(data) do
			self.supportFlights[name][i] = v
		end

		local gr = Group.getByName(name)
		if gr then gr:destroy() end
	end

	function CarrierCommand:addExtraSupport(name, cost, type, data)
		self.extraSupports[name] = { 
			name = name, 
			cost = cost, 
			type = type, 
			target = nil,
			carrier = self
		}

		for i,v in pairs(data) do
			self.extraSupports[name][i] = v
		end
	end

	function CarrierCommand:setWPStock(wpname, amount)
		self.weaponStocks[wpname] = amount
	end

	function CarrierCommand:callExtraSupport(data, groupname)
		local playerGroup = Group.getByName(groupname)
		if not playerGroup then return end

		if self.resource < data.cost then
			trigger.action.outTextForGroup(playerGroup:getID(), self.name..' does not have enough resources for '..data.name, 10)
			return
		end

		local cru = Unit.getByName(self.name)
		if not cru or not cru:isExist() then return end

		local crg = cru:getGroup()

		local ammo = self.weaponStocks[data.wpType] or 0
		if ammo < data.salvo then
			trigger.action.outTextForGroup(playerGroup:getID(), data.name..' is not available at this time.', 10)
			return
		end

		local success = MenuRegistry.showTargetZoneMenu(playerGroup:getID(), "Select "..data.name..'('..data.type..") target", function(params)
			local cru = Unit.getByName(params.data.carrier.name)
			if not cru or not cru:isExist() then return end
			local crg = cru:getGroup()

			TaskExtensions.fireAtTargets(crg, params.zone.built, params.data.salvo)
			if params.data.carrier.weaponStocks[params.data.wpType] then
				params.data.carrier.weaponStocks[params.data.wpType] = params.data.carrier.weaponStocks[params.data.wpType] - params.data.salvo
			end
		end, 1, nil, data, nil, true)

		if success then
			self:removeResource(data.cost)
			trigger.action.outTextForGroup(playerGroup:getID(), 'Select target for '..data.name..' ('..data.type..') from radio menu.', 10)
		else
			trigger.action.outTextForGroup(playerGroup:getID(), 'No valid targets for '..data.name..' ('..data.type..')', 10)
		end
	end

	function CarrierCommand:callSupport(data, groupname)
		local playerGroup = Group.getByName(groupname)
		if not playerGroup then return end

		if Group.getByName(data.name) and (timer.getAbsTime() - data.lastStateTime < 60*60) then 
			trigger.action.outTextForGroup(playerGroup:getID(), data.name..' tasking is not available at this time.', 10)
			return
		end

		if self.resource < data.cost then
			trigger.action.outTextForGroup(playerGroup:getID(), self.name..' does not have enough resources to deploy '..data.name, 10)
			return
		end
		
		local targetCoalition = nil
		local minDistToFront = nil
		local includeCarriers = nil
		local includeFarps = nil
		local onlyRevealed = nil

		if data.type == CarrierCommand.supportTypes.strike then
			targetCoalition = 1
			onlyRevealed = true
		elseif data.type == CarrierCommand.supportTypes.cap then
			minDistToFront = 1
			includeCarriers = true
		elseif data.type == CarrierCommand.supportTypes.awacs then
			targetCoalition = 2
			includeCarriers = true
		elseif data.type == CarrierCommand.supportTypes.tanker then
			targetCoalition = 2
			includeCarriers = true
		elseif data.type == CarrierCommand.supportTypes.transport then
			targetCoalition = {0,2}
			includeFarps = true
			includeCarriers = true
		elseif data.type == CarrierCommand.supportTypes.sead then
			targetCoalition = 1
			minDistToFront = 2
		elseif data.type == CarrierCommand.supportTypes.recon then
			targetCoalition = 1
		end
		
		local success = MenuRegistry.showTargetZoneMenu(playerGroup:getID(), "Select "..data.name..'('..data.type..") target", function(params)
			CarrierCommand.spawnSupport(params.data, params.zone)
			trigger.action.outTextForGroup(params.groupid, params.data.name..'('..params.data.type..') heading to '..params.zone.name, 10)
		end, targetCoalition, minDistToFront, data, includeCarriers, onlyRevealed, includeFarps)

		if success then
			self:removeResource(data.cost)
			trigger.action.outTextForGroup(playerGroup:getID(), 'Select target for '..data.name..' ('..data.type..') from radio menu.', 10)
		else
			trigger.action.outTextForGroup(playerGroup:getID(), 'No valid targets for '..data.name..' ('..data.type..')', 10)
		end
	end

	local function getDefaultPos(savedData)
		local action = 'Turning Point'
		local speed = 250

		local vars = {
			groupName = savedData.name,
			point = savedData.position,
			action = 'respawn',
			heading = savedData.heading,
			initTasks = false,
			route = { 
				[1] = {
					alt = savedData.position.y,
					type = 'Turning Point',
					action = action,
					alt_type = 'BARO',
					x = savedData.position.x,
					y = savedData.position.z,
					speed = speed
				}
			}
		}

		return vars
	end

	function CarrierCommand.spawnSupport(data, target, saveData)
		data.target = target

		if saveData then
			mist.teleportToPoint(getDefaultPos(saveData))
			data.state = saveData.state
			data.lastStateTime = timer.getAbsTime() - saveData.lastStateDuration
			data.returning = saveData.returning

			if data.returning then
				timer.scheduleFunction(function(param)
					local gr = Group.getByName(param.data.name)
					local homePos = nil
					local carrier = Unit.getByName(param.data.carrier.name)
					if carrier then
						homePos = carrier:getPoint()
					end

					TaskExtensions.landAtPointFromAir(gr, {x=homePos.x, y=homePos.z}, param.data.altitude)
				end, {data = data}, timer.getTime()+1)
				return
			end
		else
			mist.respawnGroup(data.name, true)
		end

		if data.type == CarrierCommand.supportTypes.strike then
			CarrierCommand.dispatchStrike(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.cap then
			CarrierCommand.dispatchCap(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.awacs then
			CarrierCommand.dispatchAwacs(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.tanker then
			CarrierCommand.dispatchTanker(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.transport then
			CarrierCommand.dispatchTransport(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.sead then
			CarrierCommand.dispatchSead(data, saveData)
		elseif data.type == CarrierCommand.supportTypes.recon then
			CarrierCommand.dispatchRecon(data, saveData)
		end
	end

	function CarrierCommand.dispatchStrike(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)
			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated then
				homePos = { homePos = carrier:getPoint() }
			end
			env.info('CarrierCommand - sending '..param.data.name..' to '..param.data.target.name)
			
			local targets = {}
			for i,v in pairs(param.data.target.built) do
				if v.type == 'upgrade' and v.side ~= gr:getCoalition() then
					local tg = TaskExtensions.getTargetPos(v.name)
					table.insert(targets, tg)
				end
			end

			if #targets == 0 then 
				gr:destroy()
				return 
			end

			local choice = targets[math.random(1, #targets)]
			TaskExtensions.executePinpointStrikeMission(gr, choice, AI.Task.WeaponExpend.ALL, param.data.altitude, homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchSead(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)

			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated  then
				homePos = { homePos = carrier:getPoint() }
			end

            TaskExtensions.executeSeadMission(gr, param.data.target.built, AI.Task.WeaponExpend.ALL, param.data.altitude, param.homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchRecon(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)
			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated then
				homePos = { homePos = carrier:getPoint() }
			end
			env.info('CarrierCommand - sending '..param.data.name..' to '..param.data.target.name)

			local point = nil
			if param.data.target.isCarrier then
				point = Unit.getByName(param.data.target.name):getPoint()
			else
				point = trigger.misc.getZone(param.data.target.name).point
			end

			TaskExtensions.overFlyPointAndReturn(gr, point, param.data.altitude, homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchCap(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)

			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated  then
				homePos = { homePos = carrier:getPoint() }
			end

			local point = nil
			if param.data.target.isCarrier then
				point = Unit.getByName(param.data.target.name):getPoint()
			else
				point = trigger.misc.getZone(param.data.target.name).point
			end

			TaskExtensions.executePatrolMission(gr, point, param.data.altitude, param.data.range, homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchAwacs(data, saveData)		
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)

			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated  then
				homePos = { homePos = carrier:getPoint() }
			end
			
			local un = gr:getUnit(1)
			if un then 
				local callsign = un:getCallsign()
				RadioFrequencyTracker.registerRadio(param.data.name, '[AWACS] '..callsign, param.data.freq..' AM')
			end

			local point = nil
			if param.data.target.isCarrier then
				point = Unit.getByName(param.data.target.name):getPoint()
			else
				point = trigger.misc.getZone(param.data.target.name).point
			end

			TaskExtensions.executeAwacsMission(gr, point, param.data.altitude, param.data.freq, homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchTanker(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)

			local homePos = nil
			local carrier = Unit.getByName(param.data.carrier.name)
			if carrier and isReactivated  then
				homePos = { homePos = carrier:getPoint() }
			end

			local un = gr:getUnit(1)
			if un then 
				local callsign = un:getCallsign()
				RadioFrequencyTracker.registerRadio(param.data.name, '[Tanker(Drogue)] '..callsign, param.data.freq..' AM | TCN '..param.data.tacan..'X')
			end
			
			local point = nil
			if param.data.target.isCarrier then
				point = Unit.getByName(param.data.target.name):getPoint()
			else
				point = trigger.misc.getZone(param.data.target.name).point
			end

			TaskExtensions.executeTankerMission(gr, point, param.data.altitude, param.data.freq, param.data.tacan, homePos, carrier:getID())
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand.dispatchTransport(data, saveData)
		local isReactivated = saveData ~= nil
		timer.scheduleFunction(function(param)
			local gr = Group.getByName(param.data.name)

			local supplyPoint = trigger.misc.getZone(param.data.target.name..'-hsp')
			if not supplyPoint then
				supplyPoint = trigger.misc.getZone(param.data.target.name)
			end

			if not supplyPoint then
				supplyPoint = param.data.target.zone
			end
			
			if param.data.target.isCarrier then
				local tgt = Unit.getByName(param.data.target.name)
				trigger.action.outText('sending ',5)
				TaskExtensions.landAtShip(gr, tgt, param.data.altitude, true)
			else
				local point = { x=supplyPoint.point.x, y = supplyPoint.point.z}
				TaskExtensions.landAtPoint(gr, point, param.data.altitude, true)
			end
		end, {data = data}, timer.getTime()+1)
	end

	function CarrierCommand:showInformation(groupname)
		local gr = Group.getByName(groupname)
        if gr then 
			local msg = '['..self.name..'] ('..self.resource..')'
			if self.radio then msg = msg..'\n Radio: '..string.format('%.3f',self.radio/1000000)..' AM' end
			if self.tacan then msg = msg..'\n TACAN: '..self.tacan.channel..'X ('..self.tacan.callsign..')' end
			if self.link4 then msg = msg..'\n Link4: '..string.format('%.3f',self.link4/1000000) end
			if self.icls then msg = msg..'\n ICLS: '..self.icls end

			if Utils.getTableSize(self.supportFlights) > 0 then
				local flights = {}
				for _, data in pairs(self.supportFlights) do
					if (data.state == CarrierCommand.supportStates.none or (timer.getAbsTime()-data.lastStateTime >= 60*60)) and data.cost <= self.resource then
						table.insert(flights, data)
					end
				end
				
				table.sort(flights, function(a,b) return a.name<b.name end)
				
				if #flights > 0 then
					msg = msg..'\n\n Available for tasking:'
					for _,data in ipairs(flights) do
						msg = msg..'\n    '..data.name..' ('..data.type..') ['..data.cost..']'
					end
				end
			end

			if Utils.getTableSize(self.extraSupports) > 0 then
				local extras = {}
				for _, data in pairs(self.extraSupports) do
					if data.cost <= self.resource then
						if data.type == CarrierCommand.supportTypes.mslstrike then
							local cru = Unit.getByName(self.name)
							if cru and cru:isExist() then
								local crg = cru:getGroup()
								local remaining = self.weaponStocks[data.wpType] or 0
								if remaining > data.salvo then
									table.insert(extras, data)
								end
							end
						end
					end
				end
				
				table.sort(extras, function(a,b) return a.name<b.name end)
				
				if #extras > 0 then
					msg = msg..'\n\n Other:'
					for _,data in ipairs(extras) do
						if data.type == CarrierCommand.supportTypes.mslstrike then
							local cru = Unit.getByName(self.name)
							if cru and cru:isExist() then
								local crg = cru:getGroup()
								local remaining = self.weaponStocks[data.wpType] or 0
								if remaining > data.salvo then
									remaining = math.floor(remaining/data.salvo)
									msg = msg..'\n    '..data.name..' ('..data.type..') ['..data.cost..'] ('..remaining..' left)'
								end
							end
						end
					end
				end
			end

            trigger.action.outTextForGroup(gr:getID(), msg, 20)
		end
	end

    function CarrierCommand:addResource(amount)
		self.resource = self.resource+amount
		self.resource = math.floor(math.min(self.resource, self.maxResource))
        self:refreshText()
    end

    function CarrierCommand:removeResource(amount)
		self.resource = self.resource-amount
		self.resource = math.floor(math.max(self.resource, 0))
        self:refreshText()
    end

    function CarrierCommand:refreshText()		
        local build = ''
		local mBuild = ''
		
		local status=''
		if self:criticalOnSupplies() then
			status = '(!)'
		end

		local color = {0.3,0.3,0.3,1}
		if self.side == 1 then
			color = {0.7,0,0,1}
		elseif self.side == 2 then
			color = {0,0,0.7,1}
		end

		trigger.action.setMarkupColor(2000+self.index, color)

		local label = '['..self.resource..'/'..self.maxResource..']'..status..build..mBuild

		if self.side == 1 then
			if self.revealTime > 0 then
				trigger.action.setMarkupText(2000+self.index, self.name..label)
			else
				trigger.action.setMarkupText(2000+self.index, self.name)
			end
		elseif self.side == 2 then
			trigger.action.setMarkupText(2000+self.index, self.name..label)
		elseif self.side == 0 then
			trigger.action.setMarkupText(2000+self.index, ' '..self.name..' ')
		end

        if self.side == 2 and (self.isHeloSpawn or self.isPlaneSpawn) then
			trigger.action.setMarkupTypeLine(3000+self.index, 2)
			trigger.action.setMarkupColor(3000+self.index, {0,1,0,1})
		end

        local unit = Unit.getByName(self.name)
        local point = unit:getPoint()
        trigger.action.setMarkupPositionStart(3000+self.index, point)

		self.zone.point = point

        point.z = point.z + self.range
        trigger.action.setMarkupPositionStart(2000+self.index, point)
		
    end

    function CarrierCommand:capture(side)
    end

	function CarrierCommand:pushMisOfType(mistype)
	end

    function CarrierCommand:criticalOnSupplies()
		return self.resource<=self.spendTreshold
    end

    function CarrierCommand.getCarrierByName(name)
		if not name then return nil end
		return CarrierCommand.allCarriers[name]
	end
	
	function CarrierCommand.getAllCarriers()
		return CarrierCommand.allCarriers
	end
	
	function CarrierCommand.getCarrierOfUnit(unitname)
		local un = Unit.getByName(unitname)
		
		if not un then 
			return nil
		end
		
		for i,v in pairs(CarrierCommand.allCarriers) do
            local carrier = Unit.getByName(v.name)
            if carrier then
                if Utils.isInCircle(un:getPoint(), carrier:getPoint(), v.range) then
                    return v
                end
            end
		end
		
		return nil
	end

	function CarrierCommand.getClosestCarrierToPoint(point)
		local minDist = 9999999
		local closest = nil
		for i,v in pairs(CarrierCommand.allCarriers) do
            local carrier = Unit.getByName(v.name)
            if carrier then
                local d = mist.utils.get2DDist(carrier:getPoint(), point)
                if d < minDist then
                    minDist = d
                    closest = v
                end
            end
		end
		
		return closest, minDist
	end
	
	function CarrierCommand.getCarrierOfPoint(point)
		for i,v in pairs(CarrierCommand.allCarriers) do
			local carrier = Unit.getByName(v.name)
            if carrier then
                if Utils.isInCircle(point, carrier:getPoint(), v.range) then
                    return v
                end
            end
		end
		
		return nil
	end

	CarrierCommand.groupMenus = {}
	MenuRegistry.register(6, function(event, context)
		if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
			local player = event.initiator:getPlayerName()
			if player then
				local groupid = event.initiator:getGroup():getID()
				local groupname = event.initiator:getGroup():getName()
				
				if CarrierCommand.groupMenus[groupid] then
					missionCommands.removeItemForGroup(groupid, CarrierCommand.groupMenus[groupid])
					CarrierCommand.groupMenus[groupid] = nil
				end

				if not CarrierCommand.groupMenus[groupid] then
					
					local menu = missionCommands.addSubMenuForGroup(groupid, 'Naval Command')

					local sorted = {}
					for cname, carrier in pairs(CarrierCommand.getAllCarriers()) do
						local cr = Unit.getByName(carrier.name)
						if cr then
							table.insert(sorted, carrier)
						end
					end

					table.sort(sorted, function(a,b) return a.name < b.name end)

					for _,carrier in ipairs(sorted) do
						local crunit =  Unit.getByName(carrier.name)
						if crunit and crunit:isExist() then
							local subm = missionCommands.addSubMenuForGroup(groupid, carrier.name, menu)
							missionCommands.addCommandForGroup(groupid, 'Information', subm, Utils.log(carrier.showInformation), carrier, groupname)

							local rank =  DependencyManager.get("PlayerTracker"):getPlayerRank(player)

							if rank and rank.allowCarrierSupport and Utils.getTableSize(carrier.supportFlights) > 0 then
								local supm = missionCommands.addSubMenuForGroup(groupid, "Support", subm)
								local flights = {}
								for _, data in pairs(carrier.supportFlights) do
									table.insert(flights, data)
								end

								table.sort(flights, function(a,b) return a.name<b.name end)

								for _, data in ipairs(flights) do
									local name = data.name..' ('..data.type..') ['..data.cost..']'
									missionCommands.addCommandForGroup(groupid, name, supm, Utils.log(carrier.callSupport), carrier, data, groupname)
								end

								local extras = {}
								for _, data in pairs(carrier.extraSupports) do
									table.insert(extras, data)
								end

								table.sort(extras, function(a,b) return a.name<b.name end)
								for _, data in ipairs(extras) do
									local name = data.name..' ('..data.type..') ['..data.cost..']'
									missionCommands.addCommandForGroup(groupid, name, supm, Utils.log(carrier.callExtraSupport), carrier, data, groupname)
								end
							end

							if rank and rank.allowCarrierCommand then
								local navm = missionCommands.addSubMenuForGroup(groupid, "Navigation", subm)
								for _,wp in ipairs(carrier.navmap) do
									local wpm = missionCommands.addSubMenuForGroup(groupid, wp.name, navm)
									if #wp.waypoints > 1 then
										missionCommands.addCommandForGroup(groupid, 'Patrol Area', wpm, Utils.log(carrier.setWaypoints), carrier, wp.waypoints, groupname)
									end
									
									missionCommands.addCommandForGroup(groupid, 'Go to '..wp.name, wpm, Utils.log(carrier.setWaypoints), carrier, {wp.name}, groupname)
									for _,subwp in ipairs(wp.waypoints) do
										missionCommands.addCommandForGroup(groupid, 'Go to '..subwp, wpm, Utils.log(carrier.setWaypoints), carrier, {subwp}, groupname)
									end
								end
							end
						end
					end

					CarrierCommand.groupMenus[groupid] = menu
				end
			end
		end
	end, nil)
end

-----------------[[ END OF CarrierCommand.lua ]]-----------------



-----------------[[ FARPCommand.lua ]]-----------------

FARPCommand = {}
do
    FARPCommand.allFARPS = {}
	FARPCommand.currentIndex = 100000
    FARPCommand.isFARP = true

    function FARPCommand:new(name, range, maxResource)
        local st = StaticObject.getByName(name)
        if not st then return end

        local ab = Airbase.getByName(name)
        if ab then
            if ab:autoCaptureIsOn() then ab:autoCapture(false) end
            ab:setCoalition(2)
        end

        local obj = {}
        obj.name = name
        obj.range = range
        obj.side = 2
        obj.resource = 0
        obj.maxResource = maxResource or 20000
		obj.spendTreshold = 0
        obj.isHeloSpawn = false
        obj.isPlaneSpawn = false
        obj.distToFront = 1
        obj.zone = {
            point = st:getPoint()
        }
        obj.revealTime = 0

        obj.featureBuildings = {}
		
        obj.index = FARPCommand.currentIndex
		FARPCommand.currentIndex = FARPCommand.currentIndex + 1

        local point = st:getPoint()

        local color = {0.7,0.7,0.7,0.3}
		if obj.side == 1 then
			color = {1,0,0,0.3}
		elseif obj.side == 2 then
			color = {0,0,1,0.3}
		end

        trigger.action.circleToAll(-1,3000+obj.index,point, obj.range, color, color, 1)
        
        point.z = point.z + obj.range
        trigger.action.textToAll(-1,2000+obj.index, point, {0,0,0,0.8}, {1,1,1,0.5}, 15, true, '')
		
        setmetatable(obj, self)
		self.__index = self

        obj:start()
        obj:refreshText()
		FARPCommand.allFARPS[obj.name] = obj
        return obj
    end

    function FARPCommand:scheduleRemoval()
        self.isDeleted = true
		trigger.action.setMarkupColor(3000+self.index, {0.3,0.3,0.3,0.3})
		trigger.action.setMarkupColorFill(3000+self.index, {0.3,0.3,0.3,0.3})

        local pl = DependencyManager.get('PlayerLogistics')
        local trackedBuildings = pl.trackedBuildings
        for i,v in pairs(self:getAllFeatureBuildings()) do
            if trackedBuildings[v.name] then
                trackedBuildings[v.name].isDeleted = true
                local st = StaticObject.getByName(v.name) or Group.getByName(v.name)
                if st and st:isExist() then 
                    local pos = nil
                    if st.getPoint then 
                        pos = st:getPoint()
                    elseif st.getSize and st:getSize()>0 and st.getUnit then
                        local stu = st:getUnit(1)
                        pos = stu:getPoint()
                    end

                    if pos then
                        local amount = math.random(250,750)

                        local cname = pl:generateCargoName("Salvage")
                        local ctype = pl:getBoxType(amount)

                        local spos = {
                            x = pos.x + math.random(-15,15),
                            y = pos.z + math.random(-15,15)
                        }

                        Spawner.createCrate(cname, ctype, spos, 2, 1, 15, amount)

                        local origin = {
                            name='locally sourced', 
                            isCarrier=false,
                            zone={ point=pos },
                            distToFront = 0
                        }

                        pl.trackedBoxes[cname] = {name=cname, amount = amount, type=ctype, origin = origin, lifetime=60*60*2, isSalvage=true}

                        st:destroy() 
                    end
                end
            end
        end

        if trackedBuildings[self.name] then
            trackedBuildings[self.name].isDeleted = true
        end

        self:refreshText()
    end

    function FARPCommand:start()
        timer.scheduleFunction(function(param, time)
            local self = param.context
            self:refreshFeatures()
            if self:hasFeature(PlayerLogistics.buildables.generator) then
                self:addResource(5)
            end

            self:refreshText()
            if not self.isDeleted then
                return time+10
            end
        end, {context = self}, timer.getTime()+1)
    end

	function FARPCommand:clearDrawings()
		if not self.cleared then
			trigger.action.removeMark(2000+self.index)
			trigger.action.removeMark(3000+self.index)
			self.cleared = true
		end
	end

    function FARPCommand:addResource(amount)
		self.resource = self.resource+amount
		self.resource = math.floor(math.min(self.resource, self.maxResource))
        self:refreshText()
    end

    function FARPCommand:removeResource(amount)
		self.resource = self.resource-amount
		self.resource = math.floor(math.max(self.resource, 0))
        self:refreshText()
    end

    function FARPCommand:refreshText()
        if self.isDeleted then
            trigger.action.setMarkupText(2000+self.index, '')
            return
        end

		local color = {0.3,0.3,0.3,1}
		if self.side == 1 then
			color = {0.5,0,0,1}
		elseif self.side == 2 then
			color = {0,0,0.5,1}
		end

		trigger.action.setMarkupColor(2000+self.index, color)

		local label = '['..self.resource..'/'..self.maxResource..']'
        
        local features = {}
        for i,v in pairs(self.featureBuildings) do
            local symbol = FARPCommand.getFeatureSymbol(i)
            table.insert(features, symbol)
        end
        if #features > 0 then
            table.sort(features)
            label = label..'\n'
            for _,v in ipairs(features) do
                label = label..v
            end
        end
        
		if self.side == 1 then
			if self.revealTime > 0 then
				trigger.action.setMarkupText(2000+self.index, self.name..label)
			else
				trigger.action.setMarkupText(2000+self.index, self.name)
			end
		elseif self.side == 2 then
			trigger.action.setMarkupText(2000+self.index, self.name..label)
		elseif self.side == 0 then
			trigger.action.setMarkupText(2000+self.index, ' '..self.name..' ')
		end

        if self.side == 2 and (self.isHeloSpawn or self.isPlaneSpawn) then
			trigger.action.setMarkupTypeLine(3000+self.index, 2)
			trigger.action.setMarkupColor(3000+self.index, {0,1,0,1})
		end

        local st = StaticObject.getByName(self.name)
        local point = st:getPoint()
        trigger.action.setMarkupPositionStart(3000+self.index, point)

        point.z = point.z + self.range
        trigger.action.setMarkupPositionStart(2000+self.index, point)
    end

    function FARPCommand:capture(side)
    end

    function FARPCommand:pushMisOfType(mistype)
	end

    function FARPCommand:criticalOnSupplies()
		return self.resource<=self.spendTreshold
    end

    function FARPCommand.getFeatureSymbol(featureType)
        if featureType == PlayerLogistics.buildables.ammo then
            return ' Ammo'
        elseif featureType == PlayerLogistics.buildables.fuel then
            return ' Fuel'
        elseif featureType == PlayerLogistics.buildables.forklift then
            return ' Lft'
        elseif featureType == PlayerLogistics.buildables.generator then
            return ' Gen'
        elseif featureType == PlayerLogistics.buildables.medtent then
            return ' Med'
        elseif featureType == PlayerLogistics.buildables.radar then
            return ' Rad'
        elseif featureType == PlayerLogistics.buildables.satuplink then
            return ' Sat'
        elseif featureType == PlayerLogistics.buildables.tent then
            return ' Com'
        end

        return ''
    end

    function FARPCommand:getAllFeatureBuildings()
        local st = StaticObject.getByName(self.name)
        if not st then return end

        local trackedBuildings = DependencyManager.get('PlayerLogistics').trackedBuildings

        local pos = st:getPoint()

        local results = {}
        for i,v in pairs(trackedBuildings) do
            if v.type ~= PlayerLogistics.buildables.farp then
                local pos = nil
                local bl = StaticObject.getByName(i)
                if bl and bl:isExist() then
                    pos = bl:getPoint()
                end

                if not pos then 
                    bl = Group.getByName(i)
                    if bl and bl:isExist() and bl:getSize()>0 then
                        pos = bl:getUnit(1):getPoint()
                    end
                end

                if pos then
                    local bfarp = FARPCommand.getFARPOfPoint(pos)
                    if bfarp.name == self.name then
                        table.insert(results, v)
                    end
                end
            end
        end

        return results
    end

    function FARPCommand:refreshFeatures()
        local st = StaticObject.getByName(self.name)
        if not st then return end

        local trackedBuildings = DependencyManager.get('PlayerLogistics').trackedBuildings

        local pos = st:getPoint()

        for i,v in pairs(trackedBuildings) do
            if v.type ~= PlayerLogistics.buildables.farp then
                local pos = nil
                local bl = StaticObject.getByName(i)
                if bl and bl:isExist() then
                    pos = bl:getPoint()
                end

                if not pos then 
                    bl = Group.getByName(i)
                    if bl and bl:isExist() and bl:getSize()>0 then
                        pos = bl:getUnit(1):getPoint()
                    end
                end

                if pos then
                    local bfarp = FARPCommand.getFARPOfPoint(pos)
                    if bfarp and bfarp.name == self.name then
                        self.featureBuildings[v.type]=v.name
                    end
                end
            end
        end
    end

    function FARPCommand:hasFeature(feature)
        local fb = self.featureBuildings[feature]
        if fb then
            local s = StaticObject.getByName(fb)
            if s then return true end
            local g = Group.getByName(fb)
            if g then return true end
        end
    end

    function FARPCommand.getFARPByName(name)
		if not name then return nil end
		return FARPCommand.allFARPS[name]
	end
	
	function FARPCommand.getAllFARPs()
		return FARPCommand.allFARPS
	end
	
	function FARPCommand.getFARPOfUnit(unitname)
		local un = Unit.getByName(unitname)
		
		if not un then 
			return nil
		end
		
		for i,v in pairs(FARPCommand.allFARPS) do
            local farp = StaticObject.getByName(v.name)
            if farp then
                if Utils.isInCircle(un:getPoint(), farp:getPoint(), v.range) then
                    return v
                end
            end
		end
		
		return nil
	end

	function FARPCommand.getClosestFARPToPoint(point)
		local minDist = 9999999
		local closest = nil
		for i,v in pairs(FARPCommand.allFARPS) do
            local farp = StaticObject.getByName(v.name)
            if farp then
                local d = mist.utils.get2DDist(farp:getPoint(), point)
                if d < minDist then
                    minDist = d
                    closest = v
                end
            end
		end
		
		return closest, minDist
	end
	
	function FARPCommand.getFARPOfPoint(point)
		for i,v in pairs(FARPCommand.allFARPS) do
			local farp = StaticObject.getByName(v.name)
            if farp and farp:getPoint() then
                if Utils.isInCircle(point, farp:getPoint(), v.range) then
                    return v
                end
            end
		end
		
		return nil
	end

    function FARPCommand.getFARPOfWeapon(weapon)		
        if not weapon then 
            return nil
        end
        
        return FARPCommand.getFARPOfPoint(weapon:getPoint())
    end
end

-----------------[[ END OF FARPCommand.lua ]]-----------------



-----------------[[ TransmissionManager.lua ]]-----------------

TransmissionManager = {}

do
    TransmissionManager.baseStation = {x = -355923, z=618060, y = 10000 }

    TransmissionManager.radios = {
        command = { 
            queue={}, freqs = 
            {
                { frequency = 262.5E6, modulation = 0, power=500 },
                { frequency = 122.5E6, modulation = 0, power=500 },
                { frequency = 032E6, modulation = 1, power=500 }, 
            }
        },
        infantry = { 
            queue={}, 
            freqs = {
                { frequency = 263.5E6, modulation = 0, power=10 },
                { frequency = 123.5E6, modulation = 0, power=10 },
                { frequency = 033E6, modulation = 1, power=10 }, 
            }
        },
        gci = { 
            queue={},
            freqs = {
                { frequency = 264.5E6, modulation = 0, power=500 },
                { frequency = 124.5E6, modulation = 0, power=500 },
                { frequency = 034E6, modulation = 1, power=500 }, 
            }
        },
        guard = {
            queue={},
            freqs = {
                { frequency = 243.0E6, modulation = 0, power=500 },
                { frequency = 121.5E6, modulation = 0, power=500 },
            }
        }
    }

    function TransmissionManager.queueTransmission(key, radio, pos, group)
        if not Config.useRadio then return end

        local instant = #radio.queue == 0
        if instant then table.insert(radio.queue, {key='generic.noise', pos=pos, group=group}) end

        table.insert(radio.queue, {key=key, pos=pos, group=group})

        if instant then
            TransmissionManager.playNext(radio)
        end
    end

    function TransmissionManager.queueMultiple(keys, radio, pos, group)
        for _,key in ipairs(keys) do
            TransmissionManager.queueTransmission(key, radio, pos, group)
        end
    end

    function TransmissionManager.resolveKey(key)
        local trsnd = TransmissionManager.sounds[key]
        if not trsnd then return { url = '', length=0.5 } end

        local url = trsnd.url
        local length = trsnd.length

        return { url='Sounds/'..url, length=length }
    end

    function TransmissionManager.playNext(radio)
        if #radio.queue > 0 then
            local trm = radio.queue[1]

            local sound = TransmissionManager.resolveKey(trm.key)

            local pos = TransmissionManager.baseStation
            if trm.pos then
                pos = trm.pos
            elseif trm.group then
                local gr = Group.getByName(trm.group)
                if gr and gr:isExist() and gr:getSize()>0 then 
                    pos = gr:getUnit(1):getPoint()
                end
            end

            pos.y = pos.y + 10

            for _,fr in ipairs(radio.freqs) do
                env.info("TransmissionManager - "..sound.url..' '..tostring(fr.frequency)..' '..tostring(fr.modulation))
                trigger.action.radioTransmission(sound.url, pos, fr.modulation, false, fr.frequency, fr.power)
            end

            timer.scheduleFunction(function(param,time)
                table.remove(param.queue, 1)
                TransmissionManager.playNext(param)
            end, radio, timer.getTime()+sound.length+0.05)
        end
    end

    function TransmissionManager.pilotCallout(radio, pos)
        local variant = math.random(1,5)
        local callout = math.random(1,5)

        local key = 'pilots.extracting.'..variant..'.call.'..callout

        TransmissionManager.queueTransmission(key, radio, pos)

        if math.random() < 0.05 then
            TransmissionManager.queueTransmission('pilots.extracting.'..variant..'.call.quip.1', radio, pos)
        end
    end

    function TransmissionManager.gciCallout(radio, callsign, targetType, size, heading, miles, angels, sourcePos)
        local calls = ''
        if callsign then
            calls = {
                'gci.callsigns.'..callsign.name,
                'gci.numbers.'..callsign.num1,
                'gci.numbers.'..callsign.num2,
            }
        else
            calls = {
                'generic.noise'
            }
        end

        if targetType == "HELO" then
            table.insert(calls, 'gci.callout.helo')
        elseif targetType == "FXWG" then
            table.insert(calls, 'gci.callout.fixedwing')
        end

        if size > 1 then
            table.insert(calls, 'gci.callout.groupof')
            table.insert(calls, 'gci.numbers.'..size)
        end

        table.insert(calls, 'gci.callout.bra')

        local hstr = tostring(heading)
        for i=1,#hstr do
            local n = hstr:sub(i,i)
            table.insert(calls, 'gci.numbers.'..n)
        end

        table.insert(calls, 'gci.callout.for')

        local mstr = tostring(miles)
        for i=1,#mstr do
            local n = mstr:sub(i,i)
            table.insert(calls, 'gci.numbers.'..n)
        end
        
        table.insert(calls, 'gci.callout.miles')
        table.insert(calls, 'gci.callout.atangels')

        local astr = tostring(angels)
        for i=1,#astr do
            local n = astr:sub(i,i)
            table.insert(calls, 'gci.numbers.'..n)
        end

        TransmissionManager.queueMultiple(calls, radio, sourcePos)
    end

    TransmissionManager.sounds = {
        ['generic.noise'] = { url='generic.noise.ogg',  length=0.70 },

        -- nato phonetic
        ['zones.names.Alpha'] =     { url='zones.names.nato/zones.names.Alpha.ogg',      length=0.54},
        ['zones.names.Bravo'] =     { url='zones.names.nato/zones.names.Bravo.ogg',      length=0.54},
        ['zones.names.Charlie'] =   { url='zones.names.nato/zones.names.Charlie.ogg',    length=0.49},
        ['zones.names.Delta'] =     { url='zones.names.nato/zones.names.Delta.ogg',      length=0.49},
        ['zones.names.Echo'] =      { url='zones.names.nato/zones.names.Echo.ogg',       length=0.49},
        ['zones.names.Foxtrot'] =   { url='zones.names.nato/zones.names.Foxtrot.ogg',    length=0.60},
        ['zones.names.Golf'] =      { url='zones.names.nato/zones.names.Golf.ogg',       length=0.56},
        ['zones.names.Hotel'] =     { url='zones.names.nato/zones.names.Hotel.ogg',      length=0.63},
        ['zones.names.India'] =     { url='zones.names.nato/zones.names.India.ogg',      length=0.52},
        ['zones.names.Juliett'] =   { url='zones.names.nato/zones.names.Juliet.ogg',     length=0.61},
        ['zones.names.Kilo'] =      { url='zones.names.nato/zones.names.Kilo.ogg',       length=0.48},
        ['zones.names.Lima'] =      { url='zones.names.nato/zones.names.Lima.ogg',       length=0.46},
        ['zones.names.Mike'] =      { url='zones.names.nato/zones.names.Mike.ogg',       length=0.40},
        ['zones.names.November'] =  { url='zones.names.nato/zones.names.November.ogg',   length=0.60},
        ['zones.names.Oscar'] =     { url='zones.names.nato/zones.names.Oscar.ogg',      length=0.50},
        ['zones.names.Papa'] =      { url='zones.names.nato/zones.names.Papa.ogg',       length=0.46},
        ['zones.names.Quebec'] =    { url='zones.names.nato/zones.names.Quebec.ogg',     length=0.59},
        ['zones.names.Romeo'] =     { url='zones.names.nato/zones.names.Romeo.ogg',      length=0.57},
        ['zones.names.Sierra'] =    { url='zones.names.nato/zones.names.Sierra.ogg',     length=0.57},
        ['zones.names.Tango'] =     { url='zones.names.nato/zones.names.Tango.ogg',      length=0.54},
        ['zones.names.Uniform'] =   { url='zones.names.nato/zones.names.Uniform.ogg',    length=0.70},
        ['zones.names.Victor'] =    { url='zones.names.nato/zones.names.Victor.ogg',     length=0.46},
        ['zones.names.Whiskey'] =   { url='zones.names.nato/zones.names.Whiskey.ogg',    length=0.50},
        ['zones.names.XRay'] =      { url='zones.names.nato/zones.names.XRay.ogg',       length=0.60},
        ['zones.names.Yankee'] =    { url='zones.names.nato/zones.names.Yankee.ogg',     length=0.51},
        ['zones.names.Zulu'] =      { url='zones.names.nato/zones.names.Zulu.ogg',       length=0.47},

        -- locations
        ['zones.names.Babugent'] =      { url='zones.names.caucasus/zones.names.Babugent.ogg',   length=0.51},
        ['zones.names.Batumi'] =        { url='zones.names.caucasus/zones.names.Batumi.ogg',     length=0.64},
        ['zones.names.Beslan'] =        { url='zones.names.caucasus/zones.names.Beslan.ogg',     length=0.58},
        ['zones.names.Cherkessk'] =     { url='zones.names.caucasus/zones.names.Cherkessk.ogg',  length=0.71},
        ['zones.names.Digora'] =        { url='zones.names.caucasus/zones.names.Digora.ogg',     length=0.59},
        ['zones.names.Gudauta'] =       { url='zones.names.caucasus/zones.names.Gudauta.ogg',    length=0.51},
        ['zones.names.Humara'] =        { url='zones.names.caucasus/zones.names.Humara.ogg',     length=0.54},
        ['zones.names.Kislovodsk'] =    { url='zones.names.caucasus/zones.names.Kislovodsk.ogg', length=0.84},
        ['zones.names.Kobuleti'] =      { url='zones.names.caucasus/zones.names.Kobuleti.ogg',   length=0.67},
        ['zones.names.Kutaisi'] =       { url='zones.names.caucasus/zones.names.Kutaisi.ogg',    length=0.75},
        ['zones.names.Lentehi'] =       { url='zones.names.caucasus/zones.names.Lentehi.ogg',    length=0.64},
        ['zones.names.Malgobek'] =      { url='zones.names.caucasus/zones.names.Malgobek.ogg',   length=0.73},
        ['zones.names.Mineralnye'] =    { url='zones.names.caucasus/zones.names.Mineralnye.ogg', length=0.76},
        ['zones.names.Mozdok'] =        { url='zones.names.caucasus/zones.names.Mozdok.ogg',     length=0.65},
        ['zones.names.Nalchik'] =       { url='zones.names.caucasus/zones.names.Nalchik.ogg',    length=0.57},
        ['zones.names.Ochamchira'] =    { url='zones.names.caucasus/zones.names.Ochamchira.ogg', length=0.82},
        ['zones.names.Oni'] =           { url='zones.names.caucasus/zones.names.Oni.ogg',        length=0.39},
        ['zones.names.Prohladniy'] =    { url='zones.names.caucasus/zones.names.Prohladniy.ogg', length=0.66},
        ['zones.names.Senaki'] =        { url='zones.names.caucasus/zones.names.Senaki.ogg',     length=0.62},
        ['zones.names.Sochi'] =         { url='zones.names.caucasus/zones.names.Sochi.ogg',      length=0.55},
        ['zones.names.Sukhumi'] =       { url='zones.names.caucasus/zones.names.Sukhumi.ogg',    length=0.56},
        ['zones.names.Tallyk'] =        { url='zones.names.caucasus/zones.names.Tallyk.ogg',     length=0.51},
        ['zones.names.Terek'] =         { url='zones.names.caucasus/zones.names.Terek.ogg',      length=0.55},
        ['zones.names.Tyrnyauz'] =      { url='zones.names.caucasus/zones.names.Tyrnyauz.ogg',   length=0.75},
        ['zones.names.Unal'] =          { url='zones.names.caucasus/zones.names.Unal.ogg',       length=0.54},
        ['zones.names.Zugdidi'] =       { url='zones.names.caucasus/zones.names.Zugdidi.ogg',    length=0.63},

        ['zones.names.Acre'] =          { url='zones.names.syria/zones.names.Acre.ogg',           length=0.40},
        ['zones.names.Al Assad'] =      { url='zones.names.syria/zones.names.AlAssad.ogg',        length=0.75},
        ['zones.names.Al Dumayr'] =     { url='zones.names.syria/zones.names.AlDumayr.ogg',       length=0.82},
        ['zones.names.Al Qusayr'] =     { url='zones.names.syria/zones.names.AlQusayr.ogg',       length=0.79},
        ['zones.names.Al Qutayfah'] =   { url='zones.names.syria/zones.names.AlQutayfah.ogg',     length=0.85},
        ['zones.names.An Nasiriyah'] =  { url='zones.names.syria/zones.names.AnNasiriyah.ogg',    length=0.94},
        ['zones.names.Ar Rastan'] =     { url='zones.names.syria/zones.names.ArRastan.ogg',       length=0.86},
        ['zones.names.Baniyas'] =       { url='zones.names.syria/zones.names.Baniyas.ogg',        length=0.70},
        ['zones.names.Beirut'] =        { url='zones.names.syria/zones.names.Beirut.ogg',         length=0.58},
        ['zones.names.Beit Shean'] =    { url='zones.names.syria/zones.names.BeitShean.ogg',      length=0.80},
        ['zones.names.Busra'] =         { url='zones.names.syria/zones.names.Busra.ogg',          length=0.53},
        ['zones.names.Damascus'] =      { url='zones.names.syria/zones.names.Damascus.ogg',       length=0.79},
        ['zones.names.Duma'] =          { url='zones.names.syria/zones.names.Duma.ogg',           length=0.42},
        ['zones.names.Elkorum'] =       { url='zones.names.syria/zones.names.Elkorum.ogg',        length=0.73},
        ['zones.names.El Taebah'] =     { url='zones.names.syria/zones.names.ElTaebah.ogg',       length=0.73},
        ['zones.names.Et Turra'] =      { url='zones.names.syria/zones.names.EtTurra.ogg',        length=0.62},
        ['zones.names.Ghabagheb'] =     { url='zones.names.syria/zones.names.Ghabagheb.ogg',      length=0.71},
        ['zones.names.Hama'] =          { url='zones.names.syria/zones.names.Hama.ogg',           length=0.42},
        ['zones.names.Hawash'] =        { url='zones.names.syria/zones.names.Hawash.ogg',         length=0.70},
        ['zones.names.Homs'] =          { url='zones.names.syria/zones.names.Homs.ogg',           length=0.56},
        ['zones.names.Hussein'] =       { url='zones.names.syria/zones.names.Hussein.ogg',        length=0.65},
        ['zones.names.Irbid'] =         { url='zones.names.syria/zones.names.Irbid.ogg',          length=0.44},
        ['zones.names.Jabah'] =         { url='zones.names.syria/zones.names.Jabah.ogg',          length=0.48},
        ['zones.names.Jasim'] =         { url='zones.names.syria/zones.names.Jasim.ogg',          length=0.65},
        ['zones.names.Khalkhalah'] =    { url='zones.names.syria/zones.names.Khalkhalah.ogg',     length=0.63},
        ['zones.names.Khan Alsheh'] =   { url='zones.names.syria/zones.names.KhanAlsheh.ogg',     length=0.86},
        ['zones.names.Khirbet'] =       { url='zones.names.syria/zones.names.Khirbet.ogg',        length=0.62},
        ['zones.names.Kiryat'] =        { url='zones.names.syria/zones.names.Kiryat.ogg',         length=0.50},
        ['zones.names.Madaya'] =        { url='zones.names.syria/zones.names.Madaya.ogg',         length=0.61},
        ['zones.names.Marj'] =          { url='zones.names.syria/zones.names.Marj.ogg',           length=0.55},
        ['zones.names.Mezzeh'] =        { url='zones.names.syria/zones.names.Mezzeh.ogg',         length=0.48},
        ['zones.names.Muhradah'] =      { url='zones.names.syria/zones.names.Muhradah.ogg',       length=0.66},
        ['zones.names.Naqoura'] =       { url='zones.names.syria/zones.names.Naqoura.ogg',        length=0.61},
        ['zones.names.Nebatieh'] =      { url='zones.names.syria/zones.names.Nebatieh.ogg',       length=0.66},
        ['zones.names.Palmyra'] =       { url='zones.names.syria/zones.names.Palmyra.ogg',        length=0.66},
        ['zones.names.Qaraoun'] =       { url='zones.names.syria/zones.names.Qaraoun.ogg',        length=0.65},
        ['zones.names.Ramat David'] =   { url='zones.names.syria/zones.names.RamatDavid.ogg',     length=0.86},
        ['zones.names.Rayak'] =         { url='zones.names.syria/zones.names.Rayak.ogg',          length=0.58},
        ['zones.names.Rene'] =          { url='zones.names.syria/zones.names.Rene.ogg',           length=0.44},
        ['zones.names.Rosh Pina'] =     { url='zones.names.syria/zones.names.RoshPina.ogg',       length=0.73},
        ['zones.names.Saida'] =         { url='zones.names.syria/zones.names.Saida.ogg',          length=0.58},
        ['zones.names.Sayqal'] =        { url='zones.names.syria/zones.names.Sayqal.ogg',         length=0.64},
        ['zones.names.Shayrat'] =       { url='zones.names.syria/zones.names.Shayrat.ogg',        length=0.58},
        ['zones.names.Tartus'] =        { url='zones.names.syria/zones.names.Tartus.ogg',         length=0.57},
        ['zones.names.Thalah'] =        { url='zones.names.syria/zones.names.Thalah.ogg',         length=0.44},
        ['zones.names.Tiberias'] =      { url='zones.names.syria/zones.names.Tiberias.ogg',       length=0.91},
        ['zones.names.Tiyas'] =         { url='zones.names.syria/zones.names.Tiyas.ogg',          length=0.57},
        ['zones.names.Tripoli'] =       { url='zones.names.syria/zones.names.Tripoli.ogg',        length=0.58},
        ['zones.names.Tyre'] =          { url='zones.names.syria/zones.names.Tyre.ogg',           length=0.47},
        ['zones.names.Wujah'] =         { url='zones.names.syria/zones.names.Wujah.ogg',          length=0.47},
        
        -- generic zones
        ['zones.names.Distillery'] =    { url='zones.names.misc/zones.names.Distillery.ogg',     length=0.66},
        ['zones.names.Factory'] =       { url='zones.names.misc/zones.names.Factory.ogg',        length=0.59},
        ['zones.names.Farm'] =          { url='zones.names.misc/zones.names.Farm.ogg',           length=0.50},
        ['zones.names.Intel Center'] =  { url='zones.names.misc/zones.names.IntelCenter.ogg',    length=0.86},
        ['zones.names.Mine'] =          { url='zones.names.misc/zones.names.Mine.ogg',           length=0.42},
        ['zones.names.Oil Fields'] =    { url='zones.names.misc/zones.names.OilFields.ogg',      length=0.70},
        ['zones.names.Power Plant'] =   { url='zones.names.misc/zones.names.PowerPlant.ogg',     length=0.69},
        ['zones.names.Racetrack'] =     { url='zones.names.misc/zones.names.Racetrack.ogg',      length=0.55},
        ['zones.names.Refinery'] =      { url='zones.names.misc/zones.names.Refinery.ogg',       length=0.66},
        ['zones.names.Weapon Depot'] =  { url='zones.names.misc/zones.names.WeaponDepot.ogg',    length=0.76},
        
        -- zone events
        ['zones.events.lostbythem.1'] =     { url='zones.events/zones.events.lostbythem.1.ogg',      length=1.60 },-- "the enemy has lost control of ..."
        ['zones.events.lostbythem.2'] =     { url='zones.events/zones.events.lostbythem.2.ogg',      length=2.16 },-- "... is no longer under the enemys control"
        ['zones.events.lost.1'] =           { url='zones.events/zones.events.lost.1.ogg',            length=1.01 },-- "we've lost control of ..."
        ['zones.events.lost.2'] =           { url='zones.events/zones.events.lost.2.ogg',            length=1.80 },-- "... is no longer under our control"
        ['zones.events.capturedbyus.1'] =   { url='zones.events/zones.events.capturedbyus.1.ogg',    length=0.65}, -- "we've captured ...", 
        ['zones.events.capturedbyus.2'] =   { url='zones.events/zones.events.capturedbyus.2.ogg',    length=0.97}, -- "... has been seccured"
        ['zones.events.capturedbythem.1'] = { url='zones.events/zones.events.capturedbythem.1.ogg',  length=1.17}, -- "The enemy has captured ..."
        ['zones.events.capturedbythem.2'] = { url='zones.events/zones.events.capturedbythem.2.ogg',  length=1.54}, -- "... has been captured by the enemy"
        ['zones.events.underattack.1'] =    { url='zones.events/zones.events.underattack.1.ogg',     length=1.94}, -- "... is under attack by ground forces", 
        ['zones.events.underattack.2'] =    { url='zones.events/zones.events.underattack.2.ogg',     length=1.76}, -- "Enemy ground forces are attacking ..."
        
        -- squads
        ['squads.capture.working'] =            { url='squads/squads.capture.working.ogg',             length=1.76}, -- "Capture squad, Securing the area."
        ['squads.capture.extracting'] =         { url='squads/squads.capture.extracting.ogg',          length=1.99}, --"Capture squad, Requesting extraction."

        ['squads.sabotage.working'] =           { url='squads/squads.sabotage.working.ogg',            length=2.01}, -- "Saboteurs, Planting explosives."
        ['squads.sabotage.extracting'] =        { url='squads/squads.sabotage.extracting.ogg',         length=2.06}, -- "Saboteurs, Requesting extraction."
        ['squads.sabotage.missioncomplete'] =   { url='squads/squads.sabotage.missioncomplete.ogg',    length=2.58}, --"Sabotage complete, heading to extraction."

        ['squads.ambush.working'] =             { url='squads/squads.ambush.working.ogg',              length=1.59}, -- "Ambush squad, digging in."
        ['squads.ambush.extracting'] =          { url='squads/squads.ambush.extracting.ogg',           length=2.37}, --"Ambush squad requesting extraction."

        ['squads.engineer.working'] =           { url='squads/squads.engineer.working.ogg',            length=1.64}, -- "Engineers, Reporting for duty."
        ['squads.engineer.extracting'] =        { url='squads/squads.engineer.extracting.ogg',         length=1.87}, -- "Engineers, requesting extraction."

        ['squads.manpads.working'] =            { url='squads/squads.manpads.working.ogg',             length=2.27}, -- "Stinger squad, setting up defensive positions."
        ['squads.manpads.extracting'] =         { url='squads/squads.manpads.extracting.ogg',          length=1.85}, -- "Stinger squad, requesting extraction."

        ['squads.spy.working'] =                { url='squads/squads.spy.working.ogg',                 length=2.24}, -- "Agent in position, obtaining intelligence."
        ['squads.spy.extracting'] =             { url='squads/squads.spy.extracting.ogg',              length=1.65}, -- "Spy, requesting extraction."
        ['squads.spy.missioncomplete'] =        { url='squads/squads.spy.missioncomplete.ogg',         length=2.12}, -- "Intelligence obtained, heading to extract."

        ['squads.rapier.working'] =             { url='squads/squads.rapier.working.ogg',              length=1.07}, -- "Rapier operational."
        ['squads.rapier.extracting'] =          { url='squads/squads.rapier.extracting.ogg',           length=2.0}, -- "Rapier crew, requesting extraction."

        ['squads.assault.working'] =            { url='squads/squads.assault.working.ogg',             length=1.27}, -- "Assault squad, ready"
        ['squads.assault.engaging'] =           { url='squads/squads.assault.engaging.ogg',            length=2.17}, -- "Assault squad, engaging the enemy"
        ['squads.assault.extracting'] =         { url='squads/squads.assault.extracting.ogg',          length=2.17}, -- "Assault squad, requesting extraction."

        -- csar
        ['pilots.extracting.1.call.1'] = { url='pilots/pilots.extracting.1.call.1.ogg', length=2.24},
        ['pilots.extracting.1.call.2'] = { url='pilots/pilots.extracting.1.call.2.ogg', length=4.36},
        ['pilots.extracting.1.call.3'] = { url='pilots/pilots.extracting.1.call.3.ogg', length=4.58},
        ['pilots.extracting.1.call.4'] = { url='pilots/pilots.extracting.1.call.4.ogg', length=4.93},
        ['pilots.extracting.1.call.5'] = { url='pilots/pilots.extracting.1.call.5.ogg', length=3.75},
        ['pilots.extracting.1.call.quip.1'] = { url='pilots/pilots.extracting.1.call.quip.1.ogg', length=1.43},

        ['pilots.extracting.2.call.1'] = { url='pilots/pilots.extracting.2.call.1.ogg', length=2.24},
        ['pilots.extracting.2.call.2'] = { url='pilots/pilots.extracting.2.call.2.ogg', length=4.60},
        ['pilots.extracting.2.call.3'] = { url='pilots/pilots.extracting.2.call.3.ogg', length=4.50},
        ['pilots.extracting.2.call.4'] = { url='pilots/pilots.extracting.2.call.4.ogg', length=5.56},
        ['pilots.extracting.2.call.5'] = { url='pilots/pilots.extracting.2.call.5.ogg', length=4.10},
        ['pilots.extracting.2.call.quip.1'] = { url='pilots/pilots.extracting.2.call.quip.1.ogg', length=1.72},

        ['pilots.extracting.3.call.1'] = { url='pilots/pilots.extracting.3.call.1.ogg', length=2.36},
        ['pilots.extracting.3.call.2'] = { url='pilots/pilots.extracting.3.call.2.ogg', length=4.92},
        ['pilots.extracting.3.call.3'] = { url='pilots/pilots.extracting.3.call.3.ogg', length=5.05},
        ['pilots.extracting.3.call.4'] = { url='pilots/pilots.extracting.3.call.4.ogg', length=5.68},
        ['pilots.extracting.3.call.5'] = { url='pilots/pilots.extracting.3.call.5.ogg', length=3.81},
        ['pilots.extracting.3.call.quip.1'] = { url='pilots/pilots.extracting.3.call.quip.1.ogg', length=1.48},

        ['pilots.extracting.4.call.1'] = { url='pilots/pilots.extracting.4.call.1.ogg', length=2.24},
        ['pilots.extracting.4.call.2'] = { url='pilots/pilots.extracting.4.call.2.ogg', length=4.54},
        ['pilots.extracting.4.call.3'] = { url='pilots/pilots.extracting.4.call.3.ogg', length=4.90},
        ['pilots.extracting.4.call.4'] = { url='pilots/pilots.extracting.4.call.4.ogg', length=5.57},
        ['pilots.extracting.4.call.5'] = { url='pilots/pilots.extracting.4.call.5.ogg', length=3.99},
        ['pilots.extracting.4.call.quip.1'] = { url='pilots/pilots.extracting.4.call.quip.1.ogg', length=1.74},
        
        ['pilots.extracting.5.call.1'] = { url='pilots/pilots.extracting.5.call.1.ogg', length=2.36},
        ['pilots.extracting.5.call.2'] = { url='pilots/pilots.extracting.5.call.2.ogg', length=4.65},
        ['pilots.extracting.5.call.3'] = { url='pilots/pilots.extracting.5.call.3.ogg', length=4.89},
        ['pilots.extracting.5.call.4'] = { url='pilots/pilots.extracting.5.call.4.ogg', length=5.44},
        ['pilots.extracting.5.call.5'] = { url='pilots/pilots.extracting.5.call.5.ogg', length=3.92},
        ['pilots.extracting.5.call.quip.1'] = { url='pilots/pilots.extracting.5.call.quip.1.ogg', length=1.71},

        --gci
        
        ['gci.numbers.0'] = { url='gci/gci.numbers.0.ogg', length=0.61},
        ['gci.numbers.1'] = { url='gci/gci.numbers.1.ogg', length=0.41},
        ['gci.numbers.2'] = { url='gci/gci.numbers.2.ogg', length=0.41},
        ['gci.numbers.3'] = { url='gci/gci.numbers.3.ogg', length=0.42},
        ['gci.numbers.4'] = { url='gci/gci.numbers.4.ogg', length=0.51},
        ['gci.numbers.5'] = { url='gci/gci.numbers.5.ogg', length=0.48},
        ['gci.numbers.6'] = { url='gci/gci.numbers.6.ogg', length=0.52},
        ['gci.numbers.7'] = { url='gci/gci.numbers.7.ogg', length=0.56},
        ['gci.numbers.8'] = { url='gci/gci.numbers.8.ogg', length=0.40},
        ['gci.numbers.9'] = { url='gci/gci.numbers.9.ogg', length=0.51},

        ['gci.callsigns.Caveman'] = { url='gci/gci.callsigns.Caveman.ogg', length=0.69},
        ['gci.callsigns.Casper'] = { url='gci/gci.callsigns.Casper.ogg', length=0.66},
        ['gci.callsigns.Banjo'] = { url='gci/gci.callsigns.Banjo.ogg', length=0.72},
        ['gci.callsigns.Boomer'] = { url='gci/gci.callsigns.Boomer.ogg', length=0.48},
        ['gci.callsigns.Shaft'] = { url='gci/gci.callsigns.Shaft.ogg', length=0.57},
        ['gci.callsigns.Wookie'] = { url='gci/gci.callsigns.Wookie.ogg', length=0.53},
        ['gci.callsigns.Tiny'] = { url='gci/gci.callsigns.Tiny.ogg', length=0.52},
        ['gci.callsigns.Tool'] = { url='gci/gci.callsigns.Tool.ogg', length=0.47},
        ['gci.callsigns.Trash'] = { url='gci/gci.callsigns.Trash.ogg', length=0.53},
        ['gci.callsigns.Orca'] = { url='gci/gci.callsigns.Orca.ogg', length=0.53},
        ['gci.callsigns.Irish'] = { url='gci/gci.callsigns.Irish.ogg', length=0.61},
        ['gci.callsigns.Flex'] = { url='gci/gci.callsigns.Flex.ogg', length=0.53},
        ['gci.callsigns.Grip'] = { url='gci/gci.callsigns.Grip.ogg', length=0.39},
        ['gci.callsigns.Dice'] = { url='gci/gci.callsigns.Dice.ogg', length=0.52},
        ['gci.callsigns.Duck'] = { url='gci/gci.callsigns.Duck.ogg', length=0.40},
        ['gci.callsigns.Poet'] = { url='gci/gci.callsigns.Poet.ogg', length=0.50},
        ['gci.callsigns.Jack'] = { url='gci/gci.callsigns.Jack.ogg', length=0.47},
        ['gci.callsigns.Lego'] = { url='gci/gci.callsigns.Lego.ogg', length=0.58},
        ['gci.callsigns.Hurl'] = { url='gci/gci.callsigns.Hurl.ogg', length=0.44},
        ['gci.callsigns.Spin'] = { url='gci/gci.callsigns.Spin.ogg', length=0.57},

        -- 'Trash 1 1, fixed-wing, group of 2, bra: 3 4 6, for: 2 5 miles, at angels 3'
        ['gci.callout.helo'] = { url='gci/gci.callout.helo.ogg', length=0.82}, -- "helo"
        ['gci.callout.fixedwing'] = { url='gci/gci.callout.fixedwing.ogg', length=1.0}, -- "fixed wing"
        ['gci.callout.groupof'] = { url='gci/gci.callout.groupof.ogg', length=0.60}, -- "group of"
        ['gci.callout.bra'] = { url='gci/gci.callout.bra.ogg', length=0.81}, -- "bra"
        ['gci.callout.for'] = { url='gci/gci.callout.for.ogg', length=0.44}, -- "for"
        ['gci.callout.miles'] = { url='gci/gci.callout.miles.ogg', length=0.7}, -- "miles"
        ['gci.callout.atangels'] = { url='gci/gci.callout.atangels.ogg', length=0.58}, -- "at angels"
    }
end

-----------------[[ END OF TransmissionManager.lua ]]-----------------



-----------------[[ Objectives/Objective.lua ]]-----------------

Objective = {}

do
    Objective.types = {
        fly_to_zone_seq = 'fly_to_zone_seq',            -- any of playerlist inside [zone] in sequence
        recon_zone = 'recon_zone',                           -- within X km, facing Y angle +-, % of enemy units in LOS progress faster
        destroy_attr = 'destroy_attr',                  -- any of playerlist kill event on target with any of [attribute]
        destroy_attr_at_zone = 'destroy_attr_at_zone',  -- any of playerlist kill event on target at [zone] with any of [attribute]
        clear_attr_at_zone = 'clear_attr_at_zone',      -- [zone] does not have any units with [attribute]
        destroy_structure = 'destroy_structure',        -- [structure] is killed by any player (getDesc().displayName or getDesc().typeName:gsub('%.','') must match)
        hit_structure = 'hit_structure',                -- [structure] is hit by any player (getDesc().displayName or getDesc().typeName:gsub('%.','') must match)
        destroy_group = 'destroy_group',                -- [group] is missing from mission AND any player killed unit from group at least once
        supply = 'supply',                              -- any of playerlist unload [amount] supply at [zone]
        extract_pilot = 'extract_pilot',                  -- players extracted specific ejected pilots
        extract_squad = 'extract_squad',                  -- players extracted specific squad
        unloaded_pilot_or_squad = 'unloaded_pilot_or_squad', -- unloaded pilot or squad
        deploy_squad = 'deploy_squad',                  --deploy squad at zone
        escort = 'escort',                              -- escort convoy
        protect = 'protect',                            -- protect other mission
        air_kill_bonus = 'air_kill_bonus',               -- award bonus for air kills
        bomb_in_zone = 'bomb_in_zone',                     -- bombs tallied inside zone
        player_close_to_zone = 'player_close_to_zone', -- player is close to point
        recover_crate = 'recover_crate'                 -- crate unpacked in a friendly zone
    }

    function Objective:new(type)

		local obj = {
            type = type,
            mission = nil,
            param = {},
            isComplete = false,
            isFailed = false
        }

		setmetatable(obj, self)
		self.__index = self

		return obj
    end

    function Objective:initialize(mission, param)
        self.mission = mission
        self:validateParameters(param)
        self.param = param
    end

    function Objective:getType()
        return self.type
    end

    function Objective:validateParameters(param)
        for i,v in pairs(self.requiredParams) do
            if v and param[i] == nil then
                env.error("Objective - missing parameter: "..i..' in '..self:getType(), true)
            end
        end
    end

    -- virtual
    Objective.requiredParams = {}

    function Objective:getText()
        env.error("Objective - getText not implemented")
        return "NOT IMPLEMENTED"
    end

    function Objective:update()
        env.error("Objective - update not implemented")
    end

    function Objective:checkFail()
        env.error("Objective - checkFail not implemented")
    end
    --end virtual
end

-----------------[[ END OF Objectives/Objective.lua ]]-----------------



-----------------[[ Objectives/ObjAirKillBonus.lua ]]-----------------

ObjAirKillBonus = Objective:new(Objective.types.air_kill_bonus)
do
    ObjAirKillBonus.requiredParams = {
        ['attr'] = true,
        ['bonus'] = true,
        ['count'] = true,
        ['linkedObjectives'] = true
    }

    function ObjAirKillBonus:getText()
        local msg = 'Destroy: '
        for _,v in ipairs(self.param.attr) do
            msg = msg..v..', '
        end
        msg = msg:sub(1,#msg-2)
        msg = msg..'\n Kills increase mission reward (Ends when other objectives are completed)'
        msg = msg..'\n   Kills: '..self.param.count
        return msg
    end

    function ObjAirKillBonus:update()
        if not self.isComplete and not self.isFailed then
            local allcomplete = true
            for _,obj in pairs(self.param.linkedObjectives) do
                if obj.isFailed then self.isFailed = true end
                if not obj.isComplete then allcomplete = false end
            end

            self.isComplete = allcomplete
        end
    end

    function ObjAirKillBonus:checkFail()
        if not self.isComplete and not self.isFailed then
            local allcomplete = true
            for _,obj in pairs(self.param.linkedObjectives) do
                if obj.isFailed then self.isFailed = true end
                if not obj.isComplete then allcomplete = false end
            end

            self.isComplete = allcomplete
        end
    end
end

-----------------[[ END OF Objectives/ObjAirKillBonus.lua ]]-----------------



-----------------[[ Objectives/ObjBombInsideZone.lua ]]-----------------

ObjBombInsideZone = Objective:new(Objective.types.bomb_in_zone)
do
    ObjBombInsideZone.requiredParams = {
        ['targetZone'] = true,
        ['max'] = true,
        ['required'] = true,
        ['dropped'] = true,
        ['isFinishStarted'] = true,
        ['bonus'] = true
    }

    function ObjBombInsideZone:getText()
        local msg = 'Bomb runways at '..self.param.targetZone.name..'\n'

        local ratio = self.param.dropped/self.param.required
        local percent = string.format('%.1f',ratio*100)

        msg = msg..'\n  Runway bombed: '..percent..'%\n'

        msg = msg..'\n  Cluster bombs do not deal enough damage to complete this mission'

        return msg
    end

    function ObjBombInsideZone:update()
        if not self.isComplete and not self.isFailed then
            if self.param.targetZone.side ~= 1 then
                self.isFailed = true
                self.mission.failureReason = self.param.targetZone.name..' is no longer controlled by the enemy.'
            end

            if not self.param.isFinishStarted then
                if self.param.dropped >= self.param.required then
                    self.param.isFinishStarted = true
                    timer.scheduleFunction(function(o)
                        o.isComplete = true
                    end, self, timer.getTime()+5)
                end
            end
        end
    end

    function ObjBombInsideZone:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.targetZone.side ~= 1 then
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjBombInsideZone.lua ]]-----------------



-----------------[[ Objectives/ObjClearZoneOfUnitsWithAttribute.lua ]]-----------------

ObjClearZoneOfUnitsWithAttribute = Objective:new(Objective.types.clear_attr_at_zone)
do
    ObjClearZoneOfUnitsWithAttribute.requiredParams = {
        ['attr'] = true,
        ['tgtzone'] = true
    }

    function ObjClearZoneOfUnitsWithAttribute:getText()
        local msg = 'Clear '..self.param.tgtzone.name..' of: '
        for _,v in ipairs(self.param.attr) do
            msg = msg..v..', '
        end
        msg = msg:sub(1,#msg-2)
        msg = msg..'\n Progress: '..self.param.tgtzone:getUnitCountWithAttributeOnSide(self.param.attr, 1)..' left'
        return msg
    end

    function ObjClearZoneOfUnitsWithAttribute:update()
        if not self.isComplete and not self.isFailed then
            local zn = self.param.tgtzone
            if zn.side ~= 1 or not zn:hasUnitWithAttributeOnSide(self.param.attr, 1) then 
                self.isComplete = true
                return true
            end
        end
    end

    function ObjClearZoneOfUnitsWithAttribute:checkFail()
        -- can not fail
    end
end

-----------------[[ END OF Objectives/ObjClearZoneOfUnitsWithAttribute.lua ]]-----------------



-----------------[[ Objectives/ObjDestroyGroup.lua ]]-----------------

ObjDestroyGroup = Objective:new(Objective.types.destroy_group)
do
    ObjDestroyGroup.requiredParams = {
        ['target'] = true,
        ['targetUnitNames'] = true,
        ['lastUpdate'] = true
    }

    function ObjDestroyGroup:getText()
        local msg = 'Destroy '..self.param.target.product.display..' before it reaches its destination.\n'

        local gr = Group.getByName(self.param.target.name)
        if gr and gr:getSize()>0 then
            local killcount = 0
            for i,v in pairs(self.param.targetUnitNames) do
                if v == true then
                    killcount = killcount + 1
                end
            end

            msg = msg..'\n     '..gr:getSize()..' units remaining. (killed '..killcount..')\n'
            for name, unit in pairs(self.mission.players) do
                if unit and unit:isExist() then
                    local tgtUnit = gr:getUnit(1)
                    local dist = mist.utils.get2DDist(unit:getPoint(), tgtUnit:getPoint())
                    
                    local m = '\n     '..name..': Distance: '
                    m = m..string.format('%.2f',dist/1000)..'km'
                    m = m..' Bearing: '..math.floor(Utils.getBearing(unit:getPoint(), tgtUnit:getPoint()))
                    msg = msg..m
                end
            end
        end

        return msg
    end

    function ObjDestroyGroup:update()
        if not self.isComplete and not self.isFailed then
            local target = self.param.target
            local exists = false
            local gr = Group.getByName(target.name)

            if gr and gr:getSize() > 0 then
                local updateFrequency = 5 -- seconds
                local shouldUpdateMsg = (timer.getAbsTime() - self.param.lastUpdate) > updateFrequency

                if shouldUpdateMsg then
                    for _, unit in pairs(self.mission.players) do
                        if unit and unit:isExist() then
                            local tgtUnit = gr:getUnit(1)
                            local dist = mist.utils.get2DDist(unit:getPoint(), tgtUnit:getPoint())
                            local dstkm = string.format('%.2f',dist/1000)
                            local dstnm = string.format('%.2f',dist/1852)

                            local m = 'Distance: '
                            m = m..dstkm..'km | '..dstnm..'nm'

                            m = m..'\nBearing: '..math.floor(Utils.getBearing(unit:getPoint(), tgtUnit:getPoint()))
                            trigger.action.outTextForUnit(unit:getID(), m, updateFrequency)
                        end
                    end
                    
                    self.param.lastUpdate = timer.getAbsTime()
                end
            elseif target.state == 'enroute' then
                for i,v in pairs(self.param.targetUnitNames) do
                    if v == true then
                        self.isComplete = true
                        return true
                    end
                end

                self.isFailed = true
                self.mission.failureReason = 'Convoy was killed by someone else.'
                return true
            else
                self.isFailed = true
                self.mission.failureReason = 'Convoy has reached its destination.'
                return true
            end
        end
    end

    function ObjDestroyGroup:checkFail()
        if not self.isComplete and not self.isFailed then
            local target = self.param.target
            local gr = Group.getByName(target.name)

            if target.state ~= 'enroute' or not gr or gr:getSize() == 0 then
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjDestroyGroup.lua ]]-----------------



-----------------[[ Objectives/ObjDestroyStructure.lua ]]-----------------

ObjDestroyStructure = Objective:new(Objective.types.destroy_structure)
do
    ObjDestroyStructure.requiredParams = {
        ['target']=true,
        ['tgtzone']=true
    }

    function ObjDestroyStructure:getText()
        local msg = 'Destroy '..self.param.target.display..' at '..self.param.tgtzone.name..'\n'
            
        local point = nil
        local st = StaticObject.getByName(self.param.target.name)
        if st then
            point = st:getPoint()
        else
            st = Group.getByName(self.param.target.name)
            if st and st:getSize()>0 then
                point = st:getUnit(1):getPoint()
            end
        end
        
        if point then
            local lat,lon,alt = coord.LOtoLL(point)
            local mgrs = coord.LLtoMGRS(coord.LOtoLL(point))
            msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
            msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
            msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
            msg = msg..'\n Altitude: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
        end

        return msg
    end

    function ObjDestroyStructure:update()
        if not self.isComplete and not self.isFailed then

            local target = self.param.target
            local exists = false
            local st = StaticObject.getByName(target.name)
            if st then
                exists = true
            else
                st = Group.getByName(target.name)
                if st and st:getSize()>0 then
                    exists = true
                end
            end

            if not exists then
                self.isComplete = true
                return true
            end
        end
    end

    function ObjDestroyStructure:checkFail()
        if not self.isComplete and not self.isFailed then
            local target = self.param.target
            local exists = false
            local st = StaticObject.getByName(target.name)
            if st then
                exists = true
            else
                st = Group.getByName(target.name)
                if st and st:getSize()>0 then
                    exists = true
                end
            end

            if not exists then 
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjDestroyStructure.lua ]]-----------------



-----------------[[ Objectives/ObjHitStructure.lua ]]-----------------

ObjHitStructure = Objective:new(Objective.types.hit_structure)
do
    ObjHitStructure.requiredParams = {
        ['target']=true,
        ['tgtzone']=true,
        ['hit']=true
    }

    function ObjHitStructure:getText()
        local msg = 'Hit '..self.param.target.display..' at '..self.param.tgtzone.name..'\n'
            
        local point = nil
        local st = StaticObject.getByName(self.param.target.name)
        if st then
            point = st:getPoint()
        else
            st = Group.getByName(self.param.target.name)
            if st and st:getSize()>0 then
                point = st:getUnit(1):getPoint()
            end
        end
        
        if point then
            local lat,lon,alt = coord.LOtoLL(point)
            local mgrs = coord.LLtoMGRS(coord.LOtoLL(point))
            msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
            msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
            msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
            msg = msg..'\n Altitude: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
        end

        return msg
    end

    function ObjHitStructure:update()
        if not self.isComplete and not self.isFailed then
            if self.param.hit then
                self.isComplete = true
                return true
            end

            local target = self.param.target
            local exists = false
            local st = StaticObject.getByName(target.name)
            if st then
                exists = true
            else
                st = Group.getByName(target.name)
                if st and st:getSize()>0 then
                    exists = true
                end
            end

            if not exists then
                if not self.firstFailure then
                    self.firstFailure = timer.getAbsTime()
                end
            end

            if self.firstFailure and (timer.getAbsTime() - self.firstFailure > 1*60) then
                self.isFailed = true
                self.mission.failureReason = 'Structure was destoyed before it got hit.'
                return true
            end
        end
    end

    function ObjHitStructure:checkFail()
        if not self.isComplete and not self.isFailed then
            local target = self.param.target
            local exists = false
            local st = StaticObject.getByName(target.name)
            if st then
                exists = true
            else
                st = Group.getByName(target.name)
                if st and st:getSize()>0 then
                    exists = true
                end
            end

            if not exists then 
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjHitStructure.lua ]]-----------------



-----------------[[ Objectives/ObjDestroyUnitsWithAttribute.lua ]]-----------------

ObjDestroyUnitsWithAttribute = Objective:new(Objective.types.destroy_attr)
do
    ObjDestroyUnitsWithAttribute.requiredParams = {
        ['attr'] = true,
        ['amount'] = true,
        ['killed'] = true,
        ['hits'] = true
    }

    function ObjDestroyUnitsWithAttribute:getText()
        local hits = self.param.hits or 0
        local progress = math.min(self.param.killed + math.floor(hits/2), self.param.amount)

        local msg = 'Destroy: '
        for _,v in ipairs(self.param.attr) do
            msg = msg..v..', '
        end
        msg = msg:sub(1,#msg-2)
        msg = msg..'\n Progress: '..progress..'/'..self.param.amount
        return msg
    end

    function ObjDestroyUnitsWithAttribute:update()
        if not self.isComplete and not self.isFailed then
            local hits = self.param.hits or 0
            local progress = math.min(self.param.killed + math.floor(hits/2), self.param.amount)
            if progress >= self.param.amount then
                self.isComplete = true
                return true
            end
        end
    end

    function ObjDestroyUnitsWithAttribute:checkFail()
        -- can not fail
    end
end

-----------------[[ END OF Objectives/ObjDestroyUnitsWithAttribute.lua ]]-----------------



-----------------[[ Objectives/ObjDestroyUnitsWithAttributeAtZone.lua ]]-----------------

ObjDestroyUnitsWithAttributeAtZone = Objective:new(Objective.types.destroy_attr_at_zone)
do
    ObjDestroyUnitsWithAttributeAtZone.requiredParams = {
        ['attr']=true,
        ['amount'] = true,
        ['killed'] = true,
        ['tgtzone'] = true,
        ['hits'] = true
    }

    function ObjDestroyUnitsWithAttributeAtZone:getText()
        local hits = self.param.hits or 0
        local progress = math.min(self.param.killed + math.floor(hits/2), self.param.amount)

        local msg = 'Destroy at '..self.param.tgtzone.name..': '
        for _,v in ipairs(self.param.attr) do
            msg = msg..v..', '
        end
        msg = msg:sub(1,#msg-2)
        msg = msg..'\n Progress: '..progress..'/'..self.param.amount
        return msg
    end

    function ObjDestroyUnitsWithAttributeAtZone:update()
        if not self.isComplete and not self.isFailed then
            local hits = self.param.hits or 0
            local progress = math.min(self.param.killed + math.floor(hits/2), self.param.amount)

            if progress >= self.param.amount then
                self.isComplete = true
                return true
            end

            local zn = self.param.tgtzone
            if zn.side ~= 1 or not zn:hasUnitWithAttributeOnSide(self.param.attr, 1) then 
                if self.firstFailure == nil then
                    self.firstFailure = timer.getAbsTime()
                else
                    if timer.getAbsTime() - self.firstFailure > 5*60 then
                        self.isFailed = true
                        self.mission.failureReason = zn.name..' no longer has targets matching the description.'
                        return true
                    end
                end
            else
                if self.firstFailure ~= nil then
                    self.firstFailure = nil
                end
            end
        end
    end

    function ObjDestroyUnitsWithAttributeAtZone:checkFail()
        if not self.isComplete and not self.isFailed then
            local zn = self.param.tgtzone
            if zn.side ~= 1 or not zn:hasUnitWithAttributeOnSide(self.param.attr, 1) then 
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjDestroyUnitsWithAttributeAtZone.lua ]]-----------------



-----------------[[ Objectives/ObjEscortGroup.lua ]]-----------------

ObjEscortGroup = Objective:new(Objective.types.escort)
do
    ObjEscortGroup.requiredParams = {
        ['maxAmount']=true,
        ['amount'] = true,
        ['proxDist']= true,
        ['target'] = true,
        ['lastUpdate']= true
    }

    function ObjEscortGroup:getText()
        local msg = 'Stay in close proximity of the convoy'

        local gr = Group.getByName(self.param.target.name)
        if gr and gr:getSize()>0 then
            local grunit = gr:getUnit(1)
            local lat,lon,alt = coord.LOtoLL(grunit:getPoint())
            local mgrs = coord.LLtoMGRS(coord.LOtoLL(grunit:getPoint()))
            msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
            msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
            msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
        end
        
        local prg = math.floor(((self.param.maxAmount - self.param.amount)/self.param.maxAmount)*100)
        msg = msg.. '\n Progress: '..prg..'%'
        return msg
    end

    function ObjEscortGroup:update()
        if not self.isComplete and not self.isFailed then
            local gr = Group.getByName(self.param.target.name)
            if not gr or gr:getSize()==0 then
                self.isFailed = true
                self.mission.failureReason = 'Group has been destroyed.'
                return true
            end
            local grunit = gr:getUnit(1)

            if self.param.target.state == 'atdestination' or self.param.target.state == 'siege' then
                for name, unit in pairs(self.mission.players) do
                    if unit and unit:isExist() then
                        local dist = mist.utils.get3DDist(unit:getPoint(), grunit:getPoint())
                        if dist < self.param.proxDist then
                            self.isComplete = true
                            break
                        end
                    end
                end

                if not self.isComplete then 
                    self.isFailed = true 
                    self.mission.failureReason = 'Group has reached its destination without an escort.'
                end
            end

            if not self.isComplete and not self.isFailed then
                local plycount = Utils.getTableSize(self.mission.players)
                if plycount == 0 then plycount = 1 end
                local updateFrequency = 5 -- seconds
                local shouldUpdateMsg = (timer.getAbsTime() - self.param.lastUpdate) > updateFrequency
                for name, unit in pairs(self.mission.players) do
                    if unit and unit:isExist() then
                        local dist = mist.utils.get3DDist(unit:getPoint(), grunit:getPoint())
                        if dist < self.param.proxDist then
                            self.param.amount = self.param.amount - (1/plycount)

                            if shouldUpdateMsg then
                                local prg = string.format('%.1f',((self.param.maxAmount - self.param.amount)/self.param.maxAmount)*100)
                                trigger.action.outTextForUnit(unit:getID(), 'Progress: '..prg..'%', updateFrequency)
                            end
                        else
                            if shouldUpdateMsg then
                                local m = 'Distance: '
                                if dist>1000 then
                                    local dstkm = string.format('%.2f',dist/1000)
                                    local dstnm = string.format('%.2f',dist/1852)

                                    m = m..dstkm..'km | '..dstnm..'nm'
                                else
                                    local dstft = math.floor(dist/0.3048)
                                    m = m..math.floor(dist)..'m | '..dstft..'ft'
                                end

                                m = m..'\nBearing: '..math.floor(Utils.getBearing(unit:getPoint(), grunit:getPoint()))
                                trigger.action.outTextForUnit(unit:getID(), m, updateFrequency)
                            end
                        end
                    end
                end

                if shouldUpdateMsg then
                    self.param.lastUpdate = timer.getAbsTime()
                end
            end

            if self.param.amount <= 0 then
                self.isComplete = true
                return true
            end
        end
    end

    function ObjEscortGroup:checkFail()
        if not self.isComplete and not self.isFailed then
            local tg = self.param.target
            local gr = Group.getByName(tg.name)
            if not gr or gr:getSize() == 0 then
                self.isFailed = true
            end

            if self.mission.state == Mission.states.new then
                if tg.state == 'enroute' and (timer.getAbsTime() - tg.lastStateTime) >= 7*60 then
                    self.isFailed = true
                end
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjEscortGroup.lua ]]-----------------



-----------------[[ Objectives/ObjFlyToZoneSequence.lua ]]-----------------

ObjFlyToZoneSequence = Objective:new(Objective.types.fly_to_zone_seq)
do
    ObjFlyToZoneSequence.requiredParams = {
        ['waypoints'] = true,
        ['failZones'] = true
    }

    function ObjFlyToZoneSequence:getText()
        local msg = 'Fly route: '
            
        for i,v in ipairs(self.param.waypoints) do
            if v.complete then
                msg = msg..'\n [✓] '..i..'. '..v.zone.name
            else
                msg = msg..'\n --> '..i..'. '..v.zone.name
            end
        end
        return msg
    end

    function ObjFlyToZoneSequence:update()
        if not self.isComplete and not self.isFailed then
            if self.param.failZones[1] then
                for _,zn in ipairs(self.param.failZones[1]) do
                    if zn.side ~= 1 then 
                        self.isFailed = true
                        self.mission.failureReason = zn.name..' is no longer controlled by the enemy.'
                        break
                    end
                end
            end

            if self.param.failZones[2] then
                for _,zn in ipairs(self.param.failZones[2]) do
                    if zn.side ~= 2 then 
                        self.isFailed = true
                        self.mission.failureReason = zn.name..' was lost.'
                        break
                    end
                end
            end

            if not self.isFailed then
                local firstWP = nil
                local nextWP = nil
                for i,leg in ipairs(self.param.waypoints) do
                    if not leg.complete then
                        firstWP = leg
                        nextWP = self.param.waypoints[i+1]
                        break
                    end
                end

                if firstWP then
                    local point = firstWP.zone.zone.point
                    local range = 3000 --meters
                    local allInside = true
                    for p,u in pairs(self.mission.players) do
                        if u and u:isExist() then
                            if Utils.isLanded(u,true) then
                                allInside = false
                                break
                            end
                            
                            local pos = u:getPoint()
                            local dist = mist.utils.get2DDist(point, pos)
                            if dist > range then
                                allInside = false
                                break
                            end
                        end
                    end

                    if allInside then
                        firstWP.complete = true
                        self.mission:pushMessageToPlayers(firstWP.zone.name..' reached')
                        if nextWP then
                            self.mission:pushMessageToPlayers('Next point: '..nextWP.zone.name)
                        end
                    end
                else
                    self.isComplete = true
                    return true
                end
            end
        end
    end

    function ObjFlyToZoneSequence:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.failZones[1] then
                for _,zn in ipairs(self.param.failZones[1]) do
                    if zn.side ~= 1 then 
                        self.isFailed = true
                        break
                    end
                end
            end

            if self.param.failZones[2] then
                for _,zn in ipairs(self.param.failZones[2]) do
                    if zn.side ~= 2 then 
                        self.isFailed = true
                        break
                    end
                end
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjFlyToZoneSequence.lua ]]-----------------



-----------------[[ Objectives/ObjProtectMission.lua ]]-----------------

ObjProtectMission = Objective:new(Objective.types.protect)
do
    ObjProtectMission.requiredParams = {
        ['mis'] = true
    }

    function ObjProtectMission:getText()
        local msg = 'Prevent enemy aircraft from interfering with '..self.param.mis:getMissionName()..' mission.'

        if self.param.mis.info and self.param.mis.info.targetzone then
            msg = msg..'\n Target zone: '..self.param.mis.info.targetzone.name
        end

        msg = msg..'\n Protect players: '
        for i,v in pairs(self.param.mis.players) do
            msg = msg..'\n  '..i
        end
        
        msg = msg..'\n Mission success depends on '..self.param.mis:getMissionName()..' mission success.'
        return msg
    end

    function ObjProtectMission:update()
        if not self.isComplete and not self.isFailed then
            if self.param.mis.state == Mission.states.failed then 
                self.isFailed = true
                self.mission.failureReason = "Failed to protect players of "..self.param.mis.name.." mission."
            end

            if self.param.mis.state == Mission.states.completed then 
                self.isComplete = true
            end
        end
    end

    function ObjProtectMission:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.mis.state == Mission.states.failed then 
                self.isFailed = true
            end

            if self.param.mis.state == Mission.states.completed then 
                if self.mission.state == Mission.states.new or 
                    self.mission.state == Mission.states.preping or 
                    self.mission.state == Mission.states.comencing then
                        
                    self.isFailed = true
                end
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjProtectMission.lua ]]-----------------



-----------------[[ Objectives/ObjReconZone.lua ]]-----------------

ObjReconZone = Objective:new(Objective.types.recon_zone)
do
    ObjReconZone.requiredParams = { 
        ['target'] = true,
        ['failZones'] = true
    }

    function ObjReconZone:getText()
        local msg = 'Conduct a recon mission on '..self.param.target.name..' and return with data to a friendly zone.'

        return msg
    end

    function ObjReconZone:update()
        if not self.isComplete and not self.isFailed then
            if self.param.failZones[1] then
                for _,zn in ipairs(self.param.failZones[1]) do
                    if zn.side ~= 1 then 
                        self.isFailed = true
                        self.mission.failureReason = zn.name..' is no longer controlled by the enemy.'
                        break
                    end
                end
            end

            if self.param.failZones[2] then
                for _,zn in ipairs(self.param.failZones[2]) do
                    if zn.side ~= 2 then 
                        self.isFailed = true
                        break
                    end
                end
            end

            if not self.isFailed then
                if self.param.reconData then
                    self.isComplete = true
                    return true
                end
            end
        end
    end

    function ObjReconZone:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.failZones[1] then
                for _,zn in ipairs(self.param.failZones[1]) do
                    if zn.side ~= 1 then 
                        self.isFailed = true
                        break
                    end
                end
            end

            if self.param.failZones[2] then
                for _,zn in ipairs(self.param.failZones[2]) do
                    if zn.side ~= 2 then 
                        self.isFailed = true
                        break
                    end
                end
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjReconZone.lua ]]-----------------



-----------------[[ Objectives/ObjSupplyZone.lua ]]-----------------

ObjSupplyZone = Objective:new(Objective.types.supply)
do
    ObjSupplyZone.requiredParams = {
        ['amount']=true,
        ['delivered']=true,
        ['tgtzone']=true
    }

    function ObjSupplyZone:getText()
        local msg = 'Deliver '..self.param.amount..' to '..self.param.tgtzone.name..': '
        msg = msg..'\n Progress: '..self.param.delivered..'/'..self.param.amount
        return msg
    end

    function ObjSupplyZone:update()
        if not self.isComplete and not self.isFailed then
            if self.param.delivered >= self.param.amount then
                self.isComplete = true
                return true
            end

            local zn = self.param.tgtzone
            if zn.side ~= 2 then 
                self.isFailed = true
                self.mission.failureReason = zn.name..' was lost.'
                return true
            end
        end
    end

    function ObjSupplyZone:checkFail()
        if not self.isComplete and not self.isFailed then
            local zn = self.param.tgtzone
            if zn.side ~= 2 then 
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjSupplyZone.lua ]]-----------------



-----------------[[ Objectives/ObjExtractSquad.lua ]]-----------------

ObjExtractSquad = Objective:new(Objective.types.extract_squad)
do
    ObjExtractSquad.requiredParams = {
        ['target']=true,
        ['loadedBy']=false,
        ['lastUpdate']= true
    }

    function ObjExtractSquad:getText()
        local infName = PlayerLogistics.getInfantryName(self.param.target.data.type)
        local msg = 'Extract '..infName..' '..self.param.target.name..'\n'
        
        if not self.param.loadedBy then
            local gr = Group.getByName(self.param.target.name)
            if gr and gr:getSize()>0 then
                local point = gr:getUnit(1):getPoint()

                local lat,lon,alt = coord.LOtoLL(point)
                local mgrs = coord.LLtoMGRS(coord.LOtoLL(point))
                msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
                msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
                msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
                msg = msg..'\n Altitude: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
            end
        end

        return msg
    end

    function ObjExtractSquad:update()
        if not self.isComplete and not self.isFailed then

            if self.param.loadedBy then
                self.isComplete = true
                return true
            else
                local target = self.param.target
                
                local gr = Group.getByName(target.name)
                if not gr or gr:getSize()==0 then
                    self.isFailed = true
                    self.mission.failureReason = 'Squad was not rescued in time, and went MIA.'
                    return true
                end
            end

            local updateFrequency = 5 -- seconds
            local shouldUpdateMsg = (timer.getAbsTime() - self.param.lastUpdate) > updateFrequency
            if shouldUpdateMsg then
                for name, unit in pairs(self.mission.players) do
                    if unit and unit:isExist() then
                        local gr = Group.getByName(self.param.target.name)
                        local un = gr:getUnit(1)
                        local dist = mist.utils.get3DDist(unit:getPoint(), un:getPoint())
                        local m = 'Distance: '
                        if dist>1000 then
                            local dstkm = string.format('%.2f',dist/1000)
                            local dstnm = string.format('%.2f',dist/1852)

                            m = m..dstkm..'km | '..dstnm..'nm'
                        else
                            local dstft = math.floor(dist/0.3048)
                            m = m..math.floor(dist)..'m | '..dstft..'ft'
                        end

                        m = m..'\nBearing: '..math.floor(Utils.getBearing(unit:getPoint(), un:getPoint()))           
                        trigger.action.outTextForUnit(unit:getID(), m, updateFrequency)
                    end
                end

                self.param.lastUpdate = timer.getAbsTime()
            end
        end
    end

    function ObjExtractSquad:checkFail()
        if not self.isComplete and not self.isFailed then
            local target = self.param.target
                
            local gr = Group.getByName(target.name)
            if not gr or not gr:isExist() or gr:getSize()==0 then
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjExtractSquad.lua ]]-----------------



-----------------[[ Objectives/ObjExtractPilot.lua ]]-----------------

ObjExtractPilot = Objective:new(Objective.types.extract_pilot)
do
    ObjExtractPilot.requiredParams = {
        ['target']=true,
        ['loadedBy']=false,
        ['lastUpdate']= true
    }

    function ObjExtractPilot:getText()
        local msg = 'Rescue '..self.param.target.name..'\n'
        
        if not self.param.loadedBy then
            
            if self.param.target.pilot:isExist() and 
                self.param.target.pilot:getSize() > 0 and 
                self.param.target.pilot:getUnit(1):isExist() then
                    
                local point = self.param.target.pilot:getUnit(1):getPoint()

                local lat,lon,alt = coord.LOtoLL(point)
                local mgrs = coord.LLtoMGRS(coord.LOtoLL(point))
                msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
                msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
                msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
                msg = msg..'\n Altitude: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
            end
        end

        return msg
    end

    function ObjExtractPilot:update()
        if not self.isComplete and not self.isFailed then

            if self.param.loadedBy then
                self.isComplete = true
                return true
            else
                if not self.param.target.pilot:isExist() or self.param.target.remainingTime <= 0 then
                    self.isFailed = true
                    self.mission.failureReason = 'Pilot was not rescued in time, and went MIA.'
                    return true
                end
            end

            local updateFrequency = 5 -- seconds
            local shouldUpdateMsg = (timer.getAbsTime() - self.param.lastUpdate) > updateFrequency
            if shouldUpdateMsg then
                for name, unit in pairs(self.mission.players) do
                    if unit and unit:isExist() then
                        local gr = Group.getByName(self.param.target.name)
                        if gr and gr:getSize() > 0 then
                            local un = gr:getUnit(1)
                            if un then
                                local dist = mist.utils.get3DDist(unit:getPoint(), un:getPoint())
                                local m = 'Distance: '
                                if dist>1000 then
                                    local dstkm = string.format('%.2f',dist/1000)
                                    local dstnm = string.format('%.2f',dist/1852)

                                    m = m..dstkm..'km | '..dstnm..'nm'
                                else
                                    local dstft = math.floor(dist/0.3048)
                                    m = m..math.floor(dist)..'m | '..dstft..'ft'
                                end

                                m = m..'\nBearing: '..math.floor(Utils.getBearing(unit:getPoint(), un:getPoint()))
                                trigger.action.outTextForUnit(unit:getID(), m, updateFrequency)
                            end
                        end
                    end
                end

                self.param.lastUpdate = timer.getAbsTime()
            end
        end
    end

    function ObjExtractPilot:checkFail()
        if not self.isComplete and not self.isFailed then
            if not self.param.target.pilot:isExist() or self.param.target.remainingTime <= 0 then
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjExtractPilot.lua ]]-----------------



-----------------[[ Objectives/ObjUnloadExtractedPilotOrSquad.lua ]]-----------------

ObjUnloadExtractedPilotOrSquad = Objective:new(Objective.types.unloaded_pilot_or_squad)
do
    ObjUnloadExtractedPilotOrSquad.requiredParams = {
        ['targetZone']=false,
        ['extractObjective']=true,
        ['unloadedAt']=false
    }

    function ObjUnloadExtractedPilotOrSquad:getText()
        local msg = 'Drop off personnel '
        if self.param.targetZone then
            msg = msg..'at '..self.param.targetZone.name..'\n'
        else
            msg = msg..'at a friendly zone\n'
        end

        return msg
    end

    function ObjUnloadExtractedPilotOrSquad:update()
        if not self.isComplete and not self.isFailed then

            if self.param.extractObjective.isComplete and self.param.unloadedAt then
                if self.param.targetZone then
                    if self.param.unloadedAt == self.param.targetZone.name then
                        self.isComplete = true
                        return true
                    else
                        self.isFailed = true
                        self.mission.failureReason = 'Personnel dropped off at wrong zone.'
                        return true
                    end
                else
                    self.isComplete = true
                    return true
                end
            end

            if self.param.extractObjective.isFailed then
                self.isFailed = true
                return true
            end

            if self.param.targetZone and self.param.targetZone.side ~= 2 then
                self.isFailed = true
                self.mission.failureReason = self.param.targetZone.name..' was lost.'
                return true
            end
        end
    end

    function ObjUnloadExtractedPilotOrSquad:checkFail()
        if not self.isComplete and not self.isFailed then

            if self.param.extractObjective.isFailed then
                self.isFailed = true
                return true
            end

            if self.param.targetZone and self.param.targetZone.side ~= 2 then
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjUnloadExtractedPilotOrSquad.lua ]]-----------------



-----------------[[ Objectives/ObjPlayerCloseToZone.lua ]]-----------------

ObjPlayerCloseToZone = Objective:new(Objective.types.player_close_to_zone)
do
    ObjPlayerCloseToZone.requiredParams = {
        ['target']=true,
        ['range'] = true,
        ['amount']= true,
        ['maxAmount'] = true,
        ['lastUpdate']= true
    }

    function ObjPlayerCloseToZone:getText()
        local msg = 'Patrol area around '..self.param.target.name

        local prg = math.floor(((self.param.maxAmount - self.param.amount)/self.param.maxAmount)*100)
        msg = msg.. '\n Progress: '..prg..'%'
        return msg
    end

    function ObjPlayerCloseToZone:update()
        if not self.isComplete and not self.isFailed then

            if self.param.target.side ~= 2 then
                self.isFailed = true
                self.mission.failureReason = self.param.target.name..' was lost.'
                return true
            end

            local plycount = Utils.getTableSize(self.mission.players)
            if plycount == 0 then plycount = 1 end
            local updateFrequency = 5 -- seconds
            local shouldUpdateMsg = (timer.getAbsTime() - self.param.lastUpdate) > updateFrequency
            for name, unit in pairs(self.mission.players) do
                if unit and unit:isExist() and Utils.isInAir(unit) then
                    local dist = mist.utils.get2DDist(unit:getPoint(), self.param.target.zone.point)
                    if dist < self.param.range then
                        self.param.amount = self.param.amount - (1/plycount)

                        if shouldUpdateMsg then
                            local prg = string.format('%.1f',((self.param.maxAmount - self.param.amount)/self.param.maxAmount)*100)
                            trigger.action.outTextForUnit(unit:getID(), '['..self.param.target.name..'] Progress: '..prg..'%', updateFrequency)
                        end
                    end
                end
            end

            if shouldUpdateMsg then
                self.param.lastUpdate = timer.getAbsTime()
            end

            if self.param.amount <= 0 then
                self.isComplete = true
                for name, unit in pairs(self.mission.players) do
                    if unit and unit:isExist() and Utils.isInAir(unit) then
                        trigger.action.outTextForUnit(unit:getID(), '['..self.param.target.name..'] Complete', updateFrequency)
                    end
                end
                return true
            end
        end
    end

    function ObjPlayerCloseToZone:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.target.side ~= 2 then
                self.isFailed = true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjPlayerCloseToZone.lua ]]-----------------



-----------------[[ Objectives/ObjDeploySquad.lua ]]-----------------

ObjDeploySquad = Objective:new(Objective.types.deploy_squad)
do
    ObjDeploySquad.requiredParams = {
        ['squadType']=true,
        ['targetZone']=true,
        ['requiredZoneSide']=true,
        ['unloadedType']=false,
        ['unloadedAt']=false
    }

    function ObjDeploySquad:getText()
        local infName = PlayerLogistics.getInfantryName(self.param.squadType)
        local msg = 'Deploy '..infName..' at '..self.param.targetZone.name
        return msg
    end

    function ObjDeploySquad:update()
        if not self.isComplete and not self.isFailed then

            if self.param.unloadedType and self.param.unloadedAt then
                if self.param.targetZone.name == self.param.unloadedAt then
                    if self.param.squadType == self.param.unloadedType then
                        self.isComplete = true
                        return true
                    end
                end
            end

            if self.param.targetZone.side ~= self.param.requiredZoneSide then
                self.isFailed = true

                local side = ''
                if self.param.requiredZoneSide == 0 then side = 'neutral' 
                elseif self.param.requiredZoneSide == 1 then side = 'controlled by Red'
                elseif self.param.requiredZoneSide == 2 then side = 'controlled by Blue'
                end

                self.mission.failureReason = self.param.targetZone.name..' is no longer '..side
                return true
            end
        end
    end

    function ObjDeploySquad:checkFail()
        if not self.isComplete and not self.isFailed then
            if self.param.targetZone.side ~= self.param.requiredZoneSide then
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjDeploySquad.lua ]]-----------------



-----------------[[ Objectives/ObjRecoverCrate.lua ]]-----------------

ObjRecoverCrate = Objective:new(Objective.types.recover_crate)
do
    ObjRecoverCrate.requiredParams = {
        ['target']=true,
        ['unpackedAt']=false
    }

    function ObjRecoverCrate:getText()
        local msg = 'Recover '..self.param.target.data.name..'\n'
            
        if self.param.target.object:isExist() then
                
            local point = self.param.target.object:getPoint()

            local lat,lon,alt = coord.LOtoLL(point)
            local mgrs = coord.LLtoMGRS(coord.LOtoLL(point))
            msg = msg..'\n DDM:  '.. mist.tostringLL(lat,lon,3)
            msg = msg..'\n DMS:  '.. mist.tostringLL(lat,lon,2,true)
            msg = msg..'\n MGRS: '.. mist.tostringMGRS(mgrs, 5)
            msg = msg..'\n Altitude: '..math.floor(alt)..'m'..' | '..math.floor(alt*3.280839895)..'ft'
        end

        return msg
    end

    function ObjRecoverCrate:update()
        if not self.isComplete and not self.isFailed then
            if self.param.unpackedAt then
                self.isComplete = true
                return true
            end

            if not self.param.target.object:isExist() then
                self.isFailed = true
                self.mission.failureReason = 'Crate was not recovered in time.'
                return true
            end
        end
    end

    function ObjRecoverCrate:checkFail()
        if not self.isComplete and not self.isFailed then
            if not self.param.target.object:isExist() then
                self.isFailed = true
                return true
            end
        end
    end
end

-----------------[[ END OF Objectives/ObjRecoverCrate.lua ]]-----------------



-----------------[[ Missions/Mission.lua ]]-----------------

Mission = {}
do
    Mission.states = {
        new = 'new',                -- mission was just generated and is listed publicly
        preping = 'preping',        -- mission was accepted by a player, was delisted, and player recieved a join code that can be shared
        comencing = 'comencing',    -- a player that is subscribed to the mission has taken off, join code is invalidated
        active = 'active',          -- all players subscribed to the mission have taken off, objective can now be accomplished
        completed = 'completed',    -- mission objective was completed, players need to land to claim rewards
        failed = 'failed'           -- mission lost all players OR mission objective no longer possible to accomplish
    }

    --[[
        new -> preping -> comencing -> active -> completed
         |      |         |           |-> failed
         |      |         |->failed
         |      |->failed
         |->failed
    --]]

    Mission.types = {
        cap_easy = 'cap_easy',          -- fly over zn A-B-A-B-A-B OR destroy few enemy aircraft 
        cap_medium = 'cap_medium',      -- fly over zn A-B-A-B-A-B AND destroy few enemy aircraft -- push list of aircraft within range of target zones
        tarcap = 'tarcap',              -- protect other mission, air kills increase reward
        --tarcap = 'tarcap',            -- update target mission list after all other missions are in

        cas_easy = 'cas_easy',          -- destroy small amount of ground units
        cas_medium = 'cas_medium',      -- destroy large amount of ground units
        cas_hard = 'cas_hard',          -- destroy all defenses at zone A
        bai = 'bai',                    -- destroy any enemy convoy - show "last" location of convoi (BRA or LatLon) update every 30 seconds
        
        sead = 'sead',                  -- destroy any SAM TR or SAM SR at zone A
        dead = 'dead',                  -- destroy all SAM TR or SAM SR, or IR Guided SAM at zone A
        
        strike_veryeasy = 'strike_veryeasy',   -- destroy 1 building
        strike_easy = 'strike_easy',    -- destroy any structure at zone A
        strike_medium = 'strike_medium',-- destroy specific structure at zone A - show LatLon and Alt in mission description
        strike_hard = 'strike_hard',    -- destroy all structures at zone A and turn it neutral
        deep_strike = 'deep_strike',   -- destroy specific structure taken from strike queue - show LatLon and Alt in mission description

        anti_runway = 'anti_runway',  -- drop at least X anti runway bombs on runway zone (if player unit launches correct weapon, track, if agl>10m check if in zone, tally), define list of runway zones somewhere
        
        supply_easy = 'supply_easy',   -- transfer resources to zone A(low supply)
        supply_hard = 'supply_hard',   -- transfer resources to zone A(low supply), high resource number
        escort = 'escort',              -- follow and protect friendly convoy until they get to target OR 10 minutes pass
        csar = 'csar',                  -- extract specific pilot to friendly zone, track friendly pilots ejected
        recon = 'recon',                -- conduct recon
        extraction = 'extraction',  -- extract a deployed squad to friendly zone, generate mission if squad has extractionReady state
        deploy_squad = 'deploy_squad',  -- deploy squad to zone,
        salvage = 'salvage',  -- recover crate to zone,
    }

    Mission.completion_type = {
        any = 'any',
        all = 'all'
    }

    function Mission.getType(misType)
        if misType == Mission.types.cap_easy then
            return CAP_Easy
        elseif misType == Mission.types.cap_medium then
            return CAP_Medium
        elseif misType == Mission.types.cas_easy then
            return CAS_Easy
        elseif misType == Mission.types.cas_medium then
            return CAS_Medium
        elseif misType == Mission.types.cas_hard then
            return CAS_Hard
        elseif misType == Mission.types.sead then
            return SEAD
        elseif misType == Mission.types.supply_easy then
            return Supply_Easy
        elseif misType == Mission.types.supply_hard then
            return Supply_Hard
        elseif misType == Mission.types.strike_veryeasy then
            return Strike_VeryEasy
        elseif misType == Mission.types.strike_easy then
            return Strike_Easy
        elseif misType == Mission.types.strike_medium then
            return Strike_Medium
        elseif misType == Mission.types.strike_hard then
            return Strike_Hard
        elseif misType == Mission.types.deep_strike then
            return Deep_Strike
        elseif misType == Mission.types.dead then
            return DEAD
        elseif misType == Mission.types.escort then
            return Escort
        elseif misType == Mission.types.recon then
            return Recon
        elseif misType == Mission.types.bai then
            return BAI
        elseif misType == Mission.types.anti_runway then
            return Anti_Runway
        elseif misType == Mission.types.csar then
            return CSAR
        elseif misType == Mission.types.extraction then
            return Extraction
        elseif misType == Mission.types.deploy_squad then
            return DeploySquad
        elseif misType == Mission.types.salvage then
            return Salvage
        end
    end

    function Mission:new(id, type, target)
        local expire = math.random(60*15, 60*30)

		local obj = {
            missionID = id,
            type = type,
            name = '',
            description = '',
            failureReason = nil,
            state = Mission.states.new,
            expireTime = expire,
            lastStateTime = timer.getAbsTime(),
            objectives = {},
            completionType = Mission.completion_type.any,
            rewards = {},
            players = {},
            info = {},
            target = target
        }

		setmetatable(obj, self)
		self.__index = self
		
        if obj.getExpireTime then obj.expireTime = obj:getExpireTime() end
        if obj.getMissionName then obj.name = obj:getMissionName() end

        if obj.target and obj.createObjective then 
            obj:createObjective()
        elseif obj.generateObjectives then 
            obj:generateObjectives() 
        end

        if obj.generateRewards then obj:generateRewards() end

		return obj
	end

    function Mission:updateState(newstate)
        env.info('Mission - code'..self.missionID..' updateState state changed from '..self.state..' to '..newstate)
        self.state = newstate
        self.lastStateTime = timer.getAbsTime()
        if self.state == self.states.preping then
            if self.info.targetzone then
                MissionTargetRegistry.addZone(self.info.targetzone.name)
            end
        elseif self.state == self.states.completed or self.state == self.states.failed then
            if self.info.targetzone then
                MissionTargetRegistry.removeZone(self.info.targetzone.name)
            end
        end
    end

    function Mission:pushMessageToPlayer(player, msg, duration)
        if not duration then
            duration = 10
        end

        for name,un in pairs(self.players) do
            if name == player and un and un:isExist() then
                trigger.action.outTextForUnit(un:getID(), msg, duration)
                break
            end
        end
    end

    function Mission:pushMessageToPlayers(msg, duration)
        if not duration then
            duration = 10
        end

        for _,un in pairs(self.players) do
            if un and un:isExist() then
                trigger.action.outTextForUnit(un:getID(), msg, duration)
            end
        end
    end

    function Mission:pushSoundToPlayers(sound)
        for _,un in pairs(self.players) do
            if un and un:isExist() then
                --trigger.action.outSoundForUnit(un:getID(), sound) -- does not work correctly in multiplayer
                trigger.action.outSoundForGroup(un:getGroup():getID(), sound)
            end
        end
    end

    function Mission:removePlayer(player)
        for pl,un in pairs(self.players) do
            if pl == player then
                self.players[pl] = nil
                break
            end
        end
    end

    function Mission:isInstantReward()
        return false
    end

    function Mission:hasPlayers()
        return Utils.getTableSize(self.players) > 0
    end

    function Mission:getPlayerUnit(player)
        return self.players[player]
    end

    function Mission:addPlayer(player, unit)
        self.players[player] = unit
    end

    function Mission:checkFailConditions()
        if self.state == Mission.states.active then return end

        for _,obj in ipairs(self.objectives) do
            local shouldBreak = obj:checkFail()
            
            if shouldBreak then break end
        end
    end

    function Mission:updateObjectives()
        if self.state ~= self.states.active then return end

        for _,obj in ipairs(self.objectives) do
            local shouldBreak = obj:update()

            if obj.isFailed and self.objectiveFailedCallback then self:objectiveFailedCallback(obj) end
            if not obj.isFailed and obj.isComplete and self.objectiveCompletedCallback then self:objectiveCompletedCallback(obj) end

            if shouldBreak then break end
        end
    end

    function Mission:updateIsFailed()
        self:checkFailConditions()

        local allFailed = true
        for _,obj in ipairs(self.objectives) do
            if self.state == Mission.states.new then
                if obj.isFailed then
                    self:updateState(Mission.states.failed)
                    env.info("Mission code"..self.missionID.." objective cancelled:\n"..obj:getText())
                    break
                end
            end

            if self.completionType == Mission.completion_type.all then
                if obj.isFailed then
                    self:updateState(Mission.states.failed)
                    env.info("Mission code"..self.missionID.." (all) objective failed:\n"..obj:getText())
                    break
                end
            end

            if not obj.isFailed then
                allFailed = false
            end
        end

        if self.completionType == Mission.completion_type.any and allFailed then
            self:updateState(Mission.states.failed)
            env.info("Mission code"..self.missionID.." all objectives failed")
        end
    end

    function Mission:updateIsCompleted()
        if self.completionType == self.completion_type.any then
            for _,obj in ipairs(self.objectives) do
                if obj.isComplete then 
                    self:updateState(self.states.completed)
                    env.info("Mission code"..self.missionID.." (any) objective completed:\n"..obj:getText())
                    break
                end
            end
        elseif self.completionType == self.completion_type.all then
            local allComplete = true
            for _,obj in ipairs(self.objectives) do
                if not obj.isComplete then
                    allComplete = false
                    break
                end
            end

            if allComplete then
                self:updateState(self.states.completed)
                env.info("Mission code"..self.missionID.." all objectives complete")
            end
        end
    end

    function Mission:tallyWeapon(weapon)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjBombInsideZone:getType() then
                    for i,v in ipairs(obj.param.targetZone:getRunwayZones()) do
                        if Utils.isInZone(weapon, v.name) then
                            if obj.param.dropped < obj.param.max then
                                obj.param.dropped = obj.param.dropped + 1
                                if obj.param.dropped > obj.param.required then
                                    for _,rew in ipairs(self.rewards) do
                                        if obj.param.bonus[rew.type] then
                                            rew.amount = rew.amount +  obj.param.bonus[rew.type]

                                            if rew.type == PlayerTracker.statTypes.xp then
                                                self:pushMessageToPlayers("Bonus: + "..obj.param.bonus[rew.type]..' XP')
                                            end
                                        end
                                    end
                                end
                            end
                            break
                        end
                    end
                end
            end
        end
    end

    function Mission:tallyHit(hit)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjHitStructure:getType() then
                    if obj.param.target.name == hit:getName() then
                        obj.param.hit = true
                    end
                elseif obj.type == ObjDestroyUnitsWithAttribute:getType() then
                    for _,a in ipairs(obj.param.attr) do
                        if a == 'Buildings' and ZoneCommand and ZoneCommand.staticRegistry[hit:getName()] then
                            obj.param.hits = obj.param.hits + 1
                            break
                        end
                    end
                elseif obj.type == ObjDestroyUnitsWithAttributeAtZone:getType() then
                    local zn = obj.param.tgtzone
                    if zn then
                        local validzone = false
                        if Utils.isInZone(hit, zn.name) then
                            validzone = true
                        else
                            for nm,_ in pairs(zn.built) do
                                local gr = Group.getByName(nm)
                                if gr then
                                    for _,un in ipairs(gr:getUnits()) do
                                        if un:getID() == hit:getID() then
                                            validzone = true
                                            break
                                        end
                                    end
                                end

                                if validzone then break end
                            end
                        end
                        
                        if validzone then
                            for _,a in ipairs(obj.param.attr) do
                                if a == 'Buildings' and ZoneCommand and ZoneCommand.staticRegistry[hit:getName()] then
                                    obj.param.hits = obj.param.hits + 1
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    function Mission:tallyKill(kill)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjDestroyUnitsWithAttribute:getType() then
                    for _,a in ipairs(obj.param.attr) do
                        if kill:hasAttribute(a) then
                            obj.param.killed = obj.param.killed + 1
                            break
                        elseif a == 'Buildings' and ZoneCommand and ZoneCommand.staticRegistry[kill:getName()] then
                            obj.param.killed = obj.param.killed + 1
                            break
                        end
                    end
                elseif obj.type == ObjDestroyStructure:getType() then
                    if obj.param.target.name == kill:getName() then
                        obj.param.killed = true
                    end
                elseif obj.type == ObjDestroyGroup:getType() then
                    if kill.getName then
                        if obj.param.targetUnitNames[kill:getName()] ~= nil then
                            obj.param.targetUnitNames[kill:getName()] = true
                        end
                    end
                elseif obj.type == ObjAirKillBonus:getType() then
                    for _,a in ipairs(obj.param.attr) do
                        if kill:hasAttribute(a) then
                            for _,rew in ipairs(self.rewards) do
                                if obj.param.bonus[rew.type] then
                                    rew.amount = rew.amount +  obj.param.bonus[rew.type]
                                    obj.param.count = obj.param.count + 1
                                    if rew.type == PlayerTracker.statTypes.xp then
                                        self:pushMessageToPlayers("Reward increased: + "..obj.param.bonus[rew.type]..' XP')
                                    end
                                end
                            end
                            break
                        elseif a == 'Buildings' and ZoneCommand and ZoneCommand.staticRegistry[kill:getName()] then
                            for _,rew in ipairs(self.rewards) do
                                if obj.param.bonus[rew.type] then
                                    rew.amount = rew.amount +  obj.param.bonus[rew.type]
                                    obj.param.count = obj.param.count + 1
                                    
                                    if rew.type == PlayerTracker.statTypes.xp then
                                        self:pushMessageToPlayers("Reward increased: + "..obj.param.bonus[rew.type]..' XP')
                                    end
                                end
                            end
                            break
                        end
                    end
                elseif obj.type == ObjDestroyUnitsWithAttributeAtZone:getType() then
                    local zn = obj.param.tgtzone
                    if zn then
                        local validzone = false
                        if Utils.isInZone(kill, zn.name) then
                            validzone = true
                        else
                            for nm,_ in pairs(zn.built) do
                                local gr = Group.getByName(nm)
                                if gr then
                                    for _,un in ipairs(gr:getUnits()) do
                                        if un:getID() == kill:getID() then
                                            validzone = true
                                            break
                                        end
                                    end
                                end

                                if validzone then break end
                            end
                        end
                        
                        if validzone then
                            for _,a in ipairs(obj.param.attr) do
                                if kill:hasAttribute(a) then
                                    obj.param.killed = obj.param.killed + 1
                                    break
                                elseif a == 'Buildings' and ZoneCommand and ZoneCommand.staticRegistry[kill:getName()] then
                                    obj.param.killed = obj.param.killed + 1
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    function Mission:isUnitTypeAllowed(unit)
        return true
    end

    function Mission:tallySupplies(amount, zonename)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjSupplyZone:getType() then
                    if obj.param.tgtzone.name == zonename then
                        obj.param.delivered = obj.param.delivered + amount
                    end
                end
            end
        end
    end

    function Mission:tallyLoadPilot(player, pilot)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjExtractPilot:getType() then
                    if obj.param.target.name == pilot.name then
                        obj.param.loadedBy = player
                    end
                end
            end
        end
    end

    function Mission:tallyUnloadPilot(player, zonename)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjUnloadExtractedPilotOrSquad:getType() then
                    if obj.param.extractObjective.param.loadedBy == player then
                        obj.param.unloadedAt = zonename
                    end
                end
            end
        end
    end

    function Mission:tallyRecon(player, targetzone, analyzezonename)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjReconZone:getType() then
                    if obj.param.target.name == targetzone then
                        obj.param.reconData = targetzone
                    end
                end
            end
        end
    end
    
    function Mission:tallyUnpackCrate(player, zonename, cargo)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjRecoverCrate:getType() then
                    if cargo.name == obj.param.target.data.name then
                        obj.param.unpackedAt = zonename
                    end
                end
            end
        end
    end

    function Mission:tallyLoadSquad(player, squad)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjExtractSquad:getType() then
                    if obj.param.target.name == squad.name then
                        obj.param.loadedBy = player
                    end
                end
            end
        end
    end

    function Mission:tallyUnloadSquad(player, zonename, unloadedType)
        for _,obj in ipairs(self.objectives) do
            if not obj.isComplete and not obj.isFailed then
                if obj.type == ObjUnloadExtractedPilotOrSquad:getType() then
                    if obj.param.extractObjective.param.loadedBy == player and unloadedType == PlayerLogistics.infantryTypes.extractable then
                        obj.param.unloadedAt = zonename
                    end
                elseif obj.type == ObjDeploySquad:getType() then
                    obj.param.unloadedType = unloadedType
                    obj.param.unloadedAt = zonename
                end
            end
        end
    end

    function Mission:getBriefDescription()
        local msg = '~~~~~'..self.name..' ['..self.missionID..']~~~~~\n'..self.description..'\n'

        msg = msg..' Reward:'

        for _,r in ipairs(self.rewards) do
            msg = msg..' ['..r.type..': '..r.amount..']'
        end

        return msg
    end

    function Mission:generateRewards()
        if not self.type then return end
        
        local rewardDef = RewardDefinitions.missions[self.type]
        
        self.rewards = {}
        table.insert(self.rewards, {
            type = PlayerTracker.statTypes.xp,
            amount = math.random(rewardDef.xp.low,rewardDef.xp.high)*50
        })
    end

    function Mission:getDetailedDescription()
        local msg = '['..self.name..']'

        if self.state == Mission.states.comencing or self.state == Mission.states.preping or (not Config.restrictMissionAcceptance) then
            msg = msg..'\nJoin code ['..self.missionID..']'
        end

        msg = msg..'\nReward:'

        for _,r in ipairs(self.rewards) do
            msg = msg..' ['..r.type..': '..r.amount..']'
        end
        msg = msg..'\n'

        if #self.objectives>1 then
            msg = msg..'\nObjectives: '
            if self.completionType == Mission.completion_type.all then
                msg = msg..'(Complete ALL)\n'
            elseif self.completionType == Mission.completion_type.any then
                msg = msg..'(Complete ONE)\n'
            end
        elseif #self.objectives==1 then
            msg = msg..'\nObjective: \n'
        end

        for i,v in ipairs(self.objectives) do
            local obj = v:getText()
            if v.isComplete then 
                obj = '[✓]'..obj
            elseif v.isFailed then
                obj = '[X]'..obj
            else
                obj = '[ ]'..obj 
            end

            msg = msg..'\n'..obj..'\n'
        end

        msg = msg..'\nPlayers:'
        for i,_ in pairs(self.players) do
            msg = msg..'\n  '..i
        end

        return msg
    end
end

-----------------[[ END OF Missions/Mission.lua ]]-----------------



-----------------[[ Missions/CAP_Easy.lua ]]-----------------

CAP_Easy = Mission:new()
do
    function CAP_Easy.canCreate()
        local zoneNum = 0
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront == 0 then 
                zoneNum = zoneNum + 1
            end

            if zoneNum >= 2 then return true end
        end
    end

    function CAP_Easy:getMissionName()
        return 'CAP'
    end

    function CAP_Easy:isUnitTypeAllowed(unit)
        return unit:hasAttribute('Planes')
    end

    function CAP_Easy:createObjective()
        self.completionType = Mission.completion_type.any
        local description = ''
        local zn1 = ZoneCommand.getZoneByName(self.target)

        local patrol1 = ObjPlayerCloseToZone:new()
        patrol1:initialize(self, {
            target = zn1,
            range = 20000,
            amount = 15*60,
            maxAmount = 15*60,
            lastUpdate = 0
        })

        table.insert(self.objectives, patrol1)
        description = description..'   Patrol airspace near '..zn1.name..'\n   OR\n'

        local kills = ObjDestroyUnitsWithAttribute:new()
        kills:initialize(self, {
            attr = {'Planes', 'Helicopters'},
            amount = math.random(2,4),
            killed = 0,
            hits = 0
        })

        table.insert(self.objectives, kills)
        description = description..'   Kill '..kills.param.amount..' aircraft'
        self.description = self.description..description
    end

    function CAP_Easy:generateObjectives()
        self.completionType = Mission.completion_type.any
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront == 0 then
                table.insert(viableZones, zone)
            end
        end
        
        if #viableZones >= 2 then
            local choice1 = math.random(1,#viableZones)
            local zn1 = viableZones[choice1]

            local patrol1 = ObjPlayerCloseToZone:new()
            patrol1:initialize(self, {
                target = zn1,
                range = 20000,
                amount = 15*60,
                maxAmount = 15*60,
                lastUpdate = 0
            })

            table.insert(self.objectives, patrol1)
            description = description..'   Patrol airspace near '..zn1.name..'\n   OR\n'
        end

        local kills = ObjDestroyUnitsWithAttribute:new()
        kills:initialize(self, {
            attr = {'Planes', 'Helicopters'},
            amount = math.random(2,4),
            killed = 0,
            hits = 0
        })

        table.insert(self.objectives, kills)
        description = description..'   Kill '..kills.param.amount..' aircraft'
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CAP_Easy.lua ]]-----------------



-----------------[[ Missions/CAP_Medium.lua ]]-----------------

CAP_Medium = Mission:new()
do
    function CAP_Medium.canCreate()
        local zoneNum = 0
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront == 0 then 
                zoneNum = zoneNum + 1
            end

            if zoneNum >= 2 then return true end
        end
    end

    function CAP_Medium:getMissionName()
        return 'CAP'
    end

    function CAP_Medium:isUnitTypeAllowed(unit)
        return unit:hasAttribute('Planes')
    end

    function CAP_Medium:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn1 = ZoneCommand.getZoneByName(self.target[1])
        local zn2 = ZoneCommand.getZoneByName(self.target[2])

        local patrol1 = ObjPlayerCloseToZone:new()
        patrol1:initialize(self, {
            target = zn1,
            range = 20000,
            amount = 10*60,
            maxAmount = 10*60,
            lastUpdate = 0
        })

        table.insert(self.objectives, patrol1)

        local patrol2 = ObjPlayerCloseToZone:new()
        patrol2:initialize(self, {
            target = zn2,
            range = 20000,
            amount = 10*60,
            maxAmount = 10*60,
            lastUpdate = 0
        })

        table.insert(self.objectives, patrol2)
        description = description..'   Patrol airspace near '..zn1.name..' and '..zn2.name..'\n'

        local rewardDef = RewardDefinitions.missions[self.type]

        local kills = ObjAirKillBonus:new()
        kills:initialize(self, {
            attr = {'Planes', 'Helicopters'},
            bonus = {
                [PlayerTracker.statTypes.xp] = rewardDef.xp.boost
            },
            count = 0,
            linkedObjectives = {patrol1, patrol2}
        })

        table.insert(self.objectives, kills)
        description = description..'   Aircraft kills increase reward'

        self.description = self.description..description
    end

    function CAP_Medium:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront == 0 then
                table.insert(viableZones, zone)
            end
        end
        
        if #viableZones >= 2 then
            local choice1 = math.random(1,#viableZones)
            local zn1 = viableZones[choice1]
            table.remove(viableZones,choice1)
            local choice2 = math.random(1,#viableZones)
            local zn2 = viableZones[choice2]

            local patrol1 = ObjPlayerCloseToZone:new()
            patrol1:initialize(self, {
                target = zn1,
                range = 20000,
                amount = 10*60,
                maxAmount = 10*60,
                lastUpdate = 0
            })

            table.insert(self.objectives, patrol1)

            local patrol2 = ObjPlayerCloseToZone:new()
            patrol2:initialize(self, {
                target = zn2,
                range = 20000,
                amount = 10*60,
                maxAmount = 10*60,
                lastUpdate = 0
            })

            table.insert(self.objectives, patrol2)
            description = description..'   Patrol airspace near '..zn1.name..' and '..zn2.name..'\n'

            local rewardDef = RewardDefinitions.missions[self.type]

            local kills = ObjAirKillBonus:new()
            kills:initialize(self, {
                attr = {'Planes', 'Helicopters'},
                bonus = {
                    [PlayerTracker.statTypes.xp] = rewardDef.xp.boost
                },
                count = 0,
                linkedObjectives = {patrol1, patrol2}
            })

            table.insert(self.objectives, kills)
            description = description..'   Aircraft kills increase reward'
        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CAP_Medium.lua ]]-----------------



-----------------[[ Missions/CAS_Easy.lua ]]-----------------

CAS_Easy = Mission:new()
do
    function CAS_Easy.canCreate()
        return true
    end

    function CAS_Easy:getMissionName()
        return 'CAS'
    end

    function CAS_Easy:createObjective()
        env.info("ERROR - Can't create CAS_Easy on demand")
    end
    
    function CAS_Easy:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local kills = ObjDestroyUnitsWithAttribute:new()
        kills:initialize(self, {
            attr = {'Ground Units'},
            amount = math.random(3,6),
            killed = 0,
            hits = 0
        })

        table.insert(self.objectives, kills)
        description = description..'   Destroy '..kills.param.amount..' Ground Units'
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CAS_Easy.lua ]]-----------------



-----------------[[ Missions/CAS_Medium.lua ]]-----------------

CAS_Medium = Mission:new()
do
    function CAS_Medium.canCreate()
        return true
    end

    function CAS_Medium:getMissionName()
        return 'CAS'
    end

    function CAS_Medium:createObjective()
        env.info("ERROR - Can't create CAS_Medium on demand")
    end

    function CAS_Medium:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local kills = ObjDestroyUnitsWithAttribute:new()
        kills:initialize(self, {
            attr = {'Ground Units'},
            amount = math.random(8,12),
            killed = 0,
            hits = 0
        })

        table.insert(self.objectives, kills)
        description = description..'   Destroy '..kills.param.amount..' Ground Units'
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CAS_Medium.lua ]]-----------------



-----------------[[ Missions/CAS_Hard.lua ]]-----------------

CAS_Hard = Mission:new()
do
    function CAS_Hard.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront and zone.distToFront <=1 and zone:hasUnitWithAttributeOnSide({"Ground Units"}, 1, 6) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function CAS_Hard:getMissionName()
        return 'CAS'
    end

    function CAS_Hard:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local kill = ObjDestroyUnitsWithAttributeAtZone:new()
        kill:initialize(self, {
            attr = {"Ground Units"},
            amount = 1,
            killed = 0,
            tgtzone = zn,
            hits = 0
        })
        table.insert(self.objectives, kill)

        local clear = ObjClearZoneOfUnitsWithAttribute:new()
        clear:initialize(self, {
            attr = {"Ground Units"},
            tgtzone = zn
        })
        table.insert(self.objectives, clear)

        description = description..'   Clear '..zn.name..' of ground units'
        self.info = {
            targetzone = zn
        }
        self.description = self.description..description
    end

    function CAS_Hard:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone:hasUnitWithAttributeOnSide({"Ground Units"}, 1, 6) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end

        if #viableZones == 0 then
            for _,zone in pairs(ZoneCommand.getAllZones()) do
                if zone.side == 1 and zone.distToFront == 1 and zone:hasUnitWithAttributeOnSide({"Ground Units"}, 1, 6) then
                    if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                        table.insert(viableZones, zone)
                    end
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local kill = ObjDestroyUnitsWithAttributeAtZone:new()
            kill:initialize(self, {
                attr = {"Ground Units"},
                amount = 1,
                killed = 0,
                tgtzone = zn,
                hits = 0
            })
            table.insert(self.objectives, kill)

            local clear = ObjClearZoneOfUnitsWithAttribute:new()
            clear:initialize(self, {
                attr = {"Ground Units"},
                tgtzone = zn
            })
            table.insert(self.objectives, clear)

            description = description..'   Clear '..zn.name..' of ground units'
            self.info = {
                targetzone = zn
            }
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CAS_Hard.lua ]]-----------------



-----------------[[ Missions/SEAD.lua ]]-----------------

SEAD = Mission:new()
do
    function SEAD.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront and zone.distToFront <=1 and zone:hasSAMRadarOnSide(1) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function SEAD:getMissionName()
        return 'SEAD'
    end

    function SEAD:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local kill = ObjDestroyUnitsWithAttributeAtZone:new()
        kill:initialize(self, {
            attr = {'SAM SR','SAM TR'},
            amount = 1,
            killed = 0,
            tgtzone = zn,
            hits = 0
        })

        table.insert(self.objectives, kill)
        description = description..'   Destroy '..kill.param.amount..' Search Radar or Track Radar at '..zn.name
        self.info = {
            targetzone = zn
        }
        self.description = self.description..description
    end

    function SEAD:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone:hasSAMRadarOnSide(1) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end

        if #viableZones == 0 then
            for _,zone in pairs(ZoneCommand.getAllZones()) do
                if zone.side == 1 and zone.distToFront == 1 and zone:hasSAMRadarOnSide(1) then
                    if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                        table.insert(viableZones, zone)
                    end
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local kill = ObjDestroyUnitsWithAttributeAtZone:new()
            kill:initialize(self, {
                attr = {'SAM SR','SAM TR'},
                amount = 1,
                killed = 0,
                tgtzone = zn,
                hits = 0
            })

            table.insert(self.objectives, kill)
            description = description..'   Destroy '..kill.param.amount..' Search Radar or Track Radar at '..zn.name
            self.info = {
                targetzone = zn
            }
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/SEAD.lua ]]-----------------



-----------------[[ Missions/DEAD.lua ]]-----------------

DEAD = Mission:new()
do
    function DEAD.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront and zone.distToFront <=1 and zone:hasUnitWithAttributeOnSide({"Air Defence"}, 1, 4) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function DEAD:getMissionName()
        return 'DEAD'
    end

    function DEAD:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local kill = ObjDestroyUnitsWithAttributeAtZone:new()
        kill:initialize(self, {
            attr = {"Air Defence"},
            amount = 1,
            killed = 0,
            tgtzone = zn,
            hits = 0
        })
        table.insert(self.objectives, kill)

        local clear = ObjClearZoneOfUnitsWithAttribute:new()
        clear:initialize(self, {
            attr = {"Air Defence"},
            tgtzone = zn
        })
        table.insert(self.objectives, clear)

        description = description..'   Clear '..zn.name..' of any Air Defenses'
        self.info = {
            targetzone = zn
        }
        self.description = self.description..description
    end

    function DEAD:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront <=1 and zone:hasUnitWithAttributeOnSide({"Air Defence"}, 1, 4) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local kill = ObjDestroyUnitsWithAttributeAtZone:new()
            kill:initialize(self, {
                attr = {"Air Defence"},
                amount = 1,
                killed = 0,
                tgtzone = zn,
                hits = 0
            })
            table.insert(self.objectives, kill)

            local clear = ObjClearZoneOfUnitsWithAttribute:new()
            clear:initialize(self, {
                attr = {"Air Defence"},
                tgtzone = zn
            })
            table.insert(self.objectives, clear)

            description = description..'   Clear '..zn.name..' of any Air Defenses'
            self.info = {
                targetzone = zn
            }
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/DEAD.lua ]]-----------------



-----------------[[ Missions/Supply_Easy.lua ]]-----------------

Supply_Easy = Mission:new()
do
    function Supply_Easy.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront and zone.distToFront <=1 and zone:criticalOnSupplies() then
                return true
            end
        end
    end

    function Supply_Easy:getMissionName()
        return "Supply delivery"
    end

    function Supply_Easy:isInstantReward()
        return true
    end

    function Supply_Easy:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].supplies
        end
    end

    function Supply_Easy:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local deliver = ObjSupplyZone:new()
        deliver:initialize(self, {
            amount = math.random(2,6)*250,
            delivered = 0,
            tgtzone = zn
        })
        
        table.insert(self.objectives, deliver)
        description = description..'   Deliver '..deliver.param.amount..' of supplies to '..zn.name
        self.info = {
            targetzone = zn
        }

        self.description = self.description..description
    end

    function Supply_Easy:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''

        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront <=1 and zone:criticalOnSupplies() then
                table.insert(viableZones, zone)
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local deliver = ObjSupplyZone:new()
            deliver:initialize(self, {
                amount = math.random(2,6)*250,
                delivered = 0,
                tgtzone = zn
            })
            
            table.insert(self.objectives, deliver)
            description = description..'   Deliver '..deliver.param.amount..' of supplies to '..zn.name
            self.info = {
                targetzone = zn
            }
        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Supply_Easy.lua ]]-----------------



-----------------[[ Missions/Supply_Hard.lua ]]-----------------

Supply_Hard = Mission:new()
do
    function Supply_Hard.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront and zone.distToFront <=1 and zone:criticalOnSupplies() then
                return true
            end
        end
    end

    function Supply_Hard:getMissionName()
        return "Supply delivery"
    end

    function Supply_Hard:isInstantReward()
        return true
    end

    function Supply_Hard:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].supplies
        end
    end

    function Supply_Hard:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''

        local zn = ZoneCommand.getZoneByName(self.target)
        
        local deliver = ObjSupplyZone:new()
        deliver:initialize(self, {
            amount = math.random(18,24)*250,
            delivered = 0,
            tgtzone = zn
        })
        
        table.insert(self.objectives, deliver)
        description = description..'   Deliver '..deliver.param.amount..' of supplies to '..zn.name
        self.info = {
            targetzone = zn
        }

        self.description = self.description..description
    end

    function Supply_Hard:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''

        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 2 and zone.distToFront == 0 and zone:criticalOnSupplies() then
                table.insert(viableZones, zone)
            end
        end

        if #viableZones == 0 then
            for _,zone in pairs(ZoneCommand.getAllZones()) do
                if zone.side == 2 and zone.distToFront == 1 and zone:criticalOnSupplies() then
                    table.insert(viableZones, zone)
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local deliver = ObjSupplyZone:new()
            deliver:initialize(self, {
                amount = math.random(18,24)*250,
                delivered = 0,
                tgtzone = zn
            })
            
            table.insert(self.objectives, deliver)
            description = description..'   Deliver '..deliver.param.amount..' of supplies to '..zn.name
            self.info = {
                targetzone = zn
            }
        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Supply_Hard.lua ]]-----------------



-----------------[[ Missions/Strike_VeryEasy.lua ]]-----------------

Strike_VeryEasy = Mission:new()
do
    function Strike_VeryEasy.canCreate()
        return true
    end

    function Strike_VeryEasy:getMissionName()
        return 'Strike'
    end

    function Strike_VeryEasy:createObjective()
        env.info("ERROR - Can't create Strike_VeryEasy on demand")
    end

    function Strike_VeryEasy:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local kills = ObjDestroyUnitsWithAttribute:new()
        kills:initialize(self, {
            attr = {'Buildings'},
            amount = 1,
            killed = 0,
            hits = 0
        })

        table.insert(self.objectives, kills)
        description = description..'   Destroy '..kills.param.amount..' building'
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Strike_VeryEasy.lua ]]-----------------



-----------------[[ Missions/Strike_Easy.lua ]]-----------------

Strike_Easy = Mission:new()
do
    function Strike_Easy.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront and zone.distToFront <=1 and zone:hasUnitWithAttributeOnSide({'Buildings'}, 1) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function Strike_Easy:getMissionName()
        return 'Strike'
    end

    function Strike_Easy:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local kill = ObjDestroyUnitsWithAttributeAtZone:new()
        kill:initialize(self, {
            attr = {'Buildings'},
            amount = 1,
            killed = 0,
            hits = 0,
            tgtzone = zn
        })

        table.insert(self.objectives, kill)
        description = description..'   Destroy '..kill.param.amount..' Building at '..zn.name
        self.info = {
            targetzone = zn
        }
        self.description = self.description..description
    end

    function Strike_Easy:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone:hasUnitWithAttributeOnSide({'Buildings'}, 1) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end

        if #viableZones == 0 then
            for _,zone in pairs(ZoneCommand.getAllZones()) do
                if zone.side == 1 and zone.distToFront == 1 and zone:hasUnitWithAttributeOnSide({'Buildings'}, 1) then
                    if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                        table.insert(viableZones, zone)
                    end
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local kill = ObjDestroyUnitsWithAttributeAtZone:new()
            kill:initialize(self, {
                attr = {'Buildings'},
                amount = 1,
                killed = 0,
                hits = 0,
                tgtzone = zn
            })

            table.insert(self.objectives, kill)
            description = description..'   Destroy '..kill.param.amount..' Building at '..zn.name
            self.info = {
                targetzone = zn
            }
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Strike_Easy.lua ]]-----------------



-----------------[[ Missions/Strike_Medium.lua ]]-----------------

Strike_Medium = Mission:new()
do
    function Strike_Medium.canCreate()
        return MissionTargetRegistry.strikeTargetsAvailable(1, false)
    end

    function Strike_Medium:getMissionName()
        return 'Strike'
    end

    function Strike_Medium:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
       
        local zn = ZoneCommand.getZoneByName(self.target.zone)

        local tgt = {
            data = zn:getProductByName(self.target.product),
            zone = zn
        }
        
        if tgt then
            local chozenTarget = tgt.data
            local zn = tgt.zone

            local hit = ObjHitStructure:new()
            hit:initialize(self, {
                target = chozenTarget,
                tgtzone = zn,
                hit = false
            })
            
            table.insert(self.objectives, hit)

            local kill = ObjDestroyStructure:new()
            kill:initialize(self, {
                target = chozenTarget,
                tgtzone = zn
            })

            table.insert(self.objectives, kill)
            description = description..'   Destroy '..chozenTarget.display..' at '..zn.name
            self.info = {
                targetzone = zn
            }

        end
        self.description = self.description..description
    end

    function Strike_Medium:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
       
        local tgt = MissionTargetRegistry.getRandomStrikeTarget(1, false)
        
        if tgt then
            local chozenTarget = tgt.data
            local zn = tgt.zone

            local hit = ObjHitStructure:new()
            hit:initialize(self, {
                target = chozenTarget,
                tgtzone = zn,
                hit = false
            })
            
            table.insert(self.objectives, hit)

            local kill = ObjDestroyStructure:new()
            kill:initialize(self, {
                target = chozenTarget,
                tgtzone = zn
            })

            table.insert(self.objectives, kill)
            description = description..'   Destroy '..chozenTarget.display..' at '..zn.name
            self.info = {
                targetzone = zn
            }

        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Strike_Medium.lua ]]-----------------



-----------------[[ Missions/Strike_Hard.lua ]]-----------------

Strike_Hard = Mission:new()
do
    function Strike_Hard.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront and zone.distToFront <=1 and zone:hasUnitWithAttributeOnSide({"Buildings"}, 1, 3) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function Strike_Hard:getMissionName()
        return 'Strike'
    end

    function Strike_Hard:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local zn = ZoneCommand.getZoneByName(self.target)
        
        local kill = ObjDestroyUnitsWithAttributeAtZone:new()
        kill:initialize(self, { 
            attr = {"Buildings"},
            amount = 1,
            killed = 0,
            hits = 0,
            tgtzone = zn
        })

        table.insert(self.objectives, kill)

        local clear = ObjClearZoneOfUnitsWithAttribute:new()
        clear:initialize(self, {
            attr = {"Buildings"},
            tgtzone = zn
        })
        table.insert(self.objectives, clear)

        description = description..'   Destroy every structure at '..zn.name
        self.info = {
            targetzone = zn
        }

        self.description = self.description..description
    end

    function Strike_Hard:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone:hasUnitWithAttributeOnSide({"Buildings"}, 1, 3) then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end

        if #viableZones == 0 then
            for _,zone in pairs(ZoneCommand.getAllZones()) do
                if zone.side == 1 and zone.distToFront == 1 and zone:hasUnitWithAttributeOnSide({"Buildings"}, 1, 3) then
                    if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                        table.insert(viableZones, zone)
                    end
                end
            end
        end
        
        if #viableZones > 0 then
            local choice = math.random(1,#viableZones)
            local zn = viableZones[choice]
            
            local kill = ObjDestroyUnitsWithAttributeAtZone:new()
            kill:initialize(self, { 
                attr = {"Buildings"},
                amount = 1,
                killed = 0,
                hits = 0,
                tgtzone = zn
            })

            table.insert(self.objectives, kill)

            local clear = ObjClearZoneOfUnitsWithAttribute:new()
            clear:initialize(self, {
                attr = {"Buildings"},
                tgtzone = zn
            })
            table.insert(self.objectives, clear)

            description = description..'   Destroy every structure at '..zn.name
            self.info = {
                targetzone = zn
            }
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Strike_Hard.lua ]]-----------------



-----------------[[ Missions/Deep_Strike.lua ]]-----------------

Deep_Strike = Mission:new()
do
    function Deep_Strike.canCreate()
        return MissionTargetRegistry.strikeTargetsAvailable(1, true)
    end

    function Deep_Strike:getMissionName()
        return 'Deep Strike'
    end

    function Deep_Strike:createObjective()
        env.info("ERROR - Can't create Deep_Strike on demand")
    end

    function Deep_Strike:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
       
        local tgt = MissionTargetRegistry.getRandomStrikeTarget(1, true)
        
        if tgt then
            local chozenTarget = tgt.data
            local zn = tgt.zone

            local hit = ObjHitStructure:new()
            hit:initialize(self, {
                target = chozenTarget,
                tgtzone = zn,
                hit = false
            })

            table.insert(self.objectives, hit)

            local kill = ObjDestroyStructure:new()
            kill:initialize(self, {
                target = chozenTarget,
                tgtzone = zn
            })

            table.insert(self.objectives, kill)
            description = description..'   Destroy '..chozenTarget.display..' at '..zn.name
            self.info = {
                targetzone = zn
            }

        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Deep_Strike.lua ]]-----------------



-----------------[[ Missions/Escort.lua ]]-----------------

Escort = Mission:new()
do    
    function Escort.canCreate()
        local currentTime = timer.getAbsTime()
        for _,gr in pairs(DependencyManager.get("GroupMonitor").groups) do
            if gr.product.side == 2 and gr.product.type == 'mission' and (gr.product.missionType == 'supply_convoy' or gr.product.missionType == 'assault')  then
                local z = gr.target
                if z.distToFront == 0 and z.side~= 2 then
                    if gr.state == nil or gr.state == 'started' or (gr.state == 'enroute' and (currentTime - gr.lastStateTime < 7*60)) then
                        return true
                    end
                end
            end
        end
    end

    function Escort:getMissionName()
        return "Escort convoy"
    end

    function Escort:isUnitTypeAllowed(unit)
        return unit:hasAttribute('Helicopters')
    end

    function Escort:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''

        local convoy = DependencyManager.get("GroupMonitor"):getGroup(self.target)
        
        local escort = ObjEscortGroup:new()
        escort:initialize(self, {
            maxAmount = 60*7,
            amount = 60*7,
            proxDist = 400,
            target = convoy,
            lastUpdate = timer.getAbsTime()
        })
        
        table.insert(self.objectives, escort)

        local nearzone = ""
        local gr = Group.getByName(convoy.name)
        if gr and gr:getSize()>0 then
            local un = gr:getUnit(1)
            local closest = ZoneCommand.getClosestZoneToPoint(un:getPoint())
            if closest then
                nearzone = ' near '..closest.name..''
            end
        end

        description = description..'   Escort convoy'..nearzone..' on route to their destination'

        self.description = self.description..description
    end

    function Escort:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''

        local currentTime = timer.getAbsTime()
        local viableConvoys = {}
        for _,gr in pairs(DependencyManager.get("GroupMonitor").groups) do
            if gr.product.side == 2 and gr.product.type == 'mission' and (gr.product.missionType == 'supply_convoy' or gr.product.missionType == 'assault')  then
                local z = gr.target
                if z.distToFront == 0 and z.side ~= 2 then
                    if gr.state == nil or gr.state == 'started' or (gr.state == 'enroute' and (currentTime - gr.lastStateTime < 7*60)) then
                        table.insert(viableConvoys, gr)
                    end
                end
            end
        end
        
        if #viableConvoys > 0 then
            local choice = math.random(1,#viableConvoys)
            local convoy = viableConvoys[choice]
            
            local escort = ObjEscortGroup:new()
            escort:initialize(self, {
                maxAmount = 60*7,
                amount = 60*7,
                proxDist = 400,
                target = convoy,
                lastUpdate = timer.getAbsTime()
            })
            
            table.insert(self.objectives, escort)

            local nearzone = ""
            local gr = Group.getByName(convoy.name)
            if gr and gr:getSize()>0 then
                local un = gr:getUnit(1)
                local closest = ZoneCommand.getClosestZoneToPoint(un:getPoint())
                if closest then
                    nearzone = ' near '..closest.name..''
                end
            end

            description = description..'   Escort convoy'..nearzone..' on route to their destination'
            --description = description..'\n   Target will be assigned after accepting mission'

        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Escort.lua ]]-----------------



-----------------[[ Missions/TARCAP.lua ]]-----------------

TARCAP = Mission:new()
do
    TARCAP.relevantMissions = {
        Mission.types.cas_hard,
        Mission.types.dead,
        Mission.types.sead,
        Mission.types.strike_easy,
        Mission.types.strike_hard
    }

    function TARCAP:new(id, type, activeMissions)
        self = Mission.new(self, id, type)
        self:generateObjectivesOverload(activeMissions)
		return self
	end

    function TARCAP.canCreate(activeMissions)
        for _,mis in pairs(activeMissions) do
            for _,tp in ipairs(TARCAP.relevantMissions) do
                if mis.type == tp then return true end
            end
        end
    end

    function TARCAP:getMissionName()
        return 'TARCAP'
    end

    function TARCAP:isUnitTypeAllowed(unit)
        return unit:hasAttribute('Planes')
    end

    function TARCAP:generateObjectivesOverload(activeMissions)
        self.completionType = Mission.completion_type.any
        local description = ''
        local viableMissions = {}
        for _,mis in pairs(activeMissions) do
            for _,tp in ipairs(TARCAP.relevantMissions) do
                if mis.type == tp then
                    table.insert(viableMissions, mis)
                    break
                end
            end
        end
        
        if #viableMissions >= 1 then
            local choice = math.random(1,#viableMissions)
            local mis = viableMissions[choice]

            local protect = ObjProtectMission:new()
            protect:initialize(self, {
                mis = mis
            })

            table.insert(self.objectives, protect)
            description = description..'   Prevent enemy aircraft from interfering with friendly '..mis:getMissionName()..' mission'
            if mis.info and mis.info.targetzone then
                description = description..' at '..mis.info.targetzone.name
            end

            local rewardDef = RewardDefinitions.missions[self.type]

            local kills = ObjAirKillBonus:new()
            kills:initialize(self, {
                attr = {'Planes'},
                bonus = {
                    [PlayerTracker.statTypes.xp] = rewardDef.xp.boost
                },
                count = 0,
                linkedObjectives = {protect}
            })
    
            table.insert(self.objectives, kills)
            
            description = description..'\n   Aircraft kills increase reward'
        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/TARCAP.lua ]]-----------------



-----------------[[ Missions/Recon.lua ]]-----------------

Recon = Mission:new()
do
    function Recon.canCreate()
        local zoneNum = 0
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone.revealTime == 0 then 
                return true
            end
        end
    end

    function Recon:getMissionName()
        return 'Recon'
    end

    function Recon:isUnitTypeAllowed(unit)
        local tp = unit:getDesc().typeName
        local st = ReconManager.getAircraftStats(tp)
        return st.canRecon
    end

    function Recon:isInstantReward()
        return true
    end

    function Recon:createObjective()
        self.completionType = Mission.completion_type.any
        local description = ''

        local zn1 = ZoneCommand.getZoneByName(self.target)

        local recon = ObjReconZone:new()
        recon:initialize(self, {
            target = zn1,
            failZones = {
                [1] = {zn1}
            }
        })

        table.insert(self.objectives, recon)
        description = description..'   Observe enemies at '..zn1.name..'\n'

        self.description = self.description..description
    end

    function Recon:generateObjectives()
        self.completionType = Mission.completion_type.any
        local description = ''
        local viableZones = {}
        local secondaryViableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront == 0 and zone.revealTime == 0 then
                table.insert(viableZones, zone)
            end
        end

        if #viableZones > 0 then
            local choice1 = math.random(1,#viableZones)
            local zn1 = viableZones[choice1]

            local recon = ObjReconZone:new()
            recon:initialize(self, {
                target = zn1,
                failZones = {
                    [1] = {zn1}
                }
            })

            table.insert(self.objectives, recon)
            description = description..'   Observe enemies at '..zn1.name..'\n'
        end

        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Recon.lua ]]-----------------



-----------------[[ Missions/BAI.lua ]]-----------------

BAI = Mission:new()
do
    function BAI.canCreate()
        return MissionTargetRegistry.baiTargetsAvailable(1)
    end

    function BAI:getMissionName()
        return 'BAI'
    end

    function BAI:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
       
        local tgt = DependencyManager.get("GroupMonitor"):getGroup(self.target)
        
        if tgt then
            local gr = Group.getByName(tgt.name)
            if gr and gr:getSize()>0 then
                local units = {}
                for i,v in ipairs(gr:getUnits()) do
                    units[v:getName()] = false
                end

                local kill = ObjDestroyGroup:new() 
                kill:initialize(self, {
                    target = tgt,
                    targetUnitNames = units,
                    lastUpdate = timer.getAbsTime()
                })

                table.insert(self.objectives, kill)

                local nearzone = ""
                local un = gr:getUnit(1)
                local closest = ZoneCommand.getClosestZoneToPoint(un:getPoint())
                if closest then
                    nearzone = ' near '..closest.name..''
                end

                description = description..'   Destroy '..tgt.product.display..nearzone..' before it reaches its destination.'
            end

            MissionTargetRegistry.removeBaiTarget(tgt)
        end
        self.description = self.description..description
    end

    function BAI:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
       
        local tgt = MissionTargetRegistry.getRandomBaiTarget(1)
        
        if tgt then

            local gr = Group.getByName(tgt.name)
            if gr and gr:getSize()>0 then
                local units = {}
                for i,v in ipairs(gr:getUnits()) do
                    units[v:getName()] = false
                end

                local kill = ObjDestroyGroup:new() 
                kill:initialize(self, {
                    target = tgt,
                    targetUnitNames = units,
                    lastUpdate = timer.getAbsTime()
                })

                table.insert(self.objectives, kill)

                local nearzone = ""
                local un = gr:getUnit(1)
                local closest = ZoneCommand.getClosestZoneToPoint(un:getPoint())
                if closest then
                    nearzone = ' near '..closest.name..''
                end

                description = description..'   Destroy '..tgt.product.display..nearzone..' before it reaches its destination.'
            end

            MissionTargetRegistry.removeBaiTarget(tgt)
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/BAI.lua ]]-----------------



-----------------[[ Missions/Anti_Runway.lua ]]-----------------

Anti_Runway = Mission:new()
do
    function Anti_Runway.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront <=2 and zone:hasRunway() then
                    return true
            end
        end
    end

    function Anti_Runway:getMissionName()
        return 'Runway Attack'
    end

    function Anti_Runway:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
       
        local tgt = ZoneCommand.getZoneByName(self.target)

        local rewardDef = RewardDefinitions.missions[self.type]

        local bomb = ObjBombInsideZone:new()
        bomb:initialize(self,{
            targetZone = tgt,
            max = 20,
            required = 5,
            dropped = 0,
            isFinishStarted = false,
            bonus = {
                [PlayerTracker.statTypes.xp] = rewardDef.xp.boost
            }
        })

        table.insert(self.objectives, bomb)
        description = description..'   Bomb runway at '..bomb.param.targetZone.name
        self.description = self.description..description
    end

    function Anti_Runway:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        local viableZones = {}
       
        local tgts = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.side == 1 and zone.distToFront <=2 and zone:hasRunway() then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(tgts, zone)
                end
            end
        end
        
        if #tgts > 0 then
            local tgt = tgts[math.random(1,#tgts)]

            local rewardDef = RewardDefinitions.missions[self.type]

            local bomb = ObjBombInsideZone:new()
            bomb:initialize(self,{
                targetZone = tgt,
                max = 20,
                required = 5,
                dropped = 0,
                isFinishStarted = false,
                bonus = {
                    [PlayerTracker.statTypes.xp] = rewardDef.xp.boost
                }
            })

            table.insert(self.objectives, bomb)
            description = description..'   Bomb runway at '..bomb.param.targetZone.name
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Anti_Runway.lua ]]-----------------



-----------------[[ Missions/CSAR.lua ]]-----------------

CSAR = Mission:new()
do
    function CSAR.canCreate()
        return MissionTargetRegistry.pilotsAvailableToExtract()
    end

    function CSAR:getMissionName()
        return 'CSAR'
    end

    function CSAR:isInstantReward()
        return true
    end

    function CSAR:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].personCapacity and PlayerLogistics.allowedTypes[unitType].personCapacity > 0
        end
    end

    function CSAR:createObjective()
        env.info("ERROR - Can't create CSAR on demand")
    end

    function CSAR:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        if MissionTargetRegistry.pilotsAvailableToExtract() then
            local tgt = MissionTargetRegistry.getRandomPilot()
            
            local extract = ObjExtractPilot:new()
            extract:initialize(self, {
                target = tgt,
                loadedBy = nil,
                lastUpdate = timer.getAbsTime()
            })
            table.insert(self.objectives, extract)

            local unload = ObjUnloadExtractedPilotOrSquad:new()
            unload:initialize(self, {
                extractObjective = extract
            })
            table.insert(self.objectives, unload)

            local nearzone = ''
            local closest = ZoneCommand.getClosestZoneToPoint(tgt.pilot:getUnit(1):getPoint())
            if closest then
                nearzone = ' near '..closest.name..''
            end

            description = description..'   Rescue '..tgt.name..nearzone..' and deliver them to a friendly zone'
            --local mgrs = coord.LLtoMGRS(coord.LOtoLL(tgt.pilot:getUnit(1):getPoint()))
            --local grid = mist.tostringMGRS(mgrs, 2):gsub(' ','')
            --description = description..' ['..grid..']'
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/CSAR.lua ]]-----------------



-----------------[[ Missions/Extraction.lua ]]-----------------

Extraction = Mission:new()
do
    function Extraction.canCreate()
        return MissionTargetRegistry.squadsReadyToExtract(2)
    end

    function Extraction:getMissionName()
        return 'Extraction'
    end

    function Extraction:isInstantReward()
        return true
    end
    
    function Extraction:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].personCapacity
        end
    end

    function Extraction:generateObjectives()
        env.info("ERROR - Can't create Extraction on demand")
    end

    function Extraction:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        if MissionTargetRegistry.squadsReadyToExtract(2) then
            local tgt = MissionTargetRegistry.getRandomSquad(2)
            if tgt then
                local extract = ObjExtractSquad:new()
                extract:initialize(self, {
                    target = tgt,
                    loadedBy = nil,
                    lastUpdate = timer.getAbsTime()
                })
                table.insert(self.objectives, extract)

                local unload = ObjUnloadExtractedPilotOrSquad:new()
                unload:initialize(self, {
                    extractObjective = extract
                })
                table.insert(self.objectives, unload)

                local infName = PlayerLogistics.getInfantryName(tgt.data.type)

                
                local nearzone = ''
                local gr = Group.getByName(tgt.name)
                if gr and gr:isExist() and gr:getSize()>0 then
                    local un = gr:getUnit(1)
                    local closest = ZoneCommand.getClosestZoneToPoint(un:getPoint())
                    if closest then
                        nearzone = ' near '..closest.name..''
                    end
                    --local mgrs = coord.LLtoMGRS(coord.LOtoLL(un:getPoint()))
                    --local grid = mist.tostringMGRS(mgrs, 2):gsub(' ','')
                    --description = description..' ['..grid..']'
                end

                description = description..'   Extract '..infName..nearzone..' to a friendly zone'
            end
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Extraction.lua ]]-----------------



-----------------[[ Missions/DeploySquad.lua ]]-----------------

DeploySquad = Mission:new()
do
    function DeploySquad.canCreate()
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.distToFront and zone.distToFront == 0 then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    return true
                end
            end
        end
    end

    function DeploySquad:getMissionName()
        return 'Deploy infantry'
    end

    function DeploySquad:isInstantReward()
        local friendlyDeployments = {
            [PlayerLogistics.infantryTypes.engineer] = true,
        }

        if self.objectives and self.objectives[1] then
            local sqType = self.objectives[1].param.squadType
            if friendlyDeployments[sqType] then
                return true
            end
        end

        return false
    end
    
    function DeploySquad:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].personCapacity
        end
    end

    function DeploySquad:createObjective()
        self.completionType = Mission.completion_type.all
        local description = ''


        local tgt = ZoneCommand.getZoneByName(self.target)
        if tgt then
            local squadType = nil

            if tgt.side == 0 then
                squadType = PlayerLogistics.infantryTypes.capture
            elseif tgt.side == 1 then
                if math.random()>0.5 then
                    squadType = PlayerLogistics.infantryTypes.sabotage
                else
                    squadType = PlayerLogistics.infantryTypes.spy
                end
            elseif tgt.side == 2 then
                squadType = PlayerLogistics.infantryTypes.engineer
            end

            local deploy = ObjDeploySquad:new()
            deploy:initialize(self, {
                squadType = squadType,
                targetZone = tgt,
                requiredZoneSide = tgt.side,
                unloadedType = nil,
                unloadedAt = nil
            })
            table.insert(self.objectives, deploy)

            local infName = PlayerLogistics.getInfantryName(squadType)

            description = description..'   Deploy '..infName..' to '..tgt.name
            
            self.info = {
                targetzone = tgt
            }
        end
        self.description = self.description..description
    end

    function DeploySquad:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''

        local viableZones = {}
        for _,zone in pairs(ZoneCommand.getAllZones()) do
            if zone.distToFront and zone.distToFront == 0 then
                if not MissionTargetRegistry.isZoneTargeted(zone.name) then
                    table.insert(viableZones, zone)
                end
            end
        end

        if #viableZones > 0 then
            local tgt = viableZones[math.random(1,#viableZones)]
            if tgt then
                local squadType = nil

                if tgt.side == 0 then
                    squadType = PlayerLogistics.infantryTypes.capture
                elseif tgt.side == 1 then
                    if math.random()>0.5 then
                        squadType = PlayerLogistics.infantryTypes.sabotage
                    else
                        squadType = PlayerLogistics.infantryTypes.spy
                    end
                elseif tgt.side == 2 then
                    squadType = PlayerLogistics.infantryTypes.engineer
                end

                local deploy = ObjDeploySquad:new()
                deploy:initialize(self, {
                    squadType = squadType,
                    targetZone = tgt,
                    requiredZoneSide = tgt.side,
                    unloadedType = nil,
                    unloadedAt = nil
                })
                table.insert(self.objectives, deploy)

                local infName = PlayerLogistics.getInfantryName(squadType)

                description = description..'   Deploy '..infName..' to '..tgt.name
                
                self.info = {
                    targetzone = tgt
                }
            end
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/DeploySquad.lua ]]-----------------



-----------------[[ Missions/Salvage.lua ]]-----------------

Salvage = Mission:new()
do
    function Salvage.canCreate()
        local plcontext = DependencyManager.get("PlayerLogistics")
        for cname, cdata in pairs(plcontext.trackedBoxes) do
            local cobj = StaticObject.getByName(cname)
            if cdata.isSalvage and cdata.lifetime >=30*60 and cobj and cobj:isExist() and Utils.isLanded(cobj) then
                return true
            end
        end

        return false
    end

    function Salvage:getMissionName()
        return 'Salvage'
    end

    function Salvage:isInstantReward()
        return true
    end
    
    function Salvage:isUnitTypeAllowed(unit)
        if PlayerLogistics then
            local unitType = unit:getDesc()['typeName']
            return PlayerLogistics.allowedTypes[unitType] and PlayerLogistics.allowedTypes[unitType].sling
        end
    end

    function Salvage:createObjective()
        env.info("ERROR - Can't create Salvage on demand")
    end

    function Salvage:generateObjectives()
        self.completionType = Mission.completion_type.all
        local description = ''
        
        local plcontext = DependencyManager.get("PlayerLogistics")
        local viableBoxes = {}
        for cname, cdata in pairs(plcontext.trackedBoxes) do
            local cobj = StaticObject.getByName(cname) or Unit.getByName(cname)
            if cdata.isSalvage and cdata.lifetime >=30*60 and cobj and cobj:isExist() and Utils.isLanded(cobj) then
                table.insert(viableBoxes, {data = cdata, object = cobj})
            end
        end

        if #viableBoxes>0 then
            local tgt = viableBoxes[math.random(1,#viableBoxes)]
            if tgt then
                local recover = ObjRecoverCrate:new()
                recover:initialize(self, {
                    target = tgt,
                    unpackedAt = nil
                })
                table.insert(self.objectives, recover)

                local nearzone = ""
                local closest = ZoneCommand.getClosestZoneToPoint(tgt.object:getPoint())
                if closest then
                    nearzone = ' near '..closest.name
                end

                description = description..'   Recover abandoned crate'..nearzone..' to a friendly zone'
            end
        end
        self.description = self.description..description
    end
end

-----------------[[ END OF Missions/Salvage.lua ]]-----------------



-----------------[[ RewardDefinitions.lua ]]-----------------

RewardDefinitions = {}

do
    RewardDefinitions.missions = {
      [Mission.types.cap_easy]        = { xp = { low = 10, high = 20, boost = 0   } },
      [Mission.types.cap_medium]      = { xp = { low = 10, high = 20, boost = 100 } },
      [Mission.types.tarcap]          = { xp = { low = 10, high = 10, boost = 150 } },
      [Mission.types.cas_easy]        = { xp = { low = 10, high = 20, boost = 0   } },
      [Mission.types.cas_medium]      = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.cas_hard]        = { xp = { low = 30, high = 40, boost = 0   } },
      [Mission.types.bai]             = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.sead]            = { xp = { low = 10, high = 20, boost = 0   } },
      [Mission.types.dead]            = { xp = { low = 30, high = 40, boost = 0   } },
      [Mission.types.strike_veryeasy] = { xp = { low = 5,  high = 10, boost = 0   } },
      [Mission.types.strike_easy]     = { xp = { low = 10, high = 20, boost = 0   } },
      [Mission.types.strike_medium]   = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.strike_hard]     = { xp = { low = 30, high = 40, boost = 0   } },
      [Mission.types.deep_strike]     = { xp = { low = 30, high = 40, boost = 0   } },
      [Mission.types.anti_runway]     = { xp = { low = 20, high = 30, boost = 25  } },
      [Mission.types.supply_easy]     = { xp = { low = 10, high = 20, boost = 0   } },
      [Mission.types.supply_hard]     = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.escort]          = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.recon]           = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.csar]            = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.extraction]      = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.deploy_squad]    = { xp = { low = 20, high = 30, boost = 0   } },
      [Mission.types.salvage]         = { xp = { low = 20, high = 30, boost = 0   } }
    }

    RewardDefinitions.actions = {
      pilotExtract = 100,
      squadDeploy = 150,
      squadExtract = 150,
      supplyRatio = 0.06,
      supplyBoost = 0.5,
      recon = 150
    }
end

-----------------[[ END OF RewardDefinitions.lua ]]-----------------



-----------------[[ MissionTracker.lua ]]-----------------

MissionTracker = {}
do
    MissionTracker.maxMissionCount = {
        [Mission.types.cap_easy] = 2,
        [Mission.types.cap_medium] = 1,
        [Mission.types.cas_easy] = 2,
        [Mission.types.cas_medium] = 1,
        [Mission.types.cas_hard] = 1,
        [Mission.types.sead] = 3,
        [Mission.types.supply_easy] = 3,
        [Mission.types.supply_hard] = 1,
        [Mission.types.strike_veryeasy] = 2,
        [Mission.types.strike_easy] = 1,
        [Mission.types.strike_medium] = 3,
        [Mission.types.strike_hard] = 1,
        [Mission.types.dead] = 1,
        [Mission.types.escort] = 2,
        [Mission.types.tarcap] = 1,
        [Mission.types.deep_strike] = 3,
        [Mission.types.recon] = 3,
        [Mission.types.bai] = 1,
        [Mission.types.anti_runway] = 2,
        [Mission.types.csar] = 1,
        [Mission.types.extraction] = 1,
        [Mission.types.deploy_squad] = 5,
        [Mission.types.salvage] = 3,
    }

    if Config.missions then
        for i,v in pairs(Config.missions) do
            if MissionTracker.maxMissionCount[i] then
                MissionTracker.maxMissionCount[i] = v
            end
        end
    end

    MissionTracker.missionBoardSize = Config.missionBoardSize or 15

	function MissionTracker:new(boardPos)
		local obj = {}
        obj.groupMenus = {}
        obj.missionIDPool = {}
        obj.missionBoard = {}
        obj.activeMissions = {}
        obj.missionBoardPos = boardPos
		
		setmetatable(obj, self)
		self.__index = self

        DependencyManager.get("MarkerCommands"):addCommand('list', function(event, _, state) 
            if event.initiator then
                state:printMissionBoard(event.initiator:getID(), nil, event.initiator:getGroup():getName())
            elseif world.getPlayer() then
                local unit = world.getPlayer()
                state:printMissionBoard(unit:getID(), nil, event.initiator:getGroup():getName())
            end
            return true
        end, nil, obj)

        DependencyManager.get("MarkerCommands"):addCommand('active', function(event, _, state) 
            if event.initiator then
                state:printActiveMission(event.initiator:getID(), nil, event.initiator:getPlayerName())
            elseif world.getPlayer() then
                state:printActiveMission(nil, nil, world.getPlayer():getPlayerName())
            end
            return true
        end, nil, obj)

        DependencyManager.get("MarkerCommands"):addCommand('accept',function(event, code, state) 
            local numcode = tonumber(code)
            if not numcode or numcode<1000 or numcode > 9999 then return false end

            local player = ''
            local unit = nil
            if event.initiator then 
                player = event.initiator:getPlayerName()
                unit = event.initiator
            elseif world.getPlayer() then
                player = world.getPlayer():getPlayerName()
                unit = world.getPlayer()
            end

            return state:activateMission(numcode, player, unit)
        end, true, obj)

        DependencyManager.get("MarkerCommands"):addCommand('join',function(event, code, state) 
            local numcode = tonumber(code)
            if not numcode or numcode<1000 or numcode > 9999 then return false end

            local player = ''
            local unit = nil
            if event.initiator then 
                player = event.initiator:getPlayerName()
                unit = event.initiator
            elseif world.getPlayer() then
                player = world.getPlayer():getPlayerName()
                unit = world.getPlayer()
            end

            return state:joinMission(numcode, player, unit)
        end, true, obj)

        DependencyManager.get("MarkerCommands"):addCommand('leave',function(event, _, state) 
            local player = ''
            if event.initiator then 
                player = event.initiator:getPlayerName()
            elseif world.getPlayer() then
                player = world.getPlayer():getPlayerName()
            end

            return state:leaveMission(player)
        end, nil, obj)

        obj:menuSetup()
		obj:start()
        
		DependencyManager.register("MissionTracker", obj)
		return obj
	end

    function MissionTracker:menuSetup()
        MenuRegistry.register(2, function(event, context)
            if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player then
					local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()

                    if context.groupMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, context.groupMenus[groupid])
                        context.groupMenus[groupid] = nil
                    end

                    if not context.groupMenus[groupid] then
                        local menu = missionCommands.addSubMenuForGroup(groupid, 'Missions')
                        --missionCommands.addCommandForGroup(groupid, 'List Missions', menu, Utils.log(context.printMissionBoard), context, nil, groupid, groupname)
                        --missionCommands.addCommandForGroup(groupid, 'Active Mission', menu, Utils.log(context.printActiveMission), context, nil, groupid, nil, groupname)
                        missionCommands.addCommandForGroup(groupid, 'Mission', menu, Utils.log(context.printActiveMissionOrMissionBoard), context, groupid, groupname)
                        
                        local dial = missionCommands.addSubMenuForGroup(groupid, 'Dial Code', menu)
                        for i1=1,5,1 do
                            local digit1 = missionCommands.addSubMenuForGroup(groupid, i1..'___', dial)
                            for i2=1,5,1 do
                                local digit2 = missionCommands.addSubMenuForGroup(groupid, i1..i2..'__', digit1)
                                for i3=1,5,1 do
                                    local digit3 = missionCommands.addSubMenuForGroup(groupid, i1..i2..i3..'_', digit2)
                                    for i4=1,5,1 do
                                        local code = tonumber(i1..i2..i3..i4)
                                        local digit4 = missionCommands.addCommandForGroup(groupid, i1..i2..i3..i4, digit3, Utils.log(context.activateOrJoinMissionForGroup), context, code, groupname)
                                    end
                                end
                            end
                        end
                        
                        missionCommands.addCommandForGroup(groupid, 'Start', menu, Utils.log(context.forceStartMission), context, player)
                        local leavemenu = missionCommands.addSubMenuForGroup(groupid, 'Leave', menu)
                        missionCommands.addCommandForGroup(groupid, 'Confirm to leave mission', leavemenu, Utils.log(context.leaveMission), context, player)
                        missionCommands.addCommandForGroup(groupid, 'Cancel', leavemenu, function() end)
                        
                        context.groupMenus[groupid] = menu
                    end
				end
            end
        end, self)
    end

    function MissionTracker:printActiveMissionOrMissionBoard(groupid, groupname)
        env.info('MissionTracker - printActiveMissionOrMissionBoard: '..tostring(groupname)..' requested group print.')
        local gr = Group.getByName(groupname)
        for i,v in ipairs(gr:getUnits()) do
            if v.getPlayerName and v:getPlayerName() then 
                local mis = nil
                for i2,v2 in pairs(self.activeMissions) do
                    for pl,un in pairs(v2.players) do
                        if pl == v:getPlayerName() then
                            mis = v2
                            break
                        end
                    end

                    if mis then break end
                end

                if mis then 
                    self:printActiveMission(v:getID(), gr:getID(), v:getPlayerName())
                else
                    self:printMissionBoard(v:getID(), gr:getID(), groupname)
                end
            end
        end
    end

    function MissionTracker:printActiveMission(unitid, groupid, playername, groupname)
        if not playername and groupname then
            env.info('MissionTracker - printActiveMission: '..tostring(groupname)..' requested group print.')
            local gr = Group.getByName(groupname)
            for i,v in ipairs(gr:getUnits()) do
                if v.getPlayerName and v:getPlayerName() then 
                    self:printActiveMission(v:getID(), gr:getID(), v:getPlayerName())
                end
            end
            return
        end

        local mis = nil
        for i,v in pairs(self.activeMissions) do
            for pl,un in pairs(v.players) do
                if pl == playername then
                    mis = v
                    break
                end
            end

            if mis then break end
        end

        local msg = ''
        if mis then
            msg = mis:getDetailedDescription()
        else
            msg = 'No active mission'
        end

        if unitid then
            trigger.action.outTextForUnit(unitid, msg, 30)
        elseif groupid then
            trigger.action.outTextForGroup(groupid, msg, 30)
        else
            --trigger.action.outText(msg, 30)
        end
    end

    function MissionTracker:printMissionBoard(unitid, groupid, groupname)
        local gr = Group.getByName(groupname)
        local un = gr:getUnit(1)

        local msg = 'Mission Board\n'
        local empty = true
        local invalidCount = 0
        for i,v in pairs(self.missionBoard) do
            if v:isUnitTypeAllowed(un) then
                empty = false
                msg = msg..'\n'..v:getBriefDescription()..'\n'
            else
                invalidCount = invalidCount + 1
            end
        end

        if empty then 
            msg = msg..'\n No missions available'
        end

        if invalidCount > 0 then
            msg = msg..'\n'..invalidCount..' additional missions are not compatible with current aircraft\n'
        end

        if unitid then
            trigger.action.outTextForUnit(unitid, msg, 30)
        elseif groupid then
            trigger.action.outTextForGroup(groupid, msg, 30)
        else
            --trigger.action.outText(msg, 30)
        end
    end

    function MissionTracker:getNewMissionID()
        if #self.missionIDPool == 0 then
            for i=1111,5555,1 do 
                if not tostring(i):find('[06789]') then
                    if not self.missionBoard[i] and not self.activeMissions[i] then
                        table.insert(self.missionIDPool, i)
                    end
                end
            end
        end
        
        local choice = math.random(1,#self.missionIDPool)
        local newId = self.missionIDPool[choice]
        table.remove(self.missionIDPool,choice)
        return newId
    end
	
	function MissionTracker:start()
        timer.scheduleFunction(function(params, time)
            for i,v in ipairs(coalition.getPlayers(2)) do
                if v and v:isExist() and not Utils.isInAir(v) and v.getPlayerName and v:getPlayerName() then
                    local player = v:getPlayerName()
                    local cfg = DependencyManager.get("PlayerTracker"):getPlayerConfig(player)
                    if cfg.noMissionWarning == true then
                        local hasMis = false
                        for _,mis in pairs(params.context.activeMissions) do
                            if mis.players[player] then
                                hasMis = true
                                break
                            end
                        end

                        if not hasMis then
                            trigger.action.outTextForUnit(v:getID(), "No mission selected", 9)
                        end
                    end
                end
            end

            return time+10
        end, {context = self}, timer.getTime()+10)

        if self.missionBoardPos then
            trigger.action.textToAll(-1,99999, self.missionBoardPos, {0,0,0,0.8}, {1,1,1,0.5}, 10, true, "")
        end

        timer.scheduleFunction(function(param, time)
            for code,mis in pairs(param.missionBoard) do
                if timer.getAbsTime() - mis.lastStateTime > mis.expireTime then
                    param.missionBoard[code].state = Mission.states.failed
                    param.missionBoard[code] = nil
                    env.info('Mission code'..code..' expired.')
                else
                    mis:updateIsFailed()
                    if mis.state == Mission.states.failed then
                        param.missionBoard[code]=nil
                        env.info('Mission code'..code..' canceled due to objectives failed')
                        --trigger.action.outTextForCoalition(2,'Mission ['..mis.missionID..'] '..mis.name..' was cancelled',5)
                    end
                end
            end

            --param:fillEmptySlots()

            param:updateMapMarkup()

            return time+1
        end, self, timer.getTime()+1)

        timer.scheduleFunction(function(param, time)
            for code,mis in pairs(param.activeMissions) do
                -- check if players exist and in same unit as when joined
                -- remove from mission if false
                for pl,un in pairs(mis.players) do
                    if not un or
                        not un:isExist() then

                        mis:removePlayer(pl)
                        env.info('Mission code'..code..' removing player '..pl..', unit no longer exists')
                    end
                end
                
                -- check if mission has 0 players, delete mission if true
                if not mis:hasPlayers() then
                    param.activeMissions[code]:updateState(Mission.states.failed)
                    param.activeMissions[code] = nil
                    env.info('Mission code'..code..' canceled due to no players')
                else
                    --check if mission objectives can still be completed, cancel mission if not
                    mis:updateIsFailed()
                    mis:updateIsCompleted()

                    if mis.state == Mission.states.preping then
                        --check if any player in air and move to comencing if true
                        for pl,un in pairs(mis.players) do
                            if Utils.isInAir(un) then
                                mis:updateState(Mission.states.comencing)
                                mis:pushMessageToPlayers(mis.name..' mission is starting')
                                break
                            end
                        end
                    elseif mis.state == Mission.states.comencing then
                        --check if all players in air and move to active if true
                        --if all players landed, move to preping
                        local allInAir = true
                        local allLanded = true
                        for pl,un in pairs(mis.players) do
                            if Utils.isInAir(un) then
                                allLanded = false
                            else
                                allInAir = false
                            end
                        end

                        if allLanded then
                            mis:updateState(Mission.states.preping)
                            mis:pushMessageToPlayers(mis.name..' mission is in the prep phase')
                        end

                        if allInAir then
                            mis:updateState(Mission.states.active)
                            mis:pushMessageToPlayers(mis.name..' mission has started')
                            local missionstatus = mis:getDetailedDescription()
                            mis:pushMessageToPlayers(missionstatus)
                        end
                    elseif mis.state == Mission.states.active then
                        mis:updateObjectives()
                    elseif mis.state == Mission.states.completed then
                        local isInstant = mis:isInstantReward()
                        if isInstant then
                            mis:pushMessageToPlayers(mis.name..' mission complete.', 60)
                        else
                            mis:pushMessageToPlayers(mis.name..' mission complete. Land to claim rewards.', 60)
                        end 

                        for _,reward in ipairs(mis.rewards) do
                            for p,_ in pairs(mis.players) do
                                local finalAmount = reward.amount
                                if reward.type == PlayerTracker.statTypes.xp then
                                    finalAmount = math.floor(finalAmount * DependencyManager.get("PlayerTracker"):getPlayerMultiplier(p))
                                end

                                if isInstant then
                                    DependencyManager.get("PlayerTracker"):addStat(p, finalAmount, reward.type)
                                    mis:pushMessageToPlayer(p, '+'..finalAmount..' '..reward.type)
                                else
                                    DependencyManager.get("PlayerTracker"):addTempStat(p, finalAmount, reward.type)
                                end
                            end
                        end

                        for p,u in pairs(mis.players) do
                            DependencyManager.get("PlayerTracker"):addRankRewards(p,u, not isInstant)
                        end

                        mis:pushSoundToPlayers("success.ogg")
                        param.activeMissions[code] = nil
                        env.info('Mission code'..code..' removed due to completion')
                    elseif mis.state == Mission.states.failed then
                        local msg = mis.name..' mission failed.'
                        if mis.failureReason then
                            msg = msg..'\n'..mis.failureReason
                        end

                        mis:pushMessageToPlayers(msg, 60)

                        mis:pushSoundToPlayers("fail.ogg")
                        param.activeMissions[code] = nil
                        env.info('Mission code'..code..' removed due to failure')
                    end
                end
            end

            return time+1
        end, self, timer.getTime()+1)

        local ev = {}
		ev.context = self
		function ev:onEvent(event)
			if event.id == world.event.S_EVENT_KILL and event.initiator and event.target and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player and 
                    event.initiator:isExist() and
                    event.initiator.getCoalition and 
                    event.target.getCoalition and 
                    event.initiator:getCoalition() ~= event.target:getCoalition() then
					    self.context:tallyKill(player, event.target)
				end
			end

            if event.id == world.event.S_EVENT_HIT and event.initiator and event.target and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player and 
                    event.initiator:isExist() and
                    event.initiator.getCoalition and 
                    event.target.getCoalition and 
                    event.initiator:getCoalition() ~= event.target:getCoalition() then
					    self.context:tallyHit(player, event.target)
				end
			end

            if event.id == world.event.S_EVENT_SHOT and event.initiator and event.weapon and event.initiator.getPlayerName then
                local player = event.initiator:getPlayerName()
				if player and event.initiator:isExist() and event.weapon:isExist() then
                    self.context:tallyWeapon(player, event.weapon)
                end
            end
		end
		
		world.addEventHandler(ev)
	end

    function MissionTracker:updateMapMarkup()
        if not self.missionBoardPos then return end

        local msg = 'Mission Board\n'
        local empty = true
        for i,v in pairs(self.missionBoard) do
            empty = false
            msg = msg..'\n'..v:getBriefDescription()..'\n'
        end

        if empty then 
            msg = msg..'\n No missions available'
        end

        trigger.action.setMarkupText(99999,msg)
    end

    function MissionTracker:fillEmptySlots()
        local misCount = Utils.getTableSize(self.missionBoard)
        local toGen = MissionTracker.missionBoardSize-misCount
        if toGen > 0 then
            local validMissions = {}
            for _,v in pairs(Mission.types) do
                if self:canCreateMission(v) then
                    table.insert(validMissions,v)
                end
            end

            if #validMissions > 0  then
                for i=1,toGen,1 do
                    if #validMissions > 0 then
                        local choice = math.random(1,#validMissions)
                        local misType = validMissions[choice]
                        table.remove(validMissions, choice)
                        self:generateMission(misType)
                    else
                        break
                    end
                end
            end
        end
    end 

    function MissionTracker:createMission(misType, target)
        local misid = self:getNewMissionID()
        env.info('MissionTracker - creating mission type ['..misType..'] id code['..misid..']')
        
        local type = Mission.getType(misType)
        local newmis = nil
        if type then
            newmis = type:new(misid, misType, target)
        end 

        if not newmis or #newmis.objectives == 0 then return end

        return newmis
    end

    function MissionTracker:generateMission(misType)
        
        local newmis = self:createMission(misType)
        
        if not newmis then return end

        self.missionBoard[newmis.missionID] = newmis
        env.info('MissionTracker - generated mission id code'..newmis.missionID..' \n'..newmis.description)
        --trigger.action.outTextForCoalition(2,'New mission available: '..newmis.name,5)
    end

    function MissionTracker:tallyWeapon(player, weapon)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    if Weapon.getCategoryEx(weapon) == Weapon.Category.BOMB then
                        timer.scheduleFunction(function (params, time)
                            if not params.weapon:isExist() then
                                return nil -- weapon despawned
                            end

                            local alt = Utils.getAGL(params.weapon)
                            if alt < 5 then 
                                params.mission:tallyWeapon(params.weapon)
                                return nil
                            end

                            if alt < 20 then
                                return time+0.01
                            end

                            return time+0.1
                        end, {player = player, weapon = weapon, mission = m}, timer.getTime()+0.1)
                    end
                end
            end
        end
    end

    function MissionTracker:tallyKill(player,kill)
        env.info("MissionTracker - tallyKill: "..player.." killed "..kill:getName())
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyKill(kill)
                end
            end
        end
    end    
    
    function MissionTracker:tallyHit(player,hit)
        env.info("MissionTracker - tallyHit: "..player.." hit "..hit:getName())
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyHit(hit)
                end
            end
        end
    end

    function MissionTracker:tallySupplies(player, amount, zonename)
        env.info("MissionTracker - tallySupplies: "..player.." delivered "..amount.." of supplies to "..zonename)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallySupplies(amount, zonename)
                end
            end
        end
    end

    function MissionTracker:tallyLoadPilot(player, pilot)
        env.info("MissionTracker - tallyLoadPilot: "..player.." loaded pilot "..pilot.name)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyLoadPilot(player, pilot)
                end
            end
        end
    end

    function MissionTracker:tallyUnloadPilot(player, zonename)
        env.info("MissionTracker - tallyUnloadPilot: "..player.." unloaded pilots at "..zonename)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyUnloadPilot(player, zonename)
                end
            end
        end
    end

    function MissionTracker:tallyLoadSquad(player, squad)
        env.info("MissionTracker - tallyLoadSquad: "..player.." loaded squad "..squad.name)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyLoadSquad(player, squad)
                end
            end
        end
    end

    function MissionTracker:tallyUnloadSquad(player, zonename, squadType)
        env.info("MissionTracker - tallyUnloadSquad: "..player.." unloaded "..squadType.." squad at "..zonename)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyUnloadSquad(player, zonename, squadType)
                end
            end
        end
    end

    function MissionTracker:tallyRecon(player, targetzone, analyzezonename)
        env.info("MissionTracker - tallyRecon: "..player.." analyzed "..targetzone.." recon data at "..analyzezonename)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyRecon(player, targetzone, analyzezonename)
                end
            end
        end
    end

    function MissionTracker:tallyUnpackCrate(player, zonename, cargo)
        env.info("MissionTracker - tallyUnpackCrate: "..player.." unpacked "..cargo.name.." at "..zonename)
        for _,m in pairs(self.activeMissions) do
            if m.players[player] then
                if m.state == Mission.states.active then
                    m:tallyUnpackCrate(player, zonename, cargo)
                end
            end
        end
    end

    function MissionTracker:activateOrJoinMissionForGroup(code, groupname)
        if groupname then
            env.info('MissionTracker - activateOrJoinMissionForGroup: '..tostring(groupname)..' requested activate or join '..code)
            local gr = Group.getByName(groupname)
            for i,v in ipairs(gr:getUnits()) do
                if v.getPlayerName and v:getPlayerName() then 
                    local mis = self.activeMissions[code]
                    if mis then 
                        self:joinMission(code, v:getPlayerName(), v)
                    else
                        self:activateMission(code, v:getPlayerName(), v)
                    end
                    return
                end
            end
        end
    end

    function MissionTracker:activateMission(code, player, unit)
        if Config.restrictMissionAcceptance then
            if not unit or not unit:isExist() or not Utils.isLanded(unit, true) then 
                if unit and unit:isExist() then trigger.action.outTextForUnit(unit:getID(), 'Can only accept mission while landed', 5) end
                return false 
            end

            local zn = ZoneCommand.getZoneOfUnit(unit:getName())
            if not zn then 
                zn = CarrierCommand.getCarrierOfUnit(unit:getName())
            end

            if not zn then 
                zn = FARPCommand.getFARPOfUnit(unit:getName())
                if zn and not zn:hasFeature(PlayerLogistics.buildables.satuplink) then
                    trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Satellite Uplink. Can not accept missions.', 10)
                    return false
                end
            end

            if not zn or zn.side ~= unit:getCoalition() then 
                trigger.action.outTextForUnit(unit:getID(), 'Can only accept mission while inside friendly zone', 5)
                return false 
            end
        end

        for c,m in pairs(self.activeMissions) do
            if m:getPlayerUnit(player) then 
                trigger.action.outTextForUnit(unit:getID(), 'A mission is already active.', 5)
                return false 
            end
        end

        local mis = self.missionBoard[code]
        if not mis then 
            trigger.action.outTextForUnit(unit:getID(), 'Invalid mission code', 5)
            return false 
        end

        if mis.state ~= Mission.states.new then
            trigger.action.outTextForUnit(unit:getID(), 'Invalid mission.', 5)
            return false 
        end

        if not mis:isUnitTypeAllowed(unit) then
            trigger.action.outTextForUnit(unit:getID(), 'Current aircraft type is not compatible with this mission.', 5)
            return false
        end

        self.missionBoard[code] = nil
        
        trigger.action.outTextForCoalition(2,'Mission ['..mis.missionID..'] '..mis.name..' was accepted by '..player,5)
        mis:updateState(Mission.states.preping)
        mis.missionID = self:getNewMissionID()
        mis:addPlayer(player, unit)

        mis:pushMessageToPlayers(mis.name..' accepted.\nJoin code: ['..mis.missionID..']')

        env.info('Mission code'..code..' changed to code'..mis.missionID)
        env.info('Mission code'..mis.missionID..' accepted by '..player)
        self.activeMissions[mis.missionID] = mis
        return true
    end

    function MissionTracker:joinMission(code, player, unit)
        if Config.restrictMissionAcceptance then
            if not unit or not unit:isExist() or not Utils.isLanded(unit, true) then 
                if unit and unit:isExist() then trigger.action.outTextForUnit(unit:getID(), 'Can only join mission while landed', 5) end
                return false
            end

            local zn = ZoneCommand.getZoneOfUnit(unit:getName())
            if not zn then 
                zn = CarrierCommand.getCarrierOfUnit(unit:getName())
            end
            
            if not zn then 
                zn = FARPCommand.getFARPOfUnit(unit:getName())
                if zn and not zn:hasFeature(PlayerLogistics.buildables.satuplink) then
                    trigger.action.outTextForUnit(un:getID(), zn.name..' lacks a Satellite Uplink. Can not join missions.', 10)
                    return false
                end
            end

            if not zn or zn.side ~= unit:getCoalition() then 
                trigger.action.outTextForUnit(unit:getID(), 'Can only join mission while inside friendly zone', 5)
                return false
            end
        end
       
        for c,m in pairs(self.activeMissions) do
            if m:getPlayerUnit(player) then 
                trigger.action.outTextForUnit(unit:getID(), 'A mission is already active.', 5)
                return false 
            end
        end

        local mis = self.activeMissions[code]
        if not mis then 
            trigger.action.outTextForUnit(unit:getID(), 'Invalid mission code', 5)
            return false 
        end

        if Config.restrictMissionAcceptance and mis.state ~= Mission.states.preping then
            trigger.action.outTextForUnit(unit:getID(), 'Mission can only be joined if its members have not taken off yet.', 5)
            return false 
        end

        if not mis:isUnitTypeAllowed(unit) then
            trigger.action.outTextForUnit(unit:getID(), 'Current aircraft type is not compatible with this mission.', 5)
            return false
        end
        
        mis:addPlayer(player, unit)
        mis:pushMessageToPlayers(player..' has joined mission '..mis.name)
        env.info('Mission code'..code..' joined by '..player)
        return true
    end

    function MissionTracker:leaveMission(player)
        for _,mis in pairs(self.activeMissions) do
            if mis:getPlayerUnit(player) then
                mis:pushMessageToPlayers(player..' has left mission '..mis.name)
                mis:removePlayer(player)
                env.info('Mission code'..mis.missionID..' left by '..player)
                if not mis:hasPlayers() then
                    self.activeMissions[mis.missionID]:updateState(Mission.states.failed)
                    self.activeMissions[mis.missionID] = nil
                    env.info('Mission code'..mis.missionID..' canceled due to all players leaving')
                end

                break
            end
        end
        
        return true
    end

    function MissionTracker:forceStartMission(player)
        for _,mis in pairs(self.activeMissions) do
            if mis:getPlayerUnit(player) then
                mis:updateState(Mission.states.active)
                mis:pushMessageToPlayers(mis.name..' mission has started')
                local missionstatus = mis:getDetailedDescription()
                mis:pushMessageToPlayers(missionstatus)

                break
            end
        end
        
        return true
    end

    function MissionTracker:canCreateMission(misType)
        if not MissionTracker.maxMissionCount[misType] then return false end
        
        local missionCount = 0
        for i,v in pairs(self.missionBoard) do
            if v.type == misType then missionCount = missionCount + 1 end
        end

        for i,v in pairs(self.activeMissions) do
            if v.type == misType then missionCount = missionCount + 1 end
        end

        if missionCount >= MissionTracker.maxMissionCount[misType] then return false end

        local type = Mission.getType(misType)
        if type then
            return type.canCreate()
        end

        return false
    end

end


-----------------[[ END OF MissionTracker.lua ]]-----------------



-----------------[[ SquadTracker.lua ]]-----------------

SquadTracker = {}
do
    SquadTracker.infilTime = 10*60
    SquadTracker.exfilTime = 10*60

	function SquadTracker:new()
		local obj = {}
		obj.activeInfantrySquads = {}
		setmetatable(obj, self)
		self.__index = self
		
		obj:start()
        
		DependencyManager.register("SquadTracker", obj)
		return obj
	end

    SquadTracker.infantryCallsigns = {
        adjectives = {"Sapphire", "Emerald", "Whisper", "Vortex", "Blaze", "Nova", "Silent", "Zephyr", "Radiant", "Shadow", "Lively", "Dynamo", "Dusk", "Rapid", "Stellar", "Tundra", "Obsidian", "Cascade", "Zenith", "Solar"},
        nouns = {"Journey", "Quasar", "Galaxy", "Moonbeam", "Comet", "Starling", "Serenade", "Raven", "Breeze", "Echo", "Avalanche", "Harmony", "Stardust", "Horizon", "Firefly", "Solstice", "Labyrinth", "Whisper", "Cosmos", "Mystique"}
    }

    function SquadTracker:generateCallsign()
        local adjective = self.infantryCallsigns.adjectives[math.random(1,#self.infantryCallsigns.adjectives)]
        local noun = self.infantryCallsigns.nouns[math.random(1,#self.infantryCallsigns.nouns)]

        local callsign = adjective..noun

        if self.activeInfantrySquads[callsign] then
            for i=1,1000,1 do
                local try = callsign..'-'..i
                if not self.activeInfantrySquads[try] then
                    callsign = try
                    break
                end
            end
        end

        if not self.activeInfantrySquads[callsign] then
            return callsign
        end
    end

    function SquadTracker:restoreInfantry(save)

        Spawner.createObject(save.name, save.data.name, save.position, save.side, 20, 30,{
            [land.SurfaceType.LAND] = true, 
            [land.SurfaceType.ROAD] = true,
            [land.SurfaceType.RUNWAY] = true,
        })

        self.activeInfantrySquads[save.name] = SquadBase.create({
            name = save.name, 
            position = save.position, 
            deployPos = save.deployPos,
            targetPos = save.targetPos,
            state = save.state, 
            remainingStateTime=save.remainingStateTime, 
            shouldDiscover = save.discovered,
            discovered = save.discovered,
            data = save.data
        })

        if save.state == "extractReady" then
            MissionTargetRegistry.addSquad(self.activeInfantrySquads[save.name])
        end

        timer.scheduleFunction(function(param, time)
            if param.squad.state == "infil" then
                local tgzone = param.context:getTarget(param.squad)
                if tgzone then
                    local gr = Group.getByName(param.squad.name)
                    if gr then TaskExtensions.sendToPoint(gr, tgzone.zone.point) end
                end
            elseif param.state == "exfil" then
                local gr = Group.getByName(param.squad.name)
                if gr then TaskExtensions.sendToPoint(gr, param.squad.deployPos) end
            end
        end, {squad = self.activeInfantrySquads[save.name], context = self}, timer.getTime()+2)
        
        env.info('SquadTracker - '..save.name..'('..save.data.type..') restored')
    end

    function SquadTracker:spawnInfantry(infantryData, position)
        local callsign = self:generateCallsign()
        if callsign then
            Spawner.createObject(callsign, infantryData.name, position, infantryData.side, 20, 30,{
                [land.SurfaceType.LAND] = true, 
                [land.SurfaceType.ROAD] = true,
                [land.SurfaceType.RUNWAY] = true,
            })

            self:registerInfantry(infantryData, callsign, position)
        end
    end

    function SquadTracker:registerInfantry(infantryData, groupname, position)
        self.activeInfantrySquads[groupname] = SquadBase.create({name = groupname, deployPos = position, position = position, state = "deployed", remainingStateTime=0, data = infantryData})
        
        env.info('SquadTracker - '..groupname..'('..infantryData.type..') deployed')
    end
	
    function SquadTracker:start()
		if not ZoneCommand then return end

        timer.scheduleFunction(function(param, time)
			local self = param.context
			
			for i,v in pairs(self.activeInfantrySquads) do
                local remove = self:processInfantrySquad(v)
                if remove then
                    MissionTargetRegistry.removeSquad(v)
                    self.activeInfantrySquads[v.name] = nil
                end
			end
			
			return time+10
		end, {context = self}, timer.getTime()+1)
    end

    function SquadTracker:removeSquad(squadname)
        local squad = self.activeInfantrySquads[squadname]
        if squad then
            MissionTargetRegistry.removeSquad(squad)
            squad.state = 'extracted'
            squad.remainingStateTime = 0
            self.activeInfantrySquads[squadname] = nil
        end
    end

    function SquadTracker:getClosestExtractableSquad(sourcePoint, onside)
        local minDist = 99999999
        local squad = nil

        for i,v in pairs(self.activeInfantrySquads) do
            if v.state == 'extractReady' or v.state == "exfil" and v.data.side == onside then
                local gr = Group.getByName(v.name)
                if gr and gr:getSize()>0 then
                    local dist = mist.utils.get2DDist(sourcePoint, gr:getUnit(1):getPoint())
                    if dist<minDist then
                        minDist = dist
                        squad = v
                    end
                end
            end
        end

        if squad then
            local gr = Group.getByName(squad.name)
            if gr and gr:getSize()>0 then
                for i,v in ipairs(gr:getUnits()) do
                    local dist = mist.utils.get2DDist(sourcePoint, v:getPoint())
                    if dist < minDist then minDist = dist end
                end
            end
            return squad, minDist
        end
    end
    
    function SquadTracker:getTarget(squad)
        local gr = Group.getByName(squad.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        return self:getTargetZone(squad.position, squad.data.type, gr:getCoalition())
    end

    function SquadTracker:getTargetZone(position, type, squadside)
        if type == PlayerLogistics.infantryTypes.capture then
            local zn, dist = ZoneCommand.getClosestZoneToPoint(position, 0)
            if zn and dist < 2000+zn.zone.radius then
                return zn
            end
        elseif type == PlayerLogistics.infantryTypes.engineer then
            local zn, dist = ZoneCommand.getClosestZoneToPoint(position, squadside)
            if zn and dist < 2000+zn.zone.radius then
                return zn
            end
        elseif type == PlayerLogistics.infantryTypes.sabotage then
            local zn, dist = ZoneCommand.getClosestZoneToPoint(position, Utils.getEnemy(squadside))
            if zn and dist < 2000+zn.zone.radius then
                return zn
            end
        elseif type == PlayerLogistics.infantryTypes.spy then
            local zn, dist = ZoneCommand.getClosestZoneToPoint(position, Utils.getEnemy(squadside))
            if zn and dist < 2000+zn.zone.radius then
                return zn
            end
        elseif type == PlayerLogistics.infantryTypes.ambush then
        elseif type == PlayerLogistics.infantryTypes.assault then
        elseif type == PlayerLogistics.infantryTypes.manpads then
        elseif type == PlayerLogistics.infantryTypes.rapier then
        end
    end

    function SquadTracker:playSound(squad, state)
        local pos = { 
            x = squad.position.x,
            y = squad.position.y + 200,
            z = squad.position.z,
        }

        local type = squad.data.type
        TransmissionManager.queueTransmission('squads.'..type..'.'..state, TransmissionManager.radios.infantry, pos)
    end

    function SquadTracker:processInfantrySquad(squad)
        return squad:process()
    end
end

-----------------[[ END OF SquadTracker.lua ]]-----------------



-----------------[[ Squads/SquadBase.lua ]]-----------------

SquadBase = {}

do
    function SquadBase:new(data)
        local obj = data or {}
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function SquadBase.create(data)
        env.info('squadbase - '..data.data.type)
        if data.data.type == PlayerLogistics.infantryTypes.engineer then
            return EngineerSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.ambush then
            return AmbushSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.assault then
            return AssaultSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.capture then
            return CaptureSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.manpads then
            return ManpadsSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.rapier then
            return RapierSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.sabotage then
            return SabotageSquad:new(data)
        elseif data.data.type == PlayerLogistics.infantryTypes.spy then
            return SpySquad:new(data)
        end
    end

    function SquadBase:startProcess()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then
			gr:destroy()
			return true
		end

        self.position = gr:getUnit(1):getPoint()
        self.remainingStateTime = self.remainingStateTime - 10
    end

    function SquadBase:process()
        local failed = self:startProcess()
        if failed then return true end

        if self.state == 'working' then
            failed = self:processWorking()
            if failed then return true end
        else
            failed = self:processCommon()
            if failed then return true end
        end
    end

    function SquadBase:processCommon()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.state == 'deployed' then
            self.deployPos = gr:getUnit(1):getPoint()

            if self:isAtTarget() then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') started working for '..self.data.jobtime..' seconds')
                self.state = 'working'
                self.remainingStateTime = self.data.jobtime
                DependencyManager.get("SquadTracker"):playSound(self, 'working')
            else
                local tgzone = DependencyManager.get("SquadTracker"):getTarget(self)
                if tgzone then
                    env.info('SquadTracker - '..self.name..'('..self.data.type..') infiltrating to '..tgzone.name)
                    self.state = 'infil'
                    self.remainingStateTime = SquadTracker.infilTime
                    TaskExtensions.sendToPoint(gr, tgzone.zone.point)
                else
                    env.info('SquadTracker - '..self.name..'('..self.data.type..') extracting')
                    TaskExtensions.stopGroup(gr)

                    local z = ZoneCommand.getZoneOfPoint(gr:getUnit(1):getPoint())
                    if not z then FARPCommand.getFARPOfPoint(gr:getUnit(1):getPoint()) end

                    if z and z.side == gr:getCoalition() then
                        z:addResource(200)
                        local dpl = DependencyManager.get("PlayerLogistics")
                        dpl.humanResource.current = dpl.humanResource.current + gr:getSize()
                        gr:destroy()
                        MissionTargetRegistry.removeSquad(self)
                        return true
                    else
                        self.state = 'extractReady'
                        self.remainingStateTime = self.data.extracttime
                        self.redeploy = true
                        MissionTargetRegistry.addSquad(self)
                        DependencyManager.get("SquadTracker"):playSound(self, 'extracting')
                    end
                end
            end
        elseif self.state == 'infil' then
            if self:isAtTarget() then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') infiltrated and started working for '..self.data.jobtime..' seconds')
                TaskExtensions.stopGroup(gr)
                self.state = 'working'
                self.remainingStateTime = self.data.jobtime
            elseif self.remainingStateTime <= (SquadTracker.infilTime/2) and not self.repathAttempted then
                local tgzone = DependencyManager.get("SquadTracker"):getTarget(self)
                if tgzone then
                    env.info('SquadTracker - '..self.name..'('..self.data.type..') took too long to infil, repathing')
                    TaskExtensions.sendToPoint(gr, tgzone.zone.point)
                end
                self.repathAttempted = true
            elseif self.remainingStateTime <= 0 then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') exfiltrating, took too long to infil')
                if not self.deployPos then self.deployPos = self.position end
                TaskExtensions.sendToPoint(gr, self.deployPos)
                self.state = 'exfil'
                self.remainingStateTime = SquadTracker.exfilTime
            end
        elseif self.state == 'exfil' then
            if not self.deployPos then self.deployPos = self.position end
            local dist = mist.utils.get2DDist(self.position, self.deployPos)
            if dist < 50 or self.remainingStateTime <=0 then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') extracting after reached deployPos or ran out of time, waiting for '..self.data.extracttime..' seconds for extract')
                TaskExtensions.stopGroup(gr)
                
                local z = ZoneCommand.getZoneOfPoint(gr:getUnit(1):getPoint())
                if not z then FARPCommand.getFARPOfPoint(gr:getUnit(1):getPoint()) end
                
                if z and z.side == gr:getCoalition() then
                    z:addResource(200)
                    local dpl = DependencyManager.get("PlayerLogistics")
                    dpl.humanResource.current = dpl.humanResource.current + gr:getSize()
                    gr:destroy()
                    MissionTargetRegistry.removeSquad(self)
                    return true
                else
                    self.state = 'extractReady'
                    self.remainingStateTime = self.data.extracttime
                    MissionTargetRegistry.addSquad(self)
                    DependencyManager.get("SquadTracker"):playSound(self, 'extracting')
                end
            end
        elseif self.state == 'extractReady' then
            if self.remainingStateTime <= 0 then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') extract time elapsed, group MIA')
                self.state = 'mia'
                self.remainingStateTime = 0
			    gr:destroy()
                MissionTargetRegistry.removeSquad(self)
                return true
            end

            if not self.lastMarkerDeployedTime then
                self.lastMarkerDeployedTime = timer.getAbsTime() - (10*60)
            end

            if timer.getAbsTime() - self.lastMarkerDeployedTime > (5*60) then
                if gr:getSize()>0 then
                    local unPos = gr:getUnit(1):getPoint()
                    local p = Utils.getPointOnSurface(unPos)
                    p.x = p.x + math.random(-5,5)
                    p.z = p.z + math.random(-5,5)
		            trigger.action.smoke(p, trigger.smokeColor.Blue)
                    self.lastMarkerDeployedTime = timer.getAbsTime()
                end
            end
        end
    end

    function SquadBase:processExtract()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        env.info('SquadTracker - '..self.name..'('..self.data.type..') exfiltrating')
        if self.deployPos and gr and gr:isExist() and gr:getSize()>0 then TaskExtensions.sendToPoint(gr, self.deployPos) end
        self.state = 'exfil'
        self.remainingStateTime = SquadTracker.exfilTime
        DependencyManager.get("SquadTracker"):playSound(self, 'missioncomplete')
    end

    function SquadBase:isAtTarget()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        return true
    end
end

-----------------[[ END OF Squads/SquadBase.lua ]]-----------------



-----------------[[ Squads/AmbushSquad.lua ]]-----------------

AmbushSquad = SquadBase:new()

do 
    function AmbushSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function AmbushSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')
            
            local cnt = gr:getController()
            cnt:setCommand({ 
                id = 'SetInvisible', 
                params = { 
                    value = false 
                } 
            })

            self:processExtract()
        else
            if not self.discovered then
                local frcnt = gr:getUnit(1):getController()
                local targets = frcnt:getDetectedTargets()
                local isTargetClose = false
                if #targets > 0 then
                    for _,tgt in ipairs(targets) do
                        if tgt.visible and tgt.object then
                            if tgt.object.isExist and tgt.object:isExist() and tgt.object.getCoalition and tgt.object:getCoalition()~=gr:getCoalition() and 
                            Object.getCategory(tgt.object) == 1 then
                                local dist = mist.utils.get3DDist(gr:getUnit(1):getPoint(), tgt.object:getPoint())
                                if dist < 100 then
                                    isTargetClose = true
                                    break
                                end
                            end
                        end
                    end
                end
                
                if isTargetClose then
                    self.discovered = true
                    local cnt = gr:getController()
                    cnt:setCommand({ 
                        id = 'SetInvisible',
                        params = { 
                            value = false 
                        }
                    })
                end
            elseif self.shouldDiscover then
                self.shouldDiscover = nil
                local cnt = gr:getController()
                cnt:setCommand({ 
                    id = 'SetInvisible',
                    params = { 
                        value = false 
                    }
                })
            end
        end
    end
end

-----------------[[ END OF Squads/AmbushSquad.lua ]]-----------------



-----------------[[ Squads/AssaultSquad.lua ]]-----------------

AssaultSquad = SquadBase:new()

do 
    function AssaultSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function AssaultSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')
            self:processExtract()
        else
            if not self.assault then self.assault = { target = nil, effort = 0, extract = false, ammo = Utils.getAmmoCount(gr)} end

            if not self.assault.target or not self.assault.target:isExist() or self.assault.target:getSize() == 0 or self.assault.effort <=0 then
                local tz, dist = ZoneCommand.getClosestZoneToPoint(self.position, Utils.getEnemy(gr:getCoalition()))
                if tz and dist < 5000+tz.zone.radius then
                    local targets = {}
                    for i,v in pairs(tz.built) do
                        if v.type == ZoneCommand.productTypes.defense and v.side ~= gr:getCoalition() then 
                            local tgr = Group.getByName(v.name)
                            if tgr and tgr:isExist() and tgr:getSize()>0 then
                                local tdist = mist.utils.get2DDist(self.position, tgr:getUnit(1):getPoint())
                                table.insert(targets, {group = tgr, dist=tdist})
                            end
                        end
                    end

                    if #targets>0 then
                        table.sort(targets, function(a,b) return a.dist<b.dist end)
                        local tgt = targets[1].group

                        TaskExtensions.assaultGroup(gr, tgt)
                        self.assault.target = tgt
                        self.assault.effort = 60
                        DependencyManager.get("SquadTracker"):playSound(self, 'engaging')
                        env.info('SquadTracker - '..self.name..'('..self.data.type..') picked target '..tgt:getName())
                    else
                        self.assault.extract = true
                        env.info('SquadTracker - '..self.name..'('..self.data.type..') no target, exfil')
                    end
                else
                    self.assault.extract = true
                    env.info('SquadTracker - '..self.name..'('..self.data.type..') no zone, exfil')
                end
            else
                if self.assault.effort > 0 then
                    self.assault.effort = self.assault.effort - 1
                end

                if self.assault.effort < 30 then
                    if Utils.getAmmoCount(gr) == self.assault.ammo then
                        self.assault.effort = 0
                    end
                end

                self.assault.ammo = Utils.getAmmoCount(gr)
            end

            if Utils.getAmmoCount(gr)==0 then
                self.assault.extract = true
            end

            if self.assault.extract then
                env.info('SquadTracker - '..self.name..'('..self.data.type..') exfiltrating')
                if self.deployPos and gr and gr:isExist() and gr:getSize()>0 then TaskExtensions.sendToPoint(gr, self.deployPos) end
                self.state = 'exfil'
                self.remainingStateTime = SquadTracker.exfilTime
            end
        end
    end
end

-----------------[[ END OF Squads/AssaultSquad.lua ]]-----------------



-----------------[[ Squads/CaptureSquad.lua ]]-----------------

CaptureSquad = SquadBase:new()

do 
    function CaptureSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function CaptureSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')
            
            local zn = ZoneCommand.getZoneOfPoint(self.position)
            if zn and zn.side == 0 then
                self.state = "complete"
                self.remainingStateTime = 0
                zn:capture(gr:getCoalition())
                gr:destroy()
                
                local pl = DependencyManager.get("PlayerLogistics")
                pl.humanResource.current = pl.humanResource.current + self.data.size

                env.info('SquadTracker - '..self.name..'('..self.data.type..') no extraction required, deleting')
                return true
            else
                env.info('SquadTracker - '..self.name..'('..self.data.type..') not in zone, cant capture')
            end
            
            self:processExtract()
        end
    end

    function CaptureSquad:isAtTarget()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        local zn = ZoneCommand.getZoneOfPoint(self.position)
        if zn and zn.side == 0 then
            return true
        end
    end
end

-----------------[[ END OF Squads/CaptureSquad.lua ]]-----------------



-----------------[[ Squads/EngineerSquad.lua ]]-----------------

EngineerSquad = SquadBase:new()

do 
    function EngineerSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function EngineerSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')
            
            local zn = ZoneCommand.getZoneOfPoint(self.position)
            if zn and zn.side == gr:getCoalition() then
                zn:boostProduction(3000)
                self.state = "complete"
                self.remainingStateTime = 0
                gr:destroy()
                
                local pl = DependencyManager.get("PlayerLogistics")
                pl.humanResource.current = pl.humanResource.current + self.data.size

                env.info('SquadTracker - '..self.name..'('..self.data.type..') no extraction required, deleting')
                return true
            else
                env.info('SquadTracker - '..self.name..'('..self.data.type..') not in zone, cant boost')
            end

            self:processExtract()
        end
    end

    function EngineerSquad:isAtTarget()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        local zn = ZoneCommand.getZoneOfPoint(self.position)
        if zn and zn.side == gr:getCoalition() then
            return true
        end
    end
end

-----------------[[ END OF Squads/EngineerSquad.lua ]]-----------------



-----------------[[ Squads/ManpadsSquad.lua ]]-----------------

ManpadsSquad = SquadBase:new()

do 
    function ManpadsSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function ManpadsSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')

            self:processExtract()
        end
    end
end

-----------------[[ END OF Squads/ManpadsSquad.lua ]]-----------------



-----------------[[ Squads/RapierSquad.lua ]]-----------------

RapierSquad = SquadBase:new()

do 
    function RapierSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function RapierSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')

            self:processExtract()
        end
    end
end

-----------------[[ END OF Squads/RapierSquad.lua ]]-----------------



-----------------[[ Squads/SabotageSquad.lua ]]-----------------

SabotageSquad = SquadBase:new()

do 
    function SabotageSquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function SabotageSquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')

            local zn = ZoneCommand.getZoneOfPoint(self.position)
            if zn and zn.side ~= gr:getCoalition() and zn.side ~= 0 then
                zn:sabotage(1500, self.position)
                env.info('SquadTracker - '..self.name..'('..self.data.type..') sabotaged '..zn.name)
            else
                env.info('SquadTracker - '..self.name..'('..self.data.type..') not in zone, cant sabotage')
            end

            self:processExtract()
        end
    end
    
    function SabotageSquad:isAtTarget()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        local zn = ZoneCommand.getZoneOfPoint(self.position)
        if zn and zn.side ~= gr:getCoalition() and zn.side ~= 0 then
            return true
        end
    end
end

-----------------[[ END OF Squads/SabotageSquad.lua ]]-----------------



-----------------[[ Squads/SpySquad.lua ]]-----------------

SpySquad = SquadBase:new()

do 
    function SpySquad:new(data)
        local obj = SquadBase:new(data)
		setmetatable(obj, self)
		self.__index = self
		return obj
    end

    function SpySquad:processWorking()
        local gr = Group.getByName(self.name)
        if not gr then return true end
		if gr:getSize()==0 then 
			gr:destroy()
			return true
		end

        if self.remainingStateTime <=0 then
            env.info('SquadTracker - '..self.name..'('..self.data.type..') job complete, heading to extract')

            local zn = ZoneCommand.getZoneOfPoint(self.position)
            if zn and zn.side ~= gr:getCoalition() and zn.side ~= 0 then
                zn:reveal()

                if zn.neighbours then
                    for _,v in pairs(zn.neighbours) do
                        if v.side ~= gr:getCoalition() and v.side ~= 0 then
                            v:reveal()
                            if v:hasUnitWithAttributeOnSide({'Buildings'}, v.side) then
                                local tgt = v:getRandomUnitWithAttributeOnSide({'Buildings'}, v.side)
                                if tgt then
                                    MissionTargetRegistry.addStrikeTarget(tgt, v)
                                end
                            end
                        end
                    end
                end

                env.info('SquadTracker - '..self.name..'('..self.data.type..') infiltrated into '..zn.name)
            else
                env.info('SquadTracker - '..self.name..'('..self.data.type..') not in zone, cant infiltrate')
            end

            self:processExtract()
        end
    end
    
    function SpySquad:isAtTarget()
        local gr = Group.getByName(self.name)
        if not gr then return end
		if gr:getSize()==0 then return end

        local zn = ZoneCommand.getZoneOfPoint(self.position)
        if zn and zn.side ~= gr:getCoalition() and zn.side ~= 0 then
            return true
        end
    end
end

-----------------[[ END OF Squads/SpySquad.lua ]]-----------------



-----------------[[ CSARTracker.lua ]]-----------------

CSARTracker = {}
do
	function CSARTracker:new()
		local obj = {}
		obj.activePilots = {}
		setmetatable(obj, self)
		self.__index = self
		
		obj:start()

		DependencyManager.register("CSARTracker", obj)
		return obj
	end

    function CSARTracker:start()
		if not ZoneCommand then return end

        local ev = {}
		ev.context = self
		function ev:onEvent(event)
			if event.id == world.event.S_EVENT_LANDING_AFTER_EJECTION then
                if event.initiator and event.initiator:isExist() then
                    if event.initiator:getCoalition() == 2 then
                        local z = ZoneCommand.getZoneOfPoint(event.initiator:getPoint())
                        if not z then
                            local name = self.context:generateCallsign()
                            if name then
                                local pos = {
                                    x = event.initiator:getPoint().x,
                                    y = event.initiator:getPoint().z
                                }

                                if pos.x ~= 0 and pos.y ~= 0 then
                                    local srfType = land.getSurfaceType(pos)
                                    if srfType ~= land.SurfaceType.WATER and srfType ~= land.SurfaceType.SHALLOW_WATER then
                                        local gr = Spawner.createPilot(name, pos)
                                        self.context:addPilot(name, gr)
                                        TransmissionManager.pilotCallout(TransmissionManager.radios.guard, event.initiator:getPoint())
                                    end
                                end
                            end
                        end
                    end

                    event.initiator:destroy()
                end
			end
		end
		
		world.addEventHandler(ev)

        timer.scheduleFunction(function(param, time)
            for i,v in pairs(param.context.activePilots) do
                v.remainingTime = v.remainingTime - 10
                if not v.pilot:isExist() or v.remainingTime <=0 then
                    param.context:removePilot(i)
                end
            end
			
			return time+10
		end, {context = self}, timer.getTime()+1)
    end

    function CSARTracker:markPilot(data)
        local pilot = data.pilot
        if pilot:isExist() then
            local pos = pilot:getUnit(1):getPoint()
            local p = Utils.getPointOnSurface(pos)
            p.x = p.x + math.random(-5,5)
            p.z = p.z + math.random(-5,5)
            trigger.action.smoke(p, trigger.smokeColor.Green)
        end
    end

    function CSARTracker:flarePilot(data)
        local pilot = data.pilot
        if pilot:isExist() then
            local pos = pilot:getUnit(1):getPoint()
            local p = Utils.getPointOnSurface(pos)
            trigger.action.signalFlare(p, trigger.flareColor.Green, math.random(1,360))
        end
    end

    function CSARTracker:removePilot(name)
        local data = self.activePilots[name]
        if data.pilot and data.pilot:isExist() then data.pilot:destroy() end

        MissionTargetRegistry.removePilot(data)
        self.activePilots[name] = nil
    end

    function CSARTracker:addPilot(name, pilot)
        self.activePilots[name] = {pilot = pilot, name = name, remainingTime = 45*60}
        MissionTargetRegistry.addPilot(self.activePilots[name])
    end

    function CSARTracker:restorePilot(save)         
        local gr = Spawner.createPilot(save.name, save.pos)
        
        self.activePilots[save.name] = {
            pilot = gr, 
            name = save.name, 
            remainingTime = save.remainingTime
        }
        
        MissionTargetRegistry.addPilot(self.activePilots[save.name])       
    end

    function CSARTracker:getClosestPilot(toPosition)
        local minDist = 99999999
        local data = nil
        local name = nil

        for i,v in pairs(self.activePilots) do
            if v.pilot:isExist() and v.pilot:getSize()>0 and v.pilot:getUnit(1):isExist() and v.remainingTime > 0 then
                local dist = mist.utils.get2DDist(toPosition, v.pilot:getUnit(1):getPoint())
                if dist<minDist then
                    minDist = dist
                    data = v
                end
            else
                self:removePilot(i)
            end
        end

        if data then
            return {name=data.name, pilot=data.pilot, remainingTime = data.remainingTime, dist=minDist}
        end
    end

    CSARTracker.pilotCallsigns = {
        adjectives = {"Agile", "Voyager", "Sleek", "Fierce", "Nimble", "Daring", "Swift", "Fearless", "Dynamic", "Rapid", "Brave", "Stealthy", "Eagle", "Thunder", "Roaring", "Jade", "Lion", "Crimson", "Mighty", "Phoenix"},
        nouns = {"Pancake", "Noodle", "Potato", "Banana", "Wombat", "Penguin", "Llama", "Cabbage", "Kangaroo", "Giraffe", "Walrus", "Pickle", "Donut", "Hamburger", "Toaster", "Teapot", "Unicorn", "Rainbow", "Dragon", "Sasquatch"}
    }

    function CSARTracker:generateCallsign()
        local adjective = self.pilotCallsigns.adjectives[math.random(1,#self.pilotCallsigns.adjectives)]
        local noun = self.pilotCallsigns.nouns[math.random(1,#self.pilotCallsigns.nouns)]

        local callsign = adjective..noun

        if self.activePilots[callsign] then
            for i=1,1000,1 do
                local try = callsign..'-'..i
                if not self.activePilots[try] then
                    callsign = try
                    break
                end
            end
        end

        if not self.activePilots[callsign] then
            return callsign
        end
    end
end

-----------------[[ END OF CSARTracker.lua ]]-----------------



-----------------[[ GCI.lua ]]-----------------

GCI = {}

do
    function GCI:new(side)
        local o = {}
        o.side = side
        o.tgtSide = 0
        if side == 1 then
            o.tgtSide = 2
        elseif side == 2 then
            o.tgtSide = 1
        end

        o.radars = {}
        o.players = {}
        o.radarTypes = {
            'SAM SR',
            'EWR',
            'AWACS'
        }

        o.groupMenus = {}

        setmetatable(o, self)
		self.__index = self

        o:start()

		DependencyManager.register("GCI", o)
		return o
    end

    local function getCenter(unitslist)
        local center = { x=0,y=0,z=0}
        local count = 0
        for _,u in pairs(unitslist) do
            if u and u:isExist() then
                local up = u:getPoint()
                center = {
                    x = center.x + up.x,
                    y = center.y + up.y,
                    z = center.z + up.z,
                }
                count = count + 1
            end
        end

        center.x = center.x / count
        center.y = center.y / count
        center.z = center.z / count

        return center
    end

    function GCI:registerPlayer(name, unit, warningRadius, metric)
        if warningRadius > 0 then
            local msg = "Warning radius set to "..warningRadius
            if metric then
                msg=msg.."km" 
            else
                msg=msg.."nm"
            end
            
            local wRadius = 0
            if metric then
                wRadius = warningRadius * 1000
            else
                wRadius = warningRadius * 1852
            end

            local callsign = DependencyManager.get("PlayerTracker"):getPlayerConfig(name).gci_callsign
            
            self.players[name] = {
                unit = unit, 
                warningRadius = wRadius,
                metric = metric,
                callsign = callsign,
                lastTransmit = timer.getAbsTime() - 60
            }
            
            trigger.action.outTextForUnit(unit:getID(), msg, 10)
            DependencyManager.get("PlayerTracker"):setPlayerConfig(name, "gci_warning_radius", warningRadius)
            DependencyManager.get("PlayerTracker"):setPlayerConfig(name, "gci_metric", metric)
        else
            self.players[name] = nil
            trigger.action.outTextForUnit(unit:getID(), "GCI Reports disabled", 10)
            DependencyManager.get("PlayerTracker"):setPlayerConfig(name, "gci_warning_radius", nil)
            DependencyManager.get("PlayerTracker"):setPlayerConfig(name, "gci_metric", nil)
        end
    end

    function GCI:setCallsign(name, unit, cname)
        local uid = unit:getID()
        
        local ptr = DependencyManager.get('PlayerTracker')
        local csign = ptr:generateCallsign(cname)
        ptr:setPlayerConfig(name, 'gci_callsign', csign)
        
        trigger.action.outTextForUnit(uid, "GCI callsign set to "..PlayerTracker.callsignToString(csign), 10)

        if not self.players[name] then return end
        self.players[name].callsign = csign
    end

    function GCI:start()
        MenuRegistry.register(4, function(event, context)
			if (event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT or event.id == world.event.S_EVENT_BIRTH) and event.initiator and event.initiator.getPlayerName then
				local player = event.initiator:getPlayerName()
				if player then
					local groupid = event.initiator:getGroup():getID()
                    local groupname = event.initiator:getGroup():getName()
                    local unit = event.initiator
					
                    if context.groupMenus[groupid] then
                        missionCommands.removeItemForGroup(groupid, context.groupMenus[groupid])
                        context.groupMenus[groupid] = nil
                    end

                    if not context.groupMenus[groupid] then
                        
                        local menu = missionCommands.addSubMenuForGroup(groupid, 'GCI')
                        local setWR = missionCommands.addSubMenuForGroup(groupid, 'Set Warning Radius', menu)
                        local kmMenu = missionCommands.addSubMenuForGroup(groupid, 'KM', setWR)
                        local nmMenu = missionCommands.addSubMenuForGroup(groupid, 'NM', setWR)

                        missionCommands.addCommandForGroup(groupid, '10 KM',  kmMenu, Utils.log(context.registerPlayer), context, player, unit, 10, true)
                        missionCommands.addCommandForGroup(groupid, '25 KM',  kmMenu, Utils.log(context.registerPlayer), context, player, unit, 25, true)
                        missionCommands.addCommandForGroup(groupid, '50 KM',  kmMenu, Utils.log(context.registerPlayer), context, player, unit, 50, true)
                        missionCommands.addCommandForGroup(groupid, '100 KM', kmMenu, Utils.log(context.registerPlayer), context, player, unit, 100, true)
                        missionCommands.addCommandForGroup(groupid, '150 KM', kmMenu, Utils.log(context.registerPlayer), context, player, unit, 150, true)

                        missionCommands.addCommandForGroup(groupid, '5 NM',  nmMenu, Utils.log(context.registerPlayer), context, player, unit, 5, false)
                        missionCommands.addCommandForGroup(groupid, '10 NM', nmMenu, Utils.log(context.registerPlayer), context, player, unit, 10, false)
                        missionCommands.addCommandForGroup(groupid, '25 NM', nmMenu, Utils.log(context.registerPlayer), context, player, unit, 25, false)
                        missionCommands.addCommandForGroup(groupid, '50 NM', nmMenu, Utils.log(context.registerPlayer), context, player, unit, 50, false)
                        missionCommands.addCommandForGroup(groupid, '80 NM', nmMenu, Utils.log(context.registerPlayer), context, player, unit, 80, false)
                        missionCommands.addCommandForGroup(groupid, 'Disable Warning Radius', menu, Utils.log(context.registerPlayer), context, player, unit, 0, false)

                        
                        local gcicsignmenu = missionCommands.addSubMenuForGroup(groupid, 'Callsign', menu)

                        local sub1 = gcicsignmenu
                        local count = 0
                        for i,v in ipairs(PlayerTracker.callsigns) do
                            count = count + 1
                            if count%9==1 and count>1 then
                                sub1 = missionCommands.addSubMenuForGroup(groupid, "More", sub1)
                                missionCommands.addCommandForGroup(groupid, v, sub1, Utils.log(context.setCallsign), context, player, unit, v)
                            else
                                missionCommands.addCommandForGroup(groupid, v, sub1, Utils.log(context.setCallsign), context, player, unit, v)
                            end
                        end

                        context.groupMenus[groupid] = menu
                    end
				end

            end
		end, self)

        timer.scheduleFunction(function(param, time)
            local self = param.context
            local allunits = coalition.getGroups(self.side)
  
            local radars = {}
            for _,g in ipairs(allunits) do
                for _,u in ipairs(g:getUnits()) do
                    for _,a in ipairs(self.radarTypes) do
                        if u:hasAttribute(a) then
                            table.insert(radars, u)
                            break
                        end
                    end
                end
            end

            self.radars = radars
            env.info("GCI - tracking "..#radars.." radar enabled units")

            return time+10
        end, {context = self}, timer.getTime()+1)

        timer.scheduleFunction(function(param, time)
            local self = param.context

            local plyCount = 0
            for i,v in pairs(self.players) do
                if not v.unit or not v.unit:isExist() then
                    self.players[i] = nil
                else
                    plyCount = plyCount + 1
                end
            end

            env.info("GCI - reporting to "..plyCount.." players")
            if plyCount >0 then
                local dect = {}
                local dcount = 0
                for _,u in ipairs(self.radars) do
                    if u:isExist() then
                        local detected = u:getController():getDetectedTargets(Controller.Detection.RADAR)
                        for _,d in ipairs(detected) do
                            if d and d.object and d.object.isExist and d.object:isExist() and 
                                Object.getCategory(d.object) == Object.Category.UNIT and
                                d.object.getCoalition and
                                d.object:getCoalition() == self.tgtSide then
                                    
                                if not dect[d.object:getName()] then
                                    dect[d.object:getName()] = d.object
                                    dcount = dcount + 1
                                end
                            end
                        end
                    end
                end
                
                env.info("GCI - aware of "..dcount.." enemy units")

                local minsep = 1500
                local minaltsep = 500
                local dectgroups = {}
                local assignedUnits = {}
                for nm,dt in pairs(dect) do
                    for gnm, gdt in pairs(dectgroups) do
                        if gdt.leader and gdt.leader:isExist() and dt and dt:isExist() then
                            if gdt.leader:getDesc().typeName == dt:getDesc().typeName then
                                local dist = mist.utils.get2DDist(gdt.center, dt:getPoint())
                                if dist < minsep and math.abs(gdt.center.y-dt:getPoint().y)<minaltsep then
                                    gdt.units[nm] = dt
                                    gdt.center = getCenter(gdt.units)
                                    assignedUnits[nm] = true
                                    break
                                end
                            end
                        end
                    end

                    if not assignedUnits[nm] then
                        dectgroups[nm] = { leader = dt, units={}, center = {}}
                        dectgroups[nm].units[nm] = dt
                        dectgroups[nm].center = getCenter(dectgroups[nm].units)
                        assignedUnits[nm] = true
                    end
                end

                for name, data in pairs(self.players) do
                    if data.unit and data.unit:isExist() then
                        local closeUnits = {}

                        local wr = data.warningRadius
                        if wr > 0 then
                            for _,dtg in pairs(dectgroups) do
                                local dt = dtg.leader
                                if dt:isExist() then
                                    local tgtPnt = dtg.center
                                    local dist = mist.utils.get2DDist(data.unit:getPoint(), tgtPnt)
                                    if dist <= wr then
                                        local brg = math.floor(Utils.getBearing(data.unit:getPoint(), tgtPnt))

                                        local myPos = data.unit:getPosition()
                                        local tgtPos = dt:getPosition()
                                        local tgtHeading = math.deg(math.atan2(tgtPos.x.z, tgtPos.x.x))
                                        local tgtBearing = Utils.getBearing(tgtPos.p, myPos.p)
            
                                        local diff = math.abs(Utils.getHeadingDiff(tgtBearing, tgtHeading))
                                        local aspect = ''
                                        local priority = 1
                                        if diff <= 30 then
                                            aspect = "Hot"
                                            priority = 1
                                        elseif diff <= 60 then
                                            aspect = "Flanking"
                                            priority = 1
                                        elseif diff <= 120 then
                                            aspect = "Beaming"
                                            priority = 2
                                        else
                                            aspect = "Cold"
                                            priority = 3
                                        end

                                        local type = "UNKN"
                                        if dt:hasAttribute("Helicopters") then
                                            type = "HELO"
                                        elseif dt:hasAttribute("Planes") then
                                            type = "FXWG"
                                        end

                                        table.insert(closeUnits, {
                                            type = type, --dt:getDesc().typeName,
                                            bearing = brg,
                                            range = dist,
                                            altitude = tgtPnt.y,
                                            score = dist*priority,
                                            aspect = aspect,
                                            size = Utils.getTableSize(dtg.units)
                                        })
                                    end
                                end
                            end
                        end

                        env.info("GCI - "..#closeUnits.." enemy units within "..wr.."m of "..name)
                        if #closeUnits > 0 then
                            table.sort(closeUnits, function(a, b) return a.range < b.range end)
                            local strcallsign = DependencyManager.get("PlayerTracker").callsignToString(data.callsign)
                            local msg = "GCI Report for ["..strcallsign.."]:\n"
                            local count = 0
                            local callouts = {}
                            for _,tgt in ipairs(closeUnits) do
                                if data.metric then
                                    local km = tgt.range/1000
                                    if km < 1 then
                                        msg = msg..'\n'..tgt.type..'  MERGED'
                                    else
                                        msg = msg..'\n'..tgt.type
                                        msg = msg..'  BRA: '..tgt.bearing..' for '
                                        msg = msg..Utils.round(km)..'km at '
                                        msg = msg..(Utils.round(tgt.altitude/250)*250)..'m, '
                                        msg = msg..tostring(tgt.aspect)
                                        if tgt.size > 1 then msg = msg..',    GROUP of '..tgt.size end
                                    end
                                else
                                    local nm = tgt.range/1852
                                    if nm < 1 then
                                        msg = msg..'\n'..tgt.type..'  MERGED'
                                    else
                                        msg = msg..'\n'..tgt.type
                                        msg = msg..'  BRA: '..tgt.bearing..' for '
                                        msg = msg..Utils.round(nm)..'nm at '
                                        msg = msg..(Utils.round((tgt.altitude/0.3048)/1000)*1000)..'ft, '
                                        msg = msg..tostring(tgt.aspect)
                                        if tgt.size > 1 then msg = msg..',    GROUP of '..tgt.size end
                                    end
                                end
                                
                                if tgt.aspect == "Hot" and data.lastTransmit < (timer.getAbsTime()-Config.gciRadioTimeout) and #callouts <= Config.gciMaxCallouts then
                                    local miles = Utils.round(tgt.range/1852)
                                    local angels = Utils.round((tgt.altitude/0.3048)/1000)
                                    table.insert(callouts, {
                                        type = tgt.type,
                                        size = tgt.size,
                                        bearing = tgt.bearing,
                                        miles = miles,
                                        angels = angels
                                    })
                                end

                                count = count + 1
                                if count >= 10 then break end
                            end

                            if #callouts > 0 then
                                local sourcePos = data.unit:getPoint()

                                for i,call in ipairs(callouts) do
                                    if i==1 then
                                        TransmissionManager.gciCallout(TransmissionManager.radios.gci, data.callsign, call.type, call.size, call.bearing, call.miles, call.angels, sourcePos)
                                    else
                                        TransmissionManager.gciCallout(TransmissionManager.radios.gci, nil, call.type, call.size, call.bearing, call.miles, call.angels, sourcePos)
                                    end 
                                end

                                data.lastTransmit = timer.getAbsTime()
                            end
                            
                            if DependencyManager.get("PlayerTracker"):getPlayerConfig(name).gciTextReports then
                                trigger.action.outTextForUnit(data.unit:getID(), msg, 19)
                            end
                        end
                    else
                        self.players[name] = nil
                    end
                end
            end

            return time+20
        end, {context = self}, timer.getTime()+6)
    end
end

-----------------[[ END OF GCI.lua ]]-----------------



-----------------[[ Starter.lua ]]-----------------

Starter = {}
do
    Starter.neutralChance = 0.1

    function Starter.start(zones)
        if Starter.shouldRandomize() then
            Starter.randomize(zones)
        else
            Starter.normalStart(zones)
        end
    end

    function Starter.randomize(zones)
        local startZones = {}
        for _,z in pairs(zones) do
            if z.isHeloSpawn and z.isPlaneSpawn then
                table.insert(startZones, z)
            end
        end

        if #startZones > 0 then
            local sz = startZones[math.random(1,#startZones)]

            sz:capture(2, true)
            Starter.captureNeighbours(sz, math.random(1,3))
        end

        for _,z in pairs(zones) do
            if z.side == 0 then 
                if math.random() > Starter.neutralChance then
                    z:capture(1,true)
                end
            end

            if z.side ~= 0 then
                z:fullUpgrade(math.random(1,30)/100)
            end
        end
    end

    function Starter.captureNeighbours(zone, stepsLeft)
        if stepsLeft > 0 then
            for _,v in pairs(zone.neighbours) do
                if v.side == 0 then
                    if math.random() > Starter.neutralChance then
                        v:capture(2,true)
                    end
                    Starter.captureNeighbours(v, stepsLeft-1)
                end
            end
        end
    end

    function Starter.shouldRandomize()
        if lfs then
            local filename = lfs.writedir()..'Missions/Saves/randomize.lua'
            if lfs.attributes(filename) then
                return true
            end
		end
    end

    function Starter.normalStart(zones)
        for _,z in pairs(zones) do
            local i = z.initialState
            if i then
                if i.side and i.side ~= 0 then
                    z:capture(i.side, true)
                    z:fullUpgrade()
                    z:boostProduction(math.random(1,200))
                end
            else
                z:setSide(0)
            end
        end
    end
end

-----------------[[ END OF Starter.lua ]]-----------------

