
---One time script when the game is started
---@param q game_obj_research_panel
---@param v_modid string
function create(q, v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule")

	--path to the mod folder
	local modFilepath = Mod.Common.GetModPath("Combat Data Core")

	--load needed types
	local researchIcons = Mod.Types.ResearchIcons
	local researchConditions = Mod.Types.ResearchConditions
	local componentTypes = Mod.Types.ComponentTypes

	local dataCore = Mod.Research.AddResearch({
		Name = "CDC_DataCore",
		Position = 130,
		Condition = researchConditions.Researching,
		RequiredDays = 4,
		RequiredStaff = 0,
		ReseachIcon = researchIcons.Research,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "DATA CORE:#The main AI is working on unlocking the combat data core. When completed it grants additional research options." }
			,{ LanguageFile = "loc_french.ini", Value = "NOYAU DE DONNÉES :#L'IA principale travaille à déverrouiller le noyau de données de combat. Une fois cette opération terminée, elle débloquera des options de recherche supplémentaires." }
			,{ LanguageFile = "loc_german.ini", Value = "DATENKERNE:#Die Haupt-KI arbeitet daran, den Kampfdatenkern freizuschalten. Nach Abschluss der Arbeiten werden zusätzliche Forschungsoptionen freigeschaltet." }
			,{ LanguageFile = "loc_polish.ini", Value = "Rdzeń danych:#Główna sztuczna inteligencja pracuje nad odblokowaniem rdzenia danych bojowych. Po jego ukończeniu udostępnione zostaną dodatkowe opcje badawcze." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NÚCLEO DE DADOS:#A IA principal está trabalhando para desbloquear o núcleo de dados de combate. Quando concluído, isso concederá opções de pesquisa adicionais." }
			,{ LanguageFile = "loc_russian.ini", Value = "OCHOBA ДАННЫХ:#Основной ИИ работает над разблокировкой ядра боевых данных. После завершения этого процесса откроются дополнительные возможности для исследований." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NÚCLEO DE DATOS:#La IA principal está trabajando para desbloquear el núcleo de datos de combate. Una vez completado, otorgará opciones de investigación adicionales." }
			,{ LanguageFile = "loc_chinese.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心。完成后,它将解锁额外的研究选项。" }
			,{ LanguageFile = "chs.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心。完成后,它将解锁额外的研究选项。" }
			,{ LanguageFile = "loc_italian.ini", Value = "CENTRO DATI:#L'IA principale sta lavorando allo sblocco del nucleo dati di combattimento. Una volta completato, garantirà ulteriori opzioni di ricerca." }
			,{ LanguageFile = "japanese.ini", Value = "データコア：#メインAIは戦闘データコアのロック解除に取り組んでいます。ロック解除が完了すると、追加の研究オプションが利用可能になります。" }
		},
		SpritePath = modFilepath.."sprites\\data_core_research.png",
		UnlockedComponents = {}
	})

	local deepDataCore = Mod.Research.AddResearch({
		Name = "CDC_DeepDataCore",
		Position = 131,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 18,
		RequiredStaff = 0,
		ReseachIcon = researchIcons.Research,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "DATA CORE:#The main AI is working on unlocking the next layer of the combat data core. When completed it grants additional research options." }
			,{ LanguageFile = "loc_french.ini", Value = "NOYAU DE DONNÉES :#L'IA principale travaille à débloquer la couche suivante du noyau de données de combat. Une fois cette étape terminée, elle débloquera des options de recherche supplémentaires." }
			,{ LanguageFile = "loc_german.ini", Value = "DATENKERNE:#Die Haupt-KI arbeitet daran, die nächste Ebene des Kampfdatenkerns freizuschalten. Nach Fertigstellung werden zusätzliche Forschungsoptionen freigeschaltet." }
			,{ LanguageFile = "loc_polish.ini", Value = "Rdzeń danych:#Główna sztuczna inteligencja pracuje nad odblokowaniem kolejnej warstwy rdzenia danych bojowych. Po jej ukończeniu udostępni ona dodatkowe możliwości badawcze." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NÚCLEO DE DADOS:#A IA principal está trabalhando para desbloquear a próxima camada do núcleo de dados de combate. Quando concluída, ela concederá opções de pesquisa adicionais." }
			,{ LanguageFile = "loc_russian.ini", Value = "OCHOBA ДАННЫХ:#Основной ИИ работает над разблокировкой следующего уровня ядра боевых данных. После завершения этого процесса откроются дополнительные возможности для исследований." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NÚCLEO DE DATOS:#La IA principal está trabajando para desbloquear la siguiente capa del núcleo de datos de combate. Una vez completada, otorgará opciones de investigación adicionales." }
			,{ LanguageFile = "loc_chinese.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心的下一层。完成后,它将提供额外的研究选项。" }
			,{ LanguageFile = "chs.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心的下一层。完成后,它将提供额外的研究选项。" }
			,{ LanguageFile = "loc_italian.ini", Value = "CENTRO DATI:#L'IA principale sta lavorando per sbloccare il livello successivo del nucleo dati di combattimento. Una volta completato, garantirà ulteriori opzioni di ricerca." }
			,{ LanguageFile = "japanese.ini", Value = "データコア：#メインAIは戦闘データコアの次の層のロック解除に取り組んでいます。ロック解除が完了すると、追加の研究オプションが利用可能になります。" }
		},
		SpritePath = modFilepath.."sprites\\deep_data_core_research.png",
		UnlockedComponents = {}
	})

	local finalDataCore = Mod.Research.AddResearch({
		Name = "CDC_FinalDataCore",
		Position = 142,
		PrerequisiteResearchResNumber = deepDataCore,
		RequiredDays = 22,
		RequiredStaff = 0,
		ReseachIcon = researchIcons.Research,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "DATA CORE:#The main AI is working on unlocking the last layer of the combat data core. When completed it grants additional research options." }
			,{ LanguageFile = "loc_french.ini", Value = "NOYAU DE DONNÉES :#L'IA principale travaille à débloquer la dernière couche du noyau de données de combat. Une fois cette étape terminée, elle débloquera des options de recherche supplémentaires." }
			,{ LanguageFile = "loc_german.ini", Value = "DATENKERNE:#Die Haupt-KI arbeitet daran, die letzte Ebene des Kampfdatenkerns freizuschalten. Nach Abschluss der Freischaltung werden zusätzliche Forschungsoptionen verfügbar." }
			,{ LanguageFile = "loc_polish.ini", Value = "Rdzeń danych:#Główna sztuczna inteligencja pracuje nad odblokowaniem ostatniej warstwy rdzenia danych bojowych. Po jej ukończeniu udostępni ona dodatkowe opcje badawcze." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NÚCLEO DE DADOS:#A IA principal está trabalhando para desbloquear a última camada do núcleo de dados de combate. Quando concluída, ela concederá opções de pesquisa adicionais." }
			,{ LanguageFile = "loc_russian.ini", Value = "OCHOBA ДАННЫХ:#Основной ИИ работает над разблокировкой последнего уровня ядра боевых данных. После завершения этого процесса откроются дополнительные возможности для исследований." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NÚCLEO DE DATOS:#La IA principal está trabajando para desbloquear la última capa del núcleo de datos de combate. Una vez completada, otorgará opciones de investigación adicionales." }
			,{ LanguageFile = "loc_chinese.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心的最后一层。完成后,它将解锁额外的研究选项。" }
			,{ LanguageFile = "chs.ini", Value = "数据核心：#主人工智能正在努力解锁战斗数据核心的最后一层。完成后,它将解锁额外的研究选项。" }
			,{ LanguageFile = "loc_italian.ini", Value = "CENTRO DATI:#L'IA principale sta lavorando allo sblocco dell'ultimo livello del nucleo dati di combattimento. Una volta completato, garantirà ulteriori opzioni di ricerca." }
			,{ LanguageFile = "japanese.ini", Value = "データコア：#メインAIは戦闘データコアの最終層のロック解除に取り組んでいます。ロック解除が完了すると、追加の研究オプションが利用可能になります。" }
		},
		SpritePath = modFilepath.."sprites\\final_data_core_research.png",
		UnlockedComponents = {}
	})

	local novaUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_NovaMech", ComponentType = componentTypes.Mech }
	})
	local novaResearch = Mod.Research.AddResearch({
		Name = "CDC_NovaResearch",
		Position = 140,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 4,
		RequiredStaff = 120,
		ReseachIcon = researchIcons.Production,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats." }
			,{ LanguageFile = "loc_french.ini", Value = "NOUVEAU MECH : NOVA#2 canons, 2 points de blindage, 15 de résistance aux impacts, 40 de résistance à l'eau. Un mécha de combat produit en masse avec des statistiques correctes." }
			,{ LanguageFile = "loc_german.ini", Value = "NEUER MECH: NOVA#2 Geschütze, 2 Panzerung, 15 Stoßfestigkeit, 40 Wasserfestigkeit. Ein in Serie gefertigter Kampfmech mit ordentlichen Werten." }
			,{ LanguageFile = "loc_polish.ini", Value = "NOWY MECH: NOVA#2 działa, 2 pancerze, 15 punktów odporności na uderzenia, 40 punktów odporności na wodę. Masowo produkowany mech bojowy z przyzwoitymi statystykami." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NOVO MECH: NOVA#2 armas, 2 de blindagem, 15 de resistência a impactos, 40 de resistência à água. Um mecha de combate produzido em massa com atributos decentes." }
			,{ LanguageFile = "loc_russian.ini", Value = "НОВЫЙ МЕХАНИЗМ: HOBA#2 орудия, 2 брони, 15 сопротивления удару, 40 сопротивления воде. Серийный боевой мех c неплохими характеристиками." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NUEVO MECH: NOVA#Dos armas, dos puntos de blindaje, 15 de resistencia al impacto y 40 de resistencia al agua. Un mecha de combate de producción en masa con estadísticas decentes." }
			,{ LanguageFile = "loc_chinese.ini", Value = "新机甲：诺瓦#2门武器,2层装甲,15点冲击抗性,40点防水性。一款性能不错的量产战斗机甲。" }
			,{ LanguageFile = "chs.ini", Value = "新机甲：诺瓦#2门武器,2层装甲,15点冲击抗性,40点防水性。一款性能不错的量产战斗机甲。" }
			,{ LanguageFile = "loc_italian.ini", Value = "NUOVO MECCANICO: NOVA#2 armi, 2 di armatura, 15 di resistenza agli urti, 40 di resistenza all'acqua. Un mech da combattimento prodotto in serie con statistiche discrete." }
			,{ LanguageFile = "japanese.ini", Value = "新メカ：ノヴァ#銃2丁、装甲2、耐衝撃性15、耐水性40。そこそこの性能を持つ量産型戦闘メカ。" }
		},
		SpritePath = modFilepath.."sprites\\nova_research.png",
		UnlockedComponents = novaUnlocks
	})

	local sentinelUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_SentinelMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		Name = "CDC_SentinelResearch",
		Position = 132,
		PrerequisiteResearchResNumber = deepDataCore,
		RequiredDays = 6,
		RequiredStaff = 160,
		ReseachIcon = researchIcons.Production,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "NEW MECH: SENTINEL#4 guns, 5 armor, 90 impact resistance, 80 water resistance. Armored assault mech with plenty of auxiliary slots." }
			,{ LanguageFile = "loc_french.ini", Value = "NOUVEAU MÉCANIQUE : SENTINELLE#4 canons, 5 points de blindage, 90 de résistance aux impacts, 80 de résistance à l'eau. Méca d'assaut blindé avec de nombreux emplacements auxiliaires." }
			,{ LanguageFile = "loc_german.ini", Value = "NEUER MECH: SENTINEL#4 Geschütze, 5 Panzerung, 90 Stoßfestigkeit, 80 Wasserfestigkeit. Gepanzerter Angriffsmech mit zahlreichen Zusatzausrüstungsplätzen." }
			,{ LanguageFile = "loc_polish.ini", Value = "NOWY MECH: SENTINEL#4 działa, 5 punktów pancerza, 90 punktów odporności na uderzenia, 80 punktów wodoodporności. Opancerzony mech szturmowy z wieloma dodatkowymi slotami." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NOVO MECH: SENTINELA#4 armas, 5 de blindagem, 90 de resistência a impactos, 80 de resistência à água. Mech de assalto blindado com vários slots auxiliares." }
			,{ LanguageFile = "loc_russian.ini", Value = "НОВЫЙ МЕХАНИЗМ: СТРАЖ#4 орудия, 5 единиц брони, 90 единиц сопротивления удару, 80 единиц сопротивления воде. Бронированный штурмовой мех c множеством дополнительных слотов." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NUEVO MECH: CENTINELA#4 cañones, 5 de blindaje, 90 de resistencia al impacto, 80 de resistencia al agua. Mech de asalto blindado con muchas ranuras auxiliares." }
			,{ LanguageFile = "loc_chinese.ini", Value = "新机甲：哨兵#4门武器,5点装甲,90点抗冲击力,80点防水力。装甲突击机甲,拥有大量辅助插槽。" }
			,{ LanguageFile = "chs.ini", Value = "新机甲：哨兵#4门武器,5点装甲,90点抗冲击力,80点防水力。装甲突击机甲,拥有大量辅助插槽。" }
			,{ LanguageFile = "loc_italian.ini", Value = "NUOVO MECH: SENTINEL#4 cannoni, 5 di armatura, 90 di resistenza agli urti, 80 di resistenza all'acqua. Mech d'assalto corazzato con numerosi slot ausiliari." }
			,{ LanguageFile = "japanese.ini", Value = "新メカ：センチネル#銃4丁、装甲5、耐衝撃性90、耐水性80。補助スロットを多数備えた装甲突撃メカ。" }
		},
		SpritePath = modFilepath.."sprites\\sentinel_research.png",
		UnlockedComponents = sentinelUnlocks
	})

	local behemothUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_BehemothMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		Name = "CDC_BehemothResearch",
		Position = 143,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 6,
		RequiredStaff = 160,
		ReseachIcon = researchIcons.Production,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "NEW MECH: BEHEMOTH#14 guns, 5 armor, 95 impact resistance, 95 water resistance. A massive armored assault mech with plenty of slots." }
			,{ LanguageFile = "loc_french.ini", Value = "NOUVEAU MÉCANIQUE : BÉHÉMOTH#14 canons, 5 points de blindage, 95 de résistance aux impacts, 95 de résistance à l'eau. Un mécha d'assaut blindé massif avec de nombreux emplacements d'équipement." }
			,{ LanguageFile = "loc_german.ini", Value = "NEUER MECH: BEHEMOTH#14 Geschütze, 5 Panzerung, 95 Stoßfestigkeit, 95 Wasserfestigkeit. Ein massiver, gepanzerter Angriffsmech mit zahlreichen Ausrüstungsslots." }
			,{ LanguageFile = "loc_polish.ini", Value = "NOWY MECH: BEHEMOTH#14 dział, 5 punktów pancerza, 95 punktów odporności na uderzenia, 95 punktów odporności na wodę. Ogromny, opancerzony mech szturmowy z mnóstwem slotów." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NOVO MECH: BEHEMOTH#14 armas, 5 de blindagem, 95 de resistência a impactos, 95 de resistência à água. Um enorme mecha de assalto blindado com muitos espaços para equipamentos." }
			,{ LanguageFile = "loc_russian.ini", Value = "НОВЫЙ МЕХАНИЗМ: БЫМОТ#14 орудий, 5 единиц брони, 95 единиц ударопрочности, 95 единиц водостойкости. Массивный бронированный штурмовой мех с множеством слотов." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NUEVO MECH: BEHEMOTH#14 cañones, 5 de blindaje, 95 de resistencia al impacto, 95 de resistencia al agua. Un enorme mecha de asalto blindado con multitud de ranuras." }
			,{ LanguageFile = "loc_chinese.ini", Value = "新机甲：巨兽#14门武器，5点装甲，95点抗冲击性，95点防水性。一台拥有大量插槽的巨型装甲突击机甲。" }
			,{ LanguageFile = "chs.ini", Value = "新机甲：巨兽#14门武器，5点装甲，95点抗冲击性，95点防水性。一台拥有大量插槽的巨型装甲突击机甲。" }
			,{ LanguageFile = "loc_italian.ini", Value = "NUOVO MECH: BEHEMOTH#14 cannoni, 5 di armatura, 95 di resistenza agli urti, 95 di resistenza all'acqua. Un massiccio mech d'assalto corazzato con tantissimi slot." }
			,{ LanguageFile = "japanese.ini", Value = "新メカ：ベヒーモス#銃14丁、装甲5、耐衝撃性95、耐水性95。スロットが豊富な巨大装甲突撃メカ。" }
		},
		SpritePath = modFilepath.."sprites\\behemoth_research.png",
		UnlockedComponents = behemothUnlocks
	})

	local echoUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_EchoMech", ComponentType = componentTypes.Mech }
	})
	Mod.Research.AddResearch({
		Name = "CDC_EchoResearch",
		Position = 141,
		PrerequisiteResearchResNumber = novaResearch,
		RequiredDays = 6,
		RequiredStaff = 120,
		ReseachIcon = researchIcons.Production,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "NEW MECH: ECHO#3 guns, 3 armor, 30 impact resistance, 20 water resistance. A armored mech with high mobility." }
			,{ LanguageFile = "loc_french.ini", Value = "NOUVEAU MÉCANIQUE : ECHO#3 canons, 3 points de blindage, 30 de résistance aux impacts, 20 de résistance à l'eau. Un mécha blindé à haute mobilité." }
			,{ LanguageFile = "loc_german.ini", Value = "NEUER MECH: ECHO#3 Geschütze, 3 Panzerung, 30 Stoßfestigkeit, 20 Wasserfestigkeit. Ein gepanzerter Mech mit hoher Mobilität." }
			,{ LanguageFile = "loc_polish.ini", Value = "NOWY MECH: ECHO#3 działa, 3 pancerze, 30 odporności na uderzenia, 20 odporności na wodę. Opancerzony mech o dużej mobilności." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "NOVO MECH: ECHO#3 armas, 3 de blindagem, 30 de resistência a impactos, 20 de resistência à água. Um mecha blindado com alta mobilidade." }
			,{ LanguageFile = "loc_russian.ini", Value = "НОВЫЙ МЕХАНИЗМ: ЭХО#3 орудия, 3 брони, 30 ударопрочности, 20 водостойкости. Бронированный мех с высокой мобильностью." }
			,{ LanguageFile = "loc_spanish.ini", Value = "NUEVO MECANISMO: ECHO#3 cañones, 3 de blindaje, 30 de resistencia al impacto, 20 de resistencia al agua. Un mecha blindado con alta movilidad." }
			,{ LanguageFile = "loc_chinese.ini", Value = "新机甲：回声#3门武器，3层装甲，30点抗冲击力，20点防水力。一款高机动性的装甲机甲。" }
			,{ LanguageFile = "chs.ini", Value = "新机甲：回声#3门武器，3层装甲，30点抗冲击力，20点防水力。一款高机动性的装甲机甲。" }
			,{ LanguageFile = "loc_italian.ini", Value = "NUOVO MECH: ECHO#3 armi, 3 di armatura, 30 di resistenza agli urti, 20 di resistenza all'acqua. Un mech corazzato ad alta mobilità." }
			,{ LanguageFile = "japanese.ini", Value = "新メカ：エコー#銃3丁、装甲3、耐衝撃性30、耐水性20。高い機動性を備えた装甲メカ。" }
		},
		SpritePath = modFilepath.."sprites\\echo_research.png",
		UnlockedComponents = echoUnlocks
	})

	local highTechSolenoidUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_HighTechSolenoid", ComponentType = componentTypes.Solenoid }
	})
	Mod.Research.AddResearch({
		Name = "CDC_HighTechSolenoidResearch",
		Position = 133,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 2,
		RequiredStaff = 120,
		ReseachIcon = researchIcons.Volcano,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "HIGH TECH SOLENOID#Using advanced metallurgy processes we can create a better solenoid for our thermonuclear reactors. Granting them better cooling characteristics." }
			,{ LanguageFile = "loc_french.ini", Value = "ÉLECTROVANNE HAUTE TECHNOLOGIE#Grâce à des procédés métallurgiques avancés, nous pouvons créer un solénoïde plus performant pour nos réacteurs thermonucléaires, leur conférant ainsi de meilleures caractéristiques de refroidissement." }
			,{ LanguageFile = "loc_german.ini", Value = "HOCHTECHNOLOGIE-MAGNETVENTIL#Mithilfe fortschrittlicher metallurgischer Verfahren können wir ein besseres Solenoid für unsere thermonuklearen Reaktoren herstellen. Dadurch erhalten diese bessere Kühleigenschaften." }
			,{ LanguageFile = "loc_polish.ini", Value = "ELEKTROMAGNETYCZNY HIGH TECH#Wykorzystując zaawansowane procesy metalurgiczne, możemy stworzyć lepszy elektromagnes do naszych reaktorów termojądrowych, zapewniając im lepsze właściwości chłodzące." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "SOLENOIDE DE ALTA TECNOLOGIA#Utilizando processos metalúrgicos avançados, podemos criar um solenoide melhor para nossos reatores termonucleares, conferindo-lhes melhores características de resfriamento." }
			,{ LanguageFile = "loc_russian.ini", Value = "Высокотехнологичный соленоид#Используя передовые металлургические процессы, мы можем создать более совершенный соленоид для наших термоядерных реакторов, обеспечив им лучшие характеристики охлаждения." }
			,{ LanguageFile = "loc_spanish.ini", Value = "SOLENOIDE DE ALTA TECNOLOGÍA#Mediante procesos metalúrgicos avanzados podemos crear un solenoide mejorado para nuestros reactores termonucleares, lo que les confiere mejores características de refrigeración." }
			,{ LanguageFile = "loc_chinese.ini", Value = "高科技电磁阀#利用先进的冶金工艺，我们可以为热核反应堆制造出性能更优的螺线管，从而赋予其更好的冷却性能。" }
			,{ LanguageFile = "chs.ini", Value = "高科技电磁阀#利用先进的冶金工艺，我们可以为热核反应堆制造出性能更优的螺线管，从而赋予其更好的冷却性能。" }
			,{ LanguageFile = "loc_italian.ini", Value = "ELETTROVALVOLA AD ALTA TECNOLOGIA#Grazie a processi metallurgici avanzati, possiamo creare un solenoide migliore per i nostri reattori termonucleari, garantendo loro caratteristiche di raffreddamento superiori." }
			,{ LanguageFile = "japanese.ini", Value = "ハイテクソレノイド#高度な冶金プロセスを用いることで、熱核融合炉用のより優れたソレノイドを製造し、冷却特性を向上させることができます。" }
		},
		SpritePath = modFilepath.."sprites\\high_tech_solenoid_research.png",
		UnlockedComponents = highTechSolenoidUnlocks
	})

	local howitzerUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_Howitzer", ComponentType = componentTypes.Weapon }
	})
	Mod.Research.AddResearch({
		Name = "CDC_HowitzerResearch",
		Position = 120,
		PrerequisiteResearchResNumber = dataCore,
		RequiredDays = 2,
		RequiredStaff = 40,
		ReseachIcon = researchIcons.Damage,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "HOWITZER#A large 240mm artillery weapon repurposed for use in direct fire." }
			,{ LanguageFile = "loc_french.ini", Value = "OBUSIER#Une pièce d'artillerie de gros calibre (240 mm) reconvertie pour le tir direct." }
			,{ LanguageFile = "loc_german.ini", Value = "HAUBITZE#Eine große 240-mm-Artilleriekanone, die für den Einsatz im direkten Feuer umgerüstet wurde." }
			,{ LanguageFile = "loc_polish.ini", Value = "HAUBICA#Duża broń artyleryjska kalibru 240 mm przystosowana do ognia bezpośredniego." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "Obuseiro#Uma grande arma de artilharia de 240 mm adaptada para uso em fogo direto." }
			,{ LanguageFile = "loc_russian.ini", Value = "ГАВИТЦЕР#Крупнокалиберное 240-мм артиллерийское орудие, переоборудованное для стрельбы прямой наводкой." }
			,{ LanguageFile = "loc_spanish.ini", Value = "OBÚS#Un arma de artillería de gran calibre de 240 mm, adaptada para su uso en fuego directo." }
			,{ LanguageFile = "loc_chinese.ini", Value = "榴弹炮#一门大型 240 毫米火炮，经过改装后用于直射。" }
			,{ LanguageFile = "chs.ini", Value = "榴弹炮#一门大型 240 毫米火炮，经过改装后用于直射。" }
			,{ LanguageFile = "loc_italian.ini", Value = "OBICE#Un grosso cannone da 240 mm riadattato per il tiro diretto." }
			,{ LanguageFile = "japanese.ini", Value = "榴弾砲#直接射撃用に転用された大型240mm砲。" }
		},
		SpritePath = modFilepath.."sprites\\howitzer_research.png",
		UnlockedComponents = howitzerUnlocks
	})

	local laserPulseCannonUnlocks = Mod.Common.GetModdedComponents({
		{ Name = "CDC_LaserPulseCannon", ComponentType = componentTypes.Weapon }
	})
	Mod.Research.AddResearch({
		Name = "CDC_LaserPulseCannonResearch",
		Position = 144,
		PrerequisiteResearchResNumber = finalDataCore,
		RequiredDays = 8,
		RequiredStaff = 160,
		ReseachIcon = researchIcons.Damage,
		Description = {
			 { LanguageFile = "loc_english.ini", Value = "AUXILIARY POWER UNIT#Able to provide portable power for high energy draw weapons without overloading the reactor connections. Enabling the production of the EXTENDED RANGE LASER PULSE CANNON." }
			,{ LanguageFile = "loc_french.ini", Value = "GROUPE ÉLECTROGÈNE AUXILIAIRE#Capable de fournir une alimentation portable aux armes à forte consommation d'énergie sans surcharger les connexions du réacteur. Permet la production du CANON À IMPULSIONS LASER À PORTÉE ÉTENDUE." }
			,{ LanguageFile = "loc_german.ini", Value = "Hilfsstromversorgungseinheit#Kann tragbare Energie für Waffen mit hohem Energiebedarf bereitstellen, ohne die Reaktoranschlüsse zu überlasten. Ermöglicht die Produktion der Laserpulskanone mit erweiterter Reichweite." }
			,{ LanguageFile = "loc_polish.ini", Value = "POMOCNICZY JEDNOSTKA ZASILANIA#Możliwość zapewnienia przenośnego zasilania broni o dużym poborze energii bez przeciążania połączeń reaktora. Umożliwia produkcję LASEROWEGO DZIAŁA IMPULSOWEGO O ROZSZERZONYM ZASIĘGU." }
			,{ LanguageFile = "loc_portuguese_brazil.ini", Value = "UNIDADE DE ENERGIA AUXILIAR#Capaz de fornecer energia portátil para armas de alto consumo energético sem sobrecarregar as conexões do reator. Possibilitando a produção do CANHÃO DE PULSO LASER DE ALCANCE ESTENDIDO." }
			,{ LanguageFile = "loc_russian.ini", Value = "Вспомогательный блок питания#Способна обеспечивать портативное питание для оружия с высоким энергопотреблением без перегрузки соединений реактора. Позволяет производить лазерные импульсные пушки увеличенной дальности." }
			,{ LanguageFile = "loc_spanish.ini", Value = "UNIDAD DE POTENCIA AUXILIAR#Capaz de proporcionar energía portátil para armas de alto consumo energético sin sobrecargar las conexiones del reactor. Esto permite la producción del cañón láser de pulsos de alcance extendido." }
			,{ LanguageFile = "loc_chinese.ini", Value = "辅助动力装置#能够为高能量消耗武器提供便携式电源，而不会使反应堆连接过载。这使得远程激光脉冲炮的生产成为可能。" }
			,{ LanguageFile = "chs.ini", Value = "辅助动力装置#能够为高能量消耗武器提供便携式电源，而不会使反应堆连接过载。这使得远程激光脉冲炮的生产成为可能。" }
			,{ LanguageFile = "loc_italian.ini", Value = "UNITÀ DI ALIMENTAZIONE AUSILIARIA#In grado di fornire energia portatile per armi ad alto consumo energetico senza sovraccaricare i collegamenti del reattore. Consente la produzione del cannone a impulsi laser a raggio esteso." }
			,{ LanguageFile = "japanese.ini", Value = "補助動力装置#原子炉の接続部に過負荷をかけることなく、高エネルギー消費兵器に携帯型電源を供給可能。これにより、射程延長型レーザーパルス砲の生産が可能となる。" }
		},
		SpritePath = modFilepath.."sprites\\laser_pulse_cannon_research.png",
		UnlockedComponents = laserPulseCannonUnlocks
	})
end

---if activated = true
---@param q any
function step(q)
end

---if activated = true
---@param q any
function draw(q)
end