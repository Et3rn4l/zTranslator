instance DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 2;
	condition	= DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_condition;
	information	= DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_info;
	description	= "Ich könnte dich begleiten.";
};

FUNC int DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_condition()
{
	if Bekannt_DIA_GM_AMBIENT_WADUR_2_1
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_00"); //Ich könnte dich begleiten.
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_01"); //Zu zweit ist der Weg sicherer als alleine. Aber woher soll ich denn wissen, dass du mich auch verteidigen kannst?
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_02"); //Da wirst du mir wohl vertrauen müssen.
	Info_ClearChoices (DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST);
	Info_AddChoice (DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST, "Entweder du glaubst mir, oder du kannst allein gehen.", DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN);
	Quest(TOPIC_WadurHafen, T_NEW, "Ich soll Wadur zum Hafen geleiten, da der Weg für ihn alleine zu gefährlich ist.");
	
};
	
FUNC void DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN()
{
	Bekannt_DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN_00"); //Entweder du glaubst mir, oder du kannst allein gehen.
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN_01"); //Reg dich doch nicht gleich so auf. Ich glaube dir ja. Sag mir einfach, wann wir losgehen sollen.
	MISVAR_Wadur_begleiten = TRUE;
	Info_ClearChoices (DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST);
};
	
instance DIA_GM_K1_WADURHAFEN_2_WADUR (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 10;
	condition	= DIA_GM_K1_WADURHAFEN_2_WADUR_condition;
	information	= DIA_GM_K1_WADURHAFEN_2_WADUR_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_WADURHAFEN_2_WADUR_condition()
{
	if SDistTo("LOA_STADT_HAFEN_75", 600)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_WADURHAFEN_3_WADUR)
	&& self.aivar[AIV_PartyMember] == TRUE
	&& RunningQ(TOPIC_WadurHafen)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_WADURHAFEN_2_WADUR_info()
{
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_2_WADUR_00"); //(ruft) Halt mal kurz an!
	AI_TurnToNpc(other, self);
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_2_WADUR_01"); //Was ist denn?
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_2_WADUR_02"); //Muss nur schnell was erledigen.
	if (Wld_IsFPAvailable (self, "PEE")){	
		AI_GotoFP (self, "PEE");	
		AI_Standup (self);	
		AI_AlignToFP (self);	
		AI_PlayAni (self, "T_STAND_2_PEE");
	};
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_2_WADUR_03"); //Ist alles gut abgelaufen? 
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_2_WADUR_04"); //Ja, wir können weiter.
};
	
instance DIA_GM_K1_WADURHAFEN_3_WADUR (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 10;
	condition	= DIA_GM_K1_WADURHAFEN_3_WADUR_condition;
	information	= DIA_GM_K1_WADURHAFEN_3_WADUR_info;
	description	= "Lass uns gehen.";
};

FUNC int DIA_GM_K1_WADURHAFEN_3_WADUR_condition()
{
	if Bekannt_DIA_GM_K1_WADURHAFEN_1_WADUR_QUEST_VERTRAUEN
	&& RunningQ(TOPIC_WadurHafen)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_WADURHAFEN_3_WADUR_info()
{
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_3_WADUR_00"); //Lass uns gehen.
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_3_WADUR_01"); //Ich folge dir.
	Npc_ExchangeRoutine (self, "FOLLOW");
	self.aivar[AIV_PartyMember] = TRUE;
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_WADURHAFEN_4_WADUR (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 10;
	condition	= DIA_GM_K1_WADURHAFEN_4_WADUR_condition;
	information	= DIA_GM_K1_WADURHAFEN_4_WADUR_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_WADURHAFEN_4_WADUR_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_WADURHAFEN_3_WADUR)
	&& SDistTO("WP_MINE_01", 5000)
	&& SDistTO("VERBINDUNG_HAFEN", 5000)
	&& isTalking()
	&& RunningQ(TOPIC_WadurHafen)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_WADURHAFEN_4_WADUR_info()
{
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_4_WADUR_00"); //Warum bleiben wir stehen?
	Info_ClearChoices (DIA_GM_K1_WADURHAFEN_4_WADUR);
	Info_AddChoice (DIA_GM_K1_WADURHAFEN_4_WADUR, "Wir blieben doch gar nicht stehen. Jetzt komm weiter!", DIA_GM_K1_WADURHAFEN_4_WADUR_KEINGRUND);
	Info_AddChoice (DIA_GM_K1_WADURHAFEN_4_WADUR, "Weil du mir jetzt all deine Roperi gibst.", DIA_GM_K1_WADURHAFEN_4_WADUR_GOLD);
};
	
FUNC void DIA_GM_K1_WADURHAFEN_4_WADUR_KEINGRUND()
{
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_4_WADUR_KEINGRUND_00"); //Wir sind doch gar nicht stehen geblieben. Jetzt komm weiter!
	Info_ClearChoices (DIA_GM_K1_WADURHAFEN_4_WADUR);
};
	
FUNC void DIA_GM_K1_WADURHAFEN_4_WADUR_GOLD()
{
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_4_WADUR_GOLD_00"); //Weil du mir jetzt all deine Roperi gibst.
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_4_WADUR_GOLD_01"); //Du Betrüger, du elender... Von mir bekommst du gar nichts.
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_4_WADUR_GOLD_02"); //Wenn du wirklich den Mumm hast, kannst du ja mal probieren, es dir zu holen. Aber ich warne dich, ein Brummschädel wie nach 'nem Blutfliegenstich ist vorprogrammiert!
	AI_SetWalkmode(self, NPC_RUN);
	Npc_ExchangeRoutine (self, "START");
	Info_ClearChoices (DIA_GM_K1_WADURHAFEN_4_WADUR);
};
	
instance DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 10;
	condition	= DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_condition;
	information	= DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_condition()
{
	if SDistTo("VERBINDUNG_HAFEN",3000)
	&& RunningQ(TOPIC_WadurHafen)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_00"); //Das reicht, du hast mich weit genug begleitet. Unsere Wege trennen sich hier.
	AI_Output (other, self, "DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_01"); //Was ist mit einer Belohnung?
	AI_Output (self, other, "DIA_GM_K1_WADURHAFEN_5_WADUR_SUCCESS_02"); //Davon habe ich nie gesprochen, geh und schufte selbst, dann hast du auch genug Roperi.
	Npc_ExchangeRoutine (self, "STADT");
	AI_StopProcessInfos (self);
	Quest(TOPIC_WadurHafen, T_SUCCESS, "Wadur hat mich ausgenutzt und mich nicht einmal bezahlt. Dieser miese, kleine Betrüger...");
	XP(75);
	self.aivar[AIV_PartyMember] = FALSE;
};
	
instance DIA_GM_K1_SNAPPER_1_ADIM_QUEST (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 5;
	condition	= DIA_GM_K1_SNAPPER_1_ADIM_QUEST_condition;
	information	= DIA_GM_K1_SNAPPER_1_ADIM_QUEST_info;
	description	= "Alles in Ordnung?";
};

FUNC int DIA_GM_K1_SNAPPER_1_ADIM_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_TIPP)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_SNAPPER_1_ADIM_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_00"); //Ist hier draußen alles in Ordnung? Du siehst so verärgert aus.
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_01"); //(poltert) Das ist auch kein Wunder bei diesem Höllenjob am Ende der Welt!
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_02"); //Bei jedem Dreckswetter müssen wir draußen stehen. Gutes Essen und schöne Frauen suchst du hier vergebens.
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_03"); //Und zu allem Überfluss rücken uns all die Viecher aus der Umgebung immer dichter auf den Pelz.
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_04"); //Die verlassene Gegend hinter der Goldmine nennen wir deswegen schon Snapperland.
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_05"); //(verabscheuend) Meine Jungs trauen sich kaum noch zum Pinkeln hinter die Felsen zu gehen, weil immer dann eins von diesen Mistviechern auftaucht, wenn man seine Hand mal nicht am Schwert hat.
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_06"); //(resigniert) Wenn ich das alles vorher gewusst hätte, wäre ich lieber als Torwache in der Stadt geblieben.
	Info_ClearChoices (DIA_GM_K1_SNAPPER_1_ADIM_QUEST);
	Info_AddChoice (DIA_GM_K1_SNAPPER_1_ADIM_QUEST, DIALOG_ENDE, DIA_GM_K1_SNAPPER_1_ADIM_QUEST_ENDE);
	Info_AddChoice (DIA_GM_K1_SNAPPER_1_ADIM_QUEST, "Ich könnte euch helfen.", DIA_GM_K1_SNAPPER_1_ADIM_QUEST_WAS_IST);
};
	
FUNC void DIA_GM_K1_SNAPPER_1_ADIM_QUEST_ENDE()
{
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_SNAPPER_1_ADIM_QUEST_WAS_IST()
{
	AI_Output (other, self, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_WAS_IST_00"); //Was hältst du davon, wenn ich im Snapperland ein paar von den Biestern für dich erledige?
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_WAS_IST_01"); //(musternd) Du bist wohl ein starker Kämpfer, was?!
	AI_Output (self, other, "DIA_GM_K1_SNAPPER_1_ADIM_QUEST_WAS_IST_02"); //(schnell) Na gut, wenn du es schaffen solltest, auch nur zehn Snapper zu töten, wirst du von mir dafür eine angemessene Belohnung erhalten. Viel Glück!
	Quest(TOPIC_Snapperland, T_NEW, "Die Rekruten vor der Goldmine werden von unzähligen Snappern bedrängt. Ich habe Adim meine Hilfe angeboten. Wenn ich mindestens zehn Snapper erledigen kann, wird er mir eine Belohnung geben.");
	MISVAR_Snapper_count = 1000;
	MISVAR_Snapper_Hunt = TRUE;
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_VOR_MINE_12");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_BEI_WALD1_01");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_WALD1_01");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_WALD1_05");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_WIESE_14");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_WIESE_09");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_BEI_BRÜCKE_08");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_BEI_BRÜCKE_01");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_VOR_RUINE_11");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_VOR_RUINE_11");
	Wld_InsertNpc (Snapper_NORESPAWN, "FP_ROAM_VOR_RUINE_05");
};
	
instance DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_condition;
	information	= DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_info;
	permanent	= TRUE;
	description	= "Ich habe zehn Snapper für dich erledigt.";
};

FUNC int DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_condition()
{
	if (RunningQ(TOPIC_Snapperland))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_00"); //Auftrag ausgeführt! Ich habe zehn Snapper für dich beseitigt.
	if MISVAR_Snapper_count >= 1010 {
		AI_Output (self, other, "DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_01"); //Gut gemacht! Weit und breit kaum noch eins von diesen Biestern zu sehen.
		AI_Output (self, other, "DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_02"); //Meine Männer und ich danken dir!
		CreateAndGive(ItMi_GoldNugget_Addon,20);
		CreateAndGive(ItFo_Addon_FireStew,1);
		XP(100);
		Quest(TOPIC_Snapperland, T_SUCCESS, "Adim und seine Männer sind zufrieden. Ich auch!");
	}else{
		AI_Output (self, other, "DIA_GM_K1_SNAPPER_2_ADIM_SUCCESS_03"); //Verarsch mich nicht. Die Gegend ist immer noch voll von diesen Viechern!
	};
};
	
instance DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_condition;
	information	= DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_info;
	description	= "Ich könnte schauen, was ich machen kann.";
};

FUNC int DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_5)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_00"); //Ich könnte schauen, was ich machen kann. Entweder ich zahle deine Schulden im Voraus, oder... Ich versuch mal an die Liste zu kommen.
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_1_MORTY_QUEST_01"); //Damit würdest du mir einen riesigen Gefallen tun.
	Quest(TOPIC_MortySchulden, T_NEW, "Morty hat aufgrund seines Unfalls beim Schürfen keine Möglichkeit, das Schutzgeld bei den Eintreibern zu bezahlen. Morty schuldet den Eintreibern noch 27 Goldbrocken. Ich sollte mal mit Frand reden.");
	if RunningQ(TOPIC_Triumvirat){
		Quest(TOPIC_Triumvirat, T_ENTRY, "Morty wird ebenfalls vom Triumvirat ausgenommen.");
	}else{
		Quest(TOPIC_Triumvirat, T_NEW, "Anscheinend gibt es in der Goldmine von Ahssûn eine kriminelle Vereinigung namens 'Triumvirat', die von den Schürfern Schutzgeld erpresst, obwohl diese bereits ihre Steuerabgaben an die Stadt leisten.");
		Quest(TOPIC_Triumvirat, T_ENTRY, "Morty wird ebenfalls vom Triumvirat ausgenommen.");
	};
};
	
instance DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_condition;
	information	= DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_info;
	permanent	= TRUE;
	description	= "Wegen Mortys Schulden...";
};

FUNC int DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_condition()
{
	if RunningQ(TOPIC_MortySchulden)
	&& MISVAR_Morty_DeptFree == FALSE
	&& Npc_HasItems(self, ItMi_DeptList) >= 1
	&& Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_00"); //Wegen Mortys Schulden...
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_01"); //Ja?
	Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
	Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "(zurück)", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_BACK);
	if (self.aivar[AIV_PlayerHasPickedMyPocket] == FALSE
	&& (Npc_GetTalentSkill (other, NPC_TALENT_PICKPOCKET) == 1 || SYSVAR_Pickpocket == TRUE)
	&& Npc_HasItems(self, ItMi_DeptList) > 0){
		Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "(Es wäre einfach, seine Schuldenliste zu stehlen)", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3);
	};
	Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "Können wir uns wegen der Schulden irgendwie einigen?", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2);
	Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "Ich möchte seine Schulden bezahlen.", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1);
	
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_00"); //Ich möchte seine Schulden bezahlen.
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_01"); //Wieviel war das nochmal?
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_02"); //Hey, woher soll ich das wissen?
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_03"); //Ach ja, dafür haben wir ja die Listen.
	if (Npc_HasItems (self, Fakescroll_Addon) == FALSE)
	{
		CreateInvItem (self, Fakescroll_Addon);
	};
	B_StopLookAt (self);
	AI_UseItemToState (self, Fakescroll_Addon, 1);
	AI_Wait (self, 2);
	AI_UseItemToState (self, Fakescroll_Addon, -1);
	Npc_SetStateTime (self, 0);
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_04"); //Genau, 27 Goldbrocken wären das.
	if(HItem(ItMi_GoldNugget_Addon, 27)){
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_05"); //Hier.
		Take(ItMi_GoldNugget_Addon, 27);
		MISVAR_Morty_DeptFree = TRUE;
		Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_06"); //Damit hätte sich das erledigt. Ich streiche ihn von der Liste, aber ab jetzt muss er wieder zahlen.
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_07"); //Okay.
	}else{
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_08"); //Soviel habe ich gerade nicht dabei.
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_1_09"); //Dann besorg es.
	};
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_00"); //Können wir uns wegen der Schulden irgendwie einigen?
	if (RunningQ(TOPIC_TiresFinden)
	&& !SuccessQ(TOPIC_TiresFinden)
	&& !SuccessQ(TOPIC_Verstecken)){
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_01"); //Erledige die Sache mit Tires und Mortys Schulden sind Geschichte, aber danach muss er wieder zahlen.
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_02"); //Geht klar.
		Quest(TOPIC_MortySchulden, T_ENTRY, "Mortys Schulden sind Geschichte, wenn ich Frand sage, wo Tires zu finden ist.");
	}else if (!SuccessQ(TOPIC_TiresFinden)
	&& !RunningQ(TOPIC_TiresFinden)
	&& !SuccessQ(TOPIC_Verstecken)
	&& !RunningQ(TOPIC_Verstecken)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO)
	&& !Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN){
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_03"); //Da wäre schon etwas, dass ich erledigt sehen will...
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_04"); //Worum geht's?
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_05"); //Dieser dreckige Schürfer Namens Tires, der hat mich doch tatsächlich angegriffen! Außerdem hat er seine Abgaben nicht bezahlt.
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_06"); //Könntest du mir helfen, ihn zu finden?
		Quest(TOPIC_MortySchulden, T_ENTRY, "Wenn ich Frand dabei helfe, Tires zu finden, dann werden Morty die Schulden beim Triumvirat erlassen.");
		Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
		Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "Ich geb mein Bestes.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA);
		Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "Nein, damit will ich nichts zu tun haben.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN);
	}else if (SuccessQ(TOPIC_TiresFinden)){
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_07"); //Du hast die Sache mit Tires geregelt. Mortys Schulden sind Geschichte, aber jetzt muss er wieder zahlen.
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_08"); //Ich sag's ihm.
		MISVAR_Morty_DeptFree = TRUE;
		Quest(TOPIC_MortySchulden, T_ENTRY, "Ich habe Frand dabei geholfen, Tires zu finden. Mortys Schulden sind nun erstmal Geschichte.");
		Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
	}else{
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_2_09"); //Nein, verpiss dich!	
	};
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3()
{
	Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
	Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "(zurück)", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3_BACK);
	Info_AddChoice (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND, "(Taschendiebstahl versuchen)", DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3_DOIT);
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3_BACK()
{
	Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_3_DOIT()
{
	if (other.attribute[ATR_DEXTERITY] >= 30){
		Npc_RemoveInvItems(self, ItMi_DeptList, 1);
		CreateInvItems(other, ItMi_DeptList, 1);
		self.aivar[AIV_PlayerHasPickedMyPocket] = TRUE;
		B_GiveThiefXP ();
		Quest(TOPIC_MortySchulden, T_ENTRY, "Ich habe jetzt Frands Schuldenliste. Das sollte ich Morty mitteilen.");
	}else{
		B_ResetThiefLevel();
		B_Say_Overlay (self, other, "$DIRTYTHIEF");
		AI_StopProcessInfos	(self);
		B_Attack (self, other, AR_Theft, 1); //reagiert trotz IGNORE_Theft mit NEWS
	};
	Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
};
	
FUNC void DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND_BACK()
{
	Info_ClearChoices (DIA_GM_K1_MORTYSCHULDEN_2_1_FRAND);
};
	
instance DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_condition;
	information	= DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_info;
	description	= "Deine Schulden sind beglichen.";
};

FUNC int DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_condition()
{
	if RunningQ(TOPIC_MortySchulden)
	&& (MISVAR_Morty_DeptFree == TRUE || HItem(ItMi_DeptList, 1))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_00"); //Deine Schulden sind beglichen. Du brauchst dir darum keine Gedanken mehr zu machen.
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_01"); //Ich bin sprachlos, wie hast du das gemacht?!
	if(MISVAR_Morty_DeptFree == TRUE){
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_02"); //Ich habe deine Schulden verschwinden lassen. Belassen wir es einfach dabei.
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_03"); //Soll mir recht sein.
	}else if (HItem(ItMi_DeptList, 1)){
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_04"); //Ich habe Frands Schuldenliste geklaut. Geh das nächste Mal zu ihm und gib ihm drei Goldstücke und sag, dass du damit deine Schulden beglichen hättest.
		AI_Output (other, self, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_05"); //Da er nicht mehr weiß, wieviel du ihm schuldest, wird er es damit belassen müssen.
		AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_06"); //Klasse!
	};
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_07"); //Danke für die Hilfe, ich hatte das echt nötig. Ab jetzt werde ich versuchen die Schutzgelder zu zahlen.
	AI_Output (self, other, "DIA_GM_K1_MORTYSCHULDEN_3_MORTY_SUCCESS_08"); //Leider kann ich dir dafür nichts als Gegenleistung anbieten, außer meinen Dank.
	XP(100);
	Quest(TOPIC_MortySchulden, T_SUCCESS, "Ich habe mich um Mortys Schulden gekümmert.");
};
	
instance DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 6;
	condition	= DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_condition;
	information	= DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_info;
	description	= "Sonst gibt es hier nichts anderes mehr zu tun?";
};

FUNC int DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_6)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_00"); //Sonst gibt es hier nichts anderes mehr zu tun?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_01"); //Mir fällt zumindest nichts auf Anhieb ein...
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_02"); //Warte, vielleicht braucht der Schmied ja Hilfe beim Inventarisieren der Erträge.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_03"); //Weißt du was, bevor wir uns hier noch die Füße krumm stehen, geh ich mal los und schaue, was es für dich so zu tun gibt.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST_04"); //Alles klar, ich warte dann hier... Wo soll ich auch sonst hin...?!
	Quest(TOPIC_MortyArbeit, T_NEW, "Morty braucht übergangsweise eine Arbeit, damit er die Schulden abbezahlen und sich was zu Essen leisten kann.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORTYARBEIT_2_RODG (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_2_RODG_condition;
	information	= DIA_GM_K1_MORTYARBEIT_2_RODG_info;
	description	= "Brauchst du Hilfe?";
};

FUNC int DIA_GM_K1_MORTYARBEIT_2_RODG_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_RODG_RODG_INTRO)
	&& RunningQ(TOPIC_MortyArbeit)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_2_RODG_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_2_RODG_00"); //Du brauchst nicht zufällig eine helfende Hand hier?
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_2_RODG_01"); //Morty erwähnte etwas von Inventarisierung. Brauchst du noch jemanden?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_2_RODG_02"); //Naja, so einen kräftigen und klugen Burschen wie dich könnte ich ganz gut gebrauchen. Ich suche tatsächlich noch jemanden, der die Bücher prüft, den Goldeingang in Empfang nimmt und diverse andere Tätigkeiten übernimmt.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_2_RODG_03"); //Einen Buchmacher mit Muskeln also.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_2_RODG_04"); //Genau so einen suche ich.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_2_RODG_05"); //Also, ich würde bei dieser Arbeit versauern. Das ist mir nicht aufregend genug.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_2_RODG_06"); //Morty jedoch braucht dringend eine Arbeit, um die Schutzgelder zahlen zu können.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_2_RODG_07"); //Der Krüppel will bei mir arbeiten? Der kann doch nicht einmal ein Buch hochheben ohne zu japsen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_2_RODG_08"); //Der Typ hat eine Woche im Bett gelegen. Ist das dein Ernst? Kann der überhaupt rechnen?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_2_RODG_09"); //Ach, vergiss mein Angebot einfach wieder. Den Stress tue ich mir nicht an.
};
	
instance DIA_GM_K1_MORTYARBEIT_3_RODG (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_3_RODG_condition;
	information	= DIA_GM_K1_MORTYARBEIT_3_RODG_info;
	description	= "Komm schon, gib Morty eine Chance.";
};

FUNC int DIA_GM_K1_MORTYARBEIT_3_RODG_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_2_RODG)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_3_RODG_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_3_RODG_00"); //Komm schon, falls ihm Wissen fehlt, dann kannst du es ihm ja zeigen. Ich bin mir sicher, dass er äußerst motiviert arbeiten wird.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_3_RODG_01"); //Von den Münzen hängt sein Leben ab. (zu sich selbst) Zumindest so, wie er sich anstellt.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_3_RODG_02"); //Ich weiß nicht... Na ja, okay. Wenn er diese Rechenaufgaben lösen kann, dann darf er mal Probearbeiten.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_3_RODG_03"); //Aber wehe, er versucht etwas zu klauen, dann sind seine Hände endgültig ab! Darauf schwöre ich bei meinem Schmiedehammer.
	CreateAndGive(ItWr_Rechnenaufgaben_1, 1);
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Rodg hat sich schlussendlich dazu entschlossen, Morty eine Chance zu geben. Das sollte ich Morty gleich mitteilen.");
	
};
	
instance DIA_GM_K1_MORTYARBEIT_5_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_5_NEMS_condition;
	information	= DIA_GM_K1_MORTYARBEIT_5_NEMS_info;
	description	= "Ich suche Arbeit für Morty.";
};

FUNC int DIA_GM_K1_MORTYARBEIT_5_NEMS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST)
	&& RunningQ(TOPIC_MortyArbeit)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_NEMS_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_5_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_5_NEMS_00"); //Hey, alles okay?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_01"); //Ja, wieso fragst du?
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_5_NEMS_02"); //Ich bin für Morty auf der Suche nach Arbeit. Hast du welche?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_03"); //Geh mir weg damit. Ich kann den Typ nicht ausstehen.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_5_NEMS_04"); //Aber wieso?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_05"); //Nach dem Balkenunfall hat er wie bekloppt im Schlaf geschrien und uns alle nicht schlafen lassen. Ich hab auch noch so einen leichten Schlaf, sodass ich absolut alles mitbekam.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_06"); //Drei Tage konnte ich gar nicht schlafen, bis ich irgendwann bei der Arbeit eingeschlafen bin und mich einer der Eintreiber des Triumvirats geweckt hat.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_07"); //Da ich bei der Arbeit geschlafen hab, muss ich jetzt sogar noch mehr Abgaben leisten. 
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_08"); //'Wer feiern kann, kann auch arbeiten.', hat er gesagt. 'Wer nicht arbeitet, der muss anders zahlen.', hat er gesagt.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_5_NEMS_09"); //Beim verfluchten Beliar! Danke, Morty, für deine verdammte Hackfresse!
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_5_NEMS_10"); //Ist ja schon gut... Ich lass das Thema lieber.
	AI_StopProcessInfos (self);
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Nems war nicht so begeistert von der Idee Morty Arbeit zu geben. Mortys Alpträume haben ihm das Leben schwerer gemacht.");
};
	
instance DIA_GM_K1_MORTYARBEIT_6_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 3;
	condition	= DIA_GM_K1_MORTYARBEIT_6_ZARA_condition;
	information	= DIA_GM_K1_MORTYARBEIT_6_ZARA_info;
	description	= "Hast du Arbeit für Morty?";
};

FUNC int DIA_GM_K1_MORTYARBEIT_6_ZARA_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_1_MORTY_QUEST)
	&& RunningQ(TOPIC_MortyArbeit)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ZARA_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_6_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_6_ZARA_00"); //Sag mal, hättest du Arbeit für Morty?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_6_ZARA_01"); //Hmm... Ich könnte schon eine helfende Hand gebrauchen. Aber Morty? Der ist doch verletzt. Wie will er mir dann beim Waschen der Pflanzen helfen oder sonstiges?
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_6_ZARA_02"); //Er könnte doch für dich das Rühren übernehmen, dazu müsste ein Arm doch wohl reichen, oder?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_6_ZARA_03"); //Ja, kann er.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_6_ZARA_04"); //Viel kann ich ihm dafür aber nicht geben. Ich schau mal, ob ich in der Zwischenzeit ein paar Sonderwünsche einholen kann, die für Mortys Entlohnung sorgen können.
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Also Zara hätte simple Rührarbeit für Morty, bei der er mit einem Arm auskommt.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORTYARBEIT_7_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_7_MORTY_condition;
	information	= DIA_GM_K1_MORTYARBEIT_7_MORTY_info;
	permanent	= TRUE;
	description	= "Ich konnte für dich Arbeit finden.";
};

FUNC int DIA_GM_K1_MORTYARBEIT_7_MORTY_condition()
{
	if ((Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_3_RODG))
	||(Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_6_ZARA)))
	&& (MISVAR_MortyArbeit == 0)
	&& RunningQ(TOPIC_MortyArbeit)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_7_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_00"); //Ich konnte für dich Arbeit finden.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_01"); //Sag an!
	Info_ClearChoices (DIA_GM_K1_MORTYARBEIT_7_MORTY);
	if (Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_3_RODG) && HItem(ItWr_Rechnenaufgaben_1, 1)){
		Info_AddChoice (DIA_GM_K1_MORTYARBEIT_7_MORTY, "Rogd will prüfen, ob du was taugst.", DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG);
	};
	if (!Bekannt_DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA 
	&& Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_6_ZARA)){
		Info_AddChoice (DIA_GM_K1_MORTYARBEIT_7_MORTY, "Zara könnte dich als Umrührer gebrauchen.", DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA);
	};
	
	
};
	
FUNC void DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_00"); //Rogd will prüfen, ob du was taugst. Wenn du rechnen kannst, dann kriegst du eine Chance als Buchhalter seines Inventars.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_01"); //Das klingt ja hervorragend. Aber leider kann ich gar nicht rechnen. Mein Vater war auch nur ein Knecht.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_02"); //Da kann ich dir weiterhelfen. Ich kann dir das schnell beibringen. 
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_03"); //Oder ich löse die Aufgaben für dich und gebe sie ab.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_04"); //Möchtest du diese Arbeit haben?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_05"); //Hast du etwa mehr?
	Info_ClearChoices (DIA_GM_K1_MORTYARBEIT_7_MORTY);
	if (!Bekannt_DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA && Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_6_ZARA)){
		Info_AddChoice (DIA_GM_K1_MORTYARBEIT_7_MORTY, "Zara könnte dich als Umrührer gebrauchen.", DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA);
	};
	if (Bekannt_DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA){
		AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_06"); //Du kennst die andere Option bereits.
	}else if (!Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_6_ZARA)){
		AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_07"); //Nein.
	};	
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_08"); //Die Sache mit Rodg klingt am besten. Was willst du eigentlich für den Rechenunterricht haben?
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_09"); //Das lass mal später unsere Sorge sein.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_RODG_10"); //(misstrauisch) Okay...
	MISVAR_MortyArbeit = 1;
	Info_ClearChoices (DIA_GM_K1_MORTYARBEIT_7_MORTY);
};
	
FUNC void DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA()
{
	Bekannt_DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA_00"); //Zara könnte dich als Umrührer gebrauchen. Aber dort gibt's wohl nicht allzu viele Münzen zu holen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_7_MORTY_ZARA_01"); //Hmm... Schwer hört es sich ja nicht an, aber ich glaube nicht, dass das was für mich wäre.
};
	
instance DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 3;
	condition	= DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_condition;
	information	= DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_info;
	description	= "Ich könnte die Rechenaufgabe für dich erledigen.";
};

FUNC int DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_condition()
{
	if MISVAR_MortyArbeit == 1
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_00"); //Ich könnte die Aufgaben für dich erledigen. Dann müssten wir keine Zeit verschwenden, um dir das Rechnen beizubringen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_01"); //Das wäre natürlich toll.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_02"); //Okay, ich mach sie dann fertig und geb sie Rodg.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT_03"); //Danke für deine großzügige Hilfe!
	if Npc_HasItems(self, ItWr_Rechnenaufgaben_1) >= 1{
		Npc_RemoveInvItems(self, ItWr_Rechnenaufgaben_1, 1);
	};
	CreateInvItems(other, ItWr_Rechnenaufgaben_1_geloest,1);
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Ich habe für Morty die Aufgaben gelöst und sollte sie nun in seinem Namen zu Rodg bringen.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 1;
	condition	= DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_condition;
	information	= DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_info;
	description	= "Sollen wir dann mit den Lektionen anfangen?";
};

FUNC int DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_condition()
{
	if MISVAR_MortyArbeit == 1
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_00"); //Sollen wir dann mit den Lektionen anfangen?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_01"); //Von mir aus kann es sofort losgehen.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_02"); //Okay, also es gibt die vier Grundrechenarten...
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_03"); //(murmelt) ... und dann ziehst du das davon ab...
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN_04"); //(murmelt) ... hier musst du im Grunde auch nur drauf rechnen, aber halt soviele Male, wie...
	AI_StopProcessInfos (self);
	//NewRout(self, "wait");
};
	
instance DIA_GM_K1_MORTYARBEIT_10_2_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 1;
	condition	= DIA_GM_K1_MORTYARBEIT_10_2_MORTY_condition;
	information	= DIA_GM_K1_MORTYARBEIT_10_2_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_MORTYARBEIT_10_2_MORTY_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_9_2_MORTY_LEARN))
	&& RunningQ(TOPIC_MortyArbeit)
	//&& Wld_isAfterTime(TIMEVAR_Morty_calc)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_10_2_MORTY_info()
{
	Wld_PlayEffect("BLACK_SCREEN", hero, hero, 0, 0, 0, FALSE);
	AI_Wait(self,2);
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_10_2_MORTY_00"); //Mir schwirrt der Kopf. Lass uns für heute Schluss machen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_10_2_MORTY_01"); //Immerhin haben wir die Aufgaben lösen können.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_10_2_MORTY_02"); //Hier bring das dem Rodg. Ich hau mich jetzt aufs Ohr.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_10_2_MORTY_03"); //Gut, das mach ich.
	if Npc_HasItems(other, ItWr_Rechnenaufgaben_1) >= 1{
		Npc_RemoveInvItems(other, ItWr_Rechnenaufgaben_1, 1);
	};
	CreateAndGive(ItWr_Rechnenaufgaben_1_geloest,1);
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Morty konnte die Aufgaben nach stundenlangem Lernen lösen. Rodg wird zufrieden sein. Ich sollte ihm die gelösten Aufgaben gleich bringen.");
	AI_StopProcessInfos (self);
	NewRout(self, "start");
};
	
instance DIA_GM_K1_MORTYARBEIT_11_2_RODG (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_condition;
	information	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_info;
	description	= "Morty hat die Aufgaben gelöst. (Lösungen zeigen)";
};

FUNC int DIA_GM_K1_MORTYARBEIT_11_2_RODG_condition()
{
	if HItem(ItWr_Rechnenaufgaben_1_geloest,1)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_11_2_RODG_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_00"); //Morty hat die Aufgaben gelöst.
	TakeAndDestroy(ItWr_Rechnenaufgaben_1_geloest,1);
	
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_01"); //Bei den Minecrawlern! Das hätte ich ihm gar nicht zugetraut.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_02"); //Also wenn er so gut rechnen kann, dann kann ich ihn auch als Buchhalter gebrauchen.
	if (Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_10_2_MORTY)){
		AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_03"); //Ach ja, ich hatte dir ganz vergessen zu sagen, dass ich Betrüger nicht so gerne sehe.
		AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_04"); //Wenn du diese Aufgaben gelöst hättest und ich hätte bemerkt, dass Morty gar nicht rechnen kann, dann wärt ihr jetzt übel dran gewesen.
		AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_05"); //Aber zum Glück bist du ein anständiger Kerl.
	};
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_06"); //Sag ihm, er kann noch heute anfangen.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_07"); //Ist mir eine Freude.
	Quest(TOPIC_MortyArbeit, T_ENTRY, "Rodg will Morty einstellen, ich sollte ihm bescheid geben.");
	TIMEVAR_Rodg_work = Wld_GetDay();
};
	
instance DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_condition;
	information	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_11_2_RODG)
	&& TIMEVAR_Rodg_work < Wld_GetDay()
	&& Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_info()
{
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_00"); //(sauer) Du dreckiger Betrüger. Morty kann gar nicht rechnen. Der kann ja noch nicht einmal zwei Zahlen addieren.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_01"); //Wie hast du dir das bitte schön vorgestellt? Sollte er sich die Goldbrocken gegen den Kopf hauen, bis ihm die richtige Zahl einfällt?
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_02"); //Aber weißt du was? Ich hab eine bessere Idee, als dir einfach nur gepflegt auf die Fresse zu hauen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_03"); //Ich erzähle diese Scheiße hier Umar, der kann sich dann mit dir rumschlagen.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY_04"); //Aber...
	AMBVAR_CrimeCounter += 1;
	MISVAR_Rodg_realisedCrime = TRUE;
	B_StartOtherRoutine(loa_none_6403_Morty, "start");
	if (RunningQ(TOPIC_MortyArbeit)){
		Quest(TOPIC_MortyArbeit, T_FAILED, "Morty wurde wieder entlassen, da ich bei der Rechenaufgabe geschummelt habe.");
	};
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_condition;
	information	= DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_11_2_RODG_12_RODG_ANGRY)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_info()
{
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_00"); //(wütend) Sehr gut gemacht! Jetzt hab ich wegen deinen grandiosen Ideen meine Arbeit verloren.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_01"); //Ich...
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_02"); //Sag einfach nichts und verschwinde aus meinem Blickfeld!
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_11_2_RODG_14_MORTY_03"); //Ich wollte doch nur...
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 1;
	condition	= DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_condition;
	information	= DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_info;
	description	= "Rodg will, dass du für ihn arbeitest.";
};

FUNC int DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_11_2_RODG)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_00"); //Rodg will, dass du für ihn arbeitest.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_01"); //Das ist super! Dafür hast du bei mir einen gut. Leider kann ich dir nichts als Gegenleistung anbieten. Du weißt ja, wie es um mich steht.
	AI_Output (other, self, "DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_02"); //Glaub mir, ich werde noch darauf zurückkommen.
	AI_Output (self, other, "DIA_GM_K1_MORTYARBEIT_13_MORTY_SUCCESS_03"); //Okay, ich werd mich dann mal aufmachen.
	Quest(TOPIC_MortyArbeit, T_SUCCESS, "Ich konnte Morty die dringend benötigte Arbeit beschaffen. Er arbeitet jetzt bei Rodg.");
	B_StartOtherRoutine(loa_none_6403_Morty, "workatRodg");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_condition;
	information	= DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_11_2_RODG)
	&& TIMEVAR_Rodg_work < Wld_GetDay()
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_MORTYARBEIT_9_2_MORTY_CHEAT))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_info()
{
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_00"); //(schelmisch) Ich hätte da noch eine 'kleine' Aufgabe für Morty.
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_01"); //Und die wäre?
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_02"); //Ich hab hier mal was aufgeschrieben, das etwas schwieriger ist.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_03"); //Wenn er das innerhalb von zwei Stunden lösen kann, dann erhöhe ich sogar seinen Lohn.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_04"); //Wer so gut rechnen kann, dem vertraue ich auch blind meine Bücher an.
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST_05"); //Okay, ich geb's ihm.
	CreateAndGive(ItWr_Rechnenaufgaben_2, 1);
	Quest(TOPIC_Calc, T_NEW, "Rodg hat noch eine besonders schwere Rechenaufgabe für Morty und für die Lösung hat er nur zwei Stunden Zeit.");
	TIMEVAR_Rodg_calc = Wld_GetTimePlus(0,2,0);
};
	
instance DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 4;
	condition	= DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_condition;
	information	= DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_info;
	description	= "Ich habe von Rodg eine weitere Aufgabe für dich bekommen.";
};

FUNC int DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_condition()
{
	if HItem(ItWr_Rechnenaufgaben_2, 1)				
	&& RunningQ(TOPIC_Calc)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_00"); //Ich habe von Rodg eine weitere Aufgabe für dich bekommen.
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_01"); //Wenn du sie innerhalb von zwei Stunden lösen kannst, dann gibt es von Rodg einen besseren Lohn.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_02"); //Klingt ja super. Gib mal her den Wisch.
	Take(ItWr_Rechnenaufgaben_2, 1);
	B_StopLookAt (loa_none_6403_Morty);
	AI_UseItemToState (loa_none_6403_Morty, ItWr_Rechnenaufgaben_2, 1);
	AI_Wait (loa_none_6403_Morty, 4);
	AI_UseItemToState (loa_none_6403_Morty, ItWr_Rechnenaufgaben_2, -1);
	Npc_SetStateTime (loa_none_6403_Morty, 0);
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_03"); //(empört) Was? Das ist doch nicht im Kopf auszurechnen!
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_04"); //Erst recht nicht innerhalb von zwei Stunden!
	B_StopLookAt (loa_none_6403_Morty);
	AI_UseItemToState (loa_none_6403_Morty, ItWr_Rechnenaufgaben_2, 1);
	AI_Wait (loa_none_6403_Morty, 4);
	AI_UseItemToState (loa_none_6403_Morty, ItWr_Rechnenaufgaben_2, -1);
	Npc_SetStateTime (loa_none_6403_Morty, 0);
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_05"); //Ah, mein Kopf. Ich krieg schon Kopfschmerzen.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_06"); //Selbst, wenn ich jede einzelne Zahl auf einem Blatt aufaddiere, werde ich nie fertig.
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_07"); //Hmm, lass mal sehen...
	Give(ItWr_Rechnenaufgaben_2, 1);
	B_StopLookAt (hero);
	AI_UseItemToState (hero, ItWr_Rechnenaufgaben_2, 1);
	AI_Wait (hero, 4);
	AI_UseItemToState (hero, ItWr_Rechnenaufgaben_2, -1);
	Npc_SetStateTime (hero, 0);
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_08"); //Hmm... Ah, ja... Ich glaub ich habe die Lösung.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_09"); //Ehrlich? Wow, bist du schlau!
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY_10"); //Dann eil mal schnell zu Rodg, bevor es zu spät ist. Du kriegst natürlich auch was von der Belohnung ab.
	Quest(TOPIC_Calc, T_ENTRY, "Morty hatte keine Idee für die Lösung. Vielleicht fällt es mir ja selbst ein.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_condition;
	information	= DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_info;
	permanent	= TRUE;
	description	= "Ich habe die Lösung.";
};

FUNC int DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST)
	&& Wld_isBeforeTime(TIMEVAR_Rodg_calc)
	&& RunningQ(TOPIC_Calc)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_00"); //Ich habe die Lösung.
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_01"); //Ach ja? Was ist das Ergebnis?
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_02"); //Zuerst die Einerzahl.
	AMBVAR_Calc_1 = TRUE;
	Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "9", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "8", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "7", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "6", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "5", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "4", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "3", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "2", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "1", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "0", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0);
	Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "Das war's!", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG);
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG()
{
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG_00"); //Das war's!
	if (MISVAR_Calc == 20100){
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG_01"); //Unglaublich, er hat die Lösung tatsächlich innerhalb von zwei Stunden gefunden.
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG_02"); //Ich brauchte eine ganze Woche, um auf die Lösung zu kommen. Aber es gibt natürlich einen Trick. Und den scheint Morty ausgenutzt zu haben.
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG_03"); //Ein echt schlaues Bürschen. Die Lohnerhöhung zahl ich gerne. Richte es ihm aus.
		if RunningQ(TOPIC_Calc){
			Quest(TOPIC_Calc, T_SUCCESS, "Ich konnte die Aufgabe innerhalb der zwei Stunden lösen. Jetzt kriegt Morty eine Belohnung.");
		};
		XP(300);
	}else{
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG_04"); //Nein, das ist leider falsch.
	};
	AI_StopProcessInfos (self);
	AMBVAR_Calc_1 = FALSE;
	AMBVAR_Calc_10 = FALSE;
	AMBVAR_Calc_100 = FALSE;
	AMBVAR_Calc_1000 = FALSE;
	AMBVAR_Calc_10000 = FALSE;
	 
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD()
{
	if (AMBVAR_Calc_10000 == TRUE){
		MISVAR_Calc += AMBVAR_Calc_chosen*10000;
		Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
		DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG();
	}else if (AMBVAR_Calc_1000 == TRUE){
		MISVAR_Calc += AMBVAR_Calc_chosen*1000;
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD_00"); //Jetzt die Zehntausenderzahl.
		AMBVAR_Calc_10000 = TRUE;
		Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "9", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "8", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "7", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "6", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "5", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "4", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "3", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "2", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "1", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "0", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "Das war's!", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG);
	}else if (AMBVAR_Calc_100 == TRUE){
		MISVAR_Calc += AMBVAR_Calc_chosen*100;
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD_01"); //Jetzt die Tausenderzahl.
		AMBVAR_Calc_1000 = TRUE;
		Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "9", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "8", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "7", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "6", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "5", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "4", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "3", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "2", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "1", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "0", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "Das war's!", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG);
	}else if (AMBVAR_Calc_10 == TRUE){
		MISVAR_Calc += AMBVAR_Calc_chosen*10;
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD_02"); //Jetzt die Hunderterzahl.
		AMBVAR_Calc_100 = TRUE;
		Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "9", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "8", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "7", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "6", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "5", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "4", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "3", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "2", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "1", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "0", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "Das war's!", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG);
	}else if (AMBVAR_Calc_1 == TRUE){
		MISVAR_Calc += AMBVAR_Calc_chosen;
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD_03"); //Jetzt die Zehnerzahl.
		AMBVAR_Calc_10 = TRUE;
		Info_ClearChoices (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "9", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "8", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "7", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "6", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "5", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "4", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "3", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "2", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "1", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "0", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0);
		Info_AddChoice (DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS, "Das war's!", DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_FERTIG);
	};
	
	
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_0()
{
	AMBVAR_Calc_chosen = 0;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_1()
{
	AMBVAR_Calc_chosen = 1;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_2()
{
	AMBVAR_Calc_chosen = 2;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_3()
{
	AMBVAR_Calc_chosen = 3;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_4()
{
	AMBVAR_Calc_chosen = 4;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_5()
{
	AMBVAR_Calc_chosen = 5;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_6()
{
	AMBVAR_Calc_chosen = 6;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_7()
{
	AMBVAR_Calc_chosen = 7;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_8()
{
	AMBVAR_Calc_chosen = 8;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_9()
{
	AMBVAR_Calc_chosen = 9;
	DIA_GM_K1_KNIFFLIGEAUFGABE_3_RODG_SUCCESS_ADD();
};
	
instance DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_condition;
	information	= DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_KNIFFLIGEAUFGABE_1_RODG_QUEST)
	&& Wld_isAfterTime(TIMEVAR_Rodg_calc)
	&& RunningQ(TOPIC_Calc)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_info()
{
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_00"); //Tja, die Zeit ist leider abgelaufen!
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_4_RODG_FAILED_01"); //Schade. Ich hätte Morty mehr zugetraut, nach dem was ich bisher gesehen habe.
	Quest(TOPIC_Calc, T_FAILED, "Weder ich, noch Morty konnten die Aufgabe innerhalb der zwei Stunden lösen.");
	XP (20);
};
	
instance DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_condition;
	information	= DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_info;
	description	= "Ich habe die Aufgabe gelöst.";
};

FUNC int DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_condition()
{
	if SuccessQ(TOPIC_Calc)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_00"); //Ich habe die knifflige Aufgabe von Rodg gelöst.
	if (!Npc_KnowsInfo (hero, DIA_GM_K1_KNIFFLIGEAUFGABE_2_MORTY)){
		AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_01"); //Welche knifflige Aufgabe?
		AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_02"); //Rodg hat mir eine neue Rechenaufgabe für dich mitgegeben, aber ich konnte sie sofort lösen und habe Rodg in deinem Namen die richtige Lösung gesagt.	
	};
	AI_Output (self, other, "DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_03"); //Super. Ich weiß gar nicht, wie ich mich dafür bedanken soll.
	AI_Output (other, self, "DIA_GM_K1_KNIFFLIGEAUFGABE_5_MORTY_04"); //Es wird sich schon was finden.
	XP(50);
};
	
instance DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_condition;
	information	= DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_UMAR_INTRO)
	&& TIMEVAR_Lockvogel < Wld_GetDay()
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_info()
{
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_00"); //Hey, bleib mal stehen! Ich hätte eine Aufgabe für dich.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_01"); //Okay, worum geht's?
	if (FALSE){
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_02"); //Wie du ja schon erfahren hast, brauchte ich ja einen Lockvogel für das Fangen - oder eher Abschlachten - der Minecrawler.
		AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_03"); //Genau. Und was hab ich jetzt damit zu tun? Du hast doch Morty für diesen Job.
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_04"); //Richtig, aber ich suche noch ein paar fähige Männer, die das Ding mit mir durchziehen.
	}else{
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_05"); //Ich suche noch ein paar fähige Männer, die mit mir die Minecrawler hier in der Goldmine jagen.
	};
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_06"); //Leider kann ich den anderen Rekruten nicht wirklich befehlen, solange es keine Sicherheitsprobleme gibt.
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_07"); //Ich bin nämlich auch nur einen Rang höher als die anderen hier und habe keine Befehlsgewalt - außer im Notfall.
		AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_08"); //Okay, und was würde für mich rausspringen?
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_09"); //Ich denke, da lässt sich was finden. Roperi und das unbezahlbare Gefühl, jemanden zu beschützen.
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_10"); //Außerdem bekommst du die einmalige Chance dich an den Trophäen eines Minecrawlers zu bedienen.
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_11"); //Natürlich nur, wenn du das vorher erlernt hast.
		AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_12"); //Wie sieht's aus? Bist du dabei?!
		Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST);
		Info_AddChoice (DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST, "Nein, das ist mir zu heikel.", DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_NEIN);
		Info_AddChoice (DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST, "Ja, bin dabei.", DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA);
	
};
	
FUNC void DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_00"); //Ja, bin dabei. Was soll ich machen?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_01"); //Einen Lockvogel habe ich bereits gefunden. Einer der Buddler wollte sich unbedingt etwas dazuverdienen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_02"); //Ich halte ihn nicht davon ab. Dient ja immerhin meinen Zielen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_03"); //Was du jetzt machen müsstest, ist herauszufinden, was die Viecher anlockt. Dann beschmieren wir den Lockvogel damit, bevor es losgeht.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_04"); //Danach warten wir, bis die Crawler aus ihren Löchern kommen und schlagen zu, wenn sie es nicht erwarten!
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_JA_05"); //Für Albrecht!
	Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST);
	//Npc_ExchangeRoutine(self, "CrawlerJagd");
	Quest(TOPIC_Lockvogel, T_NEW, "Umar will Minecrawler jagen gehen und ich schließe mich ihm an.");
};
	
FUNC void DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_NEIN()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_NEIN_00"); //Nein, das ist mir zu heikel.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST_NEIN_01"); //Schade, du wärst der Richtige dafür.
	Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_1_UMAR_QUEST);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_LOCKVOGEL_2_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_2_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_2_UMAR_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_2_UMAR_condition()
{
	if RunningQ(TOPIC_Lockvogel)
	&& Bekannt_DIA_GM_K1_LOCKVOGEL_6_UMAR
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_2_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_UMAR_00"); //Sind das alle deine 'Crawlerjäger'? Etwas dürftig, oder nicht?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_UMAR_01"); //Ach ja, keiner hat mehr Lust auf ein richtiges Abenteuer. Immerhin konnte ich den einen Rekruten und dich überzeugen.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_UMAR_02"); //Na dann müssen wir wohl doppelt so hart zuschlagen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_UMAR_03"); //(lachend) Was du nicht sagst.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_UMAR_04"); //Für Albrecht!
};
	
instance DIA_GM_K1_LOCKVOGEL_2_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 2;
	condition	= DIA_GM_K1_LOCKVOGEL_2_ZARA_condition;
	information	= DIA_GM_K1_LOCKVOGEL_2_ZARA_info;
	description	= "Weißt du, was Minecrawler magisch anzieht?";
};

FUNC int DIA_GM_K1_LOCKVOGEL_2_ZARA_condition()
{
	if RunningQ(TOPIC_Lockvogel)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_2_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_ZARA_00"); //Weißt du, was Minecrawler magisch anzieht?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_ZARA_01"); //Also, wenn du etwas Essbares meinst, wo sie nicht nein sagen können, dann ja.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_ZARA_02"); //Genau das meinte ich.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_ZARA_03"); //Bring mir einfach vier Feuernesseln, dann erklär ich's dir.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_ZARA_04"); //Feuernesseln?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_ZARA_05"); //Es heißt das Minecrawler total auf die Wurzelknöllchen von Feuernesseln stehen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_ZARA_06"); //Die werden total wild, wenn sie den Geruch aufnehmen.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_2_ZARA_07"); //Also wird man sie damit aus ihren Löchern herauslocken können?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_2_ZARA_08"); //Natürlich. Bring mir einfach die Pflanzen, dann bereite ich sie für dich vor.
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_LOCKVOGEL_3_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_3_ZARA_condition;
	information	= DIA_GM_K1_LOCKVOGEL_3_ZARA_info;
	description	= "Da hast du die Feuernesseln.";
};

FUNC int DIA_GM_K1_LOCKVOGEL_3_ZARA_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_2_ZARA))
	&& HItem(ItPl_Mana_Herb_01, 4)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_3_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_3_ZARA_00"); //Da hast du die Feuernesseln.
	Take(ItPl_Mana_Herb_01, 4);
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_3_ZARA_01"); //Okay, warte einen Moment.
	if (!C_BodyStateContains (self, BS_MOBINTERACT_INTERRUPT) && Wld_IsMobAvailable (self, "CAULDRON")){
		AI_UseMob (self, "CAULDRON", 1);
	}else if (!C_BodyStateContains (self, BS_MOBINTERACT_INTERRUPT) && Wld_IsMobAvailable (self, "STOVE")){
		AI_UseMob (self, "STOVE", 1);
	};
	AI_Wait(self, 2);
	AI_UseMob (self, "CAULDRON", -1);
	AI_UseMob (self, "STOVE", -1);
	AI_TurnToNpc(self, other);
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_3_ZARA_02"); //So, da hast du die Wurzelknöllchen.
	CreateAndGive(ItPl_Mana_Herb_sp, 12);
	AI_StopProcessInfos (self);
	Quest(TOPIC_Lockvogel, T_ENTRY, "Ich habe jetzt das Lockmittel und sollte damit jetzt zu Umar gehen.");
};
	
instance DIA_GM_K1_LOCKVOGEL_4_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 1;
	condition	= DIA_GM_K1_LOCKVOGEL_4_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_4_UMAR_info;
	description	= "Was mögen die Minecrawler denn so?";
};

FUNC int DIA_GM_K1_LOCKVOGEL_4_UMAR_condition()
{
	if RunningQ(TOPIC_Lockvogel) 
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_5_UMAR)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_4_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_4_UMAR_00"); //Was mögen die Minecrawler denn so?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_4_UMAR_01"); //Das musst du schon selbst herausfinden.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_4_UMAR_02"); //Irgendein Anhaltspunkt?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_4_UMAR_03"); //Frag mal unsere Köchin Zara, die hat früher für einen Alchemisten gearbeitet. Vielleicht kennt sie sich mit Lockmitteln aus.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_4_UMAR_04"); //Für Albrecht!
	Quest(TOPIC_Lockvogel, T_ENTRY, "Umar weiß nicht, was Minecrawler anlockt. Ich soll bei den Leuten oder einem Alchemisten herumfragen.");
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ZARA_INTRO){
		Quest(TOPIC_Lockvogel, T_ENTRY, "Vielleicht könnte auch die Köchin Zara etwas darüber wissen.");
	};
};
	
instance DIA_GM_K1_LOCKVOGEL_5_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_5_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_5_UMAR_info;
	description	= "Ich habe den Köder besorgt.";
};

FUNC int DIA_GM_K1_LOCKVOGEL_5_UMAR_condition()
{
	if RunningQ(TOPIC_Lockvogel)
	&& HItem(ItPl_Mana_Herb_sp, 12)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_5_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_5_UMAR_00"); //Ich habe den Köder besorgt.
	Take(ItPl_Mana_Herb_sp, 12);
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_5_UMAR_01"); //Jetzt muss der Buddler nur noch damit eingeschmiert werden.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_5_UMAR_02"); //Das wird heute wohl nicht mehr fertig werden.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_5_UMAR_03"); //Komm morgen wieder, dann kann die Jagd auf die Crawler losgehen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_5_UMAR_04"); //Für Albrecht!
	TIMEVAR_Crawler = Wld_GetDay();
	Quest(TOPIC_Lockvogel, T_ENTRY, "Umar präpariert den Lockvogel. Bis morgen sollte er soweit sein.");
	
	NewRout(loa_rek_6444_Rekrut, "waitCrawlerJagd");
};
	
instance DIA_GM_K1_LOCKVOGEL_6_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_6_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_6_UMAR_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_6_UMAR_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_5_UMAR)
	&& TIMEVAR_Crawler < Wld_GetDay()
	&& isTalking()
	&& MISVAR_Umar_toCrawler == FALSE
	&& RunningQ(TOPIC_Lockvogel)
	&& Wld_isTime(6,00,22,00)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_6_UMAR_info()
{
	Bekannt_DIA_GM_K1_LOCKVOGEL_6_UMAR = TRUE;
	
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_00"); //Da bist du ja. Der Lockvogel ist fertig.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_6_UMAR_01"); //Sehr gut.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_02"); //Bist du bereit zuzuschlagen?
	Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_6_UMAR);
	Info_AddChoice (DIA_GM_K1_LOCKVOGEL_6_UMAR, "Nein, ich brauch noch 'ne Minute.", DIA_GM_K1_LOCKVOGEL_6_UMAR_WARTEN);
	Info_AddChoice (DIA_GM_K1_LOCKVOGEL_6_UMAR, "Ja, es kann losgehen.", DIA_GM_K1_LOCKVOGEL_6_UMAR_JA);
};
	
FUNC void DIA_GM_K1_LOCKVOGEL_6_UMAR_WARTEN()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_6_UMAR_WARTEN_00"); //Nein, ich brauch noch 'ne Minute.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_WARTEN_01"); //Gut, dann sag Bescheid, wenn du bereit bist. Ich warte dann hier.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_WARTEN_02"); //Für Albrecht!
	Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_6_UMAR);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_LOCKVOGEL_6_UMAR_JA()
{
	Bekannt_DIA_GM_K1_LOCKVOGEL_6_UMAR_JA = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_6_UMAR_JA_00"); //Ja, es kann losgehen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_JA_01"); //Sehr gut, ich geh voraus und ihr folgt mir.
	NewRout(self, "CrawlerJagd");
	NewRout(loa_rek_6444_Rekrut, "CrawlerJagd");
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_rek_6444_Rekrut.aivar[AIV_PARTYMEMBER] = TRUE;
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_6_UMAR_JA_02"); //Für Albrecht!
	MISVAR_Umar_toCrawler = TRUE;
	Info_ClearChoices (DIA_GM_K1_LOCKVOGEL_6_UMAR);
	AI_StopProcessInfos (self);
	Quest(TOPIC_Lockvogel, T_ENTRY, "Es geht los. Wir wollen die Minecrawler zur Strecke bringen.");
};
	
instance DIA_GM_K1_LOCKVOGEL_8_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_8_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_8_UMAR_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_8_UMAR_condition()
{
	if RunningQ(TOPIC_Lockvogel) 
	&& Npc_GetDistToWP(loa_rek_6926_Umar, "GM_B_47") <= 1500
	&& Bekannt_DIA_GM_K1_LOCKVOGEL_6_UMAR_JA
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_8_UMAR_info()
{
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_8_UMAR_00"); //Verdammt, das habe ich mir schon gedacht.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_8_UMAR_01"); //Was ist denn?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_8_UMAR_02"); //Silberzange ist nicht hier.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_8_UMAR_03"); //Wer oder was ist Silberzange?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_8_UMAR_04"); //Der Minecrawler, auf den wir Jagd machen. Ein ziemlich großes Vieh und auch das größte Übel dieser Mine.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_8_UMAR_05"); //Er hat schon mehrere Schürfer verschleppt und abgeschlachtet.
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_8_UMAR_06"); //Okay...
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_8_UMAR_07"); //Für Albrecht!
	NewRout(loa_none_6412_Buddler, "CrawlerJagd");
	MISVAR_Lockvogel = 2;
	
};
	
instance DIA_GM_K1_LOCKVOGEL_9_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_9_UMAR_condition;
	information	= DIA_GM_K1_LOCKVOGEL_9_UMAR_info;
	description	= "Wie geht es jetzt weiter?";
};

FUNC int DIA_GM_K1_LOCKVOGEL_9_UMAR_condition()
{
	if RunningQ(TOPIC_Lockvogel)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_8_UMAR)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_9_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_9_UMAR_00"); //Wie geht es jetzt weiter? Worauf warten wir?
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_9_UMAR_01"); //Wir warten auf den Lockvogel. Eigentlich hätte er schon längst da sein müssen.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_9_UMAR_02"); //Könntest du mal nach ihm sehen?
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_9_UMAR_03"); //Sicher.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_9_UMAR_04"); //Für Albrecht!
	loa_none_6412_Buddler.name = "Lockvogel";
	Quest(TOPIC_Lockvogel, T_ENTRY, "Der Buddler, der als Lockvogel fungiert, braucht etwas lange. Ich sollte da mal nachschauen gehen, wo er bleibt. Er schürft für gewöhnlich im Eingangsbereich der Goldmine. Ich könnte ihn eventuell auch auf dem Weg treffen.");
	
	NewRout(self, "waitLure");
	NewRout(loa_rek_6444_Rekrut, "waitLure");
};
	
instance DIA_GM_K1_LOCKVOGEL_10_BUDDLER12 (C_INFO)
{
	npc			= loa_none_6412_Buddler;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_condition;
	information	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_info;
	description	= "Wo bleibst du denn?";
};

FUNC int DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_9_UMAR) 
	&& RunningQ(TOPIC_Lockvogel)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_00"); //Wo bleibst du denn? Wir warten bereits auf dich. Es ist Zeit für deinen Auftritt.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_01"); //(zitternd) Ich... Ich... Ich kann nicht.
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_02"); //Ich wollte ja schon losgehen, doch dann überfiel mich dieses Schlottern in meinen Beinen...
	Quest(TOPIC_Lockvogel, T_ENTRY, "Der Buddler hat Angst bekommen. Ich sollte ihm was Ordentliches zu Trinken besorgen, damit er sich überwinden kann. Ich schätze, zwei Wacholderschnäpse sollten reichen.");
};
	
instance DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12 (C_INFO)
{
	npc			= loa_none_6412_Buddler;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_condition;
	information	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_info;
	description	= "Hier hast du zwei Schnäpse, das sollte dir helfen.";
};

FUNC int DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_condition()
{
	if (HItem(Itfo_Booze, 2) 
	|| HItem(ItFo_Addon_Rum, 2)
	|| HItem(ItFo_Addon_Grog, 2)
	|| HItem(Itfo_Reisschnaps, 2)
	|| HItem(ItFo_Getreideschnaps, 2))
	&& Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_10_BUDDLER12)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_info()
{
	AI_Output (other, self, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_00"); //Hier hast du zwei Schnäpse, das sollte dir helfen.
	if HItem(Itfo_Booze, 2){
		Take(ItFo_Booze, 2);
		AI_UseItem(self, ItFo_Booze);
	}else if HItem(Itfo_Reisschnaps, 2){
		Take(ItFo_Reisschnaps, 2);
		AI_UseItem(self, ItFo_Reisschnaps);
	}else if HItem(Itfo_Getreideschnaps, 2){
		Take(ItFo_Getreideschnaps, 2);	
		AI_UseItem(self, ItFo_Getreideschnaps);
	}else if HItem(ItFo_Addon_Rum, 2){
		Take(ItFo_Addon_Rum, 2);	
		AI_UseItem(self, ItFo_Addon_Rum);
	}else if HItem(ItFo_Addon_Grog, 2){
		Take(ItFo_Addon_Grog, 2);	
		AI_UseItem(self, ItFo_Addon_Grog);
	};
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12_01"); //Danke, man. Das hab ich gebraucht. Okay, ich folge dir.
	Npc_ExchangeRoutine(self, "CrawlerJagd2");
	Quest(TOPIC_Lockvogel, T_ENTRY, "Ich führe den Lockvogel zu Umar und den Crawlern. Umar steht vor dem Stollen, in den die Crawler gelockt werden sollen.");
	
};
	
instance DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12 (C_INFO)
{
	npc			= loa_none_6412_Buddler;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12_condition;
	information	= DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_1_BUDDLER12)
	&& Npc_GetDistToWp(self, "GM_B_47") <= 1000
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12_info()
{
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_10_BUDDLER12_2_BUDDLER12_00"); //Okay, ich spiel dann mal den Lockvogel. Du solltest dich jetzt mit den anderen bereit halten.
	Npc_ExchangeRoutine(self, "CrawlerLure");
	AI_StopProcessInfos (self);
	B_StartOtherRoutine(loa_rek_6926_Umar, "CrawlerFollow");
	B_StartOtherRoutine(loa_rek_6444_Rekrut, "CrawlerJagd");
	loa_rek_6926_Umar.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_rek_6444_Rekrut.aivar[AIV_PARTYMEMBER] = TRUE;
	Quest(TOPIC_Lockvogel, T_ENTRY, "Ich soll mit den Rekruten weggehen, damit die Crawler hevorgelockt werden.");
};
	
instance DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_condition;
	information	= DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_condition()
{
	if DEADVAR_Silberzange == TRUE
	&& RunningQ(TOPIC_Lockvogel)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_00"); //Silberzange ist tot. Verdammt, das war aber ein Brocken!
	AI_Output (self, other, "DIA_GM_K1_LOCKVOGEL_12_UMAR_SUCCESS_01"); //Du hast der Stadt Ahssûn einen wertvollen Dienst erwiesen, dafür sollst du belohnt werden!
	Npc_ExchangeRoutine(self, "start");
	B_StartOtherRoutine(loa_rek_6444_Rekrut, "start");
	loa_none_6412_Buddler.name = "Buddler";
	B_StartOtherRoutine(loa_none_6412_Buddler, "start");
	
	Reward(100);
	XP(200);
	Quest(TOPIC_Lockvogel, T_SUCCESS, "Ich habe Umar geholfen, die Crawler zu erledigen und habe zum Schutz der Goldmine beizutragen. Dafür habe ich eine gute Belohnung kassiert.");
	loa_rek_6926_Umar.aivar[AIV_PARTYMEMBER] = FALSE;
	loa_rek_6444_Rekrut.aivar[AIV_PARTYMEMBER] = FALSE;
};
	
instance DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 2;
	condition	= DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_info;
	description	= "Was soll ich für dich machen?";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_5)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_00"); //Was soll ich für dich machen?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_01"); //Bei meinem letzten Gespräch mit Umar hat er von Johanns leckeren Fleischspießen geschwärmt.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_02"); //Dabei ist mir sofort das Wasser im Mund zusammengelaufen. Die will ich unbedingt probieren. 
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_03"); //(träumerisch) Wenn ich die dann noch über dem Feuer brate... Hmm...
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_04"); //Also besorg mir zuerst ein paar von diesen delikaten Fleischspießen.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_05"); //Wie viele genau?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_06"); //Wenn die nicht zu teuer sind, dann zehn Stück.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_07"); //Okay, wird notiert.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_08"); //Und dann bräuchte ich noch etwas Wohliges zum Runterspülen. Irgendein besonderes Bier. Aber nicht das aus dem Kloster.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_09"); //Die letzten Rekruten, die hier ankamen, sagten, dass das wie warme Goblinpisse schmeckt.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_10"); //Ich bevorzuge da schon einen etwas edleren Hopfen. Ein Dutzend Krüge davon sollte vorerst reichen.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_11"); //(genervt) Auch notiert. (gelangweilt) Darf es denn noch etwas sein?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_12"); //Oh ja, hätte ich fast vergessen. Ich habe schon lange nichts mehr geraucht. Besorg mir doch ein paar Stengel. Je mehr, desto besser.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_13"); //Alles klar. Ich mach mich mal auf den Weg.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST_14"); //(zu sich selbst) Was man nicht alles für andere macht, wenn man etwas von ihnen will...
	Quest(TOPIC_DotterKraut, T_NEW, "Dotter hat recht exklusive Wünsche. Ich soll ihm zehn Fleischspieße aus Johanns Taverne in der Stadt besorgen. Zusätzlich soll ich für ihn auch noch zwölf Krüge des besten Biers, aber nicht das aus dem Kloster, bringen. In der Stadt gibt's bestimmt einen Händler dafür. Abschließend will er auch noch etwas zum Rauchen haben.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_DOTTERSKRAUT_2_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 14;
	condition	= DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_info;
	description	= "Für diese Bestellung brauche ich mehr Geld.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_00"); //Sag mal, das ist doch ein Witz oder? Ich bin doch kein Geldverleiher, der ein halbes Vermögen mit sich rumschleppt.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_01"); //Also wenn du mir keine Münzen für die Einkäufe gibst, dann kann ich das Zeug auch nicht einkaufen.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_2_DOTTER_02"); //Na okay, du hast Recht. Du kriegst mehr, wenn du etwas lieferst.
	Reward(150);
	Quest(TOPIC_DotterKraut, T_ENTRY, "Ich habe vom Dotter zumindest 150 Roperi für meine Auslagen bekommen. Mehr gibt es erst bei Lieferung.");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_DOTTERSKRAUT_3_JOHANN (C_INFO)
{
	npc			= loa_vlk_6244_johann;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_info;
	description	= "Ich habe von deinen leckeren Fleischspießen gehört.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_00"); //Ich habe von deinen leckeren Fleischspießen gehört. Kann ich welche bekommen?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_01"); //Tris wollte mir eigentlich das saftige Fleisch dafür liefern, doch er ließ nichts mehr von sich hören.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_02"); //Weißt du zufällig, wo ich leckeres Bier herbekomme?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_03"); //Ich habe welches zu verkaufen.
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_04"); //Würde das auch einem Feinschmecker gefallen?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_3_JOHANN_05"); //Sicher, warum nicht?
	CreateInvItems (self, ITFO_LOA_HELLESHEFE,15);
};
	
instance DIA_GM_K1_DOTTERSKRAUT_4_JOHANN (C_INFO)
{
	npc			= loa_vlk_6244_johann;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_info;
	description	= "Soll ich mal nach Tris schauen?";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_3_JOHANN)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_00"); //Soll ich mal nach Tris schauen?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_4_JOHANN_01"); //Tu dir keinen Zwang an. Ich würde dir ein Dutzend überlassen, wenn du es mir bringst.
	Quest(TOPIC_DotterKraut, T_ENTRY, "Johann hat keine Spieße mehr im Angebot, aber er kann mir welche machen, wenn ich ihm das Fleisch aus Tris' Jägerlager bringe.");
};
	
instance DIA_GM_K1_DOTTERSKRAUT_5_JOHANN (C_INFO)
{
	npc			= loa_vlk_6244_johann;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_info;
	description	= "Wo finde ich Tris' Lager?";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_4_JOHANN)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_00"); //Wo finde ich Tris' Lager?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_01"); //Tris' Lager ist auf dem Weg zum Hafen. Eigentlich nicht zu verfehlen.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_5_JOHANN_02"); //Wenn du das Untere Viertel verlässt, halte dich einfach an der Straße, bis du auf der rechten Seite das Jägerlager entdeckst.
	Quest(TOPIC_DotterKraut, T_ENTRY, "Tris' lager ist auf dem Weg zum Hafen auf der rechten Seite des Pfades.");
};
	
instance DIA_GM_K1_DOTTERSKRAUT_6_TRIS (C_INFO)
{
	npc			= loa_none_30166_tris;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_6_TRIS_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_6_TRIS_info;
	description	= "Johann wartet auf sein Fleisch.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_6_TRIS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_5_JOHANN)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_6_TRIS_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_6_TRIS_00"); //Johann wartet auf sein Fleisch.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_6_TRIS_01"); //Oh ja, stimmt ja. Ich wollte eigentlich schon eher los, aber diese dummen Fleischwanzen ließen mich kaum schlafen.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_6_TRIS_02"); //Ich hab's wohl vergessen. Da du ja da bist, kannst du die Lieferung ja direkt mitnehmen.
	CreateAndGive(ItMi_Meatpaket, 1);
	Quest(TOPIC_DotterKraut, T_ENTRY, "Ich habe das Paket für Johann.");
};
	
instance DIA_GM_K1_DOTTERSKRAUT_7_JOHANN (C_INFO)
{
	npc			= loa_vlk_6244_johann;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_info;
	description	= "Ich habe das Fleischpaket.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_condition()
{
	if HItem(ItMi_MeatPaket, 1)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_6_TRIS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_00"); //Ich habe das Fleischpaket.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_7_JOHANN_01"); //Gut, gib her. Es wird so eine Stunde dauern, bis ich die Dinger gebraten und gewürzt habe.
	TIMEVAR_Johann_Fleisch = Wld_GetTimePlus(0,1,0);
	Npc_ExchangeRoutine(self, "Fleischspies");
	Take(ItMi_Meatpaket, 1);
};
	
instance DIA_GM_K1_DOTTERSKRAUT_8_JOHANN (C_INFO)
{
	npc			= loa_vlk_6244_johann;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_info;
	permanent	= TRUE;
	description	= "Ist das Fleisch fertig?";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_7_JOHANN)
	&& MISVAR_Johann_Fleisch == FALSE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_00"); //Ist das Fleisch fertig?
	if Wld_isAfterTime(TIMEVAR_Johann_Fleisch){
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_01"); //Ja, hier sind die schönen Teile. Wie viele willst du?
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_02"); //Zehn Stück reichen mir.
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_03"); //Da du mir das Fleisch gebracht hast, kriegst du diese zehn mal umsonst.
		CreateAndGive(ItFo_Spies, 10);
		Npc_ExchangeRoutine(self, "start");
		Quest(TOPIC_DotterKraut, T_ENTRY, "Die Spieße hab ich jetzt.");
		MISVAR_Johann_Fleisch = TRUE;
	}else{
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_8_JOHANN_04"); //Das Fleisch braucht noch ein wenig.	
	};
	
	
	
};
	
instance DIA_GM_K1_DOTTERSKRAUT_9_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_9_NEMS_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_9_NEMS_info;
	description	= "Weißt du vielleicht, wo ich was zu rauchen bekomme?";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_9_NEMS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_9_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_00"); //Weißt du vielleicht, wo ich was zu rauchen bekomme?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_01"); //Wieso kommst du ausgerechnet zu mir?
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_02"); //Keine Ahnung, du scheinst der Typ für sowas zu sein.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_03"); //Wozu brauchst du die denn?
	Info_ClearChoices (DIA_GM_K1_DOTTERSKRAUT_9_NEMS);
	Info_AddChoice (DIA_GM_K1_DOTTERSKRAUT_9_NEMS, "Wozu wohl? Ich will mir einen durchziehen.", DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1);
	Info_AddChoice (DIA_GM_K1_DOTTERSKRAUT_9_NEMS, "Dotter will welche haben.", DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2);
};
	
FUNC void DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1()
{
	Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1_00"); //Wozu wohl? Ich will mir einen durchziehen.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1_01"); //Na dann kostet es dich 30 Roperi pro Stengel.
	Info_ClearChoices (DIA_GM_K1_DOTTERSKRAUT_9_NEMS);
	Quest(TOPIC_DotterKraut, T_ENTRY, "Ein Stengel Sumpfkraut kostet bei Nems 30 Roperi. Ich denke, Dotter wird mit fünf Stück zufrieden sein.");
};
	
FUNC void DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2()
{
	Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2_00"); //Dotter will welche haben.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2_01"); //Dotter, was? Hmm... Ja, ich könnte welche auftreiben, aber das kostet dich dann 50 Roperi den Stengel.
	Info_ClearChoices (DIA_GM_K1_DOTTERSKRAUT_9_NEMS);
	Quest(TOPIC_DotterKraut, T_ENTRY, "Ein Stengel Sumpfkraut kostet bei Nems 50 Roperi. Ich denke, Dotter wird mit drei Stück zufrieden sein.");
};
	
instance DIA_GM_K1_DOTTERSKRAUT_10_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_10_NEMS_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_10_NEMS_info;
	permanent	= TRUE;
	description	= "Ich will Sumpfkrautstengel kaufen.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_10_NEMS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_9_NEMS)
	&& MISVAR_Bought_Weed == FALSE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_10_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_00"); //Ich will Sumpfkrautstengel.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_01"); //Wieviele?
	if Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1{
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_02"); //Gib mir fünf Stück.
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_03"); //Das macht dann 150 Roperi.
	}else if Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2{
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_04"); //Gib mir drei Stück.
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_05"); //Das macht dann 150 Roperi.
	};
	if (HGold(150)){
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_06"); //Hier.
		Pay(150);
		if Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_1{
			CreateAndGive(ItMi_Joint, 5);
		}else if Bekannt_DIA_GM_K1_DOTTERSKRAUT_9_NEMS_2{
			CreateAndGive(ItMi_Joint, 3);
		};	
		MISVAR_Bought_Weed = TRUE;
	}else{	
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_10_NEMS_07"); //Bring mir erst die Münzen.
		AI_StopProcessInfos (self);
	};
};
	
instance DIA_GM_K1_DOTTERSKRAUT_11_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_info;
	permanent	= TRUE;
	description	= "Ich habe, was du wolltest.";
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_DOTTERSKRAUT_1_DOTTER_QUEST)
	&& ((HItem(ItFo_Spies,10) && AMBVAR_Spiese == FALSE)
	|| (HItem(ITFO_LOA_HELLESHEFE,12 && AMBVAR_Bier == FALSE))
	|| (HItem(ITFO_LOA_HOFSBRAEU,12 && AMBVAR_Bier == FALSE))
	|| (HItem(ITFO_LOA_FRISCHEBRIESE,12 && AMBVAR_Bier == FALSE)) 
	|| (HItem(ITFO_LOA_STARKEBRIESE,12 && AMBVAR_Bier == FALSE))
	|| (HItem(ITFO_LOA_BERGTRUNK,12 && AMBVAR_Bier == FALSE))
	|| (HItem(ITMi_Joint, 3) && AMBVAR_Weed == FALSE))
	&& (AMBVAR_Weed == FALSE||AMBVAR_Bier == FALSE||AMBVAR_Spiese == FALSE)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_00"); //Ich habe, was du wolltest.
	if (HItem(ItFo_Spies,10) 
	&& AMBVAR_Spiese == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_01"); //Hier sind Johanns Fleischspieße.
		TakeAndDestroy(ItFo_Spies,10);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_02"); //Hmm... Lecker.
		Reward(60);
		AMBVAR_Spiese = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Ich habe Dotter die Fleischspieße gebracht.");
	};
	if (HItem(ITFO_LOA_HELLESHEFE,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_03"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_HELLESHEFE,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_04"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	if (HItem(ITFO_LOA_HOFSBRAEU,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_05"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_HOFSBRAEU,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_06"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
			Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	if (HItem(ITFO_LOA_FREIERADLER,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_07"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_FREIERADLER,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_08"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	if (HItem(ITFO_LOA_FRISCHEBRIESE,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_09"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_FRISCHEBRIESE,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_10"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	
	if (HItem(ITFO_LOA_STARKEBRIESE,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_11"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_STARKEBRIESE,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_12"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	if (HItem(ITFO_LOA_BERGTRUNK,12) 
	&& AMBVAR_Bier == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_13"); //Hier dein schmackhaftes Bier.
		TakeAndDestroy(ITFO_LOA_BERGTRUNK,12);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_14"); //Das sieht köstlich aus.
		Reward(120);
		AMBVAR_Bier = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Dotter wird sich das Bier sicher schmecken lassen.");
	};
	if (HItem(ITMi_Joint, 5) 
	&& AMBVAR_Weed == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_15"); //Hier ist was zum Rauchen.
		TakeAndDestroy(ITMi_Joint, 5);
		Reward(200);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_16"); //Super! Die sind hier in der Goldmine nur zu Wucherpreisen von 50 Roperi pro Stengel aufzutreiben.
		AMBVAR_Weed = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Hoffentlich übertreibt er es nicht mit dem Rauchen.");
	};
	if (HItem(ITMi_Joint, 3) 
	&& AMBVAR_Weed == FALSE){
		AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_17"); //Hier ist was zum Rauchen.
		TakeAndDestroy(ITMi_Joint, 3);
		Reward(120);
		AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_11_DOTTER_18"); //Super, die sind hier in der Goldmine nur zu Wucherpreisen von 50 Roperi pro Stengel aufzutreiben.
		AMBVAR_Weed = TRUE;
		Quest(TOPIC_DotterKraut, T_ENTRY, "Hoffentlich übertreibt er es nicht mit dem Rauchen.");
	};
	
	
	
};
	
instance DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_condition;
	information	= DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_condition()
{
	if AMBVAR_Weed == TRUE
	&& AMBVAR_Bier == TRUE
	&& AMBVAR_Spiese == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_00"); //Ich danke dir für deine Mühen.
	XP(200);
	Reward(20);
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_01"); //So eine mickrige Belohnung für soviel Lauferei?
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_02"); //Hatte ich dir nicht angeboten, dir das Schürfen zu zeigen?
	AI_Output (other, self, "DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_03"); //Ja.
	AI_Output (self, other, "DIA_GM_K1_DOTTERSKRAUT_12_DOTTER_SUCCESS_04"); //Na, findest du das nicht viel wertvoller? Damit kannst du dir wahre Reichtümer anhäufen!
	Quest(TOPIC_DotterKraut, T_SUCCESS, "Ich habe Dotter alles gebracht und eine eher mickrige Belohnung erhalten. Dafür kann ich zumindest jetzt bei ihm das Schürfen erlernen.");
};
	
instance DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_condition;
	information	= DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_info;
	description	= "Könntest du mir was Besonderes kochen?";
};

FUNC int DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ZARA_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_00"); //Könntest du mir was Besonderes kochen, wenn ich dir die Zutaten bringe?
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_01"); //Aber sicherlich. Umar schleppte vor kurzem noch ein paar Minecrawlerzangen an.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_02"); //Keine Ahnung, wo er die her hatte. Aber ich konnte aus dem wenigen Fleisch, das darin zu finden ist, noch einen guten Gulasch machen.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_03"); //Man muss die Zangen aufbrechen und die filigranen Muskelfasern herausholen.
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_04"); //Klingt etwas unkonventionell, aber vielleicht in der Tat eine Delikatesse.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_05"); //Erst kürzlich kam einer der Rekruten und wollte wieder was von dem Crawlereintopf, doch ich musste ihn vertrösten.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_06"); //Der hat mir doch tatsächlich Gold angeboten, wenn ich ihm welchen mache.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_07"); //Aber ohne Crawlerzangen ist da nichts zu machen.
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_08"); //War die Zubereitung schwer?
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_09"); //Ich musste die Zangen zwar stundenlang kochen, bis der bittere Geschmack weg war, aber sonst hat es den Rekruten geschmeckt.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_10"); //Die meinten sogar, dass sie sich danach viel stärker fühlten. Ich konnte den Eintopf gar nicht mehr probieren, da alles so schnell weg war.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_11"); //Umar hat mich dafür doch glatt gelobt.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_12"); //Zehn Stück sollten es aber schon sein, wenn du satt werden willst.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_13"); //Außerdem wäre Salz nicht verkehrt. Meins ist mir ausgegangen, aber das kannst du bestimmt beim Proviantmeister finden.
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST_14"); //Schön, also wenn ich Crawlerzangen finde, dann bringe ich dir welche.
	Quest(TOPIC_CrawlerEintopf, T_NEW, "Zara kann mir einen besonderen Eintopf machen. Dafür bräuchte sie aber mindestens zehn Minecrawlerzangen. Außerdem braucht sie noch Salz.");
};
	
instance DIA_GM_K1_CRAWLEREINTOPF_2_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_condition;
	information	= DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_info;
	description	= "Wo finde ich den Proviantmeister?";
};

FUNC int DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_00"); //Wo finde ich den Proviantmeister?
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_2_ZARA_01"); //Der Proviantmeister ist in der Küche bei den Schlafplätzen im oberen Teil der Mine zu finden.
	Info(info_mine, "Der Proviantmeister ist bei den Schlafplätzen im oberen Teil der Mine zu finden.");
};
	
instance DIA_GM_K1_CRAWLEREINTOPF_3_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_condition;
	information	= DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_info;
	permanent	= TRUE;
	description	= "Ich habe die Crawlerzangen und das Salz.";
};

FUNC int DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_condition()
{
	if HItem(ItAt_CrawlerMandibles, 10)
	&& HItem(ItMi_Salz, 1)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_CRAWLEREINTOPF_1_ZARA_QUEST)
	&& AMBVAR_Eintopf == FALSE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_00"); //Ich habe die Crawlerzangen und das Salz. Hier!
	TakeAndDestroy(ItAt_CrawlerMandibles, 10);
	TakeAndDestroy(ItMi_Salz, 1);
	AMBVAR_Eintopf = TRUE;
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_01"); //Super, danke!
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_02"); //Also noch zwei Heilkräuter... Drei Prisen Salz und... Ach ja, das Zangenfleisch.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_03"); //Gut, dann hätte ich alles.
	AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_3_ZARA_04"); //Ich lass das Fleisch auf jeden Fall ein wenig ziehen. Komm einfach in sechs Stunden wieder. Dann ist er auf jeden Fall fertig.
	TIMEVAR_Zara = Wld_GetTimePlus(0,6,0);
	Npc_ExchangeRoutine(self, "Eintopf");
	if (!Bekannt_DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS){
		Quest(TOPIC_CrawlerEintopf, T_ENTRY, "Zara macht mir den Eintopf fertig. Ich soll in sechs Stunden wiederkommen.");
	};
};
	
instance DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_condition;
	information	= DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_info;
	permanent	= TRUE;
	description	= "Ist der Crawlereintopf fertig?";
};

FUNC int DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_condition()
{
	if AMBVAR_Eintopf == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_info()
{
	Bekannt_DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_00"); //Ist der Crawlereintopf fertig?
	if (AMBVAR_Eintopfgiven == TRUE)
	&& HGold(40)
	&& Wld_isAfterTime(TIMEVAR_Zara){
		AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_01"); //Erst die Münzen.
		Pay(40);
	}else if Wld_isAfterTime(TIMEVAR_Zara)
	&& AMBVAR_Eintopfgiven == TRUE{
		AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_02"); //Du hast nicht genügend Roperi dabei.
		AI_StopProcessInfos (self);
	};
	if Wld_isAfterTime(TIMEVAR_Zara){
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_03"); //Ja, hier hast du eine Portion.
		if AMBVAR_Eintopfgiven == TRUE{
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_04"); //Hier.
			AMBVAR_Eintopf = FALSE;
			CreateAndGive(ItFo_StrStew, 1);
			AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_05"); //Danke dir.
			NewRout(self, "start");
		}else{
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_06"); //Weitere werden dich aber was kosten. Ich will 40 Roperi pro Eintopf.
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_07"); //Schließlich muss ich ja auch noch die anderen Zutaten bezahlen.
			AMBVAR_Eintopfgiven = TRUE;
			AMBVAR_Eintopf = FALSE;
			CreateAndGive(ItFo_CrawlerStew_MIS, 1);
			AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_08"); //Danke dir.
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_09"); //Ach ja, wenn du mir noch mehr Crawlerzangen bringen kannst, dann kauf ich dir die gerne ab.
			AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_10"); //Die Leute reißen sich um meinen Eintopf.
			NewRout(self, "start");
			Quest(TOPIC_CrawlerEintopf, T_SUCCESS, "Zara macht mir den Eintopf fertig. Ich soll in sechs Stunden wiederkommen.");
		};
	}else{
		AI_Output (self, other, "DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS_11"); //Leider nicht. Es wird wohl noch eine Zeit lang dauern.
	};
};
	
instance DIA_GM_K1_CRAWLEREINTOPF_5_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_CRAWLEREINTOPF_5_ZARA_condition;
	information	= DIA_GM_K1_CRAWLEREINTOPF_5_ZARA_info;
	permanent	= TRUE;
	trade		= TRUE;
	description	= "Zeig mir deine Ware. (Handel)";
};

FUNC int DIA_GM_K1_CRAWLEREINTOPF_5_ZARA_condition()
{
	if Bekannt_DIA_GM_K1_CRAWLEREINTOPF_4_ZARA_SUCCESS
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_CRAWLEREINTOPF_5_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_CRAWLEREINTOPF_5_ZARA_00"); //Zeig mir deine Ware.
	
	B_GiveTradeInv (self);
};
	
instance DIA_GM_K1_MORSKILL_1_RODG_QUEST (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_1_RODG_QUEST_condition;
	information	= DIA_GM_K1_MORSKILL_1_RODG_QUEST_info;
	description	= "Ich glaube, du steckst hinter dem Mord an Mors.";
};

FUNC int DIA_GM_K1_MORSKILL_1_RODG_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_1_RODG_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_00"); //Etwas verdächtig die Sache mit Mors. Er stirbt, kurz nachdem er dir ein Gerücht erzählt.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_01"); //Hey, du Bengel! Du hast doch nicht mich im Verdacht, oder?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_02"); //Es sieht sehr danach aus.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_03"); //Das kannst du dir sofort abschminken. Ich hab gar keinen Grund, mich mit jemandem zu streiten.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_04"); //Kannst ruhig die Leute hier fragen. Glaub mir, ich hätte gar nicht den Mumm dazu.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_05"); //Aber die bezahlten Eintreiber könnten das für dich erledigt haben.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_06"); //Die Eintreiber? Gar nicht so 'ne schlechte Idee.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_07"); //Was? Du gibst es zu?!
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_08"); //(hastig) Aber nein, hör auf mit dem Unsinn. Ich meinte, dass die Eintreiber Mors für jemanden umgebracht haben.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_09"); //Immerhin hat er sich ja auch geweigert, das Schutzgeld zu zahlen. Vielleicht kam es ihnen ganz gelegen, wenn jemand mit so einer Bitte antanzt.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_10"); //Du könntest Recht haben.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_11"); //Versuch die doch einfach ein wenig auszuquetschen. Irgendjemand verplappert sich bestimmt.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_12"); //Nur wer hätte was davon, dass Mors seinen Mund nicht mehr aufmachen kann?!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_1_RODG_QUEST_13"); //Hmm... Ich werde der Sache nachgehen. Ich schau mal, wer was weiß.
	Quest(TOPIC_MorsKill, T_NEW, "Mors könnte von den Eintreibern getötet worden sein. Ich sollte mich mal umhören, wer etwas davon hätte.");
};
	
instance DIA_GM_K1_MORSKILL_2_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_2_ZARA_condition;
	information	= DIA_GM_K1_MORSKILL_2_ZARA_info;
	description	= "Weißt du was über Mors?";
};

FUNC int DIA_GM_K1_MORSKILL_2_ZARA_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_3)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG))
	&& Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_1_RODG_QUEST)
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_2_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_2_ZARA_00"); //Weißt du was über Mors?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_2_ZARA_01"); //Ach, der arme Junge. Ich habe ihm immer die Reste meines Eintopfs gegeben, wenn er spät nachts nochmal vorbeikam.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_2_ZARA_02"); //Einfach nur traurig, dass er jetzt tot ist.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_2_ZARA_03"); //Weißt du vielleicht, wer dafür verantwortlich ist?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_2_ZARA_04"); //Ach nein, woher denn auch? Er hat zwar viel mit mir geredet - ich denke er hatte sonst kaum Freunde - aber woher sollte ich denn wissen, womit er das verdient hat?!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_2_ZARA_05"); //Hat er irgendwas Merkwürdiges dir gegenüber erwähnt?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_2_ZARA_06"); //Nein. Er ließ sich, wie viele hier, oft über Dotters Engstirnigkeit aus.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_2_ZARA_07"); //Jeden Tag erzählte er mir, dass Dotter sich weigerte, ihm das Schürfen beizubringen.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_2_ZARA_08"); //Aha, das ist doch schon mal was.
	Quest(TOPIC_MorsKill, T_ENTRY, "Zara meinte, dass Mors sich stets über Dotter beschwert hat, da er ihm das Schürfen nicht beibringen wollte.");
};
	
instance DIA_GM_K1_MORSKILL_3_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_3_DOTTER_condition;
	information	= DIA_GM_K1_MORSKILL_3_DOTTER_info;
	description	= "Du erwähntest Mors. Was weißt du darüber?";
};

FUNC int DIA_GM_K1_MORSKILL_3_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_3)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_1_RODG_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_3_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_3_DOTTER_00"); //Du erwähntest Mors. Was weißt du darüber?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_3_DOTTER_01"); //(aufgeschreckt) Mors? Wieso fragst du? Ich weiß nichts über Mors.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_3_DOTTER_02"); //Das sieht mir irgendwie anders aus.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_3_DOTTER_03"); //(hektisch) Nein, nein. Ich weiß da nichts. Jetzt geh, ich muss weiterarbeiten!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORSKILL_4_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_4_MORTY_condition;
	information	= DIA_GM_K1_MORSKILL_4_MORTY_info;
	description	= "Was weißt du über Mors' Tod?";
};

FUNC int DIA_GM_K1_MORSKILL_4_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_1_RODG_QUEST)
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_4_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_4_MORTY_00"); //Was weißt du über Mors' Tod? Du warst doch mit ihm befreundet.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_4_MORTY_01"); //Hat er sich vor seinem Tod seltsam verhalten?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_4_MORTY_02"); //Mors? Hmm... Ja, jetzt wo du es sagst... Ich habe ihn gefragt, was mit ihm los sei, doch er hat sich vor mir verschlossen.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_4_MORTY_03"); //Und davor? Was hat er vorher so gemacht?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_4_MORTY_04"); //Ich weiß nur, dass er immer wieder zu Dotter ging, um ihn nach Tipps auszufragen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_4_MORTY_05"); //Frag am besten Furt, der hing die letzten Tage vor der Tragödie mit Mors rum.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_4_MORTY_06"); //Vielleicht hat er ihn ja sogar getötet... Wer weiß...
	Quest(TOPIC_MorsKill, T_ENTRY, "Mors hing oft mit Furt, einem der Buddler rum. Vielleicht hat dieser ihn getötet. Noch habe ich keinen konkreten Verdacht.");
};
	
instance DIA_GM_K1_MORSKILL_5_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 5;
	condition	= DIA_GM_K1_MORSKILL_5_FURT_condition;
	information	= DIA_GM_K1_MORSKILL_5_FURT_info;
	description	= "Ich habe gehört, dass du mit Mors rumgehangen hast.";
};

FUNC int DIA_GM_K1_MORSKILL_5_FURT_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_4_MORTY)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_5_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_00"); //Ich habe gehört, dass du mit Mors rumgehangen hast.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_5_FURT_01"); //Wer hat dir das erzählt?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_02"); //Ist das wichtig?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_5_FURT_03"); //Nun ja, eigentlich nicht.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_04"); //Weißt du, warum Mors draufgegangen ist?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_5_FURT_05"); //(flüsternd) Wieso willst du das wissen? Kannst du es nicht einfach damit belassen?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_06"); //(erzürnt) Nein, kann ich nicht! Irgendjemand hat ihn umgebracht und diese nutzlosen Rekruten scheren sich einen Dreck darum.
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_4){
		AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_07"); //Laut Umar gibt es keine 'Spuren' mehr zum Verfolgen.
	};
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_5_FURT_08"); //(leise) Hey, mach hier nicht so einen Radau! Die Eintreiber sind hier überall.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_5_FURT_09"); //Na und? Was haben die damit zu tun?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_5_FURT_10"); //Ich wollte das eigentlich für mich behalten, um nicht auch noch auf die Abschussliste zu gelangen... Also erzähl das jetzt nicht weiter!
	
	
};
	
instance DIA_GM_K1_MORSKILL_6_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 5;
	condition	= DIA_GM_K1_MORSKILL_6_FURT_condition;
	information	= DIA_GM_K1_MORSKILL_6_FURT_info;
	description	= "Jetzt spuck's schon aus!";
};

FUNC int DIA_GM_K1_MORSKILL_6_FURT_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_5_FURT)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_6_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_6_FURT_00"); //Jetzt spuck's schon aus!
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_01"); //Okay, okay... Aber du hast das nicht von mir!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_6_FURT_02"); //Ich werde dich nicht ans Messer liefern. Das, was du sagst bleibt unter uns, okay?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_03"); //Also gut. Ich habe da mit Mors ein paar Sachen angestellt, nachdem wir Freunde wurden.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_04"); //Eines davon war, dass wir Dotter bespitzelt haben und dabei herausfanden, dass er ein Buch über's Schürfen besaß.
	if(Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)){
		AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_05"); //Aber das weißt du ja schon.
		if(SuccessQ(TOPIC_AllesFuersGold)){
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_06"); //Das Buch, das du mir gebracht hast, wollten wir unbedingt haben.
		};
	}else{
		AI_Output (self, other, "DIA_GM_K1_MORSKILL_6_FURT_07"); //Wir wollten dieses Buch unbedingt haben, da Dotter sich immer geweigert hatte, irgendwem das Buddeln zu zeigen.
	};
};
	
instance DIA_GM_K1_MORSKILL_7_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 5;
	condition	= DIA_GM_K1_MORSKILL_7_FURT_condition;
	information	= DIA_GM_K1_MORSKILL_7_FURT_info;
	description	= "Und Mors hat das Buch geklaut?";
};

FUNC int DIA_GM_K1_MORSKILL_7_FURT_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_6_FURT)
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_7_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_7_FURT_00"); //Und Mors hat das Buch geklaut?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_7_FURT_01"); //Schlimmer! Er versuchte Dotter damit zu erpressen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_7_FURT_02"); //Er wollte ihn damit bloßstellen, damit die Leute erfahren, was für ein Weichei er eigentlich ist und sich mit fremdem Wissen schmückt.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_7_FURT_03"); //Ich seh's schon kommen...
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_7_FURT_04"); //Ja... Ich denke, Dotter hat das den Eintreibern erzählt und sie gebeten, ihn mundtot zu machen - oder Schlimmeres.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_7_FURT_05"); //Mit einem ordentlichen Schmiergeld geht das auch ganz einfach.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_7_FURT_06"); //Gut. Ich denke, das reicht mir.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_7_FURT_07"); //Hör mal, dass hast du nicht von mir! Ich will nicht sterben!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_7_FURT_08"); //(genervt) Ist ja gut! Ich sagte doch schon, dass dir nichts passiert!
	AI_StopProcessInfos (self);
	Quest(TOPIC_MorsKill, T_ENTRY, "Mors hat Dotter mit dessen Buch über die Kunst des Schürfens erpresst und musste wahrscheinlich dafür mit seinem Leben bezahlen.");
	
};
	
instance DIA_GM_K1_MORSKILL_8_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_8_UMAR_condition;
	information	= DIA_GM_K1_MORSKILL_8_UMAR_info;
	description	= "Ich habe eine Spur auf Mors' Mörder gefunden.";
};

FUNC int DIA_GM_K1_MORSKILL_8_UMAR_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_7_FURT)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_4)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_1_DOTTER)
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_8_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_8_UMAR_00"); //Ich habe eine Spur auf Mors' Mörder gefunden.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_01"); //Tatsächlich? Schon wieder so eine wilde Vermutung?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_8_UMAR_02"); //Diesmal ist es fundiert.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_03"); //Und wer hat dir das erzählt?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_8_UMAR_04"); //Das spielt keine Rolle. Wichtig ist nur, dass Dotter aktiv oder passiv an dem Mord an Mors beteiligt war.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_05"); //Dotter? Das kann ich nicht glauben. Der Typ ist zwar geizig wie die Nacht, doch das traue ich ihm eigentlich nicht zu.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_8_UMAR_06"); //Das ist in diesem Fall irrelevant. Er hat etwas damit zu tun.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_8_UMAR_07"); //Das ist doch eine Spur, der ihr nachgehen könnt, oder?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_08"); //Also solange du mir keine Beweise bringst, kann ich nicht wirklich helfen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_09"); //Wer weiß, woher du diese unzuverlässige Info hast.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_8_UMAR_10"); //Tut mir leid, aber mir sind die Hände gebunden.
	Quest(TOPIC_MorsKill, T_ENTRY, "Umar will weiterhin nichts zur Aufklärung des Mordfalls beitragen. Ich soll ihm stichhaltige Beweise bringen.");
};
	
instance DIA_GM_K1_MORSKILL_9_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_9_DOTTER_condition;
	information	= DIA_GM_K1_MORSKILL_9_DOTTER_info;
	description	= "Noch mal wegen Mors.";
};

FUNC int DIA_GM_K1_MORSKILL_9_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_7_FURT)
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_9_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_00"); //Noch mal wegen Mors. Da hat mir jemand aber mehr erzählt.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_9_DOTTER_01"); //(unsicher) Was?! Erzähl doch keinen Scheiß! Ich weiß von nichts, also lass mich in Ruhe!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_02"); //Ich denke, die Rekruten werden das anders sehen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_9_DOTTER_03"); //Was genau willst du von mir? Du kommst hier mit wilden Spekulationen und versuchst, mich zu erpressen.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_04"); //Tja, dem Mors ist das auch nicht gelungen, was?!
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_9_DOTTER_05"); //(leicht panisch) Ich weiß nicht, was du meinst.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_06"); //Doch, das weißt du! Und wenn du es weiterhin verleugnest, dann gehst du mitsamt den Eintreibern ins Verlies von Ahssûn.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_07"); //Ach ja, auf Mord steht mindestens die Arena. Und ich bezweifle irgendwie, dass du dort bestehen kannst.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_9_DOTTER_08"); //Diesmal ist keiner vom Triumvirat da, um dir den Arsch zu retten.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_9_DOTTER_09"); //Verdammter Dreckskerl. Na warte!
	AI_StopProcessInfos (self);
	B_Attack(self, hero, AR_NONE, 1);
};
	
instance DIA_GM_K1_MORSKILL_10_1_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_10_1_DOTTER_condition;
	information	= DIA_GM_K1_MORSKILL_10_1_DOTTER_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_MORSKILL_10_1_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_9_DOTTER)
	&& self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_10_1_DOTTER_info()
{
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_00"); //Warte, warte! Ist ja gut. Ich erzähl dir alles.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_10_1_DOTTER_01"); //Wieso nicht gleich? Wieso versteht ihr Kerle eigentlich nur die schmerzliche Sprache der Waffe?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_02"); //Ich wollte doch nicht, dass Mors drauf geht.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_10_1_DOTTER_03"); //Sondern?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_04"); //Ich habe den Eintreibern 150 Roperi gegeben und ihnen gesagt, dass sie ihm mal ordentlich Angst machen sollen und ihm raten, die Sache mit dem Buch für sich zu behalten.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_10_1_DOTTER_05"); //Das Schürferbuch?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_06"); //Du weißt davon? Egal... Ja genau das... Der kleine Drecksack hatte mich erpresst. Da hab ich wohl einen Fehler gemacht, als ich mich auf die Eintreiber verlassen habe.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_10_1_DOTTER_07"); //Wem hast du den Auftrag gegeben?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_08"); //Es waren Togen, Kunislav und Frand.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_09"); //Woher hätte ich denn wissen sollen, das die den gleich umlegen?!
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_10_1_DOTTER_10"); //Lass dich beim nächsten Mal einfach nicht mehr mit diesem Pack ein.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_1_DOTTER_11"); //Okay, ich hab aus meinem Fehler gelernt...
	Quest(TOPIC_MorsKill, T_ENTRY, "Dotter hat die Eintreiber auf Mors angesetzt. Togen, Frand und Kunislav waren die Ansprechpersonen bei diesem Auftrag. Ich sollte einem dieser Eintreiber etwas entlocken können.");
};
	
instance DIA_GM_K1_MORSKILL_10_2_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_10_2_DOTTER_condition;
	information	= DIA_GM_K1_MORSKILL_10_2_DOTTER_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_MORSKILL_10_2_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_9_DOTTER)
	&& self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_WON
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_10_2_DOTTER_info()
{
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_2_DOTTER_00"); //Lass dir das eine Lehre sein. Und wehe, du erzählst noch einmal so einen Mist über mich.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_10_2_DOTTER_01"); //Dann schick ich dir das Triumvirat auf den Hals!
	AI_StopProcessInfos (self);
	Quest(TOPIC_MorsKill, T_ENTRY, "Dotter hat mich angegriffen, nachdem ich ihn zur Rede gestellt habe. Dies zeugt klar von seiner Schuld. Ich sollte mich bei den Eintreibern umhören.");
};
	
instance DIA_GM_K1_MORSKILL_11_2_KUNISLAV (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_11_2_KUNISLAV_condition;
	information	= DIA_GM_K1_MORSKILL_11_2_KUNISLAV_info;
	description	= "Wieso habt ihr Mors getötet?";
};

FUNC int DIA_GM_K1_MORSKILL_11_2_KUNISLAV_condition()
{
	if !Bekannt_DIA_GM_K1_MORSKILL_11_2_FRAND_1_3
	&& (Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_2_DOTTER)||Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_1_DOTTER))
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_11_2_KUNISLAV_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_00"); //Wieso habt ihr Mors getötet?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_01"); //(gelassen) Was? Welcher Spinner hat dir denn das erzählt?
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_KUNISLAV);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_KUNISLAV, "Dotter. Er hat aus dem Nähkästchen geplaudert.", DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_KUNISLAV, "Ein Vögelchen hat's mir gezwitschert.", DIA_GM_K1_MORSKILL_11_2_KUNISLAV_2);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_00"); //Dotter. Er hat aus dem Nähkästchen geplaudert.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_01"); //Tatsächlich? Und was hat er so erzählt?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_02"); //Na, dass er die Eintreiber angeheuert hat.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_03"); //Wieso sollte er dir das erzählen?
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_KUNISLAV);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_KUNISLAV, "Weil ich eure Dienste brauche.", DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_KUNISLAV, "Er wollte sich einfach nur mitteilen.", DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_4);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3()
{
	Bekannt_DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3_00"); //Weil ich eure Dienste brauche. Ich habe da jemanden, der weg muss.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3_01"); //Ach so, sag das doch gleich. Was sollen wir für dich erledigen?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3_02"); //Weiß du was, ich komme auf euch zurück.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3_03"); //Du weißt ja, wo du uns findest.
	Quest(TOPIC_MorsKill, T_ENTRY, "Kunislav hat zugegeben, das er von Dotter den Auftrag erhalten hat. Er hat mir sogar den selben Dienst angeboten. Dies sollte Umar reichen. Diesmal muss er etwas unternehmen.");
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_KUNISLAV);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_4()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_4_00"); //Er wollte sich einfach nur mitteilen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_4_01"); //Schön für ihn.
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_KUNISLAV);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_KUNISLAV_2()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_2_00"); //Ein Vögelchen hat's mir gezwitschert.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_KUNISLAV_2_01"); //Schön für dich. Jetzt verpiss dich!
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_KUNISLAV);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORSKILL_11_2_FRAND (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_11_2_FRAND_condition;
	information	= DIA_GM_K1_MORSKILL_11_2_FRAND_info;
	description	= "Wieso habt ihr Mors getötet?";
};

FUNC int DIA_GM_K1_MORSKILL_11_2_FRAND_condition()
{
	if !Bekannt_DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3
	&& (Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_2_DOTTER)||Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_1_DOTTER))
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_11_2_FRAND_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_00"); //Wieso habt ihr Mors getötet?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_01"); //(gelassen) Was? Welcher Spinner hat dir denn das erzählt?
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_FRAND);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_FRAND, "Dotter. Er hat aus dem Nähkästchen geplaudert.", DIA_GM_K1_MORSKILL_11_2_FRAND_1);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_FRAND, "Ein Vögelchen hat's mir gezwitschert.", DIA_GM_K1_MORSKILL_11_2_FRAND_2);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_FRAND_1()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_00"); //Dotter. Er hat aus dem Nähkästchen geplaudert.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_01"); //Tatsächlich? Und was hat er so erzählt?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_02"); //Na, dass er die Eintreiber angeheuert hat.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_03"); //Wieso sollte er dir das erzählen?
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_FRAND);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_FRAND, "Weil ich eure Dienste brauche.", DIA_GM_K1_MORSKILL_11_2_FRAND_1_3);
	Info_AddChoice (DIA_GM_K1_MORSKILL_11_2_FRAND, "Er wollte sich einfach nur mitteilen.", DIA_GM_K1_MORSKILL_11_2_FRAND_1_4);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_FRAND_1_3()
{
	Bekannt_DIA_GM_K1_MORSKILL_11_2_FRAND_1_3 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_3_00"); //Weil ich eure Dienste brauche. Ich habe da jemanden, der weg muss.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_3_01"); //Ach so, sag das doch gleich. Was sollen wir für dich erledigen?
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_3_02"); //Weiß du was, ich komme auf euch zurück.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_3_03"); //Du weißt ja, wo du uns findest.
	Quest(TOPIC_MorsKill, T_ENTRY, "Frand hat zugegeben, das er von Dotter den Auftrag erhalten hat. Er hat mir sogar den selben Dienst angeboten. Dies sollte Umar reichen. Diesmal muss er etwas unternehmen.");
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_FRAND);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_FRAND_1_4()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_4_00"); //Er wollte sich einfach nur mitteilen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_1_4_01"); //Schön für ihn.
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_FRAND);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_MORSKILL_11_2_FRAND_2()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_FRAND_2_00"); //Ein Vögelchen hat's mir gezwitschert.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_FRAND_2_01"); //Schön für dich. Jetzt verpiss dich!
	Info_ClearChoices (DIA_GM_K1_MORSKILL_11_2_FRAND);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORSKILL_11_2_TOGEN (C_INFO)
{
	npc			= loa_none_6437_Togen;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_11_2_TOGEN_condition;
	information	= DIA_GM_K1_MORSKILL_11_2_TOGEN_info;
	description	= "Warum habt ihr Mors kalt gemacht?";
};

FUNC int DIA_GM_K1_MORSKILL_11_2_TOGEN_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_2_DOTTER)||Npc_KnowsInfo (hero, DIA_GM_K1_MORSKILL_10_1_DOTTER))
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_11_2_TOGEN_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_11_2_TOGEN_00"); //Warum habt ihr Mors kalt gemacht?
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_11_2_TOGEN_01"); //Keine Ahnung, was du da für einen Scheiß erzählst - also verpiss dich!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_condition;
	information	= DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_info;
	description	= "Ich weiß, wer Mors umgebracht hat.";
};

FUNC int DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_condition()
{
	if Bekannt_DIA_GM_K1_MORSKILL_11_2_FRAND_1_3
	|| Bekannt_DIA_GM_K1_MORSKILL_11_2_KUNISLAV_1_3
	&& RunningQ(TOPIC_MorsKill)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_00"); //Ich weiß, wer Mors umgebracht hat.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_01"); //Die Eintreiber Frand, Togen und Kunislav haben von Dotter den Auftrag bekommen, Mors einzuschüchtern und zu verprügeln.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_02"); //Mors starb noch am selben Tag.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_03"); //Hmm, in der Tat hatte die Leiche erhebliche Prellungen.
	AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_04"); //Wir waren jedoch von einem Raubmotiv ausgegangen.
	AI_Output (other, self, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_05"); //Verhaftest du jetzt die drei Mörder?
	Quest(TOPIC_MorsKill, T_SUCCESS, "Umar weiß jetzt von Mors Mördern.");
	Quest(TOPIC_Triumvirat, T_ENTRY, "Umar weiß jetzt von Mors Mördern. Diese gehören zum Triumvirat. Dies wird sicher dabei helfen, das Triumvirat und seine Machenschaften aufzuhalten.");
	
	MISVAR_Triumvirat_bad_deeds += 1;
	
	if (RunningQ(TOPIC_TRIUMVIRAT)){
		if (MISVAR_Triumvirat_bad_deeds < 3){
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_06"); //Leider reichen die Beweise nicht aus.
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_07"); //Momentan können wir nur die Augen offen halten.	
		}else{
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_08"); //Ja, das reicht mir. Die kriminelle Energie des Triumvirats ist eindeutig.
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_09"); //Ich werde Verstärkung aus der Stadt anfordern, um sie problemlos verhaften zu können.
			AI_Output (self, other, "DIA_GM_K1_MORSKILL_12_UMAR_SUCCESS_10"); //Du wirst die Nachricht an Cortez überbringen. Dieser wird sie dann an Hamilkar weiterleiten.
			CreateAndGive(ItWr_VerstaerkungfuerUmar,1);
			MISVAR_Triumvirat_bad_deeds += 10;
			if RunningQ(TOPIC_Riot){
				Quest(TOPIC_Riot, T_ENTRY, "Ich werde den Rekruten dabei helfen, das Triumvirat aufzuhalten.");	
			};
			if !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA){
				Quest(TOPIC_Triumvirat, T_ENTRY, "Umar hat mir sein Gesuch um Verstärkung gegeben. Ich soll es Cortez bringen, damit dieser es an Hamilkar weiterleiten kann. Hamilkar wiederum wird sich dann um ausreichend Männer kümmern, die das Triumvirat dingfest machen sollen.");
			};
		};
	};
};
	
instance DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST (C_INFO)
{
	npc			= loa_none_6447_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_condition;
	information	= DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_info()
{
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_00"); //Verdammt, ich habe bei all der Hektik mein Gold vergessen!
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_01"); //Und ich kann auch nicht mehr zurück.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_02"); //Könntest du es für mich holen?
	Info_ClearChoices (DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST);
	Info_AddChoice (DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST, "Ich habe keine Zeit mehr für deine Probleme!", DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_1);
	Info_AddChoice (DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST, "Sicher. Wo soll ich suchen?", DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2);
};
	
FUNC void DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_1()
{
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_1_00"); //Ich habe keine Zeit mehr für deine lächerlichen Probleme! Viel Glück.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_1_01"); //Come on dude...
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_1_02"); //Ich geh dann einfach ins Untere Viertel.
	NewRout(self, "UV");
	Info_ClearChoices (DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST);
};
	
FUNC void DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2()
{
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_00"); //Sicher. Wo soll ich suchen?
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_01"); //Suchen ist schon mal der richtige Ansatz. Du wirst eine Spitzhacke brauchen, um mein Gold zu heben.
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_02"); //Muss das sein?
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_03"); //Na klar. Ich musste das Gold doch irgendwo verstecken, damit die Eintreiber mich nicht abzocken konnten.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_04"); //Also ich hab es an derselben Stelle vergraben, an der du mich gefunden habt. Such dort vor dem Getreidesack.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST_2_05"); //Ich warte hier solange, bis du zurück bist.
	Quest(TOPIC_TiresGold, T_NEW, "Tires hat bei seiner panischen Flucht doch glatt sein ganzes Gold in der Mine gelassen. Es soll irgendwo bei seinem ehemaligen Versteck verbuddelt sein.");
	if (RunningQ(TOPIC_TiresSchatz)){
		Quest(TOPIC_TiresSchatz, T_ENTRY, "Tires hat mir verraten, wo er sein Gold versteckt hat. Der Don wartet bereits auf diesen Schatz.");	
	};
	MISVAR_Tires_told_hero_treasure = TRUE;
	Info_ClearChoices (DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST);
};
	
instance DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS (C_INFO)
{
	npc			= loa_none_6447_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_condition;
	information	= DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_info;
	description	= "Ich habe dein Gold.";
};

FUNC int DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TIRESGOLD_1_TIRES_QUEST)
	&& (HItem(ItMi_TiresGold, 1)
	||(HItem (ItMi_Goldnugget_Addon, 436)
	&& MISVAR_Tires_opened_treasure == TRUE))
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_00"); //Ich habe dein Gold. Hier hast du es!
	if HItem(ItMi_TiresGold, 1){
		Take(ItMi_TiresGold, 1);
	}else{
		Take(ItMi_Goldnugget_Addon, 436);
	};
	XP(100);
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_01"); //Wow, danke, damit hast du mir einen großen Gefallen getan!
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_02"); //Keine Ursache.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_03"); //Dafür kriegst du auch was von mir als Belohnung. Hier.
	CreateAndGive(ItMi_GoldNugget_Addon, 27);
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_04"); //Wow, gar nicht mal so happig.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_05"); //(lachend) Na ja, ich hab ja auch keine Schutzgelder bezahlt.
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_06"); //Jedes Mal, wenn einer vorbei kam, hab ich ihm ein oder zwei Goldbrocken zugesteckt und sie vertröstet, dass ich noch nicht mehr geschürft habe.
	AI_Output (other, self, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_07"); //Und das hat geklappt?
	AI_Output (self, other, "DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS_08"); //Ja. Na ja, zumindest bis Frand bei mir vorbeikam.
	Quest(TOPIC_TiresGold, T_SUCCESS, "Tires hat sein Gold wieder.");
	NewRout(self, "MV");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_BESTECHLICH_1_HONER (C_INFO)
{
	npc			= loa_rek_6498_Honer;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_1_HONER_condition;
	information	= DIA_GM_K1_BESTECHLICH_1_HONER_info;
	description	= "Ich habe gehört, ihr akzeptiert ein paar zusätzliche Zahlungen.";
};

FUNC int DIA_GM_K1_BESTECHLICH_1_HONER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_5)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_4_KUNISLAV_5)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_1_HONER_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_1_HONER_00"); //Ich habe gehört, ihr akzeptiert ein paar zusätzliche Zahlungen.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_1_HONER_01"); //Hä?
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_1_HONER_02"); //Na, ich meine die Schmiergelder der Eintreiber.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_1_HONER_03"); //Was? Was erzählst du da? (übertrieben) Meine Jungs sind nicht bestechlich.
};
	
instance DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_condition;
	information	= DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_info;
	description	= "Was weißt du genau über die Schmiergelder an die Rekruten?";
};

FUNC int DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_5)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_4_KUNISLAV_5)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_00"); //Was weißt du genau über die Schmiergelder an die Rekruten?
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_01"); //Umar tut nichts dagegen. Es sieht fast so aus, als wäre er dahingehend blind.
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_02"); //Ja, aber hast du Beweise, dass die Rekruten bestochen werden oder ist das nur dein Eindruck?
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_03"); //Ich habe die Drecksäcke beobachtet. Diese nächtlichen Treffen mit den Eintreibern sind unmissverständlich.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_04"); //Ich habe sogar gesehen, wie Honer einen ziemlich dicken Lederbeutel von Togen bekommen hat.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST_05"); //Abgesehen davon verpissen sich die Rekruten jedes Mal, wenn die Eintreiber aus ihrem Loch kriechen und zu uns hoch kommen.
	Quest(TOPIC_Bestechlich, T_NEW, "Morty hat Honer und Togen bei der Übergabe der Schmiergelder beobachtet.");
	B_StartOtherRoutine(loa_rek_6498_Honer, "Bestechen");
	B_StartOtherRoutine(loa_none_6437_Togen, "Bestechen");
};
	
instance DIA_GM_K1_BESTECHLICH_3_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_3_MORTY_condition;
	information	= DIA_GM_K1_BESTECHLICH_3_MORTY_info;
	description	= "Wo genau fand das letzte Treffen statt?";
};

FUNC int DIA_GM_K1_BESTECHLICH_3_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_BESTECHLICH_2_MORTY_QUEST)
	&& RunningQ(TOPIC_Bestechlich)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_3_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_3_MORTY_00"); //Wo genau fand das letzte Treffen statt?
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_3_MORTY_01"); //Ich habe sie das letzte Mal in einer ziemlich dunklen Ecke gefunden.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_3_MORTY_02"); //Die standen in einem verlassenen Gang. Aber ich bezweifle, dass sie dort bald wieder ihre dreckigen Geschäfte machen.
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_3_MORTY_03"); //Und wo könnte ich sie finden?
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_3_MORTY_04"); //Such einfach nach abgelegenen Ecken. Aber vor Mitternacht wirst du sie nicht beobachten können.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_3_MORTY_05"); //Das letzte Mal habe ich sie etwa kurz nach Mitternacht gesehen, nachdem alle anderen schlafen waren.
	Quest(TOPIC_Bestechlich, T_ENTRY, "Morty erzählte mir, dass ich Honer und Togen wahrscheinlich kurz nach Mitternacht in einem abgelegenen Gang finden könnte.");
};
	
instance DIA_GM_K1_BESTECHLICH_3_7_TOGEN (C_INFO)
{
	npc			= loa_none_6437_Togen;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_3_7_TOGEN_condition;
	information	= DIA_GM_K1_BESTECHLICH_3_7_TOGEN_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_K1_BESTECHLICH_3_7_TOGEN_condition()
{
	if Npc_GetDistToWP(loa_rek_6498_Honer, "GM_A_42") <= 600
	&& Npc_GetDistToWP(loa_none_6437_Togen, "GM_A_42") <= 600
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_3_7_TOGEN_info()
{
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_3_7_TOGEN_00"); //Hey, was machst du hier? Verpiss dich!
	AI_StopProcessInfos (self);
	AI_GotoWP(other, "GM_A_39");
};
	
instance DIA_GM_K1_BESTECHLICH_4_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_4_MORTY_condition;
	information	= DIA_GM_K1_BESTECHLICH_4_MORTY_info;
	description	= "Ich habe Honer und Togen beobachtet.";
};

FUNC int DIA_GM_K1_BESTECHLICH_4_MORTY_condition()
{
	if Bekannt_GM_K1_BESTECHLICH_3_5_FOUNDTRADE
	&& RunningQ(TOPIC_Bestechlich)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_4_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_4_MORTY_00"); //Ich habe Honer und Togen beobachtet.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_4_MORTY_01"); //Und?
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_4_MORTY_02"); //Du hattest Recht. Sie haben sich in einem verlassenen Gang versteckt.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_4_MORTY_03"); //Was willst du jetzt machen?
	if (Npc_KnowsInfo (hero, DIA_GM_K1_BESTECHLICH_5_UMAR)){
		AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_4_MORTY_04"); //Ich habe es Umar bereits erzählt.
	}else{
		AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_4_MORTY_05"); //Ich werde es Umar erzählen. Vielleicht unternimmt er was, wenn wir beide bezeugen können, dass wir die Schmiergeldübergabe gesehen haben.
	};
};
	
instance DIA_GM_K1_BESTECHLICH_5_UMAR (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_5_UMAR_condition;
	information	= DIA_GM_K1_BESTECHLICH_5_UMAR_info;
	description	= "Ich habe beobachtet, wie die Rekruten bestochen werden.";
};

FUNC int DIA_GM_K1_BESTECHLICH_5_UMAR_condition()
{
	if Bekannt_GM_K1_BESTECHLICH_3_5_FOUNDTRADE
	&& RunningQ(TOPIC_Bestechlich)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_5_UMAR_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_5_UMAR_00"); //Ich habe beobachtet, wie die Rekruten bestochen werden.
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_5_UMAR_01"); //Honer hat sich jetzt schon mindestens zwei Mal mit Togen getroffen, wo Lederbeutel vom Eintreiber an den Rekruten übergeben wurden.
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_5_UMAR_02"); //Morty, der Buddler, hatte dies schon zuvor gesehen.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_5_UMAR_03"); //Ich werde diesbezüglich Ermittlungen einleiten.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_5_UMAR_04"); //Leider kann ich zur Zeit nicht mehr tun. Eure Beobachtungen allein reichen nicht als Beweis aus.
	Quest(TOPIC_Bestechlich, T_ENTRY, "Umar wird Ermittlungen gegen Honer einleiten. Mehr kann ich vorerst nicht machen.");
	MISVAR_Triumvirat_bad_deeds += 1;
};
	
instance DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_condition;
	information	= DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_info;
	description	= "Umar nimmt sich der Sache mit den Rekruten an.";
};

FUNC int DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_BESTECHLICH_5_UMAR)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_00"); //Umar nimmt sich der Sache mit den Rekruten an. Er leitet Ermittlungen ein.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_01"); //Falls er eine Aussage braucht, so stehe ich bereit.
	AI_Output (self, other, "DIA_GM_K1_BESTECHLICH_6_MORTY_SUCCESS_02"); //Danke, dass du dich dieser Sache angenommen hast.
	Quest(TOPIC_Bestechlich, T_SUCCESS, "Morty war zufrieden, dass ich die Sache bei Umar gemeldet habe und sicherte seine Unterstützung zu.");
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST (C_INFO)
{
	npc			= loa_none_6437_Togen;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_condition()
{
	return TRUE;
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_00"); //Hey du, dich hab ich hier noch nie gesehen!
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_01"); //Das kommt wahrscheinlich daher, dass ich noch nie hier war.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_02"); //Wer bist du überhaupt?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_03"); //Ich bin Togen, Eintreiber des Triumvirats.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_04"); //Egal - hast du Lust, mir bei einer misslichen Angelegenheit zu helfen?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_05"); //Ich brauche da jemand Besonderen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_06"); //Gibt's da niemanden aus eurem schönen Verein?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_07"); //Du meinst das Triumvirat?
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_08"); //Ja.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_09"); //Nein, für diese spezielle Aufgabe benötige ich einen Neuen und Unbekannten.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_10"); //Worum geht's denn?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_11"); //Das kann ich dir nur sagen, wenn du zugestimmt hast, mir zu helfen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_12"); //Also, wie sieht's aus?
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_13"); //Das kommt darauf an, ob es illegal ist oder nicht.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_14"); //Na ja, sagen wir's mal so. Ich will etwas zurück haben, was eigentlich mir gehört.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_15"); //Bist du dabei?
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Mit solchen Machenschaften möchte ich nichts zu tun haben.", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_NEIN);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Lass hören, was dir auf der Seele brennt.", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_00"); //Okay, lass hören, was dir auf der Seele brennt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_01"); //Also, es geht um den Armreif meiner verstorbenen Mutter.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_02"); //Ich Trottel habe ihn bei der letzten Würfelrunde verzockt. Dabei ist er mein wertvollster Besitz und hätte meine Taschen nie verlassen sollen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_03"); //Da er meiner Mutter gehörte, will ich ihn natürlich schnellstmöglich zurück. Da hängen einfach zu viele Erinnerungen dran.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Wie kommt es, dass du ihn verspielt hast?", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Wie ist deine Mutter gestorben?", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_00"); //Wie ist deine Mutter gestorben?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_01"); //Trauriger Weise hatte ich keine Zeit mehr, um ihr während ihrer letzten Tagen beizustehen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_02"); //Die Pest hat sie erreicht, als sie auf einer Reise in einer dichtbesiedelten Stadt Wiranons Halt gemacht hatte.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_03"); //Der König ließ die Stadt abriegeln und befahl jeden mit der Armbrust zu töten, der versuchte auszubrechen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_04"); //Meine Mutter war eine der Eingeschlossenen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_05"); //Und wie kommt der Armreif ins Spiel?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_06"); //Den trug sie bei sich, als das ganze passierte. Eigentlich trug sie ihn ihr ganzes Leben lang.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_1_07"); //Er war das Verlobungsgeschenk meines elendigen Vaters.
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_00"); //Wie kommt es, dass du ihn verspielt hast, obwohl er dir so viel bedeutet?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_01"); //Die letzte Spielrunde hätte ich eigentlich nicht verlieren können. Ich weiß selber nicht, was dort passiert ist.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_02"); //Honer hat mich mit Sicherheit betrogen, denn wie aus dem Nichts zauberte er noch einen Wurf mit fünf Sechsen hin - was praktisch unmöglich ist!
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_03"); //Aber nicht unmöglich, oder?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_04"); //Die Chance, so einen Wurf zu landen, ist verschwindend klein. Das war so ziemlich die einzige Möglichkeit, um mich in der letzten Spielrunde noch zu schlagen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_05"); //Also hast du deinen letzten Wertgegenstand eingesetzt, nur um im Spiel zu bleiben?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_06"); //Du glaubst gar nicht, wie ich mit mir gerungen hab. Ich weiß, dass man beim Spielen keine persönliche Gegenstände setzen darf, aber die Situation stand voll zu meinen Gunsten. Ich konnte gar nicht verlieren!
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_07"); //Und trotzdem hast du verloren...
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_08"); //An diesem Spiel war irgendetwas faul.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_09"); //Zuerst hab ich wie ein Bescheuerter gewonnen und mein Gewinn stieg immer weiter an. Dabei hatte ich mit dem kleinsten Einsatz von allen angefangen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_10"); //Aber dann nach ein paar Spielen wendete sich mein Glück. Ich verlor zwei Würfelduelle hintereinander, bis zu der letzten Spielrunde, in der ich auch den Armreif verlor.
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Wie komme ich jetzt ins Spiel?", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Wer hat dich ausgenommen?", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST, "Aus meiner Sicht, hast du es selbst verbockt.", DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_3);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_3()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_3_00"); //Aus meiner Sicht, hast du es selbst verbockt. Wer spielt, muss auch damit rechnen zu verlieren.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_3_01"); //Normalerweise schon, aber in diesem Fall ist es anders. Ich konnte gar nicht verlieren.
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4_00"); //Wer hat dich ausgenommen?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4_01"); //Es war dieser Honer und die anderen Rekruten.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4_02"); //Was? Die Rekruten?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_4_03"); //Ja, ich habe mich bei ihnen eingebracht, nachdem ich von ihren abendlichen Würfelspielen erfuhr.
	
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_00"); //Wie komme ich jetzt ins Spiel? DU hast den Armreif doch verloren!
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_01"); //Ich will ihn unbedingt wiederhaben.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_02"); //Honer trägt ihn noch nicht einmal, hat ihn aber immer bei sich. Für ihn ist er sowieso nur ein weiteres Stück Schmuck, welches er beim Händler verscherbeln kann.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_03"); //Ich dachte mir, dass du ihm das Teil abluchsen könntest, da er dich ja nicht kennt und dich auch nicht verdächtigt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_04"); //Wenn ich oder einer aus dem Triumvirat zu ihm geht, dann wird er sofort vorsichtig.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_05"); //Ist gut, ich werde sehen, was sich machen lässt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_JA_2_5_06"); //Wenn du flinke Finger hast, dann kannst du ihm den Armreif bestimmt aus den Taschen fingern.
	Quest(TOPIC_Ehrenschulden, T_NEW, "Togen hat den Armreif seiner Mutter beim Würfelspiel an den Rekruten Honer verloren. Ich soll ihm das Teil wiederbeschaffen.");
	CreateInvItems(loa_rek_6498_Honer, ItBr_Togensbracelet, 1);
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_NEIN()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_NEIN_00"); //Mit solchen Machenschaften möchte ich nichts zu tun haben.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST_NEIN_01"); //Schade, das hätte sich für dich richtig gelohnt.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_1_TOGEN_QUEST);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN (C_INFO)
{
	npc			= loa_none_6437_Togen;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN_condition()
{
	if RunningQ(TOPIC_Ehrenschulden)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_2_TOGEN_00"); //Ach ja, hätte ich fast vergessen. Erzähle Honer nichts von mir, das würde deine Chancen mindern.
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER (C_INFO)
{
	npc			= loa_rek_6498_Honer;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_info;
	description	= "Ich suche Schmuck für meine Angebetete.";
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_condition()
{
	if RunningQ(TOPIC_Ehrenschulden)
	&& MISVAR_Honer_realisedCrime == FALSE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_00"); //Ich suche Schmuck für meine Angebetete, kennst du da jemanden?
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_01"); //Wieso kommst du denn damit zu mir? Ich bin doch nur Rekrut.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Togen hat mir erzählt, du hättest Schmuck.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_1);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich frage einfach jeden, der mir über den Weg läuft.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_1()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_1_00"); //Togen hat mir erzählt, du hättest Schmuck.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_1_01"); //(misstrauisch) Togen, was?! Tja, ich hab nichts. Wie gesagt, ich bin nur ein einfacher Rekrut.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_00"); //Ich frage einfach jeden, der mir über den Weg läuft.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_01"); //Vielleicht kann ich so ja einen guten Preis rausschlagen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_02"); //Hmm... Ich habe tatsächlich noch ein Stück. Für 500 Goldbrocken überlasse ich es dir.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_03"); //Sag mal, du hast wohl gar keine Vorstellung was sowas wert ist, oder?
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_04"); //Für das Gold krieg ich eine mehr als anständige Waffe.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_05"); //(nachdenklich) Hmm... Ich weiß nicht. Was glaubst du denn, was das Zeug wert ist?
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 50 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 150 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_150);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 250 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 500 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50_00"); //Ich gebe dir 50 Roperi dafür.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50_01"); //(wütend) Haben dir die Scavenger zu lange auf dem Kopf rumgepickt?!
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50_02"); //Das ist viel zu wenig! Soviel weiß ich auch.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_150()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_150_00"); //Ich geb dir 150 Roperi dafür.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_150_01"); //Was? Das ist mir zu wenig. Ich bin mir sicher, da krieg ich beim Händler mehr.
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 50 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_50);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 250 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250);
	Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER, "Ich gebe dir 500 Roperi dafür.", DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250()
{
	Bekannt_DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250_00"); //Ich geb dir 250 Roperi dafür.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250_01"); //Hmm... Ich weiß nicht.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250_02"); //Komm schon, du kannst mit dem Teil doch eh nichts anfangen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250_03"); //Okay, immerhin ist es für eine Frau. Komm wieder, wenn du genug Gold dabei hast.
	AMBVAR_bracelet_value = 250;
	Quest(TOPIC_Ehrenschulden, T_ENTRY, "Ich habe mit Honer einen fairen Preis von 250 Roperi ausgehandelt. Ich soll wiederkommen, wenn ich genug Gold dabei habe.");
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500()
{
	Bekannt_DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500_00"); //Ich geb dir 500 Roperi dafür.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500_01"); //Das klingt gut. Du kannst den Armreif haben! Komm wieder, wenn du genug Gold dabei hast.
	AMBVAR_bracelet_value = 500;
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER);
	Quest(TOPIC_Ehrenschulden, T_ENTRY, "Ich habe mit Honer einen Preis von 500 Roperi ausgehandelt. Ich soll wiederkommen, wenn ich genug Gold dabei habe.");
		
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER (C_INFO)
{
	npc			= loa_rek_6498_Honer;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_info;
	description	= "Ich will den Armreif kaufen.";
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_condition()
{
	if HGold(AMBVAR_bracelet_value)
	&& RunningQ(TOPIC_Ehrenschulden)
	&& MISVAR_Honer_realisedCrime == FALSE
	&& (Bekannt_DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_250 || Bekannt_DIA_GM_K1_TRIV_EHRENSCHULDEN_3_HONER_2_500)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_00"); //Ich will den Armreif kaufen.
	if (!Npc_HasItems(self, ItBr_Togensbracelet)>= 1){
		AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_01"); //Huh, wo ist das hässliche Teil denn?!
		AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_02"); //Warte mal, das Ding verschwindet ausgerechnet dann, als du danach fragst. Etwas verdächtig...
		AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_03"); //(unschuldig) Ich weiß nicht, was du meinst.
		AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_04"); //Du dreckiger Dieb!
		AMBVAR_CrimeCounter += 1;
		if (HItem(ItBr_Togensbracelet, 1)){
			 MISVAR_Honer_realisedCrime = TRUE;
		};
		Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER);
		Info_AddChoice (DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER, "(ENDE)", DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_ATTACK);
	}else{
		if (AMBVAR_bracelet_value == 250){
			AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_05"); //Das macht dann 250 Roperi.
			if (HGold(AMBVAR_bracelet_value)){
				Pay(250);
				Npc_RemoveInvItems(self, ItMi_Gold, Npc_HasItems(self, ItMi_Gold));
				Give(ItBr_Togensbracelet, 1);
				Quest(TOPIC_Ehrenschulden, T_ENTRY, "Ich konnte Togens Armreif zurückkaufen.");
			}else{
				AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_06"); //Ich habe leider nicht genug dabei.
				AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_07"); //Komm einfach wieder, wenn du es hast.
			};
		}else{
			AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_08"); //Das macht dann 500 Roperi.
			if (HGold(AMBVAR_bracelet_value)){
				Pay(500);
				Give(ItBr_Togensbracelet, 1);
				Quest(TOPIC_Ehrenschulden, T_ENTRY, "Ich konnte Togens Armreif zurückkaufen.");
			}else{
				AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_09"); //Ich habe leider nicht genug dabei.
				AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_10"); //Komm einfach wieder, wenn du es hast.
			};
		};
	};
};
	
FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER_ATTACK()
{
	B_ResetThiefLevel();
	Info_ClearChoices (DIA_GM_K1_TRIV_EHRENSCHULDEN_4_HONER);
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_THEFT, 1);
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS (C_INFO)
{
	npc			= loa_none_6437_Togen;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_info;
	description	= "Ich habe deinen Armreif.";
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_condition()
{
	if HItem(ItBr_Togensbracelet, 1)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_00"); //Ich habe deinen Armreif.
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_01"); //Echt? Du glaubst ja gar nicht, was für einen Gefallen du mir getan hast!
	Take(ItBr_Togensbracelet, 1);
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_02"); //Danke dir. Dafür hast du einen gut.
	AI_Output (other, self, "DIA_GM_K1_TRIV_EHRENSCHULDEN_5_TOGEN_SUCCESS_03"); //Das merke ich mir.
	Quest(TOPIC_Ehrenschulden, T_SUCCESS, "Togen war sehr dankbar, dass ich ihm mit seinem Armreif helfen konnte. Dafür hab ich bei ihm einen gut.");
	MISVAR_Helped_TRIV += 1;
	XP(150);
	if MISVAR_Helped_TRIV >= 2{
		NewRout(loa_none_6439_Kunislav, "toHero");	
	};
};
	
instance DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER (C_INFO)
{
	npc			= loa_rek_6498_Honer;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_condition;
	information	= DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_condition()
{
	if MISVAR_Honer_realisedCrime == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_00"); //Dafür wirst du dich verantworten müssen!
	AI_Output (self, other, "DIA_GM_K1_TRIV_EHRENSCHULDEN_6_HONER_01"); //Geh zu Umar und zahl deine Strafe - oder verpiss dich von hier!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO (C_INFO)
{
	npc			= loa_none_6436_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_00"); //(leise) Hey, pssst, du da!
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_01"); //Was ist? Was machst du da?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_02"); //Verstecken, was denn sonst!
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_03"); //Vor wem?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_04"); //Vor dem Eintreiber Frand.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_05"); //Wieso?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_06"); //Wieso was?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_07"); //(genervt) Wieso versteckst du dich hier vor dem Eintreiber Frand?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_08"); //(leise) Das ist es ja. Der Typ will mich umbringen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_09"); //(genervt) WIESO will er dich umbringen?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO_10"); //Ganz einfach, ich hab ihm in die Eier getreten und verstecke mich seitdem.
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES (C_INFO)
{
	npc			= loa_none_6436_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_info;
	description	= "Erzähl mir einfach die ganze Geschichte.";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_00"); //Also jetzt reicht es mir. Entweder du erzählst mir die ganze Geschichte oder ich gehe.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_01"); //Ich habe echt keine Lust, dir alles aus den Taschen zu leiern.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_02"); //Hey, ist ja gut. Ich muss nur vorsichtig sein, mit wem ich spreche.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_03"); //Also ich habe Probleme mit Frand. Der Typ kam vor fünf Tagen zu mir und wollte die doppelte Menge an Schutzgeld von mir.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_04"); //Natürlich habe ich gefragt, warum und hab direkt eine auf's Maul bekommen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_05"); //Einfach so?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_06"); //Ja! Der Penner hat einfach so zugehauen, nur weil ich eine Frage gestellt habe.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_07"); //Nachdem ich mich wieder aufgerafft hatte, griff er mich am Hals und forderte mich nochmals auf, das Gold zu zahlen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_08"); //Da hab ich die Gelegenheit genutzt und hab ihm kräftigst in die Weichteile getreten.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_09"); //Den Sturm von Flüchen und seinen Aufschrei hättest du hören müssen. Das hat natürlich einige Leute angelockt.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_10"); //Und dann?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_11"); //Ich war da natürlich schon weg und habe mich hier versteckt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_12"); //Aber wenn er mich zu fassen kriegt, dann bin ich tot - ich sag's dir!
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES_13"); //(flüsternd) Bitte erzähl den Eintreibern nichts von mir.
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST (C_INFO)
{
	npc			= loa_none_6436_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_info;
	description	= "Was soll ich jetzt machen? (helfen)";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_00"); //Was soll ich jetzt machen? Soll ich ihn etwa umbringen? 
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_01"); //Er ist ein Eintreiber des Triumvirats. Das würde nicht gut gehen!
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_02"); //Ach, ich weiß nicht. Am liebsten würde ich von hier verschwinden. Ich kann nicht mehr länger in der Goldmine bleiben.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_03"); //Selbst, wenn Frand verschwinden würde, würden mich die Eintreiber mein Leben lang täglich verdreschen für dieses Aufbegehren.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_04"); //Leider ist stets ein Eintreiber vor dem Ausgang der Goldmine, der aufpasst, dass ich nicht abhaue.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_05"); //Ich könnte den Eintreiber ablenken.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_06"); //Das würdest du tun?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_07"); //Sicher. Ist ja jetzt nicht gerade ein Kraftakt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_08"); //Okay, ich schlüpf schnell durch, wenn der Eintreiber weg ist.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST_09"); //Ich warte dann vor der Mine auf dich, wenn ich durchkomme.
	Quest(TOPIC_Verstecken, T_NEW, "Tires hat Angst vor Frand und dem Triumvirat. Ich werde ihm helfen, von hier zu verschwinden. Ich soll den Eintreiber vorm Ausgang der Goldmine ablenken oder vertreiben, damit Tires durchschlüpfen kann.");
	
	
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4 (C_INFO)
{
	npc			= loa_none_6449_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_info;
	description	= "Wen suchst du?";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_3_TIRES_QUEST)
	&& RunningQ(TOPIC_Verstecken)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_00"); //Wen suchst du?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_01"); //Geht dich nichts an?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_02"); //Vielleicht kann ich helfen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_03"); //Ich bezweifle es.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_04"); //Dann lass es drauf ankommen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_05"); //Der Buddler Tires schuldet uns Gold und will sich damit aus dem Staub machen.
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4);
	Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4, "Hey, du Hackfresse!", DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3);
	Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4, "Ich hab ihn auf einem Gerüst gesehen...", DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1);
};
	
FUNC void DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1()
{
	Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_00"); //Tires? Den Typen hab ich doch vorhin kauernd auf einem Gerüst rumhocken gesehen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_01"); //(aufgeregt) Wo?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_02"); //Da, wo die Minecrawler sind. Ich weiß nicht, wie ich es besser erklären soll. Diese Mine ist mir einfach zu verwirrend.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_03"); //Das sind super Nachrichten. Geh und erzähl das mal einem anderen Eintreiber, damit die ihn schnappen können.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_04"); //Nee, ich muss gleich in die Stadt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_05"); //Hmm... Könntest du denn wenigstens hier Wache halten und aufpassen, dass Tires nicht abhaut.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_06"); //(innerlich lachend) Sicherlich...
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1_07"); //Ich bin gleich zurück. Wir brauchen mehr gute Leute wie dich!
	Npc_ExchangeRoutine(self, "searchTires");
	Quest(TOPIC_Verstecken, T_ENTRY, "Ich habe den Eintreiber weggeschickt, jetzt kann Tires durchschlüpfen.");
	TIMEVAR_Tires = Wld_GetTimePlus(0,0,10);
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4);
	AI_StopProcessInfos (self);
	
};
	
FUNC void DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3()
{
	Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3_00"); //Hey, du Hackfresse! Verpiss dich von hier!
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3_01"); //Was? Du willst eine auf's Maul haben? Komm her und hol dir deine Prügel ab.
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4);
	AI_StopProcessInfos (self);
	B_Attack(self, other, 11, 1);
	
	AI_Teleport(loa_none_6436_Tires, "GM_TOT");
	NewRout(loa_none_6436_Tires, "GM_dead");
	AI_Teleport(loa_none_6436_Tires, "GM_TOT");
	MISVAR_Tires_exited = TRUE;
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1 (C_INFO)
{
	npc			= loa_none_6449_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_condition()
{
	if Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3
	&& self.aivar[AIV_DefeatedbyPlayer] == TRUE
	&& RunningQ(TOPIC_Verstecken)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_00"); //Ist ja gut, ich geh ja schon. Aber das wirst du irgendwann bereuen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_4_1_01"); //Verschwinde aus meinem Blickfeld!
	AI_StopProcessInfos (self);
	Quest(TOPIC_Verstecken, T_ENTRY, "Ich habe den Eintreiber mit ein wenig Prügel verjagt, jetzt kann Tires durchschlüpfen.");
	NewRout(self, "Patrouille");
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO (C_INFO)
{
	npc			= loa_none_6436_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_info;
	description	= "Du kannst in die Freiheit.";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_condition()
{
	if Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1 || Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3
	&& RunningQ(TOPIC_Verstecken)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_00"); //Du kannst in die Freiheit. Die Wache ist vorerst weg.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO_01"); //Super, ich danke dir. Ich bin dann mal raus.
	AI_StopProcessInfos (self);
	NewRout(self, "flee");
	if (RunningQ(TOPIC_TiresFinden))
	{
		Quest(TOPIC_TiresFinden, T_FAILURE, "Ich habe Tires bei der Flucht geholfen.");
	};
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS (C_INFO)
{
	npc			= loa_none_6447_Tires;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_info;
	description	= "Scheinst ja gut rausgekommen zu sein.";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_condition()
{
	if MISVAR_Tires_exited >= 2
	&& RunningQ(TOPIC_Verstecken)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_00"); //Scheinst ja gut rausgekommen zu sein.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_01"); //Ja, ich danke dir für deine Hilfe.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_02"); //Ich werde mich wohl in die Stadt begeben und versuchen mir eine richtige Arbeit zu suchen.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS_03"); //Viel Glück dabei.
	Quest(TOPIC_Verstecken, T_SUCCESS, "Tires hat es aus der Goldmine geschafft und wird sein Glück in der Stadt versuchen.");
	XP(200);
	Quest(TOPIC_TiresFinden, T_FAILURE, "Ich habe Tires geholfen, anstatt ihn zu verpfeifen.");
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_info;
	description	= "Wer bist du?";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_00"); //Wer bist du?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO_01"); //Ich bin Frand, Mitglied des Triumvirats.
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_info;
	description	= "Und was machst du so?";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO)
	&& !SuccessQ(TOPIC_Verstecken)
	&& !RunningQ(TOPIC_TiresFinden)
	&& !SuccessQ(TOPIC_TiresFinden)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_00"); //Und was machst du so?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_01"); //Eigentlich die Abgaben der Buddler einsammeln, aber momentan hab ich Wichtigeres zu tun.
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_02"); //Was wäre das?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_03"); //Dieser dreckige Schürfer Namens Tires. Der hat mich doch tatsächlich angegriffen. Außerdem hat er seine Abgaben nicht bezahlt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_04"); //Könntest du mir helfen, ihn zu finden?
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST);
	Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST, "Nein, damit will ich nichts zu tun haben.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN);
	if (!Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO)){	
		Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST, "Ich geb mein Bestes.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA);
		Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST, "Wieso sollte ich das tun?", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO);
	};
	
};
	
FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_00"); //Wieso sollte ich das tun?
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_01"); //Für Gold natürlich!
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_02"); //Etwas mager.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_03"); //Was willst du denn noch?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_04"); //Ich will ein gutes Wort von dir beim Don.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_WIESO_05"); //Okay, abgemacht! Ich setzt mich für dich ein, wenn du mir mit Tires hilfst.
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST);
	Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST, "Nein, damit will ich nichts zu tun haben.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN);
	Info_AddChoice (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST, "Ich geb mein Bestes.", DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA);
};
	
FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN()
{
	Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN_00"); //Nein, damit will ich nichts zu tun haben.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_NEIN_01"); //Dann geh mir aus den Augen.
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA_00"); //Okay, ich geb mein Bestes.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST_JA_01"); //Wenn du weißt, wo er ist, sag mir Bescheid - dann knöpf ich ihn mir vor.
	Quest(TOPIC_TiresFinden, T_NEW, "Frand hat mich damit beauftragt, nach Tires zu suchen. Dieser hat sich irgendwo in der Goldmine versteckt, nachdem er ihn angegriffen hat.");
	Info_ClearChoices (DIA_GM_K1_TRIV_VERSTECKEN_1_2_FRAND_QUEST);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_condition;
	information	= DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_info;
	description	= "Ich weiß, wo Tires sich versteckt.";
};

FUNC int DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO)
	&& (Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_TIRES_INTRO))
	&& !(Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_3 || Bekannt_DIA_GM_K1_TRIV_VERSTECKEN_4_EINTREIBER4_1)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO)
	&& RunningQ(TOPIC_TiresFinden)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_00"); //Ich weiß, wo Tires sich versteckt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_01"); //Wo?
	AI_Output (other, self, "DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_02"); //In einem verlassenen Gang in der Nähe des Ausgangs.
	AI_Output (self, other, "DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS_03"); //Okay, ich geh dann mal los und klär die Sache! Danke für die Hilfe.
	XP(200);
	Quest(TOPIC_TiresFinden, T_SUCCESS, "Frand kümmert sich jetzt um die Sache.");
	TIMEVAR_Frand_goes_Tires = Wld_GetTimePlus(0,1,0);
	if RunningQ(TOPIC_MortySchulden){
		MISVAR_Morty_DeptFree = TRUE;//das schließt die dritte option bei Honer aus mit den Schulden
		Quest(TOPIC_MortySchulden, T_ENTRY, "Ich habe Frand dabei geholfen, Tires zu finden. Dafür werden Morty die Schulden beim Triumvirat erlassen.");
	};
	Npc_ExchangeRoutine(loa_none_6438_Frand, "Tiresfound");
	B_KillNpc(loa_none_6436_Tires);
	MISVAR_Helped_TRIV += 1;
	if (RunningQ(TOPIC_Verstecken)){
		Quest(TOPIC_Verstecken, T_FAILURE, "Ich habe Frand geholfen, Tires zu finden.");
	};
	if MISVAR_Helped_TRIV >= 2{
		NewRout(loa_none_6439_Kunislav, "toHero");	
	};
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_condition()
{
	if MISVAR_Helped_TRIV >= 2
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_00"); //Der Don hat nach dir gerufen. Hier hast du den Schlüssel.
	CreateAndGive(Itke_TRIV, 1);
	AI_PointAtNpc(self, loa_none_6440_Don);
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_01"); //Geh direkt zu ihm. Du findest ihn in dem Fort.
	AI_StopPointAt(self);
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_0_KUNISLAV_02"); //Gut.
	AI_StopProcessInfos (self);
	Info(Info_Mine, "Der Don verlangt nach mir. Dieser hält sich in dem kleinen Fort in der Goldmine auf.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 2;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_condition()
{
	if MISVAR_Helped_TRIV >= 2
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_00"); //Was machst du denn hier? Wer hat dich durchgelassen?
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_01"); //Ich habe diverse Aufgaben in Eurem Namen erledigt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON_02"); //Tatsächlich? Dann musst du ja vertrauenswürdig sein. Nun gut, ich denke wir können dich gut gebrauchen.
	
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_condition()
{
	if !Npc_KnowsInfo (hero, DIA_GM_K1_TIRESGOLD_2_TIRES_SUCCESS)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_00"); //Warte noch. Ich hätte da eine Aufgabe für dich.
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_01"); //Und die wäre?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_02"); //Ich höre immer wieder von diesem schmierigen, kleinen Buddler namens Tires.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_03"); //Er schuldet dem Triumvirat einen beträchtlichen Anteil. Er hat schon seit Ewigkeiten keine Abgaben mehr geleistet.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_04"); //Jeder Buddler in dieser Mine steht unter unserem Schutz und muss dafür eine Gebühr entrichten.
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_05"); //Leuchtet mir ein.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_06"); //Nun, Tires muss mittlerweile ein ganzes Vermögen unterschlagen haben.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_07"); //Ich möchte, dass du dich darum kümmerst und mir die fälligen Abgaben bringst.
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_08"); //Wie viel wäre das?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_09"); //So genau weiß ich das nicht, aber als Bestrafung nimmst du dem Buddler alles ab, was er hat.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST_10"); //Damit er es sich beim nächsten Mal zwei Mal überlegt, ob er das Triumvirat bescheißen will.
	Quest(TOPIC_TiresSchatz, T_NEW, "Der Buddler Tires hat einen großen Batzen an Schutzgeld ans Triumvirat unterschlagen. Ich soll es für den Don wiederbeschaffen, indem ich Tires alles abnehme, was er hat.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 11;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_info;
	description	= "Wo ist denn dieser Tires?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST)
	&& RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_00"); //Wo ist den dieser Tires?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_3_DON_01"); //Na, tot! Frand war etwas grobschlächtig.
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Tires ist leider tot. Aus ihm kriege ich keine Infos mehr raus.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_info;
	description	= "Wie komme ich an sein Gold?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST)
	&& RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_00"); //Wie komme ich an sein Gold?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_01"); //Das ist der schwierige Teil. Er war nicht dumm und hat seinen ganzes Gold und seine Habseligkeiten versteckt.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_02"); //Du siehst also, es gibt einen wahren Schatz zu bergen. Bring mir diesen Schatz, dann erhälst du eine faire Belohnung. 
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_03"); //Wie sieht diese aus?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_4_DON_04"); //Das besprechen wir, wenn du deine Aufgabe erledigt hast.
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Der Buddler hat sein Gold und seine Habseligkeiten irgendwo versteckt. Ohne Hinweise werde ich wohl nie auf dieses Versteck kommen. Vielleicht hat Tires den Schatz in seinem letzten Unterschlupf versteckt oder vergraben. Habe ich eigentlich noch eine Spitzhacke bei mir?");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_info;
	description	= "Ich habe Tires' Schatz gefunden.";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_TIRES_SCHATZ_2_DON_QUEST)
	&& RunningQ(TOPIC_TiresSchatz)
	&&(HItem(ItMi_TiresGold, 1)
	||(HItem (ItMi_Goldnugget_Addon, 436)
	&& MISVAR_Tires_opened_treasure == TRUE))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_00"); //Ich habe Tires' Schatz gefunden. Es war ein ganz beträchtlicher Sack voller Gold und Wertgegenständen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_01"); //Wusste ich es doch. Das war gute Arbeit. Jetzt gib mir die Sachen.
	Info_ClearChoices (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS);
	Info_AddChoice (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS, "Wie sieht's mit meiner Belohnung aus?", DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1);
	Info_AddChoice (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS, "Ich habe den Sack nicht mehr.", DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_2);
};
	
FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_00"); //Wie sieht's mit meiner Belohnung aus?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_01"); //Ich habe die Sachen doch noch gar nicht gesehen. Also, gib sie her!
	Info_ClearChoices (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS);
	Info_AddChoice (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS, "(Tires' Schatz geben)", DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3);
	Info_AddChoice (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS, "Nein, ich behalte die Sachen.", DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_4);
};
	
FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_00"); //Hier hast du die Sachen.
	Take(ItMi_TiresGold, 1);
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_01"); //Das sieht gut aus. Hmm...
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_02"); //Hier ist deine Belohnung.
	Pay(300);
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_03"); //Was, nur 300 Roperi?! Der Inhalt dieses Beutels ist mindestens 2000 Roperi wert.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_04"); //Und das sind alles unterschlagene Zahlungen! Oder willst du jetzt Anspruch auf das uns zustehende Schutzgeld stellen?!
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_3_05"); //Nein, nein, schon okay...
	XP(150);
	Quest(TOPIC_TiresSchatz, T_SUCCESS, "Ich habe dem Don die Sachen von Tires überbracht und dafür 300 Roperi als Belohnung erhalten.");
	MISVAR_Helped_TRIV += 1;
	TIMEVAR_Don_helped = Wld_GetDay();
	NewRout(self, "Aufstand");
	NewRout(loa_none_6440_Don, "Aufstand");
	NewRout(loa_none_6439_Kunislav, "Aufstand");
	NewRout(loa_none_6438_Frand, "Aufstand");
	NewRout(loa_none_6437_Togen, "Aufstand");
	Info_ClearChoices (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS);
};
	
FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_4()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_4_00"); //Nein, ich behalte die Sachen. Immerhin habe ich sie beschafft.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_4_01"); //Du dreckiger Dieb! Das ist MEIN Gold!
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_1_4_02"); //Alarm, Leute! Schnappt ihn euch!
	Info_ClearChoices (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS);
	AI_StopProcessInfos (self);
	B_Attack(loa_none_6437_Togen, other, AR_KILL, 1);
	B_Attack(loa_none_6438_Frand, other, AR_KILL, 1);
	B_Attack(loa_none_6439_Kunislav, other, AR_KILL, 1);
	B_Attack(loa_none_6440_Don, other, AR_KILL, 1);
};
	
FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_2()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_2_00"); //Ich habe den Sack nicht mehr.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_2_01"); //Du willst mich doch verarschen! Mich bescheißt hier keiner!
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS_2_02"); //Alarm, Leute! Schnappt ihn euch!
	Info_ClearChoices (DIA_GM_K1_TRIV_TIRES_SCHATZ_5_DON_SUCCESS);
	AI_StopProcessInfos (self);
	B_Attack(loa_none_6437_Togen, other, AR_KILL, 1);
	B_Attack(loa_none_6438_Frand, other, AR_KILL, 1);
	B_Attack(loa_none_6439_Kunislav, other, AR_KILL, 1);
	B_Attack(loa_none_6440_Don, other, AR_KILL, 1);
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_info;
	description	= "Weißt du, wo Tires sein Gold versteckt hat?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_condition()
{
	if RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_00"); //Weißt du, wo Tires sein Gold versteckt hat?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_6_NEMS_01"); //Tires? Hmm... keine Ahnung. Hab nicht so viel mit ihm zu tun gehabt. Aber ich hörte, er wurde auch vom Triumvirat getötet.
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Nems weiß nichts über die Habseligkeiten.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_info;
	description	= "Weißt du, wo Tires sein Gold versteckt hat?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_condition()
{
	if RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_00"); //Weißt du, wo Tires sein Gold versteckt hat?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_01"); //Du suchst nach Tires? Der wurde doch vom Triumvirat ermordet. Wann hat das bloß ein Ende...?!
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_02"); //Nein, sein Gold suche ich.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_7_MORTY_03"); //Von seinem Gold habe ich keine Ahnung. Er hat immer alles bei sich behalten...
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Morty konnte mir nicht wirklich helfen.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_info;
	description	= "Weißt du, wo Tires sein Gold versteckt hat?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_condition()
{
	if RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_00"); //Weißt du, wo Tires sein Gold versteckt hat?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_8_DOTTER_01"); //Interessiert mich nicht! Ich würde mein Gold niemals unbeabsichtigt liegen lassen.
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Dotter konnte mir nicht direkt helfen, doch erwähnte er, dass er sein Gold nie unbeobachtet lassen würde. Vielleicht hat Tires das Gold in seiner Nähe versteckt.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_info;
	description	= "Weißt du, wo Tires sein Gold versteckt hat?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_condition()
{
	if RunningQ(TOPIC_TiresSchatz)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_00"); //Weißt du, wo Tires sein Gold versteckt hat?
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_9_FURT_01"); //Keine Ahnung, sonst hätte ich es mir schon längst geschnappt. Der scheint ja 'ne Menge gebunkert zu haben.
	Quest(TOPIC_TiresSchatz, T_ENTRY, "Furt weiß nichts.");
};
	
instance DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON (C_INFO)
{
	npc			= loa_none_6440_Don;
	nr			= 10;
	condition	= DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_condition;
	information	= DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_info;
	description	= "Warum nennt ihr euch das Triumvirat?";
};

FUNC int DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_TIRES_SCHATZ_1_DON)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_00"); //Warum nennt ihr euch das Triumvirat? Eure Vereinigung verfehlt doch absolut die Begriffsbedeutung.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_01"); //Wer bist du, dass du so mit mir sprechen kannst?
	AI_Output (other, self, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_02"); //Nur ein neugieriger Fremder.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_03"); //Erhebe noch einmal dermaßen das Wort gegen mich und ich lasse dir die Zunge rausreißen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_04"); //Aber um deine Frage zu beantworten: Das Triumvirat hat sich anfangs aus Kunislav, Frand und mir gebildet. Wir haben uns zusammengeschlossen, um die Buddler zu beschützen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_05"); //Mit der Zeit haben sich uns mehr Männer angeschlossen und Kunislav und Frand erkannten, dass ich der geborene Anführer bin.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_06"); //Zu diesem Zeitpunkt bin ich zum Don aufgestiegen.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_07"); //Tatsächlich hast du aber Recht, ein Triumvirat sind wir nicht mehr.
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_08"); //Der Kerngedanke bleibt jedoch unverändert: Wir beschützen die Buddler!
	AI_Output (self, other, "DIA_GM_K1_TRIV_TIRES_SCHATZ_10_DON_09"); //(leise und nachdenklich) Ich sollte mir vielleicht wirklich einen neuen Namen ausdenken...
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_info;
	description	= "Du erwähntest ein Buch zum Schürfen?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_4)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_00"); //Du erwähntest ein Buch zum Schürfen? Worum geht es da?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_01"); //Na, genau um das, was der Name schon sagt. Damit kannst du deine Fähigkeiten im Schürfen verbessern.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_02"); //Dotter ist nur so gut, weil er dieses Buch hat. Ich will aber auch mal besser werden, sonst werde ich nie reich.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_03"); //Wär schon super, wenn ich da 'nen Blick reinwerfen könnte.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_04"); //Wo bewahrt er das Buch denn auf?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_05"); //Ich glaube, der trägt das immer bei sich. Da bräuchtest du schon ziemlich flinke Finger.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_06"); //Immer?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_07"); //Na ja. Er geht auch schlafen, das wird er bestimmt nicht ins Bett mitnehmen.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_08"); //Ich probier mal an dieses Buch zu kommen. Ich will nämlich auch besser Schürfen lernen. Und ohne Gold zu bezahlen oder ihm zu helfen, zeigt er mir das Schürfen nicht.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST_09"); //(enttäuscht) Mir auch nicht...
	Quest(TOPIC_AllesFuersGold, T_NEW, "Dotter hat ein Buch, das Tipps zum Schürfen beinhaltet. Ich sollte mir dieses Buch mal besorgen und es Furt zeigen.");
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_info()
{
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_00"); //Aber pass auf, das er nicht mitbekommt, dass sein Buch weg ist, sonst ergeht es dir wie Mors!
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__1_5_FURT_01"); //Merke ich mir.
	Quest(TOPIC_AllesFuersGold, T_ENTRY, "Furt warnte mich vor Dotter. Ich sollte das Buch wieder zurücklegen, bevor Dotter aufwacht.");
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_info;
	description	= "Was weißt du über Dotters Buch zum Schürfen?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_00"); //Was weißt du über Dotters Buch zum Schürfen?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_01"); //Mit dem würde ich mich lieber nicht anlegen.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_02"); //Wieso?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_03"); //Der bezahlt die Eintreiber so gut, dass die alles für ihn tun. Er ist sozusagen ihr Gold-Kunde.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_04"); //Okay, gut zu wissen, aber weißt du trotzdem, wo er sein Buch versteckt?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY_05"); //Ja, ich habe einmal mit ihm gesoffen. Nach dem Schürfen hat er 'ne Weile in seiner Kiste rumgewühlt und das Buch reingelegt. Wahrscheinlich hat er irgendwas präpariert.
	Quest(TOPIC_AllesFuersGold, T_ENTRY, "Morty konnte mir verraten, dass Dotter sein Buch abends in seine Truhe einschließt. Das ist die optimale Gelegenheit, um es sich 'auszuleihen'.");
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_info;
	description	= "Was weißt du über Dotters Buch zum Schürfen?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_00"); //Was weißt du über Dotters Buch zum Schürfen?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_01"); //Er hat ein Buch dafür?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__3_NEMS_02"); //(aufgebracht) Dieser dreckige Geizhals! Mir hat er letztens 300 Roperi für eine Lektion abgezockt, nachdem ich ihn tagelang angebettelt habe.
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_info;
	description	= "Was weißt du über Dotters Buch zum Schürfen?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_00"); //Was weißt du über Dotters Buch zum Schürfen?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_01"); //Von dem Gerücht habe ich gehört, Mors hatte es mir mal erzählt.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__4_RODG_02"); //(nachdenklich) Kurz darauf ist er gestorben...
	if RunningQ(TOPIC_Triumvirat){
		Quest(TOPIC_Triumvirat, T_ENTRY, "Mors ist gestorben, nachdem er Rodg von einem Gerücht über Dotters Schürfbuch erzählt hat.");
	}else{
		Quest(TOPIC_Triumvirat, T_NEW, "Anscheinend gibt es in der Goldmine von Ahssûn eine kriminelle Vereinigung namens 'Triumvirat', die von den Schürfern Schutzgeld erpresst, obwohl diese bereits ihre Steuerabgaben an die Stadt leisten.");
		Quest(TOPIC_Triumvirat, T_ENTRY, "Mors ist gestorben, nachdem er Rodg von einem Gerücht über Dotters Schürfbuch erzählt hat.");
	};
	if RunningQ(TOPIC_MorsKill){
		Quest(TOPIC_MorsKill, T_ENTRY, "Mors ist gestorben, nachdem er Rodg von einem Gerücht über Dotters Schürfbuch erzählt hat.");
	};
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_info;
	description	= "Wo steht Dotters Truhe eigentlich?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__2_MORTY)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_00"); //Wo steht Dotters Truhe eigentlich?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_01"); //Du Goblin! Wurmt es dich jetzt tatsächlich nach diesem Buch?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_02"); //Was soll's, ich will deinem Glück nicht im Wege stehen.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_03"); //Also weißt du, wo die Truhe ist?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__5_MORTY_04"); //Ja, sie ist beim Schlafplatz der Rekruten, dort wo Dotter auch schläft.
	Quest(TOPIC_AllesFuersGold, T_ENTRY, "Dotter hat seine Truhe neben seinem Bett stehen.");
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_info;
	description	= "Hey, Dotter!";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__1_FURT_QUEST)
	&& SDistTo("GM_DOTTER_02", 400)
	&& Wld_isTime(18,40,23,20)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_00"); //Hey, Dotter! Was machst du hier?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_01"); //Ich trink mir meinen Feierabend schön.
	Quest(TOPIC_AllesFuersGold, T_ENTRY, "Verdammt, Dotter will nicht von seiner Truhe weg. Da muss ich mir was einfallen lassen.");
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_info;
	description	= "Wollen wir zusammen einen heben?";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER)
	&& DIA_GM_K1_ALLESFUERSGOLD_UD__6_DOTTER_condition()
	&& RunningQ(TOPIC_AllesFuersGold)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_00"); //Wollen wir zusammen einen heben?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_01"); //Kommt drauf an.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_02"); //Worauf denn?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_03"); //Ob du ein paar tolle Geschichten drauf hast.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_04"); //Och, ich hab schon einige Außergewöhnliche.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_05"); //Ich komme beispielsweise vom Festland.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_06"); //Das klingt interessant.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_07"); //Hier erstmal ein Bier.
	CreateInvItems(self, ItFo_Beer, 1);
	CreateAndGive(ItFo_Beer, 1);
	AI_WaitTillEnd(self, other);
	AI_UseItem(self, ItFo_Beer);
	AI_UseItem(hero, ItFo_Beer);
	AI_Wait(self, 1);
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_08"); //So, dann erzähl mal!
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_09"); //Eigentlich sollte der Auftrag ganz einfach sein. Rübersegeln, die Situation abstecken und dann wieder heimfahren...
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_10"); //... aber dann kam alles anders...
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_11"); //Du hast die Arena überlebt? Respekt. Hier, nimm noch einen.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_12"); //Gerne.
	CreateInvItems(self, ItFo_Beer, 1);
	CreateAndGive(ItFo_Beer, 1);
	AI_WaitTillEnd(self, other);
	AI_UseItem(self, ItFo_Beer);
	AI_UseItem(hero, ItFo_Beer);
	AI_Wait(self, 1);
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_13"); //Nach dem Überlebenskampf hab ich mich halbtot den Pfad entlang ins Untere Viertel geschleppt...
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_14"); //Hat dir keiner...
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_15"); //... nein, niemand hat mir geholfen, doch...
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_16"); //... dann bin ich hier zur Goldmine gekommen.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_17"); //So, es wird Zeit für ein weiteres, kühles Blondes.
	CreateInvItems(self, ItFo_Beer, 1);
	CreateAndGive(ItFo_Beer, 1);
	AI_WaitTillEnd(self, other);
	AI_UseItem(self, ItFo_Beer);
	AI_UseItem(hero, ItFo_Beer);
	AI_Wait(self, 1);
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_18"); //Erzähl ruhig weiter.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_19"); //Na ja, ich...
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_20"); //... so war das und...
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_21"); //... Na und dann traf ich dich, wie du so einsam hier rumstandest.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_22"); //Hick, tjoa, eine interessante Geschichte.
	if(MISVAR_Lupia_INTRO == TRUE){
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_23"); //Auch wenn mir die Stelle mit Lupia am besten gefallen hat, so hat sie doch zu wenige Frauen drinne.
	};
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_24"); //Hier haste noch einen.
	CreateInvItems(self, ItFo_Beer, 1);
	CreateAndGive(ItFo_Beer, 1);
	AI_WaitTillEnd(self, other);
	AI_UseItem(self, ItFo_Beer);
	AI_UseItem(hero, ItFo_Beer);
	AI_Wait(self, 1);
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_25"); //Willst du noch was hören?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_26"); //Nee du, für mich reicht's heute.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_27"); //Ich werd mich jetzt erstmal in die Pfanne hauen und bereite mich mental auf den morgigen Schürftag vor.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__7_DOTTER_28"); //Dann mach das mal.
	Npc_ExchangeRoutine(self, "Sleep");
	MISVAR_Dotter_sleeping = TRUE;
	AI_StopProcessInfos (self);
	Quest(TOPIC_AllesFuersGold, T_ENTRY, "Dotter ist jetzt schlafen gegangen, damit habe ich jetzt Zeit, um mir sein Buch 'auszuleihen'.");
	TIMEVAR_Dotter_Sleep = Wld_GetTimePlus(0,9,0);
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_info;
	description	= "Ich habe das Buch der Buddler.";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_condition()
{
	if HItem(ItWr_BuddlerBuch, 1)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_00"); //Ich habe das Buch der Buddler.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_01"); //Zeig her!
	Take(ItWr_BuddlerBuch, 1);
	if (Npc_HasItems (self, Fakescroll_Addon) == FALSE){
		CreateInvItem (self, Fakescroll_Addon);
	};
	B_StopLookAt (self);
	AI_UseItemToState (self, Fakescroll_Addon, 1);
	AI_Wait (self, 3);
	AI_UseItemToState (self, Fakescroll_Addon, -1);
	Npc_SetStateTime (self, 0);
	Npc_RemoveInvItems(self, Fakescroll_Addon, 1);
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_02"); //Aha, das bringt mich tatsächlich weiter. Kein Wunder, dass ich nie besser wurde.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_03"); //Hier hast du es zurück. Verstau es bitte wieder in seiner Truhe, bevor er es merkt.
	Give(ItWr_BuddlerBuch, 1);
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_04"); //Als Gegenleistung zeige ich dir auch ein paar Tricks.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_05"); //Es kommt sehr darauf an, dass du einen festen Stand hast.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS_06"); //Wenn du dies beherzigst, dann kommst du beim Schwingen nicht ins Straucheln.
	B_Upgrade_Hero_HackChance(3);
	XP(150);
	Quest(TOPIC_AllesFuersGold, T_SUCCESS, "Ich habe Furt das Buch gebracht und dieser war voll zufrieden. Als Gegenleistung hat er mir sogar seine wenigen Tricks gezeigt.");
	
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 1;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_condition()
{
	if MISVAR_Dotter_Angry == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_info()
{
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_00"); //Irgend so ein dreckiger Dieb hat meine Truhe ausgeräumt! Wenn ich herausfinde, wer das war, dann gibt's mächtig Ärger!
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER_01"); //Bestimmt ist diese kleine Goblinpfote Furt da dran gewesen!
	TIMEVAR_Dotter_Angry = Wld_GetDay();
	if RunningQ(TOPIC_AllesFuersGold){
		Quest(TOPIC_AllesFuersGold, T_ENTRY, "Dotter verdächtigt Furt des Buchdiebstahls.");
	};
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_info;
	description	= "Ich will dich vor Dotter warnen.";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_00"); //Ich will dich vor Dotter warnen. Der hat bemerkt, dass sein Buch fehlt und sucht jetzt den Dieb.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_01"); //(aufgeregt) Verdammte Scheiße, dabei hab ich es dir doch noch gesagt!
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_02"); //(beruhigend) Nur keine Panik! Er weiß nicht, wer es war und wird es auch nicht erfahren, wenn du es ihm nicht sagst.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_03"); //Bisher tappt er im Dunkeln. Wenn er dich fragt, dann sagst du, dass du nicht so blöd wärst, Dotter noch einmal zu bestehlen nach der letzten Prügel.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_04"); //Das wird er dir glauben. Sag einfach, dass du bei den anderen am Saufen warst.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT_05"); //Okay, du hast Recht...
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_condition()
{
	if (TIMEVAR_Dotter_Angry < Wld_GetDay())
	&& Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_info()
{
	if (!Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT)){
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_00"); //Na, sieh mal an, wen wir da haben.
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_01"); //Ja?
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_02"); //Du bist die dreckige Ratte, die mein Buch geklaut hat.
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_03"); //Ich doch nicht, wie kommst du auf diese Anschuldigung?
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_04"); //Sagen wir mal, ein feiges Vögelchen hat es mir gezwitschert.
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_05"); //Du hast jetzt die Wahl... Entweder du gibst es mir zurück und zahlst eine Strafe bei Umar, oder...
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_06"); //Ich hab schon verstanden. Du hast mächtige Freunde. Okay, ich werde bezahlen.
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_07"); //Ich suche dann mal Umar auf.
		AMBVAR_CrimeCounter += 1;
		MISVAR_Dotter_realisedCrime = TRUE;
		AMBVAR_GM_LOCK = TRUE;
	}else{
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_08"); //Hast du jemanden gesehen, der sich an meiner Truhe vergriffen hat?
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_09"); //(gibt vor nachzudenken) Nee, ich kann mich an niemanden erinnern.
		AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER_10"); //Verdammt, niemand weiß etwas...
	};
	//TIMEVAR_Dotter_Angry = Wld_GetTimePlus(2,0,0);
	
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 0;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER)
	&& MISVAR_Dotter_realisedCrime == TRUE
	&& MISVAR_Crime_Paid == FALSE
	&& isTalking()
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_00"); //Mit Dieben spreche ich nicht!
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__13_DOTTER_LOCK_01"); //Zahl erstmal die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_info;
	description	= "Wegen deines Verdachts... (Furt anschwärzen)";
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__9_DOTTER)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__10_FURT))
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__11_DOTTER)
	&& !SuccessQ(TOPIC_AllesFuersGold)
	&& RunningQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_00"); //Du hattest doch Furt im Verdacht, oder?
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_01"); //Ja, der Drecksack wollte mir das Buch schon einmal klauen.
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_02"); //Nun, er hat mir erzählt, dass er sich das Buch jetzt tatsächlich unter den Nagel reißen konnte.
	if (HItem(ItWr_BuddlerBuch, 1) 
	|| (Mob_HasItems("DOTTER_CHEST", ItWr_BuddlerBuch) != 1 
	  && Npc_KnowsInfo (hero, DIA_GM_K1_ALLESFUERSGOLD_UD__8_FURT_SUCCESS))){
		AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_03"); //Nach dem Lesen hat er es verbrannt, um den Beweis loszuwerden.	
	};
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_04"); //Ich wusste es! Das wird für ihn Konsequenzen haben. Danke, du bist voll in Ordnung.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__14_DOTTER_05"); //Da du mir gegenüber so freundlich warst, werde ich dir jetzt auch was vom Goldschürfen erzählen.
	B_Upgrade_Hero_HackChance(10);
	XP(100);
	AI_StopProcessInfos (self);
	Quest(TOPIC_AllesFuersGold, T_FAILED, "Um meine Haut zu retten, habe ich Furt angeschwärzt, indem ich Dotters Verdacht gegenüber Furt ausgenutzt habe. Dafür hat mir Dotter ein paar Tricks im Goldschürfen gezeigt.");
	IncAndPrint_Verschlagenheit();
};
	
instance DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_condition;
	information	= DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_condition()
{
	if FailedQ(TOPIC_AllesFuersGold)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_info()
{
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_00"); //Du dreckiger Verräter. Du hast mich angeschwärzt? 
	AI_Output (other, self, "DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_01"); //Wer sagt das?!
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_02"); //Dotter nannte dich als Zeugen.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_03"); //(entmutigt) Jetzt muss ich über ein Jahr lang schürfen, um die Schulden bei Umar abzubezahlen.
	AI_Output (self, other, "DIA_GM_K1_ALLESFUERSGOLD_UD__15_FURT_04"); //(angewidert) Wir beide sind miteinander durch!
	XP(-100);
};
	
instance DIA_GM_K1_RIOT_1_KUNISLAV_INTRO (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_condition;
	information	= DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_2_KUNISLAV)
	&& MISVAR_Helped_TRIV >= 2
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_00"); //Was ist denn hier los? Wieso steht ihr alle hier so aufgeschreckt rum?
	AI_Output (self, other, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_01"); //Was geht dich das an?
	AI_Output (other, self, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_02"); //Keine Ahnung, ich wollte nur schauen, ob ich helfen kann.
	AI_Output (self, other, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_03"); //Und wie willst du das anstellen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_04"); //Also, wenn du mir erzählst, was hier los ist, dann kann ich mir was einfallen lassen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_1_KUNISLAV_INTRO_05"); //Na gut. Es geht um die Buddler. Die scheinen einen Aufstand zu planen.
};
	
instance DIA_GM_K1_RIOT_2_KUNISLAV (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_2_KUNISLAV_condition;
	information	= DIA_GM_K1_RIOT_2_KUNISLAV_info;
	description	= "Wer bist du eigentlich?";
};

FUNC int DIA_GM_K1_RIOT_2_KUNISLAV_condition()
{
	return TRUE;
};

FUNC void DIA_GM_K1_RIOT_2_KUNISLAV_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_2_KUNISLAV_00"); //Wer bist du eigentlich?
	AI_Output (self, other, "DIA_GM_K1_RIOT_2_KUNISLAV_01"); //Ich bin Kunislav, die rechte Hand des Don.
	AI_Output (other, self, "DIA_GM_K1_RIOT_2_KUNISLAV_02"); //Der Don? Wer ist das?
	AI_Output (self, other, "DIA_GM_K1_RIOT_2_KUNISLAV_03"); //Du kennst den Don nicht? Er ist der Anführer des Triumvirats, die einzige Instution in dieser Goldmine, die für Recht und Ordnung sorgt.
	AI_Output (self, other, "DIA_GM_K1_RIOT_2_KUNISLAV_04"); //Wir sind es zum Beispiel auch, die die Minecrawler auf Abstand halten und die Schürfer bei Streitigkeiten unterstützen.
	Info("Triumvirat", "Das Triumvirat tut so, als wären sie die Beschützer der Buddler. Sie verteidigen sie angeblich sogar ganz alleine vor den Minecrawlern.");
};
	
instance DIA_GM_K1_RIOT_2_KUNISLAV_3 (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 20;
	condition	= DIA_GM_K1_RIOT_2_KUNISLAV_3_condition;
	information	= DIA_GM_K1_RIOT_2_KUNISLAV_3_info;
	description	= "Wieso nennt er sich Don?";
};

FUNC int DIA_GM_K1_RIOT_2_KUNISLAV_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_2_KUNISLAV)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_2_KUNISLAV_3_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_2_KUNISLAV_3_00"); //Wieso nennt er sich Don? Etwas ungewöhnlich...
	AI_Output (self, other, "DIA_GM_K1_RIOT_2_KUNISLAV_3_01"); //Der Don hat seinen früheren Buddlernamen ablegt und ist zum Don aufgestiegen, um die Buddler zu beschützen.
};
	
instance DIA_GM_K1_RIOT_4_KUNISLAV (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 21;
	condition	= DIA_GM_K1_RIOT_4_KUNISLAV_condition;
	information	= DIA_GM_K1_RIOT_4_KUNISLAV_info;
	description	= "Ein Aufstand?";
};

FUNC int DIA_GM_K1_RIOT_4_KUNISLAV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_1_KUNISLAV_INTRO)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_4_KUNISLAV_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_00"); //Ein Aufstand?
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_01"); //Ja, die Buddler lehnen sich gegen das Triumvirat auf. Es hatte mit dem Schürfer Mors angefangen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_02"); //Dieser wollte seine Abgaben an das Triumvirat nicht leisten.
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_03"); //Kurz darauf entstand ein Gerücht darüber, dass einer der Eintreiber ihn umgebracht hätte.
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_04"); //Das stimmt nicht?
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_05"); //Nein! Wir sind eine beschützende Institution!
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_06"); //Jetzt weigert sich auch Tires, seine Abgaben zu zahlen.
};
	
instance DIA_GM_K1_RIOT_4_KUNISLAV_5 (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 13;
	condition	= DIA_GM_K1_RIOT_4_KUNISLAV_5_condition;
	information	= DIA_GM_K1_RIOT_4_KUNISLAV_5_info;
	description	= "Was ist mit den Rekruten?";
};

FUNC int DIA_GM_K1_RIOT_4_KUNISLAV_5_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_4_KUNISLAV)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_4_KUNISLAV_5_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_5_00"); //Was ist mit den Rekruten? Müssten die nicht eigentlich eure Arbeit machen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_5_01"); //Damit meine ich, die Buddler beschützen und Streit schlichten.
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_5_02"); //Sollten sie, aber es ist ihnen egal, da wir ja hier sind.
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_5_03"); //Ich glaube kaum, dass es ihnen egal ist.
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_5_04"); //Wir sorgen dafür, dass es ihnen egal ist.
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_5_05"); //Also bestecht ihr sie?
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_5_06"); //(entsetzt) Wie kommst du denn darauf?
	AI_Output (other, self, "DIA_GM_K1_RIOT_4_KUNISLAV_5_07"); //Nur so eine Ahnung.
	AI_Output (self, other, "DIA_GM_K1_RIOT_4_KUNISLAV_5_08"); //Natürlich nicht.
};
	
instance DIA_GM_K1_RIOT_6_KUNISLAV_QUEST (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 24;
	condition	= DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_condition;
	information	= DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_info;
	description	= "Wie kann ich euch helfen?";
};

FUNC int DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_1_KUNISLAV_INTRO)
	&& (SuccessQ(TOPIC_Verstecken) || FailedQ(TOPIC_Verstecken))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_00"); //Wie kann ich euch helfen?
	AI_Output (self, other, "DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_01"); //Ein Informant hat uns berichtet, dass die Buddler einen Aufstand planen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_02"); //Leider konnte er uns keine konkreten Namen liefern. Wir wollen wissen, wer diese Sache ins Leben gerufen hat und ein paar Takte mit ihm reden.
	AI_Output (self, other, "DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_03"); //Du könntest für uns den Namen des Aufwieglers herausfinden. Dies passt sehr gut, da du weder richtiger Schürfer bist, noch zum Triumvirat gehörst.
	AI_Output (other, self, "DIA_GM_K1_RIOT_6_KUNISLAV_QUEST_04"); //Ich werde mich umhören.
	Quest(TOPIC_Riot, T_NEW, "Kunislav hat mir von einem Aufstand der Buddler erzählt und mich gebeten den Aufrührer und Anführer des Aufstandes ausfindig zu machen.");
	MISVAR_Riot = TRUE;
};
	
instance DIA_GM_K1_RIOT_7_KUNISLAV (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 4;
	condition	= DIA_GM_K1_RIOT_7_KUNISLAV_condition;
	information	= DIA_GM_K1_RIOT_7_KUNISLAV_info;
	description	= "Wo soll ich anfangen?";
};

FUNC int DIA_GM_K1_RIOT_7_KUNISLAV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_6_KUNISLAV_QUEST)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_7_KUNISLAV_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_7_KUNISLAV_00"); //Wo soll ich anfangen?
	AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_01"); //Frag mal Frand. Der hatte kürzlich ein Problem mit einem der Schürfer. Ich glaube, es war Tires.
	AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_02"); //(zwinkernd) Dieser kann dir bestimmt etwas zum Aufstand sagen, wenn du ihn entsprechend freundlich fragst.
};
	
instance DIA_GM_K1_RIOT_7_KUNISLAV_7_5 (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_7_KUNISLAV_7_5_condition;
	information	= DIA_GM_K1_RIOT_7_KUNISLAV_7_5_info;
	description	= "Was weißt du über den Buddleraufstand?";
};

FUNC int DIA_GM_K1_RIOT_7_KUNISLAV_7_5_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_7_KUNISLAV)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_1_1_FRAND_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_7_KUNISLAV_7_5_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_00"); //Was weißt du über den Buddleraufstand?
	AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_01"); //Hat dir Kunislav davon erzählt?
	AI_Output (other, self, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_02"); //Ja, ich soll helfen den Anführer zu finden.
	if (Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_2_1_FRAND_SUCCESS) || Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_4_TIRES_CANGO))
	{
		AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_03"); //Nun gut. Wie bereits erklärt, hat Tires uns um eine Menge Gold betrogen. Ich denke, er könnte ein Teil des Buddleraufstands sein oder ihn sogar angezettelt haben.
		Quest(TOPIC_Riot, T_ENTRY, "Tires schuldet dem Triumvirat Gold, allerdings werde ich ihn nach der Geschichte zwischen ihm und Frand wohl kaum noch dazu befragen können.");
	}else{
		AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_04"); //Nun gut. Tires hat uns um eine Menge Gold betrogen. Ich denke, er könnte ein Teil des Buddleraufstands sein oder ihn sogar angezettelt haben.
		AI_Output (self, other, "DIA_GM_K1_RIOT_7_KUNISLAV_7_5_05"); //Er müsste hier irgendwo in der Mine sein. Dort solltest du suchen.
		Quest(TOPIC_Riot, T_ENTRY, "Tires schuldet dem Triumvirat Gold, ich sollte ihn mal suchen.");
	};
	
};
	
instance DIA_GM_K1_RIOT_8_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 3;
	condition	= DIA_GM_K1_RIOT_8_MORTY_condition;
	information	= DIA_GM_K1_RIOT_8_MORTY_info;
	description	= "Was weißt du über den Buddleraufstand?";
};

FUNC int DIA_GM_K1_RIOT_8_MORTY_condition()
{
	if RunningQ(TOPIC_Riot)
	&& MISVAR_Riot == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_8_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_8_MORTY_00"); //Was weißt du über den Buddleraufstand?
	AI_Output (self, other, "DIA_GM_K1_RIOT_8_MORTY_01"); //(unbeeindruckt) Buddleraufstand? Noch nie von gehört.
	if SuccessQ(TOPIC_MortyArbeit){
		AI_Output (self, other, "DIA_GM_K1_RIOT_8_MORTY_02"); //Ich bin zufrieden, dass ich überhaupt eine Arbeit habe.
	}else{
		AI_Output (self, other, "DIA_GM_K1_RIOT_8_MORTY_03"); //Ich bin gerade auf der Suche nach einer Arbeit, da hab ich keine Zeit für irgendwelche Aufstände.
	};
};
	
instance DIA_GM_K1_RIOT_9_NEMS (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 3;
	condition	= DIA_GM_K1_RIOT_9_NEMS_condition;
	information	= DIA_GM_K1_RIOT_9_NEMS_info;
	description	= "Weißt du etwas über den Buddleraufstand?";
};

FUNC int DIA_GM_K1_RIOT_9_NEMS_condition()
{
	if RunningQ(TOPIC_Riot)
	&& !MISVAR_Triv_Tot
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_9_NEMS_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_00"); //Weißt du etwas über den Buddleraufstand?
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_01"); //Wieso willst du das denn wissen?
	Info_ClearChoices (DIA_GM_K1_RIOT_9_NEMS);
	Info_AddChoice (DIA_GM_K1_RIOT_9_NEMS, "Ich möchte dem Aufstand helfen.", DIA_GM_K1_RIOT_9_NEMS_1);
	Info_AddChoice (DIA_GM_K1_RIOT_9_NEMS, "Das kann ich dir nicht sagen, aber es ist wichtig.", DIA_GM_K1_RIOT_9_NEMS_2);
	Info_AddChoice (DIA_GM_K1_RIOT_9_NEMS, "Kunislav will, dass ich den Aufrührer finde.", DIA_GM_K1_RIOT_9_NEMS_3);
};
	
FUNC void DIA_GM_K1_RIOT_9_NEMS_1()
{
	Bekannt_DIA_GM_K1_RIOT_9_NEMS_1 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_1_00"); //Ich möchte dem Aufstand helfen. Die Buddler haben hier bereits genug gelitten.
	if (Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_2_TIRES)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_1_01"); //Schon alleine Tires' Schwierigkeiten mit Frand und der Tod von Mors reichen für mich aus.
		AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_1_02"); //Das kann nicht so weitergehen!
	};
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_1_03"); //Tatsächlich? Interessanter Standpunkt...
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_1_04"); //Ich weiß leider nichts Genaues. Frag doch mal den Rodg. Vielleicht kann er dir weiterhelfen.
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_1_05"); //Rodg? Er ist doch Schmied und nicht Buddler.
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_1_06"); //Na und? Er bekommt viel mit. Jeder Buddler gibt sein Gold bei ihm ab.
	Quest(TOPIC_Riot, T_ENTRY, "Rodg könnte mit dem Aufstand zu tun haben oder zumindest wissen, wer zu den Aufrührern gehört.");
	B_StartOtherRoutine(loa_none_6403_Morty, "preRiot");
	Info_ClearChoices (DIA_GM_K1_RIOT_9_NEMS);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_RIOT_9_NEMS_2()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_2_00"); //Das kann ich dir nicht sagen, aber es ist wichtig.
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_2_01"); //Tut mir leid, hab leider nichts davon gehört.
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_2_02"); //Ich muss dann weitermachen.
	Info_ClearChoices (DIA_GM_K1_RIOT_9_NEMS);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_RIOT_9_NEMS_3()
{
	Bekannt_DIA_GM_K1_RIOT_9_NEMS_3 = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_3_00"); //Kunislav will, dass ich den Aufrührer finde.
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_3_01"); //(ungläubig) Tatsächlich? Nun, dann solltest du mal mit Dotter sprechen.
	AI_Output (other, self, "DIA_GM_K1_RIOT_9_NEMS_3_02"); //Dotter? Der ist doch der beste Freund des Triumvirats, oder irre ich mich da?!
	AI_Output (self, other, "DIA_GM_K1_RIOT_9_NEMS_3_03"); //Geh und sprich einfach mit ihm. Du findest ihn ab Mitternacht im Nebengang des Crawlerstollens.
	Info_ClearChoices (DIA_GM_K1_RIOT_9_NEMS);
	AI_StopProcessInfos (self);
	Quest(TOPIC_Riot, T_ENTRY, "Dotter scheint bei dieser Sache der Drahtzieher zu sein. Ich sollte mich vergewissern, dass er der Anführer ist, bevor ich Kunislav berichte.");
	NewRout(self, "Riot");
	NewRout(loa_none_6411_Furt, "Riot");
	NewRout(loa_none_6403_Morty, "Riot");
	NewRout(loa_none_6412_Buddler, "Riot");
	NewRout(loa_none_6413_Buddler, "Riot");
	NewRout(loa_none_6414_Buddler, "Riot");
	NewRout(loa_none_6415_Buddler, "Riot");
	NewRout(loa_none_6417_Buddler, "Riot");
	NewRout(loa_none_6419_Buddler, "Riot");
	NewRout(loa_none_6420_Buddler, "Riot");
	NewRout(loa_none_6421_Buddler, "Riot");
	NewRout(loa_none_6422_Buddler, "Riot");
	NewRout(loa_none_6423_Buddler, "Riot");
	NewRout(loa_none_6405_Nems, "Riot");
	MISVAR_Riot = FALSE;
};
	
instance DIA_GM_K1_RIOT_11_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 3;
	condition	= DIA_GM_K1_RIOT_11_MORTY_condition;
	information	= DIA_GM_K1_RIOT_11_MORTY_info;
	description	= "(Auf Treffen mit Rodg ansprechen)";
};

FUNC int DIA_GM_K1_RIOT_11_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_8_MORTY)
	&& RunningQ(TOPIC_Riot)
	&& !MISVAR_Triv_Tot
	&& Kapitel == 8
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_11_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_00"); //Ich habe von deinem Treffen mit Rodg erfahren. Ihr plant einen Buddleraufstand.
	AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_01"); //Was erzählst du da?
	AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_02"); //Tires hat euch beobachtet und belauscht.
	AI_ReadyMeleeWeapon(self);
	AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_03"); //Stirb!
	AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_04"); //Hey, hey, sachte. Ich bin auf eurer Seite.
	AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_05"); //Woher soll ich das wissen? Du könntest ein Spitzel des Dons sein.
	AMBVAR_Riot_help = 0;
	if (SuccessQ(TOPIC_MortySchulden)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_06"); //Habe ich dir nicht bei deinem Schuldenproblem geholfen?
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_07"); //Stimmt.
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_MortyArbeit)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_08"); //Was ist mit deiner Arbeit? Hast du vergessen, wer dir geholfen hat?!
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_09"); //Stimmt, das warst du.
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_Verstecken)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_10"); //Ich habe Tires geholfen, aus der Goldmine zu fliehen, weil er um sein Leben fürchten musste. Die Eintreiber haben ihn schikaniert.
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_11"); //Davon hab ich gehört.
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_AllesfuersGold)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_12"); //Furt hab ich bei seinem Problem mit Dotter geholfen.
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_13"); //Du hast Recht, er hat es mir selbst erst kürzlich erzählt.
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_MorsKill)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_14"); //Ich habe die Mörder von Mors aufgedeckt. Zeugt das nicht von meiner Einstellung?
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_15"); //Hmm... Da hast du Recht. Das war schon ein Ding.
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_Bestechlich)){
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_16"); //Ich konnte aufzeigen, dass die Rekruten geschmiert wurden.
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_17"); //Zeugt dies nicht erst recht, dass ich gegen das Triumvirat bin?
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_18"); //Da kann man wohl nichts gegen einwenden.
		AMBVAR_Riot_help += 2;
	};
	if(AMBVAR_Riot_help <= 2){
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_19"); //Ich bin mir nicht ganz sicher, auf welcher Seite du stehst.
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_20"); //Stirb!
		B_Attack(self, other, AR_KILL, 1);
		B_Attack(loa_none_6412_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6413_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6414_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6415_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6417_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6419_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6420_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6421_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6422_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6423_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6424_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6425_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6426_Buddler, other, AR_KILL, 1);
		B_Attack(loa_none_6427_Buddler, other, AR_KILL, 1);
	}else {
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_21"); //Gut, du hast mich überzeugt, dass du uns helfen willst. Deine Großzügigkeit ist überwältigend.
		MISVAR_Riot_pro_Buddler = TRUE;
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_22"); //Wir treffen uns immer nach Mitternacht, um das weitere Vorgehen zu besprechen.
		AI_Output (other, self, "DIA_GM_K1_RIOT_11_MORTY_23"); //Und wo?
		AI_Output (self, other, "DIA_GM_K1_RIOT_11_MORTY_24"); //In dem verlassenen Gang, der direkt an den Crawlerschacht angrenzt. Dort wirst du uns antreffen.
		Quest(TOPIC_Riot, T_ENTRY, "Ich weiß jetzt, wo sich die Aufrührer treffen.");
	};
	
};
	
instance DIA_GM_K1_RIOT_12_FURT (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 3;
	condition	= DIA_GM_K1_RIOT_12_FURT_condition;
	information	= DIA_GM_K1_RIOT_12_FURT_info;
	permanent	= TRUE;
	description	= "Weißt du, wieso die Buddler einen Aufstand planen?";
};

FUNC int DIA_GM_K1_RIOT_12_FURT_condition()
{
	if RunningQ(TOPIC_Riot)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_12_FURT_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_12_FURT_00"); //Weißt du, wieso die Buddler einen Aufstand planen?
	AI_Output (self, other, "DIA_GM_K1_RIOT_12_FURT_01"); //Woher hast du das denn? Mir ist sowas nicht bekannt.
	Info_ClearChoices (DIA_GM_K1_RIOT_12_FURT);
	Info_AddChoice (DIA_GM_K1_RIOT_12_FURT, "Hab ich von einem der Buddler.", DIA_GM_K1_RIOT_12_FURT_1);
	Info_AddChoice (DIA_GM_K1_RIOT_12_FURT, "Kunislav will, dass ich den Aufrührer finde.", DIA_GM_K1_RIOT_12_FURT_2);
};
	
FUNC void DIA_GM_K1_RIOT_12_FURT_2()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_12_FURT_2_00"); //Kunislav will, dass ich den Aufrührer finde.
	AI_Output (self, other, "DIA_GM_K1_RIOT_12_FURT_2_01"); //Tut mir leid, da kann ich dir nicht helfen.
	Info_ClearChoices (DIA_GM_K1_RIOT_12_FURT);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_K1_RIOT_12_FURT_1()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_12_FURT_1_00"); //Hab ich von einem der Buddler.
	AI_Output (self, other, "DIA_GM_K1_RIOT_12_FURT_1_01"); //Aha.
	AI_Output (other, self, "DIA_GM_K1_RIOT_12_FURT_1_02"); //Du weißt nichts darüber?
	AI_Output (self, other, "DIA_GM_K1_RIOT_12_FURT_1_03"); //Nein, ich hab nichts gehört.
	Info_ClearChoices (DIA_GM_K1_RIOT_12_FURT);
};
	
instance DIA_GM_K1_RIOT_13_DOTTER (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 3;
	condition	= DIA_GM_K1_RIOT_13_DOTTER_condition;
	information	= DIA_GM_K1_RIOT_13_DOTTER_info;
	description	= "Weißt du etwas über den Buddleraufstand?";
};

FUNC int DIA_GM_K1_RIOT_13_DOTTER_condition()
{
	if RunningQ(TOPIC_Riot)
	&& MISVAR_Riot == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_13_DOTTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_13_DOTTER_00"); //Weißt du etwas über den Buddleraufstand?
	AI_Output (self, other, "DIA_GM_K1_RIOT_13_DOTTER_01"); //Wieso sollte ich denn? Mir erzählt doch kein Arsch was!
	AI_Output (self, other, "DIA_GM_K1_RIOT_13_DOTTER_02"); //Nee, ich bleib lieber für mich alleine.
	AI_Output (self, other, "DIA_GM_K1_RIOT_13_DOTTER_03"); //Nachher wollen die noch mein Gold haben oder sogar meine Schürffähigkeiten erlernen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_13_DOTTER_04"); //Nein, danke!
	Quest(TOPIC_Riot, T_ENTRY, "Dotter weiß scheinbar von nichts. Angeblich erzählt ihm sowieso niemand etwas.");
};
	
instance DIA_GM_K1_RIOT_14_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_14_MORTY_condition;
	information	= DIA_GM_K1_RIOT_14_MORTY_info;
	description	= "Habt ihr auch jemanden, der euch anführt?";
};

FUNC int DIA_GM_K1_RIOT_14_MORTY_condition()
{
	if MISVAR_Riot_pro_Buddler == TRUE
	&& Npc_GetDistToWp(self, "GM_BUD_RIOT_02") <= 500
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_14_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_14_MORTY_00"); //Habt ihr auch jemanden, der euch anführt?
	AI_Output (self, other, "DIA_GM_K1_RIOT_14_MORTY_01"); //Nun, wenn du so willst, dann bin ich sozusagen derjenige. Ich habe den Gedanken zuerst geäußert.
};
	
instance DIA_GM_K1_RIOT_15_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_15_MORTY_condition;
	information	= DIA_GM_K1_RIOT_15_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_15_MORTY_condition()
{
	if Bekannt_DIA_GM_K1_RIOT_9_NEMS_3
	&& SDistTo("GM_BUD_RIOT_02", 800)
	&& !MISVAR_Triv_Tot
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_15_MORTY_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_15_MORTY_00"); //Wen suchst du?
	AI_Output (other, self, "DIA_GM_K1_RIOT_15_MORTY_01"); //Dotter. Ich habe gehört, dass er etwas über den Aufstand weiß.
	AI_Output (self, other, "DIA_GM_K1_RIOT_15_MORTY_02"); //(gelassen) Ja, wir haben die frohe Kunde schon gehört. (brüllend) Triumviratsschwein!
	B_Attack(self, other, AR_KILL, 1);
	B_Attack(loa_none_6412_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6413_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6414_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6415_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6417_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6419_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6420_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6421_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6422_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6411_Furt,    other, AR_KILL, 1);
	B_Attack(loa_none_6405_Nems,    other, AR_KILL, 1);
	B_Attack(loa_none_6417_Buddler, other, AR_KILL, 1);
	B_Attack(loa_none_6419_Buddler, other, AR_KILL, 1);
};
	
instance DIA_GM_K1_RIOT_16_RODG (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_16_RODG_condition;
	information	= DIA_GM_K1_RIOT_16_RODG_info;
	permanent	= TRUE;
	description	= "(auf den Aufstand ansprechen)";
};

FUNC int DIA_GM_K1_RIOT_16_RODG_condition()
{
	if !MISVAR_Riot_pro_Buddler
	&& RunningQ(TOPIC_Riot)
	&& Bekannt_DIA_GM_K1_RIOT_9_NEMS_1
	&& !MISVAR_Triv_Tot
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_16_RODG_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_00"); //Nems sagte mir, dass du einiges mitbekommst.
	AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_01"); //Manchmal mehr, als ich wissen will.
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_02"); //Ich möchte herausfinden, wer zum Buddleraufstand gehört.
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_03"); //Ich würde mich ihnen gerne anschließen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_04"); //Was geht dich das denn an? Du bist doch kein Buddler und ich bezweifle, dass du einer werden willst bei deiner Aufmachung.
	Info_ClearChoices (DIA_GM_K1_RIOT_16_RODG);
	Info_AddChoice (DIA_GM_K1_RIOT_16_RODG, "Kunislav will, dass ich den Aufrührer finde.", DIA_GM_K1_RIOT_16_RODG_1);
	Info_AddChoice (DIA_GM_K1_RIOT_16_RODG, "Ich möchte den Buddlern helfen.", DIA_GM_K1_RIOT_16_RODG_2);
	//Test
	//Quest(TOPIC_Riot, T_NEW, "start");
	//Quest(TOPIC_MortySchulden, T_NEW, "TOPIC_MortySchulden");
	//Quest(TOPIC_Bestechlich, T_NEW, "TOPIC_MortySchulden");
	//Quest(TOPIC_AllesfuersGold, T_NEW, "TOPIC_MortySchulden");
	//Quest(TOPIC_MortySchulden, T_SUCCESS, "TOPIC_MortySchulden");
	//Quest(TOPIC_Bestechlich, T_SUCCESS, "TOPIC_MortySchulden");
	//Quest(TOPIC_AllesfuersGold, T_SUCCESS, "TOPIC_MortySchulden");
};
	
FUNC void DIA_GM_K1_RIOT_16_RODG_1()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_1_00"); //Kunislav will, dass ich den Aufrührer finde.
	AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_1_01"); //Ach so, na das erklärt einiges.
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_1_02"); //Und kannst du mir helfen?
	AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_1_03"); //Nein, leider nicht. Ich meine, ich bin ein Schmied und habe nichts mit dem Buddleraufstand zu tun.
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_1_04"); //...
	Info_ClearChoices (DIA_GM_K1_RIOT_16_RODG); 
};
	
FUNC void DIA_GM_K1_RIOT_16_RODG_2()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_2_00"); //Ich habe diesen Missständen in der Goldmine schon lange genug zugeschaut.
	AMBVAR_Riot_help = 0;
	if (SuccessQ(TOPIC_MortySchulden)){
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_MortyArbeit)){
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_Verstecken)){
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_AllesfuersGold)){
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_MorsKill)){
		AMBVAR_Riot_help += 1;
	};
	if (SuccessQ(TOPIC_Bestechlich)){
		AMBVAR_Riot_help += 1;
	};
	if(AMBVAR_Riot_help <= 2) && !FailedQ(TOPIC_AllesFuersGold){
		AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_2_01"); //Ich bin mir nicht sicher, ob du den Buddlern gegenüber freundlich gestimmt bist.
		AI_Output (other, self, "DIA_GM_K1_RIOT_16_RODG_2_02"); //Wie könnte ich dich davon überzeugen?
		AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_2_03"); //Indem du den armen Schweinen hier hilfst.
	}else if !FailedQ(TOPIC_AllesFuersGold)
	{
		AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_2_04"); //Viele positive Meldungen haben mich erreicht. Ich denke, du stehst auf unserer Seite.
		AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_2_05"); //Wir treffen uns ab Mitternacht im Nebengang vor dem Crawlerstollen. Dort wirst du mehr über den Aufstand erfahren und wie du helfen kannst.
		Quest(TOPIC_Riot, T_ENTRY, "Die Beteiligten des Aufstandes treffen sich in der Nähe des Crawlerstollens.");
		B_StartOtherRoutine(loa_none_6411_Furt, "Riot");
		B_StartOtherRoutine(loa_none_6403_Morty, "Riot");
		B_StartOtherRoutine(loa_none_6405_Nems, "Riot");
		B_StartOtherRoutine(loa_none_6412_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6413_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6414_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6415_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6417_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6419_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6420_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6421_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6422_Buddler, "Riot");
		B_StartOtherRoutine(loa_none_6423_Buddler, "Riot");
		MISVAR_Riot_pro_Buddler = TRUE;
		MISVAR_Riot = FALSE;
	}else{
		AI_Output (self, other, "DIA_GM_K1_RIOT_16_RODG_2_06"); //Ich habe von der Sache mit Furt gehört. Jemand, der so eiskalt ist, kann sich nicht für die Belange der Buddler interessieren.
		Quest(TOPIC_Riot, T_FAILED, "Das mit Furt habe ich wohl verbockt und so das Vertrauen aller Buddler verloren. Es wird mir niemand was Vernünftiges über den Aufstand und erst recht nichts über ihren Anführer erzählen.");
	};
	Info_ClearChoices (DIA_GM_K1_RIOT_16_RODG);
};
	
instance DIA_GM_K1_RIOT_17_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_17_MORTY_condition;
	information	= DIA_GM_K1_RIOT_17_MORTY_info;
	description	= "Was habt ihr jetzt vor?";
};

FUNC int DIA_GM_K1_RIOT_17_MORTY_condition()
{
	if MISVAR_Riot_pro_Buddler == TRUE
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	&& Npc_GetDistToWp(loa_none_6403_Morty, "GM_BUD_RIOT_02") <= 1000
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_17_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_17_MORTY_00"); //Was habt ihr jetzt vor?
	AI_Output (self, other, "DIA_GM_K1_RIOT_17_MORTY_01"); //Wir wollen besprechen, wie wir weiter vorgehen.
	AI_Output (other, self, "DIA_GM_K1_RIOT_17_MORTY_02"); //Schon etwas Konkretes?
	AI_Output (self, other, "DIA_GM_K1_RIOT_17_MORTY_03"); //Nein, aber gleich geht es los. Du kannst dich auch daran beteiligen.
	TIMEVAR_PRE_RIOT = Wld_GetTimePlus(0,0,20);
	Quest(TOPIC_Riot, T_ENTRY, "In Kürze beginnt eine Besprechung der Buddler. Ich sollte mich jetzt entscheiden, ob ich den Anführer des Aufstands an Kunislav melde oder ob ich den Buddlern helfe.");
};
	
instance DIA_GM_K1_RIOT_18_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_info;
	description	= "Wer hat das ganze denn überhaupt losgetreten?";
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_condition()
{
	if MISVAR_Riot_pro_Buddler == TRUE
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	&& Npc_GetDistToWp(loa_none_6403_Morty, "GM_BUD_RIOT_02") <= 1000
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_00"); //Wer hat das ganze denn überhaupt losgetreten?
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_01"); //Nun, ich denke, das bin ich. Jedoch ich bin nicht der Einzige, der mit diesen Missständen unzufrieden ist.
	Quest(TOPIC_Riot, T_ENTRY, "Morty ist der Aufrührer. Allerding sind wohl ziemlich alle Buddler mit den derzeitigen Missständen unzufrieden.");
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_17_MORTY)
	&& Npc_GetDistToWp(loa_none_6403_Morty, "GM_BUD_RIOT_02") <= 600
	&& Npc_GetDistToWp(loa_none_6411_Furt, "GM_BUD_RIOT_02") <= 600
	&& Npc_GetDistToWp(loa_none_6405_Nems, "GM_BUD_RIOT_02") <= 600
	&& !MISVAR_Triv_Tot
	&& Wld_isAfterTime(TIMEVAR_PRE_RIOT)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_info()
{
	NewRout(loa_none_6438_Frand, "Attack");
	NewRout(loa_none_6441_Eintreiber, "Attack");
	NewRout(loa_none_6442_Eintreiber, "Attack");
	NewRout(loa_none_6443_Eintreiber, "Attack");
	NewRout(loa_none_6449_Eintreiber, "Attack");
	NewRout(loa_none_6437_Togen, 		"Attack2");
	NewRout(loa_none_6439_Kunislav, 	"Attack2");
	NewRout(loa_none_6440_Don, 			"Attack2");
	
	var c_npc TRIA_Morty; TRIA_Morty = Hlp_GetNpc(loa_none_6403_Morty);
	var c_npc TRIA_Furt; TRIA_Furt = Hlp_GetNpc(loa_none_6411_Furt);
	var c_npc TRIA_Nems; TRIA_Nems = Hlp_GetNpc(loa_none_6405_Nems);
	
	TRIA_Invite(TRIA_Furt);
	TRIA_Invite(TRIA_Nems);
	TRIA_Start();
	DIAG_Reset();
	
	TRIA_Next(TRIA_Morty);
	AI_TurnToNpc(self, TRIA_Furt);
	AI_TurnToNpc(TRIA_Furt, TRIA_Morty);
	AI_TurnToNpc(TRIA_Nems, TRIA_Morty);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_00"); //Wir sind hier, um das weitere Vorgehen zu besprechen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_01"); //Die Lage hier in der Mine kann nicht mehr so weitergehen.
	AI_TurnToNpc(hero, self);
	TRIA_Next(TRIA_Furt);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_02"); //Und was schlägst du vor? Willst du mit unbewaffneten Buddlern gegen brutale Aufseher vorgehen?
	TRIA_Next(TRIA_Morty);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_03"); //Nein, wir brauchen Waffen. Waffen, und einen Plan wie wir die Eintreiber loswerden.
	TRIA_Next(TRIA_Nems);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_04"); //Wofür Waffen? Wir haben doch jeder unsere Spitzhacke. Damit können wir kämpfen.
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_05"); //Und der Plan? Wie wollt ihr das Triumvirat stürzen?
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_06"); //Ohne zu kämpfen, werden diese Barbaren nicht von hier verschwinden.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_07"); //Doch wenn wir ihnen offen gegenüber treten, dann schlachten sie uns einfach ab.
	TRIA_Next(TRIA_Morty);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_08"); //Also greifen wir verdeckt an?
	TRIA_Next(TRIA_Furt);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_09"); //Ja, aber ich möchte niemanden töten. Ich bin Schürfer und kein Mörder.
	TRIA_Next(TRIA_Morty);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_10"); //Die Zeit zum Kämpfen ist jetzt gekommen. Es ist kein Mord, sondern die Befreiung von der Tyrannei!
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_11"); //Dafür kämpfe ich!
	TRIA_Next(TRIA_Nems);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_12"); //Dafür kämpfe ich!
	TRIA_Next(TRIA_Furt);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_13"); //Dafür kämpfe ich!
	TRIA_Next(TRIA_Morty);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_14"); //Was ist mit dir, hilfst du uns bei diesem Vorhaben?
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_15"); //Ja, das werde ich. Dass ihr kampfbereit seid, sehe ich.
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_16"); //Nur was ist denn jetzt genau der Plan? Wie überlisten wir sie?
	AI_Wait(self,2);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_17"); //Ich weiß es, ihre Schwachstelle ist die tägliche Patroullie.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18"); //Wenn wir zum richtigen Zeitpunkt zuschlagen, dann treffen wir sie jedes Mal einzeln an.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_19"); //Dann hat auch der beste Krieger keine Chance.
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_20"); //Gut. Eine große Meute erregt jedoch zuviel Aufsehen.
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_21"); //Ich schlage vor, dass wir eine kleine Einheit bilden, die gezielt zuschlägt, während der Rest die wichtigen Triumviratsmitglieder beobachtet.
	TRIA_Next(TRIA_Furt);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_22"); //Ein guter Vorschlag. Ich führe die zweite Gruppe zum Raum vor den Schmiedeöfen. Wir sorgen dafür, dass der Don und seine Männer nicht rauskommen.
	TRIA_Next(TRIA_Nems);
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_23"); //Gut. Ich und Morty werden mit dir kommen. Zwei weitere Männer werden dir zur Seite stehen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_24"); //Wir schlagen jetzt zu!
	
	Quest(TOPIC_Riot, T_ENTRY, "Die Buddler haben sich entschieden, das Triumvirat zu stürzen. Wir werden die Eintreiber einzeln ausschalten, während Furt mit dem Rest Stellung vor ihrem Lager hält. Ich soll mir noch ein paar Männer schnappen, die mich, Nems und Morty beim Angriff unterstützen.");
	DIAG_Reset();
	TRIA_Finish();
	
	
	loa_none_6403_Morty.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_none_6405_Nems.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_none_6414_Buddler.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_none_6415_Buddler.aivar[AIV_PARTYMEMBER] = TRUE;
	loa_none_6403_Morty.flags = NPC_FLAG_IMMORTAL;
	loa_none_6405_Nems.flags = NPC_FLAG_IMMORTAL;
	loa_none_6411_Furt.flags = NPC_FLAG_IMMORTAL;
	
	NewRout(loa_none_6403_Morty, "Attack");
	NewRout(loa_none_6405_Nems, "Attack");
	
	NewRout(loa_none_6411_Furt, "Attack");
	NewRout(loa_none_6412_Buddler, "Attack");
	NewRout(loa_none_6413_Buddler, "Attack");
	NewRout(loa_none_6414_Buddler, "Attack");
	NewRout(loa_none_6415_Buddler, "Attack");
	NewRout(loa_none_6417_Buddler, "Attack");
	NewRout(loa_none_6419_Buddler, "Attack");
	NewRout(loa_none_6420_Buddler, "Attack");
	NewRout(loa_none_6421_Buddler, "Attack");
	NewRout(loa_none_6422_Buddler, "Attack");
	NewRout(loa_none_6423_Buddler, "Attack");
	
	AI_StopProcessInfos (self);
	//B_KillNpc(loa_none_6438_Frand);
	AI_Function(loa_none_6405_Nems, evt_attackTriv);
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1 (C_INFO)
{
	npc			= loa_none_6441_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_00"); //Hey, was macht ihr hier? Wieso hockt ihr so auf einem Haufen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_01"); //Zeit zu sterben, du Drecksack!
	loa_none_6441_Eintreiber.guild = GIL_BDT;
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_1_EINTREIBER1_02"); //Das wagt ihr nicht. Der Don wird euch fertig machen, wenn ihr mich anrührt, also verpisst euch!
	AI_StopProcessInfos (self);
	Npc_RemoveImmortality(self);
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2 (C_INFO)
{
	npc			= loa_none_6442_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_00"); //Hey, was macht ihr hier? Wieso hockt ihr so auf einem Haufen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_01"); //Zeit zu sterben, du Drecksack!
	loa_none_6442_Eintreiber.guild = GIL_BDT;
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_2_EINTREIBER2_02"); //Das wagt ihr nicht. Der Don wird euch fertig machen, wenn ihr mich anrührt, also verpisst euch!
	AI_StopProcessInfos (self);
	Npc_RemoveImmortality(self);
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3 (C_INFO)
{
	npc			= loa_none_6443_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_00"); //Hey, was macht ihr hier? Wieso hockt ihr so auf einem Haufen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_01"); //Zeit zu sterben, du Drecksack!
	loa_none_6443_Eintreiber.guild = GIL_BDT;
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_3_EINTREIBER3_02"); //Das wagt ihr nicht. Der Don wird euch fertig machen, wenn ihr mich anrührt, also verpisst euch!
	AI_StopProcessInfos (self);
	Npc_RemoveImmortality(self);
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4 (C_INFO)
{
	npc			= loa_none_6449_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_00"); //Hey, was macht ihr hier? Wieso hockt ihr so auf einem Haufen?
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_01"); //Zeit zu sterben, du Drecksack!
	loa_none_6449_Eintreiber.guild = GIL_BDT;
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_4_EINTREIBER4_02"); //Das wagt ihr nicht. Der Don wird euch fertig machen, wenn ihr mich anrührt, also verpisst euch!
	AI_StopProcessInfos (self);
	Npc_RemoveImmortality(self);
};
	
instance DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND (C_INFO)
{
	npc			= loa_none_6438_Frand;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_condition;
	information	= DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_00"); //Hey, was macht ihr hier alle? Wollt ihr euch schon wieder beschweren?
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_01"); //Verdammt, das wird Kunislav und dem Don gar nicht gefallen!
	AI_Output (other, self, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_02"); //Halt's Maul, Frand! Jetzt wirst du für alles bezahlen, was du den Buddlern hier angetan hast.
	AI_Output (self, other, "DIA_GM_K1_RIOT_18_MORTY_TRIA_18_5_FRAND_03"); //Das wagt ihr nicht. Der Don wird euch dafür fertig machen, also verpisst euch wieder zu euren Arbeitsplätzen!
	loa_none_6438_Frand.guild = GIL_BDT;
	AI_StopProcessInfos (self);
	Npc_RemoveImmortality(loa_none_6439_Kunislav);
	Npc_RemoveImmortality(loa_none_6437_Togen);
	Npc_RemoveImmortality(loa_none_6440_Don);
	Npc_RemoveImmortality(self);
};
	
instance DIA_GM_K1_RIOT_19_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_19_MORTY_condition;
	information	= DIA_GM_K1_RIOT_19_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_19_MORTY_condition()
{
	if Npc_GetDistToWp(self, "GM_B_81") <= 1000
	&& DEADVAR_Eintreiber1
	&& DEADVAR_Eintreiber2
	&& DEADVAR_Eintreiber3
	&& DEADVAR_Eintreiber4
	&& DEADVAR_Frand
	&& !MISVAR_Triv_Tot
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_19_MORTY_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_19_MORTY_00"); //Gut, Frand scheint auch schon tot zu sein.
	AI_Output (other, self, "DIA_GM_K1_RIOT_19_MORTY_01"); //Wollen wir da einfach reinspazieren?
	AI_Output (self, other, "DIA_GM_K1_RIOT_19_MORTY_02"); //Natürlich. Wir sind ihnen weit überlegen durch unsere Anzahl.
	AI_Output (other, self, "DIA_GM_K1_RIOT_19_MORTY_03"); //Nun gut, folgt mir.
	NewRout(loa_none_6403_Morty, 	 "Attack2");
	NewRout(loa_none_6405_Nems, 	 "Attack2");
	NewRout(loa_none_6411_Furt, 	 "Attack2");
	NewRout(loa_none_6412_Buddler, "Attack2");
	NewRout(loa_none_6413_Buddler, "Attack2");
	NewRout(loa_none_6414_Buddler, "Attack2");
	NewRout(loa_none_6415_Buddler, "Attack2");
	NewRout(loa_none_6417_Buddler, "Attack2");
	NewRout(loa_none_6419_Buddler, "Attack2");
	NewRout(loa_none_6420_Buddler, "Attack2");
	NewRout(loa_none_6421_Buddler, "Attack2");
	NewRout(loa_none_6422_Buddler, "Attack2");
	NewRout(loa_none_6423_Buddler, "Attack2");
	
	loa_none_6437_Togen.guild = GIL_BDT;
	loa_none_6439_Kunislav.guild = GIL_BDT;
	loa_none_6440_Don.guild = GIL_BDT;
	Npc_SetTrueGuild(loa_none_6437_Togen, GIL_BDT);
	Npc_SetTrueGuild(loa_none_6439_Kunislav, GIL_BDT);
	Npc_SetTrueGuild(loa_none_6440_Don, GIL_BDT);
	AI_Teleport(loa_none_6440_Don, "GM_B_92");
	NewRout(loa_none_6440_Don, "riot");
	AI_Teleport(loa_none_6439_Kunislav, "GM_B_93");
	NewRout(loa_none_6439_Kunislav, "riot");
	AI_Teleport(loa_none_6437_Togen, "GM_B_93");
	NewRout(loa_none_6437_Togen, "riot");
	Npc_RemoveImmortality(loa_none_6439_Kunislav);
	Npc_RemoveImmortality(loa_none_6437_Togen);
	Npc_RemoveImmortality(loa_none_6440_Don);
};
	
instance DIA_GM_K1_RIOT_20_MORTY_SUCCESS (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_20_MORTY_SUCCESS_condition;
	information	= DIA_GM_K1_RIOT_20_MORTY_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_RIOT_20_MORTY_SUCCESS_condition()
{
	if (DEADVAR_Togen
	&& DEADVAR_Don
	&& DEADVAR_Kunislav
	&& SDistTo("GM_B_93", 1000)) || MISVAR_Triv_Tot == TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_20_MORTY_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_RIOT_20_MORTY_SUCCESS_00"); //Super, wir sind endlich wieder frei von der Tyrannei! Danke dafür... Wir werden deine Beteiligung nie vergessen!
	AI_Output (self, other, "DIA_GM_K1_RIOT_20_MORTY_SUCCESS_01"); //Jetzt können wir endlich wieder unser Feierabendbier genießen, ohne uns Gedanken über das Triumvirat machen zu müssen.
	AI_Output (self, other, "DIA_GM_K1_RIOT_20_MORTY_SUCCESS_02"); //Ich habe ein wenig für eine Belohnung gesammelt. Hier.
	Reward(73);
	XP(300);
	loa_none_6403_Morty.aivar[AIV_PARTYMEMBER] = FALSE;
	loa_none_6405_Nems.aivar[AIV_PARTYMEMBER] = FALSE;
	loa_none_6414_Buddler.aivar[AIV_PARTYMEMBER] = FALSE;
	loa_none_6415_Buddler.aivar[AIV_PARTYMEMBER] = FALSE;
	Quest(TOPIC_Riot, T_SUCCESS, "Die Buddler haben das Triumvirat mit meiner Hilfe gestürzt. Sie haben sich sehr dankbar gezeigt.");
	loa_none_6403_Morty.flags = 0;
	loa_none_6405_Nems.flags = 0;
	loa_none_6411_Furt.flags =0;
	if RunningQ(TOPIC_Triumvirat){
		Quest(TOPIC_Triumvirat, T_SUCCESS, "Die Sache mit dem Triumvirat hat sich anscheinend erledigt.");
	};
	
	NewRout(loa_none_6403_Morty, 	 "start");
			NewRout(loa_none_6405_Nems, 	 "start");
			NewRout(loa_none_6411_Furt, 	 "start");
			NewRout(loa_none_6412_Buddler, "start");
			NewRout(loa_none_6413_Buddler, "start");
			NewRout(loa_none_6414_Buddler, "start");
			NewRout(loa_none_6415_Buddler, "start");
			NewRout(loa_none_6417_Buddler, "start");
			NewRout(loa_none_6419_Buddler, "start");
			NewRout(loa_none_6420_Buddler, "start");
			NewRout(loa_none_6421_Buddler, "start");
			NewRout(loa_none_6422_Buddler, "start");
			NewRout(loa_none_6423_Buddler, "start");
};
	
instance DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS (C_INFO)
{
	npc			= loa_none_6439_Kunislav;
	nr			= 10;
	condition	= DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_condition;
	information	= DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_info;
	description	= "Ich weiß, wer der Aufwiegler ist. Es ist Morty.";
};

FUNC int DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_condition()
{
	if !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY)
	&& RunningQ(TOPIC_Riot)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_00"); //Ich weiß, wer der Aufwiegler ist. Es ist Morty.
	AI_Output (self, other, "DIA_GM_K1_RIOT_21_KUNISLAV_SUCCESS_01"); //Gut, er wird aus dem Weg geschafft. Dafür erhälst du auch eine faire Belohnung.
	CreateAndGive(ItMi_GoldNugget_Addon, 100);
	Quest(TOPIC_Riot, T_SUCCESS, "Ich habe Kunislav den Namen des Aufwieglers verraten und wurde fürstlich entlohnt.");
	XP(200);
	B_KillNpc(loa_none_6403_Morty);
			NewRout(loa_none_6405_Nems, 	 "start");
			NewRout(loa_none_6411_Furt, 	 "start");
			NewRout(loa_none_6412_Buddler, "start");
			NewRout(loa_none_6413_Buddler, "start");
			NewRout(loa_none_6414_Buddler, "start");
			NewRout(loa_none_6415_Buddler, "start");
			NewRout(loa_none_6417_Buddler, "start");
			NewRout(loa_none_6419_Buddler, "start");
			NewRout(loa_none_6420_Buddler, "start");
			NewRout(loa_none_6421_Buddler, "start");
			NewRout(loa_none_6422_Buddler, "start");
			NewRout(loa_none_6423_Buddler, "start");
	
	if (RunningQ(TOPIC_MortySchulden)){
		Quest(TOPIC_MortySchulden, T_FAILED, "");
	};
	if (RunningQ(TOPIC_MortyArbeit)){
		Quest(TOPIC_MortyArbeit, T_FAILED, "");
	};
	if (RunningQ(TOPIC_Verstecken)){
		Quest(TOPIC_Verstecken, T_FAILED, "");
	};
	if (RunningQ(TOPIC_AllesfuersGold)){
		Quest(TOPIC_AllesfuersGold, T_FAILED, "");
	};
	if (RunningQ(TOPIC_MorsKill)){
		Quest(TOPIC_MorsKill, T_FAILED, "");
	};
	if (RunningQ(TOPIC_Bestechlich)){
		Quest(TOPIC_Bestechlich, T_FAILED, "");
	};
	
};
	
instance DIA_GM_K1_TRIUMVIRAT_4 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_4_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_4_info;
	description	= "Mors ist tot.";
};

FUNC int DIA_GM_K1_TRIUMVIRAT_4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_1)
	&& (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_3) || Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_3) || Npc_KnowsInfo (hero, DIA_GM_AMBIENT_EINTREIBER_INTRO))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_4_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_4_00"); //Mors ist tot.
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_4_01"); //Ja, bedauerlich. Unsere Ermittlungen sind im Sand verlaufen.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_4_02"); //Also habt ihr aufgegeben und lasst den Mörder ziehen?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_4_03"); //Was sollen wir machen, wenn wir keine weiteren Spuren haben?
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_4_04"); //Anscheinend gar nichts...
};
	
instance DIA_GM_K1_TRIUMVIRAT_7 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_7_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_7_info;
	description	= "Tires ist auch Opfer des Triumvirats geworden.";
};

FUNC int DIA_GM_K1_TRIUMVIRAT_7_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_6)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_TRIV_VERSTECKEN_5_TIRES_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_7_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_7_00"); //Tires ist auch Opfer des Triumvirats geworden.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_7_01"); //Die haben ihn solange erpresst, bis er aus der Goldmine flüchten musste, da er um sein Leben fürchtete.
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_7_02"); //Das ist eine echte Schande!
	MISVAR_Triumvirat_bad_deeds += 1;
	Quest(TOPIC_Triumvirat, T_ENTRY, "Das Triumvirat hat Tires bedroht. Umar weiß jetzt davon. Dies hilft dabei das Triumvirat aufzuhalten.");
};
	
instance DIA_GM_K1_TRIUMVIRAT_8 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_8_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_8_info;
	description	= "Ich habe die Schuldenliste von Frand.";
};

FUNC int DIA_GM_K1_TRIUMVIRAT_8_condition()
{
	if (HItem(ItMi_DeptList, 1))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_8_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_8_00"); //Ich habe die Schuldenliste von Frand. Diese beweist, dass die Eintreiber des Triumvirats die Buddler erpressen.
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_8_01"); //Dies ist ein guter Beweis. Damit sind wir einen guten Schritt weitergekommen, doch dies allein reicht nicht aus, um das ganze Triumvirat zu belasten.
	MISVAR_Triumvirat_bad_deeds += 2;
	Take(ItMi_DeptList, 1);
};
	
instance DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_info;
	permanent	= TRUE;
	description	= "Werdet ihr dem Triumvirat jetzt Einhalt gebieten?";
};

FUNC int DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_condition()
{
	if isTalking()
	&& (Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_7) || Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_3))
	&& RunningQ(TOPIC_TRIUMVIRAT)
	&& MISVAR_Triumvirat_bad_deeds <= 5
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_00"); //Werdet ihr dem Triumvirat jetzt Einhalt gebieten?
	if (MISVAR_Triumvirat_bad_deeds < 3){
			AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_01"); //Leider reichen die Beweise nicht aus.
			AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_02"); //Momentan können wir nur die Augen offen halten.	
	}else{
			AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_03"); //Ja, das reicht mir. Die kriminelle Energie des Triumvirats ist eindeutig!
			AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_04"); //Ich werde Verstärkung aus der Stadt anfordern, um sie problemlos verhaften zu können.
			AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_UMAR_TRIUMVIRAT_05"); //Du wirst die Nachricht an Cortez überbringen. Dieser wird sie dann an Hamilkar weiterleiten.
			CreateAndGive(ItWr_VerstaerkungfuerUmar,1);
			MISVAR_Triumvirat_bad_deeds += 10;
			if RunningQ(TOPIC_Riot){
				Quest(TOPIC_Riot, T_ENTRY, "Ich werde den Rekruten helfen, das Triumvirat aufzuhalten.");	
			};
			if !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_18_MORTY_TRIA){
				Quest(TOPIC_Triumvirat, T_ENTRY, "Umar hat mir ein Gesuch um Verstärkung gegeben, welches ich Cortez überbringen soll. Es sind mehr Männer nötig, um das Triumvirat dingfest machen zu können.");
			};
	};
};
	
instance DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL (C_INFO)
{
	npc			= loa_mil_6207_Cortez;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_info;
	description	= "Ich habe hier ein wichtiges Schreiben von Umar.";
};

FUNC int DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_condition()
{
	if (HItem(ItWr_VerstaerkungfuerUmar,1)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	&& RunningQ(TOPIC_Triumvirat))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_info()
{
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_00"); //Ich habe hier ein wichtiges Schreiben von Umar.
	Take(ItWr_VerstaerkungfuerUmar,1);
	if (Npc_HasItems (self, Fakescroll_Addon) == FALSE){
		CreateInvItem (self, Fakescroll_Addon);
	};
	B_StopLookAt (self);
	AI_UseItemToState (self, Fakescroll_Addon, 1);
	AI_Wait (self, 3);
	AI_UseItemToState (self, Fakescroll_Addon, -1);
	Npc_SetStateTime (self, 0);
	Npc_RemoveInvItems(self, Fakescroll_Addon, 1);
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_01"); //Hmm... Gut, ich leite das weiter. Danke für's Überbringen.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_02"); //Willst du das Gesuch nicht zu Hamilkar bringen?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_03"); //Doch, aber der hat gerade Wichtigeres zu tun. Ich erledige das später.
	XP(100);
	MISVAR_Triv_Tot = TRUE;
	Quest(TOPIC_Triumvirat, T_ENTRY, "Ich habe das Schreiben von Umar überbracht und sollte Umar Bescheid geben.");
	Info_ClearChoices (DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL);
	Info_AddChoice (DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL, "(zur Goldmine zurückkehren)", DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_FAST);
	Info_AddChoice (DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL, DIALOG_BACK, DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_SLOW);
};
	
FUNC void DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_FAST()
{
	Info_ClearChoices (DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL);
	AI_StopProcessInfos (self);
	AI_Wait(hero, 2);
	Wld_PlayEffect("BLACK_SCREEN_3", hero, hero, 0, 0, 0, FALSE);
	AI_Teleport(hero, "WP_MINE_08");
	AI_PrintScreen ("... nach einem langen Fußmarsch ...", -1, YPOS_ItemGiven, FONT_ScreenSmall, 2);
};
	
FUNC void DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL_SLOW()
{
	Info_ClearChoices (DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL);
};
	
instance DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_condition;
	information	= DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_CORTEZ_GIVEZETTEL)
	&& MISVAR_Triv_Tot == 2
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_00"); //Da hast du aber was verpasst. Die Sache mit dem Triumvirat hat sich erledigt.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_01"); //Was ist denn passiert?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_02"); //Die Buddler haben sich erhoben und haben ihre Unterdrücker erschlagen.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_03"); //Toll, und was ist jetzt mit der Unterstützung?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_04"); //Die sollen ruhig kommen. Wir sind hier sowieso völlig unterbesetzt.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_05"); //Verstehe. Werdet ihr die Buddler für das Abschlachten des Triumvirats bestrafen?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_06"); //Nein, das wird wohl nicht möglich sein. Es war ein so großes Kollektiv am Überfall beteiligt, sodass wir da nichts machen können.
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_07"); //Wieso nicht? Habt ihr Angst?
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_08"); //Das nicht, aber wenn wir sie alle einsperren, dann haben wir keine Arbeiter mehr und die Mine steht leer.
	AI_Output (self, other, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_09"); //Das heißt, kein Gold für die Stadt und kein Gold für den König. Stell dir vor, was dann los ist...
	AI_Output (other, self, "DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS_10"); //Schon gut, ich hab's verstanden. 
	XP(100);
	Quest(TOPIC_Triumvirat, T_SUCCESS, "Die Buddler haben sich selbst des Problems angenommen und alle Mitglieder des Triumvirats erschlagen.");
};
	
instance DIA_GM_K1_HOLGA_1_HOLGALOA (C_INFO)
{
	npc			= loa_none_6452_HolgaLOA;
	nr			= 10;
	condition	= DIA_GM_K1_HOLGA_1_HOLGALOA_condition;
	information	= DIA_GM_K1_HOLGA_1_HOLGALOA_info;
	description	= "Was machst du hier draußen?";
};

FUNC int DIA_GM_K1_HOLGA_1_HOLGALOA_condition()
{
	return TRUE;
};

FUNC void DIA_GM_K1_HOLGA_1_HOLGALOA_info()
{
	AI_Output (other, self, "DIA_GM_K1_HOLGA_1_HOLGALOA_00"); //Was machst du hier draußen?
	AI_Output (self, other, "DIA_GM_K1_HOLGA_1_HOLGALOA_01"); //(traurig) Ich bin Holga. Eigentlich bin ich nur ein Knecht von den Bauernhöfen, der keine Lust mehr hat für einen Hungerlohn auf den Feldern zu schuften.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_1_HOLGALOA_02"); //Da bin ich einfach abgehauen, aber in der Stadt ist es auch verdammt schwer, gute Arbeit zu bekommen. 
	AI_Output (self, other, "DIA_GM_K1_HOLGA_1_HOLGALOA_03"); //Immerhin habe ich dort viel über die große Goldmine hier draußen in der Wildnis gehört und da will ich jetzt hin, um als Buddler zu arbeiten.
};
	
instance DIA_GM_K1_HOLGA_2_HOLGALOA_NEW (C_INFO)
{
	npc			= loa_none_6452_HolgaLOA;
	nr			= 10;
	condition	= DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_condition;
	information	= DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_info;
	description	= "Und warum sitzt du dann hier herum?";
};

FUNC int DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_HOLGA_1_HOLGALOA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_info()
{
	AI_Output (other, self, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_00"); //Und warum sitzt du dann hier herum?
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_01"); //(verärgert) Witzbold! Der Weg ist verdammt gefährlich, das haben mir die Rekruten in der Stadt auch gesagt. 
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_02"); //In gewissen Abständen schickt die Stadt einen bewaffneten Versorgungstrupp zur Mine, da hätte ich mich anschließen können, aber ich hatte es eilig und wollte nicht so lange warten.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_03"); //Mein Kumpel Lefty, den ich in der Stadt kennengelernt habe, ist mit mir gemeinsam aufgebrochen. Wir dachten, zu zweit schaffen wir es, aber kurz vor dem Ziel wurden wir von einem Rudel Snapper überrascht.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_04"); //Lefty ist auf der Flucht vor den Snappern von der Klippe gestürzt und eines der Mistviecher mit ihm.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_05"); //Nur dadurch konnte ich entkommen - und jetzt sitze ich hier fest.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_06"); //(verbittert) Wenn der Versorgungstrupp nicht bald kommt, gehe ich in die Stadt zurück oder ich versuche, im Hafen Arbeit zu finden.
	Info_ClearChoices (DIA_GM_K1_HOLGA_2_HOLGALOA_NEW);
	Info_AddChoice (DIA_GM_K1_HOLGA_2_HOLGALOA_NEW, "Dann wünsche ich dir viel Erfolg dabei!", DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_1);
	Info_AddChoice (DIA_GM_K1_HOLGA_2_HOLGALOA_NEW, "Wir könnten zusammen zur Mine gehen.", DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_2_NEW);
};
	
FUNC void DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_1()
{
	AI_Output (other, self, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_1_00"); //Dann wünsche ich dir viel Erfolg dabei!
	Info_ClearChoices (DIA_GM_K1_HOLGA_2_HOLGALOA_NEW);
};
	
FUNC void DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_2_NEW()
{
	Bekannt_DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_2_NEW = TRUE;
	
	AI_Output (other, self, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_2_NEW_00"); //In die Goldmine will ich auch. Ich werde schon mit den Viechern fertig, wenn du mir den Weg zeigst.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_2_HOLGALOA_NEW_2_NEW_01"); //Folge mir.
	Info_ClearChoices (DIA_GM_K1_HOLGA_2_HOLGALOA_NEW);
	Quest(TOPIC_Minenzugang, T_NEW, "Der Knecht Holga will als Buddler in der Goldmine arbeiten. Da ich auch in die Goldmine will, habe ich ihm angeboten, den Weg freizumachen.");
	AI_StopProcessInfos (self);
	NewRout(self, "guide");
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	if !Bekannt_GM_K1_HOLGA_REVEALQB{
		Hlp_Questbezeichner(2);
	};
};
	
instance DIA_GM_K1_HOLGA_3_HOLGALOA (C_INFO)
{
	npc			= loa_none_6452_HolgaLOA;
	nr			= 2;
	condition	= DIA_GM_K1_HOLGA_3_HOLGALOA_condition;
	information	= DIA_GM_K1_HOLGA_3_HOLGALOA_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_HOLGA_3_HOLGALOA_condition()
{
	if SDistTo("LOA_M1_MAINSTREET_01", 1000)
	&& !Npc_KnowsInfo (hero, DIA_GM_K1_HOLGA_4_HOLGALOA)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_HOLGA_3_HOLGALOA_info()
{
	AI_Output (self, other, "DIA_GM_K1_HOLGA_3_HOLGALOA_00"); //Dort hinter der Brücke warten die Viecher schon.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_3_HOLGALOA_01"); //Ich gehe zurück zu meinem Lagerplatz. Viel Glück!
	NewRout(self, "start");
};
	
instance DIA_GM_K1_HOLGA_4_HOLGALOA (C_INFO)
{
	npc			= loa_none_6452_HolgaLOA;
	nr			= 10;
	condition	= DIA_GM_K1_HOLGA_4_HOLGALOA_condition;
	information	= DIA_GM_K1_HOLGA_4_HOLGALOA_info;
	description	= "Der Weg ist jetzt frei, komm mit!";
};

FUNC int DIA_GM_K1_HOLGA_4_HOLGALOA_condition()
{
	if RunningQ(TOPIC_Minenzugang)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_HOLGA_4_HOLGALOA_info()
{
	AI_Output (other, self, "DIA_GM_K1_HOLGA_4_HOLGALOA_00"); //Der Weg ist jetzt frei, komm mit!
	NewRout(self, "follow");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS (C_INFO)
{
	npc			= loa_none_6452_HolgaLOA;
	nr			= 1;
	condition	= DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_condition;
	information	= DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_condition()
{
	if Npc_GetDistToWP(self, "WP_MINE_06") < 1200
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_info()
{
	AI_Output (self, other, "DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_00"); //Wir haben es geschafft, ich danke dir.
	AI_Output (self, other, "DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_01"); //Ich habe keine wertvollen Sachen bei mir, aber dieses alte Pergament hier habe ich bei dem Lagerplatz gefunden. 
	AI_Output (self, other, "DIA_GM_K1_HOLGA_5_HOLGALOA_SUCCESS_02"); //Es scheint sich um einen Bauplan zu handeln, aber ich verstehe nichts davon. Vielleicht ist es wertvoll und du kannst etwas damit anfangen.
	
	CreateAndGive(ItWr_CrawlerPlan, 1);
	XP(100);
	Quest(TOPIC_Minenzugang, T_SUCCESS, "Ich habe Holga sicher zur Goldmine gebracht. Als Belohnung konnte er mir nur ein altes Pergament geben, aber vielleicht kann ich damit etwas anfangen.");
	AI_StopProcessInfos (self);
	NewRout(self, "Mine");
	self.aivar[AIV_PARTYMEMBER] = FALSE;
};
	
instance DIA_GM_K1_GMINTRO_1_RODG_NEW (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_1_RODG_NEW_condition;
	information	= DIA_GM_K1_GMINTRO_1_RODG_NEW_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_GMINTRO_1_RODG_NEW_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_UMAR_INTRO)
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_1_RODG_NEW_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_1_RODG_NEW_00"); //Umar sagt, ich soll mir von dir eine Spitzhacke geben lassen.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_01"); //(mürrisch) Na gut, wenn das Umar gesagt hat, hier hast du eine Spitzhacke. 
	CreateAndGive(ItMw_2H_Axe_L_01, 1);
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_02"); //Aber dafür kannst du gleich mal was für mich erledigen.
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_1_RODG_NEW_03"); //Was soll ich denn machen?
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_04"); //Die Stadt schickt regelmäßig einen Versorgungskonvoi mit ausreichend Lebensmitteln und sonstigen Gütern in die Mine, damit wir hier nicht verhungern.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_05"); //Auf dem Rückweg nehmen sie dann das geschürfte Gold mit und bringen es in die Burg des Fürsten.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_06"); //Hier liegen noch die Warenpakete der letzten Lieferung, die bringst du jetzt zu unserem Proviantmeister.
	CreateAndGive(ItMi_Warenpacket, 10);
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_1_RODG_NEW_07"); //Wo finde ich den Proviantmeister?
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_08"); //Der Buddler Morty soll dich hinbringen, dann lernst du auch gleichzeitig die Mine besser kennen. 
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_09"); //Dieser Trottel hat sich neulich verletzt und kann nicht arbeiten.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_10"); //Umar hat ihn zu unserem besten Buddler Dotter geschickt, damit er sich mal ansehen kann, wie man richtig schürft. 
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_11"); //Folge dem Weg in den Schacht unter mir, dann findest du Morty bei der Schürfstelle von Dotter.
	Quest(TOPIC_GMVorraete, T_NEW, "Ich soll für den Schmied Rodg zehn Warenpakete zum Proviantmeister bringen. Der Buddler Morty kann mich hinführen. Ich finde ihn momentan tagsüber im Stollen unterhalb von Rodgs Schmiede an der Schürfstelle von Dotter, dem besten Buddler der Goldmine.");
	if Wld_isTime(22,00,06,00){
		AI_Output (self, other, "DIA_GM_K1_GMINTRO_1_RODG_NEW_12"); //Nachts wird dort aber niemand arbeiten.
	};
};
	
instance DIA_GM_K1_GMINTRO_2_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_2_MORTY_condition;
	information	= DIA_GM_K1_GMINTRO_2_MORTY_info;
	description	= "Ich muss zum Proviantmeister.";
};

FUNC int DIA_GM_K1_GMINTRO_2_MORTY_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_1_RODG_NEW)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_1_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_2_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_2_MORTY_00"); //Ich soll für Rodg die Warenpakete der letzten Lieferung zum Proviantmeister bringen. Kannst du mich hinführen?
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_2_MORTY_01"); //Folge mir.
	NewRout(self, "guideProv");
	TIMEVAR_Morty_goback = Wld_GetTimePlus(0,1,0);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_GMINTRO_3_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_3_MORTY_condition;
	information	= DIA_GM_K1_GMINTRO_3_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_GMINTRO_3_MORTY_condition()
{
	if SDistTo("GM_A_51", 600)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_3_MORTY_info()
{
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_3_MORTY_00"); //Wir sind da. 
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_3_MORTY_01"); //Da vorne kannst du die Lieferung beim Proviantmeister abgeben.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_3_MORTY_02"); //Ich mache hier noch eine kurze Pause.
	NewRout(self, "waitProv");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER (C_INFO)
{
	npc			= loa_none_6448_Proviantmeister;
	nr			= 6;
	condition	= DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_condition;
	information	= DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_info;
	description	= "Ich habe Warenpakete für dich.";
};

FUNC int DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_condition()
{
	if HItem(ItMi_Warenpacket, 10)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_00"); //Ich habe hier die letzte Lieferung aus der Stadt für dich.
	Take(ItMi_Warenpacket, 10);
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_01"); //Danke, das wird aber auch Zeit. Hier, den Schluck hast du dir verdient.
	CreateAndGive(ItFo_Beer, 1);
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_02"); //Du kannst gleich eins der Pakete zu unserer Köchin Zara bringen. Sie hat ihre Küche in der Nähe.
	Give(ItMi_Warenpacket, 1);
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER_03"); //(genervt) Na gut, wird gemacht.
	Quest(TOPIC_GMVorraete, T_ENTRY, "Eines der Warenpakete soll nun noch der Köchin Zara überbracht werden. Diese hat ihre Küche in der Nähe des Proviantlagers.");
};
	
instance DIA_GM_K1_GMINTRO_5_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_5_MORTY_condition;
	information	= DIA_GM_K1_GMINTRO_5_MORTY_info;
	description	= "Kennst du den Weg zu Zara?";
};

FUNC int DIA_GM_K1_GMINTRO_5_MORTY_condition()
{
	if !Bekannt_GM_K1_GMINTRO_MORTY_GOBACK
	&& SDistTo("GM_A_51", 600)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_5_MORTY_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_5_MORTY_00"); //Kannst du mir auch den Weg zur Köchin Zara zeigen?
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_5_MORTY_01"); //Folge mir.
	NewRout(self, "guideZara");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_GMINTRO_6_MORTY (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_6_MORTY_condition;
	information	= DIA_GM_K1_GMINTRO_6_MORTY_info;
	important	= TRUE;
};

FUNC int DIA_GM_K1_GMINTRO_6_MORTY_condition()
{
	if SDistTo("GM_EAT_01", 600)
	&& Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_5_MORTY)
	&& !SuccessQ(TOPIC_GMVorraete)
	&& !Bekannt_GM_K1_GMINTRO_MORTY_GOBACK
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_6_MORTY_info()
{
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_6_MORTY_00"); //Da sind wir, ich verschwinde dann wieder.
	NewRout(self, "start");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_K1_GMINTRO_7_ZARA (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_7_ZARA_condition;
	information	= DIA_GM_K1_GMINTRO_7_ZARA_info;
	description	= "Hier sind neue Lebensmittel.";
};

FUNC int DIA_GM_K1_GMINTRO_7_ZARA_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER)
	&& HItem(ItMi_Warenpacket, 1)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_7_ZARA_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_7_ZARA_00"); //Hier sind neue Lebensmittel vom Provantmeister.
	Take(ItMi_Warenpacket, 1);
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_7_ZARA_01"); //Danke, die Lebensmittel habe ich dringend gebraucht.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_7_ZARA_02"); //(zu sich) Die Lieferungen von der Stadt kommen auch jedes mal später. Na gut, was soll's...
	if RunningQ(TOPIC_GMVorraete){
		Quest(TOPIC_GMVorraete, T_ENTRY, "Ich habe alles ausgeliefert. Ob Rodg mir jetzt dankbar ist?");
	};
	XP(50);
};
	
instance DIA_GM_K1_GMINTRO_8_RODG_SUCCESS (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_condition;
	information	= DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_info;
	description	= "Der Proviantmeister hat die Lieferungen bekommen.";
};

FUNC int DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_4_PROVIANTMEISTER)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_info()
{
	AI_Output (other, self, "DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_00"); //Der Proviantmeister hat die Lieferungen bekommen.
	AI_Output (self, other, "DIA_GM_K1_GMINTRO_8_RODG_SUCCESS_01"); //Na prima, dann kannst du jetzt mit dem Goldhacken anfangen.
	XP(100);
	Quest(TOPIC_GMVorraete, T_SUCCESS, "Bis auf ein Bier hat mir die ganze Sache nicht viel eingebracht...");
};
	
instance DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT (C_INFO)
{
	npc			= loa_mil_6900_rekrut;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_condition;
	information	= DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_00"); //Halt!
	AI_Output (other, self, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_01"); //Was ist los?
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_02"); //Wenn du in die Mine willst, dann sollst du mit Adim sprechen.
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_03"); //Noch etwas. Wir dulden keinen Ärger hier. Ist das klar?!
	Info_ClearChoices (DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT);
	Info_AddChoice (DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT, "Klar.", DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAR);
	Info_AddChoice (DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT, "Ich wollte eh nur ein bisschen Gold klauen.", DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAUEN);
};
	
FUNC void DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAR()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAR_00"); //Klar.
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAR_01"); //Dann haben wir uns ja verstanden.
	Info_ClearChoices (DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT);
};
	
FUNC void DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAUEN()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAUEN_00"); //Ich wollte sowieso nur ein bisschen Gold klauen.
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAUEN_01"); //Keine Scherze. Ich habe dich im Auge, also pass gut auf, was du tust!
	AI_Output (self, other, "DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT_KLAUEN_02"); //Goblins und Langfinger verlieren ab und zu auch schon mal 'ne Hand.
	Info_ClearChoices (DIA_GM_AMBIENT_REKRUT0_REKRUT0_HALT);
};
	
instance DIA_GM_AMBIENT_ADIM_WICHTIGES (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 8;
	condition	= DIA_GM_AMBIENT_ADIM_WICHTIGES_condition;
	information	= DIA_GM_AMBIENT_ADIM_WICHTIGES_info;
	description	= "Was sollte ich über die Mine wissen?";
};

FUNC int DIA_GM_AMBIENT_ADIM_WICHTIGES_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_INTRO))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_WICHTIGES_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_WICHTIGES_00"); //Was sollte ich über die Mine wissen?
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_WICHTIGES_01"); //Die Mine gab es schon als Ahssûn noch nicht zum Königreich gehörte.
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_WICHTIGES_02"); //Sie ist für jeden frei zugänglich. Auch du kannst dein Glück probieren.
};
	
instance DIA_GM_AMBIENT_ADIM_SCHUERFEN (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ADIM_SCHUERFEN_condition;
	information	= DIA_GM_AMBIENT_ADIM_SCHUERFEN_info;
	description	= "Ich kann hier einfach so schürfen?";
};

FUNC int DIA_GM_AMBIENT_ADIM_SCHUERFEN_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_WICHTIGES))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_SCHUERFEN_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_SCHUERFEN_00"); //Ich kann hier einfach so schürfen?
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_SCHUERFEN_01"); //Ja. Allerdings musst du für jeden Goldbrocken, den du aus der Mine mitnimmst, fünf Roperi zahlen.
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_SCHUERFEN_02"); //Wieso das?
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_SCHUERFEN_03"); //Sieh es als Honorierung unserer Arbeit hier an. Die Stadt beschützt die Mine - also hilft die Mine den Rekruten.
};
	
instance DIA_GM_AMBIENT_ADIM_INTRO (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ADIM_INTRO_condition;
	information	= DIA_GM_AMBIENT_ADIM_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_ADIM_INTRO_condition()
{
	if isTalking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_INTRO_00"); //Ich habe dich hier noch nie gesehen.
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_INTRO_01"); //Gerade erst angekommen.
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_INTRO_02"); //Und genau deshalb ist es gut, dass du zu mir gekommen bist.
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_INTRO_03"); //Ich bin Adim und bin für den Mineneingang verantwortlich.
};
	
instance DIA_GM_AMBIENT_ADIM_TIPP (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ADIM_TIPP_condition;
	information	= DIA_GM_AMBIENT_ADIM_TIPP_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_ADIM_TIPP_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_SCHUERFEN))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_TIPP_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_TIPP_00"); //Eins noch.
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_TIPP_01"); //Was ist?
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_TIPP_02"); //Da ich ja kein Halsabschneider bin, möchte ich dir noch einen kleinen Tipp geben.
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_TIPP_03"); //Nimm deine Goldbrocken nicht mit in die Mine, sonst musst du für diese auch noch zahlen.
};
	
instance DIA_GM_AMBIENT_ADIM_TEACH (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ADIM_TEACH_condition;
	information	= DIA_GM_AMBIENT_ADIM_TEACH_info;
	description	= "Kannst du mir was beibringen?";
};

FUNC int DIA_GM_AMBIENT_ADIM_TEACH_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_TEACH_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ADIM_TEACH_00"); //Kannst du mir was beibringen?
	AI_Output (self, other, "DIA_GM_AMBIENT_ADIM_TEACH_01"); //Ich bin geschickt mit der Armbrust. Wenn du Interesse hast, zeig ich dir ein paar Tricks.
	self.aivar[AIV_TEACHER] = TRUE;
	Info(TOPIC_TEACHER, "Adim (GM) kann mir Armbrustschießen beibringen.");
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH, "(Armbrustschießen verbessern)", DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_Info);
};
	
instance DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW (C_INFO)
{
	npc			= loa_mil_6901_adim;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_condition;
	information	= DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_info;
	permanent	= TRUE;
	description	= "(Armbrustschießen verbessern)";
};

FUNC int DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ADIM_TEACH)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_info()
{
	Info_ClearChoices (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow1, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 1)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_1);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow5, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 5)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_5);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, Dialog_Back, DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_BACK);
};
	
FUNC void DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_1()
{
	B_TeachFightTalentPercent (self, other, NPC_TALENT_CROSSBOW, 1, 60);
	Info_ClearChoices (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow1, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 1)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_1);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow5, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 5)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_5);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, Dialog_Back, DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_BACK);
};
	
FUNC void DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_5()
{
	B_TeachFightTalentPercent (self, other, NPC_TALENT_CROSSBOW, 5, 60);
	Info_ClearChoices (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow1, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 1)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_1);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, B_BuildLearnString (PRINT_LearnCrossBow5, B_GetLearnCostTalent (other, NPC_TALENT_CROSSBOW, 5)), DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_5);
	Info_AddChoice (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW, Dialog_Back, DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_BACK);
};
	
FUNC void DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW_BACK()
{
	Info_ClearChoices (DIA_GM_AMBIENT_ADIM_TEACH_CROSSBOW);
};
	
instance DIA_GM_AMBIENT_EINTREIBER_INTRO (C_INFO)
{
	npc			= loa_none_6441_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_EINTREIBER_INTRO_condition;
	information	= DIA_GM_AMBIENT_EINTREIBER_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_EINTREIBER_INTRO_condition()
{
	if TIMEVAR_Eintreiber < Wld_GetDay()
	&& (Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN || Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_OK)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_EINTREIBER_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_00"); //Du hast jetzt die einmalige Gelegenheit, deine tägliche Abgabe zu leisten.
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_INTRO_01"); //Was für eine Abgabe?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_02"); //Ein kleiner Beitrag für das Triumvirat, der hier in diesem Bereich von jedem gefordert wird. Nur zu deinem persönlichen Schutz.
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_INTRO_03"); //Warum sollte ich das tun?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_04"); //Hast du schon vom Schicksal des Buddlers Mors gehört? Er wurde letztens tot in einem der Nebenstollen gefunden. Sein Körper wies sehr viele Knochenbrüche auf.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_05"); //Er hatte an diesem Tag keinen seiner Goldbrocken entrichtet...
	AMBVAR_Triumvirat = TRUE;
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_INTRO);
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_INTRO, "Das Spielchen spiele ich nicht mit.", DIA_GM_AMBIENT_EINTREIBER_INTRO_KEINBOCK);
	if(HItem(ItMi_GoldNugget_Addon,1)){
		Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_INTRO, "Gegen ein wenig Schutz hätte ich nichts einzuwenden.", DIA_GM_AMBIENT_EINTREIBER_INTRO_OK);
	};
	if(!HItem(ItMi_GoldNugget_Addon,1)){
		Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_INTRO, "Ich habe keinen einzigen Goldbrocken.", DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN);
	};
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_INTRO_KEINBOCK()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_INTRO_KEINBOCK_00"); //Das Spielchen spiele ich nicht mit.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_KEINBOCK_01"); //Da hast 'ne ziemlich große Klappe für deine Wanzenmuskeln. Sieh dich bloß vor!
	AMBVAR_Eintreiber_freundlich = 2;
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_INTRO);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_INTRO_OK()
{
	Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_OK = TRUE;
	
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_INTRO_OK_00"); //Gegen ein wenig Schutz hätte ich nichts einzuwenden.
	Take(ItMi_GoldNugget_Addon, 1);
	AMBVAR_Eintreiber_freundlich = 1;
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_OK_01"); //Ich sehe, wir verstehen uns. Bis morgen wird dir nichts geschehen ... Jedenfalls nicht von unserer Seite.
	TIMEVAR_Eintreiber = Wld_GetDay();
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_INTRO);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN()
{
	Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN = TRUE;
	
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN_00"); //Ich habe keinen einzigen Goldbrocken.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN_01"); //(gehässig) Dann solltest du noch heute ordentlich schürfen und morgen pünktlich zahlen. Sonst kann ich für nichts garantieren!
	AMBVAR_Eintreiber_freundlich = 0;
	TIMEVAR_Eintreiber = Wld_GetDay();
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_INTRO);
};
	
instance DIA_GM_AMBIENT_EINTREIBER_2 (C_INFO)
{
	npc			= loa_none_6441_Eintreiber;
	nr			= 20;
	condition	= DIA_GM_AMBIENT_EINTREIBER_2_condition;
	information	= DIA_GM_AMBIENT_EINTREIBER_2_info;
	permanent	= TRUE;
	description	= "Ich habe ein paar Fragen.";
};

FUNC int DIA_GM_AMBIENT_EINTREIBER_2_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_EINTREIBER_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_00"); //Ich habe ein paar Fragen.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_01"); //Geh mir nicht auf den Sack. Was willst du?
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_2);
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_2, "Was geschieht mit dem ganzen Gold, das ihr einsammelt?", DIA_GM_AMBIENT_EINTREIBER_2_1);
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_2, "Kann ich auch Eintreiber werden?", DIA_GM_AMBIENT_EINTREIBER_2_2);
	if (AMBVAR_Eintreiber_freundlich == 2){
		Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_2, "Ich will doch zahlen.", DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN);
	};
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_2_1()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_1_00"); //Was geschieht mit dem ganzen Gold, das ihr einsammelt?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_1_01"); //Offiziell geht das alles ans Triumvirat. Hier unten der Boss zu sein, ist ganz schön teuer, und was übrig bleibt, horten sie in ihren Kisten, auf denen sie wie die Goblins sitzen.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_1_02"); //Und inoffiziell bleibt ja auch noch der eine oder andere Brocken auf der Strecke...
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_2_2()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_2_00"); //Kann ich auch Eintreiber werden?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_2_01"); //(überlegt angestrengt) Nein. Wir nehmen nicht jeden, weißt du.
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_00"); //Ich will doch zahlen.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_01"); //(spöttisch) Oh, da ist jemand vernünftig geworden? Gratulation!
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_02"); //Das macht dann vier Goldbrocken.
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_03"); //Vier Goldbrocken?! Wieso auf einmal so viel?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_04"); //Eine kleine Nachzahlung für die versäumten Tage. Wir lassen uns doch nicht von dir über's Ohr hauen.
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_2);
	if(HItem(ItMi_GoldNugget_Addon, 4)){
		Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_2, "Wenn's sein muss...", DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_OK);
	};
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_2, "Das ist mir zuviel.", DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_VERGISSES);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_OK()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_OK_00"); //Wenn's sein muss...
	Take(ItMi_GoldNugget_Addon, 4);
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_OK_01"); //Du wirst ja doch noch vernünftig.
	AMBVAR_Eintreiber_freundlich = 1;
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_VERGISSES()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_VERGISSES_00"); //Das ist mir zuviel.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_2_DOCH_ZAHLEN_VERGISSES_01"); //Dann solltest du besonders gut auf deinen Rücken aufpassen.
	AMBVAR_Eintreiber_freundlich = 2;
};
	
instance DIA_GM_AMBIENT_EINTREIBER_3 (C_INFO)
{
	npc			= loa_none_6441_Eintreiber;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_EINTREIBER_3_condition;
	information	= DIA_GM_AMBIENT_EINTREIBER_3_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_EINTREIBER_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_EINTREIBER_INTRO)
	&& TIMEVAR_Eintreiber < Wld_GetDay()
	&& (Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_NEIN || Bekannt_DIA_GM_AMBIENT_EINTREIBER_INTRO_OK)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_EINTREIBER_3_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_3_00"); //Bereit zu zahlen?
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_3, "In Ordnung, ich will keinen Ärger.", DIA_GM_AMBIENT_EINTREIBER_3_OK);
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_3, "Von mir bekommt ihr gar nichts mehr.", DIA_GM_AMBIENT_EINTREIBER_3_VERGISS_ES);
	Info_AddChoice (DIA_GM_AMBIENT_EINTREIBER_3, "Ich habe doch vorhin schon gezahlt!", DIA_GM_AMBIENT_EINTREIBER_3_SCHON_GEZAHLT);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_3_OK()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_3_OK_00"); //In Ordnung, ich will keinen Ärger.
	Take(ItMi_GoldNugget_Addon, 1);
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_3_OK_01"); //Das ist die richtige Einstellung. (hämisch) Wir sehen uns dann morgen, und schürf schön fleißig.
	AMBVAR_Eintreiber_freundlich = 1;
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_3);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_3_VERGISS_ES()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_3_VERGISS_ES_00"); //Von mir bekommt ihr gar nichts mehr.
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_3_VERGISS_ES_01"); //Wie niedlich, ein Aufmüpfiger! Ich rate dir bloß, dich von den dunklen Ecken im Stollen fernzuhalten... 
	AMBVAR_Eintreiber_freundlich = 2;
	Info_ClearChoices (DIA_GM_AMBIENT_EINTREIBER_3);
};
	
FUNC void DIA_GM_AMBIENT_EINTREIBER_3_SCHON_GEZAHLT()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER_3_SCHON_GEZAHLT_00"); //Ich habe doch vorhin schon gezahlt!
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_3_SCHON_GEZAHLT_01"); //Da kann ich mich ja gar nicht dran erinnern. 
	if (Npc_HasItems (self, Fakescroll_Addon) == FALSE){
		CreateInvItem (self, Fakescroll_Addon);
	};
	B_StopLookAt (self);
	AI_UseItemToState (self, Fakescroll_Addon, 1);
	AI_Wait (self, 3);
	AI_UseItemToState (self, Fakescroll_Addon, -1);
	Npc_SetStateTime (self, 0);
	Npc_RemoveInvItems(self, Fakescroll_Addon, 1);
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER_3_SCHON_GEZAHLT_02"); //Und hinter 'Typ mit großer Fresse' hab ich keinen Haken gesetzt, also musst du noch zahlen - klar?!
};
	
instance DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO (C_INFO)
{
	npc			= loa_none_6449_Eintreiber;
	nr			= 6;
	condition	= DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_condition;
	information	= DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_condition()
{
	if isTalking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_00"); //Was machst du hier?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_01"); //Ich bewache den Ausgang der Goldmine.
	AI_Output (other, self, "DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_02"); //Wieso?
	AI_Output (self, other, "DIA_GM_AMBIENT_EINTREIBER4_1_EINTREIBER4_INTRO_03"); //Das geht dich nichts an.
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_GERTRUD_INTRO (C_INFO)
{
	npc			= loa_none_6409_Gertrud;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_GERTRUD_INTRO_condition;
	information	= DIA_GM_AMBIENT_GERTRUD_INTRO_info;
	description	= "Warum arbeitest du hier?";
};

FUNC int DIA_GM_AMBIENT_GERTRUD_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_GERTRUD_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_GERTRUD_INTRO_00"); //Warum arbeitest du hier?
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_01"); //Warum sollte ich NICHT hier arbeiten?
	AI_Output (other, self, "DIA_GM_AMBIENT_GERTRUD_INTRO_02"); //Das ist das erste Mal, dass ich eine Frau sehe, die sich in den Berg gräbt.
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_03"); //Normale Frauen haben ja auch nicht Rumar zum Ehemann.
	AI_Output (other, self, "DIA_GM_AMBIENT_GERTRUD_INTRO_04"); //Was ist so schlimm an Rumar?
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_05"); //Ich sagte nicht, dass er schlimm ist. Er ist ein guter Ehemann.
	AI_Output (other, self, "DIA_GM_AMBIENT_GERTRUD_INTRO_06"); //Aber?
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_07"); //Er will möglichst viel verdienen. Ihm hat noch nie gereicht, dass ich den Haushalt mache und nebenbei noch vierzig Stunden die Woche geputzt habe.
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_08"); //Als er dann von der Goldmine gehört hatte, hatte er die tolle Idee, durch mich eine Arbeitskraft sparen zu können.
	AI_Output (self, other, "DIA_GM_AMBIENT_GERTRUD_INTRO_09"); //Jetzt buddel ich hier wie ein beknackter Minecrawler.
};
	
instance DIA_GM_AMBIENT_MORTY_1_INTRO (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_MORTY_1_INTRO_condition;
	information	= DIA_GM_AMBIENT_MORTY_1_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_MORTY_1_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_MORTY_1_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_1_INTRO_00"); //(hysterisch) Nein, bitte, bring mich nicht um! Ich werde bezahlen, sobald ich wieder arbeiten kann!
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_1_INTRO_01"); //Hey, was ist denn mit dir los?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_1_INTRO_02"); //Bitte lass mich am Leben! Ich tue alles, was du willst!
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_1_INTRO_03"); //Aber es will dir hier doch keiner ans Leder.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_1_INTRO_04"); //(verwirrt) Was? Du bist nicht vom Triumvirat? Aber du siehst doch aus wie einer ihrer Schläger. Na, dann vergiss es wieder. Ich mag nichts gesagt haben...
	AMBVAR_Triumvirat = TRUE;
};
	
instance DIA_GM_AMBIENT_MORTY_2 (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 11;
	condition	= DIA_GM_AMBIENT_MORTY_2_condition;
	information	= DIA_GM_AMBIENT_MORTY_2_info;
	description	= "Wie soll ich das vergessen?";
};

FUNC int DIA_GM_AMBIENT_MORTY_2_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_1_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_2_00"); //Wie soll ich das vergessen? Du bist hier wie 'ne Blutfliege am Zittern und am Bibbern.
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_2_01"); //Was ist mit dir los? Warum hast du solche Angst vor Schlägern?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_2_02"); //Die Eintreiber des Triumvirats! Sag mal, du bist noch nicht so lange hier in der Goldmine, oder?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_2_03"); //(hastig) Das Triumvirat kennt jeder. Und die wollen mir an die Pelle. Der Don ist der Schlimmste von allen...
	Info("Triumvirat", "Morty erzählte mir davon, dass jeder das Triumvirat in der Goldmine kennt und er selbst von diesem Verein erpresst wird.");
};
	
instance DIA_GM_AMBIENT_MORTY_3 (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 13;
	condition	= DIA_GM_AMBIENT_MORTY_3_condition;
	information	= DIA_GM_AMBIENT_MORTY_3_info;
	description	= "Erzähl mir zuerst mal vom Triumvirat.";
};

FUNC int DIA_GM_AMBIENT_MORTY_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_1_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_3_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_3_00"); //Jetzt mal ganz langsam. Erzähl mir zuerst mal vom Triumvirat.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_3_01"); //Da gibt's nichts zum Erzählen. Die wollen mich kalt machen, weil ich nicht bezahlen kann.
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_3_02"); //Warum solltest du ihnen überhaupt was bezahlen? Hast du Spielschulden?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_3_03"); //Spielschulden? Ha, schön wär's!
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_3_04"); //Diese Kriminellen nehmen uns den letzten Goldbrocken aus der Tasche. Und das NACHDEM wir die Steuerabgaben geleistet haben.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_3_05"); //Der Traum vom schnellen Geld, der einzige Grund wieso wir alle hier sind, ist hier ganz schnell geplatzt. Versteh mich nicht falsch: Zum Leben reicht es.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_3_06"); //Für gewöhnlich kann ich mir jeden Abend mein Bier leisten. Na ja, Essen wird auch immer zu Genüge aus der Stadt geliefert...
	Info("Triumvirat", "Das Triumvirat holt sich das Gold erst, wenn die Schürfer ihre täglichen Steuerabgaben geleistet haben.");
};
	
instance DIA_GM_AMBIENT_MORTY_4 (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_MORTY_4_condition;
	information	= DIA_GM_AMBIENT_MORTY_4_info;
	description	= "Wieso kannst du dann nicht bezahlen?";
};

FUNC int DIA_GM_AMBIENT_MORTY_4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_3)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_4_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_4_00"); //Wieso kannst du dann nicht bezahlen?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_01"); //Ich habe vor zwei Wochen ruhig vor mich hergeschürft, als es zu knirrschen begann. Ich habe mir nichts dabei gedacht und fuhr fort.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_02"); //Als sich plötzlich ein Balken über mir löste, da war es schon zu spät. Der hat mich komplett unter sich begraben. Mit ein wenig Glück konnte ich durch die Hilfe von Mors das ganze aber noch überleben, weil die Rekruten mich darunterweg hervorgezogen haben.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_03"); //Ich konnte mich eine ganze Woche lang nicht rühren und blieb im Bett. Jetzt kann ich meinen rechten Arm immer noch nicht spüren. Deswegen kann ich auch die Abgaben an das Triumvirat nicht mehr aufbringen.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_04"); //Mit einem Arm lässt sich die alte Batsy, meine Spitzhacke, nicht so einfach schwingen.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_05"); //Das Einzige, was ich jetzt noch machen könnte, wäre die kleinen Restklumpen bei den anderen Buddlern einzusammeln... Aber alle scheuchen mich sofort weg...
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_06"); //Und diese Typen und ihre Listen vergessen nichts. Ich stehe auch noch ausgerechnet auf Frands Liste. Der Typ ist knallhart und verzeiht niemandem.
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_4_07"); //Wieviel schuldest du denen denn?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_4_08"); //Ganze 27 Goldbrocken. Selbst wenn ich arbeiten könnte, dann würde ich diese Menge nicht in weniger als fünf Tagen hacken können. Die Steuerabgaben habe ich bereits abgezogen und keinen eizigen Roperi für Verpflegung gelassen, um das Schutzgeld zahlen zu können.
	
};
	
instance DIA_GM_AMBIENT_MORTY_5 (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_MORTY_5_condition;
	information	= DIA_GM_AMBIENT_MORTY_5_info;
	description	= "Wieso gehst du damit nicht zu den Rekruten?";
};

FUNC int DIA_GM_AMBIENT_MORTY_5_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_4)
	&& (Bekannt_GM_K1_GMINTRO_MORTY_GOBACK || Npc_KnowsInfo (hero, DIA_GM_K1_GMINTRO_5_MORTY))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_5_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_5_00"); //Wieso gehst du damit nicht zu den Rekruten?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_5_01"); //Als ob die sich dafür interessieren könnten. Umar ist der einzige hier, der nicht auch korrupt ist.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_5_02"); //Der Rest der Rekruten sieht einfach gepflegt weg, wenn es Probleme mit den Eintreibern des Triumvirats gibt.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_5_03"); //Dafür erhalten sie natürlich kleine Zuschüsse, die selbstverständlich aus den Taschen der Schürfer bezahlt werden.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_5_04"); //Lediglich Umar macht da nicht mit. Ich bezweifle sogar, dass der etwas von den Schmiergeldern weiß.
	if RunningQ(TOPIC_Triumvirat){
		Quest(TOPIC_Triumvirat, T_ENTRY, "Die Rekruten in der Goldmine sind bestechlich. Nur Umar scheint sauber zu sein.");
	}else{
		Quest(TOPIC_Triumvirat, T_NEW, "Anscheinend gibt es in der Goldmine von Ahssûn eine kriminelle Vereinigung namens 'Triumvirat', die von den Schürfern Schutzgeld erpresst, obwohl diese bereits ihre Steuerabgaben an die Stadt leisten.");
		Quest(TOPIC_Triumvirat, T_ENTRY, "Die Rekruten in der Goldmine sind bestechlich. Nur Umar scheint sauber zu sein.");
	};
};
	
instance DIA_GM_AMBIENT_MORTY_6 (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 3;
	condition	= DIA_GM_AMBIENT_MORTY_6_condition;
	information	= DIA_GM_AMBIENT_MORTY_6_info;
	description	= "Was ist mit anderer Arbeit?";
};

FUNC int DIA_GM_AMBIENT_MORTY_6_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_5)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_6_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_6_00"); //Was ist mit anderer Arbeit? Gibt's hier etwa nichts anderes zu tun?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_6_01"); //Es gebe schon die Aufgabe einige Minecrawler aus ihren Nester zu verjagen, doch das wäre in meinem Zustand hochgradig leichtsinning.
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_6_02"); //Ich könnte höchstens noch als Wasserjunge für die Schürfer arbeiten oder den Eintreibern die Stiefel lecken.
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_6_03"); //Hmm... Ich verstehe.
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV (C_INFO)
{
	npc			= loa_none_6403_Morty;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_condition;
	information	= DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_info;
	description	= "Was macht ihr jetzt, da das Triumvirat weg ist?";
};

FUNC int DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_00"); //Was macht ihr jetzt, da das Triumvirat weg ist?
	AI_Output (self, other, "DIA_GM_AMBIENT_MORTY_7_WHAT_TRIV_01"); //Was wir jetzt machen? In Ruhe arbeiten und unseren Feierabend genießen.
};
	
instance DIA_GM_AMBIENT_NEMS_INTRO (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_NEMS_INTRO_condition;
	information	= DIA_GM_AMBIENT_NEMS_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_NEMS_INTRO_condition()
{
	if isTalking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_NEMS_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_INTRO_00"); //Wer bist du?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_INTRO_01"); //Ich bin Nems, ehemaliger Jäger und Buddler.
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_INTRO_02"); //Bist du aus Ahssûn oder gehörst du zu denen, die ihr Glück im Goldrausch gesucht haben?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_INTRO_03"); //Ursprünglich bin ich aus Wiranon, doch mittlerweile bin ich schon so lange auf Ahssûn, dass ich mich kaum noch an meine Heimat erinnere.
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_INTRO_04"); //Hast du dort keine Verwandten?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_INTRO_05"); //Nein, meine Familie starb bei einem Hausbrand in der Kälte der Nacht. Ich habe als Einziger überlebt.
};
	
instance DIA_GM_AMBIENT_NEMS_2 (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_NEMS_2_condition;
	information	= DIA_GM_AMBIENT_NEMS_2_info;
	description	= "Kannst du mir das Nehmen von Tiertrophäen zeigen?";
};

FUNC int DIA_GM_AMBIENT_NEMS_2_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_5)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_NEMS_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_NEMS_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_2_00"); //Kannst du mir das Nehmen von Tiertrophäen zeigen?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_01"); //Ist eine gefühlte Ewigkeit her, aber mal schauen.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_02"); //Ich könnte dir zeigen, wie man Felle nimmt.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_03"); //Besonders gut war ich da noch nie drin.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_04"); //Das was ich gut kann, ist, Minecrawler verwerten. Da kann ich dir zeigen, wie man die Schuppen so abnimmt, das sie nicht beschädigt werden.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_05"); //Die Zangen lassen sich auch noch abnehmen, wobei der Nutzen von diesen sich für mich nie ergab und auch nie viele Münzen gebracht hat.
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_2_06"); //Und bei den Schuppen ist das anders?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_07"); //Aber ja doch. die sind sehr widerstandsfähig. Damit lassen sich super Rüstungen herstellen.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_2_08"); //Das Wissen darum ist jedoch eher rar gesät.
};
	
instance DIA_GM_AMBIENT_NEMS_3 (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_NEMS_3_condition;
	information	= DIA_GM_AMBIENT_NEMS_3_info;
	description	= "Könntest du mir dieses Wissen vermitteln?";
};

FUNC int DIA_GM_AMBIENT_NEMS_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_NEMS_2)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_NEMS_3_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_3_00"); //Und du könntest mir dieses Wissen vermitteln?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_3_01"); //Aber nicht doch. Ich habe die Crawlerplatten immer für gutes Geld verkauft.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_3_02"); //Ich bin kein Produzierer. Ich bin eher ein Sammler, wenn du verstehst, was ich meine.
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_3_03"); //Wer kennt sich denn damit aus?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_3_04"); //Also, da wo ich herkomme, weiß ich es, aber hier auf Ahssûn ist mir zumindestens niemand bekannt.
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_3_05"); //Ich würde es bei den Jägern versuchen.
	Info(TOPIC_Teacher, "Nems kann mir beibringen, wie ich Crawlerplatten und Zangen nehme.");
	Info(INFO_ARMOR, "Nems erzählte mir von einer Technik, um die Crawlerplatten zu einer Rüstung zu verbinden. Diese soll sehr widerstandsfähig sein.");
};
	
instance DIA_GM_AMBIENT_NEMS_LOCK (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_NEMS_LOCK_condition;
	information	= DIA_GM_AMBIENT_NEMS_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_NEMS_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_NEMS_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_condition;
	information	= DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_info;
	description	= "Was macht ihr jetzt, da das Triumvirat weg ist?";
};

FUNC int DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_00"); //Was macht ihr jetzt, da das Triumvirat weg ist?
	AI_Output (self, other, "DIA_GM_AMBIENT_NEMS_4_WHAT_TRIV_01"); //(fröhlich) Hah, ich liebe den Klang dieser Worte. Jetzt können wir endlich reich werden.
};
	
instance DIA_GM_AMBIENT_UMAR_UMAR_INTRO (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_UMAR_UMAR_INTRO_condition;
	information	= DIA_GM_AMBIENT_UMAR_UMAR_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_UMAR_UMAR_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_UMAR_UMAR_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_00"); //Hey, was rennst du hier so rum?
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_01"); //Ich...
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_02"); //Du bist neu. Hol dir eine Spitzhacke bei Rodg und dann ran an den Klotz.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_03"); //Und vergiss nicht am Ende des Tages die Steuern bei Rodg zu zahlen. Sonst verlierst du mehr, als nur ein paar Goldbrocken.
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_04"); //Aber...
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_05"); //Los beeil dich, sonst hast du am Ende des Tages nicht genug für's Bier!
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_INTRO_06"); //(ruft) Für Albrecht!
	TIMEVAR_Lockvogel = Wld_GetDay();
};
	
instance DIA_GM_AMBIENT_UMAR_1 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 8;
	condition	= DIA_GM_AMBIENT_UMAR_1_condition;
	information	= DIA_GM_AMBIENT_UMAR_1_info;
	description	= "Was weißt du über das Triumvirat?";
};

FUNC int DIA_GM_AMBIENT_UMAR_1_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_UMAR_INTRO)
	&& AMBVAR_Triumvirat >= TRUE
	&& !SuccessQ(TOPIC_Riot)
	&& !SuccessQ(TOPIC_Triumvirat)
	&& MISVAR_Riot_pro_Buddler == FALSE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_1_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_1_00"); //Was weißt du über das Triumvirat?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_1_01"); //Ich kenne es nur vom Hören-Sagen.
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_1_02"); //Was sagt man denn so?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_1_03"); //Es besteht aus ehemaligen Schürfern, die sich ihren Respekt durch Stärke gewonnen haben.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_1_04"); //Jeder von ihnen war mal ein Buddler wie diese hier. Doch mit der Zeit, hatten sie keine Lust mehr für jeden einzelnen Brocken Gold zu schuften.
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_1_05"); //Weißt du, wer dazugehört?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_1_06"); //Nein, und es interessiert mich auch nicht wirklich. Solange die Steuern gezahlt werden und es hier keine Probleme gibt, kann es mir auch egal bleiben.
	Info("Triumvirat", "Das Triumvirat besteht aus ehemaligen Schürfern, die keine Lust mehr hatten für jeden Klumpen selbst zu schürfen.");
};
	
instance DIA_GM_AMBIENT_UMAR_2 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 13;
	condition	= DIA_GM_AMBIENT_UMAR_2_condition;
	information	= DIA_GM_AMBIENT_UMAR_2_info;
	description	= "Wusstest du, dass deine Rekruten geschmiert werden?";
};

FUNC int DIA_GM_AMBIENT_UMAR_2_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_5) || Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_4_KUNISLAV_5))
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_UMAR_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_2_00"); //Wusstest du, dass deine Rekruten geschmiert werden?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_2_01"); //Was? Wie kannst du soetwas behaupten? Hast du irgendwelche Beweise?
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_2_02"); //Nein...
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_2_03"); //Dann lass diese dämlichen Beschuldigungen, sonst werfe ich dich in die Arena!
};
	
instance DIA_GM_AMBIENT_UMAR_3 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_UMAR_3_condition;
	information	= DIA_GM_AMBIENT_UMAR_3_info;
	description	= "Furt wurde von den Eintreibern verprügelt.";
};

FUNC int DIA_GM_AMBIENT_UMAR_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_4)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_UMAR_1)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_3_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_3_00"); //Furt wurde von den Eintreibern verprügelt.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_3_01"); //Es ist bei mir keine Beschwerde eingegangen und meine Rekruten haben auch nichts gemeldet.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_3_02"); //Wo liegt dann das Problem?
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_3_03"); //Anscheinend gibt es keins...
};
	
instance DIA_GM_AMBIENT_UMAR_5 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 13;
	condition	= DIA_GM_AMBIENT_UMAR_5_condition;
	information	= DIA_GM_AMBIENT_UMAR_5_info;
	description	= "Bei wem könnte ich das Nehmen von Crawlertrophäen erlernen?";
};

FUNC int DIA_GM_AMBIENT_UMAR_5_condition()
{
	if RunningQ(TOPIC_Lockvogel) 
	|| SuccessQ(TOPIC_Lockvogel)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_5_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_5_00"); //Bei wem könnte ich das Nehmen von Crawlertrophäen erlernen?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_5_01"); //Frag mal den Nems. Der sollte das noch aus seiner Zeit als Jäger wissen.
	Info(TOPIC_Teacher, "Nems, ein Schürfer in der Goldmine, kann mir das Nehmen von Crawlertrophäen zeigen. Nems arbeitet in der großen Höhle vor der Küche von Zara.");
	
};
	
instance DIA_GM_AMBIENT_UMAR_6 (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_UMAR_6_condition;
	information	= DIA_GM_AMBIENT_UMAR_6_info;
	description	= "Wusstest du, dass die Eintreiber eure Buddler doppelt abkassieren?";
};

FUNC int DIA_GM_AMBIENT_UMAR_6_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_3)
	|| Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_3)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_6_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_6_00"); //Wusstest du, dass die Eintreiber eure Buddler doppelt abkassieren?
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_6_01"); //Nachdem sie ihre Steuerabgaben gezahlt haben, werden sie von den Eintreibern zur Kasse gebeten.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_6_02"); //Mir ist soetwas nicht bekannt. Meine Rekruten haben mir das nicht gemeldet.
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_6_03"); //Also tut ihr nichts dagegen?
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_6_04"); //Ich sehe nicht das Problem bei dieser Sache, wenn jemand ein Problem damit hätte, dann würde er es den Rekruten sagen und wir würden uns darum kümmern.
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_MORTY_3)){
		AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_6_05"); //Ich habe ein Problem damit, denn mindestens Morty wird täglich um Schutzgeld erpresst und das, obwohl er nicht mehr als Buddler arbeiten kann.
	};
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_3)){
		AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_6_06"); //Furt wird von den Eintreibern ausgenommen und sie haben ihm bei einem Streit noch nicht einmal geholfen. Was sie ja eigentlich versprechen zu tun.
	};
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_6_07"); //Das tut mir ja leid für die armen Teufel, aber ohne triftigen Grund kann ich nichts unternehmen.
};
	
instance DIA_GM_AMBIENT_UMAR_UMAR_STRAFE (C_INFO)
{
	npc			= loa_rek_6926_Umar;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_condition;
	information	= DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_condition()
{
	if (MISVAR_Dotter_realisedCrime == TRUE
	|| MISVAR_Honer_realisedCrime == TRUE
	|| MISVAR_Rodg_realisedCrime == TRUE)
	&& AMBVAR_CrimeCounter >= 1
	&& isTalking()
	&& TIMEVAR_Umar_Strafe < Wld_GetDay()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_info()
{
	if (MISVAR_Dotter_realisedCrime == TRUE){
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_00"); //Dotter hat mir von deiner hinterlistigen Aktion erzählt.
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_01"); //Dafür musst du 500 Roperi oder 100 Goldbrocken Strafe zahlen.
	}else if (MISVAR_Honer_realisedCrime == TRUE){
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_02"); //Honer hat mir von deiner hinterlistigen Aktion erzählt.
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_03"); //Dafür musst du 500 Roperi oder 100 Goldbrocken Strafe zahlen.
	}else if (MISVAR_Rodg_realisedCrime == TRUE){
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_04"); //Rodg hat mir von deiner hinterlistigen Aktion erzählt.
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_05"); //Dafür musst du 500 Roperi oder 100 Goldbrocken Strafe zahlen.
	};
	if (HGold(500)||HItem(ItMi_GoldNugget_Addon, 100)){
		Info_ClearChoices (DIA_GM_AMBIENT_UMAR_UMAR_STRAFE);
		if HGold(500){
			Info_AddChoice (DIA_GM_AMBIENT_UMAR_UMAR_STRAFE, "Ich zahle die 500 Roperi.", DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_500);
		};
		if HItem(ItMi_GoldNugget_Addon, 100){
			Info_AddChoice (DIA_GM_AMBIENT_UMAR_UMAR_STRAFE, "Ich zahle die 100 Goldbrocken.", DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_100);
		};
	}else{
		AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_06"); //Ich habe leider nicht genug dabei.
		AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_07"); //Dann komm erst wieder, wenn du genug hast!
		TIMEVAR_Umar_Strafe = Wld_GetDay();
		AMBVAR_GM_LOCK = TRUE;
	};
};
	
FUNC void DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_500()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_500_00"); //Ich zahle die 500 Roperi.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_500_01"); //Gut, damit wäre die Schuld beglichen. Mach sowas nie wieder!
	Pay(500);
	AMBVAR_CrimeCounter -= 1;
	if (MISVAR_Dotter_realisedCrime == TRUE){
		MISVAR_Dotter_realisedCrime = FALSE;
		MISVAR_Dotter_Paid = TRUE;
	}else if (MISVAR_Honer_realisedCrime == TRUE){
		MISVAR_Honer_realisedCrime = FALSE;
		MISVAR_Honer_Paid = TRUE;
	}else if (MISVAR_Rodg_realisedCrime == TRUE){
		MISVAR_Rodg_realisedCrime = FALSE;
		MISVAR_Rodg_Paid = TRUE;
	};
	if (AMBVAR_CrimeCounter == 0) {
		AMBVAR_GM_LOCK = FALSE;	
	};
	Info_ClearChoices (DIA_GM_AMBIENT_UMAR_UMAR_STRAFE);
	AI_StopProcessInfos (self);
};
	
FUNC void DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_100()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_100_00"); //Ich zahle die 100 Goldbrocken.
	AI_Output (self, other, "DIA_GM_AMBIENT_UMAR_UMAR_STRAFE_100_01"); //Gut, damit wäre die Schuld beglichen. Mach sowas nie wieder!
	Take(ItMi_GoldNugget_Addon, 100);
	AMBVAR_CrimeCounter -= 1;
	if (MISVAR_Dotter_realisedCrime == TRUE){
		MISVAR_Dotter_realisedCrime = FALSE;
		MISVAR_Dotter_Paid = TRUE;
	}else if (MISVAR_Honer_realisedCrime == TRUE){
		MISVAR_Honer_realisedCrime = FALSE;
		MISVAR_Honer_Paid = TRUE;
	}else if (MISVAR_Rodg_realisedCrime == TRUE){
		MISVAR_Rodg_realisedCrime = FALSE;
		MISVAR_Rodg_Paid = TRUE;
	};
	if (AMBVAR_CrimeCounter == 0) {
		AMBVAR_GM_LOCK = FALSE;	
	};
	Info_ClearChoices (DIA_GM_AMBIENT_UMAR_UMAR_STRAFE);
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_WADUR_INTRO (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_WADUR_INTRO_condition;
	information	= DIA_GM_AMBIENT_WADUR_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_WADUR_INTRO_condition()
{
	if isTalking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_WADUR_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_WADUR_INTRO_00"); //Was ist? Warum schaust du mich so an, ich habe die Taschen nicht voller Roperi.
	AI_Output (other, self, "DIA_GM_AMBIENT_WADUR_INTRO_01"); //Nicht? Du siehst aber aus wie ein Goblin!
	AI_Output (self, other, "DIA_GM_AMBIENT_WADUR_INTRO_02"); //Nein, die sind nur durch Brot ausgebeult, klar?! Es gibt nichts zu klauen.
	AI_Output (other, self, "DIA_GM_AMBIENT_WADUR_INTRO_03"); //Wenn du das sagst...
};
	
instance DIA_GM_AMBIENT_WADUR_2 (C_INFO)
{
	npc			= loa_strf_30602_wadur;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_WADUR_2_condition;
	information	= DIA_GM_AMBIENT_WADUR_2_info;
	description	= "Warum bist du so nervös?";
};

FUNC int DIA_GM_AMBIENT_WADUR_2_condition()
{
	if (Npc_KnowsInfo (hero, DIA_GM_AMBIENT_WADUR_INTRO))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_WADUR_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_WADUR_2_00"); //Warum bist du so nervös?
	AI_Output (self, other, "DIA_GM_AMBIENT_WADUR_2_01"); //Ich bin gar nicht nervös. Mir ist nur etwas kalt, da zittere ich nun mal.
	Info_ClearChoices (DIA_GM_AMBIENT_WADUR_2);
	Info_AddChoice (DIA_GM_AMBIENT_WADUR_2, "Warum gehst du dann nicht in die Mine und wärmst dich auf?", DIA_GM_AMBIENT_WADUR_2_1);
};
	
FUNC void DIA_GM_AMBIENT_WADUR_2_1()
{
	Bekannt_DIA_GM_AMBIENT_WADUR_2_1 = TRUE;
	
	AI_Output (other, self, "DIA_GM_AMBIENT_WADUR_2_1_00"); //Warum gehst du dann nicht in die Mine und wärmst dich auf?
	AI_Output (self, other, "DIA_GM_AMBIENT_WADUR_2_1_01"); //Weil ich zum Hafen muss. Ich habe da etwas zu erledigen, aber alleine ist mir der Weg zu gefährlich.
	AI_Output (self, other, "DIA_GM_AMBIENT_WADUR_2_1_02"); //Überall sind Banditen... Böse Monster...
	Info_ClearChoices (DIA_GM_AMBIENT_WADUR_2);
};
	
instance DIA_GM_AMBIENT_ZARA_INTRO (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_ZARA_INTRO_condition;
	information	= DIA_GM_AMBIENT_ZARA_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_ZARA_INTRO_condition()
{
	if isTalking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ZARA_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_INTRO_00"); //Du bist die Köchin hier?
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_INTRO_01"); //Ja, ich bin Zara.
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_INTRO_02"); //Zu mehr als einer Köchin reicht es nicht, aber das ist nicht schlimm.
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_INTRO_03"); //Ich liebe es, wenn die Männer zu mir kommen und sich nach meinen Eintöpfen sehnen.
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_INTRO_04"); //Machst du auch noch was anderes?
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_INTRO_05"); //Ich könnte 'ne leckere Fischsuppe machen, aber es wird hier kein Fisch geliefert von den Rekruten.
};
	
instance DIA_GM_AMBIENT_ZARA_1 (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ZARA_1_condition;
	information	= DIA_GM_AMBIENT_ZARA_1_info;
	description	= "Kann ich was zu essen haben?";
};

FUNC int DIA_GM_AMBIENT_ZARA_1_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_ZARA_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ZARA_1_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_1_00"); //Kann ich was zu essen haben?
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_1_01"); //Aber sicher, lass es dir schmecken.
	CreateAndGive(ItFo_Stew, 1);
};
	
instance DIA_GM_AMBIENT_ZARA_2 (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ZARA_2_condition;
	information	= DIA_GM_AMBIENT_ZARA_2_info;
	description	= "Du hast keinen Ärger mit dem Triumvirat?";
};

FUNC int DIA_GM_AMBIENT_ZARA_2_condition()
{
	if AMBVAR_Triumvirat >= TRUE
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ZARA_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_2_00"); //Du hast keinen Ärger mit dem Triumvirat?
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_2_01"); //Aber nein, wieso sollte ich? Ich bin doch kein Buddler.
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_2_02"); //Na ja, ich dachte nur...
};
	
instance DIA_GM_AMBIENT_ZARA_LOCK (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_ZARA_LOCK_condition;
	information	= DIA_GM_AMBIENT_ZARA_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_ZARA_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ZARA_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV (C_INFO)
{
	npc			= loa_none_6406_Zara;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_condition;
	information	= DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_info;
	description	= "Das Triumvirat ist Geschichte. Was machst du jetzt?";
};

FUNC int DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_00"); //Das Triumvirat ist Geschichte. Was machst du jetzt?
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_01"); //Das ist schön zu hören. Jetzt muss ich mir wenigstens nicht mehr die Klagen der Buddler über diese Schufte anhören.
	AI_Output (self, other, "DIA_GM_AMBIENT_ZARA_3_WHAT_TRIV_02"); //Endlich wird's wieder ruhiger. Leider aber auch langweiliger...
};
	
instance DIA_GM_AMBIENT_DOTTER_INTRO (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_DOTTER_INTRO_condition;
	information	= DIA_GM_AMBIENT_DOTTER_INTRO_info;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_DOTTER_INTRO_condition()
{
	if Npc_GetDistToNpc(self, hero)<= 400
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_INTRO_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_INTRO_00"); //Hey, du da!
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_INTRO_01"); //Ja? Sprichst du mit mir?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_INTRO_02"); //Ja, genau du. Du siehst so aus, als wärst du kein gewöhnlicher Schürfer.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_INTRO_03"); //Könnte man so sagen. Wer bist du denn überhaupt?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_INTRO_04"); //Ich bin Dotter, der beste Schürfer hier. Und wer bist du? Nur um die Höflichkeit zu wahren.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_INTRO_05"); //(seufzt) Ein unglücklicher Schiffsbrüchiger...
};
	
instance DIA_GM_AMBIENT_DOTTER_2 (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 8;
	condition	= DIA_GM_AMBIENT_DOTTER_2_condition;
	information	= DIA_GM_AMBIENT_DOTTER_2_info;
	description	= "Der beste Schürfer?";
};

FUNC int DIA_GM_AMBIENT_DOTTER_2_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_2_00"); //Du willst der beste Schürfer sein?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_2_01"); //Ich will es nicht nur, ich bin es!
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_2_02"); //Der beste dieser Goldmine! Wenn du mir nicht glaubst, dann frag ruhig rum.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_2_03"); //An Selbstbewusstsein scheint es dir ja nicht zu mangeln.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_2_04"); //Ach, wieso denn auch? Ich mache hier den größten Profit mit dem geschürften Gold.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_2_05"); //Nicht mal die immensen Abgaben an das Triumvirat können mich stoppen.
	AMBVAR_Triumvirat = TRUE;
};
	
instance DIA_GM_AMBIENT_DOTTER_3 (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 30;
	condition	= DIA_GM_AMBIENT_DOTTER_3_condition;
	information	= DIA_GM_AMBIENT_DOTTER_3_info;
	description	= "Du zahlst auch an das Triumvirat?";
};

FUNC int DIA_GM_AMBIENT_DOTTER_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_2)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_3_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_3_00"); //Du zahlst auch an das Triumvirat?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_01"); //Ja, natürlich. Jeder hier muss es, früher oder später. Hängt nur davon ab, wie viel Schläge zu einstecken kannst.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_02"); //Oder wie im Falle von Mors, gehst du drauf, wenn du dich partout weigerst.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_03"); //Aber für mich ist das gar kein Problem. Ich geb denen gerne einen Goldbrocken mehr, wenn ich mir dadurch ihre Loyalität sichern kann.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_3_04"); //Wieso brauchst du die überhaupt?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_05"); //Wenn man soviel Gold macht wie ich, dann lockt das schon den einen oder anderen neidischen Vollidioten an, der mir eine auf die Fresse hauen und mit meinem Gold verschwinden will.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_06"); //Erst kürzlich dachte dieser vertrottelte Furt doch tatsächlich, dass er mich beklauen kann, während ich den Fels bearbeite.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_07"); //So unverschämt muss man erstmal sein.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_3_08"); //Und das Triumvirat hat dir geholfen?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_09"); //Natürlich, die Eintreiber. Der Typ bezahlt zwar auch fleißig, aber nicht so viel wie ich.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_3_10"); //Es ist immer gut, starke Freunde zu haben.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_3_11"); //Verstehe...
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_3_12"); //Andere Leute haben mit den Eintreibern eher negative Erfahrungen gemacht.
	Info("Triumvirat", "Für Dotter ist das Triumvirat eine wahre Hilfe, da er ihnen mehr zahlt, als die üblichen Schürfer. Das Triumvirat ist scheinbar sehr bestechlich.");
};
	
instance DIA_GM_AMBIENT_DOTTER_4 (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_DOTTER_4_condition;
	information	= DIA_GM_AMBIENT_DOTTER_4_info;
	description	= "Wie kommt es, dass du der Beste bist?";
};

FUNC int DIA_GM_AMBIENT_DOTTER_4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_2)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_4_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_4_00"); //Wie kommt es, dass du der Beste bist?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_4_01"); //Know-How. Ein khemarisches Wort für Fachwissen.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_4_02"); //Bin immer noch nicht schlauer.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_4_03"); //Na, ich weiß einfach, wie man den Fels richtig bearbeitet, ohne dass die rausgeschlagenen Goldnuggets zersplittern und sich in wertlosen Goldstaub verwandeln.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_4_04"); //Und wie machst du das?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_4_05"); //Das wüsstest du gerne, was?!
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_4_06"); //Natürlich, kannst du mir das zeigen?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_4_07"); //Jungchen, wenn ich das jedem zeige, dann erhöhen die gierigen Stadttölpel bald die Steuern!
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_4_08"); //Nee, nicht mit mir!
};
	
instance DIA_GM_AMBIENT_DOTTER_5 (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_DOTTER_5_condition;
	information	= DIA_GM_AMBIENT_DOTTER_5_info;
	description	= "Ich würde aber gerne das Schürfen erlernen.";
};

FUNC int DIA_GM_AMBIENT_DOTTER_5_condition()
{
	if DIA_GM_AMBIENT_DOTTER_4
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_5_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_5_00"); //Ich würde aber gerne das Schürfen erlernen.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_5_01"); //Vielleicht kann ich irgendetwas für dich machen, wozu du selbst nicht in der Lage bist?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_02"); //Hmm... Da hast du einen wunden Punkt getroffen. Heutzutage kann man kaum jemandem trauen.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_5_03"); //Mir kannst du vertrauen.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_04"); //Na das werden wir ja sehen...
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_05"); //Die Rekruten versorgen uns ja ganz gut mit Bier und Essen, aber das ist alles so gewöhnlich und schmeckt mir einfach nicht mehr so wirklich.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_06"); //Da bräuchte ich schon was Neues und Schmackhaftes. Die Roperi müsstest du aber auch vorstrecken.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_07"); //Ich kann es nicht riskieren, dass mich noch so jemand versucht, auszunehmen.
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_5_08"); //Aber du sagst doch selbst, dass du hier das meiste Gold machst. Wäre das jetzt so schlimm.
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_5_09"); //Das heißt nicht, dass ich es zu verschenken brauche. So blöd bin ich dann auch wieder nicht.
	Info("Schürfen", "Ich kann bei Dotter das effiziente Goldschürfen erlernen. Er möchte jedoch, dass ich ihm vorher bei ein paar Sachen helfe.");
};
	
instance DIA_GM_AMBIENT_DOTTER_LOCK (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_DOTTER_LOCK_condition;
	information	= DIA_GM_AMBIENT_DOTTER_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_DOTTER_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_DOTTER_6 (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_DOTTER_6_condition;
	information	= DIA_GM_AMBIENT_DOTTER_6_info;
	description	= "Was machst du jetzt, da das Triumvirat nicht mehr existiert?";
};

FUNC int DIA_GM_AMBIENT_DOTTER_6_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_DOTTER_6_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_DOTTER_6_00"); //Was machst du jetzt, da das Triumvirat nicht mehr existiert?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_6_01"); //Verdammt, musst du das jetzt erwähnen?!
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_6_02"); //Ist es nicht schlimm genug, dass ich niemanden mehr habe, der mich beschützt?
	AI_Output (self, other, "DIA_GM_AMBIENT_DOTTER_6_03"); //Ach, weißt du was... Lass mich einfach in Ruhe!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_FURT_INTRO (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_FURT_INTRO_condition;
	information	= DIA_GM_AMBIENT_FURT_INTRO_info;
	description	= "Wer bist du?";
};

FUNC int DIA_GM_AMBIENT_FURT_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_FURT_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_INTRO_00"); //Wer bist du?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_INTRO_01"); //Ich bin Furt, ein armer Schlucker. Ich krieg das Schürfen einfach nicht gebacken.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_INTRO_02"); //Schon seit Monaten haue ich hier auf die Felsen, doch bisher hab ich fast noch nichts gelernt.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_INTRO_03"); //Lediglich die besonders harten Schläge bringen etwas Ertrag, aber dann ist man nach fünf Schwüngen total ausgepowert.
};
	
instance DIA_GM_AMBIENT_FURT_2 (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 11;
	condition	= DIA_GM_AMBIENT_FURT_2_condition;
	information	= DIA_GM_AMBIENT_FURT_2_info;
	description	= "Wieso fragst du die anderen Schürfer nicht nach ihren Geheimnissen?";
};

FUNC int DIA_GM_AMBIENT_FURT_2_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_FURT_2_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_2_00"); //Wieso fragst du die anderen Schürfer nicht nach ihren Geheimnissen?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_2_01"); //Hab ich versucht, aber keiner will mir helfen.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_2_02"); //Jeder ist nur auf seinen eigenen Profit konzentriert, damit ihm nach Abzug des Schutzgeldes vom Triumvirat noch genug für's Bier übrigbleibt.
	AMBVAR_Triumvirat = TRUE;
};
	
instance DIA_GM_AMBIENT_FURT_3 (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 13;
	condition	= DIA_GM_AMBIENT_FURT_3_condition;
	information	= DIA_GM_AMBIENT_FURT_3_info;
	description	= "Hast du Probleme mit dem Triumvirat?";
};

FUNC int DIA_GM_AMBIENT_FURT_3_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_INTRO)
	
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_FURT_3_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_3_00"); //Hast du Probleme mit dem Triumvirat?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_3_01"); //Probleme? Natürlich, die nehmen uns Buddler komplett aus und das obwohl wir bereits Steuerabgaben zahlen.
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_3_02"); //Hat denn keiner von euch probiert sich dagegen zu wehren?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_3_03"); //Doch, Mors. Der ist hartnäckig geblieben. Und was hat es ihm genutzt?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_3_04"); //Jetzt kann er sich in Beliars Reich vernügen. Zusammen mit den anderen Toten.
	Info("Triumvirat", "Mors hat versucht, sich gegen das Triumvirat aufzulehnen und ist daraufhin gestorben.");
};
	
instance DIA_GM_AMBIENT_FURT_4 (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_FURT_4_condition;
	information	= DIA_GM_AMBIENT_FURT_4_info;
	description	= "Du hast versucht Dotter zu bestehlen?";
};

FUNC int DIA_GM_AMBIENT_FURT_4_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_DOTTER_3)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_FURT_4_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_4_00"); //Du hast versucht, Dotter zu bestehlen? Warum? Hier gibt es doch genug Gold.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_01"); //Ja, hat leider nicht geklappt. Der Typ ist das Letzte!
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_4_02"); //Warum?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_03"); //Der hat die Taschen voll und ist der wohl beste Buddler hier, aber teilt nicht mal einen Roperi, dieser elendige Geizkragen!
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_4_04"); //Und das ist Grund genug ihn zu bestehlen?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_05"); //Ich habe ihn gebeten, mir ein paar Tricks zu zeigen, damit ich besser werde, doch das hat den gar nicht gekümmert.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_06"); //Daraufhin hab ich von Nems erfahren, dass er ein Buch über's Schürfen hat und nur deshalb so viel aus dem Fels rausholt.
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_4_07"); //Aha...
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_08"); //Ja - hab ich mir auch gedacht und wollte es mir sofort krallen, doch der Typ ist wachsam und ließ mich von den Eintreibern verprügeln.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_09"); //Diese Bastarde. Ich habe ihnen sogar Schutzgeld bezahlt.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_10"); //Na ja, immerhin muss ich ihnen jetzt nicht mehr die volle Summe zahlen.
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_4_11"); //Wieso nicht?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_4_12"); //Diese Kriminellen haben mein Gold genommen und mich in Stich gelassen, als es drauf ankam. Jetzt zahle ich nur noch die Schürfgebühr.
};
	
instance DIA_GM_AMBIENT_FURT_5 (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_FURT_5_condition;
	information	= DIA_GM_AMBIENT_FURT_5_info;
	description	= "Schürfgebühr?";
};

FUNC int DIA_GM_AMBIENT_FURT_5_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_4)
	&& Npc_KnowsInfo (hero, DIA_GM_AMBIENT_FURT_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_FURT_5_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT_5_00"); //Schürfgebühr?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_5_01"); //Ja, der Preis, um hier in Ruhe schürfen zu können.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT_5_02"); //Auf die Hilfe der Eintreiber bei Streitigkeiten kann ich nicht mehr hoffen.
};
	
instance DIA_GM_AMBIENT_FURT__WHAT_TRIV (C_INFO)
{
	npc			= loa_none_6411_Furt;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_FURT__WHAT_TRIV_condition;
	information	= DIA_GM_AMBIENT_FURT__WHAT_TRIV_info;
	description	= "Das Triumvirat ist Geschichte. Was machst du jetzt?";
};

FUNC int DIA_GM_AMBIENT_FURT__WHAT_TRIV_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_K1_RIOT_20_MORTY_SUCCESS)
	|| Npc_KnowsInfo (hero, DIA_GM_K1_TRIUMVIRAT_9_TRIV_SUCCESS)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_FURT__WHAT_TRIV_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_FURT__WHAT_TRIV_00"); //Das Triumvirat ist Geschichte. Was machst du jetzt?
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT__WHAT_TRIV_01"); //Darauf habe ich schon lange gewartet. Vielleicht räche ich mich ja jetzt an Dotter.
	AI_Output (self, other, "DIA_GM_AMBIENT_FURT__WHAT_TRIV_02"); //Aber mal schauen, was die Zukunft für uns bringt.
};
	
instance DIA_GM_AMBIENT_RODG_RODG_INTRO (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_RODG_RODG_INTRO_condition;
	information	= DIA_GM_AMBIENT_RODG_RODG_INTRO_info;
	description	= "Hey, du scheinst hier wohl der Schmied zu sein?!";
};

FUNC int DIA_GM_AMBIENT_RODG_RODG_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_RODG_RODG_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_RODG_RODG_INTRO_00"); //Hey, du scheinst hier wohl der Schmied zu sein?!
	AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_INTRO_01"); //Woran hast du das wohl erkannt? 
	AI_Output (other, self, "DIA_GM_AMBIENT_RODG_RODG_INTRO_02"); //Es steht auf deiner Stirn geschrieben.
	AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_INTRO_03"); //Witzbold. Ich bin Rodg. Und wie du schon herausgestellt hast der Goldschmied hier.
	AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_INTRO_04"); //Momentan muss ich aber noch ein paar Waffen schmieden, auch wenn ich es hasse.
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_RODG_RODG_STEUER (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_RODG_RODG_STEUER_condition;
	information	= DIA_GM_AMBIENT_RODG_RODG_STEUER_info;
	permanent	= TRUE;
	description	= "Ich möchte die Steuerabgaben bezahlen.";
};

FUNC int DIA_GM_AMBIENT_RODG_RODG_STEUER_condition()
{
	if MISVAR_Steuer_Due > 0
	|| (MISVAR_Gold_earned < Npc_HasItems(hero, ItMi_GoldNugget_Addon))
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_RODG_RODG_STEUER_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_RODG_RODG_STEUER_00"); //Ich möchte die Steuerabgaben bezahlen.
	AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_01"); //Dann lass mal sehen, wie viel Gold du hast.
	if (Npc_HasItems(hero, ItMi_Goldnugget_Addon) > 0){
		if MISVAR_Gold_earned < Npc_HasItems(hero, ItMi_GoldNugget_Addon){
			MISVAR_Steuer_Due += ((Npc_HasItems(hero, ItMi_GoldNugget_Addon) - MISVAR_Gold_earned)/5);
			MISVAR_Gold_earned = Npc_HasItems(hero, ItMi_GoldNugget_Addon);				
			if MISVAR_Steuer_Due == 0{
				MISVAR_Steuer_Due = 1;	
			};
			PrintScreen (ConcatStrings (ConcatStrings ("Steuerschulden: ", IntToString(MISVAR_Steuer_Due)), " Goldbrocken"), -1, -1, FONT_Screen, 2);	
		};
		if MISVAR_Steuer_Due > 0 {
			AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_02"); //Okay, ich nehme mir dann das Fünftel Steuerabgaben.
		};
		if HItem(ItMi_Goldnugget_Addon, MISVAR_Steuer_Due){
			TakeAndDestroy(ItMi_Goldnugget_Addon, MISVAR_Steuer_Due);
			MISVAR_Steuer_Due = 0;
			MISVAR_Gold_earned = Npc_HasItems(hero, ItMi_GoldNugget_Addon);
		}else{
			MISVAR_Steuer_Due -= Npc_HasItems(other, ItMi_Goldnugget_Addon);
			MISVAR_Gold_earned -= Npc_HasItems(other, ItMi_GoldNugget_Addon);
			TakeAndDestroy(ItMi_Goldnugget_Addon, Npc_HasItems(other, ItMi_Goldnugget_Addon));
			AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_03"); //Damit bist du aber noch nicht aus dem Schneider. Du hast mehr geschürft als diese paar Goldbrocken.
			AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_04"); //Komm wieder, wenn du deine Steuer bezahlen kannst.
		};
	}else{
		AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_05"); //Was? Heute gar nicht geschürft? Verarsch mich doch bitte nicht. Und wovon willst du die Steuern bezahlen?
		AI_Output (self, other, "DIA_GM_AMBIENT_RODG_RODG_STEUER_06"); //Hau ab, du Nichtsnutz und geh schürfen!
	};
	
};
	
instance DIA_GM_AMBIENT_RODG_LOCK (C_INFO)
{
	npc			= loa_vlk_6404_Rodg;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_RODG_LOCK_condition;
	information	= DIA_GM_AMBIENT_RODG_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_RODG_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_RODG_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_RODG_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO (C_INFO)
{
	npc			= loa_none_6448_Proviantmeister;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_condition;
	information	= DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_info;
	description	= "Wer bist du?";
};

FUNC int DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_condition()
{
	return TRUE;
};

FUNC void DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_00"); //Wer bist du?
	AI_Output (self, other, "DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO_01"); //Ich bin der Proviantmeister. Ich kümmere mich hier um die Versorgung der Rekruten und Arbeiter durch die Stadt.
};
	
instance DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER (C_INFO)
{
	npc			= loa_none_6448_Proviantmeister;
	nr			= 10;
	condition	= DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_condition;
	information	= DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_info;
	permanent	= TRUE;
	trade		= TRUE;
	description	= "Was hast du anzubieten? (Handel)";
};

FUNC int DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_PROVIANTMEISTER_1_PROVIANTMEISTER_INTRO)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_info()
{
	AI_Output (other, self, "DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_00"); //Was hast du anzubieten?
	AI_Output (self, other, "DIA_GM_AMBIENT_PROVIANTMEISTER_2_PROVIANTMEISTER_01"); //Schau dich ruhig um.
	
	B_GiveTradeInv (self);
};
	
instance DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK (C_INFO)
{
	npc			= loa_none_6448_Proviantmeister;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK_condition;
	information	= DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_PROVIANTMEISTER_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_AMBIENT_HONER_LOCK (C_INFO)
{
	npc			= loa_rek_6498_Honer;
	nr			= 1;
	condition	= DIA_GM_AMBIENT_HONER_LOCK_condition;
	information	= DIA_GM_AMBIENT_HONER_LOCK_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_AMBIENT_HONER_LOCK_condition()
{
	if AMBVAR_GM_LOCK == TRUE
	&& Talking()
	{
		return TRUE;
	};
};

FUNC void DIA_GM_AMBIENT_HONER_LOCK_info()
{
	AI_Output (self, other, "DIA_GM_AMBIENT_HONER_LOCK_00"); //Mit Verbrechern will ich nichts zu tun haben. Zahle erst die Strafe bei Umar!
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_WACHEN_MINENWACHE_PAY (C_INFO)
{
	npc			= loa_rek_6499_Minenwache;
	nr			= 10;
	condition	= DIA_GM_WACHEN_MINENWACHE_PAY_condition;
	information	= DIA_GM_WACHEN_MINENWACHE_PAY_info;
	permanent	= TRUE;
	important	= TRUE;
};

FUNC int DIA_GM_WACHEN_MINENWACHE_PAY_condition()
{
	if (MISVAR_Steuer_Due > 0 || (MISVAR_Gold_earned < Npc_HasItems(hero, ItMi_GoldNugget_Addon)))
	&& Npc_GetDistToWP(hero, "GM_B_GUARD_ENTRANCE") <= 500
	{
		return TRUE;
	};
};

FUNC void DIA_GM_WACHEN_MINENWACHE_PAY_info()
{
	AI_Output (self, other, "DIA_GM_WACHEN_MINENWACHE_PAY_00"); //Halt, du willst dich doch nicht mit dem Gold der Stadt Ahssûn aus dem Staub machen, oder?!
	AI_Output (other, self, "DIA_GM_WACHEN_MINENWACHE_PAY_01"); //Ähm... Nein.
	AI_Output (self, other, "DIA_GM_WACHEN_MINENWACHE_PAY_02"); //Du hast deine Steuern für heute noch nicht bezahlt!
	AI_Output (other, self, "DIA_GM_WACHEN_MINENWACHE_PAY_03"); //Aber ich hab doch gar nicht geschürft!
	AI_Output (self, other, "DIA_GM_WACHEN_MINENWACHE_PAY_04"); //(autoritär) Das ist nicht wichtig! Da du Zugang zur Mine hast, bist du auch ein potenzieller Buddler.
	AI_Output (self, other, "DIA_GM_WACHEN_MINENWACHE_PAY_05"); //Solange du Goldbrocken bei dir hast, muss ich davon ausgehen, dass du geschürft hast. Dann musst du auch Steuern zahlen.
	AI_GotoWP(hero, "GM_A_132");
	AI_StopProcessInfos (self);
};
	
instance DIA_GM_LEHRER_NEMS_TEACH_CRAWLER (C_INFO)
{
	npc			= loa_none_6405_Nems;
	nr			= 10;
	condition	= DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_condition;
	information	= DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_info;
	permanent	= TRUE;
	description	= "Zeig mir, wie ich Minecrawler ausnehme.";
};

FUNC int DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_AMBIENT_NEMS_3)
	&& (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE || PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Crawlerplate] == FALSE)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_info()
{
	AI_Output (other, self, "DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_00"); //Zeig mir, wie ich Minecrawler ausnehme.
	AI_Output (self, other, "DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_01"); //Gerne.
	Info_ClearChoices (DIA_GM_LEHRER_NEMS_TEACH_CRAWLER);
	if (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE){
		Info_AddChoice (DIA_GM_LEHRER_NEMS_TEACH_CRAWLER, "Crawlerzangen nehmen (1 LP)", DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_1);
	};
	if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Crawlerplate] == FALSE){
		Info_AddChoice (DIA_GM_LEHRER_NEMS_TEACH_CRAWLER, "Crawlerplatten nehmen (1 LP)", DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_2);
	};
	Info_AddChoice (DIA_GM_LEHRER_NEMS_TEACH_CRAWLER, DIALOG_BACK, DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_BACK);
};
	
FUNC void DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_1()
{
	if (B_TeachAnimalTrophy(self, other,TROPHY_Mandibles,1)){
		AI_Output (self, other, "DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_1_00"); //Ist eigentlich ganz einfach, die Zangen zu nehmen. Du musst nur aufpassen, dass du beim Abtrennen der Zange nicht das Sekret verschüttest, das herausspritzt, sobald du die Sehnen durchtrennst.
	};
};
	
FUNC void DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_2()
{
	if (B_TeachAnimalTrophy(self, other,TROPHY_CrawlerPlate,1)){
		AI_Output (self, other, "DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_2_00"); //Du musst mit einem scharfen Messer tief unter die Schuppe schneiden, bis du sie gelöst hast.
		AI_Output (self, other, "DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_2_01"); //Hier liegt der Trick daran, das Messer überhaupt das erste Mal drunter zu bekommen, denn die Teile sind gut verhärtet.
	};
};
	
FUNC void DIA_GM_LEHRER_NEMS_TEACH_CRAWLER_BACK()
{
	Info_ClearChoices (DIA_GM_LEHRER_NEMS_TEACH_CRAWLER);
};
	
instance DIA_GM_LEHRER_DOTTER_SCHUERFEN (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 16;
	condition	= DIA_GM_LEHRER_DOTTER_SCHUERFEN_condition;
	information	= DIA_GM_LEHRER_DOTTER_SCHUERFEN_info;
	description	= "Zeig mir, wie ich richtig schürfe.";
};

FUNC int DIA_GM_LEHRER_DOTTER_SCHUERFEN_condition()
{
	if SuccessQ(TOPIC_DotterKraut)
	{
		return TRUE;
	};
};

FUNC void DIA_GM_LEHRER_DOTTER_SCHUERFEN_info()
{
	AI_Output (other, self, "DIA_GM_LEHRER_DOTTER_SCHUERFEN_00"); //Zeig mir, wie ich richtig schürfe.
	AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_SCHUERFEN_01"); //Klar, aber wenn ich dir was beibringe, wirst du mehr Gold schürfen können.
	AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_SCHUERFEN_02"); //Da du mir geholfen hast, mache ich dir einen guten Preis.
	AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_SCHUERFEN_03"); //50 Roperi pro Trainingseinheit.
	Info(TOPIC_Teacher, "Bei Dotter kann ich das lernen, wie ich effizienter schürfe.");
};
	
instance DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN (C_INFO)
{
	npc			= loa_none_6410_Dotter;
	nr			= 10;
	condition	= DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_condition;
	information	= DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_info;
	permanent	= TRUE;
	description	= "Bring mir was über's Goldhacken bei! (50 Gold)";
};

FUNC int DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_condition()
{
	if Npc_KnowsInfo (hero, DIA_GM_LEHRER_DOTTER_SCHUERFEN)
	&& AMBVAR_Hack < 1000
	{
		return TRUE;
	};
};

FUNC void DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_info()
{
	AI_Output (other, self, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_00"); //Bring mir was über's Goldhacken bei!
	AMBVAR_Hack = Hlp_Random(5);
	if Hero_HackChance >= 100{
		AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_01"); //Ich kann dir nichts mehr beibringen, du bist schon zu gut.
		AI_StopProcessInfos (self);
		AMBVAR_Hack = 1000;
	}else{
		if HGold(50){
			Pay(50);
			If (HGold(100)){
				Npc_RemoveInvItems(self, ItMi_Gold, Npc_HasItems(self,ItMi_Gold) - 50);	
			};
			if (AMBVAR_Hack == 0){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_02"); //Gut. Gleichmäßiges Hacken bringt dich vorwärts. Nichts überstürzen - aber auch nicht beim Hacken einschlafen.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_03"); //Und schlag nicht immer auf die gleiche Stelle - versuche, um ein schönes Nuggetstück herumzuarbeiten.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_04"); //Befolge das und du bist auf dem Weg, ein wahrer Meister-Buddler zu werden.
			}
			else if(AMBVAR_Hack == 1){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_05"); //Ich verrate dir mal ein Buddlergeheimnis.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_06"); //Ab und zu bietet es sich an, einen Trümmerschlag anzusetzen.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_07"); //Wenn du ein paar Mal gehackt hast und es ist nichts dabei rumgekommen, dann zieh die Spitze der Hacke quer über den Fels.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_08"); //Mit etwas Glück kriegst du so gleich mehrere Brocken.
			}
			else if(AMBVAR_Hack == 2){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_09"); //Kopfarbeit, Junge. Goldhacken ist reine Kopfsache. Versuch nicht, den Fels zu bezwingen - er ist härter als du.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_10"); //Mach dich von allem frei - und versuche, eins zu werden mit dem Gold. Dann ist es ist wie ein Gebet, eine Meditation.
			}
			else if(AMBVAR_Hack == 3){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_11"); //Eine Spitzhacke in die Hand nehmen und auf 'nen Goldklumpen draufschlagen, das kann jeder.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_12"); //Aber dabei zersplittern viele Nuggets. Deshalb sollten nur Leute hacken, die was davon verstehen.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_13"); //Ich kann dir noch mehr erzählen, wenn du etwas Erfahrung mitbringst.
			}
			else if(AMBVAR_Hack == 4){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_14"); //Nun, der Einschlagwinkel ist entscheidend für eine solide Hackerei.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_15"); //Nicht zu flach und nicht zu steil, so kommst du an die Nuggets und deine Spitzhacke hält ewig.
			};
			
			if Hero_HackChance <= 95{
				B_Upgrade_Hero_HackChance(5);
			}else {
				MISVAR_Hack_ToDo = 100 - Hero_HackChance;
				B_Upgrade_Hero_HackChance(MISVAR_Hack_ToDo);
			};
			
			if (Hero_HackChance >= 50 && AMBVAR_Hack < 3){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_16"); //Außerdem kannst du mit deinen momentanen Fähigkeiten von Zeit zu Zeit auch mal einen rohen Edelstein fördern.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_17"); //Dabei musst du besonders vorsichtig sein.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_18"); //Hierbei darfst du auf keinen Fall mit Gewalt zuschlagen, sondern musst dich drumherum hacken.
			}else if (Hero_HackChance >= 50 && AMBVAR_Hack >= 3){
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_19"); //Edelsteine lassen sich mit deiner Erfahrung auch finden.
				AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_20"); //Du solltest dich dabei auf Stellen konzentrieren, die sich farbig vom Gold und dem Gestein abheben.
			};
		}else{
			AI_Output (self, other, "DIA_GM_LEHRER_DOTTER_TEACH_SCHUERFEN_21"); //Erst will ich Münzen sehen!
		};
	};
};
	
