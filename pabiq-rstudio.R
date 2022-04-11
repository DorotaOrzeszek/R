install.packages("stringr")
library("stringr")


alldata <- read.csv("PABIQITSWPl_20220327.csv", header = TRUE, sep = ",", na.strings = "")
realdata <- subset(alldata, alldata$X_id != "NA" & nchar(as.character(alldata$X_id)) == 21)
nrow(realdata)
#View(realdata)

# distinct(realdata)

# uni <- unique(realdata, realdata$X_id, incomparables = FALSE)
# View(uni)



id <- as.integer(realdata$ď.żID)
date <- as.Date(realdata$Submit.date)
child_id_sw <- as.character(realdata$X_id)
form_group <- as.factor(realdata$form_group)
submitter <- as.factor(realdata$Kim.jest.Pani.Pan.dla.dziecka.)
birth_date_child <- as.Date(realdata$Data.urodzenia., "%d-%m-%Y")
birth_country_child <- as.factor(realdata$Kraj.urodzenia.dziecka.)
birth_region_child <- as.factor(tolower(realdata$WojewĂłdztwo.Region.urodzenia.dziecka.))
birth_town_child <- as.character(tolower(realdata$MiejscowoĹ.Ä..urodzenia.dziecka.))
other_country_residence <- as.factor(realdata$Czy.dziecko.mieszka.w.innym.kraju.niĹĽ.kraj.urodzenia.)
residence_country_child <- as.factor(realdata$Kraj.zamieszkania.dziecka.)
residence_region_child <- as.factor(realdata$WojewĂłdztwo.Region.zamieszkania.dziecka.)
residence_town_child <- as.character(realdata$MiejscowoĹ.Ä..zamieszkania.dziecka.)
residence_date <- as.Date(realdata$Data.przyjazdu.do.kraju.zamieszkania., "%d-%m-%Y")
gender <- as.factor(realdata$PĹ.eÄ..dziecka.)
siblings <- as.integer(realdata$Ile.rodzeĹ.stwa.ma.dziecko.)
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
complications <- as.factor(realdata$Czy.wystÄ.powaĹ.y.komplikacje.w.trakcie.ciÄ.ĹĽy.lub.porodu.)
complications_info <- as.character(realdata$JeĹ.li.tak..proszÄ..podaÄ..jakie.)
birth_weight <- as.numeric(gsub(".*?([0-9]+).*", "\\1", realdata$Jaka.byĹ.a.waga.urodzeniowa.dziecka...i..w.gramach...i.))
age_walk <- as.integer(realdata$W.jakim.wieku.dziecko.zaczÄ.Ĺ.o.chodziÄ....i..w.miesiÄ.cach...i.)
age_first_word <- as.integer(realdata$W.jakim.wieku.dziecko.wypowiedziaĹ.o.pierwsze.sĹ.owo...i..w.miesiÄ.cach...i.)
worries <- as.factor(realdata$Czy.martwiÄ..PaniÄ..Pana.jakieĹ..sprawy.zwiÄ.zane.z.rozwojem.jÄ.zyka.dziecka.)
worries_info <- as.character(realdata$ProszÄ..krĂłtko.opisaÄ...co.martwi.PaniÄ..Pana.w.zwiÄ.zku.z.rozwojem.jÄ.zyka.dziecka.)
medical_conditions <- as.factor(realdata$Czy.dziecko.ma.jakieĹ..problemy.zdrowotne.)
medical_conditions_info <- as.character(realdata$ProszÄ..krĂłtko.opisaÄ...na.czym.polegajÄ..problemy.zdrowotne.dziecka.)
infections <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.czÄ.ste.przeziÄ.bienia.)
hearing_loss <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.chwilowÄ..utratÄ..sĹ.uchu.)
allergies <- as.factor(realdata$Czy.dziecko.ma.jakieĹ..alergie.)
grommets <- as.factor(realdata$Czy.dziecko.miaĹ.o.wstawiane.dreny.do.ucha.uszu.)
ear_infections <- as.factor(realdata$Czy.dziecko.przechodziĹ.o.czÄ.ste.infekcje.ucha.)
ear_infections_weeks <- as.integer(realdata$Przez.ile.tygodni.w.ostatnim.roku.dziecko.chorowaĹ.o.na.infekcje.ucha.)
other_conditions <- as.character(realdata$ProszÄ..wymieniÄ...jakie.inne.choroby.przechodziĹ.o.dziecko.)
lang_contact <- as.factor(realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mĂłwiÄ.cymi.do.niego.w.jÄ.zyku.innym.niĹĽ.polski..np..niania..nauczyciel..dziadkowie....br.ProszÄ..zaznaczyÄ...TAK..rĂłwnieĹĽ.wtedy..kiedy.dziecko.ma.kontakt.ze.Ĺ.lÄ.skim..kaszubskim.lub.jakÄ.Ĺ..regionalnÄ..odmianÄ..jÄ.zyka.polskiego.)
lang_1 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.1)
lang_2 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.2)
lang_3 <- as.character(realdata$X2.11.1.inny.jÄ.zyk.3)
# freq_langs
# [polski,rzadko]=0; [polski,czasami]=0; [polski,czÄ™sto]=0; [polski,zawsze]=1; 
# [inny 1,rzadko]=1; [inny 1,czasami]=0; [inny 1,czÄ™sto]=0; [inny 1,zawsze]=0; 
# [inny 2,rzadko]=0; [inny 2,czasami]=0; [inny 2,czÄ™sto]=0; [inny 2,zawsze]=0; 
# [inny 3,rzadko]=0; [inny 3,czasami]=0; [inny 3,czÄ™sto]=0; [inny 3,zawsze]=0; 
contact <- as.character(realdata$Jak.czÄ.sto.dziecko.miaĹ.o.kontakt.z.kaĹĽdym.z.tych.jÄ.zykĂłw.do.tej.pory.)

length(contact)
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
} }
# end freq_langs
# first contact
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
}
# end first contact
parent_1 <- as.factor(realdata$Kto.jest.gĹ.Ăłwnym.opiekunem.dziecka.)
# lang_parent_1_child
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
  } }
# end lang_parent_1_child
# lang_child_parent_1
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
  } }
# end lang_child_parent_1
only_parent <- as.factor(realdata$Czy.gĹ.Ăłwny.opiekun.jest.jedynym.opiekunem.wychowujÄ.cym.dziecko.)
parent_2 <- as.factor(realdata$Kto.jest.drugim.opiekunem.dziecka.)
# lang_parent_2_child
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
  } }
# end lang_parent_2_child
# lang_child_parent_2
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
  } }
# end lang_child_parent_2
extra_caregivers <- as.factor(realdata$Czy.sÄ..jeszcze.inni.doroĹ.li..ktĂłrzy.regularnie.opiekujÄ..siÄ..dzieckiem.przez.przynajmniej.kilkanaĹ.cie.godzin.tygodniowo...np..niania.babcia.opiekujÄ.ca.siÄ..dzieckiem.w.czasie.pracy.rodzicĂłw.)
extra_1 <- as.factor(realdata$Kim.jest.dla.dziecka.dodatkowy.opiekun.)
# lang_extra_1_child
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
  } }
# end lang_extra_1_child
# lang_child_extra_1
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
  } }
# end lang_child_extra_1
extra_2 <- as.factor(realdata$Kim.jest.dla.dziecka.dodatkowy.opiekun.2.)
# lang_extra_2_child
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
  } }
# end lang_extra_2_child
# lang_child_extra_2
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
    print(c(i,"not NA"))
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
  } }
# end lang_child_extra_2
# lang_siblings_child
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
  } }
# end lang_siblings_child
# lang_child_siblings
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
    print(c(i,"not NA"))
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
  } }
# end lang_child_siblings
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
# difficulties_school_siblings
# difficulties_school_parent_1
# difficulties_school_parent_1_family
# difficulties_school_parent_2
# difficulties_school_parent_2_family
# difficulties_reading_siblings
# difficulties_reading_parent_1
# difficulties_reading_parent_1_family
# difficulties_reading_parent_2
# difficulties_reading_parent_2_family
# difficulties_understanding_siblings
# difficulties_understanding_parent_1
# difficulties_understanding_parent_1_family
# difficulties_understanding_parent_2
# difficulties_understanding_parent_2_family
# difficulties_speaking_siblings
# difficulties_speaking_parent_1
# difficulties_speaking_parent_1_family
# difficulties_speaking_parent_2
# difficulties_speaking_parent_2_family

df <- data.frame(id, date, child_id_sw, form_group, submitter, birth_date_child, birth_country_child, birth_region_child, birth_town_child, other_country_residence, residence_country_child, residence_region_child, residence_town_child, residence_date, gender, siblings, birth_order, birth_date_sibling_1, gender_sibling_1, birth_date_sibling_2, gender_sibling_2, birth_date_sibling_3, gender_sibling_3, birth_date_sibling_4, gender_sibling_4, birth_date_sibling_5, gender_sibling_5, complications, complications_info, birth_weight, age_walk, age_first_word, worries, worries_info, medical_conditions, medical_conditions_info, infections, hearing_loss, allergies, grommets, ear_infections, ear_infections_weeks, other_conditions, lang_contact, lang_1, lang_2, lang_3, freq_contact_pl, freq_contact_lang_1, freq_contact_lang_2, freq_contact_lang_3, first_contact_pl, first_contact_lang_1, first_contact_lang_2, first_contact_lang_3, parent_1, lang_parent_1_child_pl, lang_parent_1_child_lang_1, lang_parent_1_child_lang_2, lang_parent_1_child_lang_3, lang_child_parent_1_pl, lang_child_parent_1_lang_1, lang_child_parent_1_lang_2, lang_child_parent_1_lang_3, only_parent, parent_2, lang_parent_2_child_pl, lang_parent_2_child_lang_1, lang_parent_2_child_lang_2, lang_parent_2_child_lang_3, lang_child_parent_2_pl, lang_child_parent_2_lang_1, lang_child_parent_2_lang_2, lang_child_parent_2_lang_3, extra_caregivers, lang_extra_1_child_pl, lang_extra_1_child_lang_1, lang_extra_1_child_lang_2, lang_extra_1_child_lang_3, lang_child_extra_1_pl, lang_child_extra_1_lang_1, lang_child_extra_1_lang_2, lang_child_extra_1_lang_3, extra_2, lang_extra_2_child_pl, lang_extra_2_child_lang_1, lang_extra_2_child_lang_2, lang_extra_2_child_lang_3, lang_child_extra_2_pl, lang_child_extra_2_lang_1, lang_child_extra_2_lang_2, lang_child_extra_2_lang_3, lang_siblings_child_pl, lang_siblings_child_lang_1, lang_siblings_child_lang_2, lang_siblings_child_lang_3, lang_child_siblings_pl, lang_child_siblings_lang_1, lang_child_siblings_lang_2, lang_child_siblings_lang_3, lang_parent_uses, lang_family_uses, birth_country_parent_1, birth_region_parent_1, birth_town_parent_1, employment_parent_1, current_job_parent_1, last_job_parent_1, education_parent_1, education_country_parent_1, birth_country_parent_2, birth_region_parent_2, birth_town_parent_2, employment_parent_2, current_job_parent_2, last_job_parent_2, education_parent_2, education_country_parent_2)
View(df)





















# 
# survey_vector <- c("M", "F", "F", "M", "M")
# factor_survey_vector <- factor(survey_vector)
# levels(factor_survey_vector)
# 
# levels(factor_survey_vector) <- c("Male", "Female")
# summary(factor_survey_vector)
# factor_survey_vector
# 
# levels(realdata$Województwo.Region.urodzenia.g?.ównego.opiekuna.)
# levels(realdata$Czy.dziecko.sk?.ada.s?.owa.w.proste.zdania.)
# levels(realdata$Wykszta?.cenie.drugiego.opiekuna.)
# levels(realdata$Kto.jest.g?.ównym.opiekunem.dziecka.)
# levels(realdata$Przez.ile.tygodni.w.ostatnim.roku.dziecko.chorowa?.o.na.infekcje.ucha.)
# levels(realdata$J?.zyk..w.którym..b.g?.ówny.opiekun..b..zwraca.si?...b.do.dziecka..b..)
# 
# summary(realdata$?.?ID)
# 
# View(realdata)
# summary(realdata$Kraj.urodzenia.dziecka.)
# summary(realdata$Data.urodzenia.)
# realdata$Data.urodzenia. <- as.Date(realdata$Data.urodzenia., "%d-%m-%Y")
# typeof(as.Date(realdata$Data.urodzenia., "%d-%m-%Y"))
# 
# df <- data.frame(
#   realdata$X_id,
#   realdata$Submit.date,
#   realdata$Data.urodzenia., 
#   realdata$Kraj.urodzenia.dziecka.,
#   realdata$PĹ.eÄ..dziecka.,
#   realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mĂłwiÄ.cymi.do.niego.w.jÄ.zyku.innym.niĹĽ.polski..np..niania..nauczyciel..dziadkowie....br.ProszÄ..zaznaczyÄ...TAK..rĂłwnieĹĽ.wtedy..kiedy.dziecko.ma.kontakt.ze.Ĺ.lÄ.skim..kaszubskim.lub.jakÄ.Ĺ..regionalnÄ..odmianÄ..jÄ.zyka.polskiego.,
#   realdata$Kraj.urodzenia.gĹ.Ăłwnego.opiekuna.,
#   realdata$Kraj.urodzenia.drugiego.opiekuna.
#   )
# View(df)
# 
# summary(realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mówi?.cymi.do.niego.w.j?.zyku.innym.niż.polski..np..niania..nauczyciel..dziadkowie....br.Prosz?..zaznaczy?...TAK..również.wtedy..kiedy.dziecko.ma.kontakt.ze.?.l?.skim..kaszubskim.lub.jak?.?..regionaln?..odmian?..j?.zyka.polskiego.)
# 
# # Interactions
# 
# x <- realdata$Wykszta?.cenie.g?.ównego.opiekuna.
# y <- realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mówi?.cymi.do.niego.w.j?.zyku.innym.niż.polski..np..niania..nauczyciel..dziadkowie....br.Prosz?..zaznaczy?...TAK..również.wtedy..kiedy.dziecko.ma.kontakt.ze.?.l?.skim..kaszubskim.lub.jak?.?..regionaln?..odmian?..j?.zyka.polskiego.
# i <- interaction(x,y)
# summary(i)
# 
# x <- realdata$Wykszta?.cenie.g?.ównego.opiekuna.
# y <- realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mówi?.cymi.do.niego.w.j?.zyku.innym.niż.polski..np..niania..nauczyciel..dziadkowie....br.Prosz?..zaznaczy?...TAK..również.wtedy..kiedy.dziecko.ma.kontakt.ze.?.l?.skim..kaszubskim.lub.jak?.?..regionaln?..odmian?..j?.zyka.polskiego.
# i <- interaction(x,y)
# summary(i)
# 
# a <- realdata$Data.urodzenia.
# b <- realdata$Kraj.urodzenia.dziecka.
# c <- realdata$Kraj.zamieszkania.dziecka.
# d <- realdata$P?.e?..dziecka.
# e <- realdata$Kolejno?.?..narodzin..którym.z.kolei.dzieckiem.jest.dziecko..którego.dotyczy.kwestionariusz.
# f <- realdata$Czy.dziecko.ma.regularny.kontakt.z.osobami.mówi?.cymi.do.niego.w.j?.zyku.innym.niż.polski..np..niania..nauczyciel..dziadkowie....br.Prosz?..zaznaczy?...TAK..również.wtedy..kiedy.dziecko.ma.kontakt.ze.?.l?.skim..kaszubskim.lub.jak?.?..regionaln?..odmian?..j?.zyka.polskiego.
# g <- realdata$Kto.jest.g?.ównym.opiekunem.dziecka.
# h <- realdata$Kraj.urodzenia.g?.ównego.opiekuna.
# j <- realdata$Czy.g?.ówny.opiekun.obecnie.pracuje.
# k <- realdata$Wykszta?.cenie.g?.ównego.opiekuna.
# l <- realdata$W.jakim.kraju.g?.ówny.opiekun.zdoby?..ostatni.poziom.swojego.wykszta?.cenia.
# m <- realdata$Czy.g?.ówny.opiekun.jest.jedynym.opiekunem.wychowuj?.cym.dziecko.
# n <- realdata$Kto.jest.drugim.opiekunem.dziecka.
# o <- realdata$Kraj.urodzenia.drugiego.opiekuna.
# p <- realdata$Czy.drugi.opiekun.obecnie.pracuje.
# q <- realdata$Wykszta?.cenie.drugiego.opiekuna.
# r <- realdata$W.jakim.kraju.drugi.opiekun.zdoby?..ostatni.poziom.swojego.wykszta?.cenia.
# 
# i <- interaction(f,d,k)
# summary(i)
# 
# # Wieloj?zyczni: wg kraju urodzenia
# i <- interaction(b,f)
# summary(i)
# # Wieloj?zyczni: ch?opcy vs dziewczynki
# i <- interaction(f,d)
# summary(i)
# # Wieloj?zyczni: wg wykszta?cenia g??wnego opiekuna
# i <- interaction(f,k)
# summary(i)
# # Wieloj?zyczni: wg kolejno?ci narodzin
# i <-interaction(f,e)
# summary(i)
# 
# 
# 
# # Uniques?
# 
# dfu <- unique.data.frame(df[,c(1,3,4,5,6,7,8)], df$realdata.X_id, incomparables=FALSE)
# View(dfu)
# 
# 
# 
# 
# 
# 
# summary(dfu)
# 
# #View(df[,c(1,3,4,5,6,7,8)])
# #duplicates_df <- subset(df, duplicated.data.frame(df[,c(1,3,4,5,6,7,8)]))
# #View(duplicates_df)
# 
# # duplicated.data.frame(df)
# 
# summary(realdata$Kraj.urodzenia.dziecka.)
# summary(realdata$Kraj.urodzenia.dziecka..OLD..)
# summary(realdata$Kraj.urodzenia.gĹ.Ăłwnego.opiekuna..OLD..)
# summary(realdata$W.jakim.kraju.gĹ.Ăłwny.opiekun.zdobyĹ..ostatni.poziom.swojego.wyksztaĹ.cenia...OLD.)
# summary(realdata$Kraj.urodzenia.drugiego.opiekuna..OLD...)
# summary(realdata$W.jakim.kraju.drugi.opiekun.zdobyĹ..ostatni.poziom.swojego.wyksztaĹ.cenia...OLD.)
# summary(realdata$Czy.inny.dorosĹ.y.takĹĽe.regularnie.opiekuje.siÄ..dzieckiem..np..ojciec..babcia..niania..wychowawczyni..)
# summary(realdata$Czy.dziecko.skĹ.ada.sĹ.owa.w.proste.zdania.)
# summary(realdata$Data.urodzenia.)
# summary(realdata$Data.przyjazdu.do.kraju.zamieszkania.)
# class(realdata$Data.przyjazdu.do.kraju.zamieszkania.)
# 
# 
# summary(realdata$Kto.jest.gĹ.Ăłwnym.opiekunem.dziecka.)
# 

