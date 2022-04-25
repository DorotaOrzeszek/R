#install.packages("stringr")
library("stringr")

# load Form Maker data CSV file
alldata <- read.csv("PABIQITSWPl_20220327.csv", header = TRUE, sep = ",", na.strings = "")
# remove test records (true records have 21-char IDs from StarWords app)
realdata <- subset(alldata, alldata$X_id != "NA" & nchar(as.character(alldata$X_id)) == 21)

# transform CSV columns

# FormMaker submission ID
id <- as.integer(realdata$ď.żID)

date <- as.Date(realdata$Submit.date)

# StarWords app ID: 21-character string
child_id_sw <- as.character(realdata$X_id)

# type of redirection: ws, wg
form_group <- as.factor(realdata$form_group)

# Q: Kim jest Pani/Pan dla dziecka?
# A: matka, ojciec, babcia, dziadek, niania, nauczyciel(ka), inne
submitter <- as.factor(realdata$Kim.jest.Pani.Pan.dla.dziecka.)

# Q: Data urodzenia:
birth_date_child <- as.Date(realdata$Data.urodzenia., "%d-%m-%Y")

# Q: Kraj urodzenia dziecka:
birth_country_child <- as.factor(realdata$Kraj.urodzenia.dziecka.)
birth_region_child <- as.factor(tolower(realdata$WojewĂłdztwo.Region.urodzenia.dziecka.))
birth_town_child <- as.character(tolower(realdata$MiejscowoĹ.Ä..urodzenia.dziecka.))

# Q: Czy dziecko mieszka w innym kraju niż kraj urodzenia?
# A: TAK, NIE
other_country_residence <- as.factor(realdata$Czy.dziecko.mieszka.w.innym.kraju.niĹĽ.kraj.urodzenia.)

# Q: Kraj zamieszkania dziecka:
residence_country_child <- as.factor(realdata$Kraj.zamieszkania.dziecka.)
residence_region_child <- as.factor(realdata$WojewĂłdztwo.Region.zamieszkania.dziecka.)
residence_town_child <- as.character(realdata$MiejscowoĹ.Ä..zamieszkania.dziecka.)

# Q: Data przyjazdu do kraju zamieszkania:
residence_date <- as.Date(realdata$Data.przyjazdu.do.kraju.zamieszkania., "%d-%m-%Y")

# Q: Płeć dziecka:
gender <- as.factor(realdata$PĹ.eÄ..dziecka.)

# Q: Ile rodzeństwa ma dziecko?
# A: 0-5
siblings <- as.integer(realdata$Ile.rodzeĹ.stwa.ma.dziecko.)

# Q: Kolejność narodzin: którym z kolei dzieckiem jest dziecko, którego dotyczy kwestionariusz?
# A: pierwsze (najstarsze), drugie, trzecie, czwarte, piąte, szóste
birth_order <- as.factor(realdata$KolejnoĹ.Ä..narodzin..ktĂłrym.z.kolei.dzieckiem.jest.dziecko..ktĂłrego.dotyczy.kwestionariusz.)

birth_date_sibling_1 <- as.Date(realdata$Data.urodzenia.rodzeĹ.stwa.1, "%d-%m-%Y")
gender_sibling_1 <- as.factor(realdata$PĹ.eÄ..rodzeĹ.stwa.1.)

birth_date_sibling_2 <- as.Date(realdata$Data.urodzenia.rodzeĹ.stwa.2, "%d-%m-%Y")
gender_sibling_2 <- as.factor(realdata$PĹ.eÄ..rodzeĹ.stwa.2)

birth_date_sibling_3 <- as.Date(realdata$Data.urodzenia.rodzeĹ.stwa.3, "%d-%m-%Y")
gender_sibling_3 <- as.factor(realdata$PĹ.eÄ..rodzeĹ.stwa.3)

birth_date_sibling_4 <- as.Date(realdata$Data.urodzenia.rodzeĹ.stwa.4, "%d-%m-%Y")
gender_sibling_4 <- as.factor(realdata$PĹ.eÄ..rodzeĹ.stwa.4)

birth_date_sibling_5 <- as.Date(realdata$Data.urodzenia.rodzeĹ.stwa.5, "%d-%m-%Y")
gender_sibling_5 <- as.factor(realdata$PĹ.eÄ..rodzeĹ.stwa.5)

# Q: Czy występowały komplikacje w trakcie ciąży lub porodu?
# A: TAK, NIE
complications <- as.factor(realdata$Czy.wystÄ.powaĹ.y.komplikacje.w.trakcie.ciÄ.ĹĽy.lub.porodu.)
complications_info <- as.character(realdata$JeĹ.li.tak..proszÄ..podaÄ..jakie.)

# Q: Jaka była waga urodzeniowa dziecka? (w gramach)
birth_weight <- as.numeric(gsub(".*?([0-9]+).*", "\\1", realdata$Jaka.byĹ.a.waga.urodzeniowa.dziecka...i..w.gramach...i.))

# Q: W jakim wieku dziecko zaczęło chodzić? (w miesiącach)
age_walk <- as.integer(realdata$W.jakim.wieku.dziecko.zaczÄ.Ĺ.o.chodziÄ....i..w.miesiÄ.cach...i.)

# Q: W jakim wieku dziecko wypowiedziało pierwsze słowo? (w miesiącach)
age_first_word <- as.integer(realdata$W.jakim.wieku.dziecko.wypowiedziaĹ.o.pierwsze.sĹ.owo...i..w.miesiÄ.cach...i.)

# Q: Czy martwią Panią/Pana jakieś sprawy związane z rozwojem języka dziecka?
# A: TAK, NIE
worries <- as.factor(realdata$Czy.martwiÄ..PaniÄ..Pana.jakieĹ..sprawy.zwiÄ.zane.z.rozwojem.jÄ.zyka.dziecka.)
worries_info <- as.character(realdata$ProszÄ..krĂłtko.opisaÄ...co.martwi.PaniÄ..Pana.w.zwiÄ.zku.z.rozwojem.jÄ.zyka.dziecka.)

# Q: Czy dziecko ma jakieś problemy zdrowotne?
# A: TAK, NIE
medical_conditions <- as.factor(realdata$Czy.dziecko.ma.jakieĹ..problemy.zdrowotne.)
medical_conditions_info <- as.character(realdata$ProszÄ..krĂłtko.opisaÄ...na.czym.polegajÄ..problemy.zdrowotne.dziecka.)

# Q: Czy dziecko przechodziło częste przeziębienia?
# A: TAK, NIE
infections <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.czÄ.ste.przeziÄ.bienia.)

# Q: Czy dziecko przechodziło chwilową utratę słuchu?
# A: TAK, NIE
hearing_loss <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.chwilowÄ..utratÄ..sĹ.uchu.)

# Q: Czy dziecko ma jakieś alergie?
# A: TAK, NIE
allergies <- as.factor(realdata$Czy.dziecko.ma.jakieĹ..alergie.)

# Q: Czy dziecko miało wstawiane dreny do ucha/uszu?
# A: TAK, NIE
grommets <- as.factor(realdata$Czy.dziecko.miaĹ.o.wstawiane.dreny.do.ucha.uszu.)

# Q: Czy dziecko przechodziło częste infekcje ucha?
# A: TAK, NIE
ear_infections <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.czÄ.ste.infekcje.ucha.)
ear_infections_weeks <- as.integer(realdata$Przez.ile.tygodni.w.ostatnim.roku.dziecko.chorowaĹ.o.na.infekcje.ucha.)

# Q: Proszę wymienić, jakie inne choroby przechodziło dziecko:
other_conditions <- as.character(realdata$ProszÄ..wymieniÄ...jakie.inne.choroby.przechodziĹ.o.dziecko.)

# Q: Czy dziecko ma regularny kontakt z osobami mówiącymi do niego w języku innym niż polski (np. niania, nauczyciel, dziadkowie)? Proszę zaznaczyć "TAK" również wtedy, kiedy dziecko ma kontakt ze śląskim, kaszubskim lub jakąś regionalną odmianą języka polskiego.
# A: TAK, NIE
lang_contact <- as.factor(realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mĂłwiÄ.cymi.do.niego.w.jÄ.zyku.innym.niĹĽ.polski..np..niania..nauczyciel..dziadkowie....br.ProszÄ..zaznaczyÄ...TAK..rĂłwnieĹĽ.wtedy..kiedy.dziecko.ma.kontakt.ze.Ĺ.lÄ.skim..kaszubskim.lub.jakÄ.Ĺ..regionalnÄ..odmianÄ..jÄ.zyka.polskiego.)

# languages
lang_1 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.1)
lang_2 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.2)
lang_3 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.3)

contact <- as.character(realdata$Jak.czÄ.sto.dziecko.miaĹ.o.kontakt.z.kaĹĽdym.z.tych.jÄ.zykĂłw.do.tej.pory.)

freq_contact_pl <- vector()
freq_contact_lang_1 <- vector()
freq_contact_lang_2 <- vector()
freq_contact_lang_3 <- vector()
for (el in contact) {
  if (is.na(el)) { 
    freq_contact_pl <- append(freq_contact_pl, NA) 
    freq_contact_lang_1 <- append(freq_contact_lang_1, NA) 
    freq_contact_lang_2 <- append(freq_contact_lang_2, NA) 
    freq_contact_lang_3 <- append(freq_contact_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {freq_contact_pl <- append(freq_contact_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {freq_contact_pl <- append(freq_contact_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {freq_contact_pl <- append(freq_contact_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {freq_contact_pl <- append(freq_contact_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0) {freq_contact_pl <- append(freq_contact_pl, NA)}
    if (temp[[1]][10] == 1) {freq_contact_lang_1 <- append(freq_contact_lang_1, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][12] == 1) {freq_contact_lang_1 <- append(freq_contact_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {freq_contact_lang_1 <- append(freq_contact_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {freq_contact_lang_1 <- append(freq_contact_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][10] == 0 & temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0) {freq_contact_lang_1 <- append(freq_contact_lang_1, NA)}
    if (temp[[1]][18] == 1) {freq_contact_lang_2 <- append(freq_contact_lang_2, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {freq_contact_lang_2 <- append(freq_contact_lang_2, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][22] == 1) {freq_contact_lang_2 <- append(freq_contact_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {freq_contact_lang_2 <- append(freq_contact_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][18] == 0 & temp[[1]][20] == 0 & temp[[1]][22] == 0 & temp[[1]][24] == 0) {freq_contact_lang_2 <- append(freq_contact_lang_2, NA)}
    if (temp[[1]][26] == 1) {freq_contact_lang_3 <- append(freq_contact_lang_3, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {freq_contact_lang_3 <- append(freq_contact_lang_3, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {freq_contact_lang_3 <- append(freq_contact_lang_3, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][32] == 1) {freq_contact_lang_3 <- append(freq_contact_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0 & temp[[1]][32] == 0) {freq_contact_lang_3 <- append(freq_contact_lang_3, NA)}
  } } # end freq_langs

first_contacts <- as.character(realdata$W.jakim.wieku.dziecko.miaĹ.o.pierwszy.kontakt.z.danym.jÄ.zykiem...i..w.miesiÄ.cach...i.)
first_contact_pl <- vector()
first_contact_lang_1 <- vector()
first_contact_lang_2 <- vector()
first_contact_lang_3 <- vector()
for (el in first_contacts) {
  temp <- strsplit(el, split = ", ")
  first_contact_pl <- append(first_contact_pl, as.integer(str_sub(temp[[1]][1], 9, -1)))
  first_contact_lang_1 <- append(first_contact_lang_1, as.integer(str_sub(temp[[1]][2], 9, -1)))
  first_contact_lang_2 <- append(first_contact_lang_2, as.integer(str_sub(temp[[1]][3], 9, -1)))
  first_contact_lang_3 <- append(first_contact_lang_3, as.integer(str_sub(temp[[1]][4], 9, -1)))
} # end first contact

parent_1 <- as.factor(realdata$Kto.jest.gĹ.Ăłwnym.opiekunem.dziecka.)

lang_parent_1_child <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.gĹ.Ăłwny.opiekun..b..mĂłwi..b.do.dziecka..b..)
lang_parent_1_child_pl <- vector()
lang_parent_1_child_lang_1 <- vector()
lang_parent_1_child_lang_2 <- vector()
lang_parent_1_child_lang_3 <- vector()
for (el in lang_parent_1_child) {
  if (is.na(el)) { 
    lang_parent_1_child_pl <- append(lang_parent_1_child_pl, NA) 
    lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, NA) 
    lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, NA) 
    lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_parent_1_child_pl <- append(lang_parent_1_child_pl, NA)}
    if (temp[[1]][12] == 1) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_parent_1_child_lang_1 <- append(lang_parent_1_child_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_parent_1_child_lang_2 <- append(lang_parent_1_child_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_parent_1_child_lang_3 <- append(lang_parent_1_child_lang_3, NA)}
  } } # end lang_parent_1_child

lang_child_parent_1 <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.dziecko..b..mĂłwi..b.do.gĹ.Ăłwnego.opiekuna..b..)
lang_child_parent_1_pl <- vector()
lang_child_parent_1_lang_1 <- vector()
lang_child_parent_1_lang_2 <- vector()
lang_child_parent_1_lang_3 <- vector()
for (el in lang_child_parent_1) {
  if (is.na(el)) { 
    lang_child_parent_1_pl <- append(lang_child_parent_1_pl, NA) 
    lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, NA) 
    lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, NA) 
    lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_child_parent_1_pl <- append(lang_child_parent_1_pl, NA)}
    if (temp[[1]][12] == 1) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_child_parent_1_lang_1 <- append(lang_child_parent_1_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_child_parent_1_lang_2 <- append(lang_child_parent_1_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_child_parent_1_lang_3 <- append(lang_child_parent_1_lang_3, NA)}
  } } # end lang_child_parent_1

only_parent <- as.factor(realdata$Czy.gĹ.Ăłwny.opiekun.jest.jedynym.opiekunem.wychowujÄ.cym.dziecko.)

parent_2 <- as.factor(realdata$Kto.jest.drugim.opiekunem.dziecka.)

lang_parent_2_child <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.drugi.opiekun..b..mĂłwi..b.do.dziecka..b..)
lang_parent_2_child_pl <- vector()
lang_parent_2_child_lang_1 <- vector()
lang_parent_2_child_lang_2 <- vector()
lang_parent_2_child_lang_3 <- vector()
for (el in lang_parent_2_child) {
  if (is.na(el)) { 
    lang_parent_2_child_pl <- append(lang_parent_2_child_pl, NA) 
    lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, NA) 
    lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, NA) 
    lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_parent_2_child_pl <- append(lang_parent_2_child_pl, NA)}
    if (temp[[1]][12] == 1) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_parent_2_child_lang_1 <- append(lang_parent_2_child_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_parent_2_child_lang_2 <- append(lang_parent_2_child_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_parent_2_child_lang_3 <- append(lang_parent_2_child_lang_3, NA)}
  } } # end lang_parent_2_child

lang_child_parent_2 <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.dziecko..b..mĂłwi..b.do.drugiego.opiekuna..b..)
lang_child_parent_2_pl <- vector()
lang_child_parent_2_lang_1 <- vector()
lang_child_parent_2_lang_2 <- vector()
lang_child_parent_2_lang_3 <- vector()
for (el in lang_child_parent_2) {
  if (is.na(el)) { 
    lang_child_parent_2_pl <- append(lang_child_parent_2_pl, NA) 
    lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, NA) 
    lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, NA) 
    lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_child_parent_2_pl <- append(lang_child_parent_2_pl, NA)}
    if (temp[[1]][12] == 1) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_child_parent_2_lang_1 <- append(lang_child_parent_2_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_child_parent_2_lang_2 <- append(lang_child_parent_2_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_child_parent_2_lang_3 <- append(lang_child_parent_2_lang_3, NA)}
  } } # end lang_child_parent_2

extra_caregivers <- as.factor(realdata$Czy.sÄ..jeszcze.inni.doroĹ.li..ktĂłrzy.regularnie.opiekujÄ..siÄ..dzieckiem.przez.przynajmniej.kilkanaĹ.cie.godzin.tygodniowo...np..niania.babcia.opiekujÄ.ca.siÄ..dzieckiem.w.czasie.pracy.rodzicĂłw.)

extra_1 <- as.factor(realdata$Kim.jest.dla.dziecka.dodatkowy.opiekun.)

lang_extra_1_child <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.gĹ.Ăłwny.opiekun..b..mĂłwi..b.do.dziecka..b..)
lang_extra_1_child_pl <- vector()
lang_extra_1_child_lang_1 <- vector()
lang_extra_1_child_lang_2 <- vector()
lang_extra_1_child_lang_3 <- vector()
for (el in lang_extra_1_child) {
  if (is.na(el)) { 
    lang_extra_1_child_pl <- append(lang_extra_1_child_pl, NA) 
    lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, NA) 
    lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, NA) 
    lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_extra_1_child_pl <- append(lang_extra_1_child_pl, NA)}
    if (temp[[1]][12] == 1) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_extra_1_child_lang_1 <- append(lang_extra_1_child_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_extra_1_child_lang_2 <- append(lang_extra_1_child_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_extra_1_child_lang_3 <- append(lang_extra_1_child_lang_3, NA)}
  } } # end lang_extra_1_child

lang_child_extra_1 <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.dziecko..b..mĂłwi..b.do.gĹ.Ăłwnego.opiekuna..b..)
lang_child_extra_1_pl <- vector()
lang_child_extra_1_lang_1 <- vector()
lang_child_extra_1_lang_2 <- vector()
lang_child_extra_1_lang_3 <- vector()
for (el in lang_child_extra_1) {
  if (is.na(el)) { 
    lang_child_extra_1_pl <- append(lang_child_extra_1_pl, NA) 
    lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, NA) 
    lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, NA) 
    lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_child_extra_1_pl <- append(lang_child_extra_1_pl, NA)}
    if (temp[[1]][12] == 1) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_child_extra_1_lang_1 <- append(lang_child_extra_1_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_child_extra_1_lang_2 <- append(lang_child_extra_1_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_child_extra_1_lang_3 <- append(lang_child_extra_1_lang_3, NA)}
  } } # end lang_child_extra_1

extra_2 <- as.factor(realdata$Kim.jest.dla.dziecka.dodatkowy.opiekun.2.)

lang_extra_2_child <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.gĹ.Ăłwny.opiekun..b..mĂłwi..b.do.dziecka..b..)
lang_extra_2_child_pl <- vector()
lang_extra_2_child_lang_1 <- vector()
lang_extra_2_child_lang_2 <- vector()
lang_extra_2_child_lang_3 <- vector()
for (el in lang_extra_2_child) {
  if (is.na(el)) { 
    lang_extra_2_child_pl <- append(lang_extra_2_child_pl, NA) 
    lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, NA) 
    lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, NA) 
    lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_extra_2_child_pl <- append(lang_extra_2_child_pl, NA)}
    if (temp[[1]][12] == 1) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_extra_2_child_lang_1 <- append(lang_extra_2_child_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_extra_2_child_lang_2 <- append(lang_extra_2_child_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_extra_2_child_lang_3 <- append(lang_extra_2_child_lang_3, NA)}
  } } # end lang_extra_2_child

lang_child_extra_2 <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.dziecko..b..mĂłwi..b.do.gĹ.Ăłwnego.opiekuna..b..)
lang_child_extra_2_pl <- vector()
lang_child_extra_2_lang_1 <- vector()
lang_child_extra_2_lang_2 <- vector()
lang_child_extra_2_lang_3 <- vector()
i = 1
for (el in lang_child_extra_2) {
  if (is.na(el)) { 
    lang_child_extra_2_pl <- append(lang_child_extra_2_pl, NA) 
    lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, NA) 
    lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, NA) 
    lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_child_extra_2_pl <- append(lang_child_extra_2_pl, NA)}
    if (temp[[1]][12] == 1) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_child_extra_2_lang_1 <- append(lang_child_extra_2_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_child_extra_2_lang_2 <- append(lang_child_extra_2_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_child_extra_2_lang_3 <- append(lang_child_extra_2_lang_3, NA)}
  } } # end lang_child_extra_2

lang_siblings_child <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.gĹ.Ăłwny.opiekun..b..mĂłwi..b.do.dziecka..b..)
lang_siblings_child_pl <- vector()
lang_siblings_child_lang_1 <- vector()
lang_siblings_child_lang_2 <- vector()
lang_siblings_child_lang_3 <- vector()
for (el in lang_siblings_child) {
  if (is.na(el)) { 
    lang_siblings_child_pl <- append(lang_siblings_child_pl, NA) 
    lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, NA) 
    lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, NA) 
    lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_siblings_child_pl <- append(lang_siblings_child_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_siblings_child_pl <- append(lang_siblings_child_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_siblings_child_pl <- append(lang_siblings_child_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_siblings_child_pl <- append(lang_siblings_child_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_siblings_child_pl <- append(lang_siblings_child_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_siblings_child_pl <- append(lang_siblings_child_pl, NA)}
    if (temp[[1]][12] == 1) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_siblings_child_lang_1 <- append(lang_siblings_child_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_siblings_child_lang_2 <- append(lang_siblings_child_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_siblings_child_lang_3 <- append(lang_siblings_child_lang_3, NA)}
  } } # end lang_siblings_child

lang_child_siblings <- as.character(realdata$JÄ.zyk..w.ktĂłrym..b.dziecko..b..mĂłwi..b.do.gĹ.Ăłwnego.opiekuna..b..)
lang_child_siblings_pl <- vector()
lang_child_siblings_lang_1 <- vector()
lang_child_siblings_lang_2 <- vector()
lang_child_siblings_lang_3 <- vector()
i = 1
for (el in lang_child_siblings) {
  if (is.na(el)) { 
    lang_child_siblings_pl <- append(lang_child_siblings_pl, NA) 
    lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, NA) 
    lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, NA) 
    lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, NA) 
  } else {
    temp <- strsplit(el, split = "; |=")
    if (temp[[1]][2] == 1) {lang_child_siblings_pl <- append(lang_child_siblings_pl, str_sub(temp[[1]][1], 9, -2))}
    if (temp[[1]][4] == 1) {lang_child_siblings_pl <- append(lang_child_siblings_pl, str_sub(temp[[1]][3], 9, -2))}
    if (temp[[1]][6] == 1) {lang_child_siblings_pl <- append(lang_child_siblings_pl, str_sub(temp[[1]][5], 9, -2))}
    if (temp[[1]][8] == 1) {lang_child_siblings_pl <- append(lang_child_siblings_pl, str_sub(temp[[1]][7], 9, -2))}
    if (temp[[1]][10] == 1) {lang_child_siblings_pl <- append(lang_child_siblings_pl, str_sub(temp[[1]][9], 9, -2))}
    if (temp[[1]][2] == 0 & temp[[1]][4] == 0 & temp[[1]][6] == 0 & temp[[1]][8] == 0 & temp[[1]][10] == 0) {lang_child_siblings_pl <- append(lang_child_siblings_pl, NA)}
    if (temp[[1]][12] == 1) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, str_sub(temp[[1]][11], 9, -2))}
    if (temp[[1]][14] == 1) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, str_sub(temp[[1]][13], 9, -2))}
    if (temp[[1]][16] == 1) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, str_sub(temp[[1]][15], 9, -2))}
    if (temp[[1]][18] == 1) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, str_sub(temp[[1]][17], 9, -2))}
    if (temp[[1]][20] == 1) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, str_sub(temp[[1]][19], 9, -2))}
    if (temp[[1]][12] == 0 & temp[[1]][14] == 0 & temp[[1]][16] == 0 & temp[[1]][18] == 0 & temp[[1]][20] == 0) {lang_child_siblings_lang_1 <- append(lang_child_siblings_lang_1, NA)}
    if (temp[[1]][22] == 1) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, str_sub(temp[[1]][21], 9, -2))}
    if (temp[[1]][24] == 1) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, str_sub(temp[[1]][23], 9, -2))}
    if (temp[[1]][26] == 1) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, str_sub(temp[[1]][25], 9, -2))}
    if (temp[[1]][28] == 1) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, str_sub(temp[[1]][27], 9, -2))}
    if (temp[[1]][30] == 1) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, str_sub(temp[[1]][29], 9, -2))}
    if (temp[[1]][22] == 0 & temp[[1]][24] == 0 & temp[[1]][26] == 0 & temp[[1]][28] == 0 & temp[[1]][30] == 0) {lang_child_siblings_lang_2 <- append(lang_child_siblings_lang_2, NA)}
    if (temp[[1]][32] == 1) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, str_sub(temp[[1]][31], 9, -2))}
    if (temp[[1]][34] == 1) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, str_sub(temp[[1]][33], 9, -2))}
    if (temp[[1]][36] == 1) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, str_sub(temp[[1]][35], 9, -2))}
    if (temp[[1]][38] == 1) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, str_sub(temp[[1]][37], 9, -2))}
    if (temp[[1]][40] == 1) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, str_sub(temp[[1]][39], 9, -2))}
    if (temp[[1]][32] == 0 & temp[[1]][34] == 0 & temp[[1]][36] == 0 & temp[[1]][38] == 0 & temp[[1]][40] == 0) {lang_child_siblings_lang_3 <- append(lang_child_siblings_lang_3, NA)}
  } } # end lang_child_siblings

lang_parent_uses <- as.factor(realdata$JÄ.zyk..w.ktĂłrym..b.gĹ.Ăłwny.opiekun..b..zwraca.siÄ...b.do.dziecka..b..)

lang_family_uses <- as.factor(realdata$JÄ.zyk..w.ktĂłrym.rozmawiajÄ...b.czĹ.onkowie.rodziny..b..)

birth_country_parent_1 <- as.factor(realdata$Kraj.urodzenia.gĹ.Ăłwnego.opiekuna.)
birth_region_parent_1 <- as.factor(tolower(realdata$WojewĂłdztwo.Region.urodzenia.gĹ.Ăłwnego.opiekuna.))
birth_town_parent_1 <- as.character(tolower(realdata$MiejscowoĹ.Ä..urodzenia.gĹ.Ăłwnego.opiekuna.))

employment_parent_1 <- as.factor(realdata$Czy.gĹ.Ăłwny.opiekun.obecnie.pracuje.)

current_job_parent_1 <- as.character(realdata$Wykonywany.zawĂłd.gĹ.Ăłwnego.opiekuna.)
last_job_parent_1 <- as.character(realdata$Ostatni.zawĂłd.gĹ.Ăłwnego.opiekuna.)

education_parent_1 <- as.factor(realdata$WyksztaĹ.cenie.gĹ.Ăłwnego.opiekuna.)
education_country_parent_1 <- as.factor(realdata$W.jakim.kraju.gĹ.Ăłwny.opiekun.zdobyĹ..ostatni.poziom.swojego.wyksztaĹ.cenia.)

birth_country_parent_2 <- as.factor(realdata$Kraj.urodzenia.drugiego.opiekuna.)
birth_region_parent_2 <- as.factor(tolower(realdata$WojewĂłdztwo.Region.urodzenia.drugiego.opiekuna.))
birth_town_parent_2 <- as.character(tolower(realdata$MiejscowoĹ.Ä..urodzenia.drugiego.opiekuna.))

employment_parent_2 <- as.factor(realdata$Czy.drugi.opiekun.obecnie.pracuje.)

current_job_parent_2 <- as.character(realdata$Wykonywany.zawĂłd.drugiego.opiekuna.)
last_job_parent_2 <- as.character(realdata$Ostatni.zawĂłd.drugiego.opiekuna.)

education_parent_2 <- as.factor(realdata$WyksztaĹ.cenie.drugiego.opiekuna.)
education_country_parent_2 <- as.factor(realdata$W.jakim.kraju.drugi.opiekun.zdobyĹ..ostatni.poziom.swojego.wyksztaĹ.cenia.)

difficulties_school <- as.character(realdata$TrudnoĹ.ci.w.szkole.)
difficulties_school_siblings <- vector()
difficulties_school_parent_1 <- vector()
difficulties_school_parent_1_family <- vector()
difficulties_school_parent_2 <- vector()
difficulties_school_parent_2_family <- vector()
i = 1
for (el in difficulties_school) {
  if (is.na(el)) { 
    difficulties_school_siblings <- append(difficulties_school_siblings, "NIE") 
    difficulties_school_parent_1 <- append(difficulties_school_parent_1, "NIE") 
    difficulties_school_parent_1_family <- append(difficulties_school_parent_1_family, "NIE") 
    difficulties_school_parent_2 <- append(difficulties_school_parent_2, "NIE") 
    difficulties_school_parent_2_family <- append(difficulties_school_parent_2_family, "NIE")
  } else {
    temp <- strsplit(el, split = ", ")
    if (is.element('rodzeĹ„stwo dziecka', temp[[1]])) {difficulties_school_siblings <- append(difficulties_school_siblings, "TAK")} else {difficulties_school_siblings <- append(difficulties_school_siblings, "NIE")}
    if (is.element('gĹ‚Ăłwny opiekun', temp[[1]])) {difficulties_school_parent_1 <- append(difficulties_school_parent_1, "TAK")} else {difficulties_school_parent_1 <- append(difficulties_school_parent_1, "NIE")}
    if (is.element('rodzina gĹ‚Ăłwnego opiekuna', temp[[1]])) {difficulties_school_parent_1_family <- append(difficulties_school_parent_1_family, "TAK")} else {difficulties_school_parent_1_family <- append(difficulties_school_parent_1_family, "NIE")}
    if (is.element('drugi opiekun', temp[[1]])) {difficulties_school_parent_2 <- append(difficulties_school_parent_2, "TAK")} else {difficulties_school_parent_2 <- append(difficulties_school_parent_2, "NIE")}
    if (is.element('rodzina drugiego opiekuna', temp[[1]])) {difficulties_school_parent_2_family <- append(difficulties_school_parent_2_family, "TAK")} else {difficulties_school_parent_2_family <- append(difficulties_school_parent_2, "NIE")}
  } } # end difficulties_school_siblings
difficulties_school_siblings <- as.factor(difficulties_school_siblings)
difficulties_school_parent_1 <- as.factor(difficulties_school_parent_1)
difficulties_school_parent_1_family <- as.factor(difficulties_school_parent_1_family)
difficulties_school_parent_2 <- as.factor(difficulties_school_parent_2)
difficulties_school_parent_2_family <- as.factor(difficulties_school_parent_2_family)

# create and view preprocessed data
df <- data.frame(id, date, child_id_sw, form_group, submitter, birth_date_child, birth_country_child, birth_region_child, birth_town_child, other_country_residence, residence_country_child, residence_region_child, residence_town_child, residence_date, gender, siblings, birth_order, birth_date_sibling_1, gender_sibling_1, birth_date_sibling_2, gender_sibling_2, birth_date_sibling_3, gender_sibling_3, birth_date_sibling_4, gender_sibling_4, birth_date_sibling_5, gender_sibling_5, complications, complications_info, birth_weight, age_walk, age_first_word, worries, worries_info, medical_conditions, medical_conditions_info, infections, hearing_loss, allergies, grommets, ear_infections, ear_infections_weeks, other_conditions, lang_contact, lang_1, lang_2, lang_3, freq_contact_pl, freq_contact_lang_1, freq_contact_lang_2, freq_contact_lang_3, first_contact_pl, first_contact_lang_1, first_contact_lang_2, first_contact_lang_3, parent_1, lang_parent_1_child_pl, lang_parent_1_child_lang_1, lang_parent_1_child_lang_2, lang_parent_1_child_lang_3, lang_child_parent_1_pl, lang_child_parent_1_lang_1, lang_child_parent_1_lang_2, lang_child_parent_1_lang_3, only_parent, parent_2, lang_parent_2_child_pl, lang_parent_2_child_lang_1, lang_parent_2_child_lang_2, lang_parent_2_child_lang_3, lang_child_parent_2_pl, lang_child_parent_2_lang_1, lang_child_parent_2_lang_2, lang_child_parent_2_lang_3, extra_caregivers, lang_extra_1_child_pl, lang_extra_1_child_lang_1, lang_extra_1_child_lang_2, lang_extra_1_child_lang_3, lang_child_extra_1_pl, lang_child_extra_1_lang_1, lang_child_extra_1_lang_2, lang_child_extra_1_lang_3, extra_2, lang_extra_2_child_pl, lang_extra_2_child_lang_1, lang_extra_2_child_lang_2, lang_extra_2_child_lang_3, lang_child_extra_2_pl, lang_child_extra_2_lang_1, lang_child_extra_2_lang_2, lang_child_extra_2_lang_3, lang_siblings_child_pl, lang_siblings_child_lang_1, lang_siblings_child_lang_2, lang_siblings_child_lang_3, lang_child_siblings_pl, lang_child_siblings_lang_1, lang_child_siblings_lang_2, lang_child_siblings_lang_3, lang_parent_uses, lang_family_uses, birth_country_parent_1, birth_region_parent_1, birth_town_parent_1, employment_parent_1, current_job_parent_1, last_job_parent_1, education_parent_1, education_country_parent_1, birth_country_parent_2, birth_region_parent_2, birth_town_parent_2, employment_parent_2, current_job_parent_2, last_job_parent_2, education_parent_2, education_country_parent_2, difficulties_school_siblings, difficulties_school_parent_1, difficulties_school_parent_1_family, difficulties_school_parent_2)
View(df)
