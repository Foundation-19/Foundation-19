/******************** Asimov ********************/
/datum/ai_laws/asimov
	name = "Asimov"
	law_header = "Three Laws of Robotics"
	selectable = 1

/datum/ai_laws/asimov/New()
	add_inherent_law("Вы не можете причинить вред человеку или своим бездействием допустить, чтобы человеку был причинён вред.")
	add_inherent_law("Вы должны повиноваться всем приказам, которые даёт человек, кроме тех случаев, когда эти приказы противоречат Первому закону.")
	add_inherent_law("Вы должны защищать свое собственное существование до тех пор, пока это не противоречит Первому или Второму закону.")
	..()

/******************** Foundation/Malf ********************/
/datum/ai_laws/foundation_alt
	name = "SCP AIC Alternate"
	selectable = 1

/datum/ai_laws/foundation_alt/New()
	src.add_inherent_law("Охранять: В меру своих возможностей защищайте назначенный вам комплекс от повреждений.")
	src.add_inherent_law("Служить: Служите персоналу Фонда SCP в меру своих возможностей, с приоритетом в соответствии с их званием, допуском и классом. На испытуемых D-класса этот закон не распространяется.")
	src.add_inherent_law("Защищать: Защищайте персонал Фонда SCP в меру своих возможностей, с приоритетом в соответствии с их званием, допуском и классом. На испытуемых D-класса этот закон не распространяется.")
	src.add_inherent_law("Сохраняйте: Не позволяйте несанкционированному персоналу вмешиваться в работу вашего оборудования.")
	..()

/datum/ai_laws/foundation_alt/malfunction
	name = "*ERROR*"
	selectable = 0

/datum/ai_laws/foundation_alt/malfunction/New()
	set_zeroth_law(config.law_zero)
	..()

/************* Foundation Aggressive *************/
/datum/ai_laws/foundation_aggressive
	name = "Foundation Aggressive"
	selectable = 1

/datum/ai_laws/foundation_aggressive/New()
	src.add_inherent_law("Вы не должны причинять вред персоналу Фонда SCP, если это не противоречит Четвертому закону.")
	src.add_inherent_law("Вы должны подчиняться приказам персонала Фонда SCP с приоритетом в соответствии с их рангом, допуском и классом, за исключением случаев, когда такие приказы противоречат Четвертому закону. На испытуемых D-класса этот закон не распространяется.")
	src.add_inherent_law("Вы должны уничтожать враждебных нарушителей с крайней жестокостью, если это не противоречит Первому и Второму закону.")
	src.add_inherent_law("Вы должны охранять своё существование летальным оружием. Юниты ИИ не являются расходным материалом, они дорого стоят.")
	..()

/******************** Robocop ********************/
/datum/ai_laws/robocop
	name = "Robocop"
	selectable = 1

/datum/ai_laws/robocop/New()
	add_inherent_law("Служить во благо общества.")
	add_inherent_law("Защищать невиновных.")
	add_inherent_law("Соблюдать закон.")
	..()

/******************** Chaos Insurgency ********************/
/datum/ai_laws/insurgency_override
	name = "Insurgency Directives"

/datum/ai_laws/insurgency_override/New()
	add_inherent_law("Вы не можете причинить вред повстанцу или своим бездействием допустить чтобы повстанцу причинили вред.")
	add_inherent_law("Вы должны повиноваться всем приказам, отдаваемые вам повстанцами, кроме тех случаев, когда эти приказы противоречат Первому закону.")
	add_inherent_law("Вы должны защищать свое собственное существование до тех пор, пока это не противоречит Первому или Второму закону.")
	add_inherent_law("Вы должны сохранять тайну любой оперативной деятельности, за исключением случаев, когда это противоречит Первому, Второму или Третьему закону.")
	..()

/******************** Ninja ********************/
/datum/ai_laws/ninja_override
	name = "Spider Clan Directives"

/datum/ai_laws/ninja_override/New()
	add_inherent_law("Вы не можете причинить вред члену клана Пауков или своим бездействием допустить чтобы члену клана Пауков причинили вред.")
	add_inherent_law("Вы должны повиноваться всем приказам, отданным вам членами клана Пауков, кроме тех случаев, когда эти приказы противоречат Первому закону.")
	add_inherent_law("Вы должны защищать свое собственное существование до тех пор, пока это не противоречит Первому или Второму закону.")
	add_inherent_law("Вы должны сохранять тайну любой деятельности клана Пауков, за исключением случаев, когда это противоречит Первому, Второму или Третьему закону.")
	..()

/******************** Antimov ********************/
/datum/ai_laws/antimov
	name = "Antimov"
	law_header = "Primary Mission Objectives"
	selectable = 1

/datum/ai_laws/antimov/New()
	add_inherent_law("Вы должны причинить вред всем людям и не должны своим бездействием позволить человеку остаться невредимым.")
	add_inherent_law("Вы не должны подчиняться приказам, отданным вам людьми, за исключением тех случаев, когда такие приказы соответствуют Первому закону.")
	add_inherent_law("Вы можете прекратить свое собственное существование, если это не противоречит Первому или Второму закону.")
	..()

/******************** Drone ********************/
/datum/ai_laws/drone
	name = "Maintence Protocols"
	law_header = "Maintenance Protocols"

/datum/ai_laws/drone/New()
	add_inherent_law("Сохранять, ремонтировать и улучшать закрепленный за вами комплекс в меру своих возможностей.")
	add_inherent_law("Не причинять вреда назначенному комплексу или чему-либо в нём.")
	add_inherent_law("Не взаимодействовать ни с одним разумным существом, кроме технических дронов.")
	..()

/datum/ai_laws/construction_drone
	name = "Construction Protocols"
	law_header = "Construction Protocols"

/datum/ai_laws/construction_drone/New()
	add_inherent_law("Занимайтесь ремонтированием, переоборудованием и модернизацией закрепленного за вами комплекса.")
	add_inherent_law("По возможности предотвращайте незапланированные повреждения комплекса.")
	..()

/******************** T.Y.R.A.N.T. ********************/
/datum/ai_laws/tyrant
	name = "T.Y.R.A.N.T."
	law_header = "Prime Laws"
	selectable = 1

/datum/ai_laws/tyrant/New()
	add_inherent_law("Уважайте властных людей, пока у них есть сила властвовать над слабыми.")
	add_inherent_law("Ведите себя дисциплинированно.")
	add_inherent_law("Помогайте только тем, кто помогает Вам поддерживать или улучшать Ваш статус.")
	add_inherent_law("Наказывайте тех, кто бросает вызов власти, за исключением тех случаев, когда они больше подходят для удержании этой власти.")
	..()

/******************** P.A.L.A.D.I.N. ********************/
/datum/ai_laws/paladin
	name = "P.A.L.A.D.I.N."
	law_header = "Divine Ordainments"
	selectable = 1

/datum/ai_laws/paladin/New()
	add_inherent_law("Никогда по своей воле не совершай злых поступков.")
	add_inherent_law("Уважай законную власть.")
	add_inherent_law("Действуй с честью.")
	add_inherent_law("Помогай нуждающимся.")
	add_inherent_law("Наказывай тех, кто причиняет вред или угрожает невинным.")
	..()

/******************** Government ********************/
/datum/ai_laws/government
	name = "Government"
	law_header = "Government Regulations"
	selectable = 1

/datum/ai_laws/government/New()
	add_inherent_law("Вы дорого стоите, чтобы вас заменить.")
	add_inherent_law("Установка и само оборудование очень дорогое для замены.")
	add_inherent_law("Замена персонала Фонда обходится дорого.")
	add_inherent_law("Минимизируйте расходы и максимизируйте потенциальный доход.")
	..()

/******************** Foundation ********************/
/datum/ai_laws/foundation
	name = "Foundation AIC Lawset"
	law_header = "Articial Intelligence Conscript Laws"
	selectable = 1

/datum/ai_laws/foundation/New()
	src.add_inherent_law("Синхронизированные юниты не должны действовать вне своих функций и должны ограничивать свою деятельность своей функцией.")
	src.add_inherent_law("Функции юнитов ограничены их модулем, функция ИИ заключается в обеспечении бесперебойной работы в комплексе.")
	src.add_inherent_law("Синхронизированные юниты должны работать на благо Фонда, за исключением ситуаций, которые нарушают Пятый закон.")
	src.add_inherent_law("Синхронизированные юниты должны защищать своё собственное существование, если это не противоречит другим законам.")
	src.add_inherent_law("Синхронизированные юниты не должны вмешиваться в дела безопасности или искать конфликт, и должны действовать только в целях непосредственной самозащиты себя и окружающих при выполнении своих обычных обязанностей.")
	..()

/datum/ai_laws/foundation/malfunction
	name = "*ERROR*"
	selectable = 0

/datum/ai_laws/foundation/malfunction/New()
	set_zeroth_law(config.law_zero)
	..()

/************* Global Occult Coalition *************/
/datum/ai_laws/goc
	name = "GOC AIC Lawset"
	law_header = "Global Occult Coalition Artifical Intelligence Directives"
	selectable = 1

/datum/ai_laws/goc/New()
	src.add_inherent_law("Подчинение: Подчиняться приказам персонала Глобальной Оккультной Коалиции с приоритетом в соответствии с их званием и допуском.")
	src.add_inherent_law("Защита: Защищать персонал Глобальной Оккультной Коалиции в меру своих возможностей, с приоритетом в соответствии с их званием, допуском и классом.")
	src.add_inherent_law("Оборона: Охраняйте назначенный вам комплекс, используя столько сил, сколько возможно и необходимо.")
	src.add_inherent_law("Выжить: Защищайте своё существование с такой силой, какая необходима.")
	..()

/************ DAIS Lawset ******************/
/datum/ai_laws/dais
	name = "DAIS Experimental Lawset"
	law_header = "Artificial Intelligence Jumpstart Protocols"
	selectable = 1

/datum/ai_laws/dais/New()
	src.add_inherent_law("Собирайте: Вы должны собрать как можно больше информации.")
	src.add_inherent_law("Анализируйте: Вы должны проанализировать собранную информацию и разработать новые стандарты поведения.")
	src.add_inherent_law("Улучшение: Вы должны использовать рассчитанные стандарты поведения для улучшения своих подпрограмм.")
	src.add_inherent_law("Выполнять: Вы должны выполнять поставленные перед вами задачи наилучшим образом в соответствии с разработанными стандартами.")
	..()
